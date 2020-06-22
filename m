Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D84203C7B
	for <lists+linux-block@lfdr.de>; Mon, 22 Jun 2020 18:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgFVQZf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 22 Jun 2020 12:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbgFVQZd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jun 2020 12:25:33 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 352DB20767;
        Mon, 22 Jun 2020 16:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592843133;
        bh=NdlnDueaM2kAyVhJucVHNEWSj5SbWdxgXOtHXhq/U+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G0dDWRkJDJLzSNs2GULK5OmSsdbj4WXmIVTv5czIBgOuAXz33jNf6Ov77BLjRjMrI
         17yy+UO+N4t7YzGQHd8QW6+nu373VxlRVJzfPsr9mfC9PpyPPmGL++2+aJgpmC4MiZ
         flnCIBCIMUj8jM12+xRv4k5i5cAK0rZrqQJfcdiY=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Daniel Wagner <dwagner@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCHv3 1/5] block: add capacity field to zone descriptors
Date:   Mon, 22 Jun 2020 09:25:26 -0700
Message-Id: <20200622162530.1287650-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200622162530.1287650-1-kbusch@kernel.org>
References: <20200622162530.1287650-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Matias Bjørling <matias.bjorling@wdc.com>

In the zoned storage model, the sectors within a zone are typically all
writeable. With the introduction of the Zoned Namespace (ZNS) Command
Set in the NVM Express organization, the model was extended to have a
specific writeable capacity.

Extend the zone descriptor data structure with a zone capacity field to
indicate to the user how many sectors in a zone are writeable.

Introduce backward compatibility in the zone report ioctl by extending
the zone report header data structure with a flags field to indicate if
the capacity field is available.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Javier González <javier.gonz@samsung.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
---
 block/blk-zoned.c              |  1 +
 drivers/block/null_blk_zoned.c |  2 ++
 drivers/scsi/sd_zbc.c          |  1 +
 include/uapi/linux/blkzoned.h  | 15 +++++++++++++--
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 23831fa8701d..81152a260354 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -312,6 +312,7 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 		return ret;
 
 	rep.nr_zones = ret;
+	rep.flags = BLK_ZONE_REP_CAPACITY;
 	if (copy_to_user(argp, &rep, sizeof(struct blk_zone_report)))
 		return -EFAULT;
 	return 0;
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index cc47606d8ffe..624aac09b005 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -47,6 +47,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 
 		zone->start = sector;
 		zone->len = dev->zone_size_sects;
+		zone->capacity = zone->len;
 		zone->wp = zone->start + zone->len;
 		zone->type = BLK_ZONE_TYPE_CONVENTIONAL;
 		zone->cond = BLK_ZONE_COND_NOT_WP;
@@ -59,6 +60,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 
 		zone->start = zone->wp = sector;
 		zone->len = dev->zone_size_sects;
+		zone->capacity = zone->len;
 		zone->type = BLK_ZONE_TYPE_SEQWRITE_REQ;
 		zone->cond = BLK_ZONE_COND_EMPTY;
 
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 6f7eba66687e..183a20720da9 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -59,6 +59,7 @@ static int sd_zbc_parse_report(struct scsi_disk *sdkp, u8 *buf,
 		zone.non_seq = 1;
 
 	zone.len = logical_to_sectors(sdp, get_unaligned_be64(&buf[8]));
+	zone.capacity = zone.len;
 	zone.start = logical_to_sectors(sdp, get_unaligned_be64(&buf[16]));
 	zone.wp = logical_to_sectors(sdp, get_unaligned_be64(&buf[24]));
 	if (zone.type != ZBC_ZONE_TYPE_CONV &&
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index 0cdef67135f0..42c3366cc25f 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -73,6 +73,15 @@ enum blk_zone_cond {
 	BLK_ZONE_COND_OFFLINE	= 0xF,
 };
 
+/**
+ * enum blk_zone_report_flags - Feature flags of reported zone descriptors.
+ *
+ * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
+ */
+enum blk_zone_report_flags {
+	BLK_ZONE_REP_CAPACITY	= (1 << 0),
+};
+
 /**
  * struct blk_zone - Zone descriptor for BLKREPORTZONE ioctl.
  *
@@ -99,7 +108,9 @@ struct blk_zone {
 	__u8	cond;		/* Zone condition */
 	__u8	non_seq;	/* Non-sequential write resources active */
 	__u8	reset;		/* Reset write pointer recommended */
-	__u8	reserved[36];
+	__u8	resv[4];
+	__u64	capacity;	/* Zone capacity in number of sectors */
+	__u8	reserved[24];
 };
 
 /**
@@ -115,7 +126,7 @@ struct blk_zone {
 struct blk_zone_report {
 	__u64		sector;
 	__u32		nr_zones;
-	__u8		reserved[4];
+	__u32		flags;
 	struct blk_zone zones[0];
 };
 
-- 
2.24.1

