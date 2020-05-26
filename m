Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958FA1BBC65
	for <lists+linux-block@lfdr.de>; Tue, 28 Apr 2020 13:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgD1L2J (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Apr 2020 07:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgD1L2I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 07:28:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8470AC03C1A9
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2020 04:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rXkNN697FlOYaplt+jBnwHd4UJVop8UEBMC0XfDEtvM=; b=PejYXeon4BIy5oIFt32Tdiwi4W
        XE9/aUUg1+ij49Nvqn3stgS1IGheWL2ZDesILZxnTH61F3c21tSZLLtUs6crAxmO+iRaDewptcBt5
        raqmIrgyu7mKyJi58pUViEy6oa912nTYqcR4fmeBWdjqL8SB/xIWNjret6gp0qKJDmfVf7jIjfWTz
        vf9wVyseTWsbK3EgWbYoMYMCphmbwlv0YB2U/CJIL2rOYJk3VZ46FrL+f/I98elWPt1p7m52Ppiaj
        DiCBiwMLqxXGqs7sDY/SPHDwClTBaEf7Z9RSG/MyCuAADs+rt2qY6w30WPkXpnFb79aZlm/hacU9I
        4hIXo9UQ==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTOPH-0002iU-Kr; Tue, 28 Apr 2020 11:28:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     hannes@cmpxchg.org, linux-block@vger.kernel.org
Subject: [PATCH 4/4] block: add a bio_queue_enter helper
Date:   Tue, 28 Apr 2020 13:27:56 +0200
Message-Id: <20200428112756.1892137-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428112756.1892137-1-hch@lst.de>
References: <20200428112756.1892137-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a little helper that passes the right nowait flag to blk_queue_enter
based on the bio flag, and terminates the bio with the right error code
if entering the queue fails.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 50 +++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 81a291085c6ca..7f11560bfddbb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -440,6 +440,23 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 	}
 }
 
+static inline int bio_queue_enter(struct bio *bio)
+{
+	struct request_queue *q = bio->bi_disk->queue;
+	bool nowait = bio->bi_opf & REQ_NOWAIT;
+	int ret;
+
+	ret = blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0);
+	if (unlikely(ret)) {
+		if (nowait && !blk_queue_dying(q))
+			bio_wouldblock_error(bio);
+		else
+			bio_io_error(bio);
+	}
+
+	return ret;
+}
+
 void blk_queue_exit(struct request_queue *q)
 {
 	percpu_ref_put(&q->q_usage_counter);
@@ -1049,10 +1066,8 @@ blk_qc_t generic_make_request(struct bio *bio)
 	current->bio_list = bio_list_on_stack;
 	do {
 		struct request_queue *q = bio->bi_disk->queue;
-		blk_mq_req_flags_t flags = bio->bi_opf & REQ_NOWAIT ?
-			BLK_MQ_REQ_NOWAIT : 0;
 
-		if (likely(blk_queue_enter(q, flags) == 0)) {
+		if (likely(bio_queue_enter(bio) == 0)) {
 			struct bio_list lower, same;
 
 			/* Create a fresh bio_list for all subordinate requests */
@@ -1079,12 +1094,6 @@ blk_qc_t generic_make_request(struct bio *bio)
 			bio_list_merge(&bio_list_on_stack[0], &lower);
 			bio_list_merge(&bio_list_on_stack[0], &same);
 			bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
-		} else {
-			if (unlikely(!blk_queue_dying(q) &&
-					(bio->bi_opf & REQ_NOWAIT)))
-				bio_wouldblock_error(bio);
-			else
-				bio_io_error(bio);
 		}
 		bio = bio_list_pop(&bio_list_on_stack[0]);
 	} while (bio);
@@ -1106,30 +1115,19 @@ EXPORT_SYMBOL(generic_make_request);
 blk_qc_t direct_make_request(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_disk->queue;
-	bool nowait = bio->bi_opf & REQ_NOWAIT;
 	blk_qc_t ret;
 
-	if (WARN_ON_ONCE(q->make_request_fn))
-		goto io_error;
-	if (!generic_make_request_checks(bio))
+	if (WARN_ON_ONCE(q->make_request_fn)) {
+		bio_io_error(bio);
 		return BLK_QC_T_NONE;
-
-	if (unlikely(blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0))) {
-		if (nowait && !blk_queue_dying(q))
-			goto would_block;
-		goto io_error;
 	}
-
+	if (!generic_make_request_checks(bio))
+		return BLK_QC_T_NONE;
+	if (unlikely(bio_queue_enter(bio)))
+		return BLK_QC_T_NONE;
 	ret = blk_mq_make_request(q, bio);
 	blk_queue_exit(q);
 	return ret;
-
-would_block:
-	bio_wouldblock_error(bio);
-	return BLK_QC_T_NONE;
-io_error:
-	bio_io_error(bio);
-	return BLK_QC_T_NONE;
 }
 EXPORT_SYMBOL_GPL(direct_make_request);
 
-- 
2.26.2

