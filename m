Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EA478720D
	for <lists+linux-block@lfdr.de>; Thu, 24 Aug 2023 16:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbjHXOpc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 24 Aug 2023 10:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241733AbjHXOpL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2023 10:45:11 -0400
Received: from out-39.mta1.migadu.com (out-39.mta1.migadu.com [IPv6:2001:41d0:203:375::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F68F1BC5
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2023 07:45:09 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692888307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPF+c1DJ7XmvhtLIn8XJOXXiqYrgAJHZCAQvWuMIHRQ=;
        b=PtBO8GhDb7ozEtU9kP2iVRjbUhhPDrVqhXJ12tWghz4MV8Z/vLY50fEpBZ7YsatVtjEQMW
        fQBcJ0VvKSXqaNK2AYY/nPNI2Ych8r8jnsvEavHhFq3vkhhF7eQc24BK8DJbw4dHLUbTm7
        tR47+vDLlad1Vrwe7GOF2+A7+qMCfLs=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org, kbusch@kernel.org
Cc:     mst@redhat.com, sagi@grimberg.me, damien.lemoal@opensource.wdc.com,
        kch@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: [PATCH 1/6] blk-mq: account active requests when get driver tag
Date:   Thu, 24 Aug 2023 22:43:58 +0800
Message-ID: <20230824144403.2135739-2-chengming.zhou@linux.dev>
In-Reply-To: <20230824144403.2135739-1-chengming.zhou@linux.dev>
References: <20230824144403.2135739-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

There is a limit that batched queue_rqs() can't work on shared tags
queue, since the account of active requests can't be done there.

Now we account the active requests only in blk_mq_get_driver_tag(),
which is not the time we get driver tag actually (with none elevator).

To support batched queue_rqs() on shared tags queue, we move the
account of active requests to where we get the driver tag:

1. none elevator: blk_mq_get_tags() and blk_mq_get_tag()
2. other elevator: __blk_mq_alloc_driver_tag()

This is clearer and match with the unaccount side, which just happen
when we put the driver tag.

The other good point is that we don't need RQF_MQ_INFLIGHT trick
anymore, which used to avoid double account of flush request.
Now we only account when actually get the driver tag, so all is good.
We will remove RQF_MQ_INFLIGHT in the next patch.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 33 +++++++++++------------------
 block/blk-mq.h | 56 ++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 53 insertions(+), 36 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ec922c6bccbe..bcdb750ef575 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -426,6 +426,8 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
 		rq_list_add(data->cached_rq, rq);
 		nr++;
 	}
+	if (!(data->rq_flags & RQF_SCHED_TAGS))
+		blk_mq_add_active_requests(data->hctx, nr);
 	/* caller already holds a reference, add for remainder */
 	percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
 	data->nr_tags -= nr;
@@ -510,6 +512,8 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		goto retry;
 	}
 
+	if (!(data->rq_flags & RQF_SCHED_TAGS))
+		blk_mq_inc_active_requests(data->hctx);
 	rq = blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag);
 	blk_mq_rq_time_init(rq, alloc_time_ns);
 	return rq;
@@ -669,6 +673,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	tag = blk_mq_get_tag(&data);
 	if (tag == BLK_MQ_NO_TAG)
 		goto out_queue_exit;
+	if (!(data.rq_flags & RQF_SCHED_TAGS))
+		blk_mq_inc_active_requests(data.hctx);
 	rq = blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag);
 	blk_mq_rq_time_init(rq, alloc_time_ns);
 	rq->__data_len = 0;
@@ -708,11 +714,10 @@ static void __blk_mq_free_request(struct request *rq)
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
 
-	if (rq->rq_flags & RQF_MQ_INFLIGHT)
-		__blk_mq_dec_active_requests(hctx);
-
-	if (rq->tag != BLK_MQ_NO_TAG)
+	if (rq->tag != BLK_MQ_NO_TAG) {
+		blk_mq_dec_active_requests(hctx);
 		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
+	}
 	if (sched_tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
 	blk_mq_sched_restart(hctx);
@@ -1065,8 +1070,7 @@ static inline void blk_mq_flush_tag_batch(struct blk_mq_hw_ctx *hctx,
 	 * All requests should have been marked as RQF_MQ_INFLIGHT, so
 	 * update hctx->nr_active in batch
 	 */
-	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		__blk_mq_sub_active_requests(hctx, nr_tags);
+	blk_mq_sub_active_requests(hctx, nr_tags);
 
 	blk_mq_put_tags(hctx->tags, tag_array, nr_tags);
 	percpu_ref_put_many(&q->q_usage_counter, nr_tags);
@@ -1748,7 +1752,7 @@ struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 	return data.rq;
 }
 
-static bool __blk_mq_alloc_driver_tag(struct request *rq)
+bool __blk_mq_alloc_driver_tag(struct request *rq)
 {
 	struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
 	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
@@ -1769,20 +1773,7 @@ static bool __blk_mq_alloc_driver_tag(struct request *rq)
 		return false;
 
 	rq->tag = tag + tag_offset;
-	return true;
-}
-
-bool __blk_mq_get_driver_tag(struct blk_mq_hw_ctx *hctx, struct request *rq)
-{
-	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_alloc_driver_tag(rq))
-		return false;
-
-	if ((hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED) &&
-			!(rq->rq_flags & RQF_MQ_INFLIGHT)) {
-		rq->rq_flags |= RQF_MQ_INFLIGHT;
-		__blk_mq_inc_active_requests(hctx);
-	}
-	hctx->tags->rqs[rq->tag] = rq;
+	blk_mq_inc_active_requests(rq->mq_hctx);
 	return true;
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 1743857e0b01..560a76df290a 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -271,12 +271,18 @@ static inline int blk_mq_get_rq_budget_token(struct request *rq)
 	return -1;
 }
 
-static inline void __blk_mq_inc_active_requests(struct blk_mq_hw_ctx *hctx)
+static inline void __blk_mq_add_active_requests(struct blk_mq_hw_ctx *hctx,
+						int val)
 {
 	if (blk_mq_is_shared_tags(hctx->flags))
-		atomic_inc(&hctx->queue->nr_active_requests_shared_tags);
+		atomic_add(val, &hctx->queue->nr_active_requests_shared_tags);
 	else
-		atomic_inc(&hctx->nr_active);
+		atomic_add(val, &hctx->nr_active);
+}
+
+static inline void __blk_mq_inc_active_requests(struct blk_mq_hw_ctx *hctx)
+{
+	__blk_mq_add_active_requests(hctx, 1);
 }
 
 static inline void __blk_mq_sub_active_requests(struct blk_mq_hw_ctx *hctx,
@@ -293,6 +299,32 @@ static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
 	__blk_mq_sub_active_requests(hctx, 1);
 }
 
+static inline void blk_mq_add_active_requests(struct blk_mq_hw_ctx *hctx,
+					      int val)
+{
+	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+		__blk_mq_add_active_requests(hctx, val);
+}
+
+static inline void blk_mq_inc_active_requests(struct blk_mq_hw_ctx *hctx)
+{
+	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+		__blk_mq_inc_active_requests(hctx);
+}
+
+static inline void blk_mq_sub_active_requests(struct blk_mq_hw_ctx *hctx,
+					      int val)
+{
+	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+		__blk_mq_sub_active_requests(hctx, val);
+}
+
+static inline void blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
+{
+	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+		__blk_mq_dec_active_requests(hctx);
+}
+
 static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)
 {
 	if (blk_mq_is_shared_tags(hctx->flags))
@@ -302,13 +334,9 @@ static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)
 static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 					   struct request *rq)
 {
+	blk_mq_dec_active_requests(hctx);
 	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
 	rq->tag = BLK_MQ_NO_TAG;
-
-	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
-		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
-		__blk_mq_dec_active_requests(hctx);
-	}
 }
 
 static inline void blk_mq_put_driver_tag(struct request *rq)
@@ -319,19 +347,17 @@ static inline void blk_mq_put_driver_tag(struct request *rq)
 	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
 }
 
-bool __blk_mq_get_driver_tag(struct blk_mq_hw_ctx *hctx, struct request *rq);
+bool __blk_mq_alloc_driver_tag(struct request *rq);
 
 static inline bool blk_mq_get_driver_tag(struct request *rq)
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
-	if (rq->tag != BLK_MQ_NO_TAG &&
-	    !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
-		hctx->tags->rqs[rq->tag] = rq;
-		return true;
-	}
+	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_alloc_driver_tag(rq))
+		return false;
 
-	return __blk_mq_get_driver_tag(hctx, rq);
+	hctx->tags->rqs[rq->tag] = rq;
+	return true;
 }
 
 static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
-- 
2.41.0

