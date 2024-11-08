Return-Path: <linux-block+bounces-13762-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D669C20F5
	for <lists+linux-block@lfdr.de>; Fri,  8 Nov 2024 16:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA5B1F249A6
	for <lists+linux-block@lfdr.de>; Fri,  8 Nov 2024 15:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E77021B425;
	Fri,  8 Nov 2024 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zYnnyBYd"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BB321B45E
	for <linux-block@vger.kernel.org>; Fri,  8 Nov 2024 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080826; cv=none; b=VxmhyGecPH0bc2QUEaJoa0MZIPD9yfqLRqdA01VjCYqDNmxfSaWF59mAAghNBtACaT4BuCzjRqhobyEmzWCl1lqu+KUFun+z8Zq1PUutCY7qNpKmeeeWwBokFGIzde7/BAUmbrhbh+OywVLhgFJK7UOQQM+UD7QxVz3Q63JJQTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080826; c=relaxed/simple;
	bh=bbJgW8w9D8+bb9GBOX+NzBxoNnrD/Tj2o6qanZiUa4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1Oc1o2BprDsf+R0c5NF3cLXHK2fzvpTNLsf8cda94pVN+C976RNN7KDEw3/gaJILUmmzYAKoScVwmCSoOfjDup/kLEjsoiDk5LiDvEzDt7IJwSpjYawadDX+hVXnGSxJN+z3Ha/CwGmgEZ+VpxFB/FkCsAEAEv9IFev6A3Otvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zYnnyBYd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DLOzoVB9qX9ySO7x5ntESOm7+Nok7ZNPoeq/iqxsdkg=; b=zYnnyBYdSVNKQ2KRCf3Bct3s9q
	4G6WmJkkr1M9cOURLjKIouk/EEjIn8XF0+dre8UuF991cQoaM5Bjldx3kR96vAqAx3fcS6LtqKLq8
	UBOhcquoBGE2mRsWMiQBz/D2tqNiCp8vFZ/Cis5YUSM4/HvKo6i+Yk0tj+SsVZ1g9Lzdg1PaQ9Ud6
	H8od50iipkViYeDVvj5cmKia5sg65MgAFpwOr7U8qqabwUdsJSx9QnsXjMOX7qOO6nOqFgSJX8tQl
	mKqihD1iWUrxoiQOxQOqxPEPUZCOyVAL4pVZqCjDQYbb6hxOsT9J0B6Qko28pjN4ryi8qKSf/w3+Z
	guKwRo4w==;
Received: from [212.185.66.19] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t9RCR-0000000B5c8-2ERS;
	Fri, 08 Nov 2024 15:47:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: pre-calculate max_zone_append_sectors
Date: Fri,  8 Nov 2024 16:46:51 +0100
Message-ID: <20241108154657.845768-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154657.845768-1-hch@lst.de>
References: <20241108154657.845768-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

max_zone_append_sectors differs from all other queue limits in that the
final value used is not stored in the queue_limits but needs to be
obtained using queue_limits_max_zone_append_sectors helper.  This not
only adds (tiny) extra overhead to the I/O path, but also can be easily
forgotten in file system code.

Add a new max_hw_zone_append_sectors value to queue_limits which is
set by the driver, and calculate max_zone_append_sectors from that and
the other inputs in blk_validate_zoned_limits, similar to how
max_sectors is calculated to fix this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20241104073955.112324-3-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c               |  2 +-
 block/blk-merge.c              |  3 +--
 block/blk-settings.c           | 27 +++++++++++++--------------
 block/blk-sysfs.c              | 17 +++--------------
 drivers/block/null_blk/zoned.c |  2 +-
 drivers/block/ublk_drv.c       |  2 +-
 drivers/block/virtio_blk.c     |  2 +-
 drivers/md/dm-zone.c           |  4 ++--
 drivers/nvme/host/multipath.c  |  2 +-
 drivers/nvme/host/zns.c        |  2 +-
 drivers/scsi/sd_zbc.c          |  2 --
 include/linux/blkdev.h         | 21 +++------------------
 12 files changed, 28 insertions(+), 58 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4f791a3114a1..0387172e8259 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -607,7 +607,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 		return BLK_STS_IOERR;
 
 	/* Make sure the BIO is small enough and will not get split */
-	if (nr_sectors > queue_max_zone_append_sectors(q))
+	if (nr_sectors > q->limits.max_zone_append_sectors)
 		return BLK_STS_IOERR;
 
 	bio->bi_opf |= REQ_NOMERGE;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index d813d799cee7..7c1375a080ad 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -388,11 +388,10 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 struct bio *bio_split_zone_append(struct bio *bio,
 		const struct queue_limits *lim, unsigned *nr_segs)
 {
-	unsigned int max_sectors = queue_limits_max_zone_append_sectors(lim);
 	int split_sectors;
 
 	split_sectors = bio_split_rw_at(bio, lim, nr_segs,
-			max_sectors << SECTOR_SHIFT);
+			lim->max_zone_append_sectors << SECTOR_SHIFT);
 	if (WARN_ON_ONCE(split_sectors > 0))
 		split_sectors = -EINVAL;
 	return bio_submit_split(bio, split_sectors);
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 5ee3d6d1448d..7d6b296997c2 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -50,7 +50,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_sectors = UINT_MAX;
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
-	lim->max_zone_append_sectors = UINT_MAX;
+	lim->max_hw_zone_append_sectors = UINT_MAX;
 	lim->max_user_discard_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
@@ -91,17 +91,16 @@ static int blk_validate_zoned_limits(struct queue_limits *lim)
 	if (lim->zone_write_granularity < lim->logical_block_size)
 		lim->zone_write_granularity = lim->logical_block_size;
 
-	if (lim->max_zone_append_sectors) {
-		/*
-		 * The Zone Append size is limited by the maximum I/O size
-		 * and the zone size given that it can't span zones.
-		 */
-		lim->max_zone_append_sectors =
-			min3(lim->max_hw_sectors,
-			     lim->max_zone_append_sectors,
-			     lim->chunk_sectors);
-	}
-
+	/*
+	 * The Zone Append size is limited by the maximum I/O size and the zone
+	 * size given that it can't span zones.
+	 *
+	 * If no max_hw_zone_append_sectors limit is provided, the block layer
+	 * will emulated it, else we're also bound by the hardware limit.
+	 */
+	lim->max_zone_append_sectors =
+		min_not_zero(lim->max_hw_zone_append_sectors,
+			min(lim->chunk_sectors, lim->max_hw_sectors));
 	return 0;
 }
 
@@ -527,8 +526,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
 	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
 					b->max_write_zeroes_sectors);
-	t->max_zone_append_sectors = min(queue_limits_max_zone_append_sectors(t),
-					 queue_limits_max_zone_append_sectors(b));
+	t->max_hw_zone_append_sectors = min(t->max_hw_zone_append_sectors,
+					b->max_hw_zone_append_sectors);
 
 	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
 					    b->seg_boundary_mask);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 0ef4e13e247d..d80a202cd170 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -131,6 +131,7 @@ QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_hw_discard_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_write_zeroes_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(atomic_write_max_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(atomic_write_boundary_sectors)
+QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_zone_append_sectors)
 
 #define QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_KB(_field)			\
 static ssize_t queue_##_field##_show(struct gendisk *disk, char *page)	\
@@ -178,18 +179,6 @@ static ssize_t queue_max_discard_sectors_store(struct gendisk *disk,
 	return ret;
 }
 
-/*
- * For zone append queue_max_zone_append_sectors does not just return the
- * underlying queue limits, but actually contains a calculation.  Because of
- * that we can't simply use QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES here.
- */
-static ssize_t queue_zone_append_max_show(struct gendisk *disk, char *page)
-{
-	return sprintf(page, "%llu\n",
-		(u64)queue_max_zone_append_sectors(disk->queue) <<
-			SECTOR_SHIFT);
-}
-
 static ssize_t
 queue_max_sectors_store(struct gendisk *disk, const char *page, size_t count)
 {
@@ -479,7 +468,7 @@ QUEUE_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
 
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_max_write_zeroes_sectors, "write_zeroes_max_bytes");
-QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
+QUEUE_RO_ENTRY(queue_max_zone_append_sectors, "zone_append_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
 
 QUEUE_RO_ENTRY(queue_zoned, "zoned");
@@ -607,7 +596,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_atomic_write_unit_max_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_max_write_zeroes_sectors_entry.attr,
-	&queue_zone_append_max_entry.attr,
+	&queue_max_zone_append_sectors_entry.attr,
 	&queue_zone_write_granularity_entry.attr,
 	&queue_rotational_entry.attr,
 	&queue_zoned_entry.attr,
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 9bc768b2ca56..0d5f9bf95229 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -166,7 +166,7 @@ int null_init_zoned_dev(struct nullb_device *dev,
 
 	lim->features |= BLK_FEAT_ZONED;
 	lim->chunk_sectors = dev->zone_size_sects;
-	lim->max_zone_append_sectors = dev->zone_append_max_sectors;
+	lim->max_hw_zone_append_sectors = dev->zone_append_max_sectors;
 	lim->max_open_zones = dev->zone_max_open;
 	lim->max_active_zones = dev->zone_max_active;
 	return 0;
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 59951e7c2593..8d938b2b41ee 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2270,7 +2270,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 		lim.features |= BLK_FEAT_ZONED;
 		lim.max_active_zones = p->max_active_zones;
 		lim.max_open_zones =  p->max_open_zones;
-		lim.max_zone_append_sectors = p->max_zone_append_sectors;
+		lim.max_hw_zone_append_sectors = p->max_zone_append_sectors;
 	}
 
 	if (ub->params.basic.attrs & UBLK_ATTR_VOLATILE_CACHE) {
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 194417abc105..0e99a4714928 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -784,7 +784,7 @@ static int virtblk_read_zoned_limits(struct virtio_blk *vblk,
 			wg, v);
 		return -ENODEV;
 	}
-	lim->max_zone_append_sectors = v;
+	lim->max_hw_zone_append_sectors = v;
 	dev_dbg(&vdev->dev, "max append sectors = %u\n", v);
 
 	return 0;
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index c0d41c36e06e..20edd3fabbab 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -344,7 +344,7 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q,
 		clear_bit(DMF_EMULATE_ZONE_APPEND, &md->flags);
 	} else {
 		set_bit(DMF_EMULATE_ZONE_APPEND, &md->flags);
-		lim->max_zone_append_sectors = 0;
+		lim->max_hw_zone_append_sectors = 0;
 	}
 
 	/*
@@ -379,7 +379,7 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q,
 	if (!zlim.mapped_nr_seq_zones) {
 		lim->max_open_zones = 0;
 		lim->max_active_zones = 0;
-		lim->max_zone_append_sectors = 0;
+		lim->max_hw_zone_append_sectors = 0;
 		lim->zone_write_granularity = 0;
 		lim->chunk_sectors = 0;
 		lim->features &= ~BLK_FEAT_ZONED;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6a15873055b9..c26cb7d3a2e5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -636,7 +636,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	if (head->ids.csi == NVME_CSI_ZNS)
 		lim.features |= BLK_FEAT_ZONED;
 	else
-		lim.max_zone_append_sectors = 0;
+		lim.max_hw_zone_append_sectors = 0;
 
 	head->disk = blk_alloc_disk(&lim, ctrl->numa_node);
 	if (IS_ERR(head->disk))
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 9a06f9d98cd6..382949e18c6a 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -111,7 +111,7 @@ void nvme_update_zone_info(struct nvme_ns *ns, struct queue_limits *lim,
 	lim->features |= BLK_FEAT_ZONED;
 	lim->max_open_zones = zi->max_open_zones;
 	lim->max_active_zones = zi->max_active_zones;
-	lim->max_zone_append_sectors = ns->ctrl->max_zone_append;
+	lim->max_hw_zone_append_sectors = ns->ctrl->max_zone_append;
 	lim->chunk_sectors = ns->head->zsze =
 		nvme_lba_to_sect(ns->head, zi->zone_size);
 }
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index ee2b74238758..de5c54c057ec 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -634,8 +634,6 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, struct queue_limits *lim,
 		lim->max_open_zones = sdkp->zones_max_open;
 	lim->max_active_zones = 0;
 	lim->chunk_sectors = logical_to_sectors(sdkp->device, zone_blocks);
-	/* Enable block layer zone append emulation */
-	lim->max_zone_append_sectors = 0;
 
 	return 0;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1b51a7c92e9b..65f37ae70712 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -375,6 +375,7 @@ struct queue_limits {
 	unsigned int		max_user_discard_sectors;
 	unsigned int		max_secure_erase_sectors;
 	unsigned int		max_write_zeroes_sectors;
+	unsigned int		max_hw_zone_append_sectors;
 	unsigned int		max_zone_append_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
@@ -1208,25 +1209,9 @@ static inline unsigned int queue_max_segment_size(const struct request_queue *q)
 	return q->limits.max_segment_size;
 }
 
-static inline unsigned int
-queue_limits_max_zone_append_sectors(const struct queue_limits *l)
-{
-	unsigned int max_sectors = min(l->chunk_sectors, l->max_hw_sectors);
-
-	return min_not_zero(l->max_zone_append_sectors, max_sectors);
-}
-
-static inline unsigned int queue_max_zone_append_sectors(struct request_queue *q)
-{
-	if (!blk_queue_is_zoned(q))
-		return 0;
-
-	return queue_limits_max_zone_append_sectors(&q->limits);
-}
-
 static inline bool queue_emulates_zone_append(struct request_queue *q)
 {
-	return blk_queue_is_zoned(q) && !q->limits.max_zone_append_sectors;
+	return blk_queue_is_zoned(q) && !q->limits.max_hw_zone_append_sectors;
 }
 
 static inline bool bdev_emulates_zone_append(struct block_device *bdev)
@@ -1237,7 +1222,7 @@ static inline bool bdev_emulates_zone_append(struct block_device *bdev)
 static inline unsigned int
 bdev_max_zone_append_sectors(struct block_device *bdev)
 {
-	return queue_max_zone_append_sectors(bdev_get_queue(bdev));
+	return bdev_limits(bdev)->max_zone_append_sectors;
 }
 
 static inline unsigned int bdev_max_segments(struct block_device *bdev)
-- 
2.45.2


