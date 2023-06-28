Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC595741193
	for <lists+linux-block@lfdr.de>; Wed, 28 Jun 2023 14:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjF1MrI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Jun 2023 08:47:08 -0400
Received: from out-57.mta1.migadu.com ([95.215.58.57]:42813 "EHLO
        out-57.mta1.migadu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjF1MqS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 08:46:18 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687956376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pM/RdRZgsIDACaBVp4cmgZyrhE7a7KC7/ymGEmkl5Ls=;
        b=a5srjzaiS6K4nB3ZXnm0AFNJNnvAlJ+SIEb7kdp7kGnt8nR/79si34wBYmtpyqERKJFv8I
        eVtIL4RSuhZrsSSmG2xZXQp4NhCObzOVQLYI/yxDhZZUg/+b1APrxemcQ5Qm9jkVah+iGX
        B5753HdUD0P4NpeZ+22N6nKf+HV7Nf4=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, ming.lei@redhat.com, hch@lst.de
Subject: [PATCH v3 1/3] blk-mq: always use __blk_mq_alloc_requests() to alloc and init rq
Date:   Wed, 28 Jun 2023 20:45:44 +0800
Message-Id: <20230628124546.1056698-2-chengming.zhou@linux.dev>
In-Reply-To: <20230628124546.1056698-1-chengming.zhou@linux.dev>
References: <20230628124546.1056698-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

This patch is preparation for the next patch that ktime_get_ns() only once
for batched pre-allocated requests start_time_ns setting.

1. data->flags is input for blk_mq_rq_ctx_init(), shouldn't update in
   every blk_mq_rq_ctx_init() in batched requests alloc. So put the
   data->flags initialization in the caller.

2. make blk_mq_alloc_request_hctx() to reuse __blk_mq_alloc_requests(),
   instead of directly using blk_mq_rq_ctx_init() by itself, so avoid
   doing the same data->flags initialization in it.

After these cleanup, __blk_mq_alloc_requests() is the only entry to
alloc and init rq.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index decb6ab2d508..c50ef953759f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -349,11 +349,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->mq_ctx = ctx;
 	rq->mq_hctx = hctx;
 	rq->cmd_flags = data->cmd_flags;
-
-	if (data->flags & BLK_MQ_REQ_PM)
-		data->rq_flags |= RQF_PM;
-	if (blk_queue_io_stat(q))
-		data->rq_flags |= RQF_IO_STAT;
 	rq->rq_flags = data->rq_flags;
 
 	if (data->rq_flags & RQF_SCHED_TAGS) {
@@ -447,6 +442,15 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
 
+	if (data->flags & BLK_MQ_REQ_RESERVED)
+		data->rq_flags |= RQF_RESV;
+
+	if (data->flags & BLK_MQ_REQ_PM)
+		data->rq_flags |= RQF_PM;
+
+	if (blk_queue_io_stat(q))
+		data->rq_flags |= RQF_IO_STAT;
+
 	if (q->elevator) {
 		/*
 		 * All requests use scheduler tags when an I/O scheduler is
@@ -471,14 +475,15 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	}
 
 retry:
-	data->ctx = blk_mq_get_ctx(q);
-	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
+	/* See blk_mq_alloc_request_hctx() for details */
+	if (!data->ctx) {
+		data->ctx = blk_mq_get_ctx(q);
+		data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
+	}
+
 	if (!(data->rq_flags & RQF_SCHED_TAGS))
 		blk_mq_tag_busy(data->hctx);
 
-	if (data->flags & BLK_MQ_REQ_RESERVED)
-		data->rq_flags |= RQF_RESV;
-
 	/*
 	 * Try batched alloc if we want more than 1 tag.
 	 */
@@ -505,6 +510,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		 * is going away.
 		 */
 		msleep(3);
+		data->ctx = NULL;
 		goto retry;
 	}
 
@@ -613,16 +619,10 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		.cmd_flags	= opf,
 		.nr_tags	= 1,
 	};
-	u64 alloc_time_ns = 0;
 	struct request *rq;
 	unsigned int cpu;
-	unsigned int tag;
 	int ret;
 
-	/* alloc_time includes depth and tag waits */
-	if (blk_queue_rq_alloc_time(q))
-		alloc_time_ns = ktime_get_ns();
-
 	/*
 	 * If the tag allocator sleeps we could get an allocation for a
 	 * different hardware context.  No need to complicate the low level
@@ -653,20 +653,10 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		goto out_queue_exit;
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
-	if (q->elevator)
-		data.rq_flags |= RQF_SCHED_TAGS;
-	else
-		blk_mq_tag_busy(data.hctx);
-
-	if (flags & BLK_MQ_REQ_RESERVED)
-		data.rq_flags |= RQF_RESV;
-
 	ret = -EWOULDBLOCK;
-	tag = blk_mq_get_tag(&data);
-	if (tag == BLK_MQ_NO_TAG)
+	rq = __blk_mq_alloc_requests(&data);
+	if (!rq)
 		goto out_queue_exit;
-	rq = blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag,
-					alloc_time_ns);
 	rq->__data_len = 0;
 	rq->__sector = (sector_t) -1;
 	rq->bio = rq->biotail = NULL;
-- 
2.39.2

