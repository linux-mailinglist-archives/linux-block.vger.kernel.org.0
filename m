Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D372B8A27E
	for <lists+linux-block@lfdr.de>; Mon, 12 Aug 2019 17:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfHLPkH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 12 Aug 2019 11:40:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfHLPkH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 11:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wwZirZR1UsujPzMr43Bi0rQicvmClE8+cKYWoCIYAfk=; b=SmDbVYjuYU0q7tIk0q2YrZbQSB
        DqrpMT5NVsLiUsk4mYZKe6B6K/SV7AVrhE+GfPBtAXCacC1EPAxQvd/h/mcOOK7w0ACbwc6VjMEFN
        TmH2t83jmPlvpkPkf2gQJPKvHdknwHRx6hsBOu6fL5GrTpKeUH6II9Cvka4WU/flvOslcsOJ2wpE0
        aSoEFBFWUrKcXWrWG1frrHrMOmhHQFGux7g3oaqcg8DTeOqZA2bTCs0id+HtkqWuYw76/0oibNm7v
        hKLqf2qxjxSMylDbvHuVXTiTqP08sLM9xezoNIC4SRuYV31tR71HfHl486NsQhoiLfIYcI7Bs2boW
        x8/xhQAA==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxCQZ-0002zi-0E; Mon, 12 Aug 2019 15:40:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: create a bio_try_merge_pc_page helper
Date:   Mon, 12 Aug 2019 17:39:57 +0200
Message-Id: <20190812153958.29560-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812153958.29560-1-hch@lst.de>
References: <20190812153958.29560-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Passsthrough bio handling should be the same as normal bio handling,
except that we need to take hardware limitations into account.  Thus
use the common try_merge implementation after checking the hardware
limits.  This changes behavior in that we now also check segment
and dma boundary settings for same page merges, which is a little
more work but has no effect as those need to be larger than the
page size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 9f80bf4531b3..6ea4b9257667 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -646,25 +646,20 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 	return true;
 }
 
-/*
- * Check if the @page can be added to the current segment(@bv), and make
- * sure to call it only if page_is_mergeable(@bv, @page) is true
- */
-static bool can_add_page_to_seg(struct request_queue *q,
-		struct bio_vec *bv, struct page *page, unsigned len,
-		unsigned offset)
+static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
+		struct page *page, unsigned len, unsigned offset,
+		bool *same_page)
 {
+	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 	unsigned long mask = queue_segment_boundary(q);
 	phys_addr_t addr1 = page_to_phys(bv->bv_page) + bv->bv_offset;
 	phys_addr_t addr2 = page_to_phys(page) + offset + len - 1;
 
 	if ((addr1 | mask) != (addr2 | mask))
 		return false;
-
 	if (bv->bv_len + len > queue_max_segment_size(q))
 		return false;
-
-	return true;
+	return __bio_try_merge_page(bio, page, len, offset, same_page);
 }
 
 /**
@@ -700,26 +695,18 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		return 0;
 
 	if (bio->bi_vcnt > 0) {
-		bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];
-
-		if (page == bvec->bv_page &&
-		    offset == bvec->bv_offset + bvec->bv_len) {
-			if (put_same_page)
+		if (bio_try_merge_pc_page(q, bio, page, len, offset,
+				&same_page)) {
+			if (put_same_page && same_page)
 				put_page(page);
-			bvec->bv_len += len;
-			goto done;
-		}
-
-		if (page_is_mergeable(bvec, page, len, offset, &same_page) &&
-		    can_add_page_to_seg(q, bvec, page, len, offset)) {
-			bvec->bv_len += len;
-			goto done;
+			return len;
 		}
 
 		/*
 		 * If the queue doesn't support SG gaps and adding this segment
 		 * would create a gap, disallow it.
 		 */
+		bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];
 		if (bvec_gap_to_prev(q, bvec, offset))
 			return 0;
 	}
@@ -735,7 +722,6 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 	bvec->bv_len = len;
 	bvec->bv_offset = offset;
 	bio->bi_vcnt++;
- done:
 	bio->bi_iter.bi_size += len;
 	return len;
 }
-- 
2.20.1

