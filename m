Return-Path: <linux-block+bounces-8557-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08946902E7B
	for <lists+linux-block@lfdr.de>; Tue, 11 Jun 2024 04:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B326D1F2381A
	for <lists+linux-block@lfdr.de>; Tue, 11 Jun 2024 02:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EE716F8E8;
	Tue, 11 Jun 2024 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTUzrW1a"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB916F85D;
	Tue, 11 Jun 2024 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073406; cv=none; b=CpigoYeY5F8jfsEb7bc0doIMM063IkMvJFyMw2coRcUT4fHxy0m6w0WNKy1FHNVsvrzpDvBpKeYqGiJMGodXNGwvx2HEve4gQyfB1NyV2KDL5VmBkyotAl4UIxoaa1vMOEDwbkpBw/rSTiUrrc4He++kpVjsi5yS3VHeLP3gNlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073406; c=relaxed/simple;
	bh=cuBijLhy38z5QDUbyu6FZU4RwSoVcWll8pILiB4XYLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+K0aeodwei6VpRcuRSrNzssiTEIZ8WxRkCxoWci7ZXm9z6E0jt4IoZjtLWxX8WPopbdXaycsldKsD+HLRzHMF3yLxg/zomsJdRyrs793S3Nx6yuctYpvcOd2nk2F8tqd+c2Mx7mi/pSFiOzNMYFJitUl8IgVyx42JpDTIcsoiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTUzrW1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC28C4AF50;
	Tue, 11 Jun 2024 02:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718073405;
	bh=cuBijLhy38z5QDUbyu6FZU4RwSoVcWll8pILiB4XYLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TTUzrW1ac5QzKZIy1gIpJy9vpUXBviWRwXnMBFYy4+PCNcIGwix4dymfNf/BSdhRQ
	 EGAEcrCrgBGDojAcJnkinGqtnFRGKwSwpCUfTyCynoLpXR8UWB2yf56shTI/ey12MZ
	 UgH/AOnQ3m8mHG0GcSPSL2cHF/Adxk9TOGW5e3q/R2VyAUcfgMPRoqdIVpH7zhh/Iw
	 ZX1yTO/64ZOle2lXL4JiT+0GQrFh58FApeSpopZPjkB1Raic2PmocaATWnYBTRfSJl
	 ce9mBSP6Cp0myx4LRTeVcmlcifniQ1Zgz2eAkHN09ypIFJHRsTB2YFWUrd1dyw6UqZ
	 zJaqnMbSnFMlg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Benjamin Marzinski <bmarzins@redhat.com>
Subject: [PATCH v8 2/4] dm: Call dm_revalidate_zones() after setting the queue limits
Date: Tue, 11 Jun 2024 11:36:37 +0900
Message-ID: <20240611023639.89277-3-dlemoal@kernel.org>
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

dm_revalidate_zones() is called from dm_set_zone_restrictions() when the
mapped device queue limits are not yet set. However,
dm_revalidate_zones() calls blk_revalidate_disk_zones() and this
function consults and modifies the mapped device queue limits. Thus,
currently, blk_revalidate_disk_zones() operates on limits that are not
yet initialized.

Fix this by moving the call to dm_revalidate_zones() out of
dm_set_zone_restrictions() and into dm_table_set_restrictions() after
executing queue_limits_set().

To further cleanup dm_set_zones_restrictions(), the message about the
type of zone append (native or emulated) is also moved inside
dm_revalidate_zones().

Fixes: 1c0e720228ad ("dm: use queue_limits_set")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Benjamin Marzinski <bmarzins@redhat.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/md/dm-table.c | 15 +++++++++++----
 drivers/md/dm-zone.c  | 25 ++++++++++---------------
 drivers/md/dm.h       |  1 +
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index b2d5246cff21..2fc847af254d 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -2028,10 +2028,7 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	    dm_table_any_dev_attr(t, device_is_not_random, NULL))
 		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
 
-	/*
-	 * For a zoned target, setup the zones related queue attributes
-	 * and resources necessary for zone append emulation if necessary.
-	 */
+	/* For a zoned table, setup the zone related queue attributes. */
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && limits->zoned) {
 		r = dm_set_zones_restrictions(t, q, limits);
 		if (r)
@@ -2042,6 +2039,16 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	if (r)
 		return r;
 
+	/*
+	 * Now that the limits are set, check the zones mapped by the table
+	 * and setup the resources for zone append emulation if necessary.
+	 */
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && limits->zoned) {
+		r = dm_revalidate_zones(t, q);
+		if (r)
+			return r;
+	}
+
 	dm_update_crypto_profile(q, t);
 
 	/*
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 5d66d916730e..75d0019a0649 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -166,14 +166,22 @@ static int dm_check_zoned_cb(struct blk_zone *zone, unsigned int idx,
  * blk_revalidate_disk_zones() function here as the mapped device is suspended
  * (this is called from __bind() context).
  */
-static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
+int dm_revalidate_zones(struct dm_table *t, struct request_queue *q)
 {
+	struct mapped_device *md = t->md;
 	struct gendisk *disk = md->disk;
 	int ret;
 
+	if (!get_capacity(disk))
+		return 0;
+
 	/* Revalidate only if something changed. */
-	if (!disk->nr_zones || disk->nr_zones != md->nr_zones)
+	if (!disk->nr_zones || disk->nr_zones != md->nr_zones) {
+		DMINFO("%s using %s zone append",
+		       disk->disk_name,
+		       queue_emulates_zone_append(q) ? "emulated" : "native");
 		md->nr_zones = 0;
+	}
 
 	if (md->nr_zones)
 		return 0;
@@ -240,9 +248,6 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q,
 		lim->max_zone_append_sectors = 0;
 	}
 
-	if (!get_capacity(md->disk))
-		return 0;
-
 	/*
 	 * Count conventional zones to check that the mapped device will indeed 
 	 * have sequential write required zones.
@@ -269,16 +274,6 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q,
 		return 0;
 	}
 
-	if (!md->disk->nr_zones) {
-		DMINFO("%s using %s zone append",
-		       md->disk->disk_name,
-		       queue_emulates_zone_append(q) ? "emulated" : "native");
-	}
-
-	ret = dm_revalidate_zones(md, t);
-	if (ret < 0)
-		return ret;
-
 	if (!static_key_enabled(&zoned_enabled.key))
 		static_branch_enable(&zoned_enabled);
 	return 0;
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index 53ef8207fe2c..c984ecb64b1e 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -103,6 +103,7 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t);
  */
 int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q,
 		struct queue_limits *lim);
+int dm_revalidate_zones(struct dm_table *t, struct request_queue *q);
 void dm_zone_endio(struct dm_io *io, struct bio *clone);
 #ifdef CONFIG_BLK_DEV_ZONED
 int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
-- 
2.45.2


