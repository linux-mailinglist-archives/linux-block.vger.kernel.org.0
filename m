Return-Path: <linux-block+bounces-1190-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12CC8150BF
	for <lists+linux-block@lfdr.de>; Fri, 15 Dec 2023 21:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5B5287454
	for <lists+linux-block@lfdr.de>; Fri, 15 Dec 2023 20:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840F1671EC;
	Fri, 15 Dec 2023 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gFuvhDYv"
X-Original-To: linux-block@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949605644D;
	Fri, 15 Dec 2023 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=jtQJbz4fdyRVv5uL17Tn1fQYq5bZueXqglZgma3TBl8=; b=gFuvhDYvigMOyd9cgE5NRHYGMP
	JXw9GfbWWxR/6/N7DMulUTX+25ifhwz3zoyE0lzX7H9OfJYCNg/MFDdY2MaFng+trp0U3o+gQBSx3
	8C5KaPgv1m/g3oZI+7UCdOI97RLBceH7asFFwM1ltU+xJV/gQlbCZuCKhTnKmdVzUNHtkvoZs1egf
	mpT5f56FHW51GIvbnhKxjwc9jnQVUWJE91EHvZ66wUeoxcvcgINVM3y85oKEZegnrtAzP3d07jUBO
	kiQ53iw4H/NDc5AGQWsFnkidijsaDL1EIBmVDdIUIGGK9wbBfziTFxK9L+YOU7apsGq6OiRL9mwts
	wddReUhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEEOW-0038jQ-38; Fri, 15 Dec 2023 20:02:48 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 11/14] sysv: Remove writepage implementation
Date: Fri, 15 Dec 2023 20:02:42 +0000
Message-Id: <20231215200245.748418-12-willy@infradead.org>
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
 fs/sysv/itree.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index 725981474e5f..410ab2a44d2f 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -8,6 +8,7 @@
 
 #include <linux/buffer_head.h>
 #include <linux/mount.h>
+#include <linux/mpage.h>
 #include <linux/string.h>
 #include "sysv.h"
 
@@ -456,9 +457,10 @@ int sysv_getattr(struct mnt_idmap *idmap, const struct path *path,
 	return 0;
 }
 
-static int sysv_writepage(struct page *page, struct writeback_control *wbc)
+static int sysv_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	return block_write_full_page(page,get_block,wbc);
+	return mpage_writepages(mapping, wbc, get_block);
 }
 
 static int sysv_read_folio(struct file *file, struct folio *folio)
@@ -503,8 +505,9 @@ const struct address_space_operations sysv_aops = {
 	.dirty_folio = block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio = sysv_read_folio,
-	.writepage = sysv_writepage,
+	.writepages = sysv_writepages,
 	.write_begin = sysv_write_begin,
 	.write_end = generic_write_end,
+	.migrate_folio = buffer_migrate_folio,
 	.bmap = sysv_bmap
 };
-- 
2.42.0


