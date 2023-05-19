Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1100708EEA
	for <lists+linux-block@lfdr.de>; Fri, 19 May 2023 06:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjESElT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 19 May 2023 00:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjESElS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 00:41:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12EB10D2
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 21:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CRsdm81PCIjEz6U3W0MKKMMlYN7yH8GEpPhS0HFg2Co=; b=U7zuGrQwsSV+0ZnL8ZnpZpWvxY
        AZfqd/5VXrAuB0FbORGn8EUivYsB2uYAwn8ErJas766hiycp47lAlkdpiBHW4do/jef8aUf60wGU0
        Z3EG1x+dilmOZphkI5zfvae8tb2Iy/GweDwZRkLe8z2VdWGMu5FeH8q7UzyH6TUa1zaauvmppO1xD
        EKSrg52cXhjw27ibMmlJQdilnWweyAOd7nWpb3NFDxP0KaJyxXmfd3OL6SNr4G2BY3Z4xeAdKjkf4
        wYlpDqRh1jkthwg6W7It+DXYmu0sduvefnxVPDpj3XuoGpF4Omut1ydXVgIkcEMzVOa12QOzWfhoC
        2plsWUNg==;
Received: from [2001:4bb8:188:3dd5:8711:951c:9ab6:1400] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzrvW-00F4Zt-0j;
        Fri, 19 May 2023 04:41:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 7/7] blk-mq: don't use the requeue list to queue flush commands
Date:   Fri, 19 May 2023 06:40:50 +0200
Message-Id: <20230519044050.107790-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519044050.107790-1-hch@lst.de>
References: <20230519044050.107790-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently both requeues of commands that were already sent to the
driver and flush commands submitted from the flush state machine
share the same requeue_list struct request_queue, despite requeues
doing head insertations and flushes not.  Switch to using two
separate lists instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-flush.c      |  9 +++++++--
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         | 42 +++++++++++++-----------------------------
 block/blk-mq.h         |  1 -
 include/linux/blk-mq.h |  4 +---
 include/linux/blkdev.h |  1 +
 6 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index f407a59503173d..dba392cf22bec6 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -188,7 +188,9 @@ static void blk_flush_complete_seq(struct request *rq,
 
 	case REQ_FSEQ_DATA:
 		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
-		blk_mq_add_to_requeue_list(rq, 0);
+		spin_lock(&q->requeue_lock);
+		list_add_tail(&rq->queuelist, &q->flush_list);
+		spin_unlock(&q->requeue_lock);
 		blk_mq_kick_requeue_list(q);
 		break;
 
@@ -346,7 +348,10 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	smp_wmb();
 	req_ref_set(flush_rq, 1);
 
-	blk_mq_add_to_requeue_list(flush_rq, 0);
+	spin_lock(&q->requeue_lock);
+	list_add_tail(&flush_rq->queuelist, &q->flush_list);
+	spin_unlock(&q->requeue_lock);
+
 	blk_mq_kick_requeue_list(q);
 }
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 22e39b9a77ecf2..68165a50951b68 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -244,7 +244,6 @@ static const char *const cmd_flag_name[] = {
 #define RQF_NAME(name) [ilog2((__force u32)RQF_##name)] = #name
 static const char *const rqf_name[] = {
 	RQF_NAME(STARTED),
-	RQF_NAME(SOFTBARRIER),
 	RQF_NAME(FLUSH_SEQ),
 	RQF_NAME(MIXED_MERGE),
 	RQF_NAME(MQ_INFLIGHT),
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aac67bc3d3680c..551e7760f45e20 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1416,13 +1416,16 @@ static void __blk_mq_requeue_request(struct request *rq)
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 {
 	struct request_queue *q = rq->q;
+	unsigned long flags;
 
 	__blk_mq_requeue_request(rq);
 
 	/* this request will be re-inserted to io scheduler queue */
 	blk_mq_sched_requeue_request(rq);
 
-	blk_mq_add_to_requeue_list(rq, BLK_MQ_INSERT_AT_HEAD);
+	spin_lock_irqsave(&q->requeue_lock, flags);
+	list_add_tail(&rq->queuelist, &q->requeue_list);
+	spin_unlock_irqrestore(&q->requeue_lock, flags);
 
 	if (kick_requeue_list)
 		blk_mq_kick_requeue_list(q);
@@ -1434,13 +1437,16 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	struct request_queue *q =
 		container_of(work, struct request_queue, requeue_work.work);
 	LIST_HEAD(rq_list);
-	struct request *rq, *next;
+	LIST_HEAD(flush_list);
+	struct request *rq;
 
 	spin_lock_irq(&q->requeue_lock);
 	list_splice_init(&q->requeue_list, &rq_list);
+	list_splice_init(&q->flush_list, &flush_list);
 	spin_unlock_irq(&q->requeue_lock);
 
-	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
+	while (!list_empty(&rq_list)) {
+		rq = list_entry(rq_list.next, struct request, queuelist);
 		/*
 		 * If RQF_DONTPREP ist set, the request has been started by the
 		 * driver already and might have driver-specific data allocated
@@ -1448,18 +1454,16 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		 * block layer merges for the request.
 		 */
 		if (rq->rq_flags & RQF_DONTPREP) {
-			rq->rq_flags &= ~RQF_SOFTBARRIER;
 			list_del_init(&rq->queuelist);
 			blk_mq_request_bypass_insert(rq, 0);
-		} else if (rq->rq_flags & RQF_SOFTBARRIER) {
-			rq->rq_flags &= ~RQF_SOFTBARRIER;
+		} else {
 			list_del_init(&rq->queuelist);
 			blk_mq_insert_request(rq, BLK_MQ_INSERT_AT_HEAD);
 		}
 	}
 
-	while (!list_empty(&rq_list)) {
-		rq = list_entry(rq_list.next, struct request, queuelist);
+	while (!list_empty(&flush_list)) {
+		rq = list_entry(flush_list.next, struct request, queuelist);
 		list_del_init(&rq->queuelist);
 		blk_mq_insert_request(rq, 0);
 	}
@@ -1467,27 +1471,6 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	blk_mq_run_hw_queues(q, false);
 }
 
-void blk_mq_add_to_requeue_list(struct request *rq, blk_insert_t insert_flags)
-{
-	struct request_queue *q = rq->q;
-	unsigned long flags;
-
-	/*
-	 * We abuse this flag that is otherwise used by the I/O scheduler to
-	 * request head insertion from the workqueue.
-	 */
-	BUG_ON(rq->rq_flags & RQF_SOFTBARRIER);
-
-	spin_lock_irqsave(&q->requeue_lock, flags);
-	if (insert_flags & BLK_MQ_INSERT_AT_HEAD) {
-		rq->rq_flags |= RQF_SOFTBARRIER;
-		list_add(&rq->queuelist, &q->requeue_list);
-	} else {
-		list_add_tail(&rq->queuelist, &q->requeue_list);
-	}
-	spin_unlock_irqrestore(&q->requeue_lock, flags);
-}
-
 void blk_mq_kick_requeue_list(struct request_queue *q)
 {
 	kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &q->requeue_work, 0);
@@ -4239,6 +4222,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	blk_mq_update_poll_flag(q);
 
 	INIT_DELAYED_WORK(&q->requeue_work, blk_mq_requeue_work);
+	INIT_LIST_HEAD(&q->flush_list);
 	INIT_LIST_HEAD(&q->requeue_list);
 	spin_lock_init(&q->requeue_lock);
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index ec7d2fb0b3c8ef..8c642e9f32f102 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -47,7 +47,6 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
 bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *,
 			     unsigned int);
-void blk_mq_add_to_requeue_list(struct request *rq, blk_insert_t insert_flags);
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 935201c8974371..d778cb6b211233 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -28,8 +28,6 @@ typedef __u32 __bitwise req_flags_t;
 
 /* drive already may have started this one */
 #define RQF_STARTED		((__force req_flags_t)(1 << 1))
-/* may not be passed by ioscheduler */
-#define RQF_SOFTBARRIER		((__force req_flags_t)(1 << 3))
 /* request for flush sequence */
 #define RQF_FLUSH_SEQ		((__force req_flags_t)(1 << 4))
 /* merge of different types, fail separately */
@@ -65,7 +63,7 @@ typedef __u32 __bitwise req_flags_t;
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
-	(RQF_STARTED | RQF_SOFTBARRIER | RQF_FLUSH_SEQ | RQF_SPECIAL_PAYLOAD)
+	(RQF_STARTED | RQF_FLUSH_SEQ | RQF_SPECIAL_PAYLOAD)
 
 enum mq_rq_state {
 	MQ_RQ_IDLE		= 0,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3952c52d6cd1b0..fe99948688dfda 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -487,6 +487,7 @@ struct request_queue {
 	 * for flush operations
 	 */
 	struct blk_flush_queue	*fq;
+	struct list_head	flush_list;
 
 	struct list_head	requeue_list;
 	spinlock_t		requeue_lock;
-- 
2.39.2

