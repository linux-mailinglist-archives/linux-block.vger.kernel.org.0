Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95A4274E7E
	for <lists+linux-block@lfdr.de>; Wed, 23 Sep 2020 03:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgIWBes (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Sep 2020 21:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727040AbgIWBes (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 21:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600824885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gyZ3e1Y1QCAzCMKHoXnUGsgQtLzHkLuy0WkNGiX53Y=;
        b=RTDzbX7Q40qz86howcesONesAkW+5/EoZSTVRpK0eG31xfKQW3pTeQBD+Ey08apVmdFX6L
        eQQnofNueBPCFKHMfWcp4ojA/bXgm8ySMYBLhc0RHK1fBEJ2xkQGMRBK4LGlPOZZr5vspF
        UMrVeE7qL1etAzVT3NSzQawQEammTfs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-xp3RSIruOBGgLXEPjJkiGg-1; Tue, 22 Sep 2020 21:34:41 -0400
X-MC-Unique: xp3RSIruOBGgLXEPjJkiGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E5AA186DD28;
        Wed, 23 Sep 2020 01:34:40 +0000 (UTC)
Received: from localhost (ovpn-12-168.pek2.redhat.com [10.72.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF5FB614F5;
        Wed, 23 Sep 2020 01:34:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V3 for 5.11 08/12] blk-mq: return budget token from .get_budget callback
Date:   Wed, 23 Sep 2020 09:33:35 +0800
Message-Id: <20200923013339.1621784-9-ming.lei@redhat.com>
In-Reply-To: <20200923013339.1621784-1-ming.lei@redhat.com>
References: <20200923013339.1621784-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SCSI uses one global atomic variable to track queue depth for each
LUN/request queue.

This way doesn't scale well when there is lots of CPU cores and the
disk is very fast. It has been observed that IOPS is affected a lot
by tracking queue depth via sdev->device_busy in IO path.

Return budget token from .get_budget callback, and the budget token
can be passed to driver, so that we can replace the atomic variable
with sbitmap_queue, then the scale issue can be fixed.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c    | 17 +++++++++++++----
 block/blk-mq.c          | 36 +++++++++++++++++++++++++-----------
 block/blk-mq.h          | 25 +++++++++++++++++++++----
 drivers/scsi/scsi_lib.c | 16 +++++++++++-----
 include/linux/blk-mq.h  |  4 ++--
 5 files changed, 72 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 3e9596738852..1c04a58c5f99 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -131,6 +131,7 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 
 	do {
 		struct request *rq;
+		int budget_token;
 
 		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
 			break;
@@ -140,12 +141,13 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 			break;
 		}
 
-		if (!blk_mq_get_dispatch_budget(q))
+		budget_token = blk_mq_get_dispatch_budget(q);
+		if (budget_token < 0)
 			break;
 
 		rq = e->type->ops.dispatch_request(hctx);
 		if (!rq) {
-			blk_mq_put_dispatch_budget(q);
+			blk_mq_put_dispatch_budget(q, budget_token);
 			/*
 			 * We're releasing without dispatching. Holding the
 			 * budget could have blocked any "hctx"s with the
@@ -157,6 +159,8 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 			break;
 		}
 
+		blk_mq_set_rq_budget_token(rq, budget_token);
+
 		/*
 		 * Now this rq owns the budget which has to be released
 		 * if this rq won't be queued to driver via .queue_rq()
@@ -230,6 +234,8 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 	struct request *rq;
 
 	do {
+		int budget_token;
+
 		if (!list_empty_careful(&hctx->dispatch)) {
 			ret = -EAGAIN;
 			break;
@@ -238,12 +244,13 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 		if (!sbitmap_any_bit_set(&hctx->ctx_map))
 			break;
 
-		if (!blk_mq_get_dispatch_budget(q))
+		budget_token = blk_mq_get_dispatch_budget(q);
+		if (budget_token < 0)
 			break;
 
 		rq = blk_mq_dequeue_from_ctx(hctx, ctx);
 		if (!rq) {
-			blk_mq_put_dispatch_budget(q);
+			blk_mq_put_dispatch_budget(q, budget_token);
 			/*
 			 * We're releasing without dispatching. Holding the
 			 * budget could have blocked any "hctx"s with the
@@ -255,6 +262,8 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 			break;
 		}
 
+		blk_mq_set_rq_budget_token(rq, budget_token);
+
 		/*
 		 * Now this rq owns the budget which has to be released
 		 * if this rq won't be queued to driver via .queue_rq()
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 88154cea83d8..7743cacb02b4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1296,10 +1296,15 @@ static enum prep_dispatch blk_mq_prep_dispatch_rq(struct request *rq,
 						  bool need_budget)
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+	int budget_token = -1;
 
-	if (need_budget && !blk_mq_get_dispatch_budget(rq->q)) {
-		blk_mq_put_driver_tag(rq);
-		return PREP_DISPATCH_NO_BUDGET;
+	if (need_budget) {
+		budget_token = blk_mq_get_dispatch_budget(rq->q);
+		if (budget_token < 0) {
+			blk_mq_put_driver_tag(rq);
+			return PREP_DISPATCH_NO_BUDGET;
+		}
+		blk_mq_set_rq_budget_token(rq, budget_token);
 	}
 
 	if (!blk_mq_get_driver_tag(rq)) {
@@ -1316,7 +1321,7 @@ static enum prep_dispatch blk_mq_prep_dispatch_rq(struct request *rq,
 			 * together during handling partial dispatch
 			 */
 			if (need_budget)
-				blk_mq_put_dispatch_budget(rq->q);
+				blk_mq_put_dispatch_budget(rq->q, budget_token);
 			return PREP_DISPATCH_NO_TAG;
 		}
 	}
@@ -1326,12 +1331,16 @@ static enum prep_dispatch blk_mq_prep_dispatch_rq(struct request *rq,
 
 /* release all allocated budgets before calling to blk_mq_dispatch_rq_list */
 static void blk_mq_release_budgets(struct request_queue *q,
-		unsigned int nr_budgets)
+		struct list_head *list)
 {
-	int i;
+	struct request *rq;
 
-	for (i = 0; i < nr_budgets; i++)
-		blk_mq_put_dispatch_budget(q);
+	list_for_each_entry(rq, list, queuelist) {
+		int budget_token = blk_mq_get_rq_budget_token(rq);
+
+		if (budget_token >= 0)
+			blk_mq_put_dispatch_budget(q, budget_token);
+	}
 }
 
 /*
@@ -1424,7 +1433,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED);
 		bool no_budget_avail = prep == PREP_DISPATCH_NO_BUDGET;
 
-		blk_mq_release_budgets(q, nr_budgets);
+		if (nr_budgets)
+			blk_mq_release_budgets(q, list);
 
 		/*
 		 * If we didn't flush the entire list, we could have told
@@ -1997,6 +2007,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 {
 	struct request_queue *q = rq->q;
 	bool run_queue = true;
+	int budget_token;
 
 	/*
 	 * RCU or SRCU read lock is needed before checking quiesced flag.
@@ -2014,11 +2025,14 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	if (q->elevator && !bypass_insert)
 		goto insert;
 
-	if (!blk_mq_get_dispatch_budget(q))
+	budget_token = blk_mq_get_dispatch_budget(q);
+	if (budget_token < 0)
 		goto insert;
 
+	blk_mq_set_rq_budget_token(rq, budget_token);
+
 	if (!blk_mq_get_driver_tag(rq)) {
-		blk_mq_put_dispatch_budget(q);
+		blk_mq_put_dispatch_budget(q, budget_token);
 		goto insert;
 	}
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index a52703c98b77..bb59a3e54c3b 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -186,17 +186,34 @@ unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part);
 void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 			 unsigned int inflight[2]);
 
-static inline void blk_mq_put_dispatch_budget(struct request_queue *q)
+static inline void blk_mq_put_dispatch_budget(struct request_queue *q,
+					      int budget_token)
 {
 	if (q->mq_ops->put_budget)
-		q->mq_ops->put_budget(q);
+		q->mq_ops->put_budget(q, budget_token);
 }
 
-static inline bool blk_mq_get_dispatch_budget(struct request_queue *q)
+static inline int blk_mq_get_dispatch_budget(struct request_queue *q)
 {
 	if (q->mq_ops->get_budget)
 		return q->mq_ops->get_budget(q);
-	return true;
+	return 0;
+}
+
+static inline void blk_mq_set_rq_budget_token(struct request *rq, int token)
+{
+	if (token < 0)
+		return;
+
+	if (rq->q->mq_ops->set_rq_budget_token)
+		rq->q->mq_ops->set_rq_budget_token(rq, token);
+}
+
+static inline int blk_mq_get_rq_budget_token(struct request *rq)
+{
+	if (rq->q->mq_ops->get_rq_budget_token)
+		return rq->q->mq_ops->get_rq_budget_token(rq);
+	return -1;
 }
 
 static inline void __blk_mq_inc_active_requests(struct blk_mq_hw_ctx *hctx)
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index bfcccc73fd01..41380e200925 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -343,6 +343,7 @@ void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd)
 		atomic_dec(&starget->target_busy);
 
 	atomic_dec(&sdev->device_busy);
+	cmd->budget_token = -1;
 }
 
 static void scsi_kick_queue(struct request_queue *q)
@@ -1128,6 +1129,7 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
 	unsigned long jiffies_at_alloc;
 	int retries, to_clear;
 	bool in_flight;
+	int budget_token = cmd->budget_token;
 
 	if (!blk_rq_is_scsi(rq) && !(flags & SCMD_INITIALIZED)) {
 		flags |= SCMD_INITIALIZED;
@@ -1156,6 +1158,7 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
 	cmd->retries = retries;
 	if (in_flight)
 		__set_bit(SCMD_STATE_INFLIGHT, &cmd->state);
+	cmd->budget_token = budget_token;
 
 }
 
@@ -1618,19 +1621,19 @@ static void scsi_mq_done(struct scsi_cmnd *cmd)
 	blk_mq_complete_request(cmd->request);
 }
 
-static void scsi_mq_put_budget(struct request_queue *q)
+static void scsi_mq_put_budget(struct request_queue *q, int budget_token)
 {
 	struct scsi_device *sdev = q->queuedata;
 
 	atomic_dec(&sdev->device_busy);
 }
 
-static bool scsi_mq_get_budget(struct request_queue *q)
+static int scsi_mq_get_budget(struct request_queue *q)
 {
 	struct scsi_device *sdev = q->queuedata;
 
 	if (scsi_dev_queue_ready(q, sdev))
-		return true;
+		return 0;
 
 	atomic_inc(&sdev->restarts);
 
@@ -1652,7 +1655,7 @@ static bool scsi_mq_get_budget(struct request_queue *q)
 	if (unlikely(atomic_read(&sdev->device_busy) == 0 &&
 				!scsi_device_blocked(sdev)))
 		blk_mq_delay_run_hw_queues(sdev->request_queue, SCSI_QUEUE_DELAY);
-	return false;
+	return -1;
 }
 
 static void scsi_mq_set_rq_budget_token(struct request *req, int token)
@@ -1680,6 +1683,8 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_status_t ret;
 	int reason;
 
+	WARN_ON_ONCE(cmd->budget_token < 0);
+
 	/*
 	 * If the device is not in running state we will reject some or all
 	 * commands.
@@ -1730,7 +1735,8 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (scsi_target(sdev)->can_queue > 0)
 		atomic_dec(&scsi_target(sdev)->target_busy);
 out_put_budget:
-	scsi_mq_put_budget(q);
+	scsi_mq_put_budget(q, cmd->budget_token);
+	cmd->budget_token = -1;
 	switch (ret) {
 	case BLK_STS_OK:
 		break;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 71060c6a84b1..7b4d4b23403a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -307,12 +307,12 @@ struct blk_mq_ops {
 	 * reserved budget. Also we have to handle failure case
 	 * of .get_budget for avoiding I/O deadlock.
 	 */
-	bool (*get_budget)(struct request_queue *);
+	int (*get_budget)(struct request_queue *);
 
 	/**
 	 * @put_budget: Release the reserved budget.
 	 */
-	void (*put_budget)(struct request_queue *);
+	void (*put_budget)(struct request_queue *, int);
 
 	/*
 	 * @set_rq_budget_toekn: store rq's budget token
-- 
2.25.2

