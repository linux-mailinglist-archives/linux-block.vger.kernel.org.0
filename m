Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19FC245B56
	for <lists+linux-block@lfdr.de>; Mon, 17 Aug 2020 06:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHQEJy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 17 Aug 2020 00:09:54 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:44138 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbgHQEJl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 00:09:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U5xJolF_1597637374;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U5xJolF_1597637374)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Aug 2020 12:09:35 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 4/5] block: Remove blk_mq_attempt_merge() function
Date:   Mon, 17 Aug 2020 12:09:18 +0800
Message-Id: <b9ae58ae4bc8b16a53fabd35ce163897286d856a.1597637287.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The small blk_mq_attempt_merge() function is only called by
__blk_mq_sched_bio_merge(), just open code it.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-mq-sched.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 8e9bafe..1cc7919 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -408,28 +408,6 @@ bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 }
 EXPORT_SYMBOL_GPL(blk_mq_bio_list_merge);
 
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
-	if (blk_mq_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs)) {
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
@@ -447,7 +425,16 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 			!list_empty_careful(&ctx->rq_lists[type])) {
 		/* default per sw-queue merge */
 		spin_lock(&ctx->lock);
-		ret = blk_mq_attempt_merge(q, hctx, ctx, bio, nr_segs);
+		/*
+		 * Reverse check our software queue for entries that we could
+		 * potentially merge with. Currently includes a hand-wavy stop
+		 * count of 8, to not spend too much time checking for merges.
+		 */
+		if (blk_mq_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs)) {
+			ctx->rq_merged++;
+			ret = true;
+		}
+
 		spin_unlock(&ctx->lock);
 	}
 
-- 
1.8.3.1

