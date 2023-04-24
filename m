Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754BA6DDC29
	for <lists+linux-block@lfdr.de>; Tue, 11 Apr 2023 15:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjDKNdz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Apr 2023 09:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDKNdy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 09:33:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D4D422E
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=s5F2oNGmpi87bjvHbS0/01Mrh1EXuBXXsYa3/loTzRs=; b=bdaOlDEQRd5+lBqBR3iRqT5Kft
        PtcrK/LnsZ7tPd9DtQoXHpWQIFqcyjH1edKqDuddc+JtEdfhaGFZhYrxhjizujjWR6opS+H8HJveX
        AHMdpXdO8Z3/iMyMIT+EVsVJ764RN76CAn5N9T/q9WhRl4ehC8yW7fQgkRUUHyzKDK5vaxdM3drHc
        IYCq4fzc0PI9pwfpt8IcDOkV/lFNV3yNCGXqM+AyY0nXrLYmkRD/OIHsloG6RRfmd+dH9wjimAh7u
        l0IQJx57wpw/bokapvxop0rPaDI2Dpuq9LkdH1tdfTLrRnREhLSTQ+lSd0oH0/66KMiShd3jGPKyy
        zn8H/q7w==;
Received: from [2001:4bb8:192:2d6c:a9b7:88a0:9fdd:81ca] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmE87-0007sc-2G;
        Tue, 11 Apr 2023 13:33:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 04/16] blk-mq: move blk_mq_sched_insert_request to blk-mq.c
Date:   Tue, 11 Apr 2023 15:33:17 +0200
Message-Id: <20230411133329.554624-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411133329.554624-1-hch@lst.de>
References: <20230411133329.554624-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_sched_insert_request is the main request insert helper and not
directly I/O scheduler related.  Move blk_mq_sched_insert_request to
blk-mq.c, rename it to blk_mq_insert_request and mark it static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-sched.c | 73 -------------------------------------
 block/blk-mq-sched.h |  3 --
 block/blk-mq.c       | 87 +++++++++++++++++++++++++++++++++++++++++---
 block/mq-deadline.c  |  2 +-
 4 files changed, 82 insertions(+), 83 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 2fa8e7cb4866aa..b12dbccc031184 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -384,79 +384,6 @@ bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
 
-static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
-				       struct request *rq)
-{
-	/*
-	 * dispatch flush and passthrough rq directly
-	 *
-	 * passthrough request has to be added to hctx->dispatch directly.
-	 * For some reason, device may be in one situation which can't
-	 * handle FS request, so STS_RESOURCE is always returned and the
-	 * FS request will be added to hctx->dispatch. However passthrough
-	 * request may be required at that time for fixing the problem. If
-	 * passthrough request is added to scheduler queue, there isn't any
-	 * chance to dispatch it given we prioritize requests in hctx->dispatch.
-	 */
-	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
-		return true;
-
-	return false;
-}
-
-void blk_mq_sched_insert_request(struct request *rq, bool at_head,
-				 bool run_queue, bool async)
-{
-	struct request_queue *q = rq->q;
-	struct elevator_queue *e = q->elevator;
-	struct blk_mq_ctx *ctx = rq->mq_ctx;
-	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
-
-	WARN_ON(e && (rq->tag != BLK_MQ_NO_TAG));
-
-	if (blk_mq_sched_bypass_insert(hctx, rq)) {
-		/*
-		 * Firstly normal IO request is inserted to scheduler queue or
-		 * sw queue, meantime we add flush request to dispatch queue(
-		 * hctx->dispatch) directly and there is at most one in-flight
-		 * flush request for each hw queue, so it doesn't matter to add
-		 * flush request to tail or front of the dispatch queue.
-		 *
-		 * Secondly in case of NCQ, flush request belongs to non-NCQ
-		 * command, and queueing it will fail when there is any
-		 * in-flight normal IO request(NCQ command). When adding flush
-		 * rq to the front of hctx->dispatch, it is easier to introduce
-		 * extra time to flush rq's latency because of S_SCHED_RESTART
-		 * compared with adding to the tail of dispatch queue, then
-		 * chance of flush merge is increased, and less flush requests
-		 * will be issued to controller. It is observed that ~10% time
-		 * is saved in blktests block/004 on disk attached to AHCI/NCQ
-		 * drive when adding flush rq to the front of hctx->dispatch.
-		 *
-		 * Simply queue flush rq to the front of hctx->dispatch so that
-		 * intensive flush workloads can benefit in case of NCQ HW.
-		 */
-		at_head = (rq->rq_flags & RQF_FLUSH_SEQ) ? true : at_head;
-		blk_mq_request_bypass_insert(rq, at_head, false);
-		goto run;
-	}
-
-	if (e) {
-		LIST_HEAD(list);
-
-		list_add(&rq->queuelist, &list);
-		e->type->ops.insert_requests(hctx, &list, at_head);
-	} else {
-		spin_lock(&ctx->lock);
-		__blk_mq_insert_request(hctx, rq, at_head);
-		spin_unlock(&ctx->lock);
-	}
-
-run:
-	if (run_queue)
-		blk_mq_run_hw_queue(hctx, async);
-}
-
 static int blk_mq_sched_alloc_map_and_rqs(struct request_queue *q,
 					  struct blk_mq_hw_ctx *hctx,
 					  unsigned int hctx_idx)
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index b25ad6ce41e95c..11bc04af4a08ad 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -17,9 +17,6 @@ bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
 void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx);
 void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
-void blk_mq_sched_insert_request(struct request *rq, bool at_head,
-				 bool run_queue, bool async);
-
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6ee05416a93f6c..05be4ae4fc0dba 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -46,6 +46,8 @@
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 
+static void blk_mq_insert_request(struct request *rq, bool at_head,
+		bool run_queue, bool async);
 static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list);
 
@@ -1305,7 +1307,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
 	if (current->plug && !at_head)
 		blk_add_rq_to_plug(current->plug, rq);
 	else
-		blk_mq_sched_insert_request(rq, at_head, true, false);
+		blk_mq_insert_request(rq, at_head, true, false);
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
 
@@ -1366,7 +1368,7 @@ blk_status_t blk_execute_rq(struct request *rq, bool at_head)
 	rq->end_io = blk_end_sync_rq;
 
 	blk_account_io_start(rq);
-	blk_mq_sched_insert_request(rq, at_head, true, false);
+	blk_mq_insert_request(rq, at_head, true, false);
 
 	if (blk_rq_is_poll(rq)) {
 		blk_rq_poll_completion(rq, &wait.done);
@@ -1440,13 +1442,13 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		if (rq->rq_flags & RQF_DONTPREP)
 			blk_mq_request_bypass_insert(rq, false, false);
 		else
-			blk_mq_sched_insert_request(rq, true, false, false);
+			blk_mq_insert_request(rq, true, false, false);
 	}
 
 	while (!list_empty(&rq_list)) {
 		rq = list_entry(rq_list.next, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		blk_mq_sched_insert_request(rq, false, false, false);
+		blk_mq_insert_request(rq, false, false, false);
 	}
 
 	blk_mq_run_hw_queues(q, false);
@@ -2534,6 +2536,79 @@ static void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx,
 	blk_mq_run_hw_queue(hctx, run_queue_async);
 }
 
+static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
+				       struct request *rq)
+{
+	/*
+	 * dispatch flush and passthrough rq directly
+	 *
+	 * passthrough request has to be added to hctx->dispatch directly.
+	 * For some reason, device may be in one situation which can't
+	 * handle FS request, so STS_RESOURCE is always returned and the
+	 * FS request will be added to hctx->dispatch. However passthrough
+	 * request may be required at that time for fixing the problem. If
+	 * passthrough request is added to scheduler queue, there isn't any
+	 * chance to dispatch it given we prioritize requests in hctx->dispatch.
+	 */
+	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
+		return true;
+
+	return false;
+}
+
+static void blk_mq_insert_request(struct request *rq, bool at_head,
+		bool run_queue, bool async)
+{
+	struct request_queue *q = rq->q;
+	struct elevator_queue *e = q->elevator;
+	struct blk_mq_ctx *ctx = rq->mq_ctx;
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+
+	WARN_ON(e && (rq->tag != BLK_MQ_NO_TAG));
+
+	if (blk_mq_sched_bypass_insert(hctx, rq)) {
+		/*
+		 * Firstly normal IO request is inserted to scheduler queue or
+		 * sw queue, meantime we add flush request to dispatch queue(
+		 * hctx->dispatch) directly and there is at most one in-flight
+		 * flush request for each hw queue, so it doesn't matter to add
+		 * flush request to tail or front of the dispatch queue.
+		 *
+		 * Secondly in case of NCQ, flush request belongs to non-NCQ
+		 * command, and queueing it will fail when there is any
+		 * in-flight normal IO request(NCQ command). When adding flush
+		 * rq to the front of hctx->dispatch, it is easier to introduce
+		 * extra time to flush rq's latency because of S_SCHED_RESTART
+		 * compared with adding to the tail of dispatch queue, then
+		 * chance of flush merge is increased, and less flush requests
+		 * will be issued to controller. It is observed that ~10% time
+		 * is saved in blktests block/004 on disk attached to AHCI/NCQ
+		 * drive when adding flush rq to the front of hctx->dispatch.
+		 *
+		 * Simply queue flush rq to the front of hctx->dispatch so that
+		 * intensive flush workloads can benefit in case of NCQ HW.
+		 */
+		at_head = (rq->rq_flags & RQF_FLUSH_SEQ) ? true : at_head;
+		blk_mq_request_bypass_insert(rq, at_head, false);
+		goto run;
+	}
+
+	if (e) {
+		LIST_HEAD(list);
+
+		list_add(&rq->queuelist, &list);
+		e->type->ops.insert_requests(hctx, &list, at_head);
+	} else {
+		spin_lock(&ctx->lock);
+		__blk_mq_insert_request(hctx, rq, at_head);
+		spin_unlock(&ctx->lock);
+	}
+
+run:
+	if (run_queue)
+		blk_mq_run_hw_queue(hctx, async);
+}
+
 static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
 		unsigned int nr_segs)
 {
@@ -2625,7 +2700,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
 
-	blk_mq_sched_insert_request(rq, false, run_queue, false);
+	blk_mq_insert_request(rq, false, run_queue, false);
 
 	return BLK_STS_OK;
 }
@@ -2977,7 +3052,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	else if ((rq->rq_flags & RQF_ELV) ||
 		 (rq->mq_hctx->dispatch_busy &&
 		  (q->nr_hw_queues == 1 || !is_sync)))
-		blk_mq_sched_insert_request(rq, false, true, true);
+		blk_mq_insert_request(rq, false, true, true);
 	else
 		blk_mq_run_dispatch_ops(rq->q,
 				blk_mq_try_issue_directly(rq->mq_hctx, rq));
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 6065c93350f84f..6f7a86a70dafb4 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -822,7 +822,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 }
 
 /*
- * Called from blk_mq_sched_insert_request() or blk_mq_dispatch_plug_list().
+ * Called from blk_mq_insert_request() or blk_mq_dispatch_plug_list().
  */
 static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 			       struct list_head *list, bool at_head)
-- 
2.39.2

