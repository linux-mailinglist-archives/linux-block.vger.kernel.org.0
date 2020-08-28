Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD6C255328
	for <lists+linux-block@lfdr.de>; Fri, 28 Aug 2020 04:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgH1CyO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Aug 2020 22:54:14 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:57789 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726854AbgH1CyN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 22:54:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U73Jfo7_1598583197;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U73Jfo7_1598583197)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Aug 2020 10:53:17 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] block: Remove blk_mq_attempt_merge() function
Date:   Fri, 28 Aug 2020 10:52:57 +0800
Message-Id: <a85628c8d00bfa7ae53732234aa7b623b3b94583.1598580324.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
References: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
References: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The small blk_mq_attempt_merge() function is only called by
__blk_mq_sched_bio_merge(), just open code it.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-sched.c | 44 ++++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 94db0c9..205d971 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -391,28 +391,6 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
 
-/*
- * Reverse check our software queue for entries that we could potentially
- * merge with. Currently includes a hand-wavy stop count of 8, to not spend
- * too much time checking for merges.
- */
-static bool blk_mq_attempt_merge(struct request_queue *q,
-				 struct blk_mq_hw_ctx *hctx,
-				 struct blk_mq_ctx *ctx, struct bio *bio,
-				 unsigned int nr_segs)
-{
-	enum hctx_type type = hctx->type;
-
-	lockdep_assert_held(&ctx->lock);
-
-	if (blk_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs)) {
-		ctx->rq_merged++;
-		return true;
-	}
-
-	return false;
-}
-
 bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
@@ -426,14 +404,24 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 		return e->type->ops.bio_merge(hctx, bio, nr_segs);
 
 	type = hctx->type;
-	if ((hctx->flags & BLK_MQ_F_SHOULD_MERGE) &&
-			!list_empty_careful(&ctx->rq_lists[type])) {
-		/* default per sw-queue merge */
-		spin_lock(&ctx->lock);
-		ret = blk_mq_attempt_merge(q, hctx, ctx, bio, nr_segs);
-		spin_unlock(&ctx->lock);
+	if (!(hctx->flags & BLK_MQ_F_SHOULD_MERGE) ||
+	    list_empty_careful(&ctx->rq_lists[type]))
+		return false;
+
+	/* default per sw-queue merge */
+	spin_lock(&ctx->lock);
+	/*
+	 * Reverse check our software queue for entries that we could
+	 * potentially merge with. Currently includes a hand-wavy stop
+	 * count of 8, to not spend too much time checking for merges.
+	 */
+	if (blk_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs)) {
+		ctx->rq_merged++;
+		ret = true;
 	}
 
+	spin_unlock(&ctx->lock);
+
 	return ret;
 }
 
-- 
1.8.3.1

