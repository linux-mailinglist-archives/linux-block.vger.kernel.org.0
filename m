Return-Path: <linux-block+bounces-15077-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257769E93D7
	for <lists+linux-block@lfdr.de>; Mon,  9 Dec 2024 13:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73B51887948
	for <lists+linux-block@lfdr.de>; Mon,  9 Dec 2024 12:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D86223711;
	Mon,  9 Dec 2024 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wb9MhOLz"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11C1222587;
	Mon,  9 Dec 2024 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747070; cv=none; b=RmzTH4mjGr+XVMgV1vlFN4BLbsS+xGMiRzRCMosIyFsCQA1sGfY7SQRySaeC6QacX0bdUQujQ/YwI2qzDLsk/FtW8XMBQK0gFynw1gX15Qju6qR8WiOhXHoVRlem8VCZ4/2nC6Z71+t3iO6r/1qVEJZc8YD6BFBX164MAlS/BbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747070; c=relaxed/simple;
	bh=h9qgCB1ArdePbTwkPP2uDIQ7xVm2U24vIbmCn7y/xZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYem7CffR8WzdkY/fQ5zz60EhC+Gl/1jy+NheMY0y0f6beoIviwZXqger2rzWFavTrPYd9qYq6tzHgZ/Ahc7OLZ4hc8qSuKCzV66TxAAjX0677hqtD/OmOLNJmD+jo/uE9jvDL7fb8bRgAFQ/o48fM7O2vBdv8+6qMEGRNAUxyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wb9MhOLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D49AC4CEE2;
	Mon,  9 Dec 2024 12:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733747070;
	bh=h9qgCB1ArdePbTwkPP2uDIQ7xVm2U24vIbmCn7y/xZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wb9MhOLzvxmSsXzAJZ6b8yneT1kS1TW+GlFsWgArho+YdYSSo74G35wvhkHiCsBgZ
	 Wg6c4DXt7Hg3iWJhMSgLqM5u9RopDzMe2NCKFRgovScshOPGHP69ORbj4rkN/E46eM
	 cFGOM0I/UJn70suPOvFO83YyFm8MLqKWp2/QytednIB5RaFdqKDQfkOUHpal0XKOyd
	 BEs0JwZagret5HtHhH0OGa9YNaB9uEOrkjCx69LZHK+Mua/oA2P1Nkx/J6kgRJ6DSY
	 BxrNR7/gK7KNnKe2TUZjynahLy2CWPgh4pnJH8cGxLqWt89YJspLPLQPeI38C3T4nV
	 EJOy1/Lfo+jcw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev
Cc: Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 4/4] block: Prevent potential deadlocks in zone write plug error recovery
Date: Mon,  9 Dec 2024 21:23:57 +0900
Message-ID: <20241209122357.47838-5-dlemoal@kernel.org>
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

Zone write plugging for handling writes to zones of a zoned block
device always execute a zone report whenever a write BIO to a zone
fails. The intent of this is to ensure that the tracking of a zone write
pointer is always correct to ensure that the alignment to a zone write
pointer of write BIOs can be checked on submission and that we can
always correctly emulate zone append operations using regular write
BIOs.

However, this error recovery scheme introduces a potential deadlock if a
device queue freeze is initiated while BIOs are still plugged in a zone
write plug and one of these write operation fails. In such case, the
disk zone write plug error recovery work is scheduled and executes a
report zone. This in turn can result in a request allocation in the
underlying driver to issue the report zones command to the device. But
with the device queue freeze already started, this allocation will
block, preventing the report zone execution and the continuation of the
processing of the plugged BIOs. As plugged BIOs hold a queue usage
reference, the queue freeze itself will never complete, resulting in a
deadlock.

Avoid this problem by completely removing from the zone write plugging
code the use of report zones operations after a failed write operation,
instead relying on the device user to either execute a report zones,
reset the zone, finish the zone, or give up writing to the device (which
is a fairly common pattern for file systems which degrade to read-only
after write failures). This is not an unreasonnable requirement as all
well-behaved applications, FSes and device mapper already use report
zones to recover from write errors whenever possible by comparing the
current position of a zone write pointer with what their assumption
about the position is.

The changes to remove the automatic error recovery are as follows:
 - Completely remove the error recovery work and its associated
   resources (zone write plug list head, disk error list, and disk
   zone_wplugs_work work struct). This also removes the functions
   disk_zone_wplug_set_error() and disk_zone_wplug_clear_error().

 - Change the BLK_ZONE_WPLUG_ERROR zone write plug flag into
   BLK_ZONE_WPLUG_NEED_WP_UPDATE. This new flag is set for a zone write
   plug whenever a write opration targetting the zone of the zone write
   plug fails. This flag indicates that the zone write pointer offset is
   not reliable and that it must be updated when the next report zone,
   reset zone, finish zone or disk revalidation is executed.

 - Modify blk_zone_write_plug_bio_endio() to set the
   BLK_ZONE_WPLUG_NEED_WP_UPDATE flag for the target zone of a failed
   write BIO.

 - Modify the function disk_zone_wplug_set_wp_offset() to clear this
   new flag, thus implementing recovery of a correct write pointer
   offset with the reset (all) zone and finish zone operations.

 - Modify blkdev_report_zones() to always use the disk_report_zones_cb()
   callback so that disk_zone_wplug_sync_wp_offset() can be called for
   any zone marked with the BLK_ZONE_WPLUG_NEED_WP_UPDATE flag.
   This implements recovery of a correct write pointer offset for zone
   write plugs marked with BLK_ZONE_WPLUG_NEED_WP_UPDATE and within
   the range of the report zones operation executed by the user.

 - Modify blk_revalidate_seq_zone() to call
   disk_zone_wplug_sync_wp_offset() for all sequential write required
   zones when a zoned block device is revalidated, thus always resolving
   any inconsistency between the write pointer offset of zone write
   plugs and the actual write pointer position of sequential zones.

Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c      | 308 ++++++++---------------------------------
 include/linux/blkdev.h |   2 -
 2 files changed, 61 insertions(+), 249 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 781caca0381e..77f12fc2086f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -41,7 +41,6 @@ static const char *const zone_cond_name[] = {
 /*
  * Per-zone write plug.
  * @node: hlist_node structure for managing the plug using a hash table.
- * @link: To list the plug in the zone write plug error list of the disk.
  * @ref: Zone write plug reference counter. A zone write plug reference is
  *       always at least 1 when the plug is hashed in the disk plug hash table.
  *       The reference is incremented whenever a new BIO needing plugging is
@@ -63,7 +62,6 @@ static const char *const zone_cond_name[] = {
  */
 struct blk_zone_wplug {
 	struct hlist_node	node;
-	struct list_head	link;
 	refcount_t		ref;
 	spinlock_t		lock;
 	unsigned int		flags;
@@ -80,8 +78,8 @@ struct blk_zone_wplug {
  *  - BLK_ZONE_WPLUG_PLUGGED: Indicates that the zone write plug is plugged,
  *    that is, that write BIOs are being throttled due to a write BIO already
  *    being executed or the zone write plug bio list is not empty.
- *  - BLK_ZONE_WPLUG_ERROR: Indicates that a write error happened which will be
- *    recovered with a report zone to update the zone write pointer offset.
+ *  - BLK_ZONE_WPLUG_NEED_WP_UPDATE: Indicates that we lost track of a zone
+ *    write pointer offset and need to update it.
  *  - BLK_ZONE_WPLUG_UNHASHED: Indicates that the zone write plug was removed
  *    from the disk hash table and that the initial reference to the zone
  *    write plug set when the plug was first added to the hash table has been
@@ -91,11 +89,9 @@ struct blk_zone_wplug {
  *    freed once all remaining references from BIOs or functions are dropped.
  */
 #define BLK_ZONE_WPLUG_PLUGGED		(1U << 0)
-#define BLK_ZONE_WPLUG_ERROR		(1U << 1)
+#define BLK_ZONE_WPLUG_NEED_WP_UPDATE	(1U << 1)
 #define BLK_ZONE_WPLUG_UNHASHED		(1U << 2)
 
-#define BLK_ZONE_WPLUG_BUSY	(BLK_ZONE_WPLUG_PLUGGED | BLK_ZONE_WPLUG_ERROR)
-
 /**
  * blk_zone_cond_str - Return string XXX in BLK_ZONE_COND_XXX.
  * @zone_cond: BLK_ZONE_COND_XXX.
@@ -163,6 +159,11 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 {
 	struct gendisk *disk = bdev->bd_disk;
 	sector_t capacity = get_capacity(disk);
+	struct disk_report_zones_cb_args args = {
+		.disk = disk,
+		.user_cb = cb,
+		.user_data = data,
+	};
 
 	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
 		return -EOPNOTSUPP;
@@ -170,7 +171,8 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 	if (!nr_zones || sector >= capacity)
 		return 0;
 
-	return disk->fops->report_zones(disk, sector, nr_zones, cb, data);
+	return disk->fops->report_zones(disk, sector, nr_zones,
+					disk_report_zones_cb, &args);
 }
 EXPORT_SYMBOL_GPL(blkdev_report_zones);
 
@@ -451,7 +453,7 @@ static inline void disk_put_zone_wplug(struct blk_zone_wplug *zwplug)
 {
 	if (refcount_dec_and_test(&zwplug->ref)) {
 		WARN_ON_ONCE(!bio_list_empty(&zwplug->bio_list));
-		WARN_ON_ONCE(!list_empty(&zwplug->link));
+		WARN_ON_ONCE(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED);
 		WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_UNHASHED));
 
 		call_rcu(&zwplug->rcu_head, disk_free_zone_wplug_rcu);
@@ -465,8 +467,8 @@ static inline bool disk_should_remove_zone_wplug(struct gendisk *disk,
 	if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED)
 		return false;
 
-	/* If the zone write plug is still busy, it cannot be removed. */
-	if (zwplug->flags & BLK_ZONE_WPLUG_BUSY)
+	/* If the zone write plug is still plugged, it cannot be removed. */
+	if (zwplug->flags & BLK_ZONE_WPLUG_PLUGGED)
 		return false;
 
 	/*
@@ -549,7 +551,6 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
 		return NULL;
 
 	INIT_HLIST_NODE(&zwplug->node);
-	INIT_LIST_HEAD(&zwplug->link);
 	refcount_set(&zwplug->ref, 2);
 	spin_lock_init(&zwplug->lock);
 	zwplug->flags = 0;
@@ -598,115 +599,22 @@ static void disk_zone_wplug_abort(struct blk_zone_wplug *zwplug)
 }
 
 /*
- * Abort (fail) all plugged BIOs of a zone write plug that are not aligned
- * with the assumed write pointer location of the zone when the BIO will
- * be unplugged.
- */
-static void disk_zone_wplug_abort_unaligned(struct gendisk *disk,
-					    struct blk_zone_wplug *zwplug)
-{
-	unsigned int wp_offset = zwplug->wp_offset;
-	struct bio_list bl = BIO_EMPTY_LIST;
-	struct bio *bio;
-
-	while ((bio = bio_list_pop(&zwplug->bio_list))) {
-		if (disk_zone_is_full(disk, zwplug->zone_no, wp_offset) ||
-		    (bio_op(bio) != REQ_OP_ZONE_APPEND &&
-		     bio_offset_from_zone_start(bio) != wp_offset)) {
-			blk_zone_wplug_bio_io_error(zwplug, bio);
-			continue;
-		}
-
-		wp_offset += bio_sectors(bio);
-		bio_list_add(&bl, bio);
-	}
-
-	bio_list_merge(&zwplug->bio_list, &bl);
-}
-
-static inline void disk_zone_wplug_set_error(struct gendisk *disk,
-					     struct blk_zone_wplug *zwplug)
-{
-	unsigned long flags;
-
-	if (zwplug->flags & BLK_ZONE_WPLUG_ERROR)
-		return;
-
-	/*
-	 * At this point, we already have a reference on the zone write plug.
-	 * However, since we are going to add the plug to the disk zone write
-	 * plugs work list, increase its reference count. This reference will
-	 * be dropped in disk_zone_wplugs_work() once the error state is
-	 * handled, or in disk_zone_wplug_clear_error() if the zone is reset or
-	 * finished.
-	 */
-	zwplug->flags |= BLK_ZONE_WPLUG_ERROR;
-	refcount_inc(&zwplug->ref);
-
-	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
-	list_add_tail(&zwplug->link, &disk->zone_wplugs_err_list);
-	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
-}
-
-static inline void disk_zone_wplug_clear_error(struct gendisk *disk,
-					       struct blk_zone_wplug *zwplug)
-{
-	unsigned long flags;
-
-	if (!(zwplug->flags & BLK_ZONE_WPLUG_ERROR))
-		return;
-
-	/*
-	 * We are racing with the error handling work which drops the reference
-	 * on the zone write plug after handling the error state. So remove the
-	 * plug from the error list and drop its reference count only if the
-	 * error handling has not yet started, that is, if the zone write plug
-	 * is still listed.
-	 */
-	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
-	if (!list_empty(&zwplug->link)) {
-		list_del_init(&zwplug->link);
-		zwplug->flags &= ~BLK_ZONE_WPLUG_ERROR;
-		disk_put_zone_wplug(zwplug);
-	}
-	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
-}
-
-/*
- * Set a zone write plug write pointer offset to either 0 (zone reset case)
- * or to the zone size (zone finish case). This aborts all plugged BIOs, which
- * is fine to do as doing a zone reset or zone finish while writes are in-flight
- * is a mistake from the user which will most likely cause all plugged BIOs to
- * fail anyway.
+ * Set a zone write plug write pointer offset to the specified value.
+ * This aborts all plugged BIOs, which is fine as this function is called for
+ * a zone reset operation, a zone finish operation or if the zone needs a wp
+ * update from a report zone after a write error.
  */
 static void disk_zone_wplug_set_wp_offset(struct gendisk *disk,
 					  struct blk_zone_wplug *zwplug,
 					  unsigned int wp_offset)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&zwplug->lock, flags);
-
-	/*
-	 * Make sure that a BIO completion or another zone reset or finish
-	 * operation has not already removed the plug from the hash table.
-	 */
-	if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED) {
-		spin_unlock_irqrestore(&zwplug->lock, flags);
-		return;
-	}
+	lockdep_assert_held(&zwplug->lock);
 
 	/* Update the zone write pointer and abort all plugged BIOs. */
+	zwplug->flags &= ~BLK_ZONE_WPLUG_NEED_WP_UPDATE;
 	zwplug->wp_offset = wp_offset;
 	disk_zone_wplug_abort(zwplug);
 
-	/*
-	 * Updating the write pointer offset puts back the zone
-	 * in a good state. So clear the error flag and decrement the
-	 * error count if we were in error state.
-	 */
-	disk_zone_wplug_clear_error(disk, zwplug);
-
 	/*
 	 * The zone write plug now has no BIO plugged: remove it from the
 	 * hash table so that it cannot be seen. The plug will be freed
@@ -714,8 +622,6 @@ static void disk_zone_wplug_set_wp_offset(struct gendisk *disk,
 	 */
 	if (disk_should_remove_zone_wplug(disk, zwplug))
 		disk_remove_zone_wplug(disk, zwplug);
-
-	spin_unlock_irqrestore(&zwplug->lock, flags);
 }
 
 static unsigned int blk_zone_wp_offset(struct blk_zone *zone)
@@ -752,7 +658,7 @@ static void disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
 		return;
 
 	spin_lock_irqsave(&zwplug->lock, flags);
-	if (zwplug->flags & BLK_ZONE_WPLUG_ERROR)
+	if (zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE)
 		disk_zone_wplug_set_wp_offset(disk, zwplug,
 					      blk_zone_wp_offset(zone));
 	spin_unlock_irqrestore(&zwplug->lock, flags);
@@ -776,6 +682,7 @@ static bool blk_zone_wplug_handle_reset_or_finish(struct bio *bio,
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 	sector_t sector = bio->bi_iter.bi_sector;
 	struct blk_zone_wplug *zwplug;
+	unsigned long flags;
 
 	/* Conventional zones cannot be reset nor finished. */
 	if (!bdev_zone_is_seq(bio->bi_bdev, sector)) {
@@ -801,7 +708,9 @@ static bool blk_zone_wplug_handle_reset_or_finish(struct bio *bio,
 	 */
 	zwplug = disk_get_zone_wplug(disk, sector);
 	if (zwplug) {
+		spin_lock_irqsave(&zwplug->lock, flags);
 		disk_zone_wplug_set_wp_offset(disk, zwplug, wp_offset);
+		spin_unlock_irqrestore(&zwplug->lock, flags);
 		disk_put_zone_wplug(zwplug);
 	}
 
@@ -812,6 +721,7 @@ static bool blk_zone_wplug_handle_reset_all(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 	struct blk_zone_wplug *zwplug;
+	unsigned long flags;
 	sector_t sector;
 
 	/*
@@ -823,7 +733,9 @@ static bool blk_zone_wplug_handle_reset_all(struct bio *bio)
 	     sector += disk->queue->limits.chunk_sectors) {
 		zwplug = disk_get_zone_wplug(disk, sector);
 		if (zwplug) {
+			spin_lock_irqsave(&zwplug->lock, flags);
 			disk_zone_wplug_set_wp_offset(disk, zwplug, 0);
+			spin_unlock_irqrestore(&zwplug->lock, flags);
 			disk_put_zone_wplug(zwplug);
 		}
 	}
@@ -1005,13 +917,23 @@ static bool blk_zone_wplug_prepare_bio(struct blk_zone_wplug *zwplug,
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 
+	/*
+	 * If we lost track of the zone write pointer due to a write error,
+	 * the user must either execute a report zones, reset the zone or finish
+	 * the to recover a reliable write pointer position. Fail BIOs if the
+	 * user did not do that as we cannot handle emulated zone append
+	 * otherwise.
+	 */
+	if (zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE)
+		return false;
+
 	/*
 	 * Check that the user is not attempting to write to a full zone.
 	 * We know such BIO will fail, and that would potentially overflow our
 	 * write pointer offset beyond the end of the zone.
 	 */
 	if (disk_zone_wplug_is_full(disk, zwplug))
-		goto err;
+		return false;
 
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 		/*
@@ -1030,24 +952,18 @@ static bool blk_zone_wplug_prepare_bio(struct blk_zone_wplug *zwplug,
 		bio_set_flag(bio, BIO_EMULATES_ZONE_APPEND);
 	} else {
 		/*
-		 * Check for non-sequential writes early because we avoid a
-		 * whole lot of error handling trouble if we don't send it off
-		 * to the driver.
+		 * Check for non-sequential writes early as we know that BIOs
+		 * with a start sector not unaligned to the zone write pointer
+		 * will fail.
 		 */
 		if (bio_offset_from_zone_start(bio) != zwplug->wp_offset)
-			goto err;
+			return false;
 	}
 
 	/* Advance the zone write pointer offset. */
 	zwplug->wp_offset += bio_sectors(bio);
 
 	return true;
-
-err:
-	/* We detected an invalid write BIO: schedule error recovery. */
-	disk_zone_wplug_set_error(disk, zwplug);
-	kblockd_schedule_work(&disk->zone_wplugs_work);
-	return false;
 }
 
 static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
@@ -1097,20 +1013,20 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 	bio_set_flag(bio, BIO_ZONE_WRITE_PLUGGING);
 
 	/*
-	 * If the zone is already plugged or has a pending error, add the BIO
-	 * to the plug BIO list. Do the same for REQ_NOWAIT BIOs to ensure that
-	 * we will not see a BLK_STS_AGAIN failure if we let the BIO execute.
+	 * If the zone is already plugged, add the BIO to the plug BIO list.
+	 * Do the same for REQ_NOWAIT BIOs to ensure that we will not see a
+	 * BLK_STS_AGAIN failure if we let the BIO execute.
 	 * Otherwise, plug and let the BIO execute.
 	 */
-	if (zwplug->flags & BLK_ZONE_WPLUG_BUSY || (bio->bi_opf & REQ_NOWAIT))
+	if ((zwplug->flags & BLK_ZONE_WPLUG_PLUGGED) ||
+	    (bio->bi_opf & REQ_NOWAIT))
 		goto plug;
 
-	/*
-	 * If an error is detected when preparing the BIO, add it to the BIO
-	 * list so that error recovery can deal with it.
-	 */
-	if (!blk_zone_wplug_prepare_bio(zwplug, bio))
-		goto plug;
+	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
+		spin_unlock_irqrestore(&zwplug->lock, flags);
+		bio_io_error(bio);
+		return true;
+	}
 
 	zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
 
@@ -1210,16 +1126,6 @@ static void disk_zone_wplug_unplug_bio(struct gendisk *disk,
 
 	spin_lock_irqsave(&zwplug->lock, flags);
 
-	/*
-	 * If we had an error, schedule error recovery. The recovery work
-	 * will restart submission of plugged BIOs.
-	 */
-	if (zwplug->flags & BLK_ZONE_WPLUG_ERROR) {
-		spin_unlock_irqrestore(&zwplug->lock, flags);
-		kblockd_schedule_work(&disk->zone_wplugs_work);
-		return;
-	}
-
 	/* Schedule submission of the next plugged BIO if we have one. */
 	if (!bio_list_empty(&zwplug->bio_list)) {
 		disk_zone_wplug_schedule_bio_work(disk, zwplug);
@@ -1262,12 +1168,13 @@ void blk_zone_write_plug_bio_endio(struct bio *bio)
 	}
 
 	/*
-	 * If the BIO failed, mark the plug as having an error to trigger
-	 * recovery.
+	 * If the BIO failed, abort all plugged BIOs and mark the plug as
+	 * needing a write pointer update.
 	 */
 	if (bio->bi_status != BLK_STS_OK) {
 		spin_lock_irqsave(&zwplug->lock, flags);
-		disk_zone_wplug_set_error(disk, zwplug);
+		disk_zone_wplug_abort(zwplug);
+		zwplug->flags |= BLK_ZONE_WPLUG_NEED_WP_UPDATE;
 		spin_unlock_irqrestore(&zwplug->lock, flags);
 	}
 
@@ -1323,6 +1230,7 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 	 */
 	spin_lock_irqsave(&zwplug->lock, flags);
 
+again:
 	bio = bio_list_pop(&zwplug->bio_list);
 	if (!bio) {
 		zwplug->flags &= ~BLK_ZONE_WPLUG_PLUGGED;
@@ -1331,10 +1239,8 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 	}
 
 	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
-		/* Error recovery will decide what to do with the BIO. */
-		bio_list_add_head(&zwplug->bio_list, bio);
-		spin_unlock_irqrestore(&zwplug->lock, flags);
-		goto put_zwplug;
+		blk_zone_wplug_bio_io_error(zwplug, bio);
+		goto again;
 	}
 
 	spin_unlock_irqrestore(&zwplug->lock, flags);
@@ -1356,97 +1262,6 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 	disk_put_zone_wplug(zwplug);
 }
 
-static int blk_zone_wplug_report_zone_cb(struct blk_zone *zone,
-					 unsigned int idx, void *data)
-{
-	struct blk_zone *zonep = data;
-
-	*zonep = *zone;
-	return 0;
-}
-
-static void disk_zone_wplug_handle_error(struct gendisk *disk,
-					 struct blk_zone_wplug *zwplug)
-{
-	sector_t zone_start_sector =
-		bdev_zone_sectors(disk->part0) * zwplug->zone_no;
-	unsigned int noio_flag;
-	struct blk_zone zone;
-	unsigned long flags;
-	int ret;
-
-	/* Get the current zone information from the device. */
-	noio_flag = memalloc_noio_save();
-	ret = disk->fops->report_zones(disk, zone_start_sector, 1,
-				       blk_zone_wplug_report_zone_cb, &zone);
-	memalloc_noio_restore(noio_flag);
-
-	spin_lock_irqsave(&zwplug->lock, flags);
-
-	/*
-	 * A zone reset or finish may have cleared the error already. In such
-	 * case, do nothing as the report zones may have seen the "old" write
-	 * pointer value before the reset/finish operation completed.
-	 */
-	if (!(zwplug->flags & BLK_ZONE_WPLUG_ERROR))
-		goto unlock;
-
-	zwplug->flags &= ~BLK_ZONE_WPLUG_ERROR;
-
-	if (ret != 1) {
-		/*
-		 * We failed to get the zone information, meaning that something
-		 * is likely really wrong with the device. Abort all remaining
-		 * plugged BIOs as otherwise we could endup waiting forever on
-		 * plugged BIOs to complete if there is a queue freeze on-going.
-		 */
-		disk_zone_wplug_abort(zwplug);
-		goto unplug;
-	}
-
-	/* Update the zone write pointer offset. */
-	zwplug->wp_offset = blk_zone_wp_offset(&zone);
-	disk_zone_wplug_abort_unaligned(disk, zwplug);
-
-	/* Restart BIO submission if we still have any BIO left. */
-	if (!bio_list_empty(&zwplug->bio_list)) {
-		disk_zone_wplug_schedule_bio_work(disk, zwplug);
-		goto unlock;
-	}
-
-unplug:
-	zwplug->flags &= ~BLK_ZONE_WPLUG_PLUGGED;
-	if (disk_should_remove_zone_wplug(disk, zwplug))
-		disk_remove_zone_wplug(disk, zwplug);
-
-unlock:
-	spin_unlock_irqrestore(&zwplug->lock, flags);
-}
-
-static void disk_zone_wplugs_work(struct work_struct *work)
-{
-	struct gendisk *disk =
-		container_of(work, struct gendisk, zone_wplugs_work);
-	struct blk_zone_wplug *zwplug;
-	unsigned long flags;
-
-	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
-
-	while (!list_empty(&disk->zone_wplugs_err_list)) {
-		zwplug = list_first_entry(&disk->zone_wplugs_err_list,
-					  struct blk_zone_wplug, link);
-		list_del_init(&zwplug->link);
-		spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
-
-		disk_zone_wplug_handle_error(disk, zwplug);
-		disk_put_zone_wplug(zwplug);
-
-		spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
-	}
-
-	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
-}
-
 static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
 {
 	return 1U << disk->zone_wplugs_hash_bits;
@@ -1455,8 +1270,6 @@ static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
 void disk_init_zone_resources(struct gendisk *disk)
 {
 	spin_lock_init(&disk->zone_wplugs_lock);
-	INIT_LIST_HEAD(&disk->zone_wplugs_err_list);
-	INIT_WORK(&disk->zone_wplugs_work, disk_zone_wplugs_work);
 }
 
 /*
@@ -1555,8 +1368,6 @@ void disk_free_zone_resources(struct gendisk *disk)
 	if (!disk->zone_wplugs_pool)
 		return;
 
-	cancel_work_sync(&disk->zone_wplugs_work);
-
 	if (disk->zone_wplugs_wq) {
 		destroy_workqueue(disk->zone_wplugs_wq);
 		disk->zone_wplugs_wq = NULL;
@@ -1753,6 +1564,8 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone, unsigned int idx,
 	if (!disk->zone_wplugs_hash)
 		return 0;
 
+	disk_zone_wplug_sync_wp_offset(disk, zone);
+
 	wp_offset = blk_zone_wp_offset(zone);
 	if (!wp_offset || wp_offset >= zone->capacity)
 		return 0;
@@ -1883,6 +1696,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		memalloc_noio_restore(noio_flag);
 		return ret;
 	}
+
 	ret = disk->fops->report_zones(disk, 0, UINT_MAX,
 				       blk_revalidate_zone_cb, &args);
 	if (!ret) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4dd698dad2d6..378d3a1a22fc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -200,8 +200,6 @@ struct gendisk {
 	spinlock_t              zone_wplugs_lock;
 	struct mempool_s	*zone_wplugs_pool;
 	struct hlist_head       *zone_wplugs_hash;
-	struct list_head        zone_wplugs_err_list;
-	struct work_struct	zone_wplugs_work;
 	struct workqueue_struct *zone_wplugs_wq;
 #endif /* CONFIG_BLK_DEV_ZONED */
 
-- 
2.47.1


