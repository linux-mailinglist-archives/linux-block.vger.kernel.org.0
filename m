Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBFD55EAD6
	for <lists+linux-block@lfdr.de>; Tue, 28 Jun 2022 19:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiF1RTL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Jun 2022 13:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiF1RTL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 13:19:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B682FFC8
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pT+rgts4+pJhWsdjJIWYYO5vmuzG7nq4lm+YgyHoQRE=; b=S8oS66w5AM1zsTuN7lcKzIAhre
        VSZ/z9BYWmxZ0frsomkdbhOKTYu4UknQ44m6A0kQqZVGBScyy6SNsEsa/9RnJF2F+BzRrjZN5SGO8
        K7pL9uYyXWueFJTd0xnHD5w6OHf+U4ny65gxP/eDaBC3zAuZuaLvgG9+GkBg4r1TQLBd0yWEw/1tZ
        7QIs7O71XLSLQPZAhwwFg5unNpc+3ZR27kPAosav8zbEDWlrGJWSa5Y929ZigKyyVJVq3u7uAsYmk
        A5IDy80qSe1TR0A40vN5706fXs6CY4Xlfsq1+u+0IZ7+F3/L+Ojgc5HMUKjJMdrxRLVgVeKr6CGpY
        jthf03sQ==;
Received: from [2001:4bb8:199:3788:e965:1541:b076:2977] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6Erl-007NVp-GB; Tue, 28 Jun 2022 17:19:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 6/6] blk-mq: cleanup disk sysfs registration
Date:   Tue, 28 Jun 2022 19:18:50 +0200
Message-Id: <20220628171850.1313069-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220628171850.1313069-1-hch@lst.de>
References: <20220628171850.1313069-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass a gendisk to the sysfs register/unregister functions and give
them descriptive names.  Also move the unregistration helper next
to the one doing the registration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-sysfs.c   | 39 ++++++++++++++++++++-------------------
 block/blk-mq.h         |  3 ++-
 block/blk-sysfs.c      |  9 ++++-----
 include/linux/blk-mq.h |  1 -
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index ee6efe2b250d2..93997d297d427 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -203,22 +203,6 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
 	return ret;
 }
 
-void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
-{
-	struct blk_mq_hw_ctx *hctx;
-	unsigned long i;
-
-	lockdep_assert_held(&q->sysfs_dir_lock);
-
-	queue_for_each_hw_ctx(q, hctx, i)
-		blk_mq_unregister_hctx(hctx);
-
-	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
-	kobject_del(q->mq_kobj);
-
-	q->mq_sysfs_init_done = false;
-}
-
 void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx)
 {
 	kobject_init(&hctx->kobj, &blk_mq_hw_ktype);
@@ -251,16 +235,16 @@ void blk_mq_sysfs_init(struct request_queue *q)
 	}
 }
 
-int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
+int blk_mq_sysfs_register(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i, j;
 	int ret;
 
-	WARN_ON_ONCE(!q->kobj.parent);
 	lockdep_assert_held(&q->sysfs_dir_lock);
 
-	ret = kobject_add(q->mq_kobj, &dev->kobj, "%s", "mq");
+	ret = kobject_add(q->mq_kobj, &disk_to_dev(disk)->kobj, "mq");
 	if (ret < 0)
 		goto out;
 
@@ -288,6 +272,23 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 	return ret;
 }
 
+void blk_mq_sysfs_unregister(struct gendisk *disk)
+{
+	struct request_queue *q = disk->queue;
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long i;
+
+	lockdep_assert_held(&q->sysfs_dir_lock);
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		blk_mq_unregister_hctx(hctx);
+
+	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
+	kobject_del(q->mq_kobj);
+
+	q->mq_sysfs_init_done = false;
+}
+
 void blk_mq_sysfs_unregister_hctxs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index a92639f2bfd21..54e20edf0da30 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -118,7 +118,8 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
  */
 extern void blk_mq_sysfs_init(struct request_queue *q);
 extern void blk_mq_sysfs_deinit(struct request_queue *q);
-extern int __blk_mq_register_dev(struct device *dev, struct request_queue *q);
+int blk_mq_sysfs_register(struct gendisk *disk);
+void blk_mq_sysfs_unregister(struct gendisk *disk);
 int blk_mq_sysfs_register_hctxs(struct request_queue *q);
 void blk_mq_sysfs_unregister_hctxs(struct request_queue *q);
 extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b72506770b97e..85ea43eff094c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -812,18 +812,17 @@ struct kobj_type blk_queue_ktype = {
  */
 int blk_register_queue(struct gendisk *disk)
 {
-	int ret;
-	struct device *dev = disk_to_dev(disk);
 	struct request_queue *q = disk->queue;
+	int ret;
 
 	mutex_lock(&q->sysfs_dir_lock);
 
-	ret = kobject_add(&q->kobj, &dev->kobj, "%s", "queue");
+	ret = kobject_add(&q->kobj, &disk_to_dev(disk)->kobj, "queue");
 	if (ret < 0)
 		goto unlock;
 
 	if (queue_is_mq(q))
-		__blk_mq_register_dev(dev, q);
+		blk_mq_sysfs_register(disk);
 	mutex_lock(&q->sysfs_lock);
 
 	mutex_lock(&q->debugfs_mutex);
@@ -919,7 +918,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	 * structures that can be modified through sysfs.
 	 */
 	if (queue_is_mq(q))
-		blk_mq_unregister_dev(disk_to_dev(disk), q);
+		blk_mq_sysfs_unregister(disk);
 	blk_crypto_sysfs_unregister(q);
 
 	mutex_lock(&q->sysfs_lock);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0fd96e92c6c65..43aad0da3305d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -691,7 +691,6 @@ struct gendisk *blk_mq_alloc_disk_for_queue(struct request_queue *q,
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *);
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		struct request_queue *q);
-void blk_mq_unregister_dev(struct device *, struct request_queue *);
 void blk_mq_destroy_queue(struct request_queue *);
 
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
-- 
2.30.2

