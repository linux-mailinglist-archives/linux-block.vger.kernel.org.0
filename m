Return-Path: <linux-block+bounces-6781-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814D98B8384
	for <lists+linux-block@lfdr.de>; Wed,  1 May 2024 02:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0AA2833CB
	for <lists+linux-block@lfdr.de>; Wed,  1 May 2024 00:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CA84A28;
	Wed,  1 May 2024 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZE+GuJTo"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F014546BA;
	Wed,  1 May 2024 00:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714522181; cv=none; b=dvODVkD5U9ADGNrsAVXUiKSXbSAbjyJ8472NE28Q2a+BFb+8txnlH8CDzTqonSj/OpE9AQ6QpITzcKnz3S/TPQRTp+StpmhlNUnDH+1Jqc56p20q4mqYBCbeDcqiOnybTyba1irnaopy+4qxVaeX8O1H9stqR9JyGdKo1XGPkZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714522181; c=relaxed/simple;
	bh=hKhf3tu/OWCDWFwaZGcp2SnI5XVx3uBpkPAcElWwqTg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbL+DPE1Rf0e4NmxsJtWY48+l2xhSw53XYR/Mg0NT2SiLrphfQHIw8HIkbFI3a2F3wl4P7xHAHpV5kmgm3RRdEKNG5p/uq1nOm+lDLqXWKNiUMlGQUf7lXnyG0e6Zlq5yPjmciFv5Z/WkbJGGYQgLWwkJLTS7Fcr2XvlqgJFwjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZE+GuJTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EB0C4AF1C;
	Wed,  1 May 2024 00:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714522180;
	bh=hKhf3tu/OWCDWFwaZGcp2SnI5XVx3uBpkPAcElWwqTg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZE+GuJToJwF5V2wonCwgYj7EbitfKeizcG14BYyTTM9Vnf5uYcWVcNAxaMJSQM9Ep
	 ts3ubtpXsnJqyrM/pltEnB/4Kn9ABqXS6iOeqd/qx2WbnJ2BzRbV5JLpBuWlPtV6ZV
	 yApFzTPZ5/U4weQRlGkERvOQhe4jc6aGcuzJ2dP5Ju7Mha5mehtObVPnI0knwLJDGW
	 eQkJsbort48rjbJulLRQFAfVXMB83glwSPj/3FbZeP86sBh3GoUZUHOkAQBM+xssFz
	 7Ib7dGERDMP4GxgImbhmhAhWqyF75cs3QqP4ZLfc9SyhQheMfj7MDlAIgdVIOYkIol
	 a+2LIv39xhD2w==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH v2 03/14] block: Fix zone write plug initialization from blk_revalidate_zone_cb()
Date: Wed,  1 May 2024 09:09:24 +0900
Message-ID: <20240501000935.100534-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501000935.100534-1-dlemoal@kernel.org>
References: <20240501000935.100534-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When revalidating the zones of a zoned block device,
blk_revalidate_zone_cb() must allocate a zone write plug for any
sequential write required zone that is not empty nor full. However, the
current code tests the latter case by comparing the zone write pointer
offset to the zone size instead of the zone capacity. Furthermore,
disk_get_and_lock_zone_wplug() is called with a sector argument equal to
the zone start instead of the current zone write pointer position.
This commit fixes both issues by calling disk_get_and_lock_zone_wplug()
for a zone that is not empty and with a write pointer offset lower than
the zone capacity and use the zone capacity sector as the sector
argument for disk_get_and_lock_zone_wplug().

Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 6cf3e319513c..e92ae0729cf8 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1666,10 +1666,11 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		 * empty nor full. So make sure we have a zone write plug for
 		 * such zone if the device has a zone write plug hash table.
 		 */
+		if (!disk->zone_wplugs_hash)
+			break;
 		wp_offset = blk_zone_wp_offset(zone);
-		if (disk->zone_wplugs_hash &&
-		    wp_offset && wp_offset < zone_sectors) {
-			zwplug = disk_get_and_lock_zone_wplug(disk, zone->start,
+		if (wp_offset && wp_offset < zone->capacity) {
+			zwplug = disk_get_and_lock_zone_wplug(disk, zone->wp,
 							      GFP_NOIO, &flags);
 			if (!zwplug)
 				return -ENOMEM;
-- 
2.44.0


