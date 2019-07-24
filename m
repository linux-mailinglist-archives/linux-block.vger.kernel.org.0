Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7158E72588
	for <lists+linux-block@lfdr.de>; Wed, 24 Jul 2019 05:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfGXDtW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Jul 2019 23:49:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfGXDtV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 23:49:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 923B4307154D;
        Wed, 24 Jul 2019 03:49:21 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C5825D9C5;
        Wed, 24 Jul 2019 03:49:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Ming Lei <ming.lei@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 5/5] blk-mq: remove blk_mq_complete_request_sync
Date:   Wed, 24 Jul 2019 11:48:43 +0800
Message-Id: <20190724034843.10879-6-ming.lei@redhat.com>
In-Reply-To: <20190724034843.10879-1-ming.lei@redhat.com>
References: <20190724034843.10879-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 24 Jul 2019 03:49:21 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_tagset_wait_completed_request() has been applied for waiting
for completed request's fn, so not necessary to use
blk_mq_complete_request_sync() any more.

Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c           | 7 -------
 drivers/nvme/host/core.c | 2 +-
 include/linux/blk-mq.h   | 1 -
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e1d0b4567388..9836a00d8c07 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -652,13 +652,6 @@ bool blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
-void blk_mq_complete_request_sync(struct request *rq)
-{
-	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
-	rq->q->mq_ops->complete(rq);
-}
-EXPORT_SYMBOL_GPL(blk_mq_complete_request_sync);
-
 int blk_mq_request_started(struct request *rq)
 {
 	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e98490b98cbd..b3c1e063261e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -293,7 +293,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 		return true;
 
 	nvme_req(req)->status = NVME_SC_ABORT_REQ;
-	blk_mq_complete_request_sync(req);
+	blk_mq_complete_request(req);
 	return true;
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_request);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f9f722aeb535..21cebe901ac0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -312,7 +312,6 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 bool blk_mq_complete_request(struct request *rq);
-void blk_mq_complete_request_sync(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio, unsigned int nr_segs);
 bool blk_mq_queue_stopped(struct request_queue *q);
-- 
2.20.1

