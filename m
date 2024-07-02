Return-Path: <linux-block+bounces-9655-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 680549241F6
	for <lists+linux-block@lfdr.de>; Tue,  2 Jul 2024 17:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C80B1C20CB0
	for <lists+linux-block@lfdr.de>; Tue,  2 Jul 2024 15:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D884071B51;
	Tue,  2 Jul 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yU0t26U7"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564D91DFFC
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933055; cv=none; b=EtOMFgTMMW77chab4dxLSJpLjZV0ZrbTzpyUkh+YsRAH9IqD94eXLRzcUMj7dBHMS1WJnYptxMU0L27ef2Q/5OJzMx69+PwPt3WZy1Eu68OfAfMSyxPAAt+RC+ij6GPakkUTVSDHPfNl4tw38r33xJjv8oRkja/7pMb7nwyfwlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933055; c=relaxed/simple;
	bh=e5VS8zSf15PDrnJHNZNh+0jCSDDOOaKcfd2K0UcDqY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHKtZ1adWh7TtzubhStWyC6uIz6zMkoCsY0nDsiYWj96yBSkxFxdJ9Eo5DVcTGZnOsVWCPzFpKdMJRQubIHE10PCF4d7JTvsW0zUkpgi3tG7tV5PEYQIspkNHxy2uPt5hmFmfG5+FXXAGMZnhqm1z8QwGBOzqNXsQW/+QmnKrRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yU0t26U7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2c2b2ppIq9h2U710pgvb9Zx5HsoY970Tsy5/d8QZ+dI=; b=yU0t26U7abUhxcDAyAtcVF8xrl
	Rgf2359BZSnuVjxLEKVHOLuAKGKRAg4xpdwbxNYirE/liebIB/dgGwvc/iHOzPvoP/w09jq+395IB
	AxXvjuwXsFlr/ueMsdfXw2kSBpOatzAt5seq7XedHb0l/090zJluwNkURr/SsyPenyTa7H1WYn46J
	6DVgnDjI7P5emhEjcfiuFMTzmjYZR1bFVrQuKox8mORDYZxtkoWMN/Vw0OyDjcC/crW2OqW0u08Bs
	qp/LA1loftiehTkISwqTsb6RXQmBvdFVmNbcXHojPfkKStbAIwuFsb1WKUxu6oUcqMSTunHR9ITxn
	Cgha0N7Q==;
Received: from 2a02-8389-2341-5b80-4c69-cf21-4832-bbca.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4c69:cf21:4832:bbca] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOf9g-000000079Tl-15FA;
	Tue, 02 Jul 2024 15:10:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/6] block: split integrity support out of bio.h
Date: Tue,  2 Jul 2024 17:10:19 +0200
Message-ID: <20240702151047.1746127-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702151047.1746127-1-hch@lst.de>
References: <20240702151047.1746127-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Split struct bio_integrity_payload and the related prototypes out of
bio.h into a separate bio-integrity.h header so that it is only pulled
in by the few places that need it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/bio.c                   |   2 +-
 block/blk.h                   |   1 +
 block/bounce.c                |   2 +-
 drivers/md/dm.c               |   1 +
 drivers/nvme/host/ioctl.c     |   1 +
 drivers/scsi/sd.c             |   3 +-
 include/linux/bio-integrity.h | 153 +++++++++++++++++++++++++++++++++
 include/linux/bio.h           | 156 ----------------------------------
 include/linux/blk-integrity.h |   1 +
 9 files changed, 161 insertions(+), 159 deletions(-)
 create mode 100644 include/linux/bio-integrity.h

diff --git a/block/bio.c b/block/bio.c
index e9e809a63c5975..4ca3f31ce45fb5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -4,7 +4,7 @@
  */
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/bio.h>
+#include <linux/bio-integrity.h>
 #include <linux/blkdev.h>
 #include <linux/uio.h>
 #include <linux/iocontext.h>
diff --git a/block/blk.h b/block/blk.h
index 47dadd2439b1ca..401e604f35d2cf 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -2,6 +2,7 @@
 #ifndef BLK_INTERNAL_H
 #define BLK_INTERNAL_H
 
+#include <linux/bio-integrity.h>
 #include <linux/blk-crypto.h>
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
 #include <linux/sched/sysctl.h>
diff --git a/block/bounce.c b/block/bounce.c
index d6a5219f29dd53..0d898cd5ec497f 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -10,7 +10,7 @@
 #include <linux/export.h>
 #include <linux/swap.h>
 #include <linux/gfp.h>
-#include <linux/bio.h>
+#include <linux/bio-integrity.h>
 #include <linux/pagemap.h>
 #include <linux/mempool.h>
 #include <linux/blkdev.h>
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 7d107ae06e1ae1..92d6eeb0a59327 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -11,6 +11,7 @@
 #include "dm-uevent.h"
 #include "dm-ima.h"
 
+#include <linux/bio-integrity.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 8b69427a44762a..fb46f55f8b2894 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  * Copyright (c) 2017-2021 Christoph Hellwig.
  */
+#include <linux/bio-integrity.h>
 #include <linux/ptrace.h>	/* for force_successful_syscall_return */
 #include <linux/nvme_ioctl.h>
 #include <linux/io_uring/cmd.h>
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 933074f8af4e96..f0f4fd7f20024a 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -33,11 +33,12 @@
  *	than the level indicated above to trigger output.	
  */
 
+#include <linux/bio-integrity.h>
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
-#include <linux/bio.h>
+#include <linux/bio-integrity.h>
 #include <linux/hdreg.h>
 #include <linux/errno.h>
 #include <linux/idr.h>
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
new file mode 100644
index 00000000000000..70ef19a0dc7e8b
--- /dev/null
+++ b/include/linux/bio-integrity.h
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_BIO_INTEGRITY_H
+#define _LINUX_BIO_INTEGRITY_H
+
+#include <linux/bio.h>
+
+enum bip_flags {
+	BIP_BLOCK_INTEGRITY	= 1 << 0, /* block layer owns integrity data */
+	BIP_MAPPED_INTEGRITY	= 1 << 1, /* ref tag has been remapped */
+	BIP_CTRL_NOCHECK	= 1 << 2, /* disable HBA integrity checking */
+	BIP_DISK_NOCHECK	= 1 << 3, /* disable disk integrity checking */
+	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
+	BIP_INTEGRITY_USER	= 1 << 5, /* Integrity payload is user address */
+	BIP_COPY_USER		= 1 << 6, /* Kernel bounce buffer in use */
+};
+
+struct bio_integrity_payload {
+	struct bio		*bip_bio;	/* parent bio */
+
+	struct bvec_iter	bip_iter;
+
+	unsigned short		bip_vcnt;	/* # of integrity bio_vecs */
+	unsigned short		bip_max_vcnt;	/* integrity bio_vec slots */
+	unsigned short		bip_flags;	/* control flags */
+
+	struct bvec_iter	bio_iter;	/* for rewinding parent bio */
+
+	struct work_struct	bip_work;	/* I/O completion */
+
+	struct bio_vec		*bip_vec;
+	struct bio_vec		bip_inline_vecs[];/* embedded bvec array */
+};
+
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+
+#define bip_for_each_vec(bvl, bip, iter)				\
+	for_each_bvec(bvl, (bip)->bip_vec, iter, (bip)->bip_iter)
+
+#define bio_for_each_integrity_vec(_bvl, _bio, _iter)			\
+	for_each_bio(_bio)						\
+		bip_for_each_vec(_bvl, _bio->bi_integrity, _iter)
+
+static inline struct bio_integrity_payload *bio_integrity(struct bio *bio)
+{
+	if (bio->bi_opf & REQ_INTEGRITY)
+		return bio->bi_integrity;
+
+	return NULL;
+}
+
+static inline bool bio_integrity_flagged(struct bio *bio, enum bip_flags flag)
+{
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+
+	if (bip)
+		return bip->bip_flags & flag;
+
+	return false;
+}
+
+static inline sector_t bip_get_seed(struct bio_integrity_payload *bip)
+{
+	return bip->bip_iter.bi_sector;
+}
+
+static inline void bip_set_seed(struct bio_integrity_payload *bip,
+				sector_t seed)
+{
+	bip->bip_iter.bi_sector = seed;
+}
+
+struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio, gfp_t gfp,
+		unsigned int nr);
+int bio_integrity_add_page(struct bio *bio, struct page *page, unsigned int len,
+		unsigned int offset);
+int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t len, u32 seed);
+void bio_integrity_unmap_free_user(struct bio *bio);
+bool bio_integrity_prep(struct bio *bio);
+void bio_integrity_advance(struct bio *bio, unsigned int bytes_done);
+void bio_integrity_trim(struct bio *bio);
+int bio_integrity_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp_mask);
+int bioset_integrity_create(struct bio_set *bs, int pool_size);
+void bioset_integrity_free(struct bio_set *bs);
+void bio_integrity_init(void);
+
+#else /* CONFIG_BLK_DEV_INTEGRITY */
+
+static inline void *bio_integrity(struct bio *bio)
+{
+	return NULL;
+}
+
+static inline int bioset_integrity_create(struct bio_set *bs, int pool_size)
+{
+	return 0;
+}
+
+static inline void bioset_integrity_free(struct bio_set *bs)
+{
+}
+
+static inline int bio_integrity_map_user(struct bio *bio, void __user *ubuf,
+					 ssize_t len, u32 seed)
+{
+	return -EINVAL;
+}
+
+static inline void bio_integrity_unmap_free_user(struct bio *bio)
+{
+}
+
+static inline bool bio_integrity_prep(struct bio *bio)
+{
+	return true;
+}
+
+static inline int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
+		gfp_t gfp_mask)
+{
+	return 0;
+}
+
+static inline void bio_integrity_advance(struct bio *bio,
+		unsigned int bytes_done)
+{
+}
+
+static inline void bio_integrity_trim(struct bio *bio)
+{
+}
+
+static inline void bio_integrity_init(void)
+{
+}
+
+static inline bool bio_integrity_flagged(struct bio *bio, enum bip_flags flag)
+{
+	return false;
+}
+
+static inline void *bio_integrity_alloc(struct bio *bio, gfp_t gfp,
+		unsigned int nr)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
+					unsigned int len, unsigned int offset)
+{
+	return 0;
+}
+#endif /* CONFIG_BLK_DEV_INTEGRITY */
+#endif /* _LINUX_BIO_INTEGRITY_H */
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 818e9361294781..a46e2047bea4d2 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -321,69 +321,6 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
 #define bio_for_each_folio_all(fi, bio)				\
 	for (bio_first_folio(&fi, bio, 0); fi.folio; bio_next_folio(&fi, bio))
 
-enum bip_flags {
-	BIP_BLOCK_INTEGRITY	= 1 << 0, /* block layer owns integrity data */
-	BIP_MAPPED_INTEGRITY	= 1 << 1, /* ref tag has been remapped */
-	BIP_CTRL_NOCHECK	= 1 << 2, /* disable HBA integrity checking */
-	BIP_DISK_NOCHECK	= 1 << 3, /* disable disk integrity checking */
-	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
-	BIP_INTEGRITY_USER	= 1 << 5, /* Integrity payload is user address */
-	BIP_COPY_USER		= 1 << 6, /* Kernel bounce buffer in use */
-};
-
-/*
- * bio integrity payload
- */
-struct bio_integrity_payload {
-	struct bio		*bip_bio;	/* parent bio */
-
-	struct bvec_iter	bip_iter;
-
-	unsigned short		bip_vcnt;	/* # of integrity bio_vecs */
-	unsigned short		bip_max_vcnt;	/* integrity bio_vec slots */
-	unsigned short		bip_flags;	/* control flags */
-
-	struct bvec_iter	bio_iter;	/* for rewinding parent bio */
-
-	struct work_struct	bip_work;	/* I/O completion */
-
-	struct bio_vec		*bip_vec;
-	struct bio_vec		bip_inline_vecs[];/* embedded bvec array */
-};
-
-#if defined(CONFIG_BLK_DEV_INTEGRITY)
-
-static inline struct bio_integrity_payload *bio_integrity(struct bio *bio)
-{
-	if (bio->bi_opf & REQ_INTEGRITY)
-		return bio->bi_integrity;
-
-	return NULL;
-}
-
-static inline bool bio_integrity_flagged(struct bio *bio, enum bip_flags flag)
-{
-	struct bio_integrity_payload *bip = bio_integrity(bio);
-
-	if (bip)
-		return bip->bip_flags & flag;
-
-	return false;
-}
-
-static inline sector_t bip_get_seed(struct bio_integrity_payload *bip)
-{
-	return bip->bip_iter.bi_sector;
-}
-
-static inline void bip_set_seed(struct bio_integrity_payload *bip,
-				sector_t seed)
-{
-	bip->bip_iter.bi_sector = seed;
-}
-
-#endif /* CONFIG_BLK_DEV_INTEGRITY */
-
 void bio_trim(struct bio *bio, sector_t offset, sector_t size);
 extern struct bio *bio_split(struct bio *bio, int sectors,
 			     gfp_t gfp, struct bio_set *bs);
@@ -721,99 +658,6 @@ static inline bool bioset_initialized(struct bio_set *bs)
 	return bs->bio_slab != NULL;
 }
 
-#if defined(CONFIG_BLK_DEV_INTEGRITY)
-
-#define bip_for_each_vec(bvl, bip, iter)				\
-	for_each_bvec(bvl, (bip)->bip_vec, iter, (bip)->bip_iter)
-
-#define bio_for_each_integrity_vec(_bvl, _bio, _iter)			\
-	for_each_bio(_bio)						\
-		bip_for_each_vec(_bvl, _bio->bi_integrity, _iter)
-
-int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t len, u32 seed);
-void bio_integrity_unmap_free_user(struct bio *bio);
-extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, gfp_t, unsigned int);
-extern int bio_integrity_add_page(struct bio *, struct page *, unsigned int, unsigned int);
-extern bool bio_integrity_prep(struct bio *);
-extern void bio_integrity_advance(struct bio *, unsigned int);
-extern void bio_integrity_trim(struct bio *);
-extern int bio_integrity_clone(struct bio *, struct bio *, gfp_t);
-extern int bioset_integrity_create(struct bio_set *, int);
-extern void bioset_integrity_free(struct bio_set *);
-extern void bio_integrity_init(void);
-
-#else /* CONFIG_BLK_DEV_INTEGRITY */
-
-static inline void *bio_integrity(struct bio *bio)
-{
-	return NULL;
-}
-
-static inline int bioset_integrity_create(struct bio_set *bs, int pool_size)
-{
-	return 0;
-}
-
-static inline void bioset_integrity_free (struct bio_set *bs)
-{
-	return;
-}
-
-static inline bool bio_integrity_prep(struct bio *bio)
-{
-	return true;
-}
-
-static inline int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
-				      gfp_t gfp_mask)
-{
-	return 0;
-}
-
-static inline void bio_integrity_advance(struct bio *bio,
-					 unsigned int bytes_done)
-{
-	return;
-}
-
-static inline void bio_integrity_trim(struct bio *bio)
-{
-	return;
-}
-
-static inline void bio_integrity_init(void)
-{
-	return;
-}
-
-static inline bool bio_integrity_flagged(struct bio *bio, enum bip_flags flag)
-{
-	return false;
-}
-
-static inline void *bio_integrity_alloc(struct bio * bio, gfp_t gfp,
-								unsigned int nr)
-{
-	return ERR_PTR(-EINVAL);
-}
-
-static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
-					unsigned int len, unsigned int offset)
-{
-	return 0;
-}
-
-static inline int bio_integrity_map_user(struct bio *bio, void __user *ubuf,
-					 ssize_t len, u32 seed)
-{
-	return -EINVAL;
-}
-static inline void bio_integrity_unmap_free_user(struct bio *bio)
-{
-}
-
-#endif /* CONFIG_BLK_DEV_INTEGRITY */
-
 /*
  * Mark a bio as polled. Note that for async polled IO, the caller must
  * expect -EWOULDBLOCK if we cannot allocate a request (or other resources).
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index 804f856ed3e571..de98049b7ded91 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -3,6 +3,7 @@
 #define _LINUX_BLK_INTEGRITY_H
 
 #include <linux/blk-mq.h>
+#include <linux/bio-integrity.h>
 
 struct request;
 
-- 
2.43.0


