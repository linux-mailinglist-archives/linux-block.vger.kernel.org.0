Return-Path: <linux-block+bounces-27857-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC5BA212A
	for <lists+linux-block@lfdr.de>; Fri, 26 Sep 2025 02:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCE0628273
	for <lists+linux-block@lfdr.de>; Fri, 26 Sep 2025 00:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6261C3BFC;
	Fri, 26 Sep 2025 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJbpPc/J"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E046A13957E
	for <linux-block@vger.kernel.org>; Fri, 26 Sep 2025 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846578; cv=none; b=UjS9gfOhKLEuiYxenKHdS5EV7RwTpw/7uJcGqQEk+pTIHbVdrvTAWqc5VB24ivSuMIaW3v3/Ci5JBHtn3TcByXb1cdNBHIEpSSgLhc78iFGG/GR/xBd6SasvE3BGG83Oy3O49m0KR3bexz+LLFv7igF6Bp5iNxUoi8wxPVTlVD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846578; c=relaxed/simple;
	bh=W3PHSNbGFQw/fTJ29XpXa8ZwrFHOhHfoy/2JAURLprc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyztpgz1nUXU0yHjvJdl7F2Li61e2GFDwW6wvU7AiWWOo2qNkz87v4a5XzzYPxmKOc8SGUaH9hwRibXSURukjGibZWVFpoPcu58QXHZ/BRmnR8ZwqWJE3gTzKslBDQ37aEnmHpNg80NPhO+5gAfW6EYU89evqGEwBLrv1iX08/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJbpPc/J; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33274fcf5c1so1611615a91.1
        for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 17:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846576; x=1759451376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOCYD4PfF8RnmlOuWlE14GqcWCmYwGJ67WUQoQQU7kU=;
        b=lJbpPc/JpYgf23CUi18g3uOoRLPmePnLVhI9dFdPx4Cblk+7VnuQu2LiqjkS/ZPAZn
         QVKvbNPz0HhoucnJn6+V35Oz+wz+Ah/KVkvjrcnwfSXFA0qPBMvVg4t66eWQzW//Y9RE
         j5R+VQGRhHHIPDqJz3nbkI9Y9dGYcPA5C0hmAbsVr/eaBXEPVku//slyURqNTgOnHzs6
         E+J1z9g+kv+BG5z/PQPWMXJbXPUQMXVEoODmKgSkxv0rfj377kgMzi7q5ruSiSyx8Fcx
         0Fox6fbg6ngUd4t2knuAolauux0ckvIU080C7/ShYTnnrMYCocg63OiVUrdipVe2O3ps
         CpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846576; x=1759451376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOCYD4PfF8RnmlOuWlE14GqcWCmYwGJ67WUQoQQU7kU=;
        b=EeXbG1r6DUNYa37Xy6p0VIdlMbg4ca8MMm9F3FEcQhGccZurD8adL1bkOJnkyDZRZI
         W4cw85C5Mf80Wr1znS5OpQM+VVeNexUVq3n6nHv0C6qiCW8MA9HaFxVd5wuXtLiaE9aX
         KPlrZUbzqe/XaB7qLC6DUf+qULC3dm9WJhyMNmVNOyjvv124F6W/XKnzux+xLRdiLKnt
         CiUjF2ZLrmv5iP+o9OzX6fZ9x8bHkAiq0FlMahTSaG60BTROMLeF4EKh5XuWi6Yt6+FU
         ecSIRLq11nUsK6WcCvd54pKNKw6puKPNoKPr0MUIWH7xTpXZag0EFJcvs3XutJa/eDMD
         Q7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCW7gz9/7FARqXr0BIFT/p22BWgbecXROqTTdMEMvTIbRFsC5NG/dT6tlB8JePbvDVuhDEj0MxqXrpaxKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0I7DJpL3ojgv4k+zBr8F4DJYtReOJGcKD/Ut86GhdwM3UliD
	DS9ad9yAs8/+Zu40yUlWxDVEuy2wXbowd1S0veMPqDFWQH0N4yZ9n4K7
X-Gm-Gg: ASbGncsOa5MR7XtCdB52IvUcYRnqm3PPCZiiMa+W4r0QbQG6qyE88MFYInXLUjQ7Ium
	N7baA59qJ1zv8R7zVy+ov4hU5fs3+FbP1O2iSxRG4Hu67x3yFjo+ZpD33F7lT/S312Nk7VR3Xmw
	9MVZUw8n6XlTMBGrgLxOL9E72UQ83zHwvmMOscve1afWn7FbjyJYSkRDSgJ7cPAT652cFXtve+Q
	pc7BGz8baATzarBvppJeSwDx8iQy733Il9mopBEmVXjMaFWPdq6J6GxPB+lcA4WLI5RtEt/o5m+
	rgMloDPf55wgHAT99jwnV3hj+ofTpAEdqyqnedgXxoh3scOvX0LhteAGm1HwgyT3pUu1FTIyWUI
	8Gl4Q/BBtKHHQOiP2VgSe2RZBPhvABhPT8Y+zS7KFlqGvDh5fdQ==
X-Google-Smtp-Source: AGHT+IERKZmWt+gVc9+1LH0ppzggCU2tS+oc4svRqUZ+lKiZZrgBTYDBzzAZw3np4C3/VOrN6slQDQ==
X-Received: by 2002:a17:90b:1c91:b0:32e:b2f8:8dc1 with SMTP id 98e67ed59e1d1-3342a24d2b6mr6072375a91.10.1758846576090;
        Thu, 25 Sep 2025 17:29:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33473f7beacsm3518344a91.15.2025.09.25.17.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:35 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v5 07/14] iomap: track pending read bytes more optimally
Date: Thu, 25 Sep 2025 17:26:02 -0700
Message-ID: <20250926002609.1302233-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926002609.1302233-1-joannelkoong@gmail.com>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of incrementing read_bytes_pending for every folio range read in
(which requires acquiring the spinlock to do so), set read_bytes_pending
to the folio size when the first range is asynchronously read in, keep
track of how many bytes total are asynchronously read in, and adjust
read_bytes_pending accordingly after issuing requests to read in all the
necessary ranges.

iomap_read_folio_ctx->cur_folio_in_bio can be removed since a non-zero
value for pending bytes necessarily indicates the folio is in the bio.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 87 ++++++++++++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 21 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 09e65771a947..4e6258fdb915 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -362,7 +362,6 @@ static void iomap_read_end_io(struct bio *bio)
 
 struct iomap_read_folio_ctx {
 	struct folio		*cur_folio;
-	bool			cur_folio_in_bio;
 	void			*read_ctx;
 	struct readahead_control *rac;
 };
@@ -380,19 +379,11 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
-	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
 	sector_t sector;
 	struct bio *bio = ctx->read_ctx;
 
-	ctx->cur_folio_in_bio = true;
-	if (ifs) {
-		spin_lock_irq(&ifs->state_lock);
-		ifs->read_bytes_pending += plen;
-		spin_unlock_irq(&ifs->state_lock);
-	}
-
 	sector = iomap_sector(iomap, pos);
 	if (!bio || bio_end_sector(bio) != sector ||
 	    !bio_add_folio(bio, folio, plen, poff)) {
@@ -422,8 +413,57 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	}
 }
 
+static void iomap_read_init(struct folio *folio)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	if (ifs) {
+		size_t len = folio_size(folio);
+
+		spin_lock_irq(&ifs->state_lock);
+		ifs->read_bytes_pending += len;
+		spin_unlock_irq(&ifs->state_lock);
+	}
+}
+
+static void iomap_read_end(struct folio *folio, size_t bytes_pending)
+{
+	struct iomap_folio_state *ifs;
+
+	/*
+	 * If there are no bytes pending, this means we are responsible for
+	 * unlocking the folio here, since no IO helper has taken ownership of
+	 * it.
+	 */
+	if (!bytes_pending) {
+		folio_unlock(folio);
+		return;
+	}
+
+	ifs = folio->private;
+	if (ifs) {
+		bool end_read, uptodate;
+		size_t bytes_accounted = folio_size(folio) - bytes_pending;
+
+		spin_lock_irq(&ifs->state_lock);
+		ifs->read_bytes_pending -= bytes_accounted;
+		/*
+		 * If !ifs->read_bytes_pending, this means all pending reads
+		 * by the IO helper have already completed, which means we need
+		 * to end the folio read here. If ifs->read_bytes_pending != 0,
+		 * the IO helper will end the folio read.
+		 */
+		end_read = !ifs->read_bytes_pending;
+		if (end_read)
+			uptodate = ifs_is_fully_uptodate(folio, ifs);
+		spin_unlock_irq(&ifs->state_lock);
+		if (end_read)
+			folio_end_read(folio, uptodate);
+	}
+}
+
 static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx, size_t *bytes_pending)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -460,6 +500,9 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			folio_zero_range(folio, poff, plen);
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
+			if (!*bytes_pending)
+				iomap_read_init(folio);
+			*bytes_pending += plen;
 			iomap_bio_read_folio_range(iter, ctx, pos, plen);
 		}
 
@@ -482,17 +525,18 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	struct iomap_read_folio_ctx ctx = {
 		.cur_folio	= folio,
 	};
+	size_t bytes_pending = 0;
 	int ret;
 
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx,
+				&bytes_pending);
 
 	iomap_bio_submit_read(&ctx);
 
-	if (!ctx.cur_folio_in_bio)
-		folio_unlock(folio);
+	iomap_read_end(folio, bytes_pending);
 
 	/*
 	 * Just like mpage_readahead and block_read_full_folio, we always
@@ -504,24 +548,23 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx, size_t *cur_bytes_pending)
 {
 	int ret;
 
 	while (iomap_length(iter)) {
 		if (ctx->cur_folio &&
 		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
-			if (!ctx->cur_folio_in_bio)
-				folio_unlock(ctx->cur_folio);
+			iomap_read_end(ctx->cur_folio, *cur_bytes_pending);
 			ctx->cur_folio = NULL;
 		}
 		if (!ctx->cur_folio) {
 			ctx->cur_folio = readahead_folio(ctx->rac);
 			if (WARN_ON_ONCE(!ctx->cur_folio))
 				return -EINVAL;
-			ctx->cur_folio_in_bio = false;
+			*cur_bytes_pending = 0;
 		}
-		ret = iomap_read_folio_iter(iter, ctx);
+		ret = iomap_read_folio_iter(iter, ctx, cur_bytes_pending);
 		if (ret)
 			return ret;
 	}
@@ -554,16 +597,18 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	struct iomap_read_folio_ctx ctx = {
 		.rac	= rac,
 	};
+	size_t cur_bytes_pending;
 
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
 	while (iomap_iter(&iter, ops) > 0)
-		iter.status = iomap_readahead_iter(&iter, &ctx);
+		iter.status = iomap_readahead_iter(&iter, &ctx,
+					&cur_bytes_pending);
 
 	iomap_bio_submit_read(&ctx);
 
-	if (ctx.cur_folio && !ctx.cur_folio_in_bio)
-		folio_unlock(ctx.cur_folio);
+	if (ctx.cur_folio)
+		iomap_read_end(ctx.cur_folio, cur_bytes_pending);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-- 
2.47.3


