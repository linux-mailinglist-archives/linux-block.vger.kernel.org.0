Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21BB6166D6E
	for <lists+linux-block@lfdr.de>; Fri, 21 Feb 2020 04:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgBUDXB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Feb 2020 22:23:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45707 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgBUDXB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 22:23:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so252055pgk.12
        for <linux-block@vger.kernel.org>; Thu, 20 Feb 2020 19:23:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nQz+s9/NC7dIiY7glYySFYWS0V805f2KdP7BLEhNNbM=;
        b=ouD7yvcH4JDlaTRNRnzu21Vy4ZeSE5R90hz13tOBe6N5bZ0cGUoO/mK2+dwQctfZ6S
         QIE381jf/CeSjFpOQKtEwVDm8XLsM9VpVoQBvjM62yIsZbT2s92exP5dy8YNQoUmaWPz
         aF5sZXZ/eQUyMuM2Ah1T92h+T/fJTVvVnPdSzVTjEwHC0D6+6Na/LX5eZiVNZQGLN5JK
         oZ39WTYPl5v92Mi6+xJGOpeH8Y1TIJeWq82TaOuKVxmVimRuez+kgVtSepRzbXXugKlR
         KGeo0qMtrrdtQBmo3T/JR99saODO8hQ2R9wUfToAzp1GbM7dqmiCMxAm1Rz+1Sb2ZoyR
         ATbQ==
X-Gm-Message-State: APjAAAU/h+IlsXCgPzm8RnL5tXPqoVmbxIVIBGLhFDsF/fDtX13mDM8J
        hsGl6NCrIBRYpDCZ8S93jVoT4FvFHdI=
X-Google-Smtp-Source: APXvYqxFxQr12TlpbA0kCB1Bwr8UofK6fxXx+yvP+mPD5Hzqt4aLCThqEzGZ03QBmpfmjgGQF3b/dQ==
X-Received: by 2002:a63:6704:: with SMTP id b4mr37608683pgc.424.1582255380714;
        Thu, 20 Feb 2020 19:23:00 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:e57a:a1b3:1a44:bb8c])
        by smtp.gmail.com with ESMTPSA id x197sm1010517pfc.1.2020.02.20.19.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 19:23:00 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v3 5/8] null_blk: Fix changing the number of hardware queues
Date:   Thu, 20 Feb 2020 19:22:40 -0800
Message-Id: <20200221032243.9708-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221032243.9708-1-bvanassche@acm.org>
References: <20200221032243.9708-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of initializing null_blk hardware queues explicitly after the
request queue has been created, provide .init_hctx() and .exit_hctx()
callback functions. The latter functions are not only called during
request queue allocation but also when the number of hardware queues
changes. Allocate nr_cpu_ids queues during initialization to support
increasing the number of hardware queues above the initial hardware
queue count.

This change fixes increasing the number of hardware queues above the
initial number of hardware queues and also keeps nullb->nr_queues in
sync with the number of hardware queues.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jth@kernel.org>
Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after an instance has been configured")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk_main.c | 103 ++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 37 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 7cd31d4ef709..31678c9af43f 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -302,6 +302,12 @@ static int nullb_apply_submit_queues(struct nullb_device *dev,
 	if (!nullb)
 		return 0;
 
+	/*
+	 * Make sure that null_init_hctx() does not access nullb->queues[] past
+	 * the end of that array.
+	 */
+	if (submit_queues > nr_cpu_ids)
+		return -EINVAL;
 	set = nullb->tag_set;
 	blk_mq_update_nr_hw_queues(set, submit_queues);
 	return set->nr_hw_queues == submit_queues ? 0 : -ENOMEM;
@@ -1408,12 +1414,6 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return null_handle_cmd(cmd, sector, nr_sectors, req_op(bd->rq));
 }
 
-static const struct blk_mq_ops null_mq_ops = {
-	.queue_rq       = null_queue_rq,
-	.complete	= null_complete_rq,
-	.timeout	= null_timeout_rq,
-};
-
 static void cleanup_queue(struct nullb_queue *nq)
 {
 	kfree(nq->tag_map);
@@ -1430,6 +1430,43 @@ static void cleanup_queues(struct nullb *nullb)
 	kfree(nullb->queues);
 }
 
+static void null_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+{
+	struct nullb_queue *nq = hctx->driver_data;
+	struct nullb *nullb = nq->dev->nullb;
+
+	nullb->nr_queues--;
+}
+
+static void null_init_queue(struct nullb *nullb, struct nullb_queue *nq)
+{
+	init_waitqueue_head(&nq->wait);
+	nq->queue_depth = nullb->queue_depth;
+	nq->dev = nullb->dev;
+}
+
+static int null_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
+			  unsigned int hctx_idx)
+{
+	struct nullb *nullb = hctx->queue->queuedata;
+	struct nullb_queue *nq;
+
+	nq = &nullb->queues[hctx_idx];
+	hctx->driver_data = nq;
+	null_init_queue(nullb, nq);
+	nullb->nr_queues++;
+
+	return 0;
+}
+
+static const struct blk_mq_ops null_mq_ops = {
+	.queue_rq       = null_queue_rq,
+	.complete	= null_complete_rq,
+	.timeout	= null_timeout_rq,
+	.init_hctx	= null_init_hctx,
+	.exit_hctx	= null_exit_hctx,
+};
+
 static void null_del_dev(struct nullb *nullb)
 {
 	struct nullb_device *dev = nullb->dev;
@@ -1473,33 +1510,6 @@ static const struct block_device_operations null_ops = {
 	.report_zones	= null_report_zones,
 };
 
-static void null_init_queue(struct nullb *nullb, struct nullb_queue *nq)
-{
-	BUG_ON(!nullb);
-	BUG_ON(!nq);
-
-	init_waitqueue_head(&nq->wait);
-	nq->queue_depth = nullb->queue_depth;
-	nq->dev = nullb->dev;
-}
-
-static void null_init_queues(struct nullb *nullb)
-{
-	struct request_queue *q = nullb->q;
-	struct blk_mq_hw_ctx *hctx;
-	struct nullb_queue *nq;
-	int i;
-
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (!hctx->nr_ctx || !hctx->tags)
-			continue;
-		nq = &nullb->queues[i];
-		hctx->driver_data = nq;
-		null_init_queue(nullb, nq);
-		nullb->nr_queues++;
-	}
-}
-
 static int setup_commands(struct nullb_queue *nq)
 {
 	struct nullb_cmd *cmd;
@@ -1528,8 +1538,7 @@ static int setup_commands(struct nullb_queue *nq)
 
 static int setup_queues(struct nullb *nullb)
 {
-	nullb->queues = kcalloc(nullb->dev->submit_queues,
-				sizeof(struct nullb_queue),
+	nullb->queues = kcalloc(nr_cpu_ids, sizeof(struct nullb_queue),
 				GFP_KERNEL);
 	if (!nullb->queues)
 		return -ENOMEM;
@@ -1675,6 +1684,27 @@ static bool null_setup_fault(void)
 	return true;
 }
 
+/*
+ * This function is identical to blk_mq_init_queue() except that it sets
+ * queuedata before .init_hctx is called.
+ */
+static struct request_queue *nullb_alloc_queue(struct nullb *nullb)
+{
+	struct request_queue *uninit_q, *q;
+	struct blk_mq_tag_set *set = nullb->tag_set;
+
+	uninit_q = blk_alloc_queue_node(GFP_KERNEL, set->numa_node);
+	if (!uninit_q)
+		return ERR_PTR(-ENOMEM);
+
+	uninit_q->queuedata = nullb;
+	q = blk_mq_init_allocated_queue(set, uninit_q, false);
+	if (IS_ERR(q))
+		blk_cleanup_queue(uninit_q);
+
+	return q;
+}
+
 static int null_add_dev(struct nullb_device *dev)
 {
 	struct nullb *nullb;
@@ -1714,12 +1744,11 @@ static int null_add_dev(struct nullb_device *dev)
 			goto out_cleanup_queues;
 
 		nullb->tag_set->timeout = 5 * HZ;
-		nullb->q = blk_mq_init_queue(nullb->tag_set);
+		nullb->q = nullb_alloc_queue(nullb);
 		if (IS_ERR(nullb->q)) {
 			rv = -ENOMEM;
 			goto out_cleanup_tags;
 		}
-		null_init_queues(nullb);
 	} else if (dev->queue_mode == NULL_Q_BIO) {
 		nullb->q = blk_alloc_queue_node(GFP_KERNEL, dev->home_node);
 		if (!nullb->q) {
