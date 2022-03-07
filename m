Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7584CF231
	for <lists+linux-block@lfdr.de>; Mon,  7 Mar 2022 07:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiCGGrM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 7 Mar 2022 01:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiCGGrM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 01:47:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D6E34550E
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 22:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646635577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ScCB02af3R2HqCptgqeV4oLkWDvKnuI/PkuSfpl1gUY=;
        b=hW8cw09VzjpWQTPQ+PopJKZBbRDVvUmoWLDq4JXU2W4vhipiuXVF1VSJVENBDatstEgmXs
        sIcfKUnNtvYt7DhlJ/3qF83eQKfL4XtWF0IeJCGf2kb15GcGFk0lwtRPFuxnUKjyxs/YvT
        zZSgUpKxZyqqX5kLkYCbRuhW4DgsRN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-ANClvDicNmu-9soVfguKkA-1; Mon, 07 Mar 2022 01:46:13 -0500
X-MC-Unique: ANClvDicNmu-9soVfguKkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C190D1091DA0;
        Mon,  7 Mar 2022 06:46:12 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB5DBE2F7;
        Mon,  7 Mar 2022 06:45:59 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 6/6] blk-mq: manage hctx map via xarray
Date:   Mon,  7 Mar 2022 14:44:01 +0800
Message-Id: <20220307064401.30056-7-ming.lei@redhat.com>
In-Reply-To: <20220307064401.30056-1-ming.lei@redhat.com>
References: <20220307064401.30056-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Firstly code becomes more clean by switching to xarray from plain array.

Secondly use-after-free on q->queue_hw_ctx can be fixed because
queue_for_each_hw_ctx() may be run when updating nr_hw_queues is
in-progress. With this patch, q->hctx_table is defined as xarray, and
this structure will share same lifetime with request queue, so
queue_for_each_hw_ctx() can use q->hctx_table to lookup hctx reliably.

Reported-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c     |  2 +-
 block/blk-mq.c         | 55 ++++++++++++++++++------------------------
 block/blk-mq.h         |  2 +-
 include/linux/blk-mq.h |  3 +--
 include/linux/blkdev.h |  2 +-
 5 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 1850a4225e12..68ac23d0b640 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -498,7 +498,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 		void *priv)
 {
 	/*
-	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
+	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and hctx_table
 	 * while the queue is frozen. So we can use q_usage_counter to avoid
 	 * racing with it.
 	 */
diff --git a/block/blk-mq.c b/block/blk-mq.c
index bffdd71c670d..a15d12fb227c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -71,7 +71,8 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
 static inline struct blk_mq_hw_ctx *blk_qc_to_hctx(struct request_queue *q,
 		blk_qc_t qc)
 {
-	return q->queue_hw_ctx[(qc & ~BLK_QC_T_INTERNAL) >> BLK_QC_T_SHIFT];
+	return xa_load(&q->hctx_table,
+			(qc & ~BLK_QC_T_INTERNAL) >> BLK_QC_T_SHIFT);
 }
 
 static inline struct request *blk_qc_to_rq(struct blk_mq_hw_ctx *hctx,
@@ -573,7 +574,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	 * If not tell the caller that it should skip this queue.
 	 */
 	ret = -EXDEV;
-	data.hctx = q->queue_hw_ctx[hctx_idx];
+	data.hctx = xa_load(&q->hctx_table, hctx_idx);
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
@@ -3437,6 +3438,8 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 
 	blk_mq_remove_cpuhp(hctx);
 
+	xa_erase(&q->hctx_table, hctx_idx);
+
 	spin_lock(&q->unused_hctx_lock);
 	list_add(&hctx->hctx_list, &q->unused_hctx_list);
 	spin_unlock(&q->unused_hctx_lock);
@@ -3476,8 +3479,15 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx,
 				hctx->numa_node))
 		goto exit_hctx;
+
+	if (xa_insert(&q->hctx_table, hctx_idx, hctx, GFP_KERNEL))
+		goto exit_flush_rq;
+
 	return 0;
 
+ exit_flush_rq:
+	if (set->ops->exit_request)
+		set->ops->exit_request(set, hctx->fq->flush_rq, hctx_idx);
  exit_hctx:
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
@@ -3856,7 +3866,7 @@ void blk_mq_release(struct request_queue *q)
 		kobject_put(&hctx->kobj);
 	}
 
-	kfree(q->queue_hw_ctx);
+	xa_destroy(&q->hctx_table);
 
 	/*
 	 * release .mq_kobj and sw queue's kobject now because
@@ -3946,45 +3956,28 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 						struct request_queue *q)
 {
 	int i, j, end;
-	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
-
-	if (q->nr_hw_queues < set->nr_hw_queues) {
-		struct blk_mq_hw_ctx **new_hctxs;
-
-		new_hctxs = kcalloc_node(set->nr_hw_queues,
-				       sizeof(*new_hctxs), GFP_KERNEL,
-				       set->numa_node);
-		if (!new_hctxs)
-			return;
-		if (hctxs)
-			memcpy(new_hctxs, hctxs, q->nr_hw_queues *
-			       sizeof(*hctxs));
-		q->queue_hw_ctx = new_hctxs;
-		kfree(hctxs);
-		hctxs = new_hctxs;
-	}
 
 	/* protect against switching io scheduler  */
 	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		int old_node;
 		int node = blk_mq_get_hctx_node(set, i);
-		struct blk_mq_hw_ctx *old_hctx = hctxs[i];
+		struct blk_mq_hw_ctx *old_hctx = xa_load(&q->hctx_table, i);
 
 		if (old_hctx) {
 			old_node = old_hctx->numa_node;
 			blk_mq_exit_hctx(q, set, old_hctx, i);
 		}
 
-		hctxs[i] = blk_mq_alloc_and_init_hctx(set, q, i, node);
-		if (!hctxs[i]) {
+		if (!blk_mq_alloc_and_init_hctx(set, q, i, node)) {
+			struct blk_mq_hw_ctx *hctx;
+
 			if (!old_hctx)
 				break;
 			pr_warn("Allocate new hctx on node %d fails, fallback to previous one on node %d\n",
 					node, old_node);
-			hctxs[i] = blk_mq_alloc_and_init_hctx(set, q, i,
-					old_node);
-			WARN_ON_ONCE(!hctxs[i]);
+			hctx = blk_mq_alloc_and_init_hctx(set, q, i, old_node);
+			WARN_ON_ONCE(!hctx);
 		}
 	}
 	/*
@@ -4001,12 +3994,10 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	}
 
 	for (; j < end; j++) {
-		struct blk_mq_hw_ctx *hctx = hctxs[j];
+		struct blk_mq_hw_ctx *hctx = xa_load(&q->hctx_table, j);
 
-		if (hctx) {
+		if (hctx)
 			blk_mq_exit_hctx(q, set, hctx, j);
-			hctxs[j] = NULL;
-		}
 	}
 	mutex_unlock(&q->sysfs_lock);
 }
@@ -4046,6 +4037,8 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	INIT_LIST_HEAD(&q->unused_hctx_list);
 	spin_lock_init(&q->unused_hctx_lock);
 
+	xa_init(&q->hctx_table);
+
 	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
@@ -4075,7 +4068,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	return 0;
 
 err_hctxs:
-	kfree(q->queue_hw_ctx);
+	xa_destroy(&q->hctx_table);
 	q->nr_hw_queues = 0;
 	blk_mq_sysfs_deinit(q);
 err_poll:
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 948791ea2a3e..2615bd58bad3 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -83,7 +83,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
 							  enum hctx_type type,
 							  unsigned int cpu)
 {
-	return q->queue_hw_ctx[q->tag_set->map[type].mq_map[cpu]];
+	return xa_load(&q->hctx_table, q->tag_set->map[type].mq_map[cpu]);
 }
 
 static inline enum hctx_type blk_mq_get_hctx_type(unsigned int flags)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3a41d50b85d3..7aa5c54901a9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -917,8 +917,7 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 }
 
 #define queue_for_each_hw_ctx(q, hctx, i)				\
-	for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
-	     ({ hctx = (q)->queue_hw_ctx[i]; 1; }); (i)++)
+	xa_for_each(&(q)->hctx_table, (i), (hctx))
 
 #define hctx_for_each_ctx(hctx, ctx, i)					\
 	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f757f9c2871f..a53ae40aaded 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -355,7 +355,7 @@ struct request_queue {
 	unsigned int		queue_depth;
 
 	/* hw dispatch queues */
-	struct blk_mq_hw_ctx	**queue_hw_ctx;
+	struct xarray		hctx_table;
 	unsigned int		nr_hw_queues;
 
 	/*
-- 
2.31.1

