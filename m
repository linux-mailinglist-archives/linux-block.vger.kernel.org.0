Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8631C6E072D
	for <lists+linux-block@lfdr.de>; Thu, 13 Apr 2023 08:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDMGmQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 13 Apr 2023 02:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjDMGmF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:42:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4833293E4
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gwjNREJykTvfTcPK+7SpTfpSwBoThAQ9ucrI6F/rR04=; b=wBkbzrkLhh8rK0Uep45G7svgAn
        ztvlkzLF1+Sps6zzGtaDN9oKRLkauJWhr1tGhe2k8oW3uHDQU/CSopEkHAdFbsRq1YdmI5c1xWUmS
        DDto4E3cnISuiRXtsYK3f4P3AOxShSwK3t5/JewkcU4/vRLnTnydSKS6brhdsn/2gQM1rhPhA8biq
        bIC1OAiI/h59i5GvgkdzFGJoKffgO/QfC/wynm7glwswvLRSu/0R/io7ERUWRWatS65J82obC1RHR
        1bgqEV/+NYbMAnaciwwTzsvlzryM5EVSkPK2aG8imjhByLSpZN39Tn9XyNeB3y8BwTha5wQ+Q4UR2
        s3RRVTRQ==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmqeP-005BY4-2c;
        Thu, 13 Apr 2023 06:41:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 18/20] blk-mq: pass a flags argument to blk_mq_request_bypass_insert
Date:   Thu, 13 Apr 2023 08:40:55 +0200
Message-Id: <20230413064057.707578-19-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413064057.707578-1-hch@lst.de>
References: <20230413064057.707578-1-hch@lst.de>
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

Replace the boolean at_head argument with the same flags that are already
passed to blk_mq_insert_request.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-flush.c |  2 +-
 block/blk-mq.c    | 18 +++++++++---------
 block/blk-mq.h    |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 015982bd2f7c8f..1d3af17619deb7 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -428,7 +428,7 @@ void blk_insert_flush(struct request *rq)
 	 */
 	if ((policy & REQ_FSEQ_DATA) &&
 	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
-		blk_mq_request_bypass_insert(rq, false);
+		blk_mq_request_bypass_insert(rq, 0);
 		blk_mq_run_hw_queue(hctx, false);
 		return;
 	}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ba64c4621e29d6..ff74559d7da1fc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1447,7 +1447,7 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		if (rq->rq_flags & RQF_DONTPREP) {
 			rq->rq_flags &= ~RQF_SOFTBARRIER;
 			list_del_init(&rq->queuelist);
-			blk_mq_request_bypass_insert(rq, false);
+			blk_mq_request_bypass_insert(rq, 0);
 		} else if (rq->rq_flags & RQF_SOFTBARRIER) {
 			rq->rq_flags &= ~RQF_SOFTBARRIER;
 			list_del_init(&rq->queuelist);
@@ -2457,17 +2457,17 @@ static void blk_mq_run_work_fn(struct work_struct *work)
 /**
  * blk_mq_request_bypass_insert - Insert a request at dispatch list.
  * @rq: Pointer to request to be inserted.
- * @at_head: true if the request should be inserted at the head of the list.
+ * @flags: BLK_MQ_INSERT_*
  *
  * Should only be used carefully, when the caller knows we want to
  * bypass a potential IO scheduler on the target device.
  */
-void blk_mq_request_bypass_insert(struct request *rq, bool at_head)
+void blk_mq_request_bypass_insert(struct request *rq, blk_insert_t flags)
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	spin_lock(&hctx->lock);
-	if (at_head)
+	if (flags & BLK_MQ_INSERT_AT_HEAD)
 		list_add(&rq->queuelist, &hctx->dispatch);
 	else
 		list_add_tail(&rq->queuelist, &hctx->dispatch);
@@ -2526,7 +2526,7 @@ static void blk_mq_insert_request(struct request *rq, blk_insert_t flags)
 		 * and it is added to the scheduler queue, there is no chance to
 		 * dispatch it given we prioritize requests in hctx->dispatch.
 		 */
-		blk_mq_request_bypass_insert(rq, flags & BLK_MQ_INSERT_AT_HEAD);
+		blk_mq_request_bypass_insert(rq, flags);
 	} else if (rq->rq_flags & RQF_FLUSH_SEQ) {
 		/*
 		 * Firstly normal IO request is inserted to scheduler queue or
@@ -2549,7 +2549,7 @@ static void blk_mq_insert_request(struct request *rq, blk_insert_t flags)
 		 * Simply queue flush rq to the front of hctx->dispatch so that
 		 * intensive flush workloads can benefit in case of NCQ HW.
 		 */
-		blk_mq_request_bypass_insert(rq, true);
+		blk_mq_request_bypass_insert(rq, BLK_MQ_INSERT_AT_HEAD);
 	} else if (q->elevator) {
 		LIST_HEAD(list);
 
@@ -2670,7 +2670,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
-		blk_mq_request_bypass_insert(rq, false);
+		blk_mq_request_bypass_insert(rq, 0);
 		blk_mq_run_hw_queue(hctx, false);
 		break;
 	default:
@@ -2718,7 +2718,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 			break;
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
-			blk_mq_request_bypass_insert(rq, false);
+			blk_mq_request_bypass_insert(rq, 0);
 			blk_mq_run_hw_queue(hctx, false);
 			goto out;
 		default:
@@ -2837,7 +2837,7 @@ static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 			break;
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
-			blk_mq_request_bypass_insert(rq, false);
+			blk_mq_request_bypass_insert(rq, 0);
 			if (list_empty(list))
 				blk_mq_run_hw_queue(hctx, false);
 			goto out;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 273eee00524b98..bb16c0a54411b0 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -67,7 +67,7 @@ void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 /*
  * Internal helpers for request insertion into sw queues
  */
-void blk_mq_request_bypass_insert(struct request *rq, bool at_head);
+void blk_mq_request_bypass_insert(struct request *rq, blk_insert_t flags);
 
 /*
  * CPU -> queue mappings
-- 
2.39.2

