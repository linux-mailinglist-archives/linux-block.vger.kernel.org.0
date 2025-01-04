Return-Path: <linux-block+bounces-15844-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5277AA0133E
	for <lists+linux-block@lfdr.de>; Sat,  4 Jan 2025 09:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C78A3A42F6
	for <lists+linux-block@lfdr.de>; Sat,  4 Jan 2025 08:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F77D14B08C;
	Sat,  4 Jan 2025 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OplsEO6y"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2F81411EB
	for <linux-block@vger.kernel.org>; Sat,  4 Jan 2025 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735978623; cv=none; b=LGrrXbZjkZviRLCosVVgqjzLccPJgHZO19Y+UrD7RkdvMPDs8+l1FHbnuySfECVdCSLFuaT7Nkhh9FqQGgG5jTPvr5kWjmaMysDMLehMQYkolHKACvk0OqPyqpdU8s00kLk6IkG2NNKfV9B7npZdb8vUNm1p2CNtoEzEKxEWeLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735978623; c=relaxed/simple;
	bh=E2AvZuaVVt3QyD9lOW0ANW+D6nr9wEq3tnQpouzbBVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EWBkLQ/4LaQgP3yVlZliysc809LLzC1jA+kxnFr8edqAvswiVF84QoVemCqOIVOprCIWAF/F/CAf7nPX2eLzIOWaCkt+lPut28rqTfEsDWdPKiyLA9bArrUbMMXCMKhgpMczlm3oO5SkYnkynyeTVN1oEWG//g4DPhQ6IMxj5Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OplsEO6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEE8C4CED1;
	Sat,  4 Jan 2025 08:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735978622;
	bh=E2AvZuaVVt3QyD9lOW0ANW+D6nr9wEq3tnQpouzbBVc=;
	h=From:To:Cc:Subject:Date:From;
	b=OplsEO6yfmxuJyBt54f7MdzY8tcYe7zmaBFkLsM9np6AkK8dyrxxqtKGsLJLuwizz
	 lnGA27mUWTI7MEfNhjowWdoJ3oufe7Rjfq4R29TIeDqeMQCHYOLBgXHXGvhTxGa4bB
	 5S6oijmczN3oXEABWa7QK1gc9iTMQPY4TmF57wSiP0p47oLhbi7YypmaUovW97EUjB
	 /mz49TCrNYt8q65w37A1pxHmGYxySx9TJDZsaoSU3KeLHi5sq7E2ZxEHL5FAXVIDyT
	 Yv9cVt2vjMZLlD3qqLveFsASzA/0Cpb/rCyxQubkULdmzE0mdS/e1e+Au12W4zW1Sx
	 vChNmUBhWMxfw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: Fix sysfs queue freeze and limits lock order
Date: Sat,  4 Jan 2025 17:16:26 +0900
Message-ID: <20250104081626.238871-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

queue_attr_store() always freezes a device queue before calling the
attribute store operation. For attributes that control queue limits, the
store operation will also lock the queue limits with a call to
queue_limits_start_update(). However, some drivers (e.g. SCSI sd) may
need to issue commands to a device to obtain limit values from the
hardware with the queue limits locked. This creates a potential ABBA
deadlock situation if a user attempts to modify a limit (thus freezing
the device queue) while the device driver starts a revalidation of the
device queue limits.

Avoid such deadlock by introducing the ->store_limit() operation in
struct queue_sysfs_entry and use this operation for all attributes that
modify the device queue limits through the QUEUE_RW_LIMIT_ENTRY() macro
definition. queue_attr_store() is modified to call the ->store_limit()
operation (if it is defined) without the device queue frozen. The device
queue freeze for attributes defining the ->stor_limit() operation is
moved to after the operation completes and is done only around the call
to queue_limits_commit_update().

Cc: stable@vger.kernel.org # v6.9+
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-sysfs.c | 123 ++++++++++++++++++++++++----------------------
 1 file changed, 64 insertions(+), 59 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 767598e719ab..4fc0020c73a5 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -24,6 +24,8 @@ struct queue_sysfs_entry {
 	struct attribute attr;
 	ssize_t (*show)(struct gendisk *disk, char *page);
 	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
+	ssize_t (*store_limit)(struct gendisk *disk, struct queue_limits *lim,
+			       const char *page, size_t count);
 	void (*load_module)(struct gendisk *disk, const char *page, size_t count);
 };
 
@@ -154,55 +156,46 @@ QUEUE_SYSFS_SHOW_CONST(write_same_max, 0)
 QUEUE_SYSFS_SHOW_CONST(poll_delay, -1)
 
 static ssize_t queue_max_discard_sectors_store(struct gendisk *disk,
-		const char *page, size_t count)
+		struct queue_limits *lim, const char *page, size_t count)
 {
 	unsigned long max_discard_bytes;
-	struct queue_limits lim;
 	ssize_t ret;
-	int err;
 
 	ret = queue_var_store(&max_discard_bytes, page, count);
 	if (ret < 0)
 		return ret;
 
-	if (max_discard_bytes & (disk->queue->limits.discard_granularity - 1))
+	if (max_discard_bytes & (lim->discard_granularity - 1))
 		return -EINVAL;
 
 	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
 		return -EINVAL;
 
-	lim = queue_limits_start_update(disk->queue);
-	lim.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
-	err = queue_limits_commit_update(disk->queue, &lim);
-	if (err)
-		return err;
-	return ret;
+	lim->max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
+
+	return count;
 }
 
 static ssize_t
-queue_max_sectors_store(struct gendisk *disk, const char *page, size_t count)
+queue_max_sectors_store(struct gendisk *disk, struct queue_limits *lim,
+			const char *page, size_t count)
 {
 	unsigned long max_sectors_kb;
-	struct queue_limits lim;
 	ssize_t ret;
-	int err;
 
 	ret = queue_var_store(&max_sectors_kb, page, count);
 	if (ret < 0)
 		return ret;
 
-	lim = queue_limits_start_update(disk->queue);
-	lim.max_user_sectors = max_sectors_kb << 1;
-	err = queue_limits_commit_update(disk->queue, &lim);
-	if (err)
-		return err;
-	return ret;
+	lim->max_user_sectors = max_sectors_kb << 1;
+
+	return count;
 }
 
-static ssize_t queue_feature_store(struct gendisk *disk, const char *page,
+static ssize_t queue_feature_store(struct gendisk *disk,
+		struct queue_limits *lim, const char *page,
 		size_t count, blk_features_t feature)
 {
-	struct queue_limits lim;
 	unsigned long val;
 	ssize_t ret;
 
@@ -210,14 +203,10 @@ static ssize_t queue_feature_store(struct gendisk *disk, const char *page,
 	if (ret < 0)
 		return ret;
 
-	lim = queue_limits_start_update(disk->queue);
 	if (val)
-		lim.features |= feature;
+		lim->features |= feature;
 	else
-		lim.features &= ~feature;
-	ret = queue_limits_commit_update(disk->queue, &lim);
-	if (ret)
-		return ret;
+		lim->features &= ~feature;
 	return count;
 }
 
@@ -228,9 +217,10 @@ static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)	\
 		!!(disk->queue->limits.features & _feature));		\
 }									\
 static ssize_t queue_##_name##_store(struct gendisk *disk,		\
+		struct queue_limits *lim,				\
 		const char *page, size_t count)				\
 {									\
-	return queue_feature_store(disk, page, count, _feature);	\
+	return queue_feature_store(disk, lim, page, count, _feature);	\
 }
 
 QUEUE_SYSFS_FEATURE(rotational, BLK_FEAT_ROTATIONAL)
@@ -267,9 +257,8 @@ static ssize_t queue_iostats_passthrough_show(struct gendisk *disk, char *page)
 }
 
 static ssize_t queue_iostats_passthrough_store(struct gendisk *disk,
-					       const char *page, size_t count)
+		struct queue_limits *lim, const char *page, size_t count)
 {
-	struct queue_limits lim;
 	unsigned long ios;
 	ssize_t ret;
 
@@ -277,15 +266,10 @@ static ssize_t queue_iostats_passthrough_store(struct gendisk *disk,
 	if (ret < 0)
 		return ret;
 
-	lim = queue_limits_start_update(disk->queue);
 	if (ios)
-		lim.flags |= BLK_FLAG_IOSTATS_PASSTHROUGH;
+		lim->flags |= BLK_FLAG_IOSTATS_PASSTHROUGH;
 	else
-		lim.flags &= ~BLK_FLAG_IOSTATS_PASSTHROUGH;
-
-	ret = queue_limits_commit_update(disk->queue, &lim);
-	if (ret)
-		return ret;
+		lim->flags &= ~BLK_FLAG_IOSTATS_PASSTHROUGH;
 
 	return count;
 }
@@ -391,12 +375,10 @@ static ssize_t queue_wc_show(struct gendisk *disk, char *page)
 	return sysfs_emit(page, "write through\n");
 }
 
-static ssize_t queue_wc_store(struct gendisk *disk, const char *page,
-			      size_t count)
+static ssize_t queue_wc_store(struct gendisk *disk, struct queue_limits *lim,
+			      const char *page, size_t count)
 {
-	struct queue_limits lim;
 	bool disable;
-	int err;
 
 	if (!strncmp(page, "write back", 10)) {
 		disable = false;
@@ -407,14 +389,10 @@ static ssize_t queue_wc_store(struct gendisk *disk, const char *page,
 		return -EINVAL;
 	}
 
-	lim = queue_limits_start_update(disk->queue);
 	if (disable)
-		lim.flags |= BLK_FLAG_WRITE_CACHE_DISABLED;
+		lim->flags |= BLK_FLAG_WRITE_CACHE_DISABLED;
 	else
-		lim.flags &= ~BLK_FLAG_WRITE_CACHE_DISABLED;
-	err = queue_limits_commit_update(disk->queue, &lim);
-	if (err)
-		return err;
+		lim->flags &= ~BLK_FLAG_WRITE_CACHE_DISABLED;
 	return count;
 }
 
@@ -439,9 +417,16 @@ static struct queue_sysfs_entry _prefix##_entry = {		\
 	.store		= _prefix##_store,			\
 }
 
+#define QUEUE_RW_LIMIT_ENTRY(_prefix, _name)				\
+static struct queue_sysfs_entry _prefix##_entry = {		\
+	.attr		= { .name = _name, .mode = 0644 },	\
+	.show		= _prefix##_show,			\
+	.store_limit	= _prefix##_store,			\
+}
+
 QUEUE_RW_ENTRY(queue_requests, "nr_requests");
 QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
-QUEUE_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
+QUEUE_RW_LIMIT_ENTRY(queue_max_sectors, "max_sectors_kb");
 QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
 QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
@@ -457,7 +442,7 @@ QUEUE_RO_ENTRY(queue_io_opt, "optimal_io_size");
 QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
 QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
 QUEUE_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes");
-QUEUE_RW_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
+QUEUE_RW_LIMIT_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
 QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 
 QUEUE_RO_ENTRY(queue_atomic_write_max_sectors, "atomic_write_max_bytes");
@@ -477,11 +462,11 @@ QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
-QUEUE_RW_ENTRY(queue_iostats_passthrough, "iostats_passthrough");
+QUEUE_RW_LIMIT_ENTRY(queue_iostats_passthrough, "iostats_passthrough");
 QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY(queue_poll, "io_poll");
 QUEUE_RW_ENTRY(queue_poll_delay, "io_poll_delay");
-QUEUE_RW_ENTRY(queue_wc, "write_cache");
+QUEUE_RW_LIMIT_ENTRY(queue_wc, "write_cache");
 QUEUE_RO_ENTRY(queue_fua, "fua");
 QUEUE_RO_ENTRY(queue_dax, "dax");
 QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
@@ -494,10 +479,10 @@ static struct queue_sysfs_entry queue_hw_sector_size_entry = {
 	.show = queue_logical_block_size_show,
 };
 
-QUEUE_RW_ENTRY(queue_rotational, "rotational");
-QUEUE_RW_ENTRY(queue_iostats, "iostats");
-QUEUE_RW_ENTRY(queue_add_random, "add_random");
-QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
+QUEUE_RW_LIMIT_ENTRY(queue_rotational, "rotational");
+QUEUE_RW_LIMIT_ENTRY(queue_iostats, "iostats");
+QUEUE_RW_LIMIT_ENTRY(queue_add_random, "add_random");
+QUEUE_RW_LIMIT_ENTRY(queue_stable_writes, "stable_writes");
 
 #ifdef CONFIG_BLK_WBT
 static ssize_t queue_var_store64(s64 *var, const char *page)
@@ -693,9 +678,11 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	struct queue_sysfs_entry *entry = to_queue(attr);
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
 	struct request_queue *q = disk->queue;
+	struct queue_limits lim = { };
 	ssize_t res;
+	int ret;
 
-	if (!entry->store)
+	if (!entry->store && !entry->store_limit)
 		return -EIO;
 
 	/*
@@ -706,12 +693,30 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	if (entry->load_module)
 		entry->load_module(disk, page, length);
 
-	blk_mq_freeze_queue(q);
+	if (entry->store) {
+		blk_mq_freeze_queue(q);
+		mutex_lock(&q->sysfs_lock);
+		res = entry->store(disk, page, length);
+		mutex_unlock(&q->sysfs_lock);
+		blk_mq_unfreeze_queue(q);
+		return res;
+	}
+
+	lim = queue_limits_start_update(q);
+
 	mutex_lock(&q->sysfs_lock);
-	res = entry->store(disk, page, length);
+	res = entry->store_limit(disk, &lim, page, length);
 	mutex_unlock(&q->sysfs_lock);
+	if (res < 0) {
+		queue_limits_cancel_update(q);
+		return res;
+	}
+
+	blk_mq_freeze_queue(q);
+	ret = queue_limits_commit_update(disk->queue, &lim);
 	blk_mq_unfreeze_queue(q);
-	return res;
+
+	return ret ? ret : res;
 }
 
 static const struct sysfs_ops queue_sysfs_ops = {
-- 
2.47.1


