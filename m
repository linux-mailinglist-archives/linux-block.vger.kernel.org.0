Return-Path: <linux-block+bounces-16759-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6CAA23D7D
	for <lists+linux-block@lfdr.de>; Fri, 31 Jan 2025 13:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996E93A86B3
	for <lists+linux-block@lfdr.de>; Fri, 31 Jan 2025 12:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF6F1C3F36;
	Fri, 31 Jan 2025 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z7Axm3SA"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF071C3C00;
	Fri, 31 Jan 2025 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738325040; cv=none; b=Qohhr5XPx1e2XuT+owV+jzG2gYrcDScVjRvTxS0JjjfD81G8EA7DmDORZcz9ddMswvjhCvBb6EI/8E8/UPa9wW7ogY8BbuRBdIsm8tq2Pun4r5bIwdQ5b1SXWiv56ZTWKKxVngccvZ74ZgsB98YHpEu1pRu5+wRFYJrCCWGuw1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738325040; c=relaxed/simple;
	bh=FwTqFovzk1I5ZWQPAHgLbWNYJ5VVj9lF/NMG2M8AOeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uflbo70HMWDTEmdcGbJGlnp/Wm1/tE0wlVSjfbPhZgi/oznU/A1Y4FM/ugcFFcN5aNiqv7UghaQmqW56dz3rjjTpja6ssJzlvJ5KRclXpXSwYBlryqOLVlfjAGyszUjtcXT2lDeTAtKDRlsFQwD40Itpbdlm6LEkQdXVrvVLHoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z7Axm3SA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=r3br8sfXoHUIvPKR1XKFtAKlXXfbcuESRzsq3IMZyYk=; b=z7Axm3SA7nl65v6AcMmEtfDG4F
	/IXFwKT9k5r7zF5jRICABBDK/AL9YRogepARN1cBkd/nffnPvpAE8sEnvN8WY0BrQJaIoJmJR28H2
	PaBHs6rk37Jb1oO4VhRV/4yxXiKo3MFbrSQag1wKRMEK7qUHu+aRLnGMahqoeERZ3pZMdS0GSKWid
	sFMKYqx+74M+ETOQVoGqV4rGDXOv2XkFcjLRP/Ujt+0YVf4dDw6u6B9y8W3nJe+dEn1drQSHmMhff
	0JR59BGWba/hnjT7FxANr+s+/rGQ4RGSk6PjRRdrzZ9rb/DlGWWGAtC7KMPeKO2diYTiAAxyAcAKV
	XkxJUtbw==;
Received: from 2a02-8389-2341-5b80-85a0-dd45-e939-a129.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:85a0:dd45:e939:a129] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tdpkb-0000000AZM2-1wDb;
	Fri, 31 Jan 2025 12:03:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH] block: force noio scope in blk_mq_freeze_queue
Date: Fri, 31 Jan 2025 13:03:47 +0100
Message-ID: <20250131120352.1315351-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250131120352.1315351-1-hch@lst.de>
References: <20250131120352.1315351-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

When block drivers or the core block code perform allocations with a
frozen queue, this could try to recurse into the block device to
reclaim memory and deadlock.  Thus all allocations done by a process
that froze a queue need to be done without __GFP_IO and __GFP_FS.
Instead of tying to track all of them down, force a noio scope as
part of freezing the queue.

Note that nvme is a bit of a mess here due to the non-owner freezes,
and they will be addressed separately.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c            | 10 ++++++----
 block/blk-iocost.c            | 14 ++++++++------
 block/blk-iolatency.c         |  6 ++++--
 block/blk-mq.c                | 21 +++++++++++++--------
 block/blk-pm.c                |  2 +-
 block/blk-rq-qos.c            | 12 +++++++-----
 block/blk-settings.c          |  5 +++--
 block/blk-sysfs.c             |  8 +++-----
 block/blk-throttle.c          |  5 +++--
 block/blk-zoned.c             |  5 +++--
 block/elevator.c              | 16 ++++++++++------
 drivers/block/aoe/aoedev.c    |  5 +++--
 drivers/block/ataflop.c       |  5 +++--
 drivers/block/loop.c          | 20 ++++++++++++--------
 drivers/block/nbd.c           |  7 ++++---
 drivers/block/rbd.c           |  5 +++--
 drivers/block/sunvdc.c        |  5 +++--
 drivers/block/swim3.c         |  5 +++--
 drivers/block/virtio_blk.c    |  5 +++--
 drivers/mtd/mtd_blkdevs.c     |  5 +++--
 drivers/nvme/host/core.c      | 17 ++++++++++-------
 drivers/nvme/host/multipath.c |  2 +-
 drivers/scsi/scsi_lib.c       |  5 +++--
 drivers/scsi/scsi_scan.c      |  5 +++--
 drivers/ufs/core/ufs-sysfs.c  |  7 +++++--
 include/linux/blk-mq.h        | 18 ++++++++++++++++--
 26 files changed, 136 insertions(+), 84 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index f1cf7f2909f3..9ed93d91d754 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1546,6 +1546,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	struct request_queue *q = disk->queue;
 	struct blkg_policy_data *pd_prealloc = NULL;
 	struct blkcg_gq *blkg, *pinned_blkg = NULL;
+	unsigned int memflags;
 	int ret;
 
 	if (blkcg_policy_enabled(q, pol))
@@ -1560,7 +1561,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 		return -EINVAL;
 
 	if (queue_is_mq(q))
-		blk_mq_freeze_queue(q);
+		memflags = blk_mq_freeze_queue(q);
 retry:
 	spin_lock_irq(&q->queue_lock);
 
@@ -1624,7 +1625,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	spin_unlock_irq(&q->queue_lock);
 out:
 	if (queue_is_mq(q))
-		blk_mq_unfreeze_queue(q);
+		blk_mq_unfreeze_queue(q, memflags);
 	if (pinned_blkg)
 		blkg_put(pinned_blkg);
 	if (pd_prealloc)
@@ -1668,12 +1669,13 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 {
 	struct request_queue *q = disk->queue;
 	struct blkcg_gq *blkg;
+	unsigned int memflags;
 
 	if (!blkcg_policy_enabled(q, pol))
 		return;
 
 	if (queue_is_mq(q))
-		blk_mq_freeze_queue(q);
+		memflags = blk_mq_freeze_queue(q);
 
 	mutex_lock(&q->blkcg_mutex);
 	spin_lock_irq(&q->queue_lock);
@@ -1697,7 +1699,7 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 	mutex_unlock(&q->blkcg_mutex);
 
 	if (queue_is_mq(q))
-		blk_mq_unfreeze_queue(q);
+		blk_mq_unfreeze_queue(q, memflags);
 }
 EXPORT_SYMBOL_GPL(blkcg_deactivate_policy);
 
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a5894ec9696e..65a1d4427ccf 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3224,6 +3224,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	u32 qos[NR_QOS_PARAMS];
 	bool enable, user;
 	char *body, *p;
+	unsigned int memflags;
 	int ret;
 
 	blkg_conf_init(&ctx, input);
@@ -3247,7 +3248,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 		ioc = q_to_ioc(disk->queue);
 	}
 
-	blk_mq_freeze_queue(disk->queue);
+	memflags = blk_mq_freeze_queue(disk->queue);
 	blk_mq_quiesce_queue(disk->queue);
 
 	spin_lock_irq(&ioc->lock);
@@ -3347,7 +3348,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 		wbt_enable_default(disk);
 
 	blk_mq_unquiesce_queue(disk->queue);
-	blk_mq_unfreeze_queue(disk->queue);
+	blk_mq_unfreeze_queue(disk->queue, memflags);
 
 	blkg_conf_exit(&ctx);
 	return nbytes;
@@ -3355,7 +3356,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	spin_unlock_irq(&ioc->lock);
 
 	blk_mq_unquiesce_queue(disk->queue);
-	blk_mq_unfreeze_queue(disk->queue);
+	blk_mq_unfreeze_queue(disk->queue, memflags);
 
 	ret = -EINVAL;
 err:
@@ -3414,6 +3415,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 {
 	struct blkg_conf_ctx ctx;
 	struct request_queue *q;
+	unsigned int memflags;
 	struct ioc *ioc;
 	u64 u[NR_I_LCOEFS];
 	bool user;
@@ -3441,7 +3443,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 		ioc = q_to_ioc(q);
 	}
 
-	blk_mq_freeze_queue(q);
+	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	spin_lock_irq(&ioc->lock);
@@ -3493,7 +3495,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	spin_unlock_irq(&ioc->lock);
 
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
+	blk_mq_unfreeze_queue(q, memflags);
 
 	blkg_conf_exit(&ctx);
 	return nbytes;
@@ -3502,7 +3504,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	spin_unlock_irq(&ioc->lock);
 
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
+	blk_mq_unfreeze_queue(q, memflags);
 
 	ret = -EINVAL;
 err:
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index ebb522788d97..42c1e0b9a68f 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -749,9 +749,11 @@ static void blkiolatency_enable_work_fn(struct work_struct *work)
 	 */
 	enabled = atomic_read(&blkiolat->enable_cnt);
 	if (enabled != blkiolat->enabled) {
-		blk_mq_freeze_queue(blkiolat->rqos.disk->queue);
+		unsigned int memflags;
+
+		memflags = blk_mq_freeze_queue(blkiolat->rqos.disk->queue);
 		blkiolat->enabled = enabled;
-		blk_mq_unfreeze_queue(blkiolat->rqos.disk->queue);
+		blk_mq_unfreeze_queue(blkiolat->rqos.disk->queue, memflags);
 	}
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index da39a1cac702..40490ac88045 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -210,12 +210,12 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);
 
-void blk_mq_freeze_queue(struct request_queue *q)
+void blk_mq_freeze_queue_nomemsave(struct request_queue *q)
 {
 	blk_freeze_queue_start(q);
 	blk_mq_freeze_queue_wait(q);
 }
-EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
+EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_nomemsave);
 
 bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 {
@@ -236,12 +236,12 @@ bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 	return unfreeze;
 }
 
-void blk_mq_unfreeze_queue(struct request_queue *q)
+void blk_mq_unfreeze_queue_nomemrestore(struct request_queue *q)
 {
 	if (__blk_mq_unfreeze_queue(q, false))
 		blk_unfreeze_release_lock(q);
 }
-EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
+EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_nomemrestore);
 
 /*
  * non_owner variant of blk_freeze_queue_start
@@ -4223,13 +4223,14 @@ static void blk_mq_update_tag_set_shared(struct blk_mq_tag_set *set,
 					 bool shared)
 {
 	struct request_queue *q;
+	unsigned int memflags;
 
 	lockdep_assert_held(&set->tag_list_lock);
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_freeze_queue(q);
+		memflags = blk_mq_freeze_queue(q);
 		queue_set_hctx_shared(q, shared);
-		blk_mq_unfreeze_queue(q);
+		blk_mq_unfreeze_queue(q, memflags);
 	}
 }
 
@@ -4992,6 +4993,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	struct request_queue *q;
 	LIST_HEAD(head);
 	int prev_nr_hw_queues = set->nr_hw_queues;
+	unsigned int memflags;
 	int i;
 
 	lockdep_assert_held(&set->tag_list_lock);
@@ -5003,8 +5005,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
 		return;
 
+	memflags = memalloc_noio_save();
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_freeze_queue(q);
+		blk_mq_freeze_queue_nomemsave(q);
+
 	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
 	 * with the previous scheduler. We will switch back once we are done
@@ -5052,7 +5056,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_elv_switch_back(&head, q);
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_unfreeze_queue(q);
+		blk_mq_unfreeze_queue_nomemrestore(q);
+	memalloc_noio_restore(memflags);
 
 	/* Free the excess tags when nr_hw_queues shrink. */
 	for (i = set->nr_hw_queues; i < prev_nr_hw_queues; i++)
diff --git a/block/blk-pm.c b/block/blk-pm.c
index 42e842074715..8d3e052f91da 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -89,7 +89,7 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 	if (percpu_ref_is_zero(&q->q_usage_counter))
 		ret = 0;
 	/* Switch q_usage_counter back to per-cpu mode. */
-	blk_mq_unfreeze_queue(q);
+	blk_mq_unfreeze_queue_nomemrestore(q);
 
 	if (ret < 0) {
 		spin_lock_irq(&q->queue_lock);
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index eb9618cd68ad..d4d4f4dc0e23 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -299,6 +299,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 		const struct rq_qos_ops *ops)
 {
 	struct request_queue *q = disk->queue;
+	unsigned int memflags;
 
 	lockdep_assert_held(&q->rq_qos_mutex);
 
@@ -310,14 +311,14 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 	 * No IO can be in-flight when adding rqos, so freeze queue, which
 	 * is fine since we only support rq_qos for blk-mq queue.
 	 */
-	blk_mq_freeze_queue(q);
+	memflags = blk_mq_freeze_queue(q);
 
 	if (rq_qos_id(q, rqos->id))
 		goto ebusy;
 	rqos->next = q->rq_qos;
 	q->rq_qos = rqos;
 
-	blk_mq_unfreeze_queue(q);
+	blk_mq_unfreeze_queue(q, memflags);
 
 	if (rqos->ops->debugfs_attrs) {
 		mutex_lock(&q->debugfs_mutex);
@@ -327,7 +328,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 
 	return 0;
 ebusy:
-	blk_mq_unfreeze_queue(q);
+	blk_mq_unfreeze_queue(q, memflags);
 	return -EBUSY;
 }
 
@@ -335,17 +336,18 @@ void rq_qos_del(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->disk->queue;
 	struct rq_qos **cur;
+	unsigned int memflags;
 
 	lockdep_assert_held(&q->rq_qos_mutex);
 
-	blk_mq_freeze_queue(q);
+	memflags = blk_mq_freeze_queue(q);
 	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
 		if (*cur == rqos) {
 			*cur = rqos->next;
 			break;
 		}
 	}
-	blk_mq_unfreeze_queue(q);
+	blk_mq_unfreeze_queue(q, memflags);
 
 	mutex_lock(&q->debugfs_mutex);
 	blk_mq_debugfs_unregister_rqos(rqos);
diff --git a/block/blk-settings.c b/block/blk-settings.c
index db12396ff5c7..c44dadc35e1e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -461,11 +461,12 @@ EXPORT_SYMBOL_GPL(queue_limits_commit_update);
 int queue_limits_commit_update_frozen(struct request_queue *q,
 		struct queue_limits *lim)
 {
+	unsigned int memflags;
 	int ret;
 
-	blk_mq_freeze_queue(q);
+	memflags = blk_mq_freeze_queue(q);
 	ret = queue_limits_commit_update(q, lim);
-	blk_mq_unfreeze_queue(q);
+	blk_mq_unfreeze_queue(q, memflags);
 
 	return ret;
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e09b455874bf..368c2f6f5c85 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -681,7 +681,7 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	struct queue_sysfs_entry *entry = to_queue(attr);
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
 	struct request_queue *q = disk->queue;
-	unsigned int noio_flag;
+	unsigned int memflags;
 	ssize_t res;
 
 	if (!entry->store_limit && !entry->store)
@@ -711,11 +711,9 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	}
 
 	mutex_lock(&q->sysfs_lock);
-	blk_mq_freeze_queue(q);
-	noio_flag = memalloc_noio_save();
+	memflags = blk_mq_freeze_queue(q);
 	res = entry->store(disk, page, length);
-	memalloc_noio_restore(noio_flag);
-	blk_mq_unfreeze_queue(q);
+	blk_mq_unfreeze_queue(q, memflags);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
 }
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 82dbaefcfa3b..8d149aff9fd0 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1202,6 +1202,7 @@ static int blk_throtl_init(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct throtl_data *td;
+	unsigned int memflags;
 	int ret;
 
 	td = kzalloc_node(sizeof(*td), GFP_KERNEL, q->node);
@@ -1215,7 +1216,7 @@ static int blk_throtl_init(struct gendisk *disk)
 	 * Freeze queue before activating policy, to synchronize with IO path,
 	 * which is protected by 'q_usage_counter'.
 	 */
-	blk_mq_freeze_queue(disk->queue);
+	memflags = blk_mq_freeze_queue(disk->queue);
 	blk_mq_quiesce_queue(disk->queue);
 
 	q->td = td;
@@ -1239,7 +1240,7 @@ static int blk_throtl_init(struct gendisk *disk)
 
 out:
 	blk_mq_unquiesce_queue(disk->queue);
-	blk_mq_unfreeze_queue(disk->queue);
+	blk_mq_unfreeze_queue(disk->queue, memflags);
 
 	return ret;
 }
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 9d08a54c201e..761ea662ddc3 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1717,9 +1717,10 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	else
 		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
 	if (ret) {
-		blk_mq_freeze_queue(q);
+		unsigned int memflags = blk_mq_freeze_queue(q);
+
 		disk_free_zone_resources(disk);
-		blk_mq_unfreeze_queue(q);
+		blk_mq_unfreeze_queue(q, memflags);
 	}
 
 	return ret;
diff --git a/block/elevator.c b/block/elevator.c
index b81216c48b6b..cd2ce4921601 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -570,6 +570,7 @@ static struct elevator_type *elevator_get_default(struct request_queue *q)
 void elevator_init_mq(struct request_queue *q)
 {
 	struct elevator_type *e;
+	unsigned int memflags;
 	int err;
 
 	WARN_ON_ONCE(blk_queue_registered(q));
@@ -590,13 +591,13 @@ void elevator_init_mq(struct request_queue *q)
 	 *
 	 * Disk isn't added yet, so verifying queue lock only manually.
 	 */
-	blk_mq_freeze_queue(q);
+	memflags = blk_mq_freeze_queue(q);
 
 	blk_mq_cancel_work_sync(q);
 
 	err = blk_mq_init_sched(q, e);
 
-	blk_mq_unfreeze_queue(q);
+	blk_mq_unfreeze_queue(q, memflags);
 
 	if (err) {
 		pr_warn("\"%s\" elevator initialization failed, "
@@ -614,11 +615,12 @@ void elevator_init_mq(struct request_queue *q)
  */
 int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 {
+	unsigned int memflags;
 	int ret;
 
 	lockdep_assert_held(&q->sysfs_lock);
 
-	blk_mq_freeze_queue(q);
+	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
@@ -639,7 +641,7 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 
 out_unfreeze:
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
+	blk_mq_unfreeze_queue(q, memflags);
 
 	if (ret) {
 		pr_warn("elv: switch to \"%s\" failed, falling back to \"none\"\n",
@@ -651,9 +653,11 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 
 void elevator_disable(struct request_queue *q)
 {
+	unsigned int memflags;
+
 	lockdep_assert_held(&q->sysfs_lock);
 
-	blk_mq_freeze_queue(q);
+	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	elv_unregister_queue(q);
@@ -664,7 +668,7 @@ void elevator_disable(struct request_queue *q)
 	blk_add_trace_msg(q, "elv switch: none");
 
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
+	blk_mq_unfreeze_queue(q, memflags);
 }
 
 /*
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 3523dd82d7a0..4db7f6ce8ade 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -226,10 +226,11 @@ aoedev_downdev(struct aoedev *d)
 	/* fast fail all pending I/O */
 	if (d->blkq) {
 		/* UP is cleared, freeze+quiesce to insure all are errored */
-		blk_mq_freeze_queue(d->blkq);
+		unsigned int memflags = blk_mq_freeze_queue(d->blkq);
+
 		blk_mq_quiesce_queue(d->blkq);
 		blk_mq_unquiesce_queue(d->blkq);
-		blk_mq_unfreeze_queue(d->blkq);
+		blk_mq_unfreeze_queue(d->blkq, memflags);
 	}
 
 	if (d->gd)
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 110f9aca2667..a81ade622a01 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -746,6 +746,7 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 	unsigned char	*p;
 	int sect, nsect;
 	unsigned long	flags;
+	unsigned int memflags;
 	int ret;
 
 	if (type) {
@@ -758,7 +759,7 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 	}
 
 	q = unit[drive].disk[type]->queue;
-	blk_mq_freeze_queue(q);
+	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	local_irq_save(flags);
@@ -817,7 +818,7 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 	ret = FormatError ? -EIO : 0;
 out:
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
+	blk_mq_unfreeze_queue(q, memflags);
 	return ret;
 }
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 89352a85b704..94edc28dba5a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -603,6 +603,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 {
 	struct file *file = fget(arg);
 	struct file *old_file;
+	unsigned int memflags;
 	int error;
 	bool partscan;
 	bool is_loop;
@@ -640,11 +641,11 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 
 	/* and ... switch */
 	disk_force_media_change(lo->lo_disk);
-	blk_mq_freeze_queue(lo->lo_queue);
+	memflags = blk_mq_freeze_queue(lo->lo_queue);
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
 	loop_assign_backing_file(lo, file);
 	loop_update_dio(lo);
-	blk_mq_unfreeze_queue(lo->lo_queue);
+	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	loop_global_unlock(lo, is_loop);
 
@@ -1263,6 +1264,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	int err;
 	bool partscan = false;
 	bool size_changed = false;
+	unsigned int memflags;
 
 	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
@@ -1280,7 +1282,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	}
 
 	/* I/O needs to be drained before changing lo_offset or lo_sizelimit */
-	blk_mq_freeze_queue(lo->lo_queue);
+	memflags = blk_mq_freeze_queue(lo->lo_queue);
 
 	err = loop_set_status_from_info(lo, info);
 	if (err)
@@ -1303,7 +1305,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	loop_update_dio(lo);
 
 out_unfreeze:
-	blk_mq_unfreeze_queue(lo->lo_queue);
+	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
 	if (partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 out_unlock:
@@ -1455,6 +1457,7 @@ static int loop_set_capacity(struct loop_device *lo)
 static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 {
 	bool use_dio = !!arg;
+	unsigned int memflags;
 
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
@@ -1468,18 +1471,19 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 		vfs_fsync(lo->lo_backing_file, 0);
 	}
 
-	blk_mq_freeze_queue(lo->lo_queue);
+	memflags = blk_mq_freeze_queue(lo->lo_queue);
 	if (use_dio)
 		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
 	else
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
-	blk_mq_unfreeze_queue(lo->lo_queue);
+	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
 	return 0;
 }
 
 static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 {
 	struct queue_limits lim;
+	unsigned int memflags;
 	int err = 0;
 
 	if (lo->lo_state != Lo_bound)
@@ -1494,10 +1498,10 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	lim = queue_limits_start_update(lo->lo_queue);
 	loop_update_limits(lo, &lim, arg);
 
-	blk_mq_freeze_queue(lo->lo_queue);
+	memflags = blk_mq_freeze_queue(lo->lo_queue);
 	err = queue_limits_commit_update(lo->lo_queue, &lim);
 	loop_update_dio(lo);
-	blk_mq_unfreeze_queue(lo->lo_queue);
+	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
 
 	return err;
 }
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b63a0f29a54a..7bdc7eb808ea 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1234,6 +1234,7 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	struct socket *sock;
 	struct nbd_sock **socks;
 	struct nbd_sock *nsock;
+	unsigned int memflags;
 	int err;
 
 	/* Arg will be cast to int, check it to avoid overflow */
@@ -1247,7 +1248,7 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	 * We need to make sure we don't get any errant requests while we're
 	 * reallocating the ->socks array.
 	 */
-	blk_mq_freeze_queue(nbd->disk->queue);
+	memflags = blk_mq_freeze_queue(nbd->disk->queue);
 
 	if (!netlink && !nbd->task_setup &&
 	    !test_bit(NBD_RT_BOUND, &config->runtime_flags))
@@ -1288,12 +1289,12 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	INIT_WORK(&nsock->work, nbd_pending_cmd_work);
 	socks[config->num_connections++] = nsock;
 	atomic_inc(&config->live_connections);
-	blk_mq_unfreeze_queue(nbd->disk->queue);
+	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
 
 	return 0;
 
 put_socket:
-	blk_mq_unfreeze_queue(nbd->disk->queue);
+	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
 	sockfd_put(sock);
 	return err;
 }
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5b393e4a1ddf..faafd7ff43d6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -7281,9 +7281,10 @@ static ssize_t do_rbd_remove(const char *buf, size_t count)
 		 * Prevent new IO from being queued and wait for existing
 		 * IO to complete/fail.
 		 */
-		blk_mq_freeze_queue(rbd_dev->disk->queue);
+		unsigned int memflags = blk_mq_freeze_queue(rbd_dev->disk->queue);
+
 		blk_mark_disk_dead(rbd_dev->disk);
-		blk_mq_unfreeze_queue(rbd_dev->disk->queue);
+		blk_mq_unfreeze_queue(rbd_dev->disk->queue, memflags);
 	}
 
 	del_gendisk(rbd_dev->disk);
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index e4d1e7284dae..33b3bc99d532 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -1113,6 +1113,7 @@ static void vdc_requeue_inflight(struct vdc_port *port)
 static void vdc_queue_drain(struct vdc_port *port)
 {
 	struct request_queue *q = port->disk->queue;
+	unsigned int memflags;
 
 	/*
 	 * Mark the queue as draining, then freeze/quiesce to ensure
@@ -1121,12 +1122,12 @@ static void vdc_queue_drain(struct vdc_port *port)
 	port->drain = 1;
 	spin_unlock_irq(&port->vio.lock);
 
-	blk_mq_freeze_queue(q);
+	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	spin_lock_irq(&port->vio.lock);
 	port->drain = 0;
-	blk_mq_unquiesce_queue(q);
+	blk_mq_unquiesce_queue(q, memflags);
 	blk_mq_unfreeze_queue(q);
 }
 
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 9914153b365b..3aedcb5add61 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -840,6 +840,7 @@ static int grab_drive(struct floppy_state *fs, enum swim_state state,
 static void release_drive(struct floppy_state *fs)
 {
 	struct request_queue *q = disks[fs->index]->queue;
+	unsigned int memflags;
 	unsigned long flags;
 
 	swim3_dbg("%s", "-> release drive\n");
@@ -848,10 +849,10 @@ static void release_drive(struct floppy_state *fs)
 	fs->state = idle;
 	spin_unlock_irqrestore(&swim3_lock, flags);
 
-	blk_mq_freeze_queue(q);
+	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
+	blk_mq_unfreeze_queue(q, memflags);
 }
 
 static int fd_eject(struct floppy_state *fs)
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index bfbe391c20fe..6a61ec35f426 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1583,11 +1583,12 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
 	struct request_queue *q = vblk->disk->queue;
+	unsigned int memflags;
 
 	/* Ensure no requests in virtqueues before deleting vqs. */
-	blk_mq_freeze_queue(q);
+	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue_nowait(q);
-	blk_mq_unfreeze_queue(q);
+	blk_mq_unfreeze_queue(q, memflags);
 
 	/* Ensure we don't receive any more interrupts */
 	virtio_reset_device(vdev);
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index ee7e1d908986..847c11542f02 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -404,6 +404,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 int del_mtd_blktrans_dev(struct mtd_blktrans_dev *old)
 {
 	unsigned long flags;
+	unsigned int memflags;
 
 	lockdep_assert_held(&mtd_table_mutex);
 
@@ -420,10 +421,10 @@ int del_mtd_blktrans_dev(struct mtd_blktrans_dev *old)
 	spin_unlock_irqrestore(&old->queue_lock, flags);
 
 	/* freeze+quiesce queue to ensure all requests are flushed */
-	blk_mq_freeze_queue(old->rq);
+	memflags = blk_mq_freeze_queue(old->rq);
 	blk_mq_quiesce_queue(old->rq);
 	blk_mq_unquiesce_queue(old->rq);
-	blk_mq_unfreeze_queue(old->rq);
+	blk_mq_unfreeze_queue(old->rq, memflags);
 
 	/* If the device is currently open, tell trans driver to close it,
 		then put mtd device, and don't touch it again */
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 76b615d4d5b9..40046770f1bf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2132,15 +2132,16 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
 	struct queue_limits lim;
+	unsigned int memflags;
 	int ret;
 
 	lim = queue_limits_start_update(ns->disk->queue);
 	nvme_set_ctrl_limits(ns->ctrl, &lim);
 
-	blk_mq_freeze_queue(ns->disk->queue);
+	memflags = blk_mq_freeze_queue(ns->disk->queue);
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
-	blk_mq_unfreeze_queue(ns->disk->queue);
+	blk_mq_unfreeze_queue(ns->disk->queue, memflags);
 
 	/* Hide the block-interface for these devices */
 	if (!ret)
@@ -2155,6 +2156,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	struct nvme_id_ns_nvm *nvm = NULL;
 	struct nvme_zone_info zi = {};
 	struct nvme_id_ns *id;
+	unsigned int memflags;
 	sector_t capacity;
 	unsigned lbaf;
 	int ret;
@@ -2186,7 +2188,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 
 	lim = queue_limits_start_update(ns->disk->queue);
 
-	blk_mq_freeze_queue(ns->disk->queue);
+	memflags = blk_mq_freeze_queue(ns->disk->queue);
 	ns->head->lba_shift = id->lbaf[lbaf].ds;
 	ns->head->nuse = le64_to_cpu(id->nuse);
 	capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
@@ -2219,7 +2221,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
 	if (ret) {
-		blk_mq_unfreeze_queue(ns->disk->queue);
+		blk_mq_unfreeze_queue(ns->disk->queue, memflags);
 		goto out;
 	}
 
@@ -2235,7 +2237,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		ns->head->features |= NVME_NS_DEAC;
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
 	set_bit(NVME_NS_READY, &ns->flags);
-	blk_mq_unfreeze_queue(ns->disk->queue);
+	blk_mq_unfreeze_queue(ns->disk->queue, memflags);
 
 	if (blk_queue_is_zoned(ns->queue)) {
 		ret = blk_revalidate_disk_zones(ns->disk);
@@ -2291,9 +2293,10 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	if (!ret && nvme_ns_head_multipath(ns->head)) {
 		struct queue_limits *ns_lim = &ns->disk->queue->limits;
 		struct queue_limits lim;
+		unsigned int memflags;
 
 		lim = queue_limits_start_update(ns->head->disk->queue);
-		blk_mq_freeze_queue(ns->head->disk->queue);
+		memflags = blk_mq_freeze_queue(ns->head->disk->queue);
 		/*
 		 * queue_limits mixes values that are the hardware limitations
 		 * for bio splitting with what is the device configuration.
@@ -2325,7 +2328,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
 		nvme_mpath_revalidate_paths(ns);
 
-		blk_mq_unfreeze_queue(ns->head->disk->queue);
+		blk_mq_unfreeze_queue(ns->head->disk->queue, memflags);
 	}
 
 	return ret;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a85d190942bd..2a7635565083 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -60,7 +60,7 @@ void nvme_mpath_unfreeze(struct nvme_subsystem *subsys)
 	lockdep_assert_held(&subsys->lock);
 	list_for_each_entry(h, &subsys->nsheads, entry)
 		if (h->disk)
-			blk_mq_unfreeze_queue(h->disk->queue);
+			blk_mq_unfreeze_queue_nomemrestore(h->disk->queue);
 }
 
 void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys)
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index e7ea1f04164a..d776f13cd160 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2736,6 +2736,7 @@ int
 scsi_device_quiesce(struct scsi_device *sdev)
 {
 	struct request_queue *q = sdev->request_queue;
+	unsigned int memflags;
 	int err;
 
 	/*
@@ -2750,7 +2751,7 @@ scsi_device_quiesce(struct scsi_device *sdev)
 
 	blk_set_pm_only(q);
 
-	blk_mq_freeze_queue(q);
+	memflags = blk_mq_freeze_queue(q);
 	/*
 	 * Ensure that the effect of blk_set_pm_only() will be visible
 	 * for percpu_ref_tryget() callers that occur after the queue
@@ -2758,7 +2759,7 @@ scsi_device_quiesce(struct scsi_device *sdev)
 	 * was called. See also https://lwn.net/Articles/573497/.
 	 */
 	synchronize_rcu();
-	blk_mq_unfreeze_queue(q);
+	blk_mq_unfreeze_queue(q, memflags);
 
 	mutex_lock(&sdev->state_mutex);
 	err = scsi_device_set_state(sdev, SDEV_QUIESCE);
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index f2093982b3db..087fcbfc9aaa 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -220,6 +220,7 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
 	int new_shift = sbitmap_calculate_shift(depth);
 	bool need_alloc = !sdev->budget_map.map;
 	bool need_free = false;
+	unsigned int memflags;
 	int ret;
 	struct sbitmap sb_backup;
 
@@ -240,7 +241,7 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
 	 * and here disk isn't added yet, so freezing is pretty fast
 	 */
 	if (need_free) {
-		blk_mq_freeze_queue(sdev->request_queue);
+		memflags = blk_mq_freeze_queue(sdev->request_queue);
 		sb_backup = sdev->budget_map;
 	}
 	ret = sbitmap_init_node(&sdev->budget_map,
@@ -256,7 +257,7 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
 		else
 			sbitmap_free(&sb_backup);
 		ret = 0;
-		blk_mq_unfreeze_queue(sdev->request_queue);
+		blk_mq_unfreeze_queue(sdev->request_queue, memflags);
 	}
 	return ret;
 }
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 796e37a1d859..3438269a5440 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -1439,6 +1439,7 @@ static ssize_t max_number_of_rtt_store(struct device *dev,
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	struct ufs_dev_info *dev_info = &hba->dev_info;
 	struct scsi_device *sdev;
+	unsigned int memflags;
 	unsigned int rtt;
 	int ret;
 
@@ -1458,14 +1459,16 @@ static ssize_t max_number_of_rtt_store(struct device *dev,
 
 	ufshcd_rpm_get_sync(hba);
 
+	memflags = memalloc_noio_save();
 	shost_for_each_device(sdev, hba->host)
-		blk_mq_freeze_queue(sdev->request_queue);
+		blk_mq_freeze_queue_nomemsave(sdev->request_queue);
 
 	ret = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
 		QUERY_ATTR_IDN_MAX_NUM_OF_RTT, 0, 0, &rtt);
 
 	shost_for_each_device(sdev, hba->host)
-		blk_mq_unfreeze_queue(sdev->request_queue);
+		blk_mq_unfreeze_queue_nomemrestore(sdev->request_queue);
+	memalloc_noio_restore(memflags);
 
 	ufshcd_rpm_put_sync(hba);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a0a9007cc1e3..9ebb53f031cd 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -900,8 +900,22 @@ void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
 void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset);
-void blk_mq_freeze_queue(struct request_queue *q);
-void blk_mq_unfreeze_queue(struct request_queue *q);
+void blk_mq_freeze_queue_nomemsave(struct request_queue *q);
+void blk_mq_unfreeze_queue_nomemrestore(struct request_queue *q);
+static inline unsigned int __must_check
+blk_mq_freeze_queue(struct request_queue *q)
+{
+	unsigned int memflags = memalloc_noio_save();
+
+	blk_mq_freeze_queue_nomemsave(q);
+	return memflags;
+}
+static inline void
+blk_mq_unfreeze_queue(struct request_queue *q, unsigned int memflags)
+{
+	blk_mq_unfreeze_queue_nomemrestore(q);
+	memalloc_noio_restore(memflags);
+}
 void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
-- 
2.45.2


