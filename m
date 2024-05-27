Return-Path: <linux-block+bounces-7783-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929858D0026
	for <lists+linux-block@lfdr.de>; Mon, 27 May 2024 14:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9D2284F0A
	for <lists+linux-block@lfdr.de>; Mon, 27 May 2024 12:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA9515E5AF;
	Mon, 27 May 2024 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NTesj0JI"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE4A38FA6;
	Mon, 27 May 2024 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813410; cv=none; b=JXLIHTtHeVUZmhGkXwzeWlZ3Z4VV/jpkGZHWcaiJKVGy3hn3bRHyWX+RbtBDCtFXbYJJDd0ddcOYhc9yKJTeXgcdrP2U9vQh6fV1gkjwobeXySmtZLBL9hUJ/lcVFpy3eh7Qajp4pubnSIGQMIoF+evhPqfSh4RA++P6iLCL5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813410; c=relaxed/simple;
	bh=quJlpP2nltsTBTb2lwdypxbNRTK5QV/treQQeeWa0/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kl5C2WR5nOrUGq1dmn+oI5H4KiR2frO4WdeElhenrtk9dugJx8rNrrZzdqVXC0GgVzyJjPEFLKGvrq6c95S0R3meOuos9pJZ7FZuIuG0NQEuzamg2LQbO84+UKrkT1tRZLEUK7+NkO79CoyB1S9SiVtdoe2yOf+kWtaUZVfwg08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NTesj0JI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Xw5VTmLtUcmmuhG0XHZfah6Xl9WiGswOVad2usHVz9A=; b=NTesj0JIa0b+4TQm8KNfHGfsYq
	Ie3rT6B77Jo3Lmxw3DSlGooYjbhZzRrx56ZlzU9+Q5v29yKDvaXnK+oQ/4oqoG4O0qO0IUKvVv2lU
	wAV17c0ASF1CzwijV7NKfkE0cxhXN6gLra+SiOPWDm9K8MH42kE39d5vdFNY3eewBcpCiwPoVlpNF
	/aqVISA05GUe8hqLT//AAQ0qgom1xd5hIVD2yis9Hj2L3BDTrTVwIA8jcCk7ikBmKYCnqkV4n5+er
	s/Hg7eOwZ56up6zNucQVFLGCfoVG9YQrvbySfCavZh89H/X/c15k3wRxBxnSvxUXHR0kIQiXN+TYo
	aGkzA/Bw==;
Received: from 2a02-8389-2341-5b80-3177-e4c1-2108-f294.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3177:e4c1:2108:f294] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBZap-0000000Eu1o-3ZAC;
	Mon, 27 May 2024 12:36:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/3] dm: make dm_set_zones_restrictions work on the queue limits
Date: Mon, 27 May 2024 14:36:20 +0200
Message-ID: <20240527123634.1116952-4-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527123634.1116952-1-hch@lst.de>
References: <20240527123634.1116952-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Don't stuff the values directly into the queue without any
synchronization, but instead delay applying the queue limits in
the caller and let dm_set_zones_restrictions work on the limit
structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-table.c | 12 ++++++------
 drivers/md/dm-zone.c  | 11 ++++++-----
 drivers/md/dm.h       |  3 ++-
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e291b78b307b13..b2d5246cff2102 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1981,10 +1981,6 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	if (!dm_table_supports_secure_erase(t))
 		limits->max_secure_erase_sectors = 0;
 
-	r = queue_limits_set(q, limits);
-	if (r)
-		return r;
-
 	if (dm_table_supports_flush(t, (1UL << QUEUE_FLAG_WC))) {
 		wc = true;
 		if (dm_table_supports_flush(t, (1UL << QUEUE_FLAG_FUA)))
@@ -2036,12 +2032,16 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	 * For a zoned target, setup the zones related queue attributes
 	 * and resources necessary for zone append emulation if necessary.
 	 */
-	if (blk_queue_is_zoned(q)) {
-		r = dm_set_zones_restrictions(t, q);
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && limits->zoned) {
+		r = dm_set_zones_restrictions(t, q, limits);
 		if (r)
 			return r;
 	}
 
+	r = queue_limits_set(q, limits);
+	if (r)
+		return r;
+
 	dm_update_crypto_profile(q, t);
 
 	/*
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 0ee22494857d07..5d66d916730efa 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -220,7 +220,8 @@ static bool dm_table_supports_zone_append(struct dm_table *t)
 	return true;
 }
 
-int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
+int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q,
+		struct queue_limits *lim)
 {
 	struct mapped_device *md = t->md;
 	struct gendisk *disk = md->disk;
@@ -236,7 +237,7 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
 		clear_bit(DMF_EMULATE_ZONE_APPEND, &md->flags);
 	} else {
 		set_bit(DMF_EMULATE_ZONE_APPEND, &md->flags);
-		blk_queue_max_zone_append_sectors(q, 0);
+		lim->max_zone_append_sectors = 0;
 	}
 
 	if (!get_capacity(md->disk))
@@ -260,9 +261,9 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
 	 * a regular device.
 	 */
 	if (nr_conv_zones >= ret) {
-		disk->queue->limits.max_open_zones = 0;
-		disk->queue->limits.max_active_zones = 0;
-		disk->queue->limits.zoned = false;
+		lim->max_open_zones = 0;
+		lim->max_active_zones = 0;
+		lim->zoned = false;
 		clear_bit(DMF_EMULATE_ZONE_APPEND, &md->flags);
 		disk->nr_zones = 0;
 		return 0;
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index e0c57f19839b29..53ef8207fe2c15 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -101,7 +101,8 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t);
 /*
  * Zoned targets related functions.
  */
-int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q);
+int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q,
+		struct queue_limits *lim);
 void dm_zone_endio(struct dm_io *io, struct bio *clone);
 #ifdef CONFIG_BLK_DEV_ZONED
 int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
-- 
2.43.0


