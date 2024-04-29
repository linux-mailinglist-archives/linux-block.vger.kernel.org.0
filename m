Return-Path: <linux-block+bounces-6704-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E46198B6084
	for <lists+linux-block@lfdr.de>; Mon, 29 Apr 2024 19:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE48B209AA
	for <lists+linux-block@lfdr.de>; Mon, 29 Apr 2024 17:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40662128399;
	Mon, 29 Apr 2024 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qhiue/fi"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89820129E98
	for <linux-block@vger.kernel.org>; Mon, 29 Apr 2024 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412948; cv=none; b=PMQMyOCh2dJGlFegRyF6iQZkMGuUqawEvDY/kLWFd0+yiY/72+mEdSJToPQ9PBgDdIooTi6kl+ZnMBSE9iTEW0H5/8BbdBbjwIQJIgRJUNCSh0LtauUCqrsQsL5Drthtv9C9b845vhibRoToaHP31C44Y6IpC5mQ10pMshOhbUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412948; c=relaxed/simple;
	bh=1U+Kh3hlSED8HrnAdOsdy60sZC6TEyEX1hh69gbLIYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pj3T0EPIGTgQYr4FSqHV+DLvj0Vo+l+Jvz8Kgyd2dPbIxV04fz3RSyXT/1KRUKjs8tndb1n8sHF84nhMbIhdhcsEAtSw2ra+EBD6chwRYCMjzPXVjvSzpyjnI8r5fhbS6UJADuEkIQ/XbPwYK7S/m2SZC76h1WRzkIBkvejZ/qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qhiue/fi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XMA0Y4ySVhUqfZ5XnqoqS75sxnrPA9ZX/CVdHty0VuM=; b=Qhiue/fi1p+4FIbi49kGmKITmV
	te3h8icOukmpTjeoX8zo51K5b4HVpJnNr8+gViJCYkuMxhJqXgXWTOJXrm6a4TKHpfZGv5sKC5Rks
	ZUw3hpUeWMIUMOcVAu9u7ParUk3z7qo/Ry/uxowT8XqmODbpJXpuMYnLu5lvV4TNITagL9JjznMif
	bRjNp8Wa008wKETR/+kdKSgJkowZmH3y1K3+gMneuKD57hnXdH2TCkb0+qPpAm8vGRIbjNMw2LqYa
	0a3JW7dgy/s8i+pYPnFpcXeNL2BU30/uBAhzCGRKOTsBDtjxTfEBmpDHvy8AEilSjy4J0cFIDb+3+
	cbPQaUWA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1V7h-00000003mZf-394v;
	Mon, 29 Apr 2024 17:49:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Lennart Poettering <mzxreary@0pointer.de>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: add a disk_has_partscan helper
Date: Mon, 29 Apr 2024 19:49:00 +0200
Message-Id: <20240429174901.1643909-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429174901.1643909-1-hch@lst.de>
References: <20240429174901.1643909-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a helper to check if partition scanning is enabled instead of
open coding the check in a few places.  This now always checks for
the hidden flag even if all but one of the callers are never reachable
for hidden gendisks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c           |  7 ++-----
 block/partitions/core.c |  5 +----
 include/linux/blkdev.h  | 13 +++++++++++++
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index eb893df56d510e..4b85963d09dbb4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -345,9 +345,7 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 	struct file *file;
 	int ret = 0;
 
-	if (disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN))
-		return -EINVAL;
-	if (test_bit(GD_SUPPRESS_PART_SCAN, &disk->state))
+	if (!disk_has_partscan(disk))
 		return -EINVAL;
 	if (disk->open_partitions)
 		return -EBUSY;
@@ -503,8 +501,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 			goto out_unregister_bdi;
 
 		/* Make sure the first partition scan will be proceed */
-		if (get_capacity(disk) && !(disk->flags & GENHD_FL_NO_PART) &&
-		    !test_bit(GD_SUPPRESS_PART_SCAN, &disk->state))
+		if (get_capacity(disk) && disk_has_partscan(disk))
 			set_bit(GD_NEED_PART_SCAN, &disk->state);
 
 		bdev_add(disk->part0, ddev->devt);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b11e88c82c8cfa..37b5f92d07fec9 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -573,10 +573,7 @@ static int blk_add_partitions(struct gendisk *disk)
 	struct parsed_partitions *state;
 	int ret = -EAGAIN, p;
 
-	if (disk->flags & GENHD_FL_NO_PART)
-		return 0;
-
-	if (test_bit(GD_SUPPRESS_PART_SCAN, &disk->state))
+	if (!disk_has_partscan(disk))
 		return 0;
 
 	state = check_partition(disk);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 040a22e0eda0ec..3b18a40a1fc109 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -230,6 +230,19 @@ static inline unsigned int disk_openers(struct gendisk *disk)
 	return atomic_read(&disk->part0->bd_openers);
 }
 
+/**
+ * disk_has_partscan - return %true if partition scanning is enabled on a disk
+ * @disk: disk to check
+ *
+ * Returns %true if partitions scanning is enabled for @disk, or %false if
+ * partition scanning is disabled either permanently or temporarily.
+ */
+static inline bool disk_has_partscan(struct gendisk *disk)
+{
+	return !(disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN)) &&
+		!test_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
+}
+
 /*
  * The gendisk is refcounted by the part0 block_device, and the bd_device
  * therein is also used for device model presentation in sysfs.
-- 
2.39.2


