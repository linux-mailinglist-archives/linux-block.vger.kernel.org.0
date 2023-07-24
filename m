Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8C075FCA8
	for <lists+linux-block@lfdr.de>; Mon, 24 Jul 2023 18:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjGXQyj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Jul 2023 12:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGXQyh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 12:54:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A6310F4
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jxj6RABkTFnEGOc2Iav3sSoTjFYz8cIIVXLuIca+dqc=; b=ed5kr1AfAQZgzGovJopAlUOnsr
        Qpcfez44A2faZvauFx9TqU8YFBrqu1FYIchBTmPZz1eEWtBmXqyxUt2uk75OYPu5rUF00EVAvdRoZ
        imqJMtihIp4SyvoWmZXjsL8AEpwNgxk0QdH4umBYfjWJ+9Nihr2KCMwRB0HZrZ92BTnQk4SDwIfty
        rW3ZsudQ3pofb1ZdIgkutvktzAYy/+4qQF/3t/oYKdyvFdzkZJS7BtfmtmprJQ1whvs1qVxjEQXtv
        srAZ2UleQEwA06J59v9vsVZxdOb8hrbcYj45u+63uqJ4O+Aq8Ug3DgrAUS+6q4MXvQsDSTdttIBAb
        LAe1yjgg==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNypO-004vv3-2b;
        Mon, 24 Jul 2023 16:54:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 7/8] block: move the bi_size update out of __bio_try_merge_page
Date:   Mon, 24 Jul 2023 09:54:32 -0700
Message-Id: <20230724165433.117645-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724165433.117645-1-hch@lst.de>
References: <20230724165433.117645-1-hch@lst.de>
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

The update of bi_size is the only thing in __bio_try_merge_page that
needs a bio.  Move it to the callers, and merge __bio_try_merge_page
and page_is_mergeable into a single bvec_try_merge_page that only takes
the current bvec instead of a full bio.  This will allow reusing this
function for supporting multi-page integrity payload bvecs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio.c | 57 +++++++++++++++++++----------------------------------
 1 file changed, 20 insertions(+), 37 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d8e0e8de8cf4f6..23b7a001b5005d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -903,9 +903,8 @@ static inline bool bio_full(struct bio *bio, unsigned len)
 	return false;
 }
 
-static inline bool page_is_mergeable(const struct bio_vec *bv,
-		struct page *page, unsigned int len, unsigned int off,
-		bool *same_page)
+static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
+		unsigned int len, unsigned int off, bool *same_page)
 {
 	size_t bv_end = bv->bv_offset + bv->bv_len;
 	phys_addr_t vec_end_addr = page_to_phys(bv->bv_page) + bv_end - 1;
@@ -919,38 +918,14 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 		return false;
 
 	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
-	if (*same_page)
-		return true;
-	else if (IS_ENABLED(CONFIG_KMSAN))
-		return false;
-	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);
-}
-
-/**
- * __bio_try_merge_page - try appending data to an existing bvec.
- * @bio: destination bio
- * @page: start page to add
- * @len: length of the data to add
- * @off: offset of the data relative to @page
- * @same_page: return if the segment has been merged inside the same page
- *
- * Try to add the data at @page + @off to the last bvec of @bio.  This is a
- * useful optimisation for file systems with a block size smaller than the
- * page size.
- *
- * Warn if (@len, @off) crosses pages in case that @same_page is true.
- *
- * Return %true on success or %false on failure.
- */
-static bool __bio_try_merge_page(struct bio *bio, struct page *page,
-		unsigned int len, unsigned int off, bool *same_page)
-{
-	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+	if (!*same_page) {
+		if (IS_ENABLED(CONFIG_KMSAN))
+			return false;
+		if (bv->bv_page + bv_end / PAGE_SIZE != page + off / PAGE_SIZE)
+			return false;
+	}
 
-	if (!page_is_mergeable(bv, page, len, off, same_page))
-		return false;
 	bv->bv_len += len;
-	bio->bi_iter.bi_size += len;
 	return true;
 }
 
@@ -972,7 +947,7 @@ static bool bio_try_merge_hw_seg(struct request_queue *q, struct bio *bio,
 		return false;
 	if (bv->bv_len + len > queue_max_segment_size(q))
 		return false;
-	return __bio_try_merge_page(bio, page, len, offset, same_page);
+	return bvec_try_merge_page(bv, page, len, offset, same_page);
 }
 
 /**
@@ -1001,8 +976,11 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		return 0;
 
 	if (bio->bi_vcnt > 0) {
-		if (bio_try_merge_hw_seg(q, bio, page, len, offset, same_page))
+		if (bio_try_merge_hw_seg(q, bio, page, len, offset,
+				same_page)) {
+			bio->bi_iter.bi_size += len;
 			return len;
+		}
 
 		if (bio->bi_vcnt >=
 		    min(bio->bi_max_vecs, queue_max_segments(q)))
@@ -1123,8 +1101,11 @@ int bio_add_page(struct bio *bio, struct page *page,
 		return 0;
 
 	if (bio->bi_vcnt > 0 &&
-	    __bio_try_merge_page(bio, page, len, offset, &same_page))
+	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
+				page, len, offset, &same_page)) {
+		bio->bi_iter.bi_size += len;
 		return len;
+	}
 
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
 		return 0;
@@ -1206,7 +1187,9 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 		return -EIO;
 
 	if (bio->bi_vcnt > 0 &&
-	    __bio_try_merge_page(bio, page, len, offset, &same_page)) {
+	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
+				page, len, offset, &same_page)) {
+		bio->bi_iter.bi_size += len;
 		if (same_page)
 			bio_release_page(bio, page);
 		return 0;
-- 
2.39.2

