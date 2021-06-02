Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53936398E9E
	for <lists+linux-block@lfdr.de>; Wed,  2 Jun 2021 17:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhFBPcW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Jun 2021 11:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhFBPcV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 11:32:21 -0400
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB6EC061756;
        Wed,  2 Jun 2021 08:30:38 -0700 (PDT)
Received: from sas1-6b1512233ef6.qloud-c.yandex.net (sas1-6b1512233ef6.qloud-c.yandex.net [IPv6:2a02:6b8:c14:44af:0:640:6b15:1223])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 458852E1A0D;
        Wed,  2 Jun 2021 18:29:19 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-6b1512233ef6.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id uDRfnrUgrB-TI1eXYka;
        Wed, 02 Jun 2021 18:29:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1622647759; bh=Wzo/vLlBwirWfMiicMvFnXKPcAKNw18ynjo+b/sZOK0=;
        h=Message-Id:References:Date:Subject:To:From:In-Reply-To:Cc;
        b=nfZmxyDo4wTP7jUPoyLIXS9iKRHL2kmDQaR1NPB0cuQ7bJje/VN/Rcc+rWAlIib8S
         lxx02tUxQocXbk+HBrAc782nUgV/ez7gw1JJLML03aK9bLHQHn6vN+kdKq/Pb/SzZL
         CRRzvPiNrsjacs8MLD3Q7gZG5i+79Wa2CQAxSwgk=
Authentication-Results: sas1-6b1512233ef6.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from warwish-linux.sas.yp-c.yandex.net (warwish-linux.sas.yp-c.yandex.net [2a02:6b8:c1b:2920:0:696:cc9e:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 42DbdVHlBw-TIoiLc6n;
        Wed, 02 Jun 2021 18:29:18 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Anton Suvorov <warwish@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     warwish@yandex-team.ru, linux-fsdevel@vger.kernel.org,
        dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH 04/10] dm: reduce stack footprint dealing with block device names
Date:   Wed,  2 Jun 2021 18:28:57 +0300
Message-Id: <20210602152903.910190-5-warwish@yandex-team.ru>
In-Reply-To: <20210602152903.910190-1-warwish@yandex-team.ru>
References: <20210602152903.910190-1-warwish@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Stack usage reduced (measured with allyesconfig):

./drivers/md/dm-cache-target.c	cache_ctr	392	328	-64
./drivers/md/dm-cache-target.c	cache_io_hints	208	72	-136
./drivers/md/dm-clone-target.c	clone_ctr	416	352	-64
./drivers/md/dm-clone-target.c	clone_io_hints	216	80	-136
./drivers/md/dm-crypt.c	crypt_convert_block_aead	408	272	-136
./drivers/md/dm-crypt.c	kcryptd_async_done	192	56	-136
./drivers/md/dm-integrity.c	integrity_metadata	872	808	-64
./drivers/md/dm-mpath.c	parse_priority_group	368	304	-64
./drivers/md/dm-table.c	device_area_is_invalid	216	80	-136
./drivers/md/dm-table.c	dm_set_device_limits	200	72	-128
./drivers/md/dm-thin.c	pool_io_hints	216	80	-136

Signed-off-by: Anton Suvorov <warwish@yandex-team.ru>
---
 drivers/md/dm-cache-target.c | 10 ++++------
 drivers/md/dm-clone-target.c | 10 ++++------
 drivers/md/dm-crypt.c        |  6 ++----
 drivers/md/dm-integrity.c    |  4 ++--
 drivers/md/dm-mpath.c        |  6 ++----
 drivers/md/dm-table.c        | 34 ++++++++++++++++------------------
 drivers/md/dm-thin.c         |  8 +++-----
 7 files changed, 33 insertions(+), 45 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index d62ec0380c39..981739043bfb 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2096,7 +2096,6 @@ static int parse_metadata_dev(struct cache_args *ca, struct dm_arg_set *as,
 {
 	int r;
 	sector_t metadata_dev_size;
-	char b[BDEVNAME_SIZE];
 
 	if (!at_least_one_arg(as, error))
 		return -EINVAL;
@@ -2110,8 +2109,8 @@ static int parse_metadata_dev(struct cache_args *ca, struct dm_arg_set *as,
 
 	metadata_dev_size = get_dev_size(ca->metadata_dev);
 	if (metadata_dev_size > DM_CACHE_METADATA_MAX_SECTORS_WARNING)
-		DMWARN("Metadata device %s is larger than %u sectors: excess space will not be used.",
-		       bdevname(ca->metadata_dev->bdev, b), THIN_METADATA_MAX_SECTORS);
+		DMWARN("Metadata device %pg is larger than %u sectors: excess space will not be used.",
+		       ca->metadata_dev->bdev, THIN_METADATA_MAX_SECTORS);
 
 	return 0;
 }
@@ -3402,7 +3401,6 @@ static void disable_passdown_if_not_supported(struct cache *cache)
 	struct block_device *origin_bdev = cache->origin_dev->bdev;
 	struct queue_limits *origin_limits = &bdev_get_queue(origin_bdev)->limits;
 	const char *reason = NULL;
-	char buf[BDEVNAME_SIZE];
 
 	if (!cache->features.discard_passdown)
 		return;
@@ -3414,8 +3412,8 @@ static void disable_passdown_if_not_supported(struct cache *cache)
 		reason = "max discard sectors smaller than a block";
 
 	if (reason) {
-		DMWARN("Origin device (%s) %s: Disabling discard passdown.",
-		       bdevname(origin_bdev, buf), reason);
+		DMWARN("Origin device (%pg) %s: Disabling discard passdown.",
+		       origin_bdev, reason);
 		cache->features.discard_passdown = false;
 	}
 }
diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
index a90bdf9b2ca6..10e2e8d8fbec 100644
--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -1677,7 +1677,6 @@ static int parse_metadata_dev(struct clone *clone, struct dm_arg_set *as, char *
 {
 	int r;
 	sector_t metadata_dev_size;
-	char b[BDEVNAME_SIZE];
 
 	r = dm_get_device(clone->ti, dm_shift_arg(as), FMODE_READ | FMODE_WRITE,
 			  &clone->metadata_dev);
@@ -1688,8 +1687,8 @@ static int parse_metadata_dev(struct clone *clone, struct dm_arg_set *as, char *
 
 	metadata_dev_size = get_dev_size(clone->metadata_dev);
 	if (metadata_dev_size > DM_CLONE_METADATA_MAX_SECTORS_WARNING)
-		DMWARN("Metadata device %s is larger than %u sectors: excess space will not be used.",
-		       bdevname(clone->metadata_dev->bdev, b), DM_CLONE_METADATA_MAX_SECTORS);
+		DMWARN("Metadata device %pg is larger than %u sectors: excess space will not be used.",
+		       clone->metadata_dev->bdev, DM_CLONE_METADATA_MAX_SECTORS);
 
 	return 0;
 }
@@ -2028,7 +2027,6 @@ static void disable_passdown_if_not_supported(struct clone *clone)
 	struct block_device *dest_dev = clone->dest_dev->bdev;
 	struct queue_limits *dest_limits = &bdev_get_queue(dest_dev)->limits;
 	const char *reason = NULL;
-	char buf[BDEVNAME_SIZE];
 
 	if (!test_bit(DM_CLONE_DISCARD_PASSDOWN, &clone->flags))
 		return;
@@ -2039,8 +2037,8 @@ static void disable_passdown_if_not_supported(struct clone *clone)
 		reason = "max discard sectors smaller than a region";
 
 	if (reason) {
-		DMWARN("Destination device (%s) %s: Disabling discard passdown.",
-		       bdevname(dest_dev, buf), reason);
+		DMWARN("Destination device (%pg) %s: Disabling discard passdown.",
+		       dest_dev, reason);
 		clear_bit(DM_CLONE_DISCARD_PASSDOWN, &clone->flags);
 	}
 }
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index b0ab080f2567..993dda7d67c2 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1361,8 +1361,7 @@ static int crypt_convert_block_aead(struct crypt_config *cc,
 	}
 
 	if (r == -EBADMSG) {
-		char b[BDEVNAME_SIZE];
-		DMERR_LIMIT("%s: INTEGRITY AEAD ERROR, sector %llu", bio_devname(ctx->bio_in, b),
+		DMERR_LIMIT("%pg: INTEGRITY AEAD ERROR, sector %llu", ctx->bio_in->bi_bdev,
 			    (unsigned long long)le64_to_cpu(*sector));
 	}
 
@@ -2172,8 +2171,7 @@ static void kcryptd_async_done(struct crypto_async_request *async_req,
 		error = cc->iv_gen_ops->post(cc, org_iv_of_dmreq(cc, dmreq), dmreq);
 
 	if (error == -EBADMSG) {
-		char b[BDEVNAME_SIZE];
-		DMERR_LIMIT("%s: INTEGRITY AEAD ERROR, sector %llu", bio_devname(ctx->bio_in, b),
+		DMERR_LIMIT("%pg: INTEGRITY AEAD ERROR, sector %llu", ctx->bio_in->bi_bdev,
 			    (unsigned long long)le64_to_cpu(*org_sector_of_dmreq(cc, dmreq)));
 		io->error = BLK_STS_PROTECTION;
 	} else if (error < 0)
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 20f2510db1f6..d2fec41635ff 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1781,8 +1781,8 @@ static void integrity_metadata(struct work_struct *w)
 						checksums_ptr - checksums, dio->op == REQ_OP_READ ? TAG_CMP : TAG_WRITE);
 			if (unlikely(r)) {
 				if (r > 0) {
-					char b[BDEVNAME_SIZE];
-					DMERR_LIMIT("%s: Checksum failed at sector 0x%llx", bio_devname(bio, b),
+					DMERR_LIMIT("%pg: Checksum failed at sector 0x%llx",
+						    bio->bi_bdev,
 						    (sector - ((r + ic->tag_size - 1) / ic->tag_size)));
 					r = -EILSEQ;
 					atomic64_inc(&ic->number_of_mismatches);
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index bced42f082b0..678e5bb0fa5a 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -900,10 +900,8 @@ static int setup_scsi_dh(struct block_device *bdev, struct multipath *m,
 	if (m->hw_handler_name) {
 		r = scsi_dh_attach(q, m->hw_handler_name);
 		if (r == -EBUSY) {
-			char b[BDEVNAME_SIZE];
-
-			printk(KERN_INFO "dm-mpath: retaining handler on device %s\n",
-			       bdevname(bdev, b));
+			pr_info("dm-mpath: retaining handler on device %pg\n",
+				bdev);
 			goto retain;
 		}
 		if (r < 0) {
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 7e88e5e06922..175b9c7b1c48 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -230,15 +230,14 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 		i_size_read(bdev->bd_inode) >> SECTOR_SHIFT;
 	unsigned short logical_block_size_sectors =
 		limits->logical_block_size >> SECTOR_SHIFT;
-	char b[BDEVNAME_SIZE];
 
 	if (!dev_size)
 		return 0;
 
 	if ((start >= dev_size) || (start + len > dev_size)) {
-		DMWARN("%s: %s too small for target: "
+		DMWARN("%s: %pg too small for target: "
 		       "start=%llu, len=%llu, dev_size=%llu",
-		       dm_device_name(ti->table->md), bdevname(bdev, b),
+		       dm_device_name(ti->table->md), bdev,
 		       (unsigned long long)start,
 		       (unsigned long long)len,
 		       (unsigned long long)dev_size);
@@ -253,10 +252,10 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 		unsigned int zone_sectors = bdev_zone_sectors(bdev);
 
 		if (start & (zone_sectors - 1)) {
-			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %s",
+			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
 			       (unsigned long long)start,
-			       zone_sectors, bdevname(bdev, b));
+			       zone_sectors, bdev);
 			return 1;
 		}
 
@@ -270,10 +269,10 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 		 * the sector range.
 		 */
 		if (len & (zone_sectors - 1)) {
-			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %s",
+			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
 			       (unsigned long long)len,
-			       zone_sectors, bdevname(bdev, b));
+			       zone_sectors, bdev);
 			return 1;
 		}
 	}
@@ -282,20 +281,20 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 		return 0;
 
 	if (start & (logical_block_size_sectors - 1)) {
-		DMWARN("%s: start=%llu not aligned to h/w "
-		       "logical block size %u of %s",
+		DMWARN("%s: start=%llu not aligned to h/w logical block size %u of %pg",
 		       dm_device_name(ti->table->md),
 		       (unsigned long long)start,
-		       limits->logical_block_size, bdevname(bdev, b));
+		       limits->logical_block_size,
+		       bdev);
 		return 1;
 	}
 
 	if (len & (logical_block_size_sectors - 1)) {
-		DMWARN("%s: len=%llu not aligned to h/w "
-		       "logical block size %u of %s",
+		DMWARN("%s: len=%llu not aligned to h/w logical block size %u of %pg",
 		       dm_device_name(ti->table->md),
 		       (unsigned long long)len,
-		       limits->logical_block_size, bdevname(bdev, b));
+		       limits->logical_block_size,
+		       bdev);
 		return 1;
 	}
 
@@ -400,20 +399,19 @@ static int dm_set_device_limits(struct dm_target *ti, struct dm_dev *dev,
 	struct queue_limits *limits = data;
 	struct block_device *bdev = dev->bdev;
 	struct request_queue *q = bdev_get_queue(bdev);
-	char b[BDEVNAME_SIZE];
 
 	if (unlikely(!q)) {
-		DMWARN("%s: Cannot set limits for nonexistent device %s",
-		       dm_device_name(ti->table->md), bdevname(bdev, b));
+		DMWARN("%s: Cannot set limits for nonexistent device %pg",
+		       dm_device_name(ti->table->md), bdev);
 		return 0;
 	}
 
 	if (blk_stack_limits(limits, &q->limits,
 			get_start_sect(bdev) + start) < 0)
-		DMWARN("%s: adding target device %s caused an alignment inconsistency: "
+		DMWARN("%s: adding target device %pg caused an alignment inconsistency: "
 		       "physical_block_size=%u, logical_block_size=%u, "
 		       "alignment_offset=%u, start=%llu",
-		       dm_device_name(ti->table->md), bdevname(bdev, b),
+		       dm_device_name(ti->table->md), bdev,
 		       q->limits.physical_block_size,
 		       q->limits.logical_block_size,
 		       q->limits.alignment_offset,
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 031d60318e1e..94a53c59aaa0 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -2834,7 +2834,6 @@ static void disable_passdown_if_not_supported(struct pool_c *pt)
 	struct block_device *data_bdev = pt->data_dev->bdev;
 	struct queue_limits *data_limits = &bdev_get_queue(data_bdev)->limits;
 	const char *reason = NULL;
-	char buf[BDEVNAME_SIZE];
 
 	if (!pt->adjusted_pf.discard_passdown)
 		return;
@@ -2846,7 +2845,7 @@ static void disable_passdown_if_not_supported(struct pool_c *pt)
 		reason = "max discard sectors smaller than a block";
 
 	if (reason) {
-		DMWARN("Data device (%s) %s: Disabling discard passdown.", bdevname(data_bdev, buf), reason);
+		DMWARN("Data device (%pg) %s: Disabling discard passdown.", data_bdev, reason);
 		pt->adjusted_pf.discard_passdown = false;
 	}
 }
@@ -3218,11 +3217,10 @@ static sector_t get_dev_size(struct block_device *bdev)
 static void warn_if_metadata_device_too_big(struct block_device *bdev)
 {
 	sector_t metadata_dev_size = get_dev_size(bdev);
-	char buffer[BDEVNAME_SIZE];
 
 	if (metadata_dev_size > THIN_METADATA_MAX_SECTORS_WARNING)
-		DMWARN("Metadata device %s is larger than %u sectors: excess space will not be used.",
-		       bdevname(bdev, buffer), THIN_METADATA_MAX_SECTORS);
+		DMWARN("Metadata device %pg is larger than %u sectors: excess space will not be used.",
+		       bdev, THIN_METADATA_MAX_SECTORS);
 }
 
 static sector_t get_metadata_dev_size(struct block_device *bdev)
-- 
2.25.1

