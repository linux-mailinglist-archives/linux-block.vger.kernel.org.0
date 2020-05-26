Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF6F1B8451
	for <lists+linux-block@lfdr.de>; Sat, 25 Apr 2020 09:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgDYHxr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 25 Apr 2020 03:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgDYHxr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 03:53:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D66C09B049;
        Sat, 25 Apr 2020 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=T8tQwPcvJ8L22/CgfVpdAP5ZKnnyuxv1LKNpOQCm/qY=; b=FJV8YV7YcQ923y2wN4PNhPD8TZ
        rpvuvIMHIw0NnNrlYgx+6Q/fDz3zaGeqJ/xLVSS+LpuBzmj4przJn2Mfl4JwH3iNxfz7Bc0VjfqON
        AgM26RH6PfIMfbMF27qA2qbb58rclbWLdVKryz+T9S0WmFYlTDKcUZYQqz9xlFYmuCfbvGxrQLcau
        h2mSZxBuXTAQh7gLJOpNG+muRotqfLEgboHPhFZ8ac8EdXeqfmiZ0f/E/93Rmt+gPXI/mVYz8pjr9
        42FSDBHsWjbgKsCuBZLoAuMc8sO2++sGCBX8yMEfKvmmEpSa/pHiHwAzlFZBk0PQJl3nCEbCaNmQy
        9YHWu5zQ==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSFdC-0007dx-3k; Sat, 25 Apr 2020 07:53:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: bypass ->make_request_fn for blk-mq drivers
Date:   Sat, 25 Apr 2020 09:53:36 +0200
Message-Id: <20200425075336.721021-4-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200425075336.721021-1-hch@lst.de>
References: <20200425075336.721021-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Call blk_mq_make_request when no ->make_request_fn is set.  This is
safe now that blk_alloc_queue always sets up the pointer for make_request
based drivers.  This avoids an indirect call in the blk-mq driver I/O
fast path, which is rather expensive due to spectre mitigations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       | 26 +++++++++++++++++---------
 block/blk-mq.c         |  4 ++--
 drivers/md/dm.c        |  3 +++
 include/linux/blk-mq.h |  2 ++
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 311596d5dbc41..0e9e1c83e5e84 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1072,7 +1072,10 @@ blk_qc_t generic_make_request(struct bio *bio)
 			/* Create a fresh bio_list for all subordinate requests */
 			bio_list_on_stack[1] = bio_list_on_stack[0];
 			bio_list_init(&bio_list_on_stack[0]);
-			ret = q->make_request_fn(q, bio);
+			if (q->make_request_fn)
+				ret = q->make_request_fn(q, bio);
+			else
+				ret = blk_mq_make_request(q, bio);
 
 			blk_queue_exit(q);
 
@@ -1112,9 +1115,7 @@ EXPORT_SYMBOL(generic_make_request);
  *
  * This function behaves like generic_make_request(), but does not protect
  * against recursion.  Must only be used if the called driver is known
- * to not call generic_make_request (or direct_make_request) again from
- * its make_request function.  (Calling direct_make_request again from
- * a workqueue is perfectly fine as that doesn't recurse).
+ * to be blk-mq based.
  */
 blk_qc_t direct_make_request(struct bio *bio)
 {
@@ -1122,20 +1123,27 @@ blk_qc_t direct_make_request(struct bio *bio)
 	bool nowait = bio->bi_opf & REQ_NOWAIT;
 	blk_qc_t ret;
 
+	if (WARN_ON_ONCE(q->make_request_fn))
+		goto io_error;
 	if (!generic_make_request_checks(bio))
 		return BLK_QC_T_NONE;
 
 	if (unlikely(blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0))) {
 		if (nowait && !blk_queue_dying(q))
-			bio_wouldblock_error(bio);
-		else
-			bio_io_error(bio);
-		return BLK_QC_T_NONE;
+			goto would_block;
+		goto io_error;
 	}
 
-	ret = q->make_request_fn(q, bio);
+	ret = blk_mq_make_request(q, bio);
 	blk_queue_exit(q);
 	return ret;
+
+would_block:
+	bio_wouldblock_error(bio);
+	return BLK_QC_T_NONE;
+io_error:
+	bio_io_error(bio);
+	return BLK_QC_T_NONE;
 }
 EXPORT_SYMBOL_GPL(direct_make_request);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 71d0894ce1c58..bcc3a2397d4ae 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1984,7 +1984,7 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
  *
  * Returns: Request queue cookie.
  */
-static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
+blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int is_sync = op_is_sync(bio->bi_opf);
 	const int is_flush_fua = op_is_flush(bio->bi_opf);
@@ -2096,6 +2096,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	return cookie;
 }
+EXPORT_SYMBOL_GPL(blk_mq_make_request); /* only for request based dm */
 
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx)
@@ -2955,7 +2956,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	INIT_LIST_HEAD(&q->requeue_list);
 	spin_lock_init(&q->requeue_lock);
 
-	q->make_request_fn = blk_mq_make_request;
 	q->nr_requests = set->queue_depth;
 
 	/*
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index db9e461146531..0eb93da44ea2a 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1788,6 +1788,9 @@ static blk_qc_t dm_make_request(struct request_queue *q, struct bio *bio)
 	int srcu_idx;
 	struct dm_table *map;
 
+	if (dm_get_md_type(md) == DM_TYPE_REQUEST_BASED)
+		return blk_mq_make_request(q, bio);
+
 	map = dm_get_live_table(md, &srcu_idx);
 
 	/* if we're suspended, we have to queue this io for later */
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 51fbf6f76593a..d7307795439a4 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -578,4 +578,6 @@ static inline void blk_mq_cleanup_rq(struct request *rq)
 		rq->q->mq_ops->cleanup_rq(rq);
 }
 
+blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio);
+
 #endif
-- 
2.26.1

