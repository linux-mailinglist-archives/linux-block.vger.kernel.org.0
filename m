Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE0D1E8066
	for <lists+linux-block@lfdr.de>; Fri, 29 May 2020 16:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgE2Ohs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 May 2020 10:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgE2Ohr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 10:37:47 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B37DD207F5;
        Fri, 29 May 2020 14:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590763067;
        bh=yFae7GK++44DPO0iGMNh4qB+ZauE/dwLiY42V7OOLR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=geZeQQD3wQB9FMM67fSf3fvXf8m3d2ZQVLjShWauY/Re2MO3LizGgN+hD7AyQkK1u
         qieD+WF1jfC3Bo/c3En4pYzukI2Wtxpru+H8q3sVcjrMFsj493eur84L8sMdqUj+x2
         yy+LAJvwE6fmfBw2Aetg6OHs0BnbUWoDDO913yGI=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     alan.adamson@oracle.com, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/2] blk-mq: export blk_mq_force_complete_rq
Date:   Fri, 29 May 2020 07:37:43 -0700
Message-Id: <20200529143744.3545429-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200529143744.3545429-1-kbusch@kernel.org>
References: <20200529143744.3545429-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For when drivers have a need to bypass error injection.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c         | 15 +++++++++++++--
 include/linux/blk-mq.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cac11945f602..560a114a82f8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -556,7 +556,17 @@ static void __blk_mq_complete_request_remote(void *data)
 	q->mq_ops->complete(rq);
 }
 
-static void __blk_mq_complete_request(struct request *rq)
+/**
+ * blk_mq_force_complete_rq() - Force complete the request, bypassing any error
+ * 				injection that could drop the completion.
+ * @rq: Request to be force completed
+ *
+ * Drivers should use blk_mq_complete_request() to complete requests in their
+ * normal IO path. For timeout error recovery, drivers may call this forced
+ * completion routine after they've reclaimed timed out requests to bypass
+ * potentially subsequent fake timeouts.
+ */
+void blk_mq_force_complete_rq(struct request *rq)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct request_queue *q = rq->q;
@@ -602,6 +612,7 @@ static void __blk_mq_complete_request(struct request *rq)
 	}
 	put_cpu();
 }
+EXPORT_SYMBOL_GPL(blk_mq_force_complete_rq);
 
 static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
 	__releases(hctx->srcu)
@@ -635,7 +646,7 @@ bool blk_mq_complete_request(struct request *rq)
 {
 	if (unlikely(blk_should_fake_timeout(rq->q)))
 		return false;
-	__blk_mq_complete_request(rq);
+	blk_mq_force_complete_rq(rq);
 	return true;
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d7307795439a..856bb10993cf 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -494,6 +494,7 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 bool blk_mq_complete_request(struct request *rq);
+void blk_mq_force_complete_rq(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio, unsigned int nr_segs);
 bool blk_mq_queue_stopped(struct request_queue *q);
-- 
2.24.1

