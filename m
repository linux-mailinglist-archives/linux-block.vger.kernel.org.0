Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0413927060
	for <lists+linux-block@lfdr.de>; Wed, 22 May 2019 22:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfEVUDT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 May 2019 16:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729971AbfEVTVo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 15:21:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D6172173C;
        Wed, 22 May 2019 19:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558552903;
        bh=BqFREttlpvHpkKLt6hvNGva987bDyHxt91ItdyW53v8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wpuLr7FFOa2BNtBSNcTMjCqG6Yy9M7ZJLQG6zx86kgEJ5H+zLc9BUUcwhh5uFUIqE
         gPxFDABqkrbQ6FBLNp9x54Z4FIlmNHZYjxSZFDcY1A4wLQpoevPWbrQ0qfgni7P57+
         9xmXZGwBAvAK619qhYDTx4NDA3K4pLNgDfs8TpD8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 020/375] blk-mq: grab .q_usage_counter when queuing request from plug code path
Date:   Wed, 22 May 2019 15:15:20 -0400
Message-Id: <20190522192115.22666-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192115.22666-1-sashal@kernel.org>
References: <20190522192115.22666-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit e87eb301bee183d82bb3d04bd71b6660889a2588 ]

Just like aio/io_uring, we need to grab 2 refcount for queuing one
request, one is for submission, another is for completion.

If the request isn't queued from plug code path, the refcount grabbed
in generic_make_request() serves for submission. In theroy, this
refcount should have been released after the sumission(async run queue)
is done. blk_freeze_queue() works with blk_sync_queue() together
for avoiding race between cleanup queue and IO submission, given async
run queue activities are canceled because hctx->run_work is scheduled with
the refcount held, so it is fine to not hold the refcount when
running the run queue work function for dispatch IO.

However, if request is staggered into plug list, and finally queued
from plug code path, the refcount in submission side is actually missed.
And we may start to run queue after queue is removed because the queue's
kobject refcount isn't guaranteed to be grabbed in flushing plug list
context, then kernel oops is triggered, see the following race:

blk_mq_flush_plug_list():
        blk_mq_sched_insert_requests()
                insert requests to sw queue or scheduler queue
                blk_mq_run_hw_queue

Because of concurrent run queue, all requests inserted above may be
completed before calling the above blk_mq_run_hw_queue. Then queue can
be freed during the above blk_mq_run_hw_queue().

Fixes the issue by grab .q_usage_counter before calling
blk_mq_sched_insert_requests() in blk_mq_flush_plug_list(). This way is
safe because the queue is absolutely alive before inserting request.

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq-sched.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index aa6bc5c026438..c59babca6857a 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -413,6 +413,14 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 				  struct list_head *list, bool run_queue_async)
 {
 	struct elevator_queue *e;
+	struct request_queue *q = hctx->queue;
+
+	/*
+	 * blk_mq_sched_insert_requests() is called from flush plug
+	 * context only, and hold one usage counter to prevent queue
+	 * from being released.
+	 */
+	percpu_ref_get(&q->q_usage_counter);
 
 	e = hctx->queue->elevator;
 	if (e && e->type->ops.insert_requests)
@@ -426,12 +434,14 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 		if (!hctx->dispatch_busy && !e && !run_queue_async) {
 			blk_mq_try_issue_list_directly(hctx, list);
 			if (list_empty(list))
-				return;
+				goto out;
 		}
 		blk_mq_insert_requests(hctx, ctx, list);
 	}
 
 	blk_mq_run_hw_queue(hctx, run_queue_async);
+ out:
+	percpu_ref_put(&q->q_usage_counter);
 }
 
 static void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
-- 
2.20.1

