Return-Path: <linux-block+bounces-23204-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6742FAE8193
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 13:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE773AF38D
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 11:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6427525F99F;
	Wed, 25 Jun 2025 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VOEQcpC/"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54C125FA0B
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851342; cv=none; b=vFqb4DG8XdZxs+GkxcKKFY8DKGIjsYBkOp7dn/L6vzJfwMLVL/jzHDPdj1YTd79Q54EX7n8b/XHTTZEWZ+vNjSuy+pc53jiSxXGEJfuwGYG/K/hgMEgTVME9M/3OKCFNQMilD5KRw0dDuJWdduErNMu62nLcVR4AET5Q0gc2vDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851342; c=relaxed/simple;
	bh=ib2vvNQTbtFvz39C3/EtQAyn/YHK324DZg2w4EubxlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+6XC6cBh0775IhJFRlbHt2SkPmR+c5D7V7nLqR7JiIq6omJ9p4TW03to77raekUqAtFiUeXwT6qPCtmgBryFSrf1EJBRHVlzhau39uJbMG93rDKgyGHInor6dDtN283WDOBIjB5hOmc08PraULJ7qNg1sw+pAC3L8JY8HkOD6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VOEQcpC/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xUlg5GSwWCDpOjRXei/a9Z8ul60ODMnMWC1XwV5mG+A=; b=VOEQcpC/22zyCQIi3ezYIssAnL
	pKCH1tZh3tOke9RCZvHwKN9Pt31p8ArVCHuuE6q0S2+la9EnfNpa/NoswaIpq4oWSgDAmN/9lDmbR
	WAUbjfFxHDh2w+9cXxTPmKw26iPMOnl6Xfnu/nASZKKYWFcCY9taOLXSO5TaG2qxUkvjltF2hq4x/
	dy6H/GcYgKdR/BHnetNZS831a3YhHItxnJk4mZCxbzxHBYH+uQu0+KkvXyxGXVIA+aTXsSwbz3dtO
	byJeaECKj68IobnH56oAsPLeh3rpQzUEVO6RvxGBqyFvjc4rjqe8kvFFZheN9d/96RcEvIBt4Qn/J
	3DtcRRZw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOPh-00000008UyF-0rJO;
	Wed, 25 Jun 2025 11:35:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH 1/8] block: don't merge different kinds of P2P transfers in a single bio
Date: Wed, 25 Jun 2025 13:34:58 +0200
Message-ID: <20250625113531.522027-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250625113531.522027-1-hch@lst.de>
References: <20250625113531.522027-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

To get out of the DMA mapping helpers having to check every segment for
it's P2P status, ensure that bios either contain P2P transfers or non-P2P
transfers, and that a P2P bio only contains ranges from a single device.

This means we do the page zone access in the bio add path where it should
be still page hot, and will only have do the fairly expensive P2P topology
lookup once per bio down in the DMA mapping path, and only for already
marked bios.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/bio-integrity.c     |  3 +++
 block/bio.c               | 20 +++++++++++++-------
 include/linux/blk_types.h |  2 ++
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 10912988c8f5..6b077ca937f6 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -128,6 +128,9 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 	if (bip->bip_vcnt > 0) {
 		struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];
 
+		if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
+			return 0;
+
 		if (bvec_try_merge_hw_page(q, bv, page, len, offset)) {
 			bip->bip_iter.bi_size += len;
 			return len;
diff --git a/block/bio.c b/block/bio.c
index 3c0a558c90f5..92c512e876c8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -930,8 +930,6 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
 		return false;
 	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
 		return false;
-	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
-		return false;
 
 	if ((vec_end_addr & PAGE_MASK) != ((page_addr + off) & PAGE_MASK)) {
 		if (IS_ENABLED(CONFIG_KMSAN))
@@ -982,6 +980,9 @@ void __bio_add_page(struct bio *bio, struct page *page,
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
 	WARN_ON_ONCE(bio_full(bio, len));
 
+	if (is_pci_p2pdma_page(page))
+		bio->bi_opf |= REQ_P2PDMA | REQ_NOMERGE;
+
 	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, off);
 	bio->bi_iter.bi_size += len;
 	bio->bi_vcnt++;
@@ -1022,11 +1023,16 @@ int bio_add_page(struct bio *bio, struct page *page,
 	if (bio->bi_iter.bi_size > UINT_MAX - len)
 		return 0;
 
-	if (bio->bi_vcnt > 0 &&
-	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
-				page, len, offset)) {
-		bio->bi_iter.bi_size += len;
-		return len;
+	if (bio->bi_vcnt > 0) {
+		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+
+		if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
+			return 0;
+
+		if (bvec_try_merge_page(bv, page, len, offset)) {
+			bio->bi_iter.bi_size += len;
+			return len;
+		}
 	}
 
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3d1577f07c1c..2a02972dc17c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -386,6 +386,7 @@ enum req_flag_bits {
 	__REQ_DRV,		/* for driver use */
 	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 	__REQ_ATOMIC,		/* for atomic write operations */
+	__REQ_P2PDMA,		/* contains P2P DMA pages */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -418,6 +419,7 @@ enum req_flag_bits {
 #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
+#define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
 
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
 
-- 
2.47.2


