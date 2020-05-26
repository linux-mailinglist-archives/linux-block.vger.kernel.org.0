Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B651B71EC
	for <lists+linux-block@lfdr.de>; Fri, 24 Apr 2020 12:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgDXKY4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Apr 2020 06:24:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24158 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726824AbgDXKYz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 06:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587723894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tgTVGaar7mDh7Ex8NTvgT9QptDQ+6Yl+cUAsrDi9uIU=;
        b=UO7dP8QC4q3GNw0Xm+SbAVvVxFdyuGCAqLkEFdBCSj0aCt19Ofa14vQrZZ2PxfTZsY6u7W
        7dPvc3QZA4B0JBDUbVXK3N3OdekgOP6Pzm2XP2nUkoZ1ortzv+cWjdDZtegEJ0CPPP776E
        CGnNxKY4+9fXuY2jsR6IbK6RV3YiQHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-vfSgjUyZMJK_xVXlKNE05Q-1; Fri, 24 Apr 2020 06:24:52 -0400
X-MC-Unique: vfSgjUyZMJK_xVXlKNE05Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FAC6800580;
        Fri, 24 Apr 2020 10:24:51 +0000 (UTC)
Received: from localhost (ovpn-8-38.pek2.redhat.com [10.72.8.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 821A25D715;
        Fri, 24 Apr 2020 10:24:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before hctx becomes inactive
Date:   Fri, 24 Apr 2020 18:23:47 +0800
Message-Id: <20200424102351.475641-8-ming.lei@redhat.com>
In-Reply-To: <20200424102351.475641-1-ming.lei@redhat.com>
References: <20200424102351.475641-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before one CPU becomes offline, check if it is the last online CPU of hct=
x.
If yes, mark this hctx as inactive, meantime wait for completion of all
in-flight IOs originated from this hctx. Meantime check if this hctx has
become inactive in blk_mq_get_driver_tag(), if yes, release the
allocated tag.

This way guarantees that there isn't any inflight IO before shutdowning
the managed IRQ line when all CPUs of this IRQ line is offline.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c |   1 +
 block/blk-mq.c         | 124 +++++++++++++++++++++++++++++++++++++----
 include/linux/blk-mq.h |   3 +
 3 files changed, 117 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 8e745826eb86..b62390918ca5 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -213,6 +213,7 @@ static const char *const hctx_state_name[] =3D {
 	HCTX_STATE_NAME(STOPPED),
 	HCTX_STATE_NAME(TAG_ACTIVE),
 	HCTX_STATE_NAME(SCHED_RESTART),
+	HCTX_STATE_NAME(INACTIVE),
 };
 #undef HCTX_STATE_NAME
=20
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d432cc74ef78..4d0c271d9f6f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1050,11 +1050,31 @@ static bool __blk_mq_get_driver_tag(struct reques=
t *rq)
 	return true;
 }
=20
-static bool blk_mq_get_driver_tag(struct request *rq)
+static bool blk_mq_get_driver_tag(struct request *rq, bool direct_issue)
 {
 	if (rq->tag !=3D -1)
 		return true;
-	return __blk_mq_get_driver_tag(rq);
+
+	if (!__blk_mq_get_driver_tag(rq))
+		return false;
+	/*
+	 * Add one memory barrier in case that direct issue IO process is
+	 * migrated to other CPU which may not belong to this hctx, so we can
+	 * order driver tag assignment and checking BLK_MQ_S_INACTIVE.
+	 * Otherwise, barrier() is enough given both setting BLK_MQ_S_INACTIVE
+	 * and driver tag assignment are run on the same CPU in case that
+	 * BLK_MQ_S_INACTIVE is set.
+	 */
+	if (unlikely(direct_issue && rq->mq_ctx->cpu !=3D raw_smp_processor_id(=
)))
+		smp_mb();
+	else
+		barrier();
+
+	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state))) {
+		blk_mq_put_driver_tag(rq);
+		return false;
+	}
+	return true;
 }
=20
 static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
@@ -1103,7 +1123,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_c=
tx *hctx,
 		 * Don't clear RESTART here, someone else could have set it.
 		 * At most this will cost an extra queue run.
 		 */
-		return blk_mq_get_driver_tag(rq);
+		return blk_mq_get_driver_tag(rq, false);
 	}
=20
 	wait =3D &hctx->dispatch_wait;
@@ -1129,7 +1149,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_c=
tx *hctx,
 	 * allocation failure and adding the hardware queue to the wait
 	 * queue.
 	 */
-	ret =3D blk_mq_get_driver_tag(rq);
+	ret =3D blk_mq_get_driver_tag(rq, false);
 	if (!ret) {
 		spin_unlock(&hctx->dispatch_wait_lock);
 		spin_unlock_irq(&wq->lock);
@@ -1228,7 +1248,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *=
q, struct list_head *list,
 			break;
 		}
=20
-		if (!blk_mq_get_driver_tag(rq)) {
+		if (!blk_mq_get_driver_tag(rq, false)) {
 			/*
 			 * The initial allocation attempt failed, so we need to
 			 * rerun the hardware queue when a tag is freed. The
@@ -1260,7 +1280,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *=
q, struct list_head *list,
 			bd.last =3D true;
 		else {
 			nxt =3D list_first_entry(list, struct request, queuelist);
-			bd.last =3D !blk_mq_get_driver_tag(nxt);
+			bd.last =3D !blk_mq_get_driver_tag(nxt, false);
 		}
=20
 		ret =3D q->mq_ops->queue_rq(hctx, &bd);
@@ -1853,7 +1873,7 @@ static blk_status_t __blk_mq_try_issue_directly(str=
uct blk_mq_hw_ctx *hctx,
 	if (!blk_mq_get_dispatch_budget(hctx))
 		goto insert;
=20
-	if (!blk_mq_get_driver_tag(rq)) {
+	if (!blk_mq_get_driver_tag(rq, true)) {
 		blk_mq_put_dispatch_budget(hctx);
 		goto insert;
 	}
@@ -2261,13 +2281,92 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, =
struct blk_mq_tags *tags,
 	return -ENOMEM;
 }
=20
-static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node=
 *node)
+struct count_inflight_data {
+	unsigned count;
+	struct blk_mq_hw_ctx *hctx;
+};
+
+static bool blk_mq_count_inflight_rq(struct request *rq, void *data,
+				     bool reserved)
 {
-	return 0;
+	struct count_inflight_data *count_data =3D data;
+
+	/*
+	 * Can't check rq's state because it is updated to MQ_RQ_IN_FLIGHT
+	 * in blk_mq_start_request(), at that time we can't prevent this rq
+	 * from being issued.
+	 *
+	 * So check if driver tag is assigned, if yes, count this rq as
+	 * inflight.
+	 */
+	if (rq->tag >=3D 0 && rq->mq_hctx =3D=3D count_data->hctx)
+		count_data->count++;
+
+	return true;
+}
+
+static bool blk_mq_inflight_rq(struct request *rq, void *data,
+			       bool reserved)
+{
+	return rq->tag >=3D 0;
+}
+
+static unsigned blk_mq_tags_inflight_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	struct count_inflight_data count_data =3D {
+		.count	=3D 0,
+		.hctx	=3D hctx,
+	};
+
+	blk_mq_all_tag_busy_iter(hctx->tags, blk_mq_count_inflight_rq,
+			blk_mq_inflight_rq, &count_data);
+
+	return count_data.count;
+}
+
+static void blk_mq_hctx_drain_inflight_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	while (1) {
+		if (!blk_mq_tags_inflight_rqs(hctx))
+			break;
+		msleep(5);
+	}
 }
=20
 static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_nod=
e *node)
 {
+	struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_online);
+
+	if (!cpumask_test_cpu(cpu, hctx->cpumask))
+		return 0;
+
+	if ((cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) !=3D cpu) ||
+	    (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids=
))
+		return 0;
+
+	/*
+	 * The current CPU is the last one in this hctx, S_INACTIVE
+	 * can be observed in dispatch path without any barrier needed,
+	 * cause both are run on one same CPU.
+	 */
+	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
+	/*
+	 * Order setting BLK_MQ_S_INACTIVE and checking rq->tag & rqs[tag],
+	 * and its pair is the smp_mb() in blk_mq_get_driver_tag
+	 */
+	smp_mb__after_atomic();
+	blk_mq_hctx_drain_inflight_rqs(hctx);
+	return 0;
+}
+
+static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node=
 *node)
+{
+	struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_online);
+
+	if (cpumask_test_cpu(cpu, hctx->cpumask))
+		clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
 	return 0;
 }
=20
@@ -2278,12 +2377,15 @@ static int blk_mq_hctx_notify_offline(unsigned in=
t cpu, struct hlist_node *node)
  */
 static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *=
node)
 {
-	struct blk_mq_hw_ctx *hctx;
+	struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_dead);
 	struct blk_mq_ctx *ctx;
 	LIST_HEAD(tmp);
 	enum hctx_type type;
=20
-	hctx =3D hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
+	if (!cpumask_test_cpu(cpu, hctx->cpumask))
+		return 0;
+
 	ctx =3D __blk_mq_get_ctx(hctx->queue, cpu);
 	type =3D hctx->type;
=20
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f550b5274b8b..b4812c455807 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -403,6 +403,9 @@ enum {
 	BLK_MQ_S_TAG_ACTIVE	=3D 1,
 	BLK_MQ_S_SCHED_RESTART	=3D 2,
=20
+	/* hw queue is inactive after all its CPUs become offline */
+	BLK_MQ_S_INACTIVE	=3D 3,
+
 	BLK_MQ_MAX_DEPTH	=3D 10240,
=20
 	BLK_MQ_CPU_WORK_BATCH	=3D 8,
--=20
2.25.2

