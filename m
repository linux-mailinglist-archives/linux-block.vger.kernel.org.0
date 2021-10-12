Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09ED42A322
	for <lists+linux-block@lfdr.de>; Tue, 12 Oct 2021 13:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbhJLLY0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Oct 2021 07:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbhJLLYZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 07:24:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DA2C061570;
        Tue, 12 Oct 2021 04:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KEtu/YDGtVq3pP1YjUsSrQVsPE8aeNCCFIFtuh+d23s=; b=HDdneQ2gl+clafi76I21Fpk7pj
        1sezin5uIxTHihvrUBgxnbog5B4kpMLVxGG2dGHlDX679iwYd7J614D97CbjQBwSnh20iWNxOLtTj
        yvQbFXtHq3qoBvzvX+gBCsL1Qvgv/OvACcfFYbky0mBCvkJDJs1AW7DScZ119I+VZOO6bQhXx6kGZ
        ItthAoLvhceXhdjE1Oa0Q3EfFzxvo32OTvm+hoqFZ4uAwOfCWI7qYgL1y2w8/1GhObGOVPmiAZ725
        IlJ2CXH/ARwafQZ0ZY7VKTxn+TjrdkgTaRNPQTS/zvMJzBbUL0kM2tz7YcLM92sRk8iEJuqpJNrhS
        b0Kt+z6w==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFo8-006Rj0-3z; Tue, 12 Oct 2021 11:19:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 06/16] blk-mq: factor out a "classic" poll helper
Date:   Tue, 12 Oct 2021 13:12:16 +0200
Message-Id: <20211012111226.760968-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Factor the code to do the classic full metal polling out of blk_poll into
a separate blk_mq_poll_classic helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 block/blk-mq.c | 120 +++++++++++++++++++++++--------------------------
 1 file changed, 56 insertions(+), 64 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e1d1f2109bbed..00bc595d8de6d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -71,6 +71,14 @@ static inline struct blk_mq_hw_ctx *blk_qc_to_hctx(struct request_queue *q,
 	return q->queue_hw_ctx[(qc & ~BLK_QC_T_INTERNAL) >> BLK_QC_T_SHIFT];
 }
 
+static inline struct request *blk_qc_to_rq(struct blk_mq_hw_ctx *hctx,
+		blk_qc_t qc)
+{
+	if (blk_qc_t_is_internal(qc))
+		return blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(qc));
+	return blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(qc));
+}
+
 /*
  * Check if any of the ctx, dispatch list or elevator
  * have pending work in this hardware queue.
@@ -3944,15 +3952,20 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 	return ret;
 }
 
-static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
-				     struct request *rq)
+static bool blk_mq_poll_hybrid(struct request_queue *q, blk_qc_t qc)
 {
+	struct blk_mq_hw_ctx *hctx = blk_qc_to_hctx(q, qc);
+	struct request *rq = blk_qc_to_rq(hctx, qc);
 	struct hrtimer_sleeper hs;
 	enum hrtimer_mode mode;
 	unsigned int nsecs;
 	ktime_t kt;
 
-	if (rq->rq_flags & RQF_MQ_POLL_SLEPT)
+	/*
+	 * If a request has completed on queue that uses an I/O scheduler, we
+	 * won't get back a request from blk_qc_to_rq.
+	 */
+	if (!rq || (rq->rq_flags & RQF_MQ_POLL_SLEPT))
 		return false;
 
 	/*
@@ -3994,32 +4007,48 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 
 	__set_current_state(TASK_RUNNING);
 	destroy_hrtimer_on_stack(&hs.timer);
+
+	/*
+	 * If we sleep, have the caller restart the poll loop to reset the
+	 * state.  Like for the other success return cases, the caller is
+	 * responsible for checking if the IO completed.  If the IO isn't
+	 * complete, we'll get called again and will go straight to the busy
+	 * poll loop.
+	 */
 	return true;
 }
 
-static bool blk_mq_poll_hybrid(struct request_queue *q,
-			       struct blk_mq_hw_ctx *hctx, blk_qc_t cookie)
+static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
+		bool spin)
 {
-	struct request *rq;
+	struct blk_mq_hw_ctx *hctx = blk_qc_to_hctx(q, cookie);
+	long state = get_current_state();
+	int ret;
 
-	if (q->poll_nsec == BLK_MQ_POLL_CLASSIC)
-		return false;
+	hctx->poll_considered++;
 
-	if (!blk_qc_t_is_internal(cookie))
-		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
-	else {
-		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
-		/*
-		 * With scheduling, if the request has completed, we'll
-		 * get a NULL return here, as we clear the sched tag when
-		 * that happens. The request still remains valid, like always,
-		 * so we should be safe with just the NULL check.
-		 */
-		if (!rq)
-			return false;
-	}
+	do {
+		hctx->poll_invoked++;
 
-	return blk_mq_poll_hybrid_sleep(q, rq);
+		ret = q->mq_ops->poll(hctx);
+		if (ret > 0) {
+			hctx->poll_success++;
+			__set_current_state(TASK_RUNNING);
+			return ret;
+		}
+
+		if (signal_pending_state(state, current))
+			__set_current_state(TASK_RUNNING);
+		if (task_is_running(current))
+			return 1;
+
+		if (ret < 0 || !spin)
+			break;
+		cpu_relax();
+	} while (!need_resched());
+
+	__set_current_state(TASK_RUNNING);
+	return 0;
 }
 
 /**
@@ -4036,9 +4065,6 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
  */
 int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
-	struct blk_mq_hw_ctx *hctx;
-	unsigned int state;
-
 	if (!blk_qc_t_valid(cookie) ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
@@ -4046,46 +4072,12 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
-	hctx = blk_qc_to_hctx(q, cookie);
-
-	/*
-	 * If we sleep, have the caller restart the poll loop to reset
-	 * the state. Like for the other success return cases, the
-	 * caller is responsible for checking if the IO completed. If
-	 * the IO isn't complete, we'll get called again and will go
-	 * straight to the busy poll loop. If specified not to spin,
-	 * we also should not sleep.
-	 */
-	if (spin && blk_mq_poll_hybrid(q, hctx, cookie))
-		return 1;
-
-	hctx->poll_considered++;
-
-	state = get_current_state();
-	do {
-		int ret;
-
-		hctx->poll_invoked++;
-
-		ret = q->mq_ops->poll(hctx);
-		if (ret > 0) {
-			hctx->poll_success++;
-			__set_current_state(TASK_RUNNING);
-			return ret;
-		}
-
-		if (signal_pending_state(state, current))
-			__set_current_state(TASK_RUNNING);
-
-		if (task_is_running(current))
+	/* If specified not to spin, we also should not sleep. */
+	if (spin && q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
+		if (blk_mq_poll_hybrid(q, cookie))
 			return 1;
-		if (ret < 0 || !spin)
-			break;
-		cpu_relax();
-	} while (!need_resched());
-
-	__set_current_state(TASK_RUNNING);
-	return 0;
+	}
+	return blk_mq_poll_classic(q, cookie, spin);
 }
 EXPORT_SYMBOL_GPL(blk_poll);
 
-- 
2.30.2

