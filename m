Return-Path: <linux-block+bounces-16143-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 809C3A06DCD
	for <lists+linux-block@lfdr.de>; Thu,  9 Jan 2025 06:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842E2167442
	for <lists+linux-block@lfdr.de>; Thu,  9 Jan 2025 05:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5142F1FBEA6;
	Thu,  9 Jan 2025 05:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u7aGKCDs"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D28207A0A;
	Thu,  9 Jan 2025 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736402303; cv=none; b=lI9cmG1Ueqtl7sPm2xch5YeDbjivm2L9E0vm7o3Qg/q4f+3zSIq7xGQyA2LjjaNxRnEZE6NP1LTmgw374Ns/jxjp91QlA2c5xlr9k0R/a2QSKMDGHZMc0xBDMLkv696R7/Yng4u/EuxOhr/npz0eHrkkc+1ucBhmrIBfRjRKtbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736402303; c=relaxed/simple;
	bh=3LgGku3i3aYHO7pDDDbAADYmQaSGAfzRIhmj/T0DbfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+Rm4VOlu9oLkHOGHhSC9i/E5HBlloOTGGvVmlFJlyfRZ96NOqS3JkhmzpihEIxkH8Vav7dvnBSEXb8rtUSQfnmR3pOMWwx4Yxt2saReM2SQTPA14xJu+wckzP7kYRMo3wLfuGRGjIHoCy5OdNLAcKNi45oRjLxHLm4KSALkHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u7aGKCDs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KxgWbJ7auoeAcx9YDYY5C3D0yCCFueGV+Dc+AQNWEfo=; b=u7aGKCDscnLquDhY1zN+kFVTU/
	6kuaDmH8x13cDM1DsPEDN7bZh3Ljds2r+scYLUpyOljV82E3F4FP9svElfACBv5yhFK1SahxEs3uX
	VJdlCFXcsYk99SQcr6x2YJL7RCtnkSzZJ7llxN9kTnS4TwOLP5uiCHMMVl1Dn1YAWR/nnfVK89uhn
	NtXN5OYiIDGxEVPwaY9Y3FoibOxIHmbxqN0XrzaBvTLAoEHIyT5zXXvlJe7ve+DHG379d3Zodgmxt
	Cp3jJT8CqDmzWNYddObJjcBy8sE1v2Nb70+yTiSsoP3QLGN2VuqC/mPEw1pKjJdUCy5efauYTJtw2
	33vtZ4CA==;
Received: from 2a02-8389-2341-5b80-ddeb-cdec-70b9-e2f0.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ddeb:cdec:70b9:e2f0] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVlYg-0000000ArCL-0Co3;
	Thu, 09 Jan 2025 05:58:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	nbd@other.debian.org,
	linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 01/11] block: fix docs for freezing of queue limits updates
Date: Thu,  9 Jan 2025 06:57:22 +0100
Message-ID: <20250109055810.1402918-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250109055810.1402918-1-hch@lst.de>
References: <20250109055810.1402918-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

queue_limits_commit_update is the function that needs to operate on a
frozen queue, not queue_limits_start_update.  Update the kerneldoc
comments to reflect that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-settings.c   | 3 ++-
 include/linux/blkdev.h | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8f09e33f41f6..89d8366fd43c 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -413,7 +413,8 @@ int blk_set_default_limits(struct queue_limits *lim)
  * @lim:	limits to apply
  *
  * Apply the limits in @lim that were obtained from queue_limits_start_update()
- * and updated by the caller to @q.
+ * and updated by the caller to @q.  The caller must have frozen the queue or
+ * ensure that there are no outstanding I/Os by other means.
  *
  * Returns 0 if successful, else a negative error code.
  */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5d40af2ef971..e781d4e6f92d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -944,8 +944,7 @@ static inline unsigned int blk_boundary_sectors_left(sector_t offset,
  * the caller can modify.  The caller must call queue_limits_commit_update()
  * to finish the update.
  *
- * Context: process context.  The caller must have frozen the queue or ensured
- * that there is outstanding I/O by other means.
+ * Context: process context.
  */
 static inline struct queue_limits
 queue_limits_start_update(struct request_queue *q)
-- 
2.45.2


