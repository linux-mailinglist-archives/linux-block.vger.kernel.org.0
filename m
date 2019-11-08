Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E79F3DAE
	for <lists+linux-block@lfdr.de>; Fri,  8 Nov 2019 02:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfKHB5M (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 Nov 2019 20:57:12 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12762 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfKHB5M (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Nov 2019 20:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573178231; x=1604714231;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=BIOiKD6oSEnVN19IlUfW7/Xaco4B/g0SObKq9lFYj8g=;
  b=hSZatjdIGWR7wk3xSY3Lw9eqSqnpeAoYclbMT7jgbwH7cCRqbfaiae1J
   QPgrhB3gKwV9mRX4hY81ZD4qUgcmNYOI/uL6cMiHKWy77H5r6+xXIQL5O
   cCgTZPW9R+yYgZIHpIrlpTZf6FP5/VeX0PN6PEmVE6lP1UZamN0RPSvQv
   WwG6FGE90YvO3X1gqL3vfiZcJNiq8FQ9jNF95M2RpENSQD6MfCKCF/26+
   tW6Fn0IDUSs7p/tV0yhKYMpPpmHe3xhNN9Ga1LCQOJVAtwYK0N5v+0V2b
   hk+B2i/vp9haUuAVbOtsVxp+bz+UZTMdj4DaEoA/zrB1doS5VSGG0tYZe
   Q==;
IronPort-SDR: cKDKbDecf1wo+O1REHYlsBLjZvybVaOcAZPakFrjJccxmrCMJLQpXN3JgG/6Tfmw7nHH0fSTjz
 v2YoXBAfOFdhhblIaM/JAFJG+yTj9/qjpM7Pqr35BJpUgVR+Zb9T/6iSoAXPsOKhBQnc3WYJq0
 zq6ZSmcbnfk/k+eHUmB1gU7KmBG/sOrTi2ZLaAEts2AatgH4vT6PmsQTrxq4NC7Dw1a7AlQLGC
 N+CZWoDUPgeUk5pfvVw8wRIxMzD22uKl+GEB+3wOs82zYT26dhsRPXZ5V1TfHMGefNMVdWyBxO
 gnE=
X-IronPort-AV: E=Sophos;i="5.68,279,1569254400"; 
   d="scan'208";a="122437208"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2019 09:57:11 +0800
IronPort-SDR: /vouOaIhvAjm/wluwAYXUs2D1EPhwzOigPnnNyDLVRvZW+xifYBvbGnBSJ9DrCk5KPcta1sUuN
 XEwDA8SC4ivzzZVgnz7Gt29QwDpYHrnuDbvbcX7Xo8ImFs2J0D7rgnc0WQ1DwzQKxh0R5lFot6
 AqxDQ1Da+B1S8yxUt8NxozlNFv1PhAOsQTyl4IR/3PIZmkcj4i+SMbL36P5WHvlCKdByki5QpF
 oYlsUzoI5mff5IP2TCITdurzL/ahzLyY4ux/oOtvKsSh8y5185ncsVosROg9H5UzHyERsnrhT/
 TVzbBbCPYBwTP3SAgJ1/mil/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 17:52:21 -0800
IronPort-SDR: Ox1zP9yk0sKpZCmB3u6Su1a56RPdwvwjztqjpqOnXifRqNJCg/V4vAyTdV0Ws6lUMfSvvnYF4g
 pMef0imx/w6H0U0v2i9oJvNKhSOdXf6D0bnuc2VsfQuQFOuY8U21XBYlPGBDIY7UPBiwJ1ChQN
 KAEA/gNuUkr4cZvPmiy+4Rno45+d/HynRkWKvfhbaJd0e47hJrQhSHpouCPT7M/BYXtTihbS/C
 9TwqT07gGhSjy5uR+KUMaDRseJ2DGuZh3TLDmS6FEmZY+Sz0HZsFRxgu2sCKjnUj1zwuBB5k6J
 j38=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2019 17:57:10 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/9] block: Remove partition support for zoned block devices
Date:   Fri,  8 Nov 2019 10:56:57 +0900
Message-Id: <20191108015702.233102-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108015702.233102-1-damien.lemoal@wdc.com>
References: <20191108015702.233102-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No known partitioning tool supports zoned block devices, especially the
host managed flavor with strong sequential write constraints.
Furthermore, there are also no known user nor use cases for partitioned
zoned block devices.

This patch removes partition device creation for zoned block devices,
which allows simplifying the processing of zone commands for zoned
block devices. A warning is added if a partition table is found on the
device.

For report zones operations no zone sector information remapping is
necessary anymore, simplifying the code. Of note is that remapping of
zone reports for DM targets is still necessary as done by
dm_remap_zone_report().

Similarly, remaping of a zone reset bio is not necessary anymore.
Testing for the applicability of the zone reset all request also becomes
simpler and only needs to check that the number of sectors of the
requested zone range is equal to the disk capacity.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-core.c          |  6 +---
 block/blk-zoned.c         | 62 ++++++--------------------------
 block/partition-generic.c | 74 +++++----------------------------------
 drivers/md/dm.c           |  3 --
 4 files changed, 21 insertions(+), 124 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 3306a3c5bed6..df6b70476187 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -851,11 +851,7 @@ static inline int blk_partition_remap(struct bio *bio)
 	if (unlikely(bio_check_ro(bio, p)))
 		goto out;
 
-	/*
-	 * Zone management bios do not have a sector count but they do have
-	 * a start sector filled out and need to be remapped.
-	 */
-	if (bio_sectors(bio) || op_is_zone_mgmt(bio_op(bio))) {
+	if (bio_sectors(bio)) {
 		if (bio_check_eod(bio, part_nr_sects_read(p)))
 			goto out;
 		bio->bi_iter.bi_sector += p->start_sect;
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ea4e086ba00e..ae665e490858 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -93,32 +93,10 @@ unsigned int blkdev_nr_zones(struct block_device *bdev)
 	if (!blk_queue_is_zoned(q))
 		return 0;
 
-	return __blkdev_nr_zones(q, bdev->bd_part->nr_sects);
+	return __blkdev_nr_zones(q, get_capacity(bdev->bd_disk));
 }
 EXPORT_SYMBOL_GPL(blkdev_nr_zones);
 
-/*
- * Check that a zone report belongs to this partition, and if yes, fix its start
- * sector and write pointer and return true. Return false otherwise.
- */
-static bool blkdev_report_zone(struct block_device *bdev, struct blk_zone *rep)
-{
-	sector_t offset = get_start_sect(bdev);
-
-	if (rep->start < offset)
-		return false;
-
-	rep->start -= offset;
-	if (rep->start + rep->len > bdev->bd_part->nr_sects)
-		return false;
-
-	if (rep->type == BLK_ZONE_TYPE_CONVENTIONAL)
-		rep->wp = rep->start + rep->len;
-	else
-		rep->wp -= offset;
-	return true;
-}
-
 /**
  * blkdev_report_zones - Get zones information
  * @bdev:	Target block device
@@ -140,8 +118,7 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 	struct gendisk *disk = bdev->bd_disk;
-	unsigned int i, nrz;
-	int ret;
+	sector_t capacity = get_capacity(disk);
 
 	if (!blk_queue_is_zoned(q))
 		return -EOPNOTSUPP;
@@ -154,27 +131,14 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 	if (WARN_ON_ONCE(!disk->fops->report_zones))
 		return -EOPNOTSUPP;
 
-	if (!*nr_zones || sector >= bdev->bd_part->nr_sects) {
+	if (!*nr_zones || sector >= capacity) {
 		*nr_zones = 0;
 		return 0;
 	}
 
-	nrz = min(*nr_zones,
-		  __blkdev_nr_zones(q, bdev->bd_part->nr_sects - sector));
-	ret = disk->fops->report_zones(disk, get_start_sect(bdev) + sector,
-				       zones, &nrz);
-	if (ret)
-		return ret;
+	*nr_zones = min(*nr_zones, __blkdev_nr_zones(q, capacity - sector));
 
-	for (i = 0; i < nrz; i++) {
-		if (!blkdev_report_zone(bdev, zones))
-			break;
-		zones++;
-	}
-
-	*nr_zones = i;
-
-	return 0;
+	return disk->fops->report_zones(disk, sector, zones, nr_zones);
 }
 EXPORT_SYMBOL_GPL(blkdev_report_zones);
 
@@ -185,15 +149,11 @@ static inline bool blkdev_allow_reset_all_zones(struct block_device *bdev,
 	if (!blk_queue_zone_resetall(bdev_get_queue(bdev)))
 		return false;
 
-	if (sector || nr_sectors != part_nr_sects_read(bdev->bd_part))
-		return false;
 	/*
-	 * REQ_OP_ZONE_RESET_ALL can be executed only if the block device is
-	 * the entire disk, that is, if the blocks device start offset is 0 and
-	 * its capacity is the same as the entire disk.
+	 * REQ_OP_ZONE_RESET_ALL can be executed only if the number of sectors
+	 * of the applicable zone range is the entire disk.
 	 */
-	return get_start_sect(bdev) == 0 &&
-	       part_nr_sects_read(bdev->bd_part) == get_capacity(bdev->bd_disk);
+	return !sector && nr_sectors == get_capacity(bdev->bd_disk);
 }
 
 /**
@@ -218,6 +178,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 	sector_t zone_sectors = blk_queue_zone_sectors(q);
+	sector_t capacity = get_capacity(bdev->bd_disk);
 	sector_t end_sector = sector + nr_sectors;
 	struct bio *bio = NULL;
 	int ret;
@@ -231,7 +192,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 	if (!op_is_zone_mgmt(op))
 		return -EOPNOTSUPP;
 
-	if (!nr_sectors || end_sector > bdev->bd_part->nr_sects)
+	if (!nr_sectors || end_sector > capacity)
 		/* Out of range */
 		return -EINVAL;
 
@@ -239,8 +200,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 	if (sector & (zone_sectors - 1))
 		return -EINVAL;
 
-	if ((nr_sectors & (zone_sectors - 1)) &&
-	    end_sector != bdev->bd_part->nr_sects)
+	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
 		return -EINVAL;
 
 	while (sector < end_sector) {
diff --git a/block/partition-generic.c b/block/partition-generic.c
index aee643ce13d1..31bff3fb28af 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -459,56 +459,6 @@ static int drop_partitions(struct gendisk *disk, struct block_device *bdev)
 	return 0;
 }
 
-static bool part_zone_aligned(struct gendisk *disk,
-			      struct block_device *bdev,
-			      sector_t from, sector_t size)
-{
-	unsigned int zone_sectors = bdev_zone_sectors(bdev);
-
-	/*
-	 * If this function is called, then the disk is a zoned block device
-	 * (host-aware or host-managed). This can be detected even if the
-	 * zoned block device support is disabled (CONFIG_BLK_DEV_ZONED not
-	 * set). In this case, however, only host-aware devices will be seen
-	 * as a block device is not created for host-managed devices. Without
-	 * zoned block device support, host-aware drives can still be used as
-	 * regular block devices (no zone operation) and their zone size will
-	 * be reported as 0. Allow this case.
-	 */
-	if (!zone_sectors)
-		return true;
-
-	/*
-	 * Check partition start and size alignement. If the drive has a
-	 * smaller last runt zone, ignore it and allow the partition to
-	 * use it. Check the zone size too: it should be a power of 2 number
-	 * of sectors.
-	 */
-	if (WARN_ON_ONCE(!is_power_of_2(zone_sectors))) {
-		u32 rem;
-
-		div_u64_rem(from, zone_sectors, &rem);
-		if (rem)
-			return false;
-		if ((from + size) < get_capacity(disk)) {
-			div_u64_rem(size, zone_sectors, &rem);
-			if (rem)
-				return false;
-		}
-
-	} else {
-
-		if (from & (zone_sectors - 1))
-			return false;
-		if ((from + size) < get_capacity(disk) &&
-		    (size & (zone_sectors - 1)))
-			return false;
-
-	}
-
-	return true;
-}
-
 int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
 {
 	struct parsed_partitions *state = NULL;
@@ -544,6 +494,14 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
 		}
 		return -EIO;
 	}
+
+	/* Partitions are not supported on zoned block devices */
+	if (bdev_is_zoned(bdev)) {
+		pr_warn("%s: ignoring partition table on zoned block device\n",
+			disk->disk_name);
+		goto out;
+	}
+
 	/*
 	 * If any partition code tried to read beyond EOD, try
 	 * unlocking native capacity even if partition table is
@@ -607,21 +565,6 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
 			}
 		}
 
-		/*
-		 * On a zoned block device, partitions should be aligned on the
-		 * device zone size (i.e. zone boundary crossing not allowed).
-		 * Otherwise, resetting the write pointer of the last zone of
-		 * one partition may impact the following partition.
-		 */
-		if (bdev_is_zoned(bdev) &&
-		    !part_zone_aligned(disk, bdev, from, size)) {
-			printk(KERN_WARNING
-			       "%s: p%d start %llu+%llu is not zone aligned\n",
-			       disk->disk_name, p, (unsigned long long) from,
-			       (unsigned long long) size);
-			continue;
-		}
-
 		part = add_partition(disk, p, from, size,
 				     state->parts[p].flags,
 				     &state->parts[p].info);
@@ -635,6 +578,7 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
 			md_autodetect_dev(part_to_dev(part)->devt);
 #endif
 	}
+out:
 	free_partitions(state);
 	return 0;
 }
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 89189c29438f..76f4cfdd6b41 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1211,9 +1211,6 @@ EXPORT_SYMBOL_GPL(dm_accept_partial_bio);
  * The zone descriptors obtained with a zone report indicate
  * zone positions within the underlying device of the target. The zone
  * descriptors must be remapped to match their position within the dm device.
- * The caller target should obtain the zones information using
- * blkdev_report_zones() to ensure that remapping for partition offset is
- * already handled.
  */
 void dm_remap_zone_report(struct dm_target *ti, sector_t start,
 			  struct blk_zone *zones, unsigned int *nr_zones)
-- 
2.23.0

