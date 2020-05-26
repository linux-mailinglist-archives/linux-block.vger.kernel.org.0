Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0148F1DBAAC
	for <lists+linux-block@lfdr.de>; Wed, 20 May 2020 19:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgETRGm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 20 May 2020 13:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgETRGm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 13:06:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A4DC061A0E
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Qpu7bb7g5tszZRMbsCxFga1+ZLh/4QRJW1z9MXDQMzY=; b=gHrrldXr55KY7WgrYeWHVgadPK
        g1lvIt2eVusOHMtZZCuZJ83O+wew4wCuKkWelqocuBACrYRuIMFTdLov/mWFEFN7Cb/jqFJPn9zGK
        5I3IBXg8h5nGSFbZPVymk38OOyS1A7xgbFqZ7thKZN5+QibA2ph8c9EGqiKqOXpEstMlY9lKeK8Yb
        WD8JBgU5kQ9qPtB5IFCxlDAMb4UO2qagS+dUz7XnPrEGstmq1l0wo6avEZ2eNr7ZAiMPAWnsTCowz
        5VKrNOtNkwu7mLg7DTidGmVyqPM4JLg3Tt1jc4/vQh5uWJW7sHrCEcUn5iUePNKEx8l3p9flbCFwU
        9O3djx4w==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbSB0-00036Q-2W; Wed, 20 May 2020 17:06:42 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/6] blk-mq: simplify the blk_mq_get_request calling convention
Date:   Wed, 20 May 2020 19:06:31 +0200
Message-Id: <20200520170635.2094101-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520170635.2094101-1-hch@lst.de>
References: <20200520170635.2094101-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The bio argument is entirely unused, and the request_queue can be passed
through the alloc_data, given that it needs to be filled out for the
low-level tag allocation anyway.  Also rename the function to
__blk_mq_alloc_request as the switch between get and alloc in the call
chains is rather confusing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 850e3642efc40..2250e6397559b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -332,10 +332,9 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	return rq;
 }
 
-static struct request *blk_mq_get_request(struct request_queue *q,
-					  struct bio *bio,
-					  struct blk_mq_alloc_data *data)
+static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 {
+	struct request_queue *q = data->q;
 	struct elevator_queue *e = q->elevator;
 	struct request *rq;
 	unsigned int tag;
@@ -346,7 +345,6 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	if (blk_queue_rq_alloc_time(q))
 		alloc_time_ns = ktime_get_ns();
 
-	data->q = q;
 	if (likely(!data->ctx)) {
 		data->ctx = blk_mq_get_ctx(q);
 		clear_ctx_on_error = true;
@@ -398,7 +396,11 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 		blk_mq_req_flags_t flags)
 {
-	struct blk_mq_alloc_data alloc_data = { .flags = flags, .cmd_flags = op };
+	struct blk_mq_alloc_data data = {
+		.q		= q,
+		.flags		= flags,
+		.cmd_flags	= op,
+	};
 	struct request *rq;
 	int ret;
 
@@ -406,7 +408,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 	if (ret)
 		return ERR_PTR(ret);
 
-	rq = blk_mq_get_request(q, NULL, &alloc_data);
+	rq = __blk_mq_alloc_request(&data);
 	if (!rq)
 		goto out_queue_exit;
 	rq->__data_len = 0;
@@ -422,7 +424,11 @@ EXPORT_SYMBOL(blk_mq_alloc_request);
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	unsigned int op, blk_mq_req_flags_t flags, unsigned int hctx_idx)
 {
-	struct blk_mq_alloc_data alloc_data = { .flags = flags, .cmd_flags = op };
+	struct blk_mq_alloc_data data = {
+		.q		= q,
+		.flags		= flags,
+		.cmd_flags	= op,
+	};
 	struct request *rq;
 	unsigned int cpu;
 	int ret;
@@ -448,14 +454,14 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	 * If not tell the caller that it should skip this queue.
 	 */
 	ret = -EXDEV;
-	alloc_data.hctx = q->queue_hw_ctx[hctx_idx];
-	if (!blk_mq_hw_queue_mapped(alloc_data.hctx))
+	data.hctx = q->queue_hw_ctx[hctx_idx];
+	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
-	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
-	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
+	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
+	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	ret = -EWOULDBLOCK;
-	rq = blk_mq_get_request(q, NULL, &alloc_data);
+	rq = __blk_mq_alloc_request(&data);
 	if (!rq)
 		goto out_queue_exit;
 	return rq;
@@ -2016,7 +2022,9 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int is_sync = op_is_sync(bio->bi_opf);
 	const int is_flush_fua = op_is_flush(bio->bi_opf);
-	struct blk_mq_alloc_data data = { .flags = 0};
+	struct blk_mq_alloc_data data = {
+		.q		= q,
+	};
 	struct request *rq;
 	struct blk_plug *plug;
 	struct request *same_queue_rq = NULL;
@@ -2040,7 +2048,7 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	rq_qos_throttle(q, bio);
 
 	data.cmd_flags = bio->bi_opf;
-	rq = blk_mq_get_request(q, bio, &data);
+	rq = __blk_mq_alloc_request(&data);
 	if (unlikely(!rq)) {
 		rq_qos_cleanup(q, bio);
 		if (bio->bi_opf & REQ_NOWAIT)
-- 
2.26.2

