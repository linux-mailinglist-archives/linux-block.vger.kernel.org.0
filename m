Return-Path: <linux-block+bounces-3365-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7689585B24F
	for <lists+linux-block@lfdr.de>; Tue, 20 Feb 2024 06:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC251F24D68
	for <lists+linux-block@lfdr.de>; Tue, 20 Feb 2024 05:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE5056B92;
	Tue, 20 Feb 2024 05:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c8515aZI"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94DF5812D
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 05:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407201; cv=none; b=RkCXK4gMk2wDsB3CAKkDqcikP7I7fpSfZkBfZVluNj4/uarR1aSqNqaPh0VyRC9Nl79v+WOVzktqu5fAnNeY+z0QH9dmRLXJHm7Ysl0WcgvW1Hg8vxi0yk6N0wNoevdNz5/YIr8RN7cU2gm+2THoBcOkJAt3JAzNxwPX/ApSRms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407201; c=relaxed/simple;
	bh=gsSijpZ0okEmRQn3/nnGD1OEtDReJDAhyxINyaFJHsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZVRNfazMwBsmHPzwtC2+CULFDepG6ij0X/XUGLOONqOrz3xF91AN2Lk3QrqjyUzz1+5pfjdkeYX6MiM9IaJF8JGEMVB8fDZdo79OCOQ55aY2uYHEVjB2dAbbr2DhBLu6hbpO1z8IKSczAQR72+ZoegaT3eJXW1XCzP6/7V/Zao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c8515aZI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=t1Qiw72RhQCfVOZsOpgZWieZvHg34qQ4jMJyC3EBRt8=; b=c8515aZIAnFCcSe3FevGyIinOh
	QzBOL8ffTN1MZ6MPuLVdqXV7tq4Lq6/QDO5UZ9i1P0tAisN5+8VoDX5t1ok6R8eSjEgHglkiDzKmA
	c57En+bOHna+5HQDhPgmGK6YBh7Nc2Iqw8VCOtutS4AGDgrI+jyS24p5gZ+GkBr/8WkkwGVhBfysM
	fJGr/ag1bXdS7edCnkD//jz5XJ+e2CDmySBb8yVTppBDEd8jihZmy3INFJc1flrnnrnrX3eBx/8pL
	3A27D5wdVvCvz/yChbNpHlVwH2ifCbVN0LzxRHL+ruufE6YyLNFIzFGrzYOXT8xXwO0BLza9AZISW
	Rrgd6EWw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcIkf-0000000DDuE-3h3B;
	Tue, 20 Feb 2024 05:33:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 5/5] null_blk: pass queue_limits to blk_mq_alloc_disk
Date: Tue, 20 Feb 2024 06:33:03 +0100
Message-Id: <20240220053303.3211004-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220053303.3211004-1-hch@lst.de>
References: <20240220053303.3211004-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Pass the queue limits directly to blk_mq_alloc_disk instead of
setting them one at a time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/main.c     | 41 +++++++++++++++----------------
 drivers/block/null_blk/null_blk.h |  2 +-
 drivers/block/null_blk/zoned.c    | 15 ++++++-----
 3 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 0c8d5042321302..a0b726c8366cc4 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1694,7 +1694,7 @@ static void null_del_dev(struct nullb *nullb)
 	dev->nullb = NULL;
 }
 
-static void null_config_discard(struct nullb *nullb)
+static void null_config_discard(struct nullb *nullb, struct queue_limits *lim)
 {
 	if (nullb->dev->discard == false)
 		return;
@@ -1711,7 +1711,7 @@ static void null_config_discard(struct nullb *nullb)
 		return;
 	}
 
-	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
+	lim->max_hw_discard_sectors = UINT_MAX >> 9;
 }
 
 static const struct block_device_operations null_ops = {
@@ -1869,6 +1869,12 @@ static bool null_setup_fault(void)
 
 static int null_add_dev(struct nullb_device *dev)
 {
+	struct queue_limits lim = {
+		.logical_block_size	= dev->blocksize,
+		.physical_block_size	= dev->blocksize,
+		.max_hw_sectors		= dev->max_sectors,
+	};
+
 	struct nullb *nullb;
 	int rv;
 
@@ -1894,10 +1900,19 @@ static int null_add_dev(struct nullb_device *dev)
 	if (rv)
 		goto out_cleanup_queues;
 
-	nullb->disk = blk_mq_alloc_disk(nullb->tag_set, NULL, nullb);
+	if (dev->virt_boundary)
+		lim.virt_boundary_mask = PAGE_SIZE - 1;
+	null_config_discard(nullb, &lim);
+	if (dev->zoned) {
+		rv = null_init_zoned_dev(dev, &lim);
+		if (rv)
+			goto out_cleanup_tags;
+	}
+
+	nullb->disk = blk_mq_alloc_disk(nullb->tag_set, &lim, nullb);
 	if (IS_ERR(nullb->disk)) {
 		rv = PTR_ERR(nullb->disk);
-		goto out_cleanup_tags;
+		goto out_cleanup_zone;
 	}
 	nullb->q = nullb->disk->queue;
 
@@ -1911,12 +1926,6 @@ static int null_add_dev(struct nullb_device *dev)
 		blk_queue_write_cache(nullb->q, true, true);
 	}
 
-	if (dev->zoned) {
-		rv = null_init_zoned_dev(dev, nullb->q);
-		if (rv)
-			goto out_cleanup_disk;
-	}
-
 	nullb->q->queuedata = nullb;
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
 
@@ -1924,22 +1933,12 @@ static int null_add_dev(struct nullb_device *dev)
 	rv = ida_alloc(&nullb_indexes, GFP_KERNEL);
 	if (rv < 0) {
 		mutex_unlock(&lock);
-		goto out_cleanup_zone;
+		goto out_cleanup_disk;
 	}
 	nullb->index = rv;
 	dev->index = rv;
 	mutex_unlock(&lock);
 
-	blk_queue_logical_block_size(nullb->q, dev->blocksize);
-	blk_queue_physical_block_size(nullb->q, dev->blocksize);
-	if (dev->max_sectors)
-		blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
-
-	if (dev->virt_boundary)
-		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
-
-	null_config_discard(nullb);
-
 	if (config_item_name(&dev->group.cg_item)) {
 		/* Use configfs dir name as the device name */
 		snprintf(nullb->disk_name, sizeof(nullb->disk_name),
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 7c618d53d8fd06..19afe8de812d4f 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -131,7 +131,7 @@ blk_status_t null_process_cmd(struct nullb_cmd *cmd, enum req_op op,
 			      sector_t sector, unsigned int nr_sectors);
 
 #ifdef CONFIG_BLK_DEV_ZONED
-int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q);
+int null_init_zoned_dev(struct nullb_device *dev, struct queue_limits *lim);
 int null_register_zoned_dev(struct nullb *nullb);
 void null_free_zoned_dev(struct nullb_device *dev);
 int null_report_zones(struct gendisk *disk, sector_t sector,
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 3605afe105dac9..1689e258410483 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -58,7 +58,8 @@ static inline void null_unlock_zone(struct nullb_device *dev,
 		mutex_unlock(&zone->mutex);
 }
 
-int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
+int null_init_zoned_dev(struct nullb_device *dev,
+			struct queue_limits *lim)
 {
 	sector_t dev_capacity_sects, zone_capacity_sects;
 	struct nullb_zone *zone;
@@ -151,23 +152,21 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		sector += dev->zone_size_sects;
 	}
 
+	lim->zoned = true;
+	lim->chunk_sectors = dev->zone_size_sects;
+	lim->max_zone_append_sectors = dev->zone_size_sects;
+	lim->max_open_zones = dev->zone_max_open;
+	lim->max_active_zones = dev->zone_max_active;
 	return 0;
 }
 
 int null_register_zoned_dev(struct nullb *nullb)
 {
-	struct nullb_device *dev = nullb->dev;
 	struct request_queue *q = nullb->q;
 
-	disk_set_zoned(nullb->disk);
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
-	blk_queue_chunk_sectors(q, dev->zone_size_sects);
 	nullb->disk->nr_zones = bdev_nr_zones(nullb->disk->part0);
-	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);
-	disk_set_max_open_zones(nullb->disk, dev->zone_max_open);
-	disk_set_max_active_zones(nullb->disk, dev->zone_max_active);
-
 	return blk_revalidate_disk_zones(nullb->disk, NULL);
 }
 
-- 
2.39.2


