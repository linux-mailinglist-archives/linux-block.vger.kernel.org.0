Return-Path: <linux-block+bounces-17236-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E89A3559D
	for <lists+linux-block@lfdr.de>; Fri, 14 Feb 2025 05:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94813AB283
	for <lists+linux-block@lfdr.de>; Fri, 14 Feb 2025 04:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E5314B088;
	Fri, 14 Feb 2025 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoCB8Z9U"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF5914658D
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739506477; cv=none; b=HVILumlWgX3OWD2dv61znI3quxt0qvhV4sNp2WhpzaI0LkHioeK1rKi6xP0BvIPY3tix1Lz5B5uqam86HQ5Q5FsvfD/VVJEELdMMoFXtVPS2eCqRSXU1Qoqz3J366HlP3ZayDx0alYgGDbo2LBUuIbhXiKDT1pWlGC8OYqPWnd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739506477; c=relaxed/simple;
	bh=47AE2VrMBZNp+I+b5SkvSxARORyDw1OLxrIGAEHa52E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aNbNW5F1XbgKOaw/sAmpOOF9u9AfLBDv7k+9KIJo98V4A8vnZPqJwL49yU/R9TyhnlNaxwLvSfyvN0vt5CRTSs8UuY0ZrlItV6Bw6einDrROQ85hAqrjIEQI8/Mp/HPihDJmXITZ7vtWBMbvK0yyW8srxRxMpJO18ZH1BGKh0FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoCB8Z9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8992CC4CEDD;
	Fri, 14 Feb 2025 04:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739506477;
	bh=47AE2VrMBZNp+I+b5SkvSxARORyDw1OLxrIGAEHa52E=;
	h=From:To:Cc:Subject:Date:From;
	b=SoCB8Z9UbmWDvNFrhC4m+mBrdonwqPhgDBSUDKMcAiBLlZBWnHy0Jghl7I5p763gR
	 aPygCDwOaXOSkYNXFL0rK3HoVVVMHRzG8eog4XUPYLGLWRmZEp3I2zka/9MCPePnHM
	 w+fCcKXKeDX/NniCRUlz3IG/P++1a7srh8gm4s4+4Uav2t+uxO3BfxaMYlTWl8lW6U
	 haxAeU/AmcaHd044mX4URlGVqEahfER4pW47U5yXPa2WJXYKf3gG3DvE3vwl72LWd9
	 zwdS3GcFhPOk5nNAeSbUnjMNoo6N68UoLEayqRFwfuZ5Gx29H2w1twlX439JJDR3vJ
	 PkbBeEe+ydy0g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Jorgen Hansen <Jorgen.Hansen@wdc.com>
Subject: [PATCH] block: Remove zone write plugs when handling native zone append writes
Date: Fri, 14 Feb 2025 13:14:34 +0900
Message-ID: <20250214041434.82564-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For devices that natively support zone append operations,
REQ_OP_ZONE_APPEND BIOs are not processed through zone write plugging
and are immediately issued to the zoned device. This means that there is
no write pointer offset tracking done for these operations and that a
zone write plug is not necessary.

However, when receiving a zone append BIO, we may already have a zone
write plug for the target zone if that zone was previously partially
written using regular write operations. In such case, since the write
pointer offset of the zone write plug is not incremented by the amount
of sectors appended to the zone, 2 issues arise:
1) we risk leaving the plug in the disk hash table if the zone is fully
   written using zone append or regular write operations, because the
   write pointer offset will never reach the "zone full" state.
2) Regular write operations that are issued after zone append operations
   will always be failed by blk_zone_wplug_prepare_bio() as the write
   pointer alignment check will fail, even if the user correctly
   accounted for the zone append operations and issued the regular
   writes with a correct sector.

Avoid these issues by immediately removing the zone write plug of zones
that are the target of zone append operations when blk_zone_plug_bio()
is called. The new function blk_zone_wplug_handle_native_zone_append()
implements this for devices that natively support zone append. The
removal of the zone write plug using disk_remove_zone_wplug() requires
aborting all plugged regular write using disk_zone_wplug_abort() as
otherwise the plugged write BIOs would never be executed (with the plug
removed, the completion path will never see again the zone write plug as
disk_get_zone_wplug() will return NULL). Rate-limited warnings are added
to blk_zone_wplug_handle_native_zone_append() and to
disk_zone_wplug_abort() to signal this.

Since blk_zone_wplug_handle_native_zone_append() is called in the hot
path for operations that will not be plugged, disk_get_zone_wplug() is
optimized under the assumption that a user issuing zone append
operations is not at the same time issuing regular writes and that there
are no hashed zone write plugs. The struct gendisk atomic counter
nr_zone_wplugs is added to check this, with this counter incremented in
disk_insert_zone_wplug() and decremented in disk_remove_zone_wplug().

To be consistent with this fix, we do not need to fill the zone write
plug hash table with zone write plugs for zones that are partially
written for a device that supports native zone append operations.
So modify blk_revalidate_seq_zone() to return early to avoid allocating
and inserting a zone write plug for partially written sequential zones
if the device natively supports zone append.

Reported-by: Jorgen Hansen <Jorgen.Hansen@wdc.com>
Fixes: 9b1ce7f0c6f8 ("block: Implement zone append emulation")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c      | 76 ++++++++++++++++++++++++++++++++++++++----
 include/linux/blkdev.h |  7 ++--
 2 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 761ea662ddc3..0c77244a35c9 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -410,13 +410,14 @@ static bool disk_insert_zone_wplug(struct gendisk *disk,
 		}
 	}
 	hlist_add_head_rcu(&zwplug->node, &disk->zone_wplugs_hash[idx]);
+	atomic_inc(&disk->nr_zone_wplugs);
 	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
 
 	return true;
 }
 
-static struct blk_zone_wplug *disk_get_zone_wplug(struct gendisk *disk,
-						  sector_t sector)
+static struct blk_zone_wplug *disk_get_hashed_zone_wplug(struct gendisk *disk,
+							 sector_t sector)
 {
 	unsigned int zno = disk_zone_no(disk, sector);
 	unsigned int idx = hash_32(zno, disk->zone_wplugs_hash_bits);
@@ -437,6 +438,15 @@ static struct blk_zone_wplug *disk_get_zone_wplug(struct gendisk *disk,
 	return NULL;
 }
 
+static inline struct blk_zone_wplug *disk_get_zone_wplug(struct gendisk *disk,
+							 sector_t sector)
+{
+	if (!atomic_read(&disk->nr_zone_wplugs))
+		return NULL;
+
+	return disk_get_hashed_zone_wplug(disk, sector);
+}
+
 static void disk_free_zone_wplug_rcu(struct rcu_head *rcu_head)
 {
 	struct blk_zone_wplug *zwplug =
@@ -503,6 +513,7 @@ static void disk_remove_zone_wplug(struct gendisk *disk,
 	zwplug->flags |= BLK_ZONE_WPLUG_UNHASHED;
 	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
 	hlist_del_init_rcu(&zwplug->node);
+	atomic_dec(&disk->nr_zone_wplugs);
 	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
 	disk_put_zone_wplug(zwplug);
 }
@@ -593,6 +604,11 @@ static void disk_zone_wplug_abort(struct blk_zone_wplug *zwplug)
 {
 	struct bio *bio;
 
+	if (bio_list_empty(&zwplug->bio_list))
+		return;
+
+	pr_warn_ratelimited("%s: zone %u: Aborting plugged BIOs\n",
+			    zwplug->disk->disk_name, zwplug->zone_no);
 	while ((bio = bio_list_pop(&zwplug->bio_list)))
 		blk_zone_wplug_bio_io_error(zwplug, bio);
 }
@@ -1040,6 +1056,47 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 	return true;
 }
 
+static void blk_zone_wplug_handle_native_zone_append(struct bio *bio)
+{
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+	struct blk_zone_wplug *zwplug;
+	unsigned long flags;
+
+	/*
+	 * We have native support for zone append operations, so we are not
+	 * going to handle @bio through plugging. However, we may already have a
+	 * zone write plug for the target zone if that zone was previously
+	 * partially written using regular writes. In such case, we risk leaving
+	 * the plug in the disk hash table if the zone is fully written using
+	 * zone append operations. Avoid this by removing the zone write plug.
+	 */
+	zwplug = disk_get_zone_wplug(disk, bio->bi_iter.bi_sector);
+	if (likely(!zwplug))
+		return;
+
+	spin_lock_irqsave(&zwplug->lock, flags);
+
+	/*
+	 * We are about to remove the zone write plug. But if the user
+	 * (mistakenly) has issued regular writes together with native zone
+	 * append, we must aborts the writes as otherwise the plugged BIOs would
+	 * not be executed by the plug BIO work as disk_get_zone_wplug() will
+	 * return NULL after the plug is removed. Aborting the plugged write
+	 * BIOs is consistent with the fact that these writes will most likely
+	 * fail anyway as there is no ordering guarantees between zone append
+	 * operations and regular write operations.
+	 */
+	if (!bio_list_empty(&zwplug->bio_list)) {
+		pr_warn_ratelimited("%s: zone %u: Invalid mix of zone append and regular writes\n",
+				    disk->disk_name, zwplug->zone_no);
+		disk_zone_wplug_abort(zwplug);
+	}
+	disk_remove_zone_wplug(disk, zwplug);
+	spin_unlock_irqrestore(&zwplug->lock, flags);
+
+	disk_put_zone_wplug(zwplug);
+}
+
 /**
  * blk_zone_plug_bio - Handle a zone write BIO with zone write plugging
  * @bio: The BIO being submitted
@@ -1096,8 +1153,10 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
 	 */
 	switch (bio_op(bio)) {
 	case REQ_OP_ZONE_APPEND:
-		if (!bdev_emulates_zone_append(bdev))
+		if (!bdev_emulates_zone_append(bdev)) {
+			blk_zone_wplug_handle_native_zone_append(bio);
 			return false;
+		}
 		fallthrough;
 	case REQ_OP_WRITE:
 	case REQ_OP_WRITE_ZEROES:
@@ -1284,6 +1343,7 @@ static int disk_alloc_zone_resources(struct gendisk *disk,
 {
 	unsigned int i;
 
+	atomic_set(&disk->nr_zone_wplugs, 0);
 	disk->zone_wplugs_hash_bits =
 		min(ilog2(pool_size) + 1, BLK_ZONE_WPLUG_MAX_HASH_BITS);
 
@@ -1338,6 +1398,7 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
 		}
 	}
 
+	WARN_ON_ONCE(atomic_read(&disk->nr_zone_wplugs));
 	kfree(disk->zone_wplugs_hash);
 	disk->zone_wplugs_hash = NULL;
 	disk->zone_wplugs_hash_bits = 0;
@@ -1550,11 +1611,12 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone, unsigned int idx,
 	}
 
 	/*
-	 * We need to track the write pointer of all zones that are not
-	 * empty nor full. So make sure we have a zone write plug for
-	 * such zone if the device has a zone write plug hash table.
+	 * If the device needs zone append emulation, we need to track the
+	 * write pointer of all zones that are not empty nor full. So make sure
+	 * we have a zone write plug for such zone if the device has a zone
+	 * write plug hash table.
 	 */
-	if (!disk->zone_wplugs_hash)
+	if (!queue_emulates_zone_append(disk->queue) || !disk->zone_wplugs_hash)
 		return 0;
 
 	disk_zone_wplug_sync_wp_offset(disk, zone);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 248416ecd01c..39cc5862cc48 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -196,10 +196,11 @@ struct gendisk {
 	unsigned int		zone_capacity;
 	unsigned int		last_zone_capacity;
 	unsigned long __rcu	*conv_zones_bitmap;
-	unsigned int            zone_wplugs_hash_bits;
-	spinlock_t              zone_wplugs_lock;
+	unsigned int		zone_wplugs_hash_bits;
+	atomic_t		nr_zone_wplugs;
+	spinlock_t		zone_wplugs_lock;
 	struct mempool_s	*zone_wplugs_pool;
-	struct hlist_head       *zone_wplugs_hash;
+	struct hlist_head	*zone_wplugs_hash;
 	struct workqueue_struct *zone_wplugs_wq;
 #endif /* CONFIG_BLK_DEV_ZONED */
 
-- 
2.48.1


