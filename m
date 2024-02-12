Return-Path: <linux-block+bounces-3115-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52387850D9C
	for <lists+linux-block@lfdr.de>; Mon, 12 Feb 2024 07:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DF01C2222F
	for <lists+linux-block@lfdr.de>; Mon, 12 Feb 2024 06:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8350FF9E5;
	Mon, 12 Feb 2024 06:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QtGCCTHa"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286CF9E4;
	Mon, 12 Feb 2024 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707720401; cv=none; b=N3ONwVja3bYk3YAquodmIcNLw+oz3BsXyMCs6JY/dor+LY3fd6Bghu+gRqOTwP/1NX1TVp5H6YhYAytFfnfzBw/Dsv6J/dWMFZHTz5I4wU0L+j586tOh4gfvEAQ6adeqsE7Eg7yxfJLk5nHLnHiTxadA0Y7IljK4smEMLxDdb0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707720401; c=relaxed/simple;
	bh=fyslmlqNpBuKcO/m78FTUDPJu1YLxiCATf/HNCrlFQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UmFFIDg6w3KHwwmfUbAEzskruNAyhrblvyb7E21K6v5DcUYJ/TnaAYKcDr5C9hMipNLG5Zyo7gzxxiVagl7C1grawDSdwgmXpnZj9W2Xkixsv5+Rx7GjkTjn+i+RgQyZMm+Zif0p3/1YDi644mo8wrNmErxMqfcAYQSsQ4n7Py4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QtGCCTHa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=q63nZGZ5nk2CmZZg/FUFdCJGsVWM4sszVHXEvpO53Oo=; b=QtGCCTHaUsqepXcNJH7YYleSM/
	gofHoZmohbl6SyLrZf89+IvZUMN8KB6U8IfTEOrafeN77AJVEI6CUMZmCj3lCKMiyKWSrGyPEktnS
	Tgz44BY0iaUS/XfVs2zvo4DawcDkhV/UpBj2DDscWmzaXNH1Qa2pKWDRXEsB089CgqH4PsqpChMBP
	WceK8/aKKTvZ+ai+sgWvf1CUch/xQCD1Z1nnNBVS/PTFgCYgq3BfXsZZdFJYz0v/k+goc8SV0wQER
	3XtMsUzzPmBao0JYFjzwQ00ATYCjGBERCcc9Keoe6/E7XZ9uERnMrZ+zUpBX6TYM6nDQO/1I21Im/
	z5t7jkDA==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ5K-00000004Pe4-3Stl;
	Mon, 12 Feb 2024 06:46:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/15] block: add a max_user_discard_sectors queue limit
Date: Mon, 12 Feb 2024 07:46:00 +0100
Message-Id: <20240212064609.1327143-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212064609.1327143-1-hch@lst.de>
References: <20240212064609.1327143-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a new max_user_discard_sectors limit that mirrors max_user_sectors
and stores the value that the user manually set.  This now allows
updates of the max_hw_discard_sectors to not worry about the user
limit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-settings.c   | 18 +++++++++++++++---
 block/blk-sysfs.c      | 17 ++++++++---------
 include/linux/blkdev.h |  1 +
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 27b9b4a2a85395..7139c13fe73484 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -37,6 +37,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	memset(lim, 0, sizeof(*lim));
 	lim->logical_block_size = lim->physical_block_size = lim->io_min = 512;
 	lim->discard_granularity = 512;
+	lim->max_user_discard_sectors = UINT_MAX;
 	lim->dma_alignment = 511;
 	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
 
@@ -160,7 +161,9 @@ static int blk_validate_limits(struct queue_limits *lim)
 	if (!lim->max_segments)
 		lim->max_segments = BLK_MAX_SEGMENTS;
 
-	lim->max_discard_sectors = lim->max_hw_discard_sectors;
+	lim->max_discard_sectors =
+		min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors);
+
 	if (!lim->max_discard_segments)
 		lim->max_discard_segments = 1;
 
@@ -226,6 +229,12 @@ static int blk_validate_limits(struct queue_limits *lim)
  */
 int blk_set_default_limits(struct queue_limits *lim)
 {
+	/*
+	 * Most defaults are set by capping the bounds in blk_validate_limits,
+	 * but max_user_discard_sectors is special and needs an explicit
+	 * initialization to the max value here.
+	 */
+	lim->max_user_discard_sectors = UINT_MAX;
 	return blk_validate_limits(lim);
 }
 
@@ -347,8 +356,11 @@ EXPORT_SYMBOL(blk_queue_chunk_sectors);
 void blk_queue_max_discard_sectors(struct request_queue *q,
 		unsigned int max_discard_sectors)
 {
-	q->limits.max_hw_discard_sectors = max_discard_sectors;
-	q->limits.max_discard_sectors = max_discard_sectors;
+	struct queue_limits *lim = &q->limits;
+
+	lim->max_hw_discard_sectors = max_discard_sectors;
+	lim->max_discard_sectors =
+		min(max_discard_sectors, lim->max_user_discard_sectors);
 }
 EXPORT_SYMBOL(blk_queue_max_discard_sectors);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 26607f9825cb05..a1ec27f0ba4150 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -174,23 +174,22 @@ static ssize_t queue_discard_max_show(struct request_queue *q, char *page)
 static ssize_t queue_discard_max_store(struct request_queue *q,
 				       const char *page, size_t count)
 {
-	unsigned long max_discard;
-	ssize_t ret = queue_var_store(&max_discard, page, count);
+	unsigned long max_discard_bytes;
+	ssize_t ret;
 
+	ret = queue_var_store(&max_discard_bytes, page, count);
 	if (ret < 0)
 		return ret;
 
-	if (max_discard & (q->limits.discard_granularity - 1))
+	if (max_discard_bytes & (q->limits.discard_granularity - 1))
 		return -EINVAL;
 
-	max_discard >>= 9;
-	if (max_discard > UINT_MAX)
+	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
 		return -EINVAL;
 
-	if (max_discard > q->limits.max_hw_discard_sectors)
-		max_discard = q->limits.max_hw_discard_sectors;
-
-	q->limits.max_discard_sectors = max_discard;
+	q->limits.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
+	q->limits.max_discard_sectors = min(q->limits.max_hw_discard_sectors,
+					    q->limits.max_user_discard_sectors);
 	return ret;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 97c01efed68253..64cca723619083 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -290,6 +290,7 @@ struct queue_limits {
 	unsigned int		io_opt;
 	unsigned int		max_discard_sectors;
 	unsigned int		max_hw_discard_sectors;
+	unsigned int		max_user_discard_sectors;
 	unsigned int		max_secure_erase_sectors;
 	unsigned int		max_write_zeroes_sectors;
 	unsigned int		max_zone_append_sectors;
-- 
2.39.2


