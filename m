Return-Path: <linux-block+bounces-21072-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CD7AA6AF8
	for <lists+linux-block@lfdr.de>; Fri,  2 May 2025 08:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D601BA6BB3
	for <lists+linux-block@lfdr.de>; Fri,  2 May 2025 06:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C55266B6F;
	Fri,  2 May 2025 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VtnQamSB"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA12676EB;
	Fri,  2 May 2025 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746168586; cv=none; b=QVOdYK6sqDS/cr2Rg/1GYpMxrkgodAuuTdEueHiALc28m6hUNM0uknXeytZk4Bn0V1jxokX0b3TOeF/GlGgL/ABv9Gse4kztuB6DEiNwNw6qVqc1Z1o8MTfdHKo740y9eziOMGsHU7WQVVd7fF6ilNSryCVX+ZofPeuhboGkeRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746168586; c=relaxed/simple;
	bh=fvBVnBfmJry95rCal2HgNiPuyAsgVZFd2KPGiyO3G0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4i4fx9CQgQX2CV0YdxQU0MpigSxvBwAyYMf2sSiwCOirgkyqPnkAGfOWmsCgSS8esWlAGGHNp0+QPSJYwt1/QShgPXoLWdefZ3l7Xe4JGGanSfvQ8SNeKmoRL55jeUAU1TUUQ0xLET4xZ/d/mMrlBjGoDTJeSIIqw73k77gwn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VtnQamSB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HBEN1Ny/Xmt6F8G1EKBQS3gVyJmGJpibhAvZz+npVsY=; b=VtnQamSBg8JQVuucMdREPYwYbn
	h72dpSse/14MZ+K7IXMpdSQ/rHpw0+JMaBpmzrNFa+5N447YNJIWg9OrlzdmIpQFXXT6gK44H+U+q
	rB7OOxqoq1SBWxL8egjSSfzXNunVhGWGlBTH65W95zQ6laxhIkqYCW7aXMG2By0HQZlzKgg/pRhzQ
	U7Uz8VtxLveaSatp94HDwsL9dVl7kboN6LmV2KLxiMfjlWx1bcu75yDq23g791tLvameyh6muFcTl
	gp+l5lKx1QH9vHZ20WQQPDPheYANLGfGoD9C+dcJDwh6Qg55Bx6pT4pXUf0hUt93fAoauRVQjdDlD
	a0IrY7kA==;
Received: from [185.143.37.16] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAkDP-0000000114o-11kC;
	Fri, 02 May 2025 06:49:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	"Juergen E. Fischer" <fischer@norbit.de>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-mm@kvack.org
Subject: [PATCH 4/7] usb-storage: reject probe of device one non-DMA HCDs when using highmem
Date: Fri,  2 May 2025 07:49:21 +0100
Message-ID: <20250502064930.2981820-5-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250502064930.2981820-1-hch@lst.de>
References: <20250502064930.2981820-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

usb-storage is the last user of the block layer bounce buffering now,
and only uses it for HCDs that do not support DMA on highmem configs.

Remove this support and fail the probe so that the block layer bounce
buffering can go away.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/storage/usb.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index d36f3b6992bb..49bbfe4610d5 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -1057,12 +1057,15 @@ int usb_stor_probe1(struct us_data **pus,
 
 	/*
 	 * Some USB host controllers can't do DMA; they have to use PIO.
-	 * For such controllers we need to make sure the block layer sets
-	 * up bounce buffers in addressable memory.
+	 * We can't support these controllers on highmem systems as the
+	 * usb-storage code lacks the code to kmap or bounce buffer.
 	 */
-	if (!hcd_uses_dma(bus_to_hcd(us->pusb_dev->bus)) ||
-	    bus_to_hcd(us->pusb_dev->bus)->localmem_pool)
-		host->no_highmem = true;
+	if (IS_ENABLED(CONFIG_HIGHMEM) &&
+	    (!hcd_uses_dma(bus_to_hcd(us->pusb_dev->bus)) ||
+	     bus_to_hcd(us->pusb_dev->bus)->localmem_pool)) {
+		dev_warn(&intf->dev, "USB Mass Storage device not support on this HCD\n");
+		goto release;
+	}
 
 	/* Get the unusual_devs entries and the descriptors */
 	result = get_device_info(us, id, unusual_dev);
@@ -1081,6 +1084,7 @@ int usb_stor_probe1(struct us_data **pus,
 
 BadDevice:
 	usb_stor_dbg(us, "storage_probe() failed\n");
+release:
 	release_everything(us);
 	return result;
 }
-- 
2.47.2


