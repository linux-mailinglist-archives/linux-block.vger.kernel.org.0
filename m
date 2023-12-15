Return-Path: <linux-block+bounces-1187-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B4A8150B7
	for <lists+linux-block@lfdr.de>; Fri, 15 Dec 2023 21:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3881F278C3
	for <lists+linux-block@lfdr.de>; Fri, 15 Dec 2023 20:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B1661FD7;
	Fri, 15 Dec 2023 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OGngCJBo"
X-Original-To: linux-block@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24122563AC;
	Fri, 15 Dec 2023 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=h/m/ubY/K1ZdLR6hCbBi+7ePQUK5r4QCjij0zKQvyNA=; b=OGngCJBoPBlEI+RqZXEcVMjqRl
	Qs0RtPBChjAntMDeQuzdkssVP8YWEwS0ct376855NHwDMuflJICChxLuWjQ7+KEUFLcnPdSVLe6qu
	xlcTvlR3XwWm/xBXcNYrKtsqr27sJQh3SK0z+Zg4xfOWbfrjkqvISl40ERmV/4lghTZqFIY7xLZqV
	9GrrPM1pNuw2V1zm7x5pHi+0erxePu3LhUl6aN8ArUcB3R7WGi0jeEE2pYlH5u0WVZ6QoTzEg4MWB
	Wyzd4bRJusV/elmO8cspKm2yyXbwjm1zgoyZjuzIMdau2klbXbAoPmhbixT+VNmAVIm7TzUbjUrH9
	nH5uEX9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEEOV-0038id-AP; Fri, 15 Dec 2023 20:02:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 05/14] adfs: Remove writepage implementation
Date: Fri, 15 Dec 2023 20:02:36 +0000
Message-Id: <20231215200245.748418-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231215200245.748418-1-willy@infradead.org>
References: <20231215200245.748418-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the filesystem implements migrate_folio and writepages, there is
no need for a writepage implementation.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/adfs/inode.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 3081edb09e46..a183e213a4a5 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 1997-1999 Russell King
  */
 #include <linux/buffer_head.h>
+#include <linux/mpage.h>
 #include <linux/writeback.h>
 #include "adfs.h"
 
@@ -33,9 +34,10 @@ adfs_get_block(struct inode *inode, sector_t block, struct buffer_head *bh,
 	return 0;
 }
 
-static int adfs_writepage(struct page *page, struct writeback_control *wbc)
+static int adfs_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	return block_write_full_page(page, adfs_get_block, wbc);
+	return mpage_writepages(mapping, wbc, adfs_get_block);
 }
 
 static int adfs_read_folio(struct file *file, struct folio *folio)
@@ -76,10 +78,11 @@ static const struct address_space_operations adfs_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= adfs_read_folio,
-	.writepage	= adfs_writepage,
+	.writepages	= adfs_writepages,
 	.write_begin	= adfs_write_begin,
 	.write_end	= generic_write_end,
-	.bmap		= _adfs_bmap
+	.migrate_folio	= buffer_migrate_folio,
+	.bmap		= _adfs_bmap,
 };
 
 /*
-- 
2.42.0


