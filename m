Return-Path: <linux-block+bounces-3180-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E00852A08
	for <lists+linux-block@lfdr.de>; Tue, 13 Feb 2024 08:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216EFB22379
	for <lists+linux-block@lfdr.de>; Tue, 13 Feb 2024 07:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D56217755;
	Tue, 13 Feb 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UuBqtdX1"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244D1774C;
	Tue, 13 Feb 2024 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809704; cv=none; b=pSRggBJ+IQMgALI8+jFT60Vm0PyuySIK2uchZ75AuTYLMhCd9bZS45SeBIc2/Jvj5pNca3aqZu3TYQAoLris+EBU7hnNBHzKLDeWxbXWNTwg7s36/gS5rf9ieAJWeNeNSU8dSnckqbqB/N7ghMMdcg/DzRZChgfoiE2pY8+pL9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809704; c=relaxed/simple;
	bh=fBGpZmSdBtnVkYeg/xuFXS8DVGJHqFctIwKzVQ8hJR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=swxJ0Eud+KmV1/KZOgtC4Tm3yIsyTgXsDUZ5WQ7YrCM4tDPIQ/wCdwFkD/kNCWuj6dZLvVUfkfbK1dXJiZFbM++AyyjQODL2d90SKyBqsyiR2pB+v4HAokQqY7AoMDSbuIzMbuFbskKHccxHygg+D3Ozf2YXHXhKK0HNyMudxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UuBqtdX1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=y6nuw8knGm5/TKMd/xbgnifFuGhXgHcfQF1BheB0sEk=; b=UuBqtdX1Tq96Ov7BIgA5S4b4lD
	ueWTrRwQP/ClDZtwQqnCmxuX91oxZT4FYabBf2T4GcOWisi+4Ns4allRfk8peK798WkbT7zit5dxq
	hkvMhBuoKSdV1HTRuxLXJe09hqagK0YnglJFRJoMNjfWVO8QXPFhAMJH66rncyOhkxD3sbPtPtojs
	Ll2Z6TynRcQgdgiYuUcqld8gRftT9PvhRZ97LvLWUjirk4QjfN7UhzhYdFJpKzNQGSlcBSi0xPegd
	Uh9rJa00ycRiwf2wo01mbczA2samd4sKhYu23+5JEVMEIUB4NlXT8r6rJWGTNJ0F55R+XljnhhjvZ
	60+iLAWQ==;
Received: from [2001:4bb8:190:6eab:b680:8f97:4b38:866d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZnJi-00000008GDq-1XQ2;
	Tue, 13 Feb 2024 07:34:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: [PATCH 04/15] block: add an API to atomically update queue limits
Date: Tue, 13 Feb 2024 08:34:14 +0100
Message-Id: <20240213073425.1621680-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213073425.1621680-1-hch@lst.de>
References: <20240213073425.1621680-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a new queue_limits_{start,commit}_update pair of functions that
allows taking an atomic snapshot of queue limits, update it, and
commit it if it passes validity checking.  Also use the low-level
validation helper to implement blk_set_default_limits instead of
duplicating the initialization.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-core.c       |   1 +
 block/blk-settings.c   | 228 ++++++++++++++++++++++++++++++++++-------
 block/blk.h            |   2 +-
 include/linux/blkdev.h |  23 +++++
 4 files changed, 217 insertions(+), 37 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2b11d8325fde68..cb56724a8dfb25 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -425,6 +425,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 	mutex_init(&q->debugfs_mutex);
 	mutex_init(&q->sysfs_lock);
 	mutex_init(&q->sysfs_dir_lock);
+	mutex_init(&q->limits_lock);
 	mutex_init(&q->rq_qos_mutex);
 	spin_lock_init(&q->queue_lock);
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 24042f6b33d54e..786b369ca59995 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -25,42 +25,6 @@ void blk_queue_rq_timeout(struct request_queue *q, unsigned int timeout)
 }
 EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
 
-/**
- * blk_set_default_limits - reset limits to default values
- * @lim:  the queue_limits structure to reset
- *
- * Description:
- *   Returns a queue_limit struct to its default state.
- */
-void blk_set_default_limits(struct queue_limits *lim)
-{
-	lim->max_segments = BLK_MAX_SEGMENTS;
-	lim->max_discard_segments = 1;
-	lim->max_integrity_segments = 0;
-	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
-	lim->virt_boundary_mask = 0;
-	lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
-	lim->max_sectors = lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
-	lim->max_user_sectors = lim->max_dev_sectors = 0;
-	lim->chunk_sectors = 0;
-	lim->max_write_zeroes_sectors = 0;
-	lim->max_zone_append_sectors = 0;
-	lim->max_discard_sectors = 0;
-	lim->max_hw_discard_sectors = 0;
-	lim->max_secure_erase_sectors = 0;
-	lim->discard_granularity = 512;
-	lim->discard_alignment = 0;
-	lim->discard_misaligned = 0;
-	lim->logical_block_size = lim->physical_block_size = lim->io_min = 512;
-	lim->bounce = BLK_BOUNCE_NONE;
-	lim->alignment_offset = 0;
-	lim->io_opt = 0;
-	lim->misaligned = 0;
-	lim->zoned = false;
-	lim->zone_write_granularity = 0;
-	lim->dma_alignment = 511;
-}
-
 /**
  * blk_set_stacking_limits - set default limits for stacking devices
  * @lim:  the queue_limits structure to reset
@@ -101,6 +65,198 @@ static void blk_apply_bdi_limits(struct backing_dev_info *bdi,
 	bdi->io_pages = lim->max_sectors >> PAGE_SECTORS_SHIFT;
 }
 
+static int blk_validate_zoned_limits(struct queue_limits *lim)
+{
+	if (!lim->zoned) {
+		if (WARN_ON_ONCE(lim->max_open_zones) ||
+		    WARN_ON_ONCE(lim->max_active_zones) ||
+		    WARN_ON_ONCE(lim->zone_write_granularity) ||
+		    WARN_ON_ONCE(lim->max_zone_append_sectors))
+			return -EINVAL;
+		return 0;
+	}
+
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_BLK_DEV_ZONED)))
+		return -EINVAL;
+
+	if (lim->zone_write_granularity < lim->logical_block_size)
+		lim->zone_write_granularity = lim->logical_block_size;
+
+	if (lim->max_zone_append_sectors) {
+		/*
+		 * The Zone Append size is limited by the maximum I/O size
+		 * and the zone size given that it can't span zones.
+		 */
+		lim->max_zone_append_sectors =
+			min3(lim->max_hw_sectors,
+			     lim->max_zone_append_sectors,
+			     lim->chunk_sectors);
+	}
+
+	return 0;
+}
+
+/*
+ * Check that the limits in lim are valid, initialize defaults for unset
+ * values, and cap values based on others where needed.
+ */
+static int blk_validate_limits(struct queue_limits *lim)
+{
+	unsigned int max_hw_sectors;
+
+	/*
+	 * Unless otherwise specified, default to 512 byte logical blocks and a
+	 * physical block size equal to the logical block size.
+	 */
+	if (!lim->logical_block_size)
+		lim->logical_block_size = SECTOR_SIZE;
+	if (lim->physical_block_size < lim->logical_block_size)
+		lim->physical_block_size = lim->logical_block_size;
+
+	/*
+	 * The minimum I/O size defaults to the physical block size unless
+	 * explicitly overridden.
+	 */
+	if (lim->io_min < lim->physical_block_size)
+		lim->io_min = lim->physical_block_size;
+
+	/*
+	 * max_hw_sectors has a somewhat weird default for historical reason,
+	 * but driver really should set their own instead of relying on this
+	 * value.
+	 *
+	 * The block layer relies on the fact that every driver can
+	 * handle at lest a page worth of data per I/O, and needs the value
+	 * aligned to the logical block size.
+	 */
+	if (!lim->max_hw_sectors)
+		lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
+	if (WARN_ON_ONCE(lim->max_hw_sectors < PAGE_SECTORS))
+		return -EINVAL;
+	lim->max_hw_sectors = round_down(lim->max_hw_sectors,
+			lim->logical_block_size >> SECTOR_SHIFT);
+
+	/*
+	 * The actual max_sectors value is a complex beast and also takes the
+	 * max_dev_sectors value (set by SCSI ULPs) and a user configurable
+	 * value into account.  The ->max_sectors value is always calculated
+	 * from these, so directly setting it won't have any effect.
+	 */
+	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
+				lim->max_dev_sectors);
+	if (lim->max_user_sectors) {
+		if (lim->max_user_sectors > max_hw_sectors ||
+		    lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
+			return -EINVAL;
+		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
+	} else {
+		lim->max_sectors = min(max_hw_sectors, BLK_DEF_MAX_SECTORS_CAP);
+	}
+	lim->max_sectors = round_down(lim->max_sectors,
+			lim->logical_block_size >> SECTOR_SHIFT);
+
+	/*
+	 * Random default for the maximum number of segments.  Driver should not
+	 * rely on this and set their own.
+	 */
+	if (!lim->max_segments)
+		lim->max_segments = BLK_MAX_SEGMENTS;
+
+	lim->max_discard_sectors = lim->max_hw_discard_sectors;
+	if (!lim->max_discard_segments)
+		lim->max_discard_segments = 1;
+
+	if (lim->discard_granularity < lim->physical_block_size)
+		lim->discard_granularity = lim->physical_block_size;
+
+	/*
+	 * By default there is no limit on the segment boundary alignment,
+	 * but if there is one it can't be smaller than the page size as
+	 * that would break all the normal I/O patterns.
+	 */
+	if (!lim->seg_boundary_mask)
+		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
+	if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
+		return -EINVAL;
+
+	/*
+	 * The maximum segment size has an odd historic 64k default that
+	 * drivers probably should override.  Just like the I/O size we
+	 * require drivers to at least handle a full page per segment.
+	 */
+	if (!lim->max_segment_size)
+		lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
+	if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
+		return -EINVAL;
+
+	/*
+	 * Devices that require a virtual boundary do not support scatter/gather
+	 * I/O natively, but instead require a descriptor list entry for each
+	 * page (which might not be identical to the Linux PAGE_SIZE).  Because
+	 * of that they are not limited by our notion of "segment size".
+	 */
+	if (lim->virt_boundary_mask) {
+		if (WARN_ON_ONCE(lim->max_segment_size &&
+				 lim->max_segment_size != UINT_MAX))
+			return -EINVAL;
+		lim->max_segment_size = UINT_MAX;
+	}
+
+	/*
+	 * We require drivers to at least do logical block aligned I/O, but
+	 * historically could not check for that due to the separate calls
+	 * to set the limits.  Once the transition is finished the check
+	 * below should be narrowed down to check the logical block size.
+	 */
+	if (!lim->dma_alignment)
+		lim->dma_alignment = SECTOR_SIZE - 1;
+	if (WARN_ON_ONCE(lim->dma_alignment > PAGE_SIZE))
+		return -EINVAL;
+
+	if (lim->alignment_offset) {
+		lim->alignment_offset &= (lim->physical_block_size - 1);
+		lim->misaligned = 0;
+	}
+
+	return blk_validate_zoned_limits(lim);
+}
+
+/*
+ * Set the default limits for a newly allocated queue.  @lim contains the
+ * initial limits set by the driver, which could be no limit in which case
+ * all fields are cleared to zero.
+ */
+int blk_set_default_limits(struct queue_limits *lim)
+{
+	return blk_validate_limits(lim);
+}
+
+/**
+ * queue_limits_commit_update - commit an atomic update of queue limits
+ * @q:		queue to update
+ * @lim:	limits to apply
+ *
+ * Apply the limits in @lim that were obtained from queue_limits_start_update()
+ * and updated by the caller to @q.
+ *
+ * Returns 0 if successful, else a negative error code.
+ */
+int queue_limits_commit_update(struct request_queue *q,
+		struct queue_limits *lim)
+	__releases(q->limits_lock)
+{
+	int error = blk_validate_limits(lim);
+
+	if (!error) {
+		q->limits = *lim;
+		if (q->disk)
+			blk_apply_bdi_limits(q->disk->bdi, lim);
+	}
+	mutex_unlock(&q->limits_lock);
+	return error;
+}
+EXPORT_SYMBOL_GPL(queue_limits_commit_update);
+
 /**
  * blk_queue_bounce_limit - set bounce buffer limit for queue
  * @q: the request queue for the device
diff --git a/block/blk.h b/block/blk.h
index 913c93838a01bf..43c7e9180b3028 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -330,7 +330,7 @@ void blk_rq_set_mixed_merge(struct request *rq);
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio);
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio);
 
-void blk_set_default_limits(struct queue_limits *lim);
+int blk_set_default_limits(struct queue_limits *lim);
 int blk_dev_init(void);
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 251a11d2d2aeff..d41d7fe934578f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -474,6 +474,7 @@ struct request_queue {
 
 	struct mutex		sysfs_lock;
 	struct mutex		sysfs_dir_lock;
+	struct mutex		limits_lock;
 
 	/*
 	 * for reusing dead hctx instance in case of updating
@@ -862,6 +863,28 @@ static inline unsigned int blk_chunk_sectors_left(sector_t offset,
 	return chunk_sectors - (offset & (chunk_sectors - 1));
 }
 
+/**
+ * queue_limits_start_update - start an atomic update of queue limits
+ * @q:		queue to update
+ *
+ * This functions starts an atomic update of the queue limits.  It takes a lock
+ * to prevent other updates and returns a snapshot of the current limits that
+ * the caller can modify.  The caller must call queue_limits_commit_update()
+ * to finish the update.
+ *
+ * Context: process context.  The caller must have frozen the queue or ensured
+ * that there is outstanding I/O by other means.
+ */
+static inline struct queue_limits
+queue_limits_start_update(struct request_queue *q)
+	__acquires(q->limits_lock)
+{
+	mutex_lock(&q->limits_lock);
+	return q->limits;
+}
+int queue_limits_commit_update(struct request_queue *q,
+		struct queue_limits *lim);
+
 /*
  * Access functions for manipulating queue properties
  */
-- 
2.39.2


