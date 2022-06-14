Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9928254AAEF
	for <lists+linux-block@lfdr.de>; Tue, 14 Jun 2022 09:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354726AbiFNHsr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Jun 2022 03:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354728AbiFNHsp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 03:48:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE8C3EAB9
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 00:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3DdXCzVR5u3vvZEMZkLy4tj/asMWLRsYm/utVoFmn60=; b=qwz0T9lqV75yDci7fJ4UP0g56s
        uVXRfhGpZY6rG0Cq4+qtijSXgdEJ4UAz8A3FpQ7ZpEz0XMVyoYGKyNB6MKcP3QASbAzWL4R7VtkA3
        TH5DFgwKYmtsbFNty5LP1mO0XNS6u+rWYBvLFJ2YKJpzAwbpOLojJzdOsol0wF7TsuCTWWOMHJD++
        7YCNERxlaj/9e84crDF7/2V5/34Xw9kV7QccymWVuIKHd1WZRmU+zQoKHC/mRdPMFpHBsMd4rqlJL
        UHj4a/tRN4t8sEwDUU+PRBgWGTd6sCBQFEQS7P7t10UWq9Zn3Am2civkwM/NC617pOzXexrGCpLLd
        ktvG9NzQ==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o11Hw-0082jU-Ep; Tue, 14 Jun 2022 07:48:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 2/4] block: serialize all debugfs operations using q->debugfs_mutex
Date:   Tue, 14 Jun 2022 09:48:25 +0200
Message-Id: <20220614074827.458955-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614074827.458955-1-hch@lst.de>
References: <20220614074827.458955-1-hch@lst.de>
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

Various places like I/O schedulers or the QOS infrastructure try to
register debugfs files on demans, which can race with creating and
removing the main queue debugfs directory.  Use the existing
debugfs_mutex to serialize all debugfs operations that rely on
q->debugfs_dir or the directories hanging off it.

To make the teardown code a little simpler declare all debugfs dentry
pointers and not just the main one uncoditionally in blkdev.h.

Move debugfs_mutex next to the dentries that it protects and document
what it is used for.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-debugfs.c  | 25 ++++++++++++++++++++-----
 block/blk-mq-debugfs.h  |  5 -----
 block/blk-mq-sched.c    | 11 +++++++++++
 block/blk-rq-qos.c      |  2 ++
 block/blk-rq-qos.h      |  7 ++++++-
 block/blk-sysfs.c       | 20 +++++++++-----------
 include/linux/blkdev.h  |  8 ++++----
 kernel/trace/blktrace.c |  3 ---
 8 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7e4136a60e1cc..f0fcfe1387cbc 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -711,11 +711,6 @@ void blk_mq_debugfs_register(struct request_queue *q)
 	}
 }
 
-void blk_mq_debugfs_unregister(struct request_queue *q)
-{
-	q->sched_debugfs_dir = NULL;
-}
-
 static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *ctx)
 {
@@ -746,6 +741,8 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
 
 void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
 {
+	if (!hctx->queue->debugfs_dir)
+		return;
 	debugfs_remove_recursive(hctx->debugfs_dir);
 	hctx->sched_debugfs_dir = NULL;
 	hctx->debugfs_dir = NULL;
@@ -773,6 +770,8 @@ void blk_mq_debugfs_register_sched(struct request_queue *q)
 {
 	struct elevator_type *e = q->elevator->type;
 
+	lockdep_assert_held(&q->debugfs_mutex);
+
 	/*
 	 * If the parent directory has not been created yet, return, we will be
 	 * called again later on and the directory/files will be created then.
@@ -790,6 +789,8 @@ void blk_mq_debugfs_register_sched(struct request_queue *q)
 
 void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 {
+	lockdep_assert_held(&q->debugfs_mutex);
+
 	debugfs_remove_recursive(q->sched_debugfs_dir);
 	q->sched_debugfs_dir = NULL;
 }
@@ -811,6 +812,10 @@ static const char *rq_qos_id_to_name(enum rq_qos_id id)
 
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 {
+	lockdep_assert_held(&rqos->q->debugfs_mutex);
+
+	if (!rqos->q->debugfs_dir)
+		return;
 	debugfs_remove_recursive(rqos->debugfs_dir);
 	rqos->debugfs_dir = NULL;
 }
@@ -820,6 +825,8 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 	struct request_queue *q = rqos->q;
 	const char *dir_name = rq_qos_id_to_name(rqos->id);
 
+	lockdep_assert_held(&q->debugfs_mutex);
+
 	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
 		return;
 
@@ -835,6 +842,8 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 
 void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
 {
+	lockdep_assert_held(&q->debugfs_mutex);
+
 	debugfs_remove_recursive(q->rqos_debugfs_dir);
 	q->rqos_debugfs_dir = NULL;
 }
@@ -844,6 +853,8 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 {
 	struct elevator_type *e = q->elevator->type;
 
+	lockdep_assert_held(&q->debugfs_mutex);
+
 	/*
 	 * If the parent debugfs directory has not been created yet, return;
 	 * We will be called again later on with appropriate parent debugfs
@@ -863,6 +874,10 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 
 void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
 {
+	lockdep_assert_held(&hctx->queue->debugfs_mutex);
+
+	if (!hctx->queue->debugfs_dir)
+		return;
 	debugfs_remove_recursive(hctx->sched_debugfs_dir);
 	hctx->sched_debugfs_dir = NULL;
 }
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 69918f4170d69..771d458328788 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -21,7 +21,6 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq);
 int blk_mq_debugfs_rq_show(struct seq_file *m, void *v);
 
 void blk_mq_debugfs_register(struct request_queue *q);
-void blk_mq_debugfs_unregister(struct request_queue *q);
 void blk_mq_debugfs_register_hctx(struct request_queue *q,
 				  struct blk_mq_hw_ctx *hctx);
 void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx);
@@ -42,10 +41,6 @@ static inline void blk_mq_debugfs_register(struct request_queue *q)
 {
 }
 
-static inline void blk_mq_debugfs_unregister(struct request_queue *q)
-{
-}
-
 static inline void blk_mq_debugfs_register_hctx(struct request_queue *q,
 						struct blk_mq_hw_ctx *hctx)
 {
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 9e56a69422b65..e84bec39fd3ad 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -593,7 +593,9 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	if (ret)
 		goto err_free_map_and_rqs;
 
+	mutex_lock(&q->debugfs_mutex);
 	blk_mq_debugfs_register_sched(q);
+	mutex_unlock(&q->debugfs_mutex);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (e->ops.init_hctx) {
@@ -606,7 +608,9 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 				return ret;
 			}
 		}
+		mutex_lock(&q->debugfs_mutex);
 		blk_mq_debugfs_register_sched_hctx(q, hctx);
+		mutex_unlock(&q->debugfs_mutex);
 	}
 
 	return 0;
@@ -647,14 +651,21 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 	unsigned int flags = 0;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
+		mutex_lock(&q->debugfs_mutex);
 		blk_mq_debugfs_unregister_sched_hctx(hctx);
+		mutex_unlock(&q->debugfs_mutex);
+
 		if (e->type->ops.exit_hctx && hctx->sched_data) {
 			e->type->ops.exit_hctx(hctx, i);
 			hctx->sched_data = NULL;
 		}
 		flags = hctx->flags;
 	}
+
+	mutex_lock(&q->debugfs_mutex);
 	blk_mq_debugfs_unregister_sched(q);
+	mutex_unlock(&q->debugfs_mutex);
+
 	if (e->type->ops.exit_sched)
 		e->type->ops.exit_sched(e);
 	blk_mq_sched_tags_teardown(q, flags);
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index e83af7bc75919..249a6f05dd3bd 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -294,7 +294,9 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 
 void rq_qos_exit(struct request_queue *q)
 {
+	mutex_lock(&q->debugfs_mutex);
 	blk_mq_debugfs_unregister_queue_rqos(q);
+	mutex_unlock(&q->debugfs_mutex);
 
 	while (q->rq_qos) {
 		struct rq_qos *rqos = q->rq_qos;
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 68267007da1c6..0e46052b018a4 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -104,8 +104,11 @@ static inline void rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
 
 	blk_mq_unfreeze_queue(q);
 
-	if (rqos->ops->debugfs_attrs)
+	if (rqos->ops->debugfs_attrs) {
+		mutex_lock(&q->debugfs_mutex);
 		blk_mq_debugfs_register_rqos(rqos);
+		mutex_unlock(&q->debugfs_mutex);
+	}
 }
 
 static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
@@ -129,7 +132,9 @@ static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
 
 	blk_mq_unfreeze_queue(q);
 
+	mutex_lock(&q->debugfs_mutex);
 	blk_mq_debugfs_unregister_rqos(rqos);
+	mutex_unlock(&q->debugfs_mutex);
 }
 
 typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 88bd41d4cb593..6e4801b217a79 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -779,14 +779,13 @@ static void blk_release_queue(struct kobject *kobj)
 	if (queue_is_mq(q))
 		blk_mq_release(q);
 
-	blk_trace_shutdown(q);
 	mutex_lock(&q->debugfs_mutex);
+	blk_trace_shutdown(q);
 	debugfs_remove_recursive(q->debugfs_dir);
+	q->debugfs_dir = NULL;
+	q->sched_debugfs_dir = NULL;
 	mutex_unlock(&q->debugfs_mutex);
 
-	if (queue_is_mq(q))
-		blk_mq_debugfs_unregister(q);
-
 	bioset_exit(&q->bio_split);
 
 	if (blk_queue_has_srcu(q))
@@ -836,17 +835,16 @@ int blk_register_queue(struct gendisk *disk)
 		goto unlock;
 	}
 
+	if (queue_is_mq(q))
+		__blk_mq_register_dev(dev, q);
+	mutex_lock(&q->sysfs_lock);
+
 	mutex_lock(&q->debugfs_mutex);
 	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
 					    blk_debugfs_root);
-	mutex_unlock(&q->debugfs_mutex);
-
-	if (queue_is_mq(q)) {
-		__blk_mq_register_dev(dev, q);
+	if (queue_is_mq(q))
 		blk_mq_debugfs_register(q);
-	}
-
-	mutex_lock(&q->sysfs_lock);
+	mutex_unlock(&q->debugfs_mutex);
 
 	ret = disk_register_independent_access_ranges(disk, NULL);
 	if (ret)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 608d577734c29..0fc912d756f94 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -482,7 +482,6 @@ struct request_queue {
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 	int			node;
-	struct mutex		debugfs_mutex;
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace __rcu	*blk_trace;
 #endif
@@ -526,11 +525,12 @@ struct request_queue {
 	struct bio_set		bio_split;
 
 	struct dentry		*debugfs_dir;
-
-#ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*sched_debugfs_dir;
 	struct dentry		*rqos_debugfs_dir;
-#endif
+	/*
+	 * Serializes all debugfs metadata operations using the above dentries.
+	 */
+	struct mutex		debugfs_mutex;
 
 	bool			mq_sysfs_init_done;
 
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 10a32b0f2deb6..fe04c6f96ca5d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -770,14 +770,11 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
  **/
 void blk_trace_shutdown(struct request_queue *q)
 {
-	mutex_lock(&q->debugfs_mutex);
 	if (rcu_dereference_protected(q->blk_trace,
 				      lockdep_is_held(&q->debugfs_mutex))) {
 		__blk_trace_startstop(q, 0);
 		__blk_trace_remove(q);
 	}
-
-	mutex_unlock(&q->debugfs_mutex);
 }
 
 #ifdef CONFIG_BLK_CGROUP
-- 
2.30.2

