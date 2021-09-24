Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F799416DF1
	for <lists+linux-block@lfdr.de>; Fri, 24 Sep 2021 10:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245007AbhIXIgB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Sep 2021 04:36:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3867 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244892AbhIXIfc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 04:35:32 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HG4xQ21N9z67xS9;
        Fri, 24 Sep 2021 16:31:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 24 Sep 2021 10:33:57 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 09:33:55 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <ming.lei@redhat.com>,
        <hare@suse.de>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v4 13/13] blk-mq: Stop using pointers for blk_mq_tags bitmap tags
Date:   Fri, 24 Sep 2021 16:28:30 +0800
Message-ID: <1632472110-244938-14-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1632472110-244938-1-git-send-email-john.garry@huawei.com>
References: <1632472110-244938-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that we use shared tags for shared sbitmap support, we don't require
the tags sbitmap pointers, so drop them.

This essentially reverts commit 222a5ae03cdd ("blk-mq: Use pointers for
blk_mq_tags bitmap tags").

Function blk_mq_init_bitmap_tags() is removed also, since it would be only
a wrappper for blk_mq_init_bitmaps().

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/bfq-iosched.c    |  4 +--
 block/blk-mq-debugfs.c |  8 +++---
 block/blk-mq-tag.c     | 56 +++++++++++++++---------------------------
 block/blk-mq-tag.h     |  7 ++----
 block/blk-mq.c         |  8 +++---
 block/kyber-iosched.c  |  4 +--
 block/mq-deadline.c    |  2 +-
 7 files changed, 35 insertions(+), 54 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index dd13c2bbc29c..4674f85d7df0 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6894,8 +6894,8 @@ static void bfq_depth_updated(struct blk_mq_hw_ctx *hctx)
 	struct blk_mq_tags *tags = hctx->sched_tags;
 	unsigned int min_shallow;
 
-	min_shallow = bfq_update_depths(bfqd, tags->bitmap_tags);
-	sbitmap_queue_min_shallow_depth(tags->bitmap_tags, min_shallow);
+	min_shallow = bfq_update_depths(bfqd, &tags->bitmap_tags);
+	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, min_shallow);
 }
 
 static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4b66d2776eda..4000376330c9 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -452,11 +452,11 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
 		   atomic_read(&tags->active_queues));
 
 	seq_puts(m, "\nbitmap_tags:\n");
-	sbitmap_queue_show(tags->bitmap_tags, m);
+	sbitmap_queue_show(&tags->bitmap_tags, m);
 
 	if (tags->nr_reserved_tags) {
 		seq_puts(m, "\nbreserved_tags:\n");
-		sbitmap_queue_show(tags->breserved_tags, m);
+		sbitmap_queue_show(&tags->breserved_tags, m);
 	}
 }
 
@@ -487,7 +487,7 @@ static int hctx_tags_bitmap_show(void *data, struct seq_file *m)
 	if (res)
 		goto out;
 	if (hctx->tags)
-		sbitmap_bitmap_show(&hctx->tags->bitmap_tags->sb, m);
+		sbitmap_bitmap_show(&hctx->tags->bitmap_tags.sb, m);
 	mutex_unlock(&q->sysfs_lock);
 
 out:
@@ -521,7 +521,7 @@ static int hctx_sched_tags_bitmap_show(void *data, struct seq_file *m)
 	if (res)
 		goto out;
 	if (hctx->sched_tags)
-		sbitmap_bitmap_show(&hctx->sched_tags->bitmap_tags->sb, m);
+		sbitmap_bitmap_show(&hctx->sched_tags->bitmap_tags.sb, m);
 	mutex_unlock(&q->sysfs_lock);
 
 out:
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 4e71ce6b37ea..4cf0f74f4fa9 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -46,9 +46,9 @@ bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
  */
 void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool include_reserve)
 {
-	sbitmap_queue_wake_all(tags->bitmap_tags);
+	sbitmap_queue_wake_all(&tags->bitmap_tags);
 	if (include_reserve)
-		sbitmap_queue_wake_all(tags->breserved_tags);
+		sbitmap_queue_wake_all(&tags->breserved_tags);
 }
 
 /*
@@ -104,10 +104,10 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 			WARN_ON_ONCE(1);
 			return BLK_MQ_NO_TAG;
 		}
-		bt = tags->breserved_tags;
+		bt = &tags->breserved_tags;
 		tag_offset = 0;
 	} else {
-		bt = tags->bitmap_tags;
+		bt = &tags->bitmap_tags;
 		tag_offset = tags->nr_reserved_tags;
 	}
 
@@ -153,9 +153,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 						data->ctx);
 		tags = blk_mq_tags_from_data(data);
 		if (data->flags & BLK_MQ_REQ_RESERVED)
-			bt = tags->breserved_tags;
+			bt = &tags->breserved_tags;
 		else
-			bt = tags->bitmap_tags;
+			bt = &tags->bitmap_tags;
 
 		/*
 		 * If destination hw queue is changed, fake wake up on
@@ -189,10 +189,10 @@ void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 		const int real_tag = tag - tags->nr_reserved_tags;
 
 		BUG_ON(real_tag >= tags->nr_tags);
-		sbitmap_queue_clear(tags->bitmap_tags, real_tag, ctx->cpu);
+		sbitmap_queue_clear(&tags->bitmap_tags, real_tag, ctx->cpu);
 	} else {
 		BUG_ON(tag >= tags->nr_reserved_tags);
-		sbitmap_queue_clear(tags->breserved_tags, tag, ctx->cpu);
+		sbitmap_queue_clear(&tags->breserved_tags, tag, ctx->cpu);
 	}
 }
 
@@ -343,9 +343,9 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
 	WARN_ON_ONCE(flags & BT_TAG_ITER_RESERVED);
 
 	if (tags->nr_reserved_tags)
-		bt_tags_for_each(tags, tags->breserved_tags, fn, priv,
+		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv,
 				 flags | BT_TAG_ITER_RESERVED);
-	bt_tags_for_each(tags, tags->bitmap_tags, fn, priv, flags);
+	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, flags);
 }
 
 /**
@@ -462,8 +462,8 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 			continue;
 
 		if (tags->nr_reserved_tags)
-			bt_for_each(hctx, tags->breserved_tags, fn, priv, true);
-		bt_for_each(hctx, tags->bitmap_tags, fn, priv, false);
+			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
+		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
 	}
 	blk_queue_exit(q);
 }
@@ -495,24 +495,6 @@ int blk_mq_init_bitmaps(struct sbitmap_queue *bitmap_tags,
 	return -ENOMEM;
 }
 
-static int blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
-				   int node, int alloc_policy)
-{
-	int ret;
-
-	ret = blk_mq_init_bitmaps(&tags->__bitmap_tags,
-				  &tags->__breserved_tags,
-				  tags->nr_tags, tags->nr_reserved_tags,
-				  node, alloc_policy);
-	if (ret)
-		return ret;
-
-	tags->bitmap_tags = &tags->__bitmap_tags;
-	tags->breserved_tags = &tags->__breserved_tags;
-
-	return 0;
-}
-
 struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 				     unsigned int reserved_tags,
 				     int node, int alloc_policy)
@@ -532,7 +514,9 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	tags->nr_reserved_tags = reserved_tags;
 	spin_lock_init(&tags->lock);
 
-	if (blk_mq_init_bitmap_tags(tags, node, alloc_policy) < 0) {
+	if (blk_mq_init_bitmaps(&tags->bitmap_tags, &tags->breserved_tags,
+				total_tags, reserved_tags, node,
+				alloc_policy) < 0) {
 		kfree(tags);
 		return NULL;
 	}
@@ -541,8 +525,8 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 void blk_mq_free_tags(struct blk_mq_tags *tags)
 {
-	sbitmap_queue_free(tags->bitmap_tags);
-	sbitmap_queue_free(tags->breserved_tags);
+	sbitmap_queue_free(&tags->bitmap_tags);
+	sbitmap_queue_free(&tags->breserved_tags);
 	kfree(tags);
 }
 
@@ -591,7 +575,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 		 * Don't need (or can't) update reserved tags here, they
 		 * remain static and should never need resizing.
 		 */
-		sbitmap_queue_resize(tags->bitmap_tags,
+		sbitmap_queue_resize(&tags->bitmap_tags,
 				tdepth - tags->nr_reserved_tags);
 	}
 
@@ -602,12 +586,12 @@ void blk_mq_tag_resize_shared_sbitmap(struct blk_mq_tag_set *set, unsigned int s
 {
 	struct blk_mq_tags *tags = set->shared_sbitmap_tags;
 
-	sbitmap_queue_resize(&tags->__bitmap_tags, size - set->reserved_tags);
+	sbitmap_queue_resize(&tags->bitmap_tags, size - set->reserved_tags);
 }
 
 void blk_mq_tag_update_sched_shared_sbitmap(struct request_queue *q)
 {
-	sbitmap_queue_resize(q->shared_sbitmap_tags->bitmap_tags,
+	sbitmap_queue_resize(&q->shared_sbitmap_tags->bitmap_tags,
 			     q->nr_requests - q->tag_set->reserved_tags);
 }
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index e433e39a9cfa..23747ea2bb53 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -11,11 +11,8 @@ struct blk_mq_tags {
 
 	atomic_t active_queues;
 
-	struct sbitmap_queue *bitmap_tags;
-	struct sbitmap_queue *breserved_tags;
-
-	struct sbitmap_queue __bitmap_tags;
-	struct sbitmap_queue __breserved_tags;
+	struct sbitmap_queue bitmap_tags;
+	struct sbitmap_queue breserved_tags;
 
 	struct request **rqs;
 	struct request **static_rqs;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ece43855bcdf..5baa35cae8a0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1062,14 +1062,14 @@ static inline unsigned int queued_to_index(unsigned int queued)
 
 static bool __blk_mq_get_driver_tag(struct request *rq)
 {
-	struct sbitmap_queue *bt = rq->mq_hctx->tags->bitmap_tags;
+	struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
 	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
 	int tag;
 
 	blk_mq_tag_busy(rq->mq_hctx);
 
 	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
-		bt = rq->mq_hctx->tags->breserved_tags;
+		bt = &rq->mq_hctx->tags->breserved_tags;
 		tag_offset = 0;
 	} else {
 		if (!hctx_may_queue(rq->mq_hctx, bt))
@@ -1112,7 +1112,7 @@ static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 		struct sbitmap_queue *sbq;
 
 		list_del_init(&wait->entry);
-		sbq = hctx->tags->bitmap_tags;
+		sbq = &hctx->tags->bitmap_tags;
 		atomic_dec(&sbq->ws_active);
 	}
 	spin_unlock(&hctx->dispatch_wait_lock);
@@ -1130,7 +1130,7 @@ static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 				 struct request *rq)
 {
-	struct sbitmap_queue *sbq = hctx->tags->bitmap_tags;
+	struct sbitmap_queue *sbq = &hctx->tags->bitmap_tags;
 	struct wait_queue_head *wq;
 	wait_queue_entry_t *wait;
 	bool ret;
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 15a8be57203d..9fb735bf1134 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -451,11 +451,11 @@ static void kyber_depth_updated(struct blk_mq_hw_ctx *hctx)
 {
 	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
 	struct blk_mq_tags *tags = hctx->sched_tags;
-	unsigned int shift = tags->bitmap_tags->sb.shift;
+	unsigned int shift = tags->bitmap_tags.sb.shift;
 
 	kqd->async_depth = (1U << shift) * KYBER_ASYNC_PERCENT / 100U;
 
-	sbitmap_queue_min_shallow_depth(tags->bitmap_tags, kqd->async_depth);
+	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, kqd->async_depth);
 }
 
 static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 7f3c3932b723..7fd07d00838e 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -519,7 +519,7 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
 
 	dd->async_depth = max(1UL, 3 * q->nr_requests / 4);
 
-	sbitmap_queue_min_shallow_depth(tags->bitmap_tags, dd->async_depth);
+	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_depth);
 }
 
 /* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */
-- 
2.26.2

