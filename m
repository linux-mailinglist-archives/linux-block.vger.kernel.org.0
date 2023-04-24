Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FDA6DEB23
	for <lists+linux-block@lfdr.de>; Wed, 12 Apr 2023 07:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDLFdX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Apr 2023 01:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDLFdW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:33:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED874680
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rmojOoxsdL4t10wpdZed6ztkVTNq0wnr8ZXoVLBhf3Q=; b=dd+sNpAxmIGVec5Tuu6OWnv6hg
        7rswkphM7b3Dnc851yu6YlIOqSALjEFYfuVSDggA/cOhaTu1LQ5uvQ6L6W30kM6E7CQh9hkqsHlN1
        gfQRH2vgNySNwpeHDdd+8kslOwBY93ShXgwL/vp2B67/HCvyf6JcYKFUgypOvOxIUxzamsqDzGOKM
        nGgb+4eDNZHYzfdaYZmzkVAHRao25jVwr5yHjUTW/QUZaVvBiN0etZnOALsvGwxKXm89/5h4enWuf
        kFFgZBKb4rSlD/UfrS4fngoaa3Vul1xyVpMJgXjCFvpPKIUq1vALCuv2yYzu6O0iIWBAnNAGkQseB
        eJFjStsw==;
Received: from [2001:4bb8:192:2d6c:58da:8aa2:ef59:390f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmT6b-001rJH-1O;
        Wed, 12 Apr 2023 05:33:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 10/18] blk-mq: refactor passthrough vs flush handling in blk_mq_insert_request
Date:   Wed, 12 Apr 2023 07:32:40 +0200
Message-Id: <20230412053248.601961-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412053248.601961-1-hch@lst.de>
References: <20230412053248.601961-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While both passthrough and flush requests call directly into
blk_mq_request_bypass_insert, the parameters aren't the same.
Split the handling into two separate conditionals and turn the whole
function into an if/elif/elif/else flow instead of the gotos.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 50 ++++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7e9f7d00452f11..c3de03217f4f1a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2506,37 +2506,26 @@ static void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx,
 	blk_mq_run_hw_queue(hctx, run_queue_async);
 }
 
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
 static void blk_mq_insert_request(struct request *rq, bool at_head,
 		bool run_queue, bool async)
 {
 	struct request_queue *q = rq->q;
-	struct elevator_queue *e = q->elevator;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
-	WARN_ON(e && (rq->tag != BLK_MQ_NO_TAG));
-
-	if (blk_mq_sched_bypass_insert(hctx, rq)) {
+	if (blk_rq_is_passthrough(rq)) {
+		/*
+		 * Passthrough request have to be added to hctx->dispatch
+		 * directly.  The device may be in a situation where it can't
+		 * handle FS request, and always returns BLK_STS_RESOURCE for
+		 * them, which gets them added to hctx->dispatch.
+		 *
+		 * If a passthrough request is required to unblock the queues,
+		 * and it is added to the scheduler queue, there is no chance to
+		 * dispatch it given we prioritize requests in hctx->dispatch.
+		 */
+		blk_mq_request_bypass_insert(rq, at_head, false);
+	} else if (rq->rq_flags & RQF_FLUSH_SEQ) {
 		/*
 		 * Firstly normal IO request is inserted to scheduler queue or
 		 * sw queue, meantime we add flush request to dispatch queue(
@@ -2558,16 +2547,14 @@ static void blk_mq_insert_request(struct request *rq, bool at_head,
 		 * Simply queue flush rq to the front of hctx->dispatch so that
 		 * intensive flush workloads can benefit in case of NCQ HW.
 		 */
-		at_head = (rq->rq_flags & RQF_FLUSH_SEQ) ? true : at_head;
-		blk_mq_request_bypass_insert(rq, at_head, false);
-		goto run;
-	}
-
-	if (e) {
+		blk_mq_request_bypass_insert(rq, true, false);
+	} else if (q->elevator) {
 		LIST_HEAD(list);
 
+		WARN_ON_ONCE(rq->tag != BLK_MQ_NO_TAG);
+
 		list_add(&rq->queuelist, &list);
-		e->type->ops.insert_requests(hctx, &list, at_head);
+		q->elevator->type->ops.insert_requests(hctx, &list, at_head);
 	} else {
 		trace_block_rq_insert(rq);
 
@@ -2581,7 +2568,6 @@ static void blk_mq_insert_request(struct request *rq, bool at_head,
 		spin_unlock(&ctx->lock);
 	}
 
-run:
 	if (run_queue)
 		blk_mq_run_hw_queue(hctx, async);
 }
-- 
2.39.2

