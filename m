Return-Path: <linux-block+bounces-15885-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A35A02080
	for <lists+linux-block@lfdr.de>; Mon,  6 Jan 2025 09:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612393A40F9
	for <lists+linux-block@lfdr.de>; Mon,  6 Jan 2025 08:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B5A1D0E27;
	Mon,  6 Jan 2025 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CFXR0Mvj"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DD91CCEF8
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151375; cv=none; b=Ov1fY8xVjlIM3jn75FpRj50cptSsK4J7Y6j/8vL7szbXVlWN/NuRP9CSaFSVTpybYyEWGsK0keBGWJBzSrvIsGWPfPSQgs7e2zqamHAoTh38kacqrJGYF7T+RCoLbvoCsgKtwDqAOy6fMPjQbqsbTgguyvhYSZeA9f1gc5U7ONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151375; c=relaxed/simple;
	bh=+tC5Tc+P9hK0yvNYdXqTWbpy9SZNDCVxKNsulSy3z/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTwONgxPJsl5PGFxIGPzRFgaTCAGTevWZDF/JemMudYb2KKpyVm+g025gvzv9CcFWLws7kY92JJtrnmuM5GtDfnncXyqbIfstnr8nOp9CUvYAVTWhXcYKMZ2RzmRZaVLvREDcX2xieHWkluR/g11dQ4IxCtZME+doR9g7o0h6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CFXR0Mvj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PqgsFOWKJTB237DD9ivp4jMzbm9laRRfvkrHdD6EdZ4=; b=CFXR0MvjhRu16872Pip+2eOJJb
	b54PBkH2GR12FlIIxlQWQaut+o7vNlsAt9QsKsb+UdQbdxAJxjge96ZeXMiW8d5M936N8XIn+9lxa
	Mz//2/IyD9STUPoY3kZO52diI7WCWBrcDglpx42r11uBWgk6E8EuMiGslEQuTEmcTV0VxVxQgLtjD
	APRshY/N0+1xu/Xdk1wzwGgUz9EPVLynKc+s9bLhPJK2r/YRFX/rS+5VodXLfNUPL6dEa2H7ZKUfk
	J5qUuJHBobpIKPA+YXgIspvmv1WUjgdMvuaiPCI4WC+yCmd3iXfF6zLiKd/HeCYzjd0Cg+DhZW3rH
	YESti3Cw==;
Received: from 2a02-8389-2341-5b80-db6b-99e8-3feb-3b4e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:db6b:99e8:3feb:3b4e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tUiHU-00000000UBd-14N5;
	Mon, 06 Jan 2025 08:16:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: add a dma mapping iterator
Date: Mon,  6 Jan 2025 09:15:29 +0100
Message-ID: <20250106081609.798289-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

blk_rq_map_sg is maze of nested loops.  Untangle it by creating an
iterator that returns [paddr,len] tuples for DMA mapping, and then
implement the DMA logic on top of this.  This not only removes code
at the source level, but also generates nicer binary code:

$ size block/blk-merge.o.*
   text	   data	    bss	    dec	    hex	filename
  10001	    432	      0	  10433	   28c1	block/blk-merge.o.new
  10317	    468	      0	  10785	   2a21	block/blk-merge.o.old

Last but not least it will be used as a building block for a new
DMA mapping helper that doesn't rely on struct scatterlist.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 177 ++++++++++++++++++----------------------------
 1 file changed, 70 insertions(+), 107 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index e01383c6e534..15cd231d560c 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -473,137 +473,100 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 	return nr_phys_segs;
 }
 
-static inline struct scatterlist *blk_next_sg(struct scatterlist **sg,
-		struct scatterlist *sglist)
-{
-	if (!*sg)
-		return sglist;
+struct phys_vec {
+	phys_addr_t	paddr;
+	u32		len;
+};
 
-	/*
-	 * If the driver previously mapped a shorter list, we could see a
-	 * termination bit prematurely unless it fully inits the sg table
-	 * on each mapping. We KNOW that there must be more entries here
-	 * or the driver would be buggy, so force clear the termination bit
-	 * to avoid doing a full sg_init_table() in drivers for each command.
-	 */
-	sg_unmark_end(*sg);
-	return sg_next(*sg);
-}
-
-static unsigned blk_bvec_map_sg(struct request_queue *q,
-		struct bio_vec *bvec, struct scatterlist *sglist,
-		struct scatterlist **sg)
+static bool blk_map_iter_next(struct request *req,
+		struct req_iterator *iter, struct phys_vec *vec)
 {
-	unsigned nbytes = bvec->bv_len;
-	unsigned nsegs = 0, total = 0;
-
-	while (nbytes > 0) {
-		unsigned offset = bvec->bv_offset + total;
-		unsigned len = get_max_segment_size(&q->limits,
-				bvec_phys(bvec) + total, nbytes);
-		struct page *page = bvec->bv_page;
-
-		/*
-		 * Unfortunately a fair number of drivers barf on scatterlists
-		 * that have an offset larger than PAGE_SIZE, despite other
-		 * subsystems dealing with that invariant just fine.  For now
-		 * stick to the legacy format where we never present those from
-		 * the block layer, but the code below should be removed once
-		 * these offenders (mostly MMC/SD drivers) are fixed.
-		 */
-		page += (offset >> PAGE_SHIFT);
-		offset &= ~PAGE_MASK;
-
-		*sg = blk_next_sg(sg, sglist);
-		sg_set_page(*sg, page, len, offset);
+	unsigned int max_size;
+	struct bio_vec bv;
 
-		total += len;
-		nbytes -= len;
-		nsegs++;
+	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
+		if (!iter->bio)
+			return false;
+		vec->paddr = bvec_phys(&req->special_vec);
+		vec->len = req->special_vec.bv_len;
+		iter->bio = NULL;
+		return true;
 	}
 
-	return nsegs;
-}
-
-static inline int __blk_bvec_map_sg(struct bio_vec bv,
-		struct scatterlist *sglist, struct scatterlist **sg)
-{
-	*sg = blk_next_sg(sg, sglist);
-	sg_set_page(*sg, bv.bv_page, bv.bv_len, bv.bv_offset);
-	return 1;
-}
-
-/* only try to merge bvecs into one sg if they are from two bios */
-static inline bool
-__blk_segment_map_sg_merge(struct request_queue *q, struct bio_vec *bvec,
-			   struct bio_vec *bvprv, struct scatterlist **sg)
-{
-
-	int nbytes = bvec->bv_len;
-
-	if (!*sg)
+	if (!iter->iter.bi_size)
 		return false;
 
-	if ((*sg)->length + nbytes > queue_max_segment_size(q))
-		return false;
+	bv = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+	vec->paddr = bvec_phys(&bv);
+	max_size = get_max_segment_size(&req->q->limits, vec->paddr, UINT_MAX);
+	bv.bv_len = min(bv.bv_len, max_size);
+	bio_advance_iter_single(iter->bio, &iter->iter, bv.bv_len);
 
-	if (!biovec_phys_mergeable(q, bvprv, bvec))
-		return false;
+	/*
+	 * If we are entirely done with this bi_io_vec entry, check if the next
+	 * one could be merged into it.  This typically happens when moving to
+	 * the next bio, but some callers also don't pack bvecs tight.
+	 */
+	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
+		struct bio_vec next;
+
+		if (!iter->iter.bi_size) {
+			if (!iter->bio->bi_next)
+				break;
+			iter->bio = iter->bio->bi_next;
+			iter->iter = iter->bio->bi_iter;
+		}
 
-	(*sg)->length += nbytes;
+		next = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+		if (bv.bv_len + next.bv_len > max_size ||
+		    !biovec_phys_mergeable(req->q, &bv, &next))
+			break;
+
+		bv.bv_len += next.bv_len;
+		bio_advance_iter_single(iter->bio, &iter->iter, next.bv_len);
+	}
 
+	vec->len = bv.bv_len;
 	return true;
 }
 
-static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
-			     struct scatterlist *sglist,
-			     struct scatterlist **sg)
+static inline struct scatterlist *blk_next_sg(struct scatterlist **sg,
+		struct scatterlist *sglist)
 {
-	struct bio_vec bvec, bvprv = { NULL };
-	struct bvec_iter iter;
-	int nsegs = 0;
-	bool new_bio = false;
-
-	for_each_bio(bio) {
-		bio_for_each_bvec(bvec, bio, iter) {
-			/*
-			 * Only try to merge bvecs from two bios given we
-			 * have done bio internal merge when adding pages
-			 * to bio
-			 */
-			if (new_bio &&
-			    __blk_segment_map_sg_merge(q, &bvec, &bvprv, sg))
-				goto next_bvec;
-
-			if (bvec.bv_offset + bvec.bv_len <= PAGE_SIZE)
-				nsegs += __blk_bvec_map_sg(bvec, sglist, sg);
-			else
-				nsegs += blk_bvec_map_sg(q, &bvec, sglist, sg);
- next_bvec:
-			new_bio = false;
-		}
-		if (likely(bio->bi_iter.bi_size)) {
-			bvprv = bvec;
-			new_bio = true;
-		}
-	}
+	if (!*sg)
+		return sglist;
 
-	return nsegs;
+	/*
+	 * If the driver previously mapped a shorter list, we could see a
+	 * termination bit prematurely unless it fully inits the sg table
+	 * on each mapping. We KNOW that there must be more entries here
+	 * or the driver would be buggy, so force clear the termination bit
+	 * to avoid doing a full sg_init_table() in drivers for each command.
+	 */
+	sg_unmark_end(*sg);
+	return sg_next(*sg);
 }
 
 /*
- * map a request to scatterlist, return number of sg entries setup. Caller
- * must make sure sg can hold rq->nr_phys_segments entries
+ * Map a request to scatterlist, return number of sg entries setup. Caller
+ * must make sure sg can hold rq->nr_phys_segments entries.
  */
 int __blk_rq_map_sg(struct request_queue *q, struct request *rq,
 		struct scatterlist *sglist, struct scatterlist **last_sg)
 {
+	struct req_iterator iter = {
+		.bio	= rq->bio,
+		.iter	= rq->bio->bi_iter,
+	};
+	struct phys_vec vec;
 	int nsegs = 0;
 
-	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
-		nsegs = __blk_bvec_map_sg(rq->special_vec, sglist, last_sg);
-	else if (rq->bio)
-		nsegs = __blk_bios_map_sg(q, rq->bio, sglist, last_sg);
+	while (blk_map_iter_next(rq, &iter, &vec)) {
+		*last_sg = blk_next_sg(last_sg, sglist);
+		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
+				offset_in_page(vec.paddr));
+		nsegs++;
+	}
 
 	if (*last_sg)
 		sg_mark_end(*last_sg);
-- 
2.45.2


