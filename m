Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3740366D7CC
	for <lists+linux-block@lfdr.de>; Tue, 17 Jan 2023 09:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbjAQIOB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Jan 2023 03:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbjAQINp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 03:13:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4C9298FD;
        Tue, 17 Jan 2023 00:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+/6WDEaCWUPLbArNJnoEULZc7ZWSS/49Mh4abbSz5eI=; b=1pOM33qpo+EJCn+4YSApt/vz90
        FKCY0/Sp++KgrOfSeLjgOfxMyNUOAlpb+7VgN4CXp07eUHjxBAGttMw1FhBhmKJgMlvgwgrLJ/ew1
        AGNlPjEATxvkWtYbmpqkTwsHxVFvtFsMgiCNHJZgelDILBAlvpBjlMJ6IUfUmjryNa45voaC1Q/Gx
        IbQ+5MJe0XE6FjtHWC6/6Vw7/Ye7EwCBy7QKJs9qMTvER1wiX50CgqeqZQKkvvtNNuJQB8fr/Ucis
        ic94+ecSkzJ7s0IA0YFLhOL4u6is6N1EceLt0s9kBW/rQ94UWIJPSaEN3H/25wO44n5ODJySebaky
        N7L/ERnw==;
Received: from [2001:4bb8:19a:2039:eaa2:3b9e:be2e:bd2a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHh6C-00DHoD-0b; Tue, 17 Jan 2023 08:13:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 15/15] blk-cgroup: move the cgroup information to struct gendisk
Date:   Tue, 17 Jan 2023 09:12:57 +0100
Message-Id: <20230117081257.3089859-16-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117081257.3089859-1-hch@lst.de>
References: <20230117081257.3089859-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

cgroup information only makes sense on a live gendisk that allows
file system I/O (which includes the raw block device).  So move over
the cgroup related members.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-cgroup.c     |  4 ++--
 block/blk-cgroup.c     | 48 +++++++++++++++++++++---------------------
 block/blk-cgroup.h     |  2 +-
 block/blk-iolatency.c  |  2 +-
 block/blk-throttle.c   | 16 ++++++++------
 include/linux/blkdev.h | 10 ++++-----
 6 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 055f9684c1c502..c13ba851c5221a 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1003,7 +1003,7 @@ void bfq_end_wr_async(struct bfq_data *bfqd)
 {
 	struct blkcg_gq *blkg;
 
-	list_for_each_entry(blkg, &bfqd->queue->blkg_list, q_node) {
+	list_for_each_entry(blkg, &bfqd->queue->disk->blkg_list, q_node) {
 		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
 
 		bfq_end_wr_async_queues(bfqd, bfqg);
@@ -1297,7 +1297,7 @@ struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
 	if (ret)
 		return NULL;
 
-	return blkg_to_bfqg(bfqd->queue->root_blkg);
+	return blkg_to_bfqg(bfqd->queue->disk->root_blkg);
 }
 
 struct blkcg_policy blkcg_policy_bfq = {
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index a041b3ddab6e33..0c813b50275cf1 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -108,10 +108,10 @@ static struct cgroup_subsys_state *blkcg_css(void)
 	return task_css(current, io_cgrp_id);
 }
 
-static bool blkcg_policy_enabled(struct request_queue *q,
+static bool blkcg_policy_enabled(struct gendisk *disk,
 				 const struct blkcg_policy *pol)
 {
-	return pol && test_bit(pol->plid, q->blkcg_pols);
+	return pol && test_bit(pol->plid, disk->blkcg_pols);
 }
 
 /**
@@ -264,7 +264,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 		struct blkcg_policy *pol = blkcg_policy[i];
 		struct blkg_policy_data *pd;
 
-		if (!blkcg_policy_enabled(disk->queue, pol))
+		if (!blkcg_policy_enabled(disk, pol))
 			continue;
 
 		/* alloc per-policy data and attach it to blkg */
@@ -341,7 +341,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 	ret = radix_tree_insert(&blkcg->blkg_tree, disk->queue->id, blkg);
 	if (likely(!ret)) {
 		hlist_add_head_rcu(&blkg->blkcg_node, &blkcg->blkg_list);
-		list_add(&blkg->q_node, &disk->queue->blkg_list);
+		list_add(&blkg->q_node, &disk->blkg_list);
 
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
@@ -410,7 +410,7 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 	while (true) {
 		struct blkcg *pos = blkcg;
 		struct blkcg *parent = blkcg_parent(blkcg);
-		struct blkcg_gq *ret_blkg = q->root_blkg;
+		struct blkcg_gq *ret_blkg = disk->root_blkg;
 
 		while (parent) {
 			blkg = blkg_lookup(parent, disk);
@@ -485,7 +485,7 @@ static void blkg_destroy_all(struct gendisk *disk)
 
 restart:
 	spin_lock_irq(&q->queue_lock);
-	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
+	list_for_each_entry_safe(blkg, n, &disk->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
 		spin_lock(&blkcg->lock);
@@ -504,7 +504,7 @@ static void blkg_destroy_all(struct gendisk *disk)
 		}
 	}
 
-	q->root_blkg = NULL;
+	disk->root_blkg = NULL;
 	spin_unlock_irq(&q->queue_lock);
 }
 
@@ -579,7 +579,7 @@ void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
 		spin_lock_irq(&blkg->disk->queue->queue_lock);
-		if (blkcg_policy_enabled(blkg->disk->queue, pol))
+		if (blkcg_policy_enabled(blkg->disk, pol))
 			total += prfill(sf, blkg->pd[pol->plid], data);
 		spin_unlock_irq(&blkg->disk->queue->queue_lock);
 	}
@@ -687,7 +687,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	rcu_read_lock();
 	spin_lock_irq(&q->queue_lock);
 
-	if (!blkcg_policy_enabled(q, pol)) {
+	if (!blkcg_policy_enabled(disk, pol)) {
 		ret = -EOPNOTSUPP;
 		goto fail_unlock;
 	}
@@ -730,7 +730,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		rcu_read_lock();
 		spin_lock_irq(&q->queue_lock);
 
-		if (!blkcg_policy_enabled(q, pol)) {
+		if (!blkcg_policy_enabled(disk, pol)) {
 			blkg_free(new_blkg);
 			ret = -EOPNOTSUPP;
 			goto fail_preloaded;
@@ -910,7 +910,7 @@ static void blkcg_fill_root_iostats(void)
 	class_dev_iter_init(&iter, &block_class, NULL, &disk_type);
 	while ((dev = class_dev_iter_next(&iter))) {
 		struct block_device *bdev = dev_to_bdev(dev);
-		struct blkcg_gq *blkg = bdev->bd_disk->queue->root_blkg;
+		struct blkcg_gq *blkg = bdev->bd_disk->root_blkg;
 		struct blkg_iostat tmp;
 		int cpu;
 		unsigned long flags;
@@ -1257,7 +1257,7 @@ int blkcg_init_disk(struct gendisk *disk)
 	bool preloaded;
 	int ret;
 
-	INIT_LIST_HEAD(&q->blkg_list);
+	INIT_LIST_HEAD(&disk->blkg_list);
 
 	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
 	if (!new_blkg)
@@ -1271,7 +1271,7 @@ int blkcg_init_disk(struct gendisk *disk)
 	blkg = blkg_create(&blkcg_root, disk, new_blkg);
 	if (IS_ERR(blkg))
 		goto err_unlock;
-	q->root_blkg = blkg;
+	disk->root_blkg = blkg;
 	spin_unlock_irq(&q->queue_lock);
 
 	if (preloaded)
@@ -1384,7 +1384,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	struct blkcg_gq *blkg, *pinned_blkg = NULL;
 	int ret;
 
-	if (blkcg_policy_enabled(q, pol))
+	if (blkcg_policy_enabled(disk, pol))
 		return 0;
 
 	if (queue_is_mq(q))
@@ -1393,7 +1393,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	spin_lock_irq(&q->queue_lock);
 
 	/* blkg_list is pushed at the head, reverse walk to allocate parents first */
-	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
+	list_for_each_entry_reverse(blkg, &disk->blkg_list, q_node) {
 		struct blkg_policy_data *pd;
 
 		if (blkg->pd[pol->plid])
@@ -1437,10 +1437,10 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 
 	/* all allocated, init in the same order */
 	if (pol->pd_init_fn)
-		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
+		list_for_each_entry_reverse(blkg, &disk->blkg_list, q_node)
 			pol->pd_init_fn(blkg->pd[pol->plid]);
 
-	__set_bit(pol->plid, q->blkcg_pols);
+	__set_bit(pol->plid, disk->blkcg_pols);
 	ret = 0;
 
 	spin_unlock_irq(&q->queue_lock);
@@ -1456,7 +1456,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 enomem:
 	/* alloc failed, nothing's initialized yet, free everything */
 	spin_lock_irq(&q->queue_lock);
-	list_for_each_entry(blkg, &q->blkg_list, q_node) {
+	list_for_each_entry(blkg, &disk->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
 		spin_lock(&blkcg->lock);
@@ -1486,7 +1486,7 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 	struct request_queue *q = disk->queue;
 	struct blkcg_gq *blkg;
 
-	if (!blkcg_policy_enabled(q, pol))
+	if (!blkcg_policy_enabled(disk, pol))
 		return;
 
 	if (queue_is_mq(q))
@@ -1494,9 +1494,9 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 
 	spin_lock_irq(&q->queue_lock);
 
-	__clear_bit(pol->plid, q->blkcg_pols);
+	__clear_bit(pol->plid, disk->blkcg_pols);
 
-	list_for_each_entry(blkg, &q->blkg_list, q_node) {
+	list_for_each_entry(blkg, &disk->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
 		spin_lock(&blkcg->lock);
@@ -1909,7 +1909,7 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
  * Associate @bio with the blkg found by combining the css's blkg and the
  * request_queue of the @bio.  An association failure is handled by walking up
  * the blkg tree.  Therefore, the blkg associated can be anything between @blkg
- * and q->root_blkg.  This situation only happens when a cgroup is dying and
+ * and disk->root_blkg.  This situation only happens when a cgroup is dying and
  * then the remaining bios will spill to the closest alive blkg.
  *
  * A reference will be taken on the blkg and will be released when @bio is
@@ -1924,8 +1924,8 @@ void bio_associate_blkg_from_css(struct bio *bio,
 	if (css && css->parent) {
 		bio->bi_blkg = blkg_tryget_closest(bio, css);
 	} else {
-		blkg_get(bdev_get_queue(bio->bi_bdev)->root_blkg);
-		bio->bi_blkg = bdev_get_queue(bio->bi_bdev)->root_blkg;
+		blkg_get(bio->bi_bdev->bd_disk->root_blkg);
+		bio->bi_blkg = bio->bi_bdev->bd_disk->root_blkg;
 	}
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 3e7508907f33d8..81eca9be7f9105 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -246,7 +246,7 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	if (blkcg == &blkcg_root)
-		return disk->queue->root_blkg;
+		return disk->root_blkg;
 
 	blkg = rcu_dereference(blkcg->blkg_hint);
 	if (blkg && blkg->disk == disk)
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index bc0d217f5c1723..5d5aa1e526b742 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -665,7 +665,7 @@ static void blkiolatency_timer_fn(struct timer_list *t)
 
 	rcu_read_lock();
 	blkg_for_each_descendant_pre(blkg, pos_css,
-				     blkiolat->rqos.disk->queue->root_blkg) {
+				     blkiolat->rqos.disk->root_blkg) {
 		struct iolatency_grp *iolat;
 		struct child_latency_info *lat_info;
 		unsigned long flags;
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 74bb1e753ea09d..902203bdddb4b4 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -451,7 +451,8 @@ static void blk_throtl_update_limit_valid(struct throtl_data *td)
 	bool low_valid = false;
 
 	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
+	blkg_for_each_descendant_post(blkg, pos_css,
+			td->queue->disk->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 
 		if (tg->bps[READ][LIMIT_LOW] || tg->bps[WRITE][LIMIT_LOW] ||
@@ -1180,7 +1181,7 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 
 	spin_lock_irq(&q->queue_lock);
 
-	if (!q->root_blkg)
+	if (!q->disk->root_blkg)
 		goto out_unlock;
 
 	if (throtl_can_upgrade(td, NULL))
@@ -1322,7 +1323,8 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	 * blk-throttle.
 	 */
 	blkg_for_each_descendant_pre(blkg, pos_css,
-			global ? tg->td->queue->root_blkg : tg_to_blkg(tg)) {
+			global ? tg->td->queue->disk->root_blkg :
+			tg_to_blkg(tg)) {
 		struct throtl_grp *this_tg = blkg_to_tg(blkg);
 		struct throtl_grp *parent_tg;
 
@@ -1717,7 +1719,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 	 * path need RCU protection and to prevent warning from lockdep.
 	 */
 	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
+	blkg_for_each_descendant_post(blkg, pos_css, disk->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 		struct throtl_service_queue *sq = &tg->service_queue;
 
@@ -1871,7 +1873,8 @@ static bool throtl_can_upgrade(struct throtl_data *td,
 		return false;
 
 	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
+	blkg_for_each_descendant_post(blkg, pos_css,
+			td->queue->disk->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 
 		if (tg == this_tg)
@@ -1917,7 +1920,8 @@ static void throtl_upgrade_state(struct throtl_data *td)
 	td->low_upgrade_time = jiffies;
 	td->scale = 0;
 	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
+	blkg_for_each_descendant_post(blkg, pos_css,
+			td->queue->disk->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 		struct throtl_service_queue *sq = &tg->service_queue;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b87ed829ab9418..d27010c25f75f0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -163,6 +163,11 @@ struct gendisk {
 	struct timer_rand_state *random;
 	atomic_t sync_io;		/* RAID */
 	struct disk_events *ev;
+#ifdef CONFIG_BLK_CGROUP
+	DECLARE_BITMAP		(blkcg_pols, BLKCG_MAX_POLS);
+	struct blkcg_gq		*root_blkg;
+	struct list_head	blkg_list;
+#endif
 #ifdef  CONFIG_BLK_DEV_INTEGRITY
 	struct kobject integrity_kobj;
 #endif	/* CONFIG_BLK_DEV_INTEGRITY */
@@ -481,11 +486,6 @@ struct request_queue {
 	struct blk_mq_tags	*sched_shared_tags;
 
 	struct list_head	icq_list;
-#ifdef CONFIG_BLK_CGROUP
-	DECLARE_BITMAP		(blkcg_pols, BLKCG_MAX_POLS);
-	struct blkcg_gq		*root_blkg;
-	struct list_head	blkg_list;
-#endif
 
 	struct queue_limits	limits;
 
-- 
2.39.0

