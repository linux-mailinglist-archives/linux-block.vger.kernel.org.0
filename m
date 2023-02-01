Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550FA68673C
	for <lists+linux-block@lfdr.de>; Wed,  1 Feb 2023 14:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjBANmS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Feb 2023 08:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjBANmO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2023 08:42:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832BA46D48;
        Wed,  1 Feb 2023 05:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=v+obufci+DGgkXvQyPdg2o6sD2Xhhd3zUYA1DRutKso=; b=bWsemC/zShKS8eBgnL4MKIjde0
        3NcNW9JIJ3gFoLUnCTOo2/5k4dC5Rq+8FhgdlIL6/VA4lGvR10P/Vkz5lPJ87kfqfYAAVqgFmqbqP
        G0UD+pVhUQZ8gWZFwjP8IOReK0ilDo+LzY8+FXmVk0A5guPbWiQYM6gPAT/2Cb9yV98ZmicxTwRWQ
        S7lVQghtBo8qdcsPyGbuQt8T4NcivFP4TXeWZ9O4zU6CLy1+7JLIm2TzMDn0TQaQJDkmuGHJqTRjr
        Eq//9PeCNk/k7Tf6FFDo5s+twkGIFRQABhYBkQx3tRglc+rP4tsoQ6ByFgfptFMrL081xqpl6+fx3
        NlNIoixw==;
Received: from [2001:4bb8:19a:272a:3635:31c6:c223:d428] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNDNK-00C7bO-7E; Wed, 01 Feb 2023 13:42:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 16/19] blk-cgroup: pass a gendisk to blkcg_{de,}activate_policy
Date:   Wed,  1 Feb 2023 14:41:20 +0100
Message-Id: <20230201134123.2656505-17-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230201134123.2656505-1-hch@lst.de>
References: <20230201134123.2656505-1-hch@lst.de>
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
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
---
 block/bfq-cgroup.c    |  2 +-
 block/bfq-iosched.c   |  2 +-
 block/blk-cgroup.c    | 21 +++++++++++----------
 block/blk-cgroup.h    |  9 ++++-----
 block/blk-iocost.c    |  4 ++--
 block/blk-iolatency.c |  4 ++--
 block/blk-ioprio.c    |  4 ++--
 block/blk-throttle.c  |  4 ++--
 8 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 1d4a3f15049bda..032c14f0451a1d 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1291,7 +1291,7 @@ struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
 {
 	int ret;
 
-	ret = blkcg_activate_policy(bfqd->queue, &blkcg_policy_bfq);
+	ret = blkcg_activate_policy(bfqd->queue->disk, &blkcg_policy_bfq);
 	if (ret)
 		return NULL;
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 5afa661fa2ea4c..777dcab73c8e28 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7146,7 +7146,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 	bfqg_and_blkg_put(bfqd->root_group);
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-	blkcg_deactivate_policy(bfqd->queue, &blkcg_policy_bfq);
+	blkcg_deactivate_policy(bfqd->queue->disk, &blkcg_policy_bfq);
 #else
 	spin_lock_irq(&bfqd->lock);
 	bfq_put_async_queues(bfqd, bfqd->root_group);
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 83fb519fd7d539..f8e77fac0df406 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1390,14 +1390,14 @@ struct cgroup_subsys io_cgrp_subsys = {
 EXPORT_SYMBOL_GPL(io_cgrp_subsys);
 
 /**
- * blkcg_activate_policy - activate a blkcg policy on a request_queue
- * @q: request_queue of interest
+ * blkcg_activate_policy - activate a blkcg policy on a gendisk
+ * @disk: gendisk of interest
  * @pol: blkcg policy to activate
  *
- * Activate @pol on @q.  Requires %GFP_KERNEL context.  @q goes through
+ * Activate @pol on @disk.  Requires %GFP_KERNEL context.  @disk goes through
  * bypass mode to populate its blkgs with policy_data for @pol.
  *
- * Activation happens with @q bypassed, so nobody would be accessing blkgs
+ * Activation happens with @disk bypassed, so nobody would be accessing blkgs
  * from IO path.  Update of each blkg is protected by both queue and blkcg
  * locks so that holding either lock and testing blkcg_policy_enabled() is
  * always enough for dereferencing policy data.
@@ -1405,9 +1405,9 @@ EXPORT_SYMBOL_GPL(io_cgrp_subsys);
  * The caller is responsible for synchronizing [de]activations and policy
  * [un]registerations.  Returns 0 on success, -errno on failure.
  */
-int blkcg_activate_policy(struct request_queue *q,
-			  const struct blkcg_policy *pol)
+int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 {
+	struct request_queue *q = disk->queue;
 	struct blkg_policy_data *pd_prealloc = NULL;
 	struct blkcg_gq *blkg, *pinned_blkg = NULL;
 	int ret;
@@ -1508,16 +1508,17 @@ int blkcg_activate_policy(struct request_queue *q,
 EXPORT_SYMBOL_GPL(blkcg_activate_policy);
 
 /**
- * blkcg_deactivate_policy - deactivate a blkcg policy on a request_queue
- * @q: request_queue of interest
+ * blkcg_deactivate_policy - deactivate a blkcg policy on a gendisk
+ * @disk: gendisk of interest
  * @pol: blkcg policy to deactivate
  *
- * Deactivate @pol on @q.  Follows the same synchronization rules as
+ * Deactivate @pol on @disk.  Follows the same synchronization rules as
  * blkcg_activate_policy().
  */
-void blkcg_deactivate_policy(struct request_queue *q,
+void blkcg_deactivate_policy(struct gendisk *disk,
 			     const struct blkcg_policy *pol)
 {
+	struct request_queue *q = disk->queue;
 	struct blkcg_gq *blkg;
 
 	if (!blkcg_policy_enabled(q, pol))
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 996572a9a0b72e..27068faa2cd086 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -194,9 +194,8 @@ void blkcg_exit_disk(struct gendisk *disk);
 /* Blkio controller policy registration */
 int blkcg_policy_register(struct blkcg_policy *pol);
 void blkcg_policy_unregister(struct blkcg_policy *pol);
-int blkcg_activate_policy(struct request_queue *q,
-			  const struct blkcg_policy *pol);
-void blkcg_deactivate_policy(struct request_queue *q,
+int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol);
+void blkcg_deactivate_policy(struct gendisk *disk,
 			     const struct blkcg_policy *pol);
 
 const char *blkg_dev_name(struct blkcg_gq *blkg);
@@ -495,9 +494,9 @@ static inline int blkcg_init_disk(struct gendisk *disk) { return 0; }
 static inline void blkcg_exit_disk(struct gendisk *disk) { }
 static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
 static inline void blkcg_policy_unregister(struct blkcg_policy *pol) { }
-static inline int blkcg_activate_policy(struct request_queue *q,
+static inline int blkcg_activate_policy(struct gendisk *disk,
 					const struct blkcg_policy *pol) { return 0; }
-static inline void blkcg_deactivate_policy(struct request_queue *q,
+static inline void blkcg_deactivate_policy(struct gendisk *disk,
 					   const struct blkcg_policy *pol) { }
 
 static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a2e9bf30039bcd..078b7770951962 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2821,7 +2821,7 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 {
 	struct ioc *ioc = rqos_to_ioc(rqos);
 
-	blkcg_deactivate_policy(rqos->disk->queue, &blkcg_policy_iocost);
+	blkcg_deactivate_policy(rqos->disk, &blkcg_policy_iocost);
 
 	spin_lock_irq(&ioc->lock);
 	ioc->running = IOC_STOP;
@@ -2893,7 +2893,7 @@ static int blk_iocost_init(struct gendisk *disk)
 	if (ret)
 		goto err_free_ioc;
 
-	ret = blkcg_activate_policy(disk->queue, &blkcg_policy_iocost);
+	ret = blkcg_activate_policy(disk, &blkcg_policy_iocost);
 	if (ret)
 		goto err_del_qos;
 	return 0;
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 8e1e43bbde6f0b..39853fc5c2b02f 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -646,7 +646,7 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 
 	timer_shutdown_sync(&blkiolat->timer);
 	flush_work(&blkiolat->enable_work);
-	blkcg_deactivate_policy(rqos->disk->queue, &blkcg_policy_iolatency);
+	blkcg_deactivate_policy(rqos->disk, &blkcg_policy_iolatency);
 	kfree(blkiolat);
 }
 
@@ -768,7 +768,7 @@ int blk_iolatency_init(struct gendisk *disk)
 			 &blkcg_iolatency_ops);
 	if (ret)
 		goto err_free;
-	ret = blkcg_activate_policy(disk->queue, &blkcg_policy_iolatency);
+	ret = blkcg_activate_policy(disk, &blkcg_policy_iolatency);
 	if (ret)
 		goto err_qos_del;
 
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 8bb6b8eba4cee8..8194826cc824bc 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -204,12 +204,12 @@ void blkcg_set_ioprio(struct bio *bio)
 
 void blk_ioprio_exit(struct gendisk *disk)
 {
-	blkcg_deactivate_policy(disk->queue, &ioprio_policy);
+	blkcg_deactivate_policy(disk, &ioprio_policy);
 }
 
 int blk_ioprio_init(struct gendisk *disk)
 {
-	return blkcg_activate_policy(disk->queue, &ioprio_policy);
+	return blkcg_activate_policy(disk, &ioprio_policy);
 }
 
 static int __init ioprio_init(void)
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index f802d8f9099430..efc0a9092c6942 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2395,7 +2395,7 @@ int blk_throtl_init(struct gendisk *disk)
 	td->low_downgrade_time = jiffies;
 
 	/* activate policy */
-	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
+	ret = blkcg_activate_policy(disk, &blkcg_policy_throtl);
 	if (ret) {
 		free_percpu(td->latency_buckets[READ]);
 		free_percpu(td->latency_buckets[WRITE]);
@@ -2411,7 +2411,7 @@ void blk_throtl_exit(struct gendisk *disk)
 	BUG_ON(!q->td);
 	del_timer_sync(&q->td->service_queue.pending_timer);
 	throtl_shutdown_wq(q);
-	blkcg_deactivate_policy(q, &blkcg_policy_throtl);
+	blkcg_deactivate_policy(disk, &blkcg_policy_throtl);
 	free_percpu(q->td->latency_buckets[READ]);
 	free_percpu(q->td->latency_buckets[WRITE]);
 	kfree(q->td);
-- 
2.39.0

