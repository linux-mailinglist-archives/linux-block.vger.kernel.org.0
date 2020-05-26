Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34DD1D059D
	for <lists+linux-block@lfdr.de>; Wed, 13 May 2020 05:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgEMDsy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 May 2020 23:48:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32763 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727107AbgEMDsy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 23:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589341731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xv5DqVnejg416O03SiKWNsVe+d+9iJXyGmze0RRSMnQ=;
        b=hXOa8vVF8c+TaR9n4UhCPZ76Dd3khpFLjaYPhE1uWtY0nNo2srRawPfpGqWtYUEnRty1pR
        M8m7tt9DJNxqicpMJEpwQGHCVupfuerbUZsJVA+P5JobWTfi8LEqeZ46W61LKaUDE5U1Uz
        sA5Igwv4rMPi0neXqzW55RmHzXsKnsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-xstxSs7APAq0kren1P2r9A-1; Tue, 12 May 2020 23:48:49 -0400
X-MC-Unique: xstxSs7APAq0kren1P2r9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A3E61005510;
        Wed, 13 May 2020 03:48:48 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C91CF10013D9;
        Wed, 13 May 2020 03:48:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V11 04/12] blk-mq: assign rq->tag in blk_mq_get_driver_tag
Date:   Wed, 13 May 2020 11:47:55 +0800
Message-Id: <20200513034803.1844579-5-ming.lei@redhat.com>
In-Reply-To: <20200513034803.1844579-1-ming.lei@redhat.com>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Especially for none elevator, rq->tag is assigned after the request is
allocated, so there isn't any way to figure out if one request is in
being dispatched. Also the code path wrt. driver tag becomes a bit
difference between none and io scheduler.

When one hctx becomes inactive, we have to prevent any request from
being dispatched to LLD. And get driver tag provides one perfect chance
to do that. Meantime we can drain any such requests by checking if
rq->tag is assigned.

So only assign rq->tag until blk_mq_get_driver_tag() is called.

This way also simplifies code of dealing with driver tag a lot.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Garry <john.garry@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c | 18 ++----------
 block/blk-mq.c    | 75 ++++++++++++++++++++++++-----------------------
 block/blk-mq.h    | 21 +++++++------
 block/blk.h       |  5 ----
 4 files changed, 51 insertions(+), 68 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index c7f396e3d5e2..977edf95d711 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -236,13 +236,8 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 		error = fq->rq_status;
 
 	hctx = flush_rq->mq_hctx;
-	if (!q->elevator) {
-		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
-		flush_rq->tag = -1;
-	} else {
-		blk_mq_put_driver_tag(flush_rq);
-		flush_rq->internal_tag = -1;
-	}
+	flush_rq->internal_tag = -1;
+	blk_mq_put_driver_tag(flush_rq);
 
 	running = &fq->flush_queue[fq->flush_running_idx];
 	BUG_ON(fq->flush_pending_idx == fq->flush_running_idx);
@@ -317,14 +312,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	flush_rq->mq_ctx = first_rq->mq_ctx;
 	flush_rq->mq_hctx = first_rq->mq_hctx;
 
-	if (!q->elevator) {
-		fq->orig_rq = first_rq;
-		flush_rq->tag = first_rq->tag;
-		blk_mq_tag_set_rq(flush_rq->mq_hctx, first_rq->tag, flush_rq);
-	} else {
-		flush_rq->internal_tag = first_rq->internal_tag;
-	}
-
+	flush_rq->internal_tag = first_rq->internal_tag;
 	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
 	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
 	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 53c6e7678c14..80d25e1d792a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -276,18 +276,8 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	struct request *rq = tags->static_rqs[tag];
 	req_flags_t rq_flags = 0;
 
-	if (data->flags & BLK_MQ_REQ_INTERNAL) {
-		rq->tag = -1;
-		rq->internal_tag = tag;
-	} else {
-		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
-			rq_flags = RQF_MQ_INFLIGHT;
-			atomic_inc(&data->hctx->nr_active);
-		}
-		rq->tag = tag;
-		rq->internal_tag = -1;
-		data->hctx->tags->rqs[rq->tag] = rq;
-	}
+	rq->internal_tag = tag;
+	rq->tag = -1;
 
 	/* csd/requeue_work/fifo_time is initialized before use */
 	rq->q = data->q;
@@ -471,14 +461,18 @@ static void __blk_mq_free_request(struct request *rq)
 	struct request_queue *q = rq->q;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
-	const int sched_tag = rq->internal_tag;
 
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
-	if (rq->tag != -1)
-		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
-	if (sched_tag != -1)
-		blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
+
+	if (hctx->sched_tags) {
+		if (rq->tag >= 0)
+			blk_mq_put_tag(hctx->tags, ctx, rq->tag);
+		blk_mq_put_tag(hctx->sched_tags, ctx, rq->internal_tag);
+	} else {
+		blk_mq_put_tag(hctx->tags, ctx, rq->internal_tag);
+        }
+
 	blk_mq_sched_restart(hctx);
 	blk_queue_exit(q);
 }
@@ -526,7 +520,7 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 		blk_stat_add(rq, now);
 	}
 
-	if (rq->internal_tag != -1)
+	if (rq->q->elevator && rq->internal_tag != -1)
 		blk_mq_sched_completed_request(rq, now);
 
 	blk_account_io_done(rq, now);
@@ -1015,33 +1009,40 @@ static inline unsigned int queued_to_index(unsigned int queued)
 	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
 }
 
-static bool blk_mq_get_driver_tag(struct request *rq)
+static bool __blk_mq_get_driver_tag(struct request *rq)
 {
 	struct blk_mq_alloc_data data = {
-		.q = rq->q,
-		.hctx = rq->mq_hctx,
-		.flags = BLK_MQ_REQ_NOWAIT,
-		.cmd_flags = rq->cmd_flags,
+		.q		= rq->q,
+		.hctx		= rq->mq_hctx,
+		.flags		= BLK_MQ_REQ_NOWAIT,
+		.cmd_flags	= rq->cmd_flags,
 	};
-	bool shared;
 
-	if (rq->tag != -1)
-		return true;
+	if (data.hctx->sched_tags) {
+		if (blk_mq_tag_is_reserved(data.hctx->sched_tags,
+				rq->internal_tag))
+			data.flags |= BLK_MQ_REQ_RESERVED;
+		rq->tag = blk_mq_get_tag(&data);
+	} else {
+		rq->tag = rq->internal_tag;
+	}
 
-	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
-		data.flags |= BLK_MQ_REQ_RESERVED;
+	if (rq->tag == -1)
+		return false;
 
-	shared = blk_mq_tag_busy(data.hctx);
-	rq->tag = blk_mq_get_tag(&data);
-	if (rq->tag >= 0) {
-		if (shared) {
-			rq->rq_flags |= RQF_MQ_INFLIGHT;
-			atomic_inc(&data.hctx->nr_active);
-		}
-		data.hctx->tags->rqs[rq->tag] = rq;
+	if (blk_mq_tag_busy(data.hctx)) {
+		rq->rq_flags |= RQF_MQ_INFLIGHT;
+		atomic_inc(&data.hctx->nr_active);
 	}
+	data.hctx->tags->rqs[rq->tag] = rq;
+	return true;
+}
 
-	return rq->tag != -1;
+static bool blk_mq_get_driver_tag(struct request *rq)
+{
+	if (rq->tag != -1)
+		return true;
+	return __blk_mq_get_driver_tag(rq);
 }
 
 static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e7d1da4b1f73..d0c72d7d07c8 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -196,26 +196,25 @@ static inline bool blk_mq_get_dispatch_budget(struct blk_mq_hw_ctx *hctx)
 	return true;
 }
 
-static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
-					   struct request *rq)
+static inline void blk_mq_put_driver_tag(struct request *rq)
 {
-	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+	int tag = rq->tag;
+
+	if (tag < 0)
+		return;
+
 	rq->tag = -1;
 
+	if (hctx->sched_tags)
+		blk_mq_put_tag(hctx->tags, rq->mq_ctx, tag);
+
 	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
 		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
 		atomic_dec(&hctx->nr_active);
 	}
 }
 
-static inline void blk_mq_put_driver_tag(struct request *rq)
-{
-	if (rq->tag == -1 || rq->internal_tag == -1)
-		return;
-
-	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
-}
-
 static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 {
 	int cpu;
diff --git a/block/blk.h b/block/blk.h
index faf616cb0463..002104739465 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -26,11 +26,6 @@ struct blk_flush_queue {
 	struct list_head	flush_data_in_flight;
 	struct request		*flush_rq;
 
-	/*
-	 * flush_rq shares tag with this rq, both can't be active
-	 * at the same time
-	 */
-	struct request		*orig_rq;
 	struct lock_class_key	key;
 	spinlock_t		mq_flush_lock;
 };
-- 
2.25.2

