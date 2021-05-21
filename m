Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763A938BCB9
	for <lists+linux-block@lfdr.de>; Fri, 21 May 2021 05:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhEUDCw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 May 2021 23:02:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25389 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhEUDCw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 23:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621566089; x=1653102089;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=5DsU3z9vFCVUXranzeld/Dhd8errTp9UbrB7wUKuLEY=;
  b=AOPv4NnEodfjWebPufwrI+aQIjGahseh7aLtIN6LKp9708bLIOTdBrI7
   /Wkah3NYJmhtpjJWxHheRlyC1ZSuKz5mq9ZFOgwkFJ1PvvXl9W26CycK5
   cG4sVScog2Q/2876A4RAGTOibTFD+LzjcegLipC+rfHgm3JKMHe/TPpcO
   x25AFQ5drMq2i1OiRhMtB7yoCd7zbWp1nYbyDjHfwlSzhgkbI0hE5xJV8
   hGZ7YOw+IfXTztwP/2Ity0iaXWoYrDyXzIr8WbAORY/c4FR11IerUHB9/
   GYpErncOZLFaG9GAgOnMMROpw48eH1nzAPSaWPQFMFDM+gSsXYEzG+2Dq
   w==;
IronPort-SDR: jTGvNtxvv5r7TqHleFWN/KY8b0WG7ABd2vmNmAWzHqOtah51qN2T5bcuSYOVQkwIHJv3eB7InT
 pYUWEQi5Cq7gLSalhepA4FVRbmHHeDtdLgT0fTvloq8PDMH71JFLh02vNrkm6eC2CZ7jFAt0Lv
 schYTlrvaX8PCdOELyc96kRNXlw4HU/qMVCeZBNTdKz5NeZsl3viDD4r7jU12DNgCGTWQWmdex
 DyXEuYjFZWrTQz1bhoE2P/qnuSYoqJcvDRvU6npo6xdSgXke9uV2BFWiPqXVKvsmztDgLnopLs
 BRQ=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168943845"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 11:01:29 +0800
IronPort-SDR: bSiiqzeKDbVzwBTyUYm8ga0345aHS/HaRiZ3ZI9wmqNUOBK+5SbfKgwRiBLd/GPlztADkofz+e
 1G6ehLGpmT2BsJ2lqQtXDskgJDeF2vUSHTwsFK0pAwK30BZRSkf+1CsmfT/F2Vf3OfqkAOB7Y6
 hHgOUS0nJh6RaGeftMOD5tPrMQlTBf0vGODIKm5BFzMsraTNlxB9jVZaJPjABhIVryrNshXmvj
 jnE4LgV1qpCuv9ctYE/vTLhqnvFU0BC7Mn3333CYMvFh/DARrwYBN2iWjqCMDvWBfsbOFNLad5
 +m/KKqmNF7iUyt5WaB9HRuB1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 19:41:05 -0700
IronPort-SDR: O+vvLBiZsQhwzVXuFcZB2abuAIaTAY22yGIiNBaQP5DEVqcZKJknqn1xA/SqsLBzNb9msJHCTh
 KYnvrV3htPHwebXexG5kJ+4VOWQieyTq7LtS1oTlJmYNlU2tI4Gf/Z8EuiHf/YaieEs5KGmMrm
 yo09PfVfgijE3o1FmTEacztZ6NpbzE69a0LBhJo1ZqbyWMRuYLke+9p+Yc9CoFoXUeyQaqpL1G
 UryhnLaQWgCKDTpm9oL4GYAHOzcXoBAsMDvhYMSeWSVLqXaF21ttRSWuTxYv8GhWM73tZeDI4u
 CXw=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2021 20:01:29 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 06/11] dm: move zone related code to dm-zone.c
Date:   Fri, 21 May 2021 12:01:14 +0900
Message-Id: <20210521030119.1209035-7-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521030119.1209035-1-damien.lemoal@wdc.com>
References: <20210521030119.1209035-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move core and table code used for zoned targets and conditionally
defined with #ifdef CONFIG_BLK_DEV_ZONED to the new file dm-zone.c.
This file is conditionally compiled depending on CONFIG_BLK_DEV_ZONED.
The small helper dm_set_zones_restrictions() is introduced to
initialize a mapped device request queue zone attributes in
dm_table_set_restrictions().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/Makefile   |   4 ++
 drivers/md/dm-table.c |  14 ++----
 drivers/md/dm-zone.c  | 102 ++++++++++++++++++++++++++++++++++++++++++
 drivers/md/dm.c       |  78 --------------------------------
 drivers/md/dm.h       |  11 +++++
 5 files changed, 120 insertions(+), 89 deletions(-)
 create mode 100644 drivers/md/dm-zone.c

diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index ef7ddc27685c..a74aaf8b1445 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -92,6 +92,10 @@ ifeq ($(CONFIG_DM_UEVENT),y)
 dm-mod-objs			+= dm-uevent.o
 endif
 
+ifeq ($(CONFIG_BLK_DEV_ZONED),y)
+dm-mod-objs			+= dm-zone.o
+endif
+
 ifeq ($(CONFIG_DM_VERITY_FEC),y)
 dm-verity-objs			+= dm-verity-fec.o
 endif
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 21fd9cd4da32..dd9f648ab598 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -2064,17 +2064,9 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	    dm_table_any_dev_attr(t, device_is_not_random, NULL))
 		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
 
-	/*
-	 * For a zoned target, the number of zones should be updated for the
-	 * correct value to be exposed in sysfs queue/nr_zones. For a BIO based
-	 * target, this is all that is needed.
-	 */
-#ifdef CONFIG_BLK_DEV_ZONED
-	if (blk_queue_is_zoned(q)) {
-		WARN_ON_ONCE(queue_is_mq(q));
-		q->nr_zones = blkdev_nr_zones(t->md->disk);
-	}
-#endif
+	/* For a zoned target, setup the zones related queue attributes */
+	if (blk_queue_is_zoned(q))
+		dm_set_zones_restrictions(t, q);
 
 	dm_update_keyslot_manager(q, t);
 	blk_queue_update_readahead(q);
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
new file mode 100644
index 000000000000..3243c42b7951
--- /dev/null
+++ b/drivers/md/dm-zone.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/blkdev.h>
+
+#include "dm-core.h"
+
+/*
+ * User facing dm device block device report zone operation. This calls the
+ * report_zones operation for each target of a device table. This operation is
+ * generally implemented by targets using dm_report_zones().
+ */
+int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
+			unsigned int nr_zones, report_zones_cb cb, void *data)
+{
+	struct mapped_device *md = disk->private_data;
+	struct dm_table *map;
+	int srcu_idx, ret;
+	struct dm_report_zones_args args = {
+		.next_sector = sector,
+		.orig_data = data,
+		.orig_cb = cb,
+	};
+
+	if (dm_suspended_md(md))
+		return -EAGAIN;
+
+	map = dm_get_live_table(md, &srcu_idx);
+	if (!map) {
+		ret = -EIO;
+		goto out;
+	}
+
+	do {
+		struct dm_target *tgt;
+
+		tgt = dm_table_find_target(map, args.next_sector);
+		if (WARN_ON_ONCE(!tgt->type->report_zones)) {
+			ret = -EIO;
+			goto out;
+		}
+
+		args.tgt = tgt;
+		ret = tgt->type->report_zones(tgt, &args,
+					      nr_zones - args.zone_idx);
+		if (ret < 0)
+			goto out;
+	} while (args.zone_idx < nr_zones &&
+		 args.next_sector < get_capacity(disk));
+
+	ret = args.zone_idx;
+out:
+	dm_put_live_table(md, srcu_idx);
+	return ret;
+}
+
+int dm_report_zones_cb(struct blk_zone *zone, unsigned int idx, void *data)
+{
+	struct dm_report_zones_args *args = data;
+	sector_t sector_diff = args->tgt->begin - args->start;
+
+	/*
+	 * Ignore zones beyond the target range.
+	 */
+	if (zone->start >= args->start + args->tgt->len)
+		return 0;
+
+	/*
+	 * Remap the start sector and write pointer position of the zone
+	 * to match its position in the target range.
+	 */
+	zone->start += sector_diff;
+	if (zone->type != BLK_ZONE_TYPE_CONVENTIONAL) {
+		if (zone->cond == BLK_ZONE_COND_FULL)
+			zone->wp = zone->start + zone->len;
+		else if (zone->cond == BLK_ZONE_COND_EMPTY)
+			zone->wp = zone->start;
+		else
+			zone->wp += sector_diff;
+	}
+
+	args->next_sector = zone->start + zone->len;
+	return args->orig_cb(zone, args->zone_idx++, args->orig_data);
+}
+EXPORT_SYMBOL_GPL(dm_report_zones_cb);
+
+void dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
+{
+	if (!blk_queue_is_zoned(q))
+		return;
+
+	/*
+	 * For a zoned target, the number of zones should be updated for the
+	 * correct value to be exposed in sysfs queue/nr_zones. For a BIO based
+	 * target, this is all that is needed.
+	 */
+	WARN_ON_ONCE(queue_is_mq(q));
+	q->nr_zones = blkdev_nr_zones(t->md->disk);
+}
+
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a9211575bfed..45d2dc2ee844 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -444,84 +444,6 @@ static int dm_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return dm_get_geometry(md, geo);
 }
 
-#ifdef CONFIG_BLK_DEV_ZONED
-int dm_report_zones_cb(struct blk_zone *zone, unsigned int idx, void *data)
-{
-	struct dm_report_zones_args *args = data;
-	sector_t sector_diff = args->tgt->begin - args->start;
-
-	/*
-	 * Ignore zones beyond the target range.
-	 */
-	if (zone->start >= args->start + args->tgt->len)
-		return 0;
-
-	/*
-	 * Remap the start sector and write pointer position of the zone
-	 * to match its position in the target range.
-	 */
-	zone->start += sector_diff;
-	if (zone->type != BLK_ZONE_TYPE_CONVENTIONAL) {
-		if (zone->cond == BLK_ZONE_COND_FULL)
-			zone->wp = zone->start + zone->len;
-		else if (zone->cond == BLK_ZONE_COND_EMPTY)
-			zone->wp = zone->start;
-		else
-			zone->wp += sector_diff;
-	}
-
-	args->next_sector = zone->start + zone->len;
-	return args->orig_cb(zone, args->zone_idx++, args->orig_data);
-}
-EXPORT_SYMBOL_GPL(dm_report_zones_cb);
-
-static int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
-		unsigned int nr_zones, report_zones_cb cb, void *data)
-{
-	struct mapped_device *md = disk->private_data;
-	struct dm_table *map;
-	int srcu_idx, ret;
-	struct dm_report_zones_args args = {
-		.next_sector = sector,
-		.orig_data = data,
-		.orig_cb = cb,
-	};
-
-	if (dm_suspended_md(md))
-		return -EAGAIN;
-
-	map = dm_get_live_table(md, &srcu_idx);
-	if (!map) {
-		ret = -EIO;
-		goto out;
-	}
-
-	do {
-		struct dm_target *tgt;
-
-		tgt = dm_table_find_target(map, args.next_sector);
-		if (WARN_ON_ONCE(!tgt->type->report_zones)) {
-			ret = -EIO;
-			goto out;
-		}
-
-		args.tgt = tgt;
-		ret = tgt->type->report_zones(tgt, &args,
-					      nr_zones - args.zone_idx);
-		if (ret < 0)
-			goto out;
-	} while (args.zone_idx < nr_zones &&
-		 args.next_sector < get_capacity(disk));
-
-	ret = args.zone_idx;
-out:
-	dm_put_live_table(md, srcu_idx);
-	return ret;
-}
-#else
-#define dm_blk_report_zones		NULL
-#endif /* CONFIG_BLK_DEV_ZONED */
-
 static int dm_prepare_ioctl(struct mapped_device *md, int *srcu_idx,
 			    struct block_device **bdev)
 {
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index b441ad772c18..fdf1536a4b62 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -100,6 +100,17 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t);
  */
 #define dm_target_hybrid(t) (dm_target_bio_based(t) && dm_target_request_based(t))
 
+/*
+ * Zoned targets related functions.
+ */
+void dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q);
+#ifdef CONFIG_BLK_DEV_ZONED
+int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
+			unsigned int nr_zones, report_zones_cb cb, void *data);
+#else
+#define dm_blk_report_zones	NULL
+#endif
+
 /*-----------------------------------------------------------------
  * A registry of target types.
  *---------------------------------------------------------------*/
-- 
2.31.1

