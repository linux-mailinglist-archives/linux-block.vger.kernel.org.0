Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B62E9127
	for <lists+linux-block@lfdr.de>; Tue, 29 Oct 2019 21:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfJ2U7I (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 29 Oct 2019 16:59:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54926 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfJ2U7I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 16:59:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 1C94628DE5D
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, kernel@collabora.com, krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2] blk-mq: Document functions for sending request
Date:   Tue, 29 Oct 2019 17:57:33 -0300
Message-Id: <20191029205733.86697-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add or improve documentation for function regarding creating and sending
IO requests to the hardware.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Hello,

I did my best to describe all variations of *_run_hw_queue, although
their names and functionally are really similar. I would be happy to get
feedback about those functions descriptions.

Those comments were tested with:

./scripts/kernel-doc -none block/blk-mq.c

Which did not returned any warning or error.

Thanks,
	André

Changes since v1:
- Add documentation for blk_mq_start_request()
---
 block/blk-mq.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c0f3357a2050..5646519c8d57 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -647,6 +647,14 @@ bool blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
+/**
+ * blk_mq_start_request - Start processing a request
+ * @rq: Pointer to request to be started
+ *
+ * Function used by device drivers to notify the block layer that a request
+ * is going to be processed now, so blk layer can do proper initializations
+ * such as starting the timeout timer.
+ */
 void blk_mq_start_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
@@ -1333,6 +1341,12 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	return (queued + errors) != 0;
 }
 
+/**
+ * __blk_mq_run_hw_queue - Run a hardware queue.
+ * @hctx: Pointer to the hardware queue to run.
+ *
+ * Send pending requests to the hardware.
+ */
 static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
 	int srcu_idx;
@@ -1430,6 +1444,15 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 	return next_cpu;
 }
 
+/**
+ * __blk_mq_delay_run_hw_queue - Run (or schedule to run) a hardware queue.
+ * @hctx: Pointer to the hardware queue to run.
+ * @async: If we want to run the queue asynchronously.
+ * @msecs: Microseconds of delay to wait before running the queue.
+ *
+ * If !@async, try to run the queue now. Else, run the queue asynchronously and
+ * with a delay of @msecs.
+ */
 static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 					unsigned long msecs)
 {
@@ -1451,12 +1474,30 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 				    msecs_to_jiffies(msecs));
 }
 
+/**
+ * blk_mq_delay_run_hw_queue - Run a hardware queue asynchronously.
+ * @hctx: Pointer to the hardware queue to run.
+ * @msecs: Microseconds of delay to wait before running the queue.
+ *
+ * Run a hardware queue asynchronously with a delay of @msecs.
+ */
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
 {
 	__blk_mq_delay_run_hw_queue(hctx, true, msecs);
 }
 EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
 
+/**
+ * blk_mq_run_hw_queue - Start to run a hardware queue.
+ * @hctx: Pointer to the hardware queue to run.
+ * @async: If we want to run the queue asynchronously.
+ *
+ * Check if the request queue is not in a quiesced state and if there are
+ * pending requests to be sent. If this is true, run the queue to send requests
+ * to hardware.
+ *
+ * Returns: True if we could run the queue, else otherwise.
+ */
 bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 {
 	int srcu_idx;
@@ -1484,6 +1525,11 @@ bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 }
 EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
+/**
+ * blk_mq_run_hw_queue - Run all hardware queues in a request queue.
+ * @q: Pointer to the request queue to run.
+ * @async: If we want to run the queue asynchronously.
+ */
 void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 {
 	struct blk_mq_hw_ctx *hctx;
@@ -1635,7 +1681,11 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	blk_mq_hctx_mark_pending(hctx, ctx);
 }
 
-/*
+/**
+ * blk_mq_request_bypass_insert - Insert a request at dispatch list.
+ * @rq: Pointer to request to be inserted.
+ * @run_queue: If we should run the hardware queue after inserting the request.
+ *
  * Should only be used carefully, when the caller knows we want to
  * bypass a potential IO scheduler on the target device.
  */
@@ -1838,6 +1888,17 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
+/**
+ * blk_mq_try_issue_directly - Try to send a request directly to device driver.
+ * @hctx: Pointer of the associated hardware queue.
+ * @rq: Pointer to request to be sent.
+ * @cookie: Request queue cookie.
+ *
+ * If the device has enough resources to accept a new request now, send the
+ * request directly to device driver. Else, insert at hctx->dispatch queue, so
+ * we can try send it another time in the future. Requests inserted at this
+ * queue have higher priority.
+ */
 static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, blk_qc_t *cookie)
 {
@@ -1915,6 +1976,22 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 	}
 }
 
+/**
+ * blk_mq_make_request - Create and send a request to block device.
+ * @q: Request queue pointer.
+ * @bio: Bio pointer.
+ *
+ * Builds up a request structure from @q and @bio and send to the device. The
+ * request may not be queued directly to hardware if:
+ * * This request can be merged with another one
+ * * We want to place request at plug queue for possible future merging
+ * * There is an IO scheduler active at this queue
+ *
+ * It will not queue the request if there is an error with the bio, or at the
+ * request creation.
+ *
+ * Returns: Request queue cookie.
+ */
 static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int is_sync = op_is_sync(bio->bi_opf);
@@ -1960,7 +2037,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	plug = blk_mq_plug(q, bio);
 	if (unlikely(is_flush_fua)) {
-		/* bypass scheduler for flush rq */
+		/* Bypass scheduler for flush requests */
 		blk_insert_flush(rq);
 		blk_mq_run_hw_queue(data.hctx, true);
 	} else if (plug && (q->nr_hw_queues == 1 || q->mq_ops->commit_rqs ||
@@ -1988,6 +2065,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 		blk_add_rq_to_plug(plug, rq);
 	} else if (q->elevator) {
+		/* Insert the request at the IO scheduler queue */
 		blk_mq_sched_insert_request(rq, false, true, true);
 	} else if (plug && !blk_queue_nomerges(q)) {
 		/*
@@ -2014,8 +2092,13 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) ||
 			!data.hctx->dispatch_busy) {
+		/*
+		 * There is no scheduler and we can try to send directly
+		 * to the hardware.
+		 */
 		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
 	} else {
+		/* Default case. */
 		blk_mq_sched_insert_request(rq, false, true, true);
 	}
 
-- 
2.23.0

