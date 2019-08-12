Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D889FF7
	for <lists+linux-block@lfdr.de>; Mon, 12 Aug 2019 15:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfHLNnw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 12 Aug 2019 09:43:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfHLNnw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 09:43:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED319EEF10;
        Mon, 12 Aug 2019 13:43:51 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13E075C1D4;
        Mon, 12 Aug 2019 13:43:48 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH V2 4/5] blk-mq: re-submit IO in case that hctx is dead
Date:   Mon, 12 Aug 2019 21:43:11 +0800
Message-Id: <20190812134312.16732-5-ming.lei@redhat.com>
In-Reply-To: <20190812134312.16732-1-ming.lei@redhat.com>
References: <20190812134312.16732-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 12 Aug 2019 13:43:52 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When all CPUs in one hctx are offline, we shouldn't run this hw queue
for completing request any more.

So steal bios from the request, and resubmit them, and finally free
the request in blk_mq_hctx_notify_dead().

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6931b2ba2776..ed334fd867c4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2261,10 +2261,30 @@ static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+static void blk_mq_resubmit_io(struct request *rq)
+{
+	struct bio_list list;
+	struct bio *bio;
+
+	bio_list_init(&list);
+	blk_steal_bios(&list, rq);
+
+	while (true) {
+		bio = bio_list_pop(&list);
+		if (!bio)
+			break;
+
+		generic_make_request(bio);
+	}
+
+	blk_mq_cleanup_rq(rq);
+	blk_mq_end_request(rq, 0);
+}
+
 /*
- * 'cpu' is going away. splice any existing rq_list entries from this
- * software queue to the hw queue dispatch list, and ensure that it
- * gets run.
+ * 'cpu' has gone away. If this hctx is dead, we can't dispatch request
+ * to the hctx any more, so steal bios from requests of this hctx, and
+ * re-submit them to the request queue, and free these requests finally.
  */
 static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 {
@@ -2272,6 +2292,8 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	struct blk_mq_ctx *ctx;
 	LIST_HEAD(tmp);
 	enum hctx_type type;
+	bool hctx_dead;
+	struct request *rq;
 
 	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
 	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
@@ -2279,6 +2301,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 
 	clear_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
 
+	hctx_dead = cpumask_first_and(hctx->cpumask, cpu_online_mask) >=
+		nr_cpu_ids;
+
 	spin_lock(&ctx->lock);
 	if (!list_empty(&ctx->rq_lists[type])) {
 		list_splice_init(&ctx->rq_lists[type], &tmp);
@@ -2289,11 +2314,20 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	if (list_empty(&tmp))
 		return 0;
 
-	spin_lock(&hctx->lock);
-	list_splice_tail_init(&tmp, &hctx->dispatch);
-	spin_unlock(&hctx->lock);
+	if (!hctx_dead) {
+		spin_lock(&hctx->lock);
+		list_splice_tail_init(&tmp, &hctx->dispatch);
+		spin_unlock(&hctx->lock);
+		blk_mq_run_hw_queue(hctx, true);
+		return 0;
+	}
+
+	while (!list_empty(&tmp)) {
+		rq = list_entry(tmp.next, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		blk_mq_resubmit_io(rq);
+	}
 
-	blk_mq_run_hw_queue(hctx, true);
 	return 0;
 }
 
-- 
2.20.1

