Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1D6361AFC
	for <lists+linux-block@lfdr.de>; Fri, 16 Apr 2021 10:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbhDPIBD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 16 Apr 2021 04:01:03 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:60985 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237986AbhDPIBD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 04:01:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UVj6W0l_1618560037;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UVj6W0l_1618560037)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Apr 2021 16:00:37 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     ming.lei@redhat.com, snitzer@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH] block: introduce QUEUE_FLAG_POLL_CAP flag
Date:   Fri, 16 Apr 2021 16:00:37 +0800
Message-Id: <20210416080037.26335-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210401021927.343727-12-ming.lei@redhat.com>
References: <20210401021927.343727-12-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
How about this patch to remove the extra poll_capable() method?

And the following 'dm: support IO polling for bio-based dm device' needs
following change.

```
+       /*
+        * Check for request-based device is remained to
+        * dm_mq_init_request_queue()->blk_mq_init_allocated_queue().
+        * For bio-based device, only set QUEUE_FLAG_POLL when all underlying
+        * devices supporting polling.
+        */
+       if (__table_type_bio_based(t->type)) {
+               if (dm_table_supports_poll(t)) {
+                       blk_queue_flag_set(QUEUE_FLAG_POLL_CAP, q);
+                       blk_queue_flag_set(QUEUE_FLAG_POLL, q);
+               }
+               else {
+                       blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
+                       blk_queue_flag_clear(QUEUE_FLAG_POLL_CAP, q);
+               }
+       }
```


Introduce QUEUE_FLAG_POLL_CAP flag, indicating if the device supports IO
polling or not. Thus both blk-mq and bio-based device could set this
flag at the initialization phase, and then only this flag needs to be
checked instead of rechecking if the device has the ability of IO
polling when enabling IO polling via sysfs.

For NVMe, the ability of IO polling may change after RESET, since
nvme.poll_queues module parameter may change. Thus the ability of IO
polling need to be rechecked after RESET.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 block/blk-mq.c           |  5 +++--
 block/blk-sysfs.c        |  3 +--
 drivers/nvme/host/core.c |  2 ++
 include/linux/blk-mq.h   | 12 ++++++++++++
 include/linux/blkdev.h   |  2 ++
 5 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 414f5d99d9de..55ef6b975169 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3227,9 +3227,10 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->tag_set = set;
 
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
-	if (set->nr_maps > HCTX_TYPE_POLL &&
-	    set->map[HCTX_TYPE_POLL].nr_queues)
+	if (blk_mq_poll_capable(set)) {
+		blk_queue_flag_set(QUEUE_FLAG_POLL_CAP, q);
 		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
+	}
 
 	q->sg_reserved_size = INT_MAX;
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index db3268d41274..64f0ab84b606 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -426,8 +426,7 @@ static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 	unsigned long poll_on;
 	ssize_t ret;
 
-	if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL ||
-	    !q->tag_set->map[HCTX_TYPE_POLL].nr_queues)
+	if(!blk_queue_poll_cap(q))
 		return -EINVAL;
 
 	ret = queue_var_store(&poll_on, page, count);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bb7da34dd967..5344cc877b05 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2210,6 +2210,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
+	blk_mq_check_poll(ns->disk->queue, ns->disk->queue->tag_set);
+
 	ret = nvme_configure_metadata(ns, id);
 	if (ret)
 		goto out_unfreeze;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2c473c9b8990..ee4c89c8bebc 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -618,4 +618,16 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio);
 void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
 		struct lock_class_key *key);
 
+static inline bool blk_mq_poll_capable(struct blk_mq_tag_set *set)
+{
+	return set->nr_maps > HCTX_TYPE_POLL &&
+	       set->map[HCTX_TYPE_POLL].nr_queues;
+}
+
+static inline void blk_mq_check_poll(struct request_queue *q,
+				     struct blk_mq_tag_set *set)
+{
+	if (blk_mq_poll_capable(set))
+		blk_queue_flag_set(QUEUE_FLAG_POLL_CAP, q);
+}
 #endif
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1e88116dc070..d192a106bf40 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -621,6 +621,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_POLL_CAP     30	/* device supports IO polling */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -668,6 +669,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
 #define blk_queue_poll(q)	test_bit(QUEUE_FLAG_POLL, &(q)->queue_flags)
+#define blk_queue_poll_cap(q)	test_bit(QUEUE_FLAG_POLL_CAP, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.27.0

