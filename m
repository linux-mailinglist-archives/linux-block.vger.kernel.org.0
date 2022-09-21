Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F765D1C4D
	for <lists+linux-block@lfdr.de>; Wed, 21 Sep 2022 20:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiIUSF4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 21 Sep 2022 14:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiIUSFu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EB77AC25
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FDCEniY+aK/9Ygq94nEzECnMQNx6HymvVYxR0DM2jGA=; b=q+r/Mt7BetmsVTuha26GRqicF1
        /hJkdo52ohpC33xpn79qcwbNO/zBITANWKqQT6YGtK8cUlG8aSCpXNRFhIC6krwkc0SB1fDfyEc8v
        6f1PhRnlTbOb9WrtG/xxlludI/8CwTqIQQXzAjPeYDovFKvcD5TBbcwYKWoqdxTIbw1kjoJnl6WAE
        VKvkuBLpSk3MhJ7XFLW7HDxTAyFrxqrKj+EG/bu+JEMCFIUUUSAarrPaQSLpX1if3SLcp7DF4io7b
        l1LAF78fgB7GOqwm51N4O0QL9BTRZDN7zJ4nrwQrLRA/ChXCtEqk3mWL5Czi4WLGDAYnL4Sle6pGT
        pTNEnS0w==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob46W-00CGdx-2Y; Wed, 21 Sep 2022 18:05:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 17/17] blk-cgroup: pass a gendisk to the blkg allocation helpers
Date:   Wed, 21 Sep 2022 20:05:01 +0200
Message-Id: <20220921180501.1539876-18-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
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

Prepare for storing the blkcg information in the gendisk instead of
the request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 56 +++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index fc82057db9629..94af5f3f3620b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -202,19 +202,19 @@ static inline struct blkcg *blkcg_parent(struct blkcg *blkcg)
 /**
  * blkg_alloc - allocate a blkg
  * @blkcg: block cgroup the new blkg is associated with
- * @q: request_queue the new blkg is associated with
+ * @disk: gendisk the new blkg is associated with
  * @gfp_mask: allocation mask to use
  *
  * Allocate a new blkg assocating @blkcg and @q.
  */
-static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
+static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 				   gfp_t gfp_mask)
 {
 	struct blkcg_gq *blkg;
 	int i, cpu;
 
 	/* alloc and init base part */
-	blkg = kzalloc_node(sizeof(*blkg), gfp_mask, q->node);
+	blkg = kzalloc_node(sizeof(*blkg), gfp_mask, disk->queue->node);
 	if (!blkg)
 		return NULL;
 
@@ -225,10 +225,10 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	if (!blkg->iostat_cpu)
 		goto err_free;
 
-	if (!blk_get_queue(q))
+	if (!blk_get_queue(disk->queue))
 		goto err_free;
 
-	blkg->q = q;
+	blkg->q = disk->queue;
 	INIT_LIST_HEAD(&blkg->q_node);
 	spin_lock_init(&blkg->async_bio_lock);
 	bio_list_init(&blkg->async_bios);
@@ -243,11 +243,11 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 		struct blkcg_policy *pol = blkcg_policy[i];
 		struct blkg_policy_data *pd;
 
-		if (!blkcg_policy_enabled(q, pol))
+		if (!blkcg_policy_enabled(disk->queue, pol))
 			continue;
 
 		/* alloc per-policy data and attach it to blkg */
-		pd = pol->pd_alloc_fn(gfp_mask, q, blkcg);
+		pd = pol->pd_alloc_fn(gfp_mask, disk->queue, blkcg);
 		if (!pd)
 			goto err_free;
 
@@ -275,17 +275,16 @@ static void blkg_update_hint(struct blkcg *blkcg, struct blkcg_gq *blkg)
  * If @new_blkg is %NULL, this function tries to allocate a new one as
  * necessary using %GFP_NOWAIT.  @new_blkg is always consumed on return.
  */
-static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
-				    struct request_queue *q,
+static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 				    struct blkcg_gq *new_blkg)
 {
 	struct blkcg_gq *blkg;
 	int i, ret;
 
-	lockdep_assert_held(&q->queue_lock);
+	lockdep_assert_held(&disk->queue->queue_lock);
 
 	/* request_queue is dying, do not create/recreate a blkg */
-	if (blk_queue_dying(q)) {
+	if (blk_queue_dying(disk->queue)) {
 		ret = -ENODEV;
 		goto err_free_blkg;
 	}
@@ -298,7 +297,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 
 	/* allocate */
 	if (!new_blkg) {
-		new_blkg = blkg_alloc(blkcg, q, GFP_NOWAIT | __GFP_NOWARN);
+		new_blkg = blkg_alloc(blkcg, disk, GFP_NOWAIT | __GFP_NOWARN);
 		if (unlikely(!new_blkg)) {
 			ret = -ENOMEM;
 			goto err_put_css;
@@ -308,7 +307,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 
 	/* link parent */
 	if (blkcg_parent(blkcg)) {
-		blkg->parent = blkg_lookup(blkcg_parent(blkcg), q);
+		blkg->parent = blkg_lookup(blkcg_parent(blkcg), disk->queue);
 		if (WARN_ON_ONCE(!blkg->parent)) {
 			ret = -ENODEV;
 			goto err_put_css;
@@ -326,10 +325,10 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 
 	/* insert */
 	spin_lock(&blkcg->lock);
-	ret = radix_tree_insert(&blkcg->blkg_tree, q->id, blkg);
+	ret = radix_tree_insert(&blkcg->blkg_tree, disk->queue->id, blkg);
 	if (likely(!ret)) {
 		hlist_add_head_rcu(&blkg->blkcg_node, &blkcg->blkg_list);
-		list_add(&blkg->q_node, &q->blkg_list);
+		list_add(&blkg->q_node, &disk->queue->blkg_list);
 
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
@@ -358,19 +357,20 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 /**
  * blkg_lookup_create - lookup blkg, try to create one if not there
  * @blkcg: blkcg of interest
- * @q: request_queue of interest
+ * @disk: gendisk of interest
  *
- * Lookup blkg for the @blkcg - @q pair.  If it doesn't exist, try to
+ * Lookup blkg for the @blkcg - @disk pair.  If it doesn't exist, try to
  * create one.  blkg creation is performed recursively from blkcg_root such
  * that all non-root blkg's have access to the parent blkg.  This function
- * should be called under RCU read lock and takes @q->queue_lock.
+ * should be called under RCU read lock and takes @disk->queue->queue_lock.
  *
  * Returns the blkg or the closest blkg if blkg_create() fails as it walks
  * down from root.
  */
 static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
-		struct request_queue *q)
+		struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
 	struct blkcg_gq *blkg;
 	unsigned long flags;
 
@@ -408,7 +408,7 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 			parent = blkcg_parent(parent);
 		}
 
-		blkg = blkg_create(pos, q, NULL);
+		blkg = blkg_create(pos, disk, NULL);
 		if (IS_ERR(blkg)) {
 			blkg = ret_blkg;
 			break;
@@ -652,6 +652,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	__acquires(rcu) __acquires(&bdev->bd_queue->queue_lock)
 {
 	struct block_device *bdev;
+	struct gendisk *disk;
 	struct request_queue *q;
 	struct blkcg_gq *blkg;
 	int ret;
@@ -659,8 +660,8 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	bdev = blkcg_conf_open_bdev(&input);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
-
-	q = bdev_get_queue(bdev);
+	disk = bdev->bd_disk;
+	q = disk->queue;
 
 	/*
 	 * blkcg_deactivate_policy() requires queue to be frozen, we can grab
@@ -703,7 +704,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		spin_unlock_irq(&q->queue_lock);
 		rcu_read_unlock();
 
-		new_blkg = blkg_alloc(pos, q, GFP_KERNEL);
+		new_blkg = blkg_alloc(pos, disk, GFP_KERNEL);
 		if (unlikely(!new_blkg)) {
 			ret = -ENOMEM;
 			goto fail_exit_queue;
@@ -729,7 +730,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			blkg_update_hint(pos, blkg);
 			blkg_free(new_blkg);
 		} else {
-			blkg = blkg_create(pos, q, new_blkg);
+			blkg = blkg_create(pos, disk, new_blkg);
 			if (IS_ERR(blkg)) {
 				ret = PTR_ERR(blkg);
 				goto fail_preloaded;
@@ -1234,7 +1235,7 @@ int blkcg_init_disk(struct gendisk *disk)
 
 	INIT_LIST_HEAD(&q->blkg_list);
 
-	new_blkg = blkg_alloc(&blkcg_root, q, GFP_KERNEL);
+	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
 	if (!new_blkg)
 		return -ENOMEM;
 
@@ -1243,7 +1244,7 @@ int blkcg_init_disk(struct gendisk *disk)
 	/* Make sure the root blkg exists. */
 	/* spin_lock_irq can serve as RCU read-side critical section. */
 	spin_lock_irq(&q->queue_lock);
-	blkg = blkg_create(&blkcg_root, q, new_blkg);
+	blkg = blkg_create(&blkcg_root, disk, new_blkg);
 	if (IS_ERR(blkg))
 		goto err_unlock;
 	q->root_blkg = blkg;
@@ -1860,8 +1861,7 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
 	struct blkcg_gq *blkg, *ret_blkg = NULL;
 
 	rcu_read_lock();
-	blkg = blkg_lookup_create(css_to_blkcg(css),
-				  bdev_get_queue(bio->bi_bdev));
+	blkg = blkg_lookup_create(css_to_blkcg(css), bio->bi_bdev->bd_disk);
 	while (blkg) {
 		if (blkg_tryget(blkg)) {
 			ret_blkg = blkg;
-- 
2.30.2

