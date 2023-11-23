Return-Path: <linux-block+bounces-390-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F0D7F548C
	for <lists+linux-block@lfdr.de>; Thu, 23 Nov 2023 00:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD211F20CD4
	for <lists+linux-block@lfdr.de>; Wed, 22 Nov 2023 23:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489A721A07;
	Wed, 22 Nov 2023 23:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q8FMhX4D"
X-Original-To: linux-block@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F854110
	for <linux-block@vger.kernel.org>; Wed, 22 Nov 2023 15:28:28 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700695706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wdxKnJ2FmIDaRAshfSUcmrGs+dMUGZeUTYVCPDJSnpk=;
	b=q8FMhX4D68JVMtBwOlZC8K7WTFcuV7dFt6Tdp+yJPOCFEpENVPE1X/9EsC7aj4rSAKviNs
	YXezFsQOaw4edYpaUeU3NRGO/ewnZZTbyesH4EgJzwvsM/xIaMGMlYZkbPYW7OSL+/FYyJ
	ghl5q/SL7SVDzkrhNFrysTuy3zB75cs=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] block: Add documentation for bio iterator macros
Date: Wed, 22 Nov 2023 18:28:15 -0500
Message-ID: <20231122232818.178256-3-kent.overstreet@linux.dev>
In-Reply-To: <20231122232818.178256-1-kent.overstreet@linux.dev>
References: <20231122232818.178256-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We've now got 3x2 interfaces for iterating over bios: by page, by bvec,
or by folio, and variants that iterate over what bi_iter points to, or
the entire bio as created by the filesystem/originator.

This adds more detailed kerneldoc comments for each variant.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org
---
 include/linux/bio.h | 54 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index eaaf7e5f0d54..21524a953f6e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -103,9 +103,14 @@ static inline void bio_iter_all_advance(const struct bio *bio,
 		((bvl = bio_iter_all_peek(bio, &iter)), true);		\
 	     bio_iter_all_advance((bio), &iter, bvl.bv_len))
 
-/*
- * drivers should _never_ use the all version - the bio may have been split
- * before it got to the driver and the driver won't own all of it
+/**
+ * bio_for_each_segment_all - iterate over single pages in a bio
+ *
+ * Like other _all versions, this is for the filesystem, or the owner/creator of
+ * a bio; it iterates over the original contents of a bio.
+ *
+ * Drivers that are working with bios that were submitted to them should not use
+ * the _all version.
  */
 #define bio_for_each_segment_all(bvl, bio, iter)			\
 	for (bvec_iter_all_init(&iter);					\
@@ -166,6 +171,13 @@ static inline void bio_advance(struct bio *bio, unsigned int nbytes)
 		((bvl = bio_iter_iovec((bio), (iter))), 1);		\
 	     bio_advance_iter_single((bio), &(iter), (bvl).bv_len))
 
+/**
+ * bio_for_each_segment - iterate over single pages in a bio
+ *
+ * Like other non-_all versions, this iterates over what bio->bi_iter currently
+ * points to. This version is for drivers, where the bio may have previously
+ * been split or cloned.
+ */
 #define bio_for_each_segment(bvl, bio, iter)				\
 	__bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
 
@@ -202,6 +214,13 @@ static inline struct folio_vec bio_iter_iovec_folio(struct bio *bio,
 		((bvl = bio_iter_iovec_folio((bio), (iter))), 1);	\
 	     bio_advance_iter_single((bio), &(iter), (bvl).fv_len))
 
+/**
+ * bio_for_each_folio - iterate over folios within a bio
+ *
+ * Like other non-_all versions, this iterates over what bio->bi_iter currently
+ * points to. This version is for drivers, where the bio may have previously
+ * been split or cloned.
+ */
 #define bio_for_each_folio(bvl, bio, iter)				\
 	__bio_for_each_folio(bvl, bio, iter, (bio)->bi_iter)
 
@@ -211,13 +230,30 @@ static inline struct folio_vec bio_iter_iovec_folio(struct bio *bio,
 		((bvl = mp_bvec_iter_bvec((bio)->bi_io_vec, (iter))), 1); \
 	     bio_advance_iter_single((bio), &(iter), (bvl).bv_len))
 
-/* iterate over multi-page bvec */
+/**
+ * bio_for_each_bvec - iterate over bvecs within a bio
+ *
+ * This version iterates over entire bio_vecs, which will be a range of
+ * contiguous pages.
+ *
+ * Like other non-_all versions, this iterates over what bio->bi_iter currently
+ * points to. This version is for drivers, where the bio may have previously
+ * been split or cloned.
+ */
 #define bio_for_each_bvec(bvl, bio, iter)			\
 	__bio_for_each_bvec(bvl, bio, iter, (bio)->bi_iter)
 
 /*
- * Iterate over all multi-page bvecs. Drivers shouldn't use this version for the
- * same reasons as bio_for_each_segment_all().
+ * bio_for_each_bvec_all - iterate over bvecs within a bio
+ *
+ * This version iterates over entire bio_vecs, which will be a range of
+ * contiguous pages.
+ *
+ * Like other _all versions, this is for the filesystem, or the owner/creator of
+ * a bio; it iterates over the original contents of a bio.
+ *
+ * Drivers that are working with bios that were submitted to them should not use
+ * the _all version.
  */
 #define bio_for_each_bvec_all(bvl, bio, i)		\
 	for (i = 0, bvl = bio_first_bvec_all(bio);	\
@@ -328,6 +364,12 @@ static inline struct folio_vec bio_folio_iter_all_peek(const struct bio *bio,
  * bio_for_each_folio_all - Iterate over each folio in a bio.
  * @fi: struct bio_folio_iter_all which is updated for each folio.
  * @bio: struct bio to iterate over.
+ *
+ * Like other _all versions, this is for the filesystem, or the owner/creator of
+ * a bio; it iterates over the original contents of a bio.
+ *
+ * Drivers that are working with bios that were submitted to them should not use
+ * the _all version.
  */
 #define bio_for_each_folio_all(fv, bio, iter)				\
 	for (bvec_iter_all_init(&iter);					\
-- 
2.42.0


