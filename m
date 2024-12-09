Return-Path: <linux-block+bounces-15074-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 164569E93D0
	for <lists+linux-block@lfdr.de>; Mon,  9 Dec 2024 13:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC3A28585B
	for <lists+linux-block@lfdr.de>; Mon,  9 Dec 2024 12:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ABE22371A;
	Mon,  9 Dec 2024 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+zXARql"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE8D221DB0;
	Mon,  9 Dec 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747068; cv=none; b=OakR8XvbmxJ4EJ8iIcXIurpcm3BlbW9/nKyHYocraXOWkunLxY6wfnFYJLTscx4j+qCH6fR86z6WGvNeyytUa6+G+DfwI6o8rYdjM85TPIEsIyPXFONjsa0FozYHwiBnnRONX0LeZ5D5iJ/R3kPDj7o3p52n8AVnPJkDfpSvLKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747068; c=relaxed/simple;
	bh=6LDVWu5G8bHyzCf4odHJ8J61mwAvGlf/2dHlhQ2DJLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWg6smUyurW/B1cNfaie9AFP5G02FrKLJsW63VTudJUehFLubieYvYpqi0ZO6ixlPsIVD7tTbv3oRj6CIncUOPdZ0qXA/JtIg2PPnzyik+PvEU8eG+SqSEj1MA/d768L2iKurf4B0Cge7333eWxXzdCEEb3DdR9iTuCgBs+F2E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+zXARql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8595C4CEDD;
	Mon,  9 Dec 2024 12:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733747065;
	bh=6LDVWu5G8bHyzCf4odHJ8J61mwAvGlf/2dHlhQ2DJLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+zXARqlCWVhAyOD3puip6Q4/SJaKt5ipPq0ANSaGxdiP3PnKTUqNVKlFOmz3ugBN
	 2cSD0pRmYSQRlQu3gzB6mCQGnyjOD+KerXH6E3gv1hxYZk5yJlHXuByBPmMJhx7rkm
	 8KC8hUeQLuRFPlZmZyNbnNkd0P/MQPs5JwQFUi/srotHfmnFIXr/Um9uQDY1q8C5r4
	 AwJVZ9lcX9PY4q/zKzjb+qk37pesrUAT/az/UyNUJFFrosDsKqN/djpDZN7pDlkmTD
	 JPF1QaJF6R+keBog6psc9SRq/S8cF8hksy0ugXtmIuPRZGfstder2ronIGnNKkSVMA
	 dAO3J32hbfpmg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev
Cc: Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 1/4] block: Use a zone write plug BIO work for REQ_NOWAIT BIOs
Date: Mon,  9 Dec 2024 21:23:54 +0900
Message-ID: <20241209122357.47838-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209122357.47838-1-dlemoal@kernel.org>
References: <20241209122357.47838-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For zoned block devices, a write BIO issued to a zone that has no
on-going writes will be prepared for execution and allowed to execute
immediately by blk_zone_wplug_handle_write() (called from
blk_zone_plug_bio()). However, if this BIO specifies REQ_NOWAIT, the
allocation of a request for its execution in blk_mq_submit_bio() may
fail after blk_zone_plug_bio() completed, marking the target zone of the
BIO as plugged. When this BIO is retried later on, it will be blocked as
the zone write plug of the target zone is in a plugged state without any
on-going write operation (completion of write operations trigger
unplugging of the next write BIOs for a zone). This leads to a BIO that
is stuck in a zone write plug and never completes, which results in
various issues such as hung tasks.

Avoid this problem by always executing REQ_NOWAIT write BIOs using the
BIO work of a zone write plug. This ensure that we never block the BIO
issuer and can thus safely ignore the REQ_NOWAIT flag when executing the
BIO from the zone write plug BIO work.

Since such BIO may be the first write BIO issued to a zone with no
on-going write, modify disk_zone_wplug_add_bio() to schedule the zone
write plug BIO work if the write plug is not already marked with the
BLK_ZONE_WPLUG_PLUGGED flag. This scheduling is otherwise not necessary
as the completion of the on-going write for the zone will schedule the
execution of the next plugged BIOs.

blk_zone_wplug_handle_write() is also fixed to better handle zone write
plug allocation failures for REQ_NOWAIT BIOs by failing a write BIO
using bio_wouldblock_error() instead of bio_io_error().

Reported-by: Bart Van Assche <bvanassche@acm.org>
Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 62 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 263e28b72053..7982b9494d63 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -746,9 +746,25 @@ static bool blk_zone_wplug_handle_reset_all(struct bio *bio)
 	return false;
 }
 
-static inline void blk_zone_wplug_add_bio(struct blk_zone_wplug *zwplug,
-					  struct bio *bio, unsigned int nr_segs)
+static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
+					      struct blk_zone_wplug *zwplug)
+{
+	/*
+	 * Take a reference on the zone write plug and schedule the submission
+	 * of the next plugged BIO. blk_zone_wplug_bio_work() will release the
+	 * reference we take here.
+	 */
+	WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED));
+	refcount_inc(&zwplug->ref);
+	queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
+}
+
+static inline void disk_zone_wplug_add_bio(struct gendisk *disk,
+				struct blk_zone_wplug *zwplug,
+				struct bio *bio, unsigned int nr_segs)
 {
+	bool schedule_bio_work = false;
+
 	/*
 	 * Grab an extra reference on the BIO request queue usage counter.
 	 * This reference will be reused to submit a request for the BIO for
@@ -764,6 +780,16 @@ static inline void blk_zone_wplug_add_bio(struct blk_zone_wplug *zwplug,
 	 */
 	bio_clear_polled(bio);
 
+	/*
+	 * REQ_NOWAIT BIOs are always handled using the zone write plug BIO
+	 * work, which can block. So clear the REQ_NOWAIT flag and schedule the
+	 * work if this is the first BIO we are plugging.
+	 */
+	if (bio->bi_opf & REQ_NOWAIT) {
+		schedule_bio_work = !(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED);
+		bio->bi_opf &= ~REQ_NOWAIT;
+	}
+
 	/*
 	 * Reuse the poll cookie field to store the number of segments when
 	 * split to the hardware limits.
@@ -777,6 +803,11 @@ static inline void blk_zone_wplug_add_bio(struct blk_zone_wplug *zwplug,
 	 * at the tail of the list to preserve the sequential write order.
 	 */
 	bio_list_add(&zwplug->bio_list, bio);
+
+	zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
+
+	if (schedule_bio_work)
+		disk_zone_wplug_schedule_bio_work(disk, zwplug);
 }
 
 /*
@@ -970,7 +1001,10 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 
 	zwplug = disk_get_and_lock_zone_wplug(disk, sector, gfp_mask, &flags);
 	if (!zwplug) {
-		bio_io_error(bio);
+		if (bio->bi_opf & REQ_NOWAIT)
+			bio_wouldblock_error(bio);
+		else
+			bio_io_error(bio);
 		return true;
 	}
 
@@ -979,9 +1013,11 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 
 	/*
 	 * If the zone is already plugged or has a pending error, add the BIO
-	 * to the plug BIO list. Otherwise, plug and let the BIO execute.
+	 * to the plug BIO list. Do the same for REQ_NOWAIT BIOs to ensure that
+	 * we will not see a BLK_STS_AGAIN failure if we let the BIO execute.
+	 * Otherwise, plug and let the BIO execute.
 	 */
-	if (zwplug->flags & BLK_ZONE_WPLUG_BUSY)
+	if (zwplug->flags & BLK_ZONE_WPLUG_BUSY || (bio->bi_opf & REQ_NOWAIT))
 		goto plug;
 
 	/*
@@ -998,8 +1034,7 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 	return false;
 
 plug:
-	zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
-	blk_zone_wplug_add_bio(zwplug, bio, nr_segs);
+	disk_zone_wplug_add_bio(disk, zwplug, bio, nr_segs);
 
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
@@ -1083,19 +1118,6 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
 }
 EXPORT_SYMBOL_GPL(blk_zone_plug_bio);
 
-static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
-					      struct blk_zone_wplug *zwplug)
-{
-	/*
-	 * Take a reference on the zone write plug and schedule the submission
-	 * of the next plugged BIO. blk_zone_wplug_bio_work() will release the
-	 * reference we take here.
-	 */
-	WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED));
-	refcount_inc(&zwplug->ref);
-	queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
-}
-
 static void disk_zone_wplug_unplug_bio(struct gendisk *disk,
 				       struct blk_zone_wplug *zwplug)
 {
-- 
2.47.1


