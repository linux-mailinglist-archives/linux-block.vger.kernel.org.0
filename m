Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F55BB8ED9
	for <lists+linux-block@lfdr.de>; Fri, 20 Sep 2019 13:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438162AbfITLON (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Sep 2019 07:14:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438154AbfITLOM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Sep 2019 07:14:12 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 967427695D64394DDBBA;
        Fri, 20 Sep 2019 19:14:09 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Sep 2019
 19:13:59 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>,
        <hch@infradead.org>, <keith.busch@intel.com>,
        Yufen Yu <yuyufen@huawei.com>
Subject: [PATCH v3] block: fix null pointer dereference in blk_mq_rq_timed_out()
Date:   Fri, 20 Sep 2019 19:34:04 +0800
Message-ID: <20190920113404.48567-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We got a null pointer deference BUG_ON in blk_mq_rq_timed_out()
as following:

[  108.825472] BUG: kernel NULL pointer dereference, address: 0000000000000040
[  108.827059] PGD 0 P4D 0
[  108.827313] Oops: 0000 [#1] SMP PTI
[  108.827657] CPU: 6 PID: 198 Comm: kworker/6:1H Not tainted 5.3.0-rc8+ #431
[  108.829503] Workqueue: kblockd blk_mq_timeout_work
[  108.829913] RIP: 0010:blk_mq_check_expired+0x258/0x330
[  108.838191] Call Trace:
[  108.838406]  bt_iter+0x74/0x80
[  108.838665]  blk_mq_queue_tag_busy_iter+0x204/0x450
[  108.839074]  ? __switch_to_asm+0x34/0x70
[  108.839405]  ? blk_mq_stop_hw_queue+0x40/0x40
[  108.839823]  ? blk_mq_stop_hw_queue+0x40/0x40
[  108.840273]  ? syscall_return_via_sysret+0xf/0x7f
[  108.840732]  blk_mq_timeout_work+0x74/0x200
[  108.841151]  process_one_work+0x297/0x680
[  108.841550]  worker_thread+0x29c/0x6f0
[  108.841926]  ? rescuer_thread+0x580/0x580
[  108.842344]  kthread+0x16a/0x1a0
[  108.842666]  ? kthread_flush_work+0x170/0x170
[  108.843100]  ret_from_fork+0x35/0x40

The bug is caused by the race between timeout handle and completion for
flush request.

When timeout handle function blk_mq_rq_timed_out() try to read
'req->q->mq_ops', the 'req' have completed and reinitiated by next
flush request, which would call blk_rq_init() to clear 'req' as 0.

After commit 12f5b93145 ("blk-mq: Remove generation seqeunce"),
normal requests lifetime are protected by refcount. Until 'rq->ref'
drop to zero, the request can really be free. Thus, these requests
cannot been reused before timeout handle finish.

However, flush request has defined .end_io and rq->end_io() is still
called even if 'rq->ref' doesn't drop to zero. After that, the 'flush_rq'
can be reused by the next flush request handle, resulting in null
pointer deference BUG ON.

We fix this problem by covering flush request with 'rq->ref'.
If the refcount is not zero, flush_end_io() return and wait the
last holder recall it. To record the request status, we add a new
entry 'rq_status', which will be used in flush_end_io().

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-flush.c | 8 ++++++++
 block/blk-mq.c    | 5 ++++-
 block/blk.h       | 7 +++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index aedd9320e605..f3ef6ce05c78 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -212,6 +212,14 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
 	struct blk_mq_hw_ctx *hctx;
 
+	if (!refcount_dec_and_test(&flush_rq->ref)) {
+		fq->rq_status = error;
+		return;
+	}
+
+	if (fq->rq_status != BLK_STS_OK)
+		error = fq->rq_status;
+
 	/* release the tag's ownership to the req cloned from */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
 	hctx = flush_rq->mq_hctx;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0835f4d8d42e..eec2ec4c79bd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -905,7 +905,10 @@ static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	 */
 	if (blk_mq_req_expired(rq, next))
 		blk_mq_rq_timed_out(rq, reserved);
-	if (refcount_dec_and_test(&rq->ref))
+
+	if (is_flush_rq(rq, hctx))
+		rq->end_io(rq, 0);
+	else if (refcount_dec_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
 
 	return true;
diff --git a/block/blk.h b/block/blk.h
index de6b2e146d6e..d3ed80f144c6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -30,6 +30,7 @@ struct blk_flush_queue {
 	 */
 	struct request		*orig_rq;
 	spinlock_t		mq_flush_lock;
+	blk_status_t 		rq_status;
 };
 
 extern struct kmem_cache *blk_requestq_cachep;
@@ -47,6 +48,12 @@ static inline void __blk_get_queue(struct request_queue *q)
 	kobject_get(&q->kobj);
 }
 
+static inline bool
+is_flush_rq(struct request *req, struct blk_mq_hw_ctx *hctx)
+{
+	return hctx->fq->flush_rq == req;
+}
+
 struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
 		int node, int cmd_size, gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
-- 
2.17.2

