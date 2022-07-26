Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E62F5819B5
	for <lists+linux-block@lfdr.de>; Tue, 26 Jul 2022 20:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiGZSag (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 26 Jul 2022 14:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiGZSaf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 14:30:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEAC65F7
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 11:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iQIyO1ovAfO29MB7MkE0TuXEbqoNeiZYFLAaoHhuKD4=; b=HrHSf+sUU49f9t49QqE2RKbsg8
        Ymdoxsni2rUdS1UBMsK12Qmt4RxT3NGiEG6nq9vq20dAt67SWkEE1WYGB8CMl15iVUmDFUeahP2Mv
        yC+Wzg8kg+0R4qpcz/QyCCQLvgI9bnsFlk51+5nNhJIdFftP3rRwD7Wx4wybQ1/Dj8QOtHQ5noPq7
        b6EQjTVPvbQx/67J6fj2dFJIM/F1L8+Lb7hluTvEqth/iH1Aot4BvKS4W1dGPpyW2SG7D6LlD/gJE
        B+UPLU01L319kDjAu4o5yKaH2imzr4D2obFYJ/rT/Pv0z65DvlmYduuxc5TaXBFFTUSN8AZ+vM4XE
        vIG78zOA==;
Received: from [2001:67c:370:1998:f991:c4cf:cf3d:dfb6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGPKE-0027sp-0T; Tue, 26 Jul 2022 18:30:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/6] block: change the blk_queue_bounce calling convention
Date:   Tue, 26 Jul 2022 14:30:25 -0400
Message-Id: <20220726183029.2950008-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726183029.2950008-1-hch@lst.de>
References: <20220726183029.2950008-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The double indirect bio leads to somewhat suboptimal code generation.
Instead return the (original or split) bio, and make sure the
request_queue arguments to the lower level helpers is passed after the
bio to avoid constant reshuffling of the argument passing registers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c |  2 +-
 block/blk.h    | 10 ++++++----
 block/bounce.c | 26 +++++++++++++-------------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 790f55453f1b1..7adba3eeba1c6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2815,7 +2815,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	unsigned int nr_segs = 1;
 	blk_status_t ret;
 
-	blk_queue_bounce(q, &bio);
+	bio = blk_queue_bounce(bio, q);
 	if (bio_may_exceed_limits(bio, q))
 		bio = __bio_split_to_limits(bio, q, &nr_segs);
 
diff --git a/block/blk.h b/block/blk.h
index 623be4c2e60c1..f50c8fcded99e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -378,7 +378,7 @@ static inline void blk_throtl_bio_endio(struct bio *bio) { }
 static inline void blk_throtl_stat_add(struct request *rq, u64 time) { }
 #endif
 
-void __blk_queue_bounce(struct request_queue *q, struct bio **bio);
+struct bio *__blk_queue_bounce(struct bio *bio, struct request_queue *q);
 
 static inline bool blk_queue_may_bounce(struct request_queue *q)
 {
@@ -387,10 +387,12 @@ static inline bool blk_queue_may_bounce(struct request_queue *q)
 		max_low_pfn >= max_pfn;
 }
 
-static inline void blk_queue_bounce(struct request_queue *q, struct bio **bio)
+static inline struct bio *blk_queue_bounce(struct bio *bio,
+		struct request_queue *q)
 {
-	if (unlikely(blk_queue_may_bounce(q) && bio_has_data(*bio)))
-		__blk_queue_bounce(q, bio);	
+	if (unlikely(blk_queue_may_bounce(q) && bio_has_data(bio)))
+		return __blk_queue_bounce(bio, q);
+	return bio;
 }
 
 #ifdef CONFIG_BLK_CGROUP_IOLATENCY
diff --git a/block/bounce.c b/block/bounce.c
index c8f487af7be37..7cfcb242f9a11 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -199,24 +199,24 @@ static struct bio *bounce_clone_bio(struct bio *bio_src)
 	return NULL;
 }
 
-void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
+struct bio *__blk_queue_bounce(struct bio *bio_orig, struct request_queue *q)
 {
 	struct bio *bio;
-	int rw = bio_data_dir(*bio_orig);
+	int rw = bio_data_dir(bio_orig);
 	struct bio_vec *to, from;
 	struct bvec_iter iter;
 	unsigned i = 0, bytes = 0;
 	bool bounce = false;
 	int sectors;
 
-	bio_for_each_segment(from, *bio_orig, iter) {
+	bio_for_each_segment(from, bio_orig, iter) {
 		if (i++ < BIO_MAX_VECS)
 			bytes += from.bv_len;
 		if (PageHighMem(from.bv_page))
 			bounce = true;
 	}
 	if (!bounce)
-		return;
+		return bio_orig;
 
 	/*
 	 * Individual bvecs might not be logical block aligned. Round down
@@ -225,13 +225,13 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
 	 */
 	sectors = ALIGN_DOWN(bytes, queue_logical_block_size(q)) >>
 			SECTOR_SHIFT;
-	if (sectors < bio_sectors(*bio_orig)) {
-		bio = bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
-		bio_chain(bio, *bio_orig);
-		submit_bio_noacct(*bio_orig);
-		*bio_orig = bio;
+	if (sectors < bio_sectors(bio_orig)) {
+		bio = bio_split(bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
+		bio_chain(bio, bio_orig);
+		submit_bio_noacct(bio_orig);
+		bio_orig = bio;
 	}
-	bio = bounce_clone_bio(*bio_orig);
+	bio = bounce_clone_bio(bio_orig);
 
 	/*
 	 * Bvec table can't be updated by bio_for_each_segment_all(),
@@ -254,7 +254,7 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
 		to->bv_page = bounce_page;
 	}
 
-	trace_block_bio_bounce(*bio_orig);
+	trace_block_bio_bounce(bio_orig);
 
 	bio->bi_flags |= (1 << BIO_BOUNCED);
 
@@ -263,6 +263,6 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
 	else
 		bio->bi_end_io = bounce_end_io_write;
 
-	bio->bi_private = *bio_orig;
-	*bio_orig = bio;
+	bio->bi_private = bio_orig;
+	return bio;
 }
-- 
2.30.2

