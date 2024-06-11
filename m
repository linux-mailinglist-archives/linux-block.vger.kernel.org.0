Return-Path: <linux-block+bounces-8558-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78662902E7D
	for <lists+linux-block@lfdr.de>; Tue, 11 Jun 2024 04:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE161C22D69
	for <lists+linux-block@lfdr.de>; Tue, 11 Jun 2024 02:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D3D16F8F4;
	Tue, 11 Jun 2024 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMYMs3e1"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA9616F8F1;
	Tue, 11 Jun 2024 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073407; cv=none; b=Ad+47aoGIHwC9b0JxBFCfTdfZY4i29wk8Kp8cWq6pnhfwMm3f01gWR4DMuOkAb2GDKeclNXwxLZhiPhvAUmM77m7EFqMevwx8K1gnfIVvzpa4R+BrD5knTteOc2agm1Jt/1avBx8w9Q9yl7fYPn4p8KnC5reidmNQAdYmMNsWEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073407; c=relaxed/simple;
	bh=MQU8y1Z91+CUECG9fFg2B+AWUgFXzCuMQTwFoJbBmbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2MlC83fgZ6C4b8et7WLjc10nqq4X6y6HD0n4hmQgZRGcQy1KXO24ZqwQRA9medd1rqOXKYaDNRO4W6Co5GSeut++UcmGwP0x72EfTB7ej9lusxy01/M2+iA2JfKdztQhrQsKxpISpbVx/xurClaFjxvUDIAoBNvogEEvSxuNn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMYMs3e1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BA6C4AF1A;
	Tue, 11 Jun 2024 02:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718073406;
	bh=MQU8y1Z91+CUECG9fFg2B+AWUgFXzCuMQTwFoJbBmbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eMYMs3e1YIYda884xVu2fp315gxXaMgn47aj4ncqrfQLFJ/knf8twFv20D0hM9hLH
	 bIu9hFeyZCBEWNlaO1GY2R4eUUU3cFMzZwRq188pe87hOf6q5+HuiMP+aHBql0WilQ
	 VQkSt5f9h2JB/eehynd3wAQMSlItCqe9NskJhtXqpDof+iNH5iT1ysZd5a5JTAA1Dq
	 BpcaOuhBRA2nT5RI5TKpX6WaVv8GBxWaP3GJq+X+4dpPXVwuIigBTIojjTEdlW2Cb+
	 E2d1XQf3OEYmB7EkKCjngFnfTBcgv67qhEWNpmGmIp6n+zAooh781qtRT5S6N8Af8F
	 uUqYg9tV93Mng==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Benjamin Marzinski <bmarzins@redhat.com>
Subject: [PATCH v8 3/4] dm: Improve zone resource limits handling
Date: Tue, 11 Jun 2024 11:36:38 +0900
Message-ID: <20240611023639.89277-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611023639.89277-1-dlemoal@kernel.org>
References: <20240611023639.89277-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic stacking of limits implemented in the block layer cannot
correctly handle stacking of zone resource limits (max open zones and
max active zones) because these limits are for an entire device but the
stacking may be for a portion of that device (e.g. a dm-linear target
that does not cover an entire block device). As a result, when DM
devices are created on top of zoned block devices, the DM device never
has any zone resource limits advertized, which is only correct if all
underlying target devices also have no zone resource limits.
If at least one target device has resource limits, the user may see
either performance issues (if the max open zone limit of the device is
exceeded) or write I/O errors if the max active zone limit of one of
the underlying target devices is exceeded.

While it is very difficult to correctly and reliably stack zone resource
limits in general, cases where targets are not sharing zone resources of
the same device can be dealt with relatively easily. Such situation
happens when a target maps all sequential zones of a zoned block device:
for such mapping, other targets mapping other parts of the same zoned
block device can only contain conventional zones and thus will not
require any zone resource to correctly handle write operations.

For a mapped device constructed with such targets, which includes mapped
devices constructed with targets mapping entire zoned block devices, the
zone resource limits can be reliably determined using the non-zero
minimum of the zone resource limits of all targets.

For mapped devices that include targets partially mapping the set of
sequential write required zones of zoned block devices, instead of
advertizing no zone resource limits, it is also better to set the mapped
device limits to the non-zero minimum of the limits of all targets. In
this case the limits for a target depend on the number of sequential
zones being mapped: if this number of zone is larger than the limits,
then the limits of the device apply and can be used. If on the other
hand the target maps a number of zones smaller than the limits, then no
limits is needed and we can assume that the target has no limits (limits
set to 0).

This commit improves zone resource limits handling as described above
by modifying dm_set_zones_restrictions() to iterate the targets of a
mapped device to evaluate the max open and max active zone limits. This
relies on an internal "stacking" of the limits of the target devices
combined with a direct counting of the number of sequential zones
mapped by the targets.
1) For a target mapping an entire zoned block device, the limits for the
   target are set to the limits of the device.
2) For a target partially mapping a zoned block device, the number of
   mapped sequential zones is used to determine the limits: if the
   target maps more sequential write required zones than the device
   limits, then the limits of the device are used as-is. If the number
   of mapped sequential zones is lower than the limits, then we assume
   that the target has no limits (limits set to 0).
As this evaluation is done for each target, the zone resource limits
for the mapped device are evaluated as the non-zero minimum of the
limits of all the targets.

For configurations resulting in unreliable limits, i.e. a table
containing a target partially mapping a zoned device, a warning message
is issued.

The counting of mapped sequential zones for the target is done using the
new function dm_device_count_zones() which performs a report zones on
the entire block device with the callback dm_device_count_zones_cb().
This count of mapped sequential zones is also used to determine if the
mapped device contains only conventional zones. This allows simplifying
dm_set_zones_restrictions() to not do a report zones just for this.
For mapped devices mapping only conventional zones, as before, the
mapped device is changed to a regular device by setting its zoned limit
to false and clearing all its zone related limits.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Benjamin Marzinski <bmarzins@redhat.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/md/dm-zone.c | 180 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 150 insertions(+), 30 deletions(-)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 75d0019a0649..ac9f1f82108b 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -145,21 +145,6 @@ bool dm_is_zone_write(struct mapped_device *md, struct bio *bio)
 	}
 }
 
-/*
- * Count conventional zones of a mapped zoned device. If the device
- * only has conventional zones, do not expose it as zoned.
- */
-static int dm_check_zoned_cb(struct blk_zone *zone, unsigned int idx,
-			     void *data)
-{
-	unsigned int *nr_conv_zones = data;
-
-	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-		(*nr_conv_zones)++;
-
-	return 0;
-}
-
 /*
  * Revalidate the zones of a mapped device to initialize resource necessary
  * for zone append emulation. Note that we cannot simply use the block layer
@@ -228,13 +213,127 @@ static bool dm_table_supports_zone_append(struct dm_table *t)
 	return true;
 }
 
+struct dm_device_zone_count {
+	sector_t start;
+	sector_t len;
+	unsigned int total_nr_seq_zones;
+	unsigned int target_nr_seq_zones;
+};
+
+/*
+ * Count the total number of and the number of mapped sequential zones of a
+ * target zoned device.
+ */
+static int dm_device_count_zones_cb(struct blk_zone *zone,
+				    unsigned int idx, void *data)
+{
+	struct dm_device_zone_count *zc = data;
+
+	if (zone->type != BLK_ZONE_TYPE_CONVENTIONAL) {
+		zc->total_nr_seq_zones++;
+		if (zone->start >= zc->start &&
+		    zone->start < zc->start + zc->len)
+			zc->target_nr_seq_zones++;
+	}
+
+	return 0;
+}
+
+static int dm_device_count_zones(struct dm_dev *dev,
+				 struct dm_device_zone_count *zc)
+{
+	int ret;
+
+	ret = blkdev_report_zones(dev->bdev, 0, BLK_ALL_ZONES,
+				  dm_device_count_zones_cb, zc);
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return -EIO;
+	return 0;
+}
+
+struct dm_zone_resource_limits {
+	unsigned int mapped_nr_seq_zones;
+	struct queue_limits *lim;
+	bool reliable_limits;
+};
+
+static int device_get_zone_resource_limits(struct dm_target *ti,
+					   struct dm_dev *dev, sector_t start,
+					   sector_t len, void *data)
+{
+	struct dm_zone_resource_limits *zlim = data;
+	struct gendisk *disk = dev->bdev->bd_disk;
+	unsigned int max_open_zones, max_active_zones;
+	int ret;
+	struct dm_device_zone_count zc = {
+		.start = start,
+		.len = len,
+	};
+
+	/*
+	 * If the target is not the whole device, the device zone resources may
+	 * be shared between different targets. Check this by counting the
+	 * number of mapped sequential zones: if this number is smaller than the
+	 * total number of sequential zones of the target device, then resource
+	 * sharing may happen and the zone limits will not be reliable.
+	 */
+	ret = dm_device_count_zones(dev, &zc);
+	if (ret) {
+		DMERR("Count %s zones failed %d", disk->disk_name, ret);
+		return ret;
+	}
+
+	/*
+	 * If the target does not map any sequential zones, then we do not need
+	 * any zone resource limits.
+	 */
+	if (!zc.target_nr_seq_zones)
+		return 0;
+
+	/*
+	 * If the target does not map all sequential zones, the limits
+	 * will not be reliable.
+	 */
+	if (zc.target_nr_seq_zones < zc.total_nr_seq_zones)
+		zlim->reliable_limits = false;
+
+	/*
+	 * If the target maps less sequential zones than the limit values, then
+	 * we do not have limits for this target.
+	 */
+	max_active_zones = disk->queue->limits.max_active_zones;
+	if (max_active_zones >= zc.target_nr_seq_zones)
+		max_active_zones = 0;
+	zlim->lim->max_active_zones =
+		min_not_zero(max_active_zones, zlim->lim->max_active_zones);
+
+	max_open_zones = disk->queue->limits.max_open_zones;
+	if (max_open_zones >= zc.target_nr_seq_zones)
+		max_open_zones = 0;
+	zlim->lim->max_open_zones =
+		min_not_zero(max_open_zones, zlim->lim->max_open_zones);
+
+	/*
+	 * Also count the total number of sequential zones for the mapped
+	 * device so that when we are done inspecting all its targets, we are
+	 * able to check if the mapped device actually has any sequential zones.
+	 */
+	zlim->mapped_nr_seq_zones += zc.target_nr_seq_zones;
+
+	return 0;
+}
+
 int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q,
 		struct queue_limits *lim)
 {
 	struct mapped_device *md = t->md;
 	struct gendisk *disk = md->disk;
-	unsigned int nr_conv_zones = 0;
-	int ret;
+	struct dm_zone_resource_limits zlim = {
+		.reliable_limits = true,
+		.lim = lim,
+	};
 
 	/*
 	 * Check if zone append is natively supported, and if not, set the
@@ -249,32 +348,53 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q,
 	}
 
 	/*
-	 * Count conventional zones to check that the mapped device will indeed 
-	 * have sequential write required zones.
+	 * Determine the max open and max active zone limits for the mapped
+	 * device by inspecting the zone resource limits and the zones mapped
+	 * by each target.
 	 */
-	md->zone_revalidate_map = t;
-	ret = dm_blk_report_zones(disk, 0, UINT_MAX,
-				  dm_check_zoned_cb, &nr_conv_zones);
-	md->zone_revalidate_map = NULL;
-	if (ret < 0) {
-		DMERR("Check zoned failed %d", ret);
-		return ret;
+	for (unsigned int i = 0; i < t->num_targets; i++) {
+		struct dm_target *ti = dm_table_get_target(t, i);
+
+		if (!ti->type->iterate_devices ||
+		    ti->type->iterate_devices(ti,
+				device_get_zone_resource_limits, &zlim)) {
+			DMERR("Could not determine %s zone resource limits",
+			      disk->disk_name);
+			return -ENODEV;
+		}
 	}
 
 	/*
-	 * If we only have conventional zones, expose the mapped device as
-	 * a regular device.
+	 * If we only have conventional zones mapped, expose the mapped device
+	 + as a regular device.
 	 */
-	if (nr_conv_zones >= ret) {
+	if (!zlim.mapped_nr_seq_zones) {
 		lim->max_open_zones = 0;
 		lim->max_active_zones = 0;
+		lim->max_zone_append_sectors = 0;
+		lim->zone_write_granularity = 0;
+		lim->chunk_sectors = 0;
 		lim->zoned = false;
 		clear_bit(DMF_EMULATE_ZONE_APPEND, &md->flags);
+		md->nr_zones = 0;
 		disk->nr_zones = 0;
 		return 0;
 	}
 
-	if (!static_key_enabled(&zoned_enabled.key))
+	/*
+	 * Warn once (when the capacity is not yet set) if the mapped device is
+	 * partially using zone resources of the target devices as that leads to
+	 * unreliable limits, i.e. if another mapped device uses the same
+	 * underlying devices, we cannot enforce zone limits to guarantee that
+	 * writing will not lead to errors. Note that we really should return
+	 * an error for such case but there is no easy way to find out if
+	 * another mapped device uses the same underlying zoned devices.
+	 */
+	if (!get_capacity(disk) && !zlim.reliable_limits)
+		DMWARN("%s zone resource limits may be unreliable",
+		       disk->disk_name);
+
+	if (lim->zoned && !static_key_enabled(&zoned_enabled.key))
 		static_branch_enable(&zoned_enabled);
 	return 0;
 }
-- 
2.45.2


