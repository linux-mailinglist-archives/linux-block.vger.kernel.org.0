Return-Path: <linux-block+bounces-3868-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F3986D234
	for <lists+linux-block@lfdr.de>; Thu, 29 Feb 2024 19:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1D51C23660
	for <lists+linux-block@lfdr.de>; Thu, 29 Feb 2024 18:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920AA78295;
	Thu, 29 Feb 2024 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="EHNEAJpH"
X-Original-To: linux-block@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FE17A14E
	for <linux-block@vger.kernel.org>; Thu, 29 Feb 2024 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231238; cv=none; b=tnFtamNHNsFQP4Wj90wC/b0ok69XKJWKibq2oBsCk4wZLCkaqD0yMsuSv51DATs71eCEkUwvHpka2aaVUayEQPPLCHnHxCWeUR2+Cp2/1JBWTV+SKIqgZLIT4SUXmLYzYvg/siI5+6mBxDNXQIQXe3JBpwZFG7QYUGtpH9a43wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231238; c=relaxed/simple;
	bh=0ujY1W7EPTMDMv8Qjd/XFEAXcyl4EZ0O06CzvoVFYCc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uwpQm0vw66nnO+cxAydzvS8hR8XppX6YV4cskIEUjFpBKWRAJ74Jbc0eGN86h4U6Lmipa6JzSJH58E5O5fjDmWkAYBKH57vNjaORpAaNi/9/04puBVA0nyv20OoWIG5jg1tCmJ4aJAgRzdDRKpzZFV1IT7FYlkTKvM3VUZbPKM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=EHNEAJpH; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
X-ASG-Debug-ID: 1709230070-1cf4391a1c4fcf0002-Cu09wu
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id OKH4L5BwQIJxnplq; Thu, 29 Feb 2024 13:08:13 -0500 (EST)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=GyTYh7rZxyuaZxAK4E6INt0hy/oXnF2VsS983Qgm9WI=;
	h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:Content-Language:
	MIME-Version:Date:Message-ID; b=EHNEAJpH9NO6DGJeblalbgxMQVo9ZjLHP5lNuDo0CY5z+
	3qRP6j8BSOQ1clNEfFa8V1xd1wyAxTkw7gIdJuf4r5DcXWB08/uQ/7qeVuc70mLwffJnHoNaXO4ro
	5M6b7FYErqw/nqlHndEyRgwppLhJ5Aw8n43zpvTRnqCKTu0iA=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 13108803; Thu, 29 Feb 2024 13:08:10 -0500
Message-ID: <86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Thu, 29 Feb 2024 13:08:09 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Hugh Dickins <hughd@google.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, linux-mm <linux-mm@kvack.org>,
 linux-block@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Tony Battersby <tonyb@cybernetics.com>
Subject: [PATCH] block: Fix page refcounts for unaligned buffers in
 __bio_release_pages()
Content-Type: text/plain; charset=UTF-8
X-ASG-Orig-Subj: [PATCH] block: Fix page refcounts for unaligned buffers in
 __bio_release_pages()
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1709230093
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1347

Fix an incorrect number of pages being released for buffers that do not
start at the beginning of a page.

Fixes: 1b151e2435fc ("block: Remove special-casing of compound pages")
Cc: stable@vger.kernel.org
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---

Tested with 6.1.79.  The 6.1 backport can just use
folio_put_refs(fi.folio, nr_pages) instead of do {...} while.

 block/bio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b9642a41f286..b52b56067e79 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1152,7 +1152,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 
 	bio_for_each_folio_all(fi, bio) {
 		struct page *page;
-		size_t done = 0;
+		size_t nr_pages;
 
 		if (mark_dirty) {
 			folio_lock(fi.folio);
@@ -1160,10 +1160,11 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 			folio_unlock(fi.folio);
 		}
 		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
+		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
+			   fi.offset / PAGE_SIZE + 1;
 		do {
 			bio_release_page(bio, page++);
-			done += PAGE_SIZE;
-		} while (done < fi.length);
+		} while (--nr_pages != 0);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);

base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
-- 
2.25.1


