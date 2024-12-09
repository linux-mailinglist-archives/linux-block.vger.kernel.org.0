Return-Path: <linux-block+bounces-15076-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B059E93D4
	for <lists+linux-block@lfdr.de>; Mon,  9 Dec 2024 13:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9FA165E3E
	for <lists+linux-block@lfdr.de>; Mon,  9 Dec 2024 12:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5900422758A;
	Mon,  9 Dec 2024 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ3rpvCJ"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E43922757D;
	Mon,  9 Dec 2024 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747069; cv=none; b=fQGWvJB2ExXLaWz5VdtXTKNldSo/3d6zi3ES/onA8szevxIiu5wQyK59CuqH0ZWMYruKxdKkCeUv+H93d/HukwJQe+rnA7VvO8au3XQ1MhvZfMCwGexECs5E7oJY+i6XaiX3axrlzOGqWJ0EOU3THMPrOZOwV7Q6/D5IzhVEufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747069; c=relaxed/simple;
	bh=KP7YJfx4jlq/RtTgoQLHinAcrkUP/+qsDxzyYc7Wplk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXxRUeyeaU2V6tj7VHNSPj9nN5mxDXZ4pxSDnO2lR2qNbXToXt1Z9JZlAQzhjaB4BDL42AuQu2Q3jmCmpPVibwauBHPyzxtm+YjuKfanennC6PXPboL6tp9hf7EBgaM3N4M303PiQpHng8hg/McpoFBh2ZWQ//lKWpjHuWf29AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ3rpvCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6E5C4CEDE;
	Mon,  9 Dec 2024 12:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733747068;
	bh=KP7YJfx4jlq/RtTgoQLHinAcrkUP/+qsDxzyYc7Wplk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQ3rpvCJW0nhu/RcebUlg9/IHH/ZFLpMSa3rgnybrSL9p5mtHk+/E8m30T+QNxTbs
	 jLwf5TKdaCG62IQOoYuGy+/RxEMJKYt2j/Suv7I8jEHHOQxsYKG9jx95RVazVvniAq
	 AsY6bkXMVgXZrFdQJTLeztcJxbLQ7Szla1lVO+j4dbSPop69tNL30l4z67LiK76lNn
	 TXIgELf5QLt0xO7PHNhBZzIjI9jVcS2foQncu3naMBRfYQt0DWKzFxrdHFIv2yBdD8
	 XYqH91R7bg/p592yjRXWUBmBVMGwIAEGqqXO4AtGnQ8IGzurNHSHvxJqC1ZV8OsvUM
	 QRdE8uAfqXpLw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev
Cc: Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 3/4] dm: Fix dm-zoned-reclaim zone write pointer alignment
Date: Mon,  9 Dec 2024 21:23:56 +0900
Message-ID: <20241209122357.47838-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209122357.47838-1-dlemoal@kernel.org>
References: <20241209122357.47838-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The zone reclaim processing of the dm-zoned device mapper uses
blkdev_issue_zeroout() to align the write pointer of a zone being used
for reclaiming another zone, to write the valid data blocks from the
zone being reclaimed at the same position relative to the zone start in
the reclaim target zone.

The first call to blkdev_issue_zeroout() will try to use hardware
offload using a REQ_OP_WRITE_ZEROES operation if the device reports a
non-zero max_write_zeroes_sectors queue limit. If this operation fails
because of the lack of hardware support, blkdev_issue_zeroout() falls
back to using a regular write operation with the zero-page as buffer.
Currently, such REQ_OP_WRITE_ZEROES failure is automatically handled by
the block layer zone write plugging code which will execute a report
zones operation to ensure that the write pointer of the target zone of
the failed operation has not changed and to "rewind" the zone write
pointer offset of the target zone as it was advanced when the write zero
operation was submitted. So the REQ_OP_WRITE_ZEROES failure does not
cause any issue and blkdev_issue_zeroout() works as expected.

However, since the automatic recovery of zone write pointers by the zone
write plugging code can potentially cause deadlocks with queue freeze
operations, a different recovery must be implemented in preparation for
the removal of zone write plugging report zones based recovery.

Do this by introducing the new function blk_zone_issue_zeroout(). This
function first calls blkdev_issue_zeroout() with the flag
BLKDEV_ZERO_NOFALLBACK to intercept failures on the first execution
which attempt to use the device hardware offload with the
REQ_OP_WRITE_ZEROES operation. If this attempt fails, a report zone
operation is issued to restore the zone write pointer offset of the
target zone to the correct position and blkdev_issue_zeroout() is called
again without the BLKDEV_ZERO_NOFALLBACK flag. The report zones
operation performing this recovery is implemented using the helper
function disk_zone_sync_wp_offset() which calls the gendisk report_zones
file operation with the callback disk_report_zones_cb(). This callback
updates the target write pointer offset of the target zone using the new
function disk_zone_wplug_sync_wp_offset().

dmz_reclaim_align_wp() is modified to change its call to
blkdev_issue_zeroout() to a call to blk_zone_issue_zeroout() without any
other change needed as the two functions are functionnally equivalent.

Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c             | 141 ++++++++++++++++++++++++++++------
 drivers/md/dm-zoned-reclaim.c |   6 +-
 include/linux/blkdev.h        |   3 +
 3 files changed, 124 insertions(+), 26 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ee9c67121c6c..781caca0381e 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -115,6 +115,30 @@ const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
 }
 EXPORT_SYMBOL_GPL(blk_zone_cond_str);
 
+struct disk_report_zones_cb_args {
+	struct gendisk	*disk;
+	report_zones_cb	user_cb;
+	void		*user_data;
+};
+
+static void disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
+					   struct blk_zone *zone);
+
+static int disk_report_zones_cb(struct blk_zone *zone, unsigned int idx,
+				void *data)
+{
+	struct disk_report_zones_cb_args *args = data;
+	struct gendisk *disk = args->disk;
+
+	if (disk->zone_wplugs_hash)
+		disk_zone_wplug_sync_wp_offset(disk, zone);
+
+	if (!args->user_cb)
+		return 0;
+
+	return args->user_cb(zone, idx, args->user_data);
+}
+
 /**
  * blkdev_report_zones - Get zones information
  * @bdev:	Target block device
@@ -694,6 +718,58 @@ static void disk_zone_wplug_set_wp_offset(struct gendisk *disk,
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 }
 
+static unsigned int blk_zone_wp_offset(struct blk_zone *zone)
+{
+	switch (zone->cond) {
+	case BLK_ZONE_COND_IMP_OPEN:
+	case BLK_ZONE_COND_EXP_OPEN:
+	case BLK_ZONE_COND_CLOSED:
+		return zone->wp - zone->start;
+	case BLK_ZONE_COND_FULL:
+		return zone->len;
+	case BLK_ZONE_COND_EMPTY:
+		return 0;
+	case BLK_ZONE_COND_NOT_WP:
+	case BLK_ZONE_COND_OFFLINE:
+	case BLK_ZONE_COND_READONLY:
+	default:
+		/*
+		 * Conventional, offline and read-only zones do not have a valid
+		 * write pointer.
+		 */
+		return UINT_MAX;
+	}
+}
+
+static void disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
+					   struct blk_zone *zone)
+{
+	struct blk_zone_wplug *zwplug;
+	unsigned long flags;
+
+	zwplug = disk_get_zone_wplug(disk, zone->start);
+	if (!zwplug)
+		return;
+
+	spin_lock_irqsave(&zwplug->lock, flags);
+	if (zwplug->flags & BLK_ZONE_WPLUG_ERROR)
+		disk_zone_wplug_set_wp_offset(disk, zwplug,
+					      blk_zone_wp_offset(zone));
+	spin_unlock_irqrestore(&zwplug->lock, flags);
+
+	disk_put_zone_wplug(zwplug);
+}
+
+static int disk_zone_sync_wp_offset(struct gendisk *disk, sector_t sector)
+{
+	struct disk_report_zones_cb_args args = {
+		.disk = disk,
+	};
+
+	return disk->fops->report_zones(disk, sector, 1,
+					disk_report_zones_cb, &args);
+}
+
 static bool blk_zone_wplug_handle_reset_or_finish(struct bio *bio,
 						  unsigned int wp_offset)
 {
@@ -1280,29 +1356,6 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 	disk_put_zone_wplug(zwplug);
 }
 
-static unsigned int blk_zone_wp_offset(struct blk_zone *zone)
-{
-	switch (zone->cond) {
-	case BLK_ZONE_COND_IMP_OPEN:
-	case BLK_ZONE_COND_EXP_OPEN:
-	case BLK_ZONE_COND_CLOSED:
-		return zone->wp - zone->start;
-	case BLK_ZONE_COND_FULL:
-		return zone->len;
-	case BLK_ZONE_COND_EMPTY:
-		return 0;
-	case BLK_ZONE_COND_NOT_WP:
-	case BLK_ZONE_COND_OFFLINE:
-	case BLK_ZONE_COND_READONLY:
-	default:
-		/*
-		 * Conventional, offline and read-only zones do not have a valid
-		 * write pointer.
-		 */
-		return UINT_MAX;
-	}
-}
-
 static int blk_zone_wplug_report_zone_cb(struct blk_zone *zone,
 					 unsigned int idx, void *data)
 {
@@ -1866,6 +1919,48 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 }
 EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
 
+/**
+ * blk_zone_issue_zeroout - zero-fill a block range in a zone
+ * @bdev:	blockdev to write
+ * @sector:	start sector
+ * @nr_sects:	number of sectors to write
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ *
+ * Description:
+ *  Zero-fill a block range in a zone (@sector must be equal to the zone write
+ *  pointer), handling potential errors due to the (initially unknown) lack of
+ *  hardware offload (See blkdev_issue_zeroout()).
+ */
+int blk_zone_issue_zeroout(struct block_device *bdev, sector_t sector,
+			   sector_t nr_sects, gfp_t gfp_mask)
+{
+	int ret;
+
+	if (WARN_ON_ONCE(!bdev_is_zoned(bdev)))
+		return -EIO;
+
+	ret = blkdev_issue_zeroout(bdev, sector, nr_sects, gfp_mask,
+				   BLKDEV_ZERO_NOFALLBACK);
+	if (ret != -EOPNOTSUPP)
+		return ret;
+
+	/*
+	 * The failed call to blkdev_issue_zeroout() advanced the zone write
+	 * pointer. Undo this using a report zone to update the zone write
+	 * pointer to the correct current value.
+	 */
+	ret = disk_zone_sync_wp_offset(bdev->bd_disk, sector);
+	if (ret != 1)
+		return ret < 0 ? ret : -EIO;
+
+	/*
+	 * Retry without BLKDEV_ZERO_NOFALLBACK to force the fallback to a
+	 * regular write with zero-pages.
+	 */
+	return blkdev_issue_zeroout(bdev, sector, nr_sects, gfp_mask, 0);
+}
+EXPORT_SYMBOL_GPL(blk_zone_issue_zeroout);
+
 #ifdef CONFIG_BLK_DEBUG_FS
 
 int queue_zone_wplugs_show(void *data, struct seq_file *m)
diff --git a/drivers/md/dm-zoned-reclaim.c b/drivers/md/dm-zoned-reclaim.c
index d58db9a27e6c..76e2c6868548 100644
--- a/drivers/md/dm-zoned-reclaim.c
+++ b/drivers/md/dm-zoned-reclaim.c
@@ -76,9 +76,9 @@ static int dmz_reclaim_align_wp(struct dmz_reclaim *zrc, struct dm_zone *zone,
 	 * pointer and the requested position.
 	 */
 	nr_blocks = block - wp_block;
-	ret = blkdev_issue_zeroout(dev->bdev,
-				   dmz_start_sect(zmd, zone) + dmz_blk2sect(wp_block),
-				   dmz_blk2sect(nr_blocks), GFP_NOIO, 0);
+	ret = blk_zone_issue_zeroout(dev->bdev,
+			dmz_start_sect(zmd, zone) + dmz_blk2sect(wp_block),
+			dmz_blk2sect(nr_blocks), GFP_NOIO);
 	if (ret) {
 		dmz_dev_err(dev,
 			    "Align zone %u wp %llu to %llu (wp+%u) blocks failed %d",
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 08a727b40816..4dd698dad2d6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1421,6 +1421,9 @@ static inline bool bdev_zone_is_seq(struct block_device *bdev, sector_t sector)
 	return is_seq;
 }
 
+int blk_zone_issue_zeroout(struct block_device *bdev, sector_t sector,
+			   sector_t nr_sects, gfp_t gfp_mask);
+
 static inline unsigned int queue_dma_alignment(const struct request_queue *q)
 {
 	return q->limits.dma_alignment;
-- 
2.47.1


