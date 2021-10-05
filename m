Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF085422394
	for <lists+linux-block@lfdr.de>; Tue,  5 Oct 2021 12:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhJEKbn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 Oct 2021 06:31:43 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3931 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbhJEKbJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Oct 2021 06:31:09 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HNtyl1ftWz67bS0;
        Tue,  5 Oct 2021 18:25:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 5 Oct 2021 12:29:17 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 5 Oct 2021 11:29:14 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <hare@suse.de>,
        <linux-scsi@vger.kernel.org>, <kashyap.desai@broadcom.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v5 14/14] blk-mq: Change shared sbitmap naming to shared tags
Date:   Tue, 5 Oct 2021 18:23:39 +0800
Message-ID: <1633429419-228500-15-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1633429419-228500-1-git-send-email-john.garry@huawei.com>
References: <1633429419-228500-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that shared sbitmap support really means shared tags, rename symbols
to match that.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/blk-core.c       |  2 +-
 block/blk-mq-sched.c   | 32 ++++++++++++++++----------------
 block/blk-mq-tag.c     | 18 +++++++++---------
 block/blk-mq-tag.h     |  4 ++--
 block/blk-mq.c         | 32 ++++++++++++++++----------------
 block/blk-mq.h         | 16 ++++++++--------
 block/elevator.c       |  2 +-
 include/linux/blk-mq.h |  8 ++++----
 include/linux/blkdev.h |  4 ++--
 9 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7c869737ce4c..532c817525de 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -536,7 +536,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 
 	q->node = node_id;
 
-	atomic_set(&q->nr_active_requests_shared_sbitmap, 0);
+	atomic_set(&q->nr_active_requests_shared_tags, 0);
 
 	timer_setup(&q->timeout, blk_rq_timed_out_timer, 0);
 	INIT_WORK(&q->timeout_work, blk_timeout_work);
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 428da4949d80..27312da7d638 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -519,8 +519,8 @@ static int blk_mq_sched_alloc_map_and_rqs(struct request_queue *q,
 					  struct blk_mq_hw_ctx *hctx,
 					  unsigned int hctx_idx)
 {
-	if (blk_mq_is_sbitmap_shared(q->tag_set->flags)) {
-		hctx->sched_tags = q->shared_sbitmap_tags;
+	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
+		hctx->sched_tags = q->sched_shared_tags;
 		return 0;
 	}
 
@@ -532,10 +532,10 @@ static int blk_mq_sched_alloc_map_and_rqs(struct request_queue *q,
 	return 0;
 }
 
-static void blk_mq_exit_sched_shared_sbitmap(struct request_queue *queue)
+static void blk_mq_exit_sched_shared_tags(struct request_queue *queue)
 {
-	blk_mq_free_rq_map(queue->shared_sbitmap_tags);
-	queue->shared_sbitmap_tags = NULL;
+	blk_mq_free_rq_map(queue->sched_shared_tags);
+	queue->sched_shared_tags = NULL;
 }
 
 /* called in queue's release handler, tagset has gone away */
@@ -546,17 +546,17 @@ static void blk_mq_sched_tags_teardown(struct request_queue *q, unsigned int fla
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->sched_tags) {
-			if (!blk_mq_is_sbitmap_shared(q->tag_set->flags))
+			if (!blk_mq_is_shared_tags(q->tag_set->flags))
 				blk_mq_free_rq_map(hctx->sched_tags);
 			hctx->sched_tags = NULL;
 		}
 	}
 
-	if (blk_mq_is_sbitmap_shared(flags))
-		blk_mq_exit_sched_shared_sbitmap(q);
+	if (blk_mq_is_shared_tags(flags))
+		blk_mq_exit_sched_shared_tags(q);
 }
 
-static int blk_mq_init_sched_shared_sbitmap(struct request_queue *queue)
+static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
 {
 	struct blk_mq_tag_set *set = queue->tag_set;
 
@@ -564,13 +564,13 @@ static int blk_mq_init_sched_shared_sbitmap(struct request_queue *queue)
 	 * Set initial depth at max so that we don't need to reallocate for
 	 * updating nr_requests.
 	 */
-	queue->shared_sbitmap_tags = blk_mq_alloc_map_and_rqs(set,
+	queue->sched_shared_tags = blk_mq_alloc_map_and_rqs(set,
 						BLK_MQ_NO_HCTX_IDX,
 						MAX_SCHED_RQ);
-	if (!queue->shared_sbitmap_tags)
+	if (!queue->sched_shared_tags)
 		return -ENOMEM;
 
-	blk_mq_tag_update_sched_shared_sbitmap(queue);
+	blk_mq_tag_update_sched_shared_tags(queue);
 
 	return 0;
 }
@@ -596,8 +596,8 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
 				   BLKDEV_DEFAULT_RQ);
 
-	if (blk_mq_is_sbitmap_shared(flags)) {
-		ret = blk_mq_init_sched_shared_sbitmap(q);
+	if (blk_mq_is_shared_tags(flags)) {
+		ret = blk_mq_init_sched_shared_tags(q);
 		if (ret)
 			return ret;
 	}
@@ -647,8 +647,8 @@ void blk_mq_sched_free_rqs(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	if (blk_mq_is_sbitmap_shared(q->tag_set->flags)) {
-		blk_mq_free_rqs(q->tag_set, q->shared_sbitmap_tags,
+	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
+		blk_mq_free_rqs(q->tag_set, q->sched_shared_tags,
 				BLK_MQ_NO_HCTX_IDX);
 	} else {
 		queue_for_each_hw_ctx(q, hctx, i) {
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 211068a5f676..72a2724a4eee 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -24,7 +24,7 @@
  */
 bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
-	if (blk_mq_is_sbitmap_shared(hctx->flags)) {
+	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
 
 		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) &&
@@ -57,19 +57,19 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 {
 	struct blk_mq_tags *tags = hctx->tags;
 
-	if (blk_mq_is_sbitmap_shared(hctx->flags)) {
+	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
 
 		if (!test_and_clear_bit(QUEUE_FLAG_HCTX_ACTIVE,
 					&q->queue_flags))
 			return;
-		atomic_dec(&tags->active_queues);
 	} else {
 		if (!test_and_clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 			return;
-		atomic_dec(&tags->active_queues);
 	}
 
+	atomic_dec(&tags->active_queues);
+
 	blk_mq_tag_wakeup_all(tags, false);
 }
 
@@ -557,7 +557,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 		 * Only the sbitmap needs resizing since we allocated the max
 		 * initially.
 		 */
-		if (blk_mq_is_sbitmap_shared(set->flags))
+		if (blk_mq_is_shared_tags(set->flags))
 			return 0;
 
 		new = blk_mq_alloc_map_and_rqs(set, hctx->queue_num, tdepth);
@@ -578,16 +578,16 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 	return 0;
 }
 
-void blk_mq_tag_resize_shared_sbitmap(struct blk_mq_tag_set *set, unsigned int size)
+void blk_mq_tag_resize_shared_tags(struct blk_mq_tag_set *set, unsigned int size)
 {
-	struct blk_mq_tags *tags = set->shared_sbitmap_tags;
+	struct blk_mq_tags *tags = set->shared_tags;
 
 	sbitmap_queue_resize(&tags->bitmap_tags, size - set->reserved_tags);
 }
 
-void blk_mq_tag_update_sched_shared_sbitmap(struct request_queue *q)
+void blk_mq_tag_update_sched_shared_tags(struct request_queue *q)
 {
-	sbitmap_queue_resize(&q->shared_sbitmap_tags->bitmap_tags,
+	sbitmap_queue_resize(&q->sched_shared_tags->bitmap_tags,
 			     q->nr_requests - q->tag_set->reserved_tags);
 }
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 1052d69147ba..d8ce89fa1686 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -43,9 +43,9 @@ extern void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_tags **tags,
 					unsigned int depth, bool can_grow);
-extern void blk_mq_tag_resize_shared_sbitmap(struct blk_mq_tag_set *set,
+extern void blk_mq_tag_resize_shared_tags(struct blk_mq_tag_set *set,
 					     unsigned int size);
-extern void blk_mq_tag_update_sched_shared_sbitmap(struct request_queue *q);
+extern void blk_mq_tag_update_sched_shared_tags(struct request_queue *q);
 
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 11644c67b064..a8c437afc2c3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2228,7 +2228,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		blk_insert_flush(rq);
 		blk_mq_run_hw_queue(data.hctx, true);
 	} else if (plug && (q->nr_hw_queues == 1 ||
-		   blk_mq_is_sbitmap_shared(rq->mq_hctx->flags) ||
+		   blk_mq_is_shared_tags(rq->mq_hctx->flags) ||
 		   q->mq_ops->commit_rqs || !blk_queue_nonrot(q))) {
 		/*
 		 * Use plugging if we have a ->commit_rqs() hook as well, as
@@ -2346,8 +2346,8 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	struct blk_mq_tags *drv_tags;
 	struct page *page;
 
-	if (blk_mq_is_sbitmap_shared(set->flags))
-		drv_tags = set->shared_sbitmap_tags;
+	if (blk_mq_is_shared_tags(set->flags))
+		drv_tags = set->shared_tags;
 	else
 		drv_tags = set->tags[hctx_idx];
 
@@ -2876,8 +2876,8 @@ struct blk_mq_tags *blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
 static bool __blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
 				       int hctx_idx)
 {
-	if (blk_mq_is_sbitmap_shared(set->flags)) {
-		set->tags[hctx_idx] = set->shared_sbitmap_tags;
+	if (blk_mq_is_shared_tags(set->flags)) {
+		set->tags[hctx_idx] = set->shared_tags;
 
 		return true;
 	}
@@ -2901,7 +2901,7 @@ void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 static void __blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 				      unsigned int hctx_idx)
 {
-	if (!blk_mq_is_sbitmap_shared(set->flags))
+	if (!blk_mq_is_shared_tags(set->flags))
 		blk_mq_free_map_and_rqs(set, set->tags[hctx_idx], hctx_idx);
 
 	set->tags[hctx_idx] = NULL;
@@ -3368,11 +3368,11 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 {
 	int i;
 
-	if (blk_mq_is_sbitmap_shared(set->flags)) {
-		set->shared_sbitmap_tags = blk_mq_alloc_map_and_rqs(set,
+	if (blk_mq_is_shared_tags(set->flags)) {
+		set->shared_tags = blk_mq_alloc_map_and_rqs(set,
 						BLK_MQ_NO_HCTX_IDX,
 						set->queue_depth);
-		if (!set->shared_sbitmap_tags)
+		if (!set->shared_tags)
 			return -ENOMEM;
 	}
 
@@ -3388,8 +3388,8 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 	while (--i >= 0)
 		__blk_mq_free_map_and_rqs(set, i);
 
-	if (blk_mq_is_sbitmap_shared(set->flags)) {
-		blk_mq_free_map_and_rqs(set, set->shared_sbitmap_tags,
+	if (blk_mq_is_shared_tags(set->flags)) {
+		blk_mq_free_map_and_rqs(set, set->shared_tags,
 					BLK_MQ_NO_HCTX_IDX);
 	}
 
@@ -3610,8 +3610,8 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 	for (i = 0; i < set->nr_hw_queues; i++)
 		__blk_mq_free_map_and_rqs(set, i);
 
-	if (blk_mq_is_sbitmap_shared(set->flags)) {
-		blk_mq_free_map_and_rqs(set, set->shared_sbitmap_tags,
+	if (blk_mq_is_shared_tags(set->flags)) {
+		blk_mq_free_map_and_rqs(set, set->shared_tags,
 					BLK_MQ_NO_HCTX_IDX);
 	}
 
@@ -3662,11 +3662,11 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	}
 	if (!ret) {
 		q->nr_requests = nr;
-		if (blk_mq_is_sbitmap_shared(set->flags)) {
+		if (blk_mq_is_shared_tags(set->flags)) {
 			if (q->elevator)
-				blk_mq_tag_update_sched_shared_sbitmap(q);
+				blk_mq_tag_update_sched_shared_tags(q);
 			else
-				blk_mq_tag_resize_shared_sbitmap(set, nr);
+				blk_mq_tag_resize_shared_tags(set, nr);
 		}
 	}
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 8824ae03215a..171e8cdcff54 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -157,7 +157,7 @@ struct blk_mq_alloc_data {
 	struct blk_mq_hw_ctx *hctx;
 };
 
-static inline bool blk_mq_is_sbitmap_shared(unsigned int flags)
+static inline bool blk_mq_is_shared_tags(unsigned int flags)
 {
 	return flags & BLK_MQ_F_TAG_HCTX_SHARED;
 }
@@ -217,24 +217,24 @@ static inline int blk_mq_get_rq_budget_token(struct request *rq)
 
 static inline void __blk_mq_inc_active_requests(struct blk_mq_hw_ctx *hctx)
 {
-	if (blk_mq_is_sbitmap_shared(hctx->flags))
-		atomic_inc(&hctx->queue->nr_active_requests_shared_sbitmap);
+	if (blk_mq_is_shared_tags(hctx->flags))
+		atomic_inc(&hctx->queue->nr_active_requests_shared_tags);
 	else
 		atomic_inc(&hctx->nr_active);
 }
 
 static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
 {
-	if (blk_mq_is_sbitmap_shared(hctx->flags))
-		atomic_dec(&hctx->queue->nr_active_requests_shared_sbitmap);
+	if (blk_mq_is_shared_tags(hctx->flags))
+		atomic_dec(&hctx->queue->nr_active_requests_shared_tags);
 	else
 		atomic_dec(&hctx->nr_active);
 }
 
 static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)
 {
-	if (blk_mq_is_sbitmap_shared(hctx->flags))
-		return atomic_read(&hctx->queue->nr_active_requests_shared_sbitmap);
+	if (blk_mq_is_shared_tags(hctx->flags))
+		return atomic_read(&hctx->queue->nr_active_requests_shared_tags);
 	return atomic_read(&hctx->nr_active);
 }
 static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
@@ -328,7 +328,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	if (bt->sb.depth == 1)
 		return true;
 
-	if (blk_mq_is_sbitmap_shared(hctx->flags)) {
+	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
 
 		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
diff --git a/block/elevator.c b/block/elevator.c
index 57be09cd7f6d..1f39f6e8ebb9 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -637,7 +637,7 @@ static struct elevator_type *elevator_get_default(struct request_queue *q)
 		return NULL;
 
 	if (q->nr_hw_queues != 1 &&
-			!blk_mq_is_sbitmap_shared(q->tag_set->flags))
+	    !blk_mq_is_shared_tags(q->tag_set->flags))
 		return NULL;
 
 	return elevator_get(q, "mq-deadline", false);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index faa20a19bfcc..75d75657df21 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -442,9 +442,9 @@ enum hctx_type {
  *		   tag set.
  * @tags:	   Tag sets. One tag set per hardware queue. Has @nr_hw_queues
  *		   elements.
- * @shared_sbitmap_tags:
- *		   Shared sbitmap set of tags. Has @nr_hw_queues elements. If
- *		   set, shared by all @tags.
+ * @shared_tags:
+ *		   Shared set of tags. Has @nr_hw_queues elements. If set,
+ *		   shared by all @tags.
  * @tag_list_lock: Serializes tag_list accesses.
  * @tag_list:	   List of the request queues that use this tag set. See also
  *		   request_queue.tag_set_list.
@@ -464,7 +464,7 @@ struct blk_mq_tag_set {
 
 	struct blk_mq_tags	**tags;
 
-	struct blk_mq_tags	*shared_sbitmap_tags;
+	struct blk_mq_tags	*shared_tags;
 
 	struct mutex		tag_list_lock;
 	struct list_head	tag_list;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index cf92c13eb80e..b19172db7eef 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -236,9 +236,9 @@ struct request_queue {
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
 
-	atomic_t		nr_active_requests_shared_sbitmap;
+	atomic_t		nr_active_requests_shared_tags;
 
-	struct blk_mq_tags	*shared_sbitmap_tags;
+	struct blk_mq_tags	*sched_shared_tags;
 
 	struct list_head	icq_list;
 #ifdef CONFIG_BLK_CGROUP
-- 
2.26.2

