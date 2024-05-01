Return-Path: <linux-block+bounces-6803-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEAD8B88E9
	for <lists+linux-block@lfdr.de>; Wed,  1 May 2024 13:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFBD11F24990
	for <lists+linux-block@lfdr.de>; Wed,  1 May 2024 11:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765845F873;
	Wed,  1 May 2024 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/RhAX4/"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA655EE80;
	Wed,  1 May 2024 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561752; cv=none; b=NTGqWr2h4LQBCqmoNJGIsEqeHGrwsikU7MhOtTR6GVcAQZjhUHnHteDqN1LW/8zqRkl9j8V3k2PsyXFlmUAK13WPOA8suFKDG4zt7TqKHWOq/TPHFH/tiNxdJjX3WWu4VN94p/8PGWnKO8LSqaziAZoZpqoJnmjkoJevSIekIoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561752; c=relaxed/simple;
	bh=JilaBqS0AytA5QSmYBjhT8Z+lqeHZf6x5YkNDNfihoE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyExiS4SFHaKeM1CHkOK7X0KvgNQNf6Lkmp9EQ3Uah93RbVnwh6QPt+Hj449fNBB5y+Qg2zrt6rS+pRR86dtB04tgVgFPI3if9JiqtXLLSZwE3GjqiLDz3KhKpGfqpIkNifE+6S9xM7PrqyW7KCOfPJx0Fj3xS9Tu4+XX/k7Vr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/RhAX4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2507EC4AF1D;
	Wed,  1 May 2024 11:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714561751;
	bh=JilaBqS0AytA5QSmYBjhT8Z+lqeHZf6x5YkNDNfihoE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f/RhAX4/2o3Ux536ITFEp315HbgJ8ML4FA/wCSDc5D/E1CiviyOTFL3P6SyaQcO2w
	 OzdJzk0vxFQl3nHroX8I+H4S6rEyJQvkikmb/2a+5vL4Qc+FRKNtIDrcs9bZ2b+unr
	 3b8/hmTNR71AAsKw+TdNbG0CJgxay0z//R5tewIruCsnrByEuJfc7TKja0nVgqbNhM
	 hnOO6CYmB/2QjpYg5AhusM+LU9+BXwr7Vax0oQLwXsC90VzeQLiql9S7oEzzy1DpfY
	 d7QKdlbqKVXf5N/Ud4QAaOI7dxWhGcO6Fw4PUoujOYyfpHtp62B2kPTzkUhCdlqoqS
	 MZU89kYEqocmA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH v3 02/14] block: Exclude conventional zones when faking max open limit
Date: Wed,  1 May 2024 20:08:55 +0900
Message-ID: <20240501110907.96950-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501110907.96950-1-dlemoal@kernel.org>
References: <20240501110907.96950-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a device that has no limits for the maximum number of open and
active zones, we default to using the number of zones, limited to
BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE (128), for the maximum number of open
zones indicated to the user. However, for a device that has conventional
zones and less zones than BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE, we should
not account conventional zones and set the limit to the number of
sequential write required zones. Furthermore, for cases where the limit
is equal to the number of sequential write required zones, we can
advertize a limit of 0 to indicate "no limits".

Fix this by moving the zone write plug mempool resizing from
disk_revalidate_zone_resources() to disk_update_zone_resources() where
we can safely compute the number of conventional zones and update the
limits.

Fixes: 843283e96e5a ("block: Fake max open zones limit when there is no limit")
Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index bad68277c0b2..731d1abb80f6 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1513,10 +1513,6 @@ static int disk_revalidate_zone_resources(struct gendisk *disk,
 	if (!disk->zone_wplugs_hash)
 		return disk_alloc_zone_resources(disk, pool_size);
 
-	/* Resize the zone write plug memory pool if needed. */
-	if (disk->zone_wplugs_pool->min_nr != pool_size)
-		return mempool_resize(disk->zone_wplugs_pool, pool_size);
-
 	return 0;
 }
 
@@ -1536,11 +1532,24 @@ static int disk_update_zone_resources(struct gendisk *disk,
 				      struct blk_revalidate_zone_args *args)
 {
 	struct request_queue *q = disk->queue;
+	unsigned int nr_seq_zones, nr_conv_zones = 0;
+	unsigned int pool_size;
 	struct queue_limits lim;
 
 	disk->nr_zones = args->nr_zones;
 	disk->zone_capacity = args->zone_capacity;
 	swap(disk->conv_zones_bitmap, args->conv_zones_bitmap);
+	if (disk->conv_zones_bitmap)
+		nr_conv_zones = bitmap_weight(disk->conv_zones_bitmap,
+					      disk->nr_zones);
+	if (nr_conv_zones >= disk->nr_zones) {
+		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
+			disk->disk_name, nr_conv_zones, disk->nr_zones);
+		return -ENODEV;
+	}
+
+	if (!disk->zone_wplugs_pool)
+		return 0;
 
 	/*
 	 * If the device has no limit on the maximum number of open and active
@@ -1549,14 +1558,23 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	 * dynamic zone write plug allocation when simultaneously writing to
 	 * more zones than the size of the mempool.
 	 */
-	if (disk->zone_wplugs_pool) {
-		lim = queue_limits_start_update(q);
-		if (!lim.max_open_zones && !lim.max_active_zones)
-			lim.max_open_zones = disk->zone_wplugs_pool->min_nr;
-		return queue_limits_commit_update(q, &lim);
+	lim = queue_limits_start_update(q);
+
+	nr_seq_zones = disk->nr_zones - nr_conv_zones;
+	pool_size = max(lim.max_open_zones, lim.max_active_zones);
+	if (!pool_size)
+		pool_size = min(BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE, nr_seq_zones);
+
+	mempool_resize(disk->zone_wplugs_pool, pool_size);
+
+	if (!lim.max_open_zones && !lim.max_active_zones) {
+		if (pool_size < nr_seq_zones)
+			lim.max_open_zones = pool_size;
+		else
+			lim.max_open_zones = 0;
 	}
 
-	return 0;
+	return queue_limits_commit_update(q, &lim);
 }
 
 /*
-- 
2.44.0


