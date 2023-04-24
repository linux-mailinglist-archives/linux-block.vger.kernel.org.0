Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9410C6DDC31
	for <lists+linux-block@lfdr.de>; Tue, 11 Apr 2023 15:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjDKNec (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Apr 2023 09:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDKNea (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 09:34:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9291E44A3
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 06:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=V48guqI0/aVfARrMU+TF4ht6h2iO5vFrZVZgjjcaKhc=; b=HdXJ4ioveNvYp2EpPPS6nIJnxa
        1wL+CimFZlzLqwuY0QcwhK2nAppfHU2mA6RVg7gPaUZJjwtwUNaD0nMDX5edVC9/lmtvwp6u1VMBz
        VcBlLaVPkwBQHXW27SWkLq25J+o8ntG/1/BhsGOLXCYL4XnJZP5sHTHfnv5v4Bqw8qsTHWjPTxiVP
        9U60cf819e8Y1s3n7aO+/eASsRGEwVZ1vjjbmgCwANGeqDbuTwoEVRYA34iNziyL5EX5pP11WKCyT
        FLhrM2KrpJu8eRlJBq1dyQ5cK2hIZWDUtZjY70zQDSFTwCubYguxb3pPIyGyx8T98OBSZlvAYi+aX
        GNp8kTKw==;
Received: from [2001:4bb8:192:2d6c:a9b7:88a0:9fdd:81ca] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmE8h-0007zZ-00;
        Tue, 11 Apr 2023 13:34:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 11/16] blk-mq: fold __blk_mq_try_issue_directly into its two callers
Date:   Tue, 11 Apr 2023 15:33:24 +0200
Message-Id: <20230411133329.554624-12-hch@lst.de>
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

Due the wildly different behavior beased on the bypass_insert
argument not a whole lot of code in __blk_mq_try_issue_directly is
actually shared between blk_mq_try_issue_directly and
blk_mq_request_issue_directly.  Remove __blk_mq_try_issue_directly and
fold the code into the two callers instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 72 ++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 41 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2995863c1680eb..68e45d5a6868b3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2640,42 +2640,6 @@ static bool blk_mq_get_budget_and_tag(struct request *rq)
 	return true;
 }
 
-static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
-						struct request *rq,
-						bool bypass_insert, bool last)
-{
-	struct request_queue *q = rq->q;
-	bool run_queue = true;
-
-	/*
-	 * RCU or SRCU read lock is needed before checking quiesced flag.
-	 *
-	 * When queue is stopped or quiesced, ignore 'bypass_insert' from
-	 * blk_mq_request_issue_directly(), and return BLK_STS_OK to caller,
-	 * and avoid driver to try to dispatch again.
-	 */
-	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
-		run_queue = false;
-		bypass_insert = false;
-		goto insert;
-	}
-
-	if ((rq->rq_flags & RQF_ELV) && !bypass_insert)
-		goto insert;
-
-	if (!blk_mq_get_budget_and_tag(rq))
-		goto insert;
-
-	return __blk_mq_issue_directly(hctx, rq, last);
-insert:
-	if (bypass_insert)
-		return BLK_STS_RESOURCE;
-
-	blk_mq_insert_request(rq, false, run_queue, false);
-
-	return BLK_STS_OK;
-}
-
 /**
  * blk_mq_try_issue_directly - Try to send a request directly to device driver.
  * @hctx: Pointer of the associated hardware queue.
@@ -2689,18 +2653,44 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		struct request *rq)
 {
-	blk_status_t ret =
-		__blk_mq_try_issue_directly(hctx, rq, false, true);
+	blk_status_t ret;
+
+	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
+		blk_mq_insert_request(rq, false, false, false);
+		return;
+	}
+
+	if ((rq->rq_flags & RQF_ELV) || !blk_mq_get_budget_and_tag(rq)) {
+		blk_mq_insert_request(rq, false, true, false);
+		return;
+	}
 
-	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
+	ret = __blk_mq_issue_directly(hctx, rq, true);
+	switch (ret) {
+	case BLK_STS_OK:
+		break;
+	case BLK_STS_RESOURCE:
+	case BLK_STS_DEV_RESOURCE:
 		blk_mq_request_bypass_insert(rq, false, true);
-	else if (ret != BLK_STS_OK)
+		break;
+	default:
 		blk_mq_end_request(rq, ret);
+		break;
+	}
 }
 
 static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 {
-	return __blk_mq_try_issue_directly(rq->mq_hctx, rq, true, last);
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+
+	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
+		blk_mq_insert_request(rq, false, false, false);
+		return BLK_STS_OK;
+	}
+
+	if (!blk_mq_get_budget_and_tag(rq))
+		return BLK_STS_RESOURCE;
+	return __blk_mq_issue_directly(hctx, rq, last);
 }
 
 static void blk_mq_plug_issue_direct(struct blk_plug *plug)
-- 
2.39.2

