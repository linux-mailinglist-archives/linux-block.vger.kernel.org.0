Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9B41E7F47
	for <lists+linux-block@lfdr.de>; Fri, 29 May 2020 15:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgE2Nxf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 May 2020 09:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgE2Nxf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 09:53:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942A4C03E969
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HxvxgA19pkd+Givz+iqH/9Lq41iOhVxepIPT/LRhjCE=; b=DFYWiKfoSARaZI5fbFjlm4VaVx
        MzbTDfd228r4B5LFOZ21z9380UD8BkSzDMLq/K601dQp8820vvXnW0AYDiMbfQk+IwKzP8yxYhdzH
        fzC4g93y+cIAS2GZ/OyW6CyRK1tpZqjzMlbr/ND2KXSAQuCZXZAi69TKYKhX2oW4qWnx14sbNgZXP
        sWC0JQYlUpeMSvj5fJBG2P6Sm60m6bMO6V2d1fp6xR8Prhyvo/Rpol+zaaVeMJULIlAA8ncSQMiI2
        tR4mJmF9FfTK6oMos60ZYtCFLTyMFBdQgeVWgUg0bSw8iMfpz3NkAUj0G96RUDkxrJx62WRfrJZ+k
        0zeZxEqA==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jefS1-0000q4-P4; Fri, 29 May 2020 13:53:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 6/8] blk-mq: open code __blk_mq_alloc_request in blk_mq_alloc_request_hctx
Date:   Fri, 29 May 2020 15:53:13 +0200
Message-Id: <20200529135315.199230-7-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529135315.199230-1-hch@lst.de>
References: <20200529135315.199230-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_alloc_request_hctx is only used for NVMeoF connect commands, so
tailor it to the specific requirements, and don't bother the general
fast path code with its special twinkles.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 block/blk-mq.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 696202e6e304f..d8c17ab0c7c22 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -351,21 +351,13 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 {
 	struct request_queue *q = data->q;
 	struct elevator_queue *e = q->elevator;
-	unsigned int tag;
-	bool clear_ctx_on_error = false;
 	u64 alloc_time_ns = 0;
+	unsigned int tag;
 
 	/* alloc_time includes depth and tag waits */
 	if (blk_queue_rq_alloc_time(q))
 		alloc_time_ns = ktime_get_ns();
 
-	if (likely(!data->ctx)) {
-		data->ctx = blk_mq_get_ctx(q);
-		clear_ctx_on_error = true;
-	}
-	if (likely(!data->hctx))
-		data->hctx = blk_mq_map_queue(q, data->cmd_flags,
-						data->ctx);
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
 
@@ -381,17 +373,16 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 		    e->type->ops.limit_depth &&
 		    !(data->flags & BLK_MQ_REQ_RESERVED))
 			e->type->ops.limit_depth(data->cmd_flags, data);
-	} else {
-		blk_mq_tag_busy(data->hctx);
 	}
 
+	data->ctx = blk_mq_get_ctx(q);
+	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
+	if (!(data->flags & BLK_MQ_REQ_INTERNAL))
+		blk_mq_tag_busy(data->hctx);
+
 	tag = blk_mq_get_tag(data);
-	if (tag == BLK_MQ_NO_TAG) {
-		if (clear_ctx_on_error)
-			data->ctx = NULL;
+	if (tag == BLK_MQ_NO_TAG)
 		return NULL;
-	}
-
 	return blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
 }
 
@@ -431,17 +422,22 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		.flags		= flags,
 		.cmd_flags	= op,
 	};
-	struct request *rq;
+	u64 alloc_time_ns = 0;
 	unsigned int cpu;
+	unsigned int tag;
 	int ret;
 
+	/* alloc_time includes depth and tag waits */
+	if (blk_queue_rq_alloc_time(q))
+		alloc_time_ns = ktime_get_ns();
+
 	/*
 	 * If the tag allocator sleeps we could get an allocation for a
 	 * different hardware context.  No need to complicate the low level
 	 * allocator for this for the rare use case of a command tied to
 	 * a specific queue.
 	 */
-	if (WARN_ON_ONCE(!(flags & BLK_MQ_REQ_NOWAIT)))
+	if (WARN_ON_ONCE(!(flags & (BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED))))
 		return ERR_PTR(-EINVAL);
 
 	if (hctx_idx >= q->nr_hw_queues)
@@ -462,11 +458,17 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
+	if (q->elevator)
+		data.flags |= BLK_MQ_REQ_INTERNAL;
+	else
+		blk_mq_tag_busy(data.hctx);
+
 	ret = -EWOULDBLOCK;
-	rq = __blk_mq_alloc_request(&data);
-	if (!rq)
+	tag = blk_mq_get_tag(&data);
+	if (tag == BLK_MQ_NO_TAG)
 		goto out_queue_exit;
-	return rq;
+	return blk_mq_rq_ctx_init(&data, tag, alloc_time_ns);
+
 out_queue_exit:
 	blk_queue_exit(q);
 	return ERR_PTR(ret);
-- 
2.26.2

