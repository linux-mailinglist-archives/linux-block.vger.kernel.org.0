Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645E24B68C5
	for <lists+linux-block@lfdr.de>; Tue, 15 Feb 2022 11:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiBOKF7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Feb 2022 05:05:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiBOKF7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 05:05:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F9A24F
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 02:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ReAiumxdBv1XVEkgCdJh8kXAnU3jtNvTIPeXyDr/xfo=; b=ooslR8dyDAPpWIaYY4MDesMLQo
        OjZRr/+Mv8znXJGwG421jfdyg7KU4nhrj8e2nCZxtLhHkgVncs57X0Qp/7FT3t+YeEpvXk5xR6cz+
        aMIPNULQVbLXYn7Pme+qP71LG3Ksh4+jodjzqRDES7ViRyiY1poV5sQREqISL2Ysyciop2HL6Nos+
        n5xjMHHZhYVrqTKqusF5bWeIwfep7afDaNIViVGTBnq47yijs0TcTug5Gs3M2hRccZ8PqUZLukhHx
        TU1Vb8U+2oufjrmecKN7A22uC3hq05uMALzoNBGSSgQiGVoVs+qs03aoeK1iFzA/Jej6n0+N7+rHk
        +So7DGTA==;
Received: from [2001:4bb8:184:543c:6bdf:22f4:7f0a:fe97] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJuiS-002E29-2V; Tue, 15 Feb 2022 10:05:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 2/5] blk-mq: fold blk_cloned_rq_check_limits into blk_insert_cloned_request
Date:   Tue, 15 Feb 2022 11:05:37 +0100
Message-Id: <20220215100540.3892965-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215100540.3892965-1-hch@lst.de>
References: <20220215100540.3892965-1-hch@lst.de>
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

Fold blk_cloned_rq_check_limits into its only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index db62d34afb637..fc132933397fb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2842,26 +2842,14 @@ void blk_mq_submit_bio(struct bio *bio)
 
 #ifdef CONFIG_BLK_MQ_STACKING
 /**
- * blk_cloned_rq_check_limits - Helper function to check a cloned request
- *                              for the new queue limits
- * @q:  the queue
- * @rq: the request being checked
- *
- * Description:
- *    @rq may have been made based on weaker limitations of upper-level queues
- *    in request stacking drivers, and it may violate the limitation of @q.
- *    Since the block layer and the underlying device driver trust @rq
- *    after it is inserted to @q, it should be checked against @q before
- *    the insertion using this generic function.
- *
- *    Request stacking drivers like request-based dm may change the queue
- *    limits when retrying requests on other queues. Those requests need
- *    to be checked against the new queue limits again during dispatch.
+ * blk_insert_cloned_request - Helper for stacking drivers to submit a request
+ * @q:  the queue to submit the request
+ * @rq: the request being queued
  */
-static blk_status_t blk_cloned_rq_check_limits(struct request_queue *q,
-				      struct request *rq)
+blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *rq)
 {
 	unsigned int max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+	blk_status_t ret;
 
 	if (blk_rq_sectors(rq) > max_sectors) {
 		/*
@@ -2893,22 +2881,6 @@ static blk_status_t blk_cloned_rq_check_limits(struct request_queue *q,
 		return BLK_STS_IOERR;
 	}
 
-	return BLK_STS_OK;
-}
-
-/**
- * blk_insert_cloned_request - Helper for stacking drivers to submit a request
- * @q:  the queue to submit the request
- * @rq: the request being queued
- */
-blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *rq)
-{
-	blk_status_t ret;
-
-	ret = blk_cloned_rq_check_limits(q, rq);
-	if (ret != BLK_STS_OK)
-		return ret;
-
 	if (rq->q->disk &&
 	    should_fail_request(rq->q->disk->part0, blk_rq_bytes(rq)))
 		return BLK_STS_IOERR;
-- 
2.30.2

