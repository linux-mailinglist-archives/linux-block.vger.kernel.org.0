Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D41E947E0F
	for <lists+linux-block@lfdr.de>; Mon, 17 Jun 2019 11:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfFQJO3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 17 Jun 2019 05:14:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40780 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfFQJO3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jun 2019 05:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sVAaWC1sMW3m9jGCKdBqNVJHQhhpQEvqVlj11bIKwLQ=; b=gf5WW9lqL8NuxORmCKVuSLLF9x
        R740jsB/a7SOd1+J/qCkLXki6upws85a4UOFHFOP433cmionUTRrGX9YE06PVXVyDTxcWpQgB9auC
        kxK6/Ry+UNMF2VDhIaE9dcbglCFKdXfi7eM6jgFebcXzOmpm4qayYbt2heIC1OzyCRCzc0s/5eBR4
        /74uWwYdGHsdtSeb6a0MeT2vqdLE6MCJqaIiJoy7cf1NGtRMCbosE+L7K5yIAo67yrTX7W2sULiwY
        Pw1G9qJ7BQzNPS+1ILykn9kEbMPfC9/kxooYxc0rewqmwSWMKne2yXLAxiDcVzZPPSbu2ZBH98y7Z
        tkJbTugw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcniV-0005CS-4K; Mon, 17 Jun 2019 09:14:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 1/2] block: return from __bio_try_merge_page if merging occured in the same page
Date:   Mon, 17 Jun 2019 11:14:11 +0200
Message-Id: <20190617091412.15923-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617091412.15923-1-hch@lst.de>
References: <20190617091412.15923-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We currently have an input same_page parameter to __bio_try_merge_page
to prohibit merging in the same page.  The rationale for that is that
some callers need to account for every page added to a bio.  Instead of
letting these callers call twice into the merge code to account for the
new vs existing page cases, just turn the paramter into an output one that
returns if a merge in the same page occured and let them act accordingly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c         | 26 +++++++++++---------------
 fs/iomap.c          | 12 ++++++++----
 fs/xfs/xfs_aops.c   | 11 ++++++++---
 include/linux/bio.h |  2 +-
 4 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 683cbb40f051..daa1c1ae72cd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -636,7 +636,7 @@ EXPORT_SYMBOL(bio_clone_fast);
 
 static inline bool page_is_mergeable(const struct bio_vec *bv,
 		struct page *page, unsigned int len, unsigned int off,
-		bool same_page)
+		bool *same_page)
 {
 	phys_addr_t vec_end_addr = page_to_phys(bv->bv_page) +
 		bv->bv_offset + bv->bv_len - 1;
@@ -647,15 +647,9 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
 		return false;
 
-	if ((vec_end_addr & PAGE_MASK) != page_addr) {
-		if (same_page)
-			return false;
-		if (pfn_to_page(PFN_DOWN(vec_end_addr)) + 1 != page)
-			return false;
-	}
-
-	WARN_ON_ONCE(same_page && (len + off) > PAGE_SIZE);
-
+	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
+	if (!*same_page && pfn_to_page(PFN_DOWN(vec_end_addr)) + 1 != page)
+		return false;
 	return true;
 }
 
@@ -701,6 +695,7 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		bool put_same_page)
 {
 	struct bio_vec *bvec;
+	bool same_page = false;
 
 	/*
 	 * cloned bio must not modify vec list
@@ -729,7 +724,7 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		if (bvec_gap_to_prev(q, bvec, offset))
 			return 0;
 
-		if (page_is_mergeable(bvec, page, len, offset, false) &&
+		if (page_is_mergeable(bvec, page, len, offset, &same_page) &&
 		    can_add_page_to_seg(q, bvec, page, len, offset)) {
 			bvec->bv_len += len;
 			goto done;
@@ -767,8 +762,7 @@ EXPORT_SYMBOL(bio_add_pc_page);
  * @page: start page to add
  * @len: length of the data to add
  * @off: offset of the data relative to @page
- * @same_page: if %true only merge if the new data is in the same physical
- *		page as the last segment of the bio.
+ * @same_page: return if the segment has been merged inside the same page
  *
  * Try to add the data at @page + @off to the last bvec of @bio.  This is a
  * a useful optimisation for file systems with a block size smaller than the
@@ -779,7 +773,7 @@ EXPORT_SYMBOL(bio_add_pc_page);
  * Return %true on success or %false on failure.
  */
 bool __bio_try_merge_page(struct bio *bio, struct page *page,
-		unsigned int len, unsigned int off, bool same_page)
+		unsigned int len, unsigned int off, bool *same_page)
 {
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return false;
@@ -837,7 +831,9 @@ EXPORT_SYMBOL_GPL(__bio_add_page);
 int bio_add_page(struct bio *bio, struct page *page,
 		 unsigned int len, unsigned int offset)
 {
-	if (!__bio_try_merge_page(bio, page, len, offset, false)) {
+	bool same_page = false;
+
+	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
 		if (bio_full(bio))
 			return 0;
 		__bio_add_page(bio, page, len, offset);
diff --git a/fs/iomap.c b/fs/iomap.c
index 23ef63fd1669..12654c2e78f8 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -287,7 +287,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	struct iomap_readpage_ctx *ctx = data;
 	struct page *page = ctx->cur_page;
 	struct iomap_page *iop = iomap_page_create(inode, page);
-	bool is_contig = false;
+	bool same_page = false, is_contig = false;
 	loff_t orig_pos = pos;
 	unsigned poff, plen;
 	sector_t sector;
@@ -315,10 +315,14 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	 * Try to merge into a previous segment if we can.
 	 */
 	sector = iomap_sector(iomap, pos);
-	if (ctx->bio && bio_end_sector(ctx->bio) == sector) {
-		if (__bio_try_merge_page(ctx->bio, page, plen, poff, true))
-			goto done;
+	if (ctx->bio && bio_end_sector(ctx->bio) == sector)
 		is_contig = true;
+
+	if (is_contig &&
+	    __bio_try_merge_page(ctx->bio, page, plen, poff, &same_page)) {
+		if (!same_page && iop)
+			atomic_inc(&iop->read_count);
+		goto done;
 	}
 
 	/*
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index a6f0f4761a37..8da5e6637771 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -758,6 +758,7 @@ xfs_add_to_ioend(
 	struct block_device	*bdev = xfs_find_bdev_for_inode(inode);
 	unsigned		len = i_blocksize(inode);
 	unsigned		poff = offset & (PAGE_SIZE - 1);
+	bool			merged, same_page = false;
 	sector_t		sector;
 
 	sector = xfs_fsb_to_db(ip, wpc->imap.br_startblock) +
@@ -774,9 +775,13 @@ xfs_add_to_ioend(
 				wpc->imap.br_state, offset, bdev, sector);
 	}
 
-	if (!__bio_try_merge_page(wpc->ioend->io_bio, page, len, poff, true)) {
-		if (iop)
-			atomic_inc(&iop->write_count);
+	merged = __bio_try_merge_page(wpc->ioend->io_bio, page, len, poff,
+			&same_page);
+
+	if (iop && !same_page)
+		atomic_inc(&iop->write_count);
+
+	if (!merged) {
 		if (bio_full(wpc->ioend->io_bio))
 			xfs_chain_bio(wpc->ioend, wbc, bdev, sector);
 		bio_add_page(wpc->ioend->io_bio, page, len, poff);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 0f23b5682640..f87abaa898f0 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -423,7 +423,7 @@ extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
 bool __bio_try_merge_page(struct bio *bio, struct page *page,
-		unsigned int len, unsigned int off, bool same_page);
+		unsigned int len, unsigned int off, bool *same_page);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
-- 
2.20.1

