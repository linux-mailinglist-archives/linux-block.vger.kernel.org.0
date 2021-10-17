Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3727C4305F8
	for <lists+linux-block@lfdr.de>; Sun, 17 Oct 2021 03:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244666AbhJQBkG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 16 Oct 2021 21:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244796AbhJQBkF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:40:05 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CB5C061767
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:57 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id y67so12157842iof.10
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jHDbtDHsjqqwQO86cmJQVVA0iWqfAFLWw2YWksxgxRI=;
        b=kvguSuTXz3Jhj7oEcK5lvAqYPaNA1ZwRn7LHSzB060BX63wQNKDxTNQb93ciA6fGjq
         uT28jqaNgxGM03rz6U37zK/luc4Jf4UjUSuMBJTY7XZR8mioQLTLzPx+p3inUtTYOzc5
         dN29iZACqwJ6TDxNM8+VZQ7bqHO7euNQtLQhcxwEuxKyDGUByLb4v3WUoYC/v550Lc7v
         jmSGzKXeUe/hIZx0EiaAVANdkWyyuufLGj4ZIBPvwFqKzX5fqrW0mGHLd/+2o5LnvIdH
         NqeOxz77YfS1gQVsWi2myDPoHSivsrpelzA53YHbs8Rzf/B2NiYQ33x9FMF7VdUisZUP
         SOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHDbtDHsjqqwQO86cmJQVVA0iWqfAFLWw2YWksxgxRI=;
        b=iyA9jo3/mSDWJwb9b1mtmREHonBYoYqSJMgxv+VvI0pdYayDHz6pxsTi7TgZqYy7c2
         Z80mfTv9EEL37C6g0WCheOFdSRaApPKb2kXf0LQKK49WgN+3KnHYWz74H3fKCQQ48lJK
         +VALsx6mSkHz8346pYt32Qx+vJozOH+X6of0zxGGJ9hG17Uu/tgz+BwOa5AUOkWqMswa
         RAYxC2M8CLymr3mO8RZpcX/kfMZPFDXlkmJSkHa40W3X1ub+3Ynxz36oa8Vi7ACpUHue
         YAmtoaTEv7t1Mctd4TaGDAffnCifoK8z1+CwW9+AkBTE5Pxyz+A2b5RIF/TVJhPO1OSW
         md7Q==
X-Gm-Message-State: AOAM532di5l+qrQ8wgTRM1Ga12ivIVJzL95jiFBdmpf9G32ahWd4jOY1
        x/Za7yZl3GDWJRMP/v4Z/BSpj9Zl5s0p5g==
X-Google-Smtp-Source: ABdhPJwnx01UW+YZvEmo1aOuFKx+1D+xCtGfyou9iZABy6fDD6h2C7xqwDqRvpo+8Yk28vlLVnwTyw==
X-Received: by 2002:a02:b803:: with SMTP id o3mr13482327jam.55.1634434676550;
        Sat, 16 Oct 2021 18:37:56 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm4934383ilq.1.2021.10.16.18.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 18:37:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/14] block: change plugging to use a singly linked list
Date:   Sat, 16 Oct 2021 19:37:41 -0600
Message-Id: <20211017013748.76461-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017013748.76461-1-axboe@kernel.dk>
References: <20211017013748.76461-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use a singly linked list for the blk_plug. This saves 8 bytes in the
blk_plug struct, and makes for faster list manipulations than doubly
linked lists. As we don't use the doubly linked lists for anything,
singly linked is just fine.

This yields a bump in default (merging enabled) performance from 7.0
to 7.1M IOPS, and ~7.5M IOPS with merging disabled.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       |   5 +-
 block/blk-merge.c      |   8 +--
 block/blk-mq.c         | 156 +++++++++++++++++++++++++++--------------
 block/blk.h            |   2 +-
 include/linux/blkdev.h |   6 +-
 5 files changed, 113 insertions(+), 64 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bdc03b80a8d0..fced71948162 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1542,11 +1542,12 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
 	if (tsk->plug)
 		return;
 
-	INIT_LIST_HEAD(&plug->mq_list);
+	plug->mq_list = NULL;
 	plug->cached_rq = NULL;
 	plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
 	plug->rq_count = 0;
 	plug->multiple_queues = false;
+	plug->has_elevator = false;
 	plug->nowait = false;
 	INIT_LIST_HEAD(&plug->cb_list);
 
@@ -1632,7 +1633,7 @@ void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	flush_plug_callbacks(plug, from_schedule);
 
-	if (!list_empty(&plug->mq_list))
+	if (!rq_list_empty(plug->mq_list))
 		blk_mq_flush_plug_list(plug, from_schedule);
 	if (unlikely(!from_schedule && plug->cached_rq))
 		blk_mq_free_plug_rqs(plug);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index ec727234ac48..b3f3e689a5ac 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1085,23 +1085,23 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
  * Caller must ensure !blk_queue_nomerges(q) beforehand.
  */
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
-		unsigned int nr_segs, struct request **same_queue_rq)
+		unsigned int nr_segs, bool *same_queue_rq)
 {
 	struct blk_plug *plug;
 	struct request *rq;
 
 	plug = blk_mq_plug(q, bio);
-	if (!plug || list_empty(&plug->mq_list))
+	if (!plug || rq_list_empty(plug->mq_list))
 		return false;
 
 	/* check the previously added entry for a quick merge attempt */
-	rq = list_last_entry(&plug->mq_list, struct request, queuelist);
+	rq = rq_list_peek(&plug->mq_list);
 	if (rq->q == q && same_queue_rq) {
 		/*
 		 * Only blk-mq multiple hardware queues case checks the rq in
 		 * the same queue, there should be only one such rq in a queue
 		 */
-		*same_queue_rq = rq;
+		*same_queue_rq = true;
 	}
 	if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) == BIO_MERGE_OK)
 		return true;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5d22c228f6df..cd1249284c1f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -19,7 +19,6 @@
 #include <linux/smp.h>
 #include <linux/interrupt.h>
 #include <linux/llist.h>
-#include <linux/list_sort.h>
 #include <linux/cpu.h>
 #include <linux/cache.h>
 #include <linux/sched/sysctl.h>
@@ -2118,54 +2117,100 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	spin_unlock(&ctx->lock);
 }
 
-static int plug_rq_cmp(void *priv, const struct list_head *a,
-		       const struct list_head *b)
+static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 {
-	struct request *rqa = container_of(a, struct request, queuelist);
-	struct request *rqb = container_of(b, struct request, queuelist);
+	struct blk_mq_hw_ctx *hctx = NULL;
+	int queued = 0;
+	int errors = 0;
+
+	while (!rq_list_empty(plug->mq_list)) {
+		struct request *rq;
+		blk_status_t ret;
+
+		rq = rq_list_pop(&plug->mq_list);
 
-	if (rqa->mq_ctx != rqb->mq_ctx)
-		return rqa->mq_ctx > rqb->mq_ctx;
-	if (rqa->mq_hctx != rqb->mq_hctx)
-		return rqa->mq_hctx > rqb->mq_hctx;
+		if (!hctx)
+			hctx = rq->mq_hctx;
+		else if (hctx != rq->mq_hctx && hctx->queue->mq_ops->commit_rqs) {
+			trace_block_unplug(hctx->queue, queued, !from_schedule);
+			hctx->queue->mq_ops->commit_rqs(hctx);
+			queued = 0;
+			hctx = rq->mq_hctx;
+		}
+
+		ret = blk_mq_request_issue_directly(rq,
+						rq_list_empty(plug->mq_list));
+		if (ret != BLK_STS_OK) {
+			if (ret == BLK_STS_RESOURCE ||
+					ret == BLK_STS_DEV_RESOURCE) {
+				blk_mq_request_bypass_insert(rq, false,
+						rq_list_empty(plug->mq_list));
+				break;
+			}
+			blk_mq_end_request(rq, ret);
+			errors++;
+		} else
+			queued++;
+	}
 
-	return blk_rq_pos(rqa) > blk_rq_pos(rqb);
+	/*
+	 * If we didn't flush the entire list, we could have told
+	 * the driver there was more coming, but that turned out to
+	 * be a lie.
+	 */
+	if ((!rq_list_empty(plug->mq_list) || errors) &&
+	     hctx->queue->mq_ops->commit_rqs && queued)
+		hctx->queue->mq_ops->commit_rqs(hctx);
 }
 
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
+	struct blk_mq_hw_ctx *this_hctx;
+	struct blk_mq_ctx *this_ctx;
+	unsigned int depth;
 	LIST_HEAD(list);
 
-	if (list_empty(&plug->mq_list))
+	if (rq_list_empty(plug->mq_list))
 		return;
-	list_splice_init(&plug->mq_list, &list);
-
-	if (plug->rq_count > 2 && plug->multiple_queues)
-		list_sort(NULL, &list, plug_rq_cmp);
-
 	plug->rq_count = 0;
 
+	if (!plug->multiple_queues && !plug->has_elevator) {
+		blk_mq_plug_issue_direct(plug, from_schedule);
+		if (rq_list_empty(plug->mq_list))
+			return;
+	}
+
+	this_hctx = NULL;
+	this_ctx = NULL;
+	depth = 0;
 	do {
-		struct list_head rq_list;
-		struct request *rq, *head_rq = list_entry_rq(list.next);
-		struct list_head *pos = &head_rq->queuelist; /* skip first */
-		struct blk_mq_hw_ctx *this_hctx = head_rq->mq_hctx;
-		struct blk_mq_ctx *this_ctx = head_rq->mq_ctx;
-		unsigned int depth = 1;
-
-		list_for_each_continue(pos, &list) {
-			rq = list_entry_rq(pos);
-			BUG_ON(!rq->q);
-			if (rq->mq_hctx != this_hctx || rq->mq_ctx != this_ctx)
-				break;
-			depth++;
+		struct request *rq;
+
+		rq = rq_list_pop(&plug->mq_list);
+
+		if (!this_hctx) {
+			this_hctx = rq->mq_hctx;
+			this_ctx = rq->mq_ctx;
+		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx) {
+			trace_block_unplug(this_hctx->queue, depth,
+						!from_schedule);
+			blk_mq_sched_insert_requests(this_hctx, this_ctx,
+						&list, from_schedule);
+			depth = 0;
+			this_hctx = rq->mq_hctx;
+			this_ctx = rq->mq_ctx;
+
 		}
 
-		list_cut_before(&rq_list, &list, pos);
-		trace_block_unplug(head_rq->q, depth, !from_schedule);
-		blk_mq_sched_insert_requests(this_hctx, this_ctx, &rq_list,
+		list_add(&rq->queuelist, &list);
+		depth++;
+	} while (!rq_list_empty(plug->mq_list));
+
+	if (!list_empty(&list)) {
+		trace_block_unplug(this_hctx->queue, depth, !from_schedule);
+		blk_mq_sched_insert_requests(this_hctx, this_ctx, &list,
 						from_schedule);
-	} while(!list_empty(&list));
+	}
 }
 
 static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
@@ -2345,16 +2390,17 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 
 static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 {
-	list_add_tail(&rq->queuelist, &plug->mq_list);
-	plug->rq_count++;
-	if (!plug->multiple_queues && !list_is_singular(&plug->mq_list)) {
-		struct request *tmp;
+	if (!plug->multiple_queues) {
+		struct request *nxt = rq_list_peek(&plug->mq_list);
 
-		tmp = list_first_entry(&plug->mq_list, struct request,
-						queuelist);
-		if (tmp->q != rq->q)
+		if (nxt && nxt->q != rq->q)
 			plug->multiple_queues = true;
 	}
+	if (!plug->has_elevator && (rq->rq_flags & RQF_ELV))
+		plug->has_elevator = true;
+	rq->rq_next = NULL;
+	rq_list_add(&plug->mq_list, rq);
+	plug->rq_count++;
 }
 
 /*
@@ -2389,7 +2435,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	const int is_flush_fua = op_is_flush(bio->bi_opf);
 	struct request *rq;
 	struct blk_plug *plug;
-	struct request *same_queue_rq = NULL;
+	bool same_queue_rq = false;
 	unsigned int nr_segs = 1;
 	blk_status_t ret;
 
@@ -2463,15 +2509,17 @@ void blk_mq_submit_bio(struct bio *bio)
 		 * IO may benefit a lot from plug merging.
 		 */
 		unsigned int request_count = plug->rq_count;
-		struct request *last = NULL;
+		struct request *tmp = NULL;
 
-		if (!request_count)
+		if (!request_count) {
 			trace_block_plug(q);
-		else
-			last = list_entry_rq(plug->mq_list.prev);
+		} else if (!blk_queue_nomerges(q)) {
+			tmp = rq_list_peek(&plug->mq_list);
+			if (blk_rq_bytes(tmp) < BLK_PLUG_FLUSH_SIZE)
+				tmp = NULL;
+		}
 
-		if (request_count >= blk_plug_max_rq_count(plug) || (last &&
-		    blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
+		if (request_count >= blk_plug_max_rq_count(plug) || tmp) {
 			blk_flush_plug_list(plug, false);
 			trace_block_plug(q);
 		}
@@ -2481,6 +2529,8 @@ void blk_mq_submit_bio(struct bio *bio)
 		/* Insert the request at the IO scheduler queue */
 		blk_mq_sched_insert_request(rq, false, true, true);
 	} else if (plug && !blk_queue_nomerges(q)) {
+		struct request *first_rq = NULL;
+
 		/*
 		 * We do limited plugging. If the bio can be merged, do that.
 		 * Otherwise the existing request in the plug list will be
@@ -2488,19 +2538,17 @@ void blk_mq_submit_bio(struct bio *bio)
 		 * The plug list might get flushed before this. If that happens,
 		 * the plug list is empty, and same_queue_rq is invalid.
 		 */
-		if (list_empty(&plug->mq_list))
-			same_queue_rq = NULL;
-		if (same_queue_rq) {
-			list_del_init(&same_queue_rq->queuelist);
+		if (!rq_list_empty(plug->mq_list) && same_queue_rq) {
+			first_rq = rq_list_pop(&plug->mq_list);
 			plug->rq_count--;
 		}
 		blk_add_rq_to_plug(plug, rq);
 		trace_block_plug(q);
 
-		if (same_queue_rq) {
+		if (first_rq) {
 			trace_block_unplug(q, 1, true);
-			blk_mq_try_issue_directly(same_queue_rq->mq_hctx,
-						  same_queue_rq);
+			blk_mq_try_issue_directly(first_rq->mq_hctx,
+						  first_rq);
 		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) ||
 		   !rq->mq_hctx->dispatch_busy) {
diff --git a/block/blk.h b/block/blk.h
index fdfaa6896fc4..c15d1ab224b8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -216,7 +216,7 @@ void blk_add_timer(struct request *req);
 void blk_print_req_error(struct request *req, blk_status_t status);
 
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
-		unsigned int nr_segs, struct request **same_queue_rq);
+		unsigned int nr_segs, bool *same_queue_rq);
 bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 			struct bio *bio, unsigned int nr_segs);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 43dda725dcae..c6a6402cb1a1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -727,7 +727,7 @@ extern void blk_set_queue_dying(struct request_queue *);
  * schedule() where blk_schedule_flush_plug() is called.
  */
 struct blk_plug {
-	struct list_head mq_list; /* blk-mq requests */
+	struct request *mq_list; /* blk-mq requests */
 
 	/* if ios_left is > 1, we can batch tag/rq allocations */
 	struct request *cached_rq;
@@ -736,6 +736,7 @@ struct blk_plug {
 	unsigned short rq_count;
 
 	bool multiple_queues;
+	bool has_elevator;
 	bool nowait;
 
 	struct list_head cb_list; /* md requires an unplug callback */
@@ -776,8 +777,7 @@ static inline bool blk_needs_flush_plug(struct task_struct *tsk)
 	struct blk_plug *plug = tsk->plug;
 
 	return plug &&
-		 (!list_empty(&plug->mq_list) ||
-		 !list_empty(&plug->cb_list));
+		 (plug->mq_list || !list_empty(&plug->cb_list));
 }
 
 int blkdev_issue_flush(struct block_device *bdev);
-- 
2.33.1

