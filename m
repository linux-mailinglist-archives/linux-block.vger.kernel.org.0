Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92BA36803B
	for <lists+linux-block@lfdr.de>; Thu, 22 Apr 2021 14:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbhDVMWv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 22 Apr 2021 08:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236183AbhDVMWt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 08:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619094134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wBRiPuY6I22372ChkUssaZmh1WEQKQC5uGMgC5a9KW0=;
        b=G6sbGnEpxQrQGrzghZ+ets6wsN7IxEyCO9UAZy3u0yduRRxiNHOtU3TU3QeqJQMTPrB4ZG
        DVJaOL1cKbnG+BbMh6g3B3p35oXzyjBMzlot3dLFYkDUdUJg8nY0n9VtKlEg3qn2J7HBUU
        cezwHmvKmqB3C/EU4H0KZ9AFqrY02cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-8t9GJVHONjm-yZsKuldr5g-1; Thu, 22 Apr 2021 08:21:35 -0400
X-MC-Unique: 8t9GJVHONjm-yZsKuldr5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DC4A107ACE3;
        Thu, 22 Apr 2021 12:21:34 +0000 (UTC)
Received: from localhost (ovpn-13-243.pek2.redhat.com [10.72.13.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3AD45C1D5;
        Thu, 22 Apr 2021 12:21:25 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V6 04/12] block: move block polling code into one dedicated source file
Date:   Thu, 22 Apr 2021 20:20:30 +0800
Message-Id: <20210422122038.2192933-5-ming.lei@redhat.com>
In-Reply-To: <20210422122038.2192933-1-ming.lei@redhat.com>
References: <20210422122038.2192933-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for supporting bio based io polling, and move blk polling
code into one dedicated source file. And three shared functions are
put into private header of blk-mq.h

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/Makefile   |   3 +-
 block/blk-mq.c   | 230 -----------------------------------------------
 block/blk-mq.h   |  40 +++++++++
 block/blk-poll.c | 196 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 238 insertions(+), 231 deletions(-)
 create mode 100644 block/blk-poll.c

diff --git a/block/Makefile b/block/Makefile
index 8d841f5f986f..d7abe2333407 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -8,7 +8,8 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-exec.o blk-merge.o blk-timeout.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
-			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o
+			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
+			blk-poll.o
 
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_ioctl.o
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 47e650bb836b..f9162295f4f2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -43,26 +43,6 @@
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 
-static void blk_mq_poll_stats_start(struct request_queue *q);
-static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
-
-static int blk_mq_poll_stats_bkt(const struct request *rq)
-{
-	int ddir, sectors, bucket;
-
-	ddir = rq_data_dir(rq);
-	sectors = blk_rq_stats_sectors(rq);
-
-	bucket = ddir + 2 * ilog2(sectors);
-
-	if (bucket < 0)
-		return -1;
-	else if (bucket >= BLK_MQ_POLL_STATS_BKTS)
-		return ddir + BLK_MQ_POLL_STATS_BKTS - 2;
-
-	return bucket;
-}
-
 /*
  * Check if any of the ctx, dispatch list or elevator
  * have pending work in this hardware queue.
@@ -3726,216 +3706,6 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 
-/* Enable polling stats and return whether they were already enabled. */
-static bool blk_poll_stats_enable(struct request_queue *q)
-{
-	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags) ||
-	    blk_queue_flag_test_and_set(QUEUE_FLAG_POLL_STATS, q))
-		return true;
-	blk_stat_add_callback(q, q->poll_cb);
-	return false;
-}
-
-static void blk_mq_poll_stats_start(struct request_queue *q)
-{
-	/*
-	 * We don't arm the callback if polling stats are not enabled or the
-	 * callback is already active.
-	 */
-	if (!test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags) ||
-	    blk_stat_is_active(q->poll_cb))
-		return;
-
-	blk_stat_activate_msecs(q->poll_cb, 100);
-}
-
-static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb)
-{
-	struct request_queue *q = cb->data;
-	int bucket;
-
-	for (bucket = 0; bucket < BLK_MQ_POLL_STATS_BKTS; bucket++) {
-		if (cb->stat[bucket].nr_samples)
-			q->poll_stat[bucket] = cb->stat[bucket];
-	}
-}
-
-static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
-				       struct request *rq)
-{
-	unsigned long ret = 0;
-	int bucket;
-
-	/*
-	 * If stats collection isn't on, don't sleep but turn it on for
-	 * future users
-	 */
-	if (!blk_poll_stats_enable(q))
-		return 0;
-
-	/*
-	 * As an optimistic guess, use half of the mean service time
-	 * for this type of request. We can (and should) make this smarter.
-	 * For instance, if the completion latencies are tight, we can
-	 * get closer than just half the mean. This is especially
-	 * important on devices where the completion latencies are longer
-	 * than ~10 usec. We do use the stats for the relevant IO size
-	 * if available which does lead to better estimates.
-	 */
-	bucket = blk_mq_poll_stats_bkt(rq);
-	if (bucket < 0)
-		return ret;
-
-	if (q->poll_stat[bucket].nr_samples)
-		ret = (q->poll_stat[bucket].mean + 1) / 2;
-
-	return ret;
-}
-
-static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
-				     struct request *rq)
-{
-	struct hrtimer_sleeper hs;
-	enum hrtimer_mode mode;
-	unsigned int nsecs;
-	ktime_t kt;
-
-	if (rq->rq_flags & RQF_MQ_POLL_SLEPT)
-		return false;
-
-	/*
-	 * If we get here, hybrid polling is enabled. Hence poll_nsec can be:
-	 *
-	 *  0:	use half of prev avg
-	 * >0:	use this specific value
-	 */
-	if (q->poll_nsec > 0)
-		nsecs = q->poll_nsec;
-	else
-		nsecs = blk_mq_poll_nsecs(q, rq);
-
-	if (!nsecs)
-		return false;
-
-	rq->rq_flags |= RQF_MQ_POLL_SLEPT;
-
-	/*
-	 * This will be replaced with the stats tracking code, using
-	 * 'avg_completion_time / 2' as the pre-sleep target.
-	 */
-	kt = nsecs;
-
-	mode = HRTIMER_MODE_REL;
-	hrtimer_init_sleeper_on_stack(&hs, CLOCK_MONOTONIC, mode);
-	hrtimer_set_expires(&hs.timer, kt);
-
-	do {
-		if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
-			break;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		hrtimer_sleeper_start_expires(&hs, mode);
-		if (hs.task)
-			io_schedule();
-		hrtimer_cancel(&hs.timer);
-		mode = HRTIMER_MODE_ABS;
-	} while (hs.task && !signal_pending(current));
-
-	__set_current_state(TASK_RUNNING);
-	destroy_hrtimer_on_stack(&hs.timer);
-	return true;
-}
-
-static bool blk_mq_poll_hybrid(struct request_queue *q,
-			       struct blk_mq_hw_ctx *hctx, blk_qc_t cookie)
-{
-	struct request *rq;
-
-	if (q->poll_nsec == BLK_MQ_POLL_CLASSIC)
-		return false;
-
-	if (!blk_qc_t_is_internal(cookie))
-		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
-	else {
-		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
-		/*
-		 * With scheduling, if the request has completed, we'll
-		 * get a NULL return here, as we clear the sched tag when
-		 * that happens. The request still remains valid, like always,
-		 * so we should be safe with just the NULL check.
-		 */
-		if (!rq)
-			return false;
-	}
-
-	return blk_mq_poll_hybrid_sleep(q, rq);
-}
-
-/**
- * blk_poll - poll for IO completions
- * @q:  the queue
- * @cookie: cookie passed back at IO submission time
- * @spin: whether to spin for completions
- *
- * Description:
- *    Poll for completions on the passed in queue. Returns number of
- *    completed entries found. If @spin is true, then blk_poll will continue
- *    looping until at least one completion is found, unless the task is
- *    otherwise marked running (or we need to reschedule).
- */
-int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
-{
-	struct blk_mq_hw_ctx *hctx;
-	long state;
-
-	if (!blk_qc_t_valid(cookie) || !blk_queue_poll(q))
-		return 0;
-
-	if (current->plug)
-		blk_flush_plug_list(current->plug, false);
-
-	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
-
-	/*
-	 * If we sleep, have the caller restart the poll loop to reset
-	 * the state. Like for the other success return cases, the
-	 * caller is responsible for checking if the IO completed. If
-	 * the IO isn't complete, we'll get called again and will go
-	 * straight to the busy poll loop. If specified not to spin,
-	 * we also should not sleep.
-	 */
-	if (spin && blk_mq_poll_hybrid(q, hctx, cookie))
-		return 1;
-
-	hctx->poll_considered++;
-
-	state = current->state;
-	do {
-		int ret;
-
-		hctx->poll_invoked++;
-
-		ret = q->mq_ops->poll(hctx);
-		if (ret > 0) {
-			hctx->poll_success++;
-			__set_current_state(TASK_RUNNING);
-			return ret;
-		}
-
-		if (signal_pending_state(state, current))
-			__set_current_state(TASK_RUNNING);
-
-		if (current->state == TASK_RUNNING)
-			return 1;
-		if (ret < 0 || !spin)
-			break;
-		cpu_relax();
-	} while (!need_resched());
-
-	__set_current_state(TASK_RUNNING);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(blk_poll);
-
 unsigned int blk_mq_rq_cpu(struct request *rq)
 {
 	return rq->mq_ctx->cpu;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9ccb1818303b..2eea38cd8048 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -324,5 +324,45 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	return __blk_mq_active_requests(hctx) < depth;
 }
 
+static inline int blk_mq_poll_stats_bkt(const struct request *rq)
+{
+	int ddir, sectors, bucket;
+
+	ddir = rq_data_dir(rq);
+	sectors = blk_rq_stats_sectors(rq);
+
+	bucket = ddir + 2 * ilog2(sectors);
+
+	if (bucket < 0)
+		return -1;
+	else if (bucket >= BLK_MQ_POLL_STATS_BKTS)
+		return ddir + BLK_MQ_POLL_STATS_BKTS - 2;
+
+	return bucket;
+}
+
+static inline void blk_mq_poll_stats_start(struct request_queue *q)
+{
+	/*
+	 * We don't arm the callback if polling stats are not enabled or the
+	 * callback is already active.
+	 */
+	if (!test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags) ||
+	    blk_stat_is_active(q->poll_cb))
+		return;
+
+	blk_stat_activate_msecs(q->poll_cb, 100);
+}
+
+static inline void blk_mq_poll_stats_fn(struct blk_stat_callback *cb)
+{
+	struct request_queue *q = cb->data;
+	int bucket;
+
+	for (bucket = 0; bucket < BLK_MQ_POLL_STATS_BKTS; bucket++) {
+		if (cb->stat[bucket].nr_samples)
+			q->poll_stat[bucket] = cb->stat[bucket];
+	}
+}
 
 #endif
diff --git a/block/blk-poll.c b/block/blk-poll.c
new file mode 100644
index 000000000000..daa307f84792
--- /dev/null
+++ b/block/blk-poll.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/blkdev.h>
+#include <linux/sched.h>
+#include <linux/hrtimer.h>
+
+#include <linux/blk-mq.h>
+#include "blk.h"
+#include "blk-mq.h"
+
+/* Enable polling stats and return whether they were already enabled. */
+static bool blk_poll_stats_enable(struct request_queue *q)
+{
+	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags) ||
+	    blk_queue_flag_test_and_set(QUEUE_FLAG_POLL_STATS, q))
+		return true;
+	blk_stat_add_callback(q, q->poll_cb);
+	return false;
+}
+
+static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
+				       struct request *rq)
+{
+	unsigned long ret = 0;
+	int bucket;
+
+	/*
+	 * If stats collection isn't on, don't sleep but turn it on for
+	 * future users
+	 */
+	if (!blk_poll_stats_enable(q))
+		return 0;
+
+	/*
+	 * As an optimistic guess, use half of the mean service time
+	 * for this type of request. We can (and should) make this smarter.
+	 * For instance, if the completion latencies are tight, we can
+	 * get closer than just half the mean. This is especially
+	 * important on devices where the completion latencies are longer
+	 * than ~10 usec. We do use the stats for the relevant IO size
+	 * if available which does lead to better estimates.
+	 */
+	bucket = blk_mq_poll_stats_bkt(rq);
+	if (bucket < 0)
+		return ret;
+
+	if (q->poll_stat[bucket].nr_samples)
+		ret = (q->poll_stat[bucket].mean + 1) / 2;
+
+	return ret;
+}
+
+static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
+				     struct request *rq)
+{
+	struct hrtimer_sleeper hs;
+	enum hrtimer_mode mode;
+	unsigned int nsecs;
+	ktime_t kt;
+
+	if (rq->rq_flags & RQF_MQ_POLL_SLEPT)
+		return false;
+
+	/*
+	 * If we get here, hybrid polling is enabled. Hence poll_nsec can be:
+	 *
+	 *  0:	use half of prev avg
+	 * >0:	use this specific value
+	 */
+	if (q->poll_nsec > 0)
+		nsecs = q->poll_nsec;
+	else
+		nsecs = blk_mq_poll_nsecs(q, rq);
+
+	if (!nsecs)
+		return false;
+
+	rq->rq_flags |= RQF_MQ_POLL_SLEPT;
+
+	/*
+	 * This will be replaced with the stats tracking code, using
+	 * 'avg_completion_time / 2' as the pre-sleep target.
+	 */
+	kt = nsecs;
+
+	mode = HRTIMER_MODE_REL;
+	hrtimer_init_sleeper_on_stack(&hs, CLOCK_MONOTONIC, mode);
+	hrtimer_set_expires(&hs.timer, kt);
+
+	do {
+		if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
+			break;
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		hrtimer_sleeper_start_expires(&hs, mode);
+		if (hs.task)
+			io_schedule();
+		hrtimer_cancel(&hs.timer);
+		mode = HRTIMER_MODE_ABS;
+	} while (hs.task && !signal_pending(current));
+
+	__set_current_state(TASK_RUNNING);
+	destroy_hrtimer_on_stack(&hs.timer);
+	return true;
+}
+
+static bool blk_mq_poll_hybrid(struct request_queue *q,
+			       struct blk_mq_hw_ctx *hctx, blk_qc_t cookie)
+{
+	struct request *rq;
+
+	if (q->poll_nsec == BLK_MQ_POLL_CLASSIC)
+		return false;
+
+	if (!blk_qc_t_is_internal(cookie))
+		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
+	else {
+		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
+		/*
+		 * With scheduling, if the request has completed, we'll
+		 * get a NULL return here, as we clear the sched tag when
+		 * that happens. The request still remains valid, like always,
+		 * so we should be safe with just the NULL check.
+		 */
+		if (!rq)
+			return false;
+	}
+
+	return blk_mq_poll_hybrid_sleep(q, rq);
+}
+
+/**
+ * blk_poll - poll for IO completions
+ * @q:  the queue
+ * @cookie: cookie passed back at IO submission time
+ * @spin: whether to spin for completions
+ *
+ * Description:
+ *    Poll for completions on the passed in queue. Returns number of
+ *    completed entries found. If @spin is true, then blk_poll will continue
+ *    looping until at least one completion is found, unless the task is
+ *    otherwise marked running (or we need to reschedule).
+ */
+int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
+{
+	struct blk_mq_hw_ctx *hctx;
+	long state;
+
+	if (!blk_qc_t_valid(cookie) || !blk_queue_poll(q))
+		return 0;
+
+	if (current->plug)
+		blk_flush_plug_list(current->plug, false);
+
+	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
+
+	/*
+	 * If we sleep, have the caller restart the poll loop to reset
+	 * the state. Like for the other success return cases, the
+	 * caller is responsible for checking if the IO completed. If
+	 * the IO isn't complete, we'll get called again and will go
+	 * straight to the busy poll loop. If specified not to spin,
+	 * we also should not sleep.
+	 */
+	if (spin && blk_mq_poll_hybrid(q, hctx, cookie))
+		return 1;
+
+	hctx->poll_considered++;
+
+	state = current->state;
+	do {
+		int ret;
+
+		hctx->poll_invoked++;
+
+		ret = q->mq_ops->poll(hctx);
+		if (ret > 0) {
+			hctx->poll_success++;
+			__set_current_state(TASK_RUNNING);
+			return ret;
+		}
+
+		if (signal_pending_state(state, current))
+			__set_current_state(TASK_RUNNING);
+
+		if (current->state == TASK_RUNNING)
+			return 1;
+		if (ret < 0 || !spin)
+			break;
+		cpu_relax();
+	} while (!need_resched());
+
+	__set_current_state(TASK_RUNNING);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(blk_poll);
-- 
2.29.2

