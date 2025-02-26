Return-Path: <linux-block+bounces-17709-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7328CA45B33
	for <lists+linux-block@lfdr.de>; Wed, 26 Feb 2025 11:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8703B3ABFCD
	for <lists+linux-block@lfdr.de>; Wed, 26 Feb 2025 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71024E002;
	Wed, 26 Feb 2025 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MPDFhiG0"
X-Original-To: linux-block@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6390E24DFE8
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564384; cv=none; b=LYiXJsIgXAf6LuUpn7g86pvt1TArZJdakAgifpXBCbngvrPIsmIpMvpT84qmOLR1cqrUUtWcuyEpXawk9MQ8Y0uNmyan+BRu9q45HHB8PLGbi+9XCSzDaSPjx2oQL5UI9wu/JOjG1z0aQPNEw+0xBzmQEy+02eXQ+WFODDcgkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564384; c=relaxed/simple;
	bh=13WItm/cmZtHL87Hk457nTb6ISavmMO8sjEE8fA7cgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APPnkiVqCqy7+Z20UlGpRjB+sLCsq+BYn+bPAKay4nBG3lhnjpPJvbMl1Ysd7cjsubTo4hHIHD5Rb5TxnUsZxldnDOYtLnlzkvwr3tdr1zLUv02b7/BvNIX4NsifISMhP5sUjDHWlXoFjDsvw1lFMI2UHVe3A4/RryuJ8UYAxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MPDFhiG0; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740564382; x=1772100382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=13WItm/cmZtHL87Hk457nTb6ISavmMO8sjEE8fA7cgU=;
  b=MPDFhiG0+PUhJ+YygRnAm5v85zZJLM6rclKW7snzSSHj2gWmktPr+5PY
   4TPoOs6j/L5Z76PBsc/FsLwbm9ZckLDnb10qUEjLSSzXTQOyLrjCi8Roz
   V5PXZBwSyOrK8RobK1CYjI9gSeMgh8SXoG8Z3O3XQw1RvrfrEqCk49KCS
   hA2exHLcIs4o/tYubds6x12E1JK0Ieqjh6EAEeIlIL8ck7id2m8XI0fdx
   /2k8OJp4AL2tv3wEZh/NHp/m61cGmMEMhP4EK6KVzEkgga1HD0aF49ioy
   c30YaCFuK75i9XzxR5TbYfvMJ2TZ0GJ6ini/6rga6zGhfa0IjJnln+QT2
   Q==;
X-CSE-ConnectionGUID: XctRHH/dR6eP1IVjYTvI0A==
X-CSE-MsgGUID: 0Io1uv14Rf+9xyf06Jh6eQ==
X-IronPort-AV: E=Sophos;i="6.13,316,1732550400"; 
   d="scan'208";a="39484533"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2025 18:06:22 +0800
IronPort-SDR: 67bed9da_JcGeGtbUMeMOiAah4qWq8vDSl1FowmABMWecoCRFhwGiWUs
 +w/pKihlNujPezNtLg3GaQ50mSDkzY1PHqbFhww==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2025 01:07:38 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2025 02:06:21 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH for-next v7 5/5] null_blk: do partial IO for bad blocks
Date: Wed, 26 Feb 2025 19:06:13 +0900
Message-ID: <20250226100613.1622564-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250226100613.1622564-1-shinichiro.kawasaki@wdc.com>
References: <20250226100613.1622564-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current null_blk implementation checks if any bad blocks exist in
the target blocks of each IO. If so, the IO fails and data is not
transferred for all of the IO target blocks. However, when real storage
devices have bad blocks, the devices may transfer data partially up to
the first bad blocks (e.g., SAS drives). Especially, when the IO is a
write operation, such partial IO leaves partially written data on the
device.

To simulate such partial IO using null_blk, introduce the new parameter
'badblocks_partial_io'. When this parameter is set,
null_handle_badblocks() returns the number of the sectors for the
partial IO as its third pointer argument. Pass the returned number of
sectors to the following calls to null_handle_memory_backend() in
null_process_cmd() and null_zone_write().

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c     | 40 ++++++++++++++++++++++++-------
 drivers/block/null_blk/null_blk.h |  4 ++--
 drivers/block/null_blk/zoned.c    |  9 ++++---
 3 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 802576698812..31d44cef6841 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -474,6 +474,7 @@ NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
 NULLB_DEVICE_ATTR(fua, bool, NULL);
 NULLB_DEVICE_ATTR(rotational, bool, NULL);
 NULLB_DEVICE_ATTR(badblocks_once, bool, NULL);
+NULLB_DEVICE_ATTR(badblocks_partial_io, bool, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
 {
@@ -595,6 +596,7 @@ CONFIGFS_ATTR_WO(nullb_device_, zone_offline);
 static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_badblocks,
 	&nullb_device_attr_badblocks_once,
+	&nullb_device_attr_badblocks_partial_io,
 	&nullb_device_attr_blocking,
 	&nullb_device_attr_blocksize,
 	&nullb_device_attr_cache_size,
@@ -1321,19 +1323,40 @@ static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
 	return sts;
 }
 
+/*
+ * Check if the command should fail for the badblocks. If so, return
+ * BLK_STS_IOERR and return number of partial I/O sectors to be written or read,
+ * which may be less than the requested number of sectors.
+ *
+ * @cmd:        The command to handle.
+ * @sector:     The start sector for I/O.
+ * @nr_sectors: Specifies number of sectors to write or read, and returns the
+ *              number of sectors to be written or read.
+ */
 blk_status_t null_handle_badblocks(struct nullb_cmd *cmd, sector_t sector,
-				   sector_t nr_sectors)
+				   unsigned int *nr_sectors)
 {
 	struct badblocks *bb = &cmd->nq->dev->badblocks;
+	struct nullb_device *dev = cmd->nq->dev;
+	unsigned int block_sectors = dev->blocksize >> SECTOR_SHIFT;
 	sector_t first_bad;
 	int bad_sectors;
+	unsigned int partial_io_sectors = 0;
 
-	if (!badblocks_check(bb, sector, nr_sectors, &first_bad, &bad_sectors))
+	if (!badblocks_check(bb, sector, *nr_sectors, &first_bad, &bad_sectors))
 		return BLK_STS_OK;
 
 	if (cmd->nq->dev->badblocks_once)
 		badblocks_clear(bb, first_bad, bad_sectors);
 
+	if (cmd->nq->dev->badblocks_partial_io) {
+		if (!IS_ALIGNED(first_bad, block_sectors))
+			first_bad = ALIGN_DOWN(first_bad, block_sectors);
+		if (sector < first_bad)
+			partial_io_sectors = first_bad - sector;
+	}
+	*nr_sectors = partial_io_sectors;
+
 	return BLK_STS_IOERR;
 }
 
@@ -1392,18 +1415,19 @@ blk_status_t null_process_cmd(struct nullb_cmd *cmd, enum req_op op,
 			      sector_t sector, unsigned int nr_sectors)
 {
 	struct nullb_device *dev = cmd->nq->dev;
+	blk_status_t badblocks_ret = BLK_STS_OK;
 	blk_status_t ret;
 
-	if (dev->badblocks.shift != -1) {
-		ret = null_handle_badblocks(cmd, sector, nr_sectors);
+	if (dev->badblocks.shift != -1)
+		badblocks_ret = null_handle_badblocks(cmd, sector, &nr_sectors);
+
+	if (dev->memory_backed && nr_sectors) {
+		ret = null_handle_memory_backed(cmd, op, sector, nr_sectors);
 		if (ret != BLK_STS_OK)
 			return ret;
 	}
 
-	if (dev->memory_backed)
-		return null_handle_memory_backed(cmd, op, sector, nr_sectors);
-
-	return BLK_STS_OK;
+	return badblocks_ret;
 }
 
 static void null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index ee60f3a88796..7bb6128dbaaf 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -64,6 +64,7 @@ struct nullb_device {
 	unsigned int curr_cache;
 	struct badblocks badblocks;
 	bool badblocks_once;
+	bool badblocks_partial_io;
 
 	unsigned int nr_zones;
 	unsigned int nr_zones_imp_open;
@@ -133,11 +134,10 @@ blk_status_t null_handle_discard(struct nullb_device *dev, sector_t sector,
 blk_status_t null_process_cmd(struct nullb_cmd *cmd, enum req_op op,
 			      sector_t sector, unsigned int nr_sectors);
 blk_status_t null_handle_badblocks(struct nullb_cmd *cmd, sector_t sector,
-				   sector_t nr_sectors);
+				   unsigned int *nr_sectors);
 blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req_op op,
 				       sector_t sector, sector_t nr_sectors);
 
-
 #ifdef CONFIG_BLK_DEV_ZONED
 int null_init_zoned_dev(struct nullb_device *dev, struct queue_limits *lim);
 int null_register_zoned_dev(struct nullb *nullb);
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 7677f6cf23f4..4e5728f45989 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -353,6 +353,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
 	struct nullb_zone *zone = &dev->zones[zno];
+	blk_status_t badblocks_ret = BLK_STS_OK;
 	blk_status_t ret;
 
 	trace_nullb_zone_op(cmd, zno, zone->cond);
@@ -413,9 +414,11 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	}
 
 	if (dev->badblocks.shift != -1) {
-		ret = null_handle_badblocks(cmd, sector, nr_sectors);
-		if (ret != BLK_STS_OK)
+		badblocks_ret = null_handle_badblocks(cmd, sector, &nr_sectors);
+		if (badblocks_ret != BLK_STS_OK && !nr_sectors) {
+			ret = badblocks_ret;
 			goto unlock_zone;
+		}
 	}
 
 	if (dev->memory_backed) {
@@ -438,7 +441,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		zone->cond = BLK_ZONE_COND_FULL;
 	}
 
-	ret = BLK_STS_OK;
+	ret = badblocks_ret;
 
 unlock_zone:
 	null_unlock_zone(dev, zone);
-- 
2.47.0


