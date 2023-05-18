Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B57079A9
	for <lists+linux-block@lfdr.de>; Thu, 18 May 2023 07:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjERFbQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 May 2023 01:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjERFbP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 01:31:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F27106
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 22:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JitTMffZuPpBfmAZayAM1tS/ovDZo71GYsccLHTCVqY=; b=yHJ/5ZeueMPmKBdvJtLlI93+BA
        Ed+x/JUVC3Y7hpgjJiiNbazHwxITPnwCXFjQuayUcSnQjxHQLu+5wikNx3PIKChvZGyPN0HYLuQt8
        OMVw6YQPBdTv7TRuC7mB1IsA6QTv0bnfEbmvp120QdI1dSoij+g78gWbEwHRl7uyXRbqFXkAwAYcr
        3xcYTkpqAv02vfAIjuyIgcY0399P1MOclvOZh1eNTDMQJaQb42Zb8aXhlJOLiOkREL2Ifs50/bU4H
        lx/nCXk02eY4AMj9UaZQyV6vxlKIHTIUSNPMxvBPswQtGbPxbfsc4u/PsRK4sGR9q7txWt9MIXfRk
        8OUuOoAQ==;
Received: from [2001:4bb8:188:3dd5:c90:b13:29fb:f2b9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzWEK-00Bwdy-0N;
        Thu, 18 May 2023 05:31:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/3] blk-mq: make sure elevator callbacks aren't called for passthrough request
Date:   Thu, 18 May 2023 07:31:01 +0200
Message-Id: <20230518053101.760632-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518053101.760632-1-hch@lst.de>
References: <20230518053101.760632-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of q->elevator, passthrought request can still be marked as
RQF_ELV, so some elevator callbacks will be called for them.

Fix this by splitting RQF_SCHED_TAGS, which is set for all requests that
are issued on a queue that uses an I/O scheduler, and RQF_USE_SCHED for
non-flush, non-passthrough requests on such a queue.

Roughly based on two different patches from
Ming Lei <ming.lei@redhat.com>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-debugfs.c |  3 ++-
 block/blk-mq-sched.h   |  6 ++---
 block/blk-mq.c         | 53 +++++++++++++++++++++++-------------------
 block/blk-mq.h         |  6 ++---
 include/linux/blk-mq.h | 12 ++++++----
 5 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 588b7048342bee..1178d8696dcc05 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -246,6 +246,8 @@ static const char *const rqf_name[] = {
 	RQF_NAME(MIXED_MERGE),
 	RQF_NAME(MQ_INFLIGHT),
 	RQF_NAME(DONTPREP),
+	RQF_NAME(SCHED_TAGS),
+	RQF_NAME(USE_SCHED),
 	RQF_NAME(FAILED),
 	RQF_NAME(QUIET),
 	RQF_NAME(IO_STAT),
@@ -255,7 +257,6 @@ static const char *const rqf_name[] = {
 	RQF_NAME(SPECIAL_PAYLOAD),
 	RQF_NAME(ZONE_WRITE_LOCKED),
 	RQF_NAME(TIMED_OUT),
-	RQF_NAME(ELV),
 	RQF_NAME(RESV),
 };
 #undef RQF_NAME
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 4d8d2cd3b47396..1326526bb7338c 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -37,7 +37,7 @@ static inline bool
 blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
 			 struct bio *bio)
 {
-	if (rq->rq_flags & RQF_ELV) {
+	if (rq->rq_flags & RQF_USE_SCHED) {
 		struct elevator_queue *e = q->elevator;
 
 		if (e->type->ops.allow_merge)
@@ -48,7 +48,7 @@ blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
 
 static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
 {
-	if (rq->rq_flags & RQF_ELV) {
+	if (rq->rq_flags & RQF_USE_SCHED) {
 		struct elevator_queue *e = rq->q->elevator;
 
 		if (e->type->ops.completed_request)
@@ -58,7 +58,7 @@ static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
 
 static inline void blk_mq_sched_requeue_request(struct request *rq)
 {
-	if ((rq->rq_flags & RQF_ELV) && !op_is_flush(rq->cmd_flags)) {
+	if (rq->rq_flags & RQF_USE_SCHED) {
 		struct request_queue *q = rq->q;
 		struct elevator_queue *e = q->elevator;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7470c6636dc4f7..e021740154feae 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -354,12 +354,12 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		data->rq_flags |= RQF_IO_STAT;
 	rq->rq_flags = data->rq_flags;
 
-	if (!(data->rq_flags & RQF_ELV)) {
-		rq->tag = tag;
-		rq->internal_tag = BLK_MQ_NO_TAG;
-	} else {
+	if (data->rq_flags & RQF_SCHED_TAGS) {
 		rq->tag = BLK_MQ_NO_TAG;
 		rq->internal_tag = tag;
+	} else {
+		rq->tag = tag;
+		rq->internal_tag = BLK_MQ_NO_TAG;
 	}
 	rq->timeout = 0;
 
@@ -386,14 +386,13 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	WRITE_ONCE(rq->deadline, 0);
 	req_ref_set(rq, 1);
 
-	if (rq->rq_flags & RQF_ELV) {
+	if (rq->rq_flags & RQF_USE_SCHED) {
 		struct elevator_queue *e = data->q->elevator;
 
 		INIT_HLIST_NODE(&rq->hash);
 		RB_CLEAR_NODE(&rq->rb_node);
 
-		if (!op_is_flush(data->cmd_flags) &&
-		    e->type->ops.prepare_request)
+		if (e->type->ops.prepare_request)
 			e->type->ops.prepare_request(rq);
 	}
 
@@ -447,26 +446,32 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
 
 	if (q->elevator) {
-		struct elevator_queue *e = q->elevator;
-
-		data->rq_flags |= RQF_ELV;
+		/*
+		 * All requests use scheduler tags when an I/O scheduler is
+		 * enabled for the queue.
+		 */
+		data->rq_flags |= RQF_SCHED_TAGS;
 
 		/*
 		 * Flush/passthrough requests are special and go directly to the
-		 * dispatch list. Don't include reserved tags in the
-		 * limiting, as it isn't useful.
+		 * dispatch list.
 		 */
 		if (!op_is_flush(data->cmd_flags) &&
-		    !blk_op_is_passthrough(data->cmd_flags) &&
-		    e->type->ops.limit_depth &&
-		    !(data->flags & BLK_MQ_REQ_RESERVED))
-			e->type->ops.limit_depth(data->cmd_flags, data);
+		    !blk_op_is_passthrough(data->cmd_flags)) {
+			struct elevator_mq_ops *ops = &q->elevator->type->ops;
+
+			WARN_ON_ONCE(data->flags & BLK_MQ_REQ_RESERVED);
+
+			data->rq_flags |= RQF_USE_SCHED;
+			if (ops->limit_depth)
+				ops->limit_depth(data->cmd_flags, data);
+		}
 	}
 
 retry:
 	data->ctx = blk_mq_get_ctx(q);
 	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
-	if (!(data->rq_flags & RQF_ELV))
+	if (!(data->rq_flags & RQF_SCHED_TAGS))
 		blk_mq_tag_busy(data->hctx);
 
 	if (data->flags & BLK_MQ_REQ_RESERVED)
@@ -646,10 +651,10 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		goto out_queue_exit;
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
-	if (!q->elevator)
-		blk_mq_tag_busy(data.hctx);
+	if (q->elevator)
+		data.rq_flags |= RQF_SCHED_TAGS;
 	else
-		data.rq_flags |= RQF_ELV;
+		blk_mq_tag_busy(data.hctx);
 
 	if (flags & BLK_MQ_REQ_RESERVED)
 		data.rq_flags |= RQF_RESV;
@@ -694,7 +699,7 @@ void blk_mq_free_request(struct request *rq)
 	struct request_queue *q = rq->q;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
-	if ((rq->rq_flags & RQF_ELV) && !op_is_flush(rq->cmd_flags) &&
+	if ((rq->rq_flags & RQF_USE_SCHED) &&
 	    q->elevator->type->ops.finish_request)
 		q->elevator->type->ops.finish_request(rq);
 
@@ -1268,7 +1273,7 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 
 	if (!plug->multiple_queues && last && last->q != rq->q)
 		plug->multiple_queues = true;
-	if (!plug->has_elevator && (rq->rq_flags & RQF_ELV))
+	if (!plug->has_elevator && (rq->rq_flags & RQF_USE_SCHED))
 		plug->has_elevator = true;
 	rq->rq_next = NULL;
 	rq_list_add(&plug->mq_list, rq);
@@ -2620,7 +2625,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		return;
 	}
 
-	if ((rq->rq_flags & RQF_ELV) || !blk_mq_get_budget_and_tag(rq)) {
+	if ((rq->rq_flags & RQF_USE_SCHED) || !blk_mq_get_budget_and_tag(rq)) {
 		blk_mq_insert_request(rq, 0);
 		blk_mq_run_hw_queue(hctx, false);
 		return;
@@ -2983,7 +2988,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	}
 
 	hctx = rq->mq_hctx;
-	if ((rq->rq_flags & RQF_ELV) ||
+	if ((rq->rq_flags & RQF_USE_SCHED) ||
 	    (hctx->dispatch_busy && (q->nr_hw_queues == 1 || !is_sync))) {
 		blk_mq_insert_request(rq, 0);
 		blk_mq_run_hw_queue(hctx, true);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e876584d351634..d15981db34b958 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -226,9 +226,9 @@ static inline bool blk_mq_is_shared_tags(unsigned int flags)
 
 static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
 {
-	if (!(data->rq_flags & RQF_ELV))
-		return data->hctx->tags;
-	return data->hctx->sched_tags;
+	if (data->rq_flags & RQF_SCHED_TAGS)
+		return data->hctx->sched_tags;
+	return data->hctx->tags;
 }
 
 static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 5529e7d28ae6bb..888b79633692fc 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -38,6 +38,10 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_MQ_INFLIGHT		((__force req_flags_t)(1 << 6))
 /* don't call prep for this one */
 #define RQF_DONTPREP		((__force req_flags_t)(1 << 7))
+/* use hctx->sched_tags */
+#define RQF_SCHED_TAGS		((__force req_flags_t)(1 << 8))
+/* use and I/O scheduler for this request */
+#define RQF_USE_SCHED		((__force req_flags_t)(1 << 9))
 /* vaguely specified driver internal error.  Ignored by the block layer */
 #define RQF_FAILED		((__force req_flags_t)(1 << 10))
 /* don't warn about errors */
@@ -57,9 +61,7 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_ZONE_WRITE_LOCKED	((__force req_flags_t)(1 << 19))
 /* ->timeout has been called, don't expire again */
 #define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
-/* queue has elevator attached */
-#define RQF_ELV			((__force req_flags_t)(1 << 22))
-#define RQF_RESV			((__force req_flags_t)(1 << 23))
+#define RQF_RESV		((__force req_flags_t)(1 << 23))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
@@ -842,7 +844,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *ib);
  */
 static inline bool blk_mq_need_time_stamp(struct request *rq)
 {
-	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_ELV));
+	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_USE_SCHED));
 }
 
 static inline bool blk_mq_is_reserved_rq(struct request *rq)
@@ -858,7 +860,7 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 				       struct io_comp_batch *iob, int ioerror,
 				       void (*complete)(struct io_comp_batch *))
 {
-	if (!iob || (req->rq_flags & RQF_ELV) || ioerror ||
+	if (!iob || (req->rq_flags & RQF_USE_SCHED) || ioerror ||
 			(req->end_io && !blk_rq_is_passthrough(req)))
 		return false;
 
-- 
2.39.2

