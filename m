Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A141399F3E
	for <lists+linux-block@lfdr.de>; Thu,  3 Jun 2021 12:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFCKtM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 3 Jun 2021 06:49:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50760 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCKtM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 06:49:12 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1EB55219DF;
        Thu,  3 Jun 2021 10:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622717247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ocENtcVFdYsoQg101wOnJ1na7Td3HgeTGTBZRSHI0t0=;
        b=NQmSH9knmMnSWT+KxvFN1icU7EQEVq5JtkThlhVnLCcDDwvPk42MLZOnEdi7LHbsdAMitF
        IZKIvbapSB4NgrmvCtzr3t/GfE/123Zzz0cXGOJwkCM4OzbOQWVQeQuSKJlkXjN9BiWnS4
        qgrZNgcZP8g6NYEpejaCuBep6zXb0mA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622717247;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ocENtcVFdYsoQg101wOnJ1na7Td3HgeTGTBZRSHI0t0=;
        b=4EubOTbR8dPgy/mxM8zHGLrKXd0k/AI4bS0420jdWbM0HCLekXgJkNbN0HmBCo5+K9+8lN
        cHhw4xXfaFdKlQAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 07A98A3B81;
        Thu,  3 Jun 2021 10:47:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E37221F2C98; Thu,  3 Jun 2021 12:47:26 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2] block: Do not pull requests from the scheduler when we cannot dispatch them
Date:   Thu,  3 Jun 2021 12:47:21 +0200
Message-Id: <20210603104721.6309-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3226; h=from:subject; bh=iAmzytD8mtcBHnHSEaUslpCdMrkD/XsxdHvb7cpP7JQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBguLMzp6FEJpAFdcRu/qxKB9J0KjMJJk0IEZluTT2e UzxkjUWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYLizMwAKCRCcnaoHP2RA2aVMCA DmpFmdibH0bn7VDthl8IFi50gRNm9jXMzDfeR+C6+l6U4gT74vFC/XDFqeURF/lghScLhRzcC+1oJo pP/P+hWfXnlo0TsuD3wVhbio/Rb/Ok4NIm9JEdZD8Nn9gXW2blzoTIDfJN7TxB8Xwx7ZTlm9JrXnrL ycQUdpagcIZo/zbw/K5ByB+R88imvZq/4uPYSuDu4qFJpfklg+wmGLETS/qb/XSJFIAd+UlxP7sJbB Wwjk5H/PKI68ssGi4eCPup5hzXeGNnyVfvdgagZQ6upu5tS1REdqF0X6n6YfdjCFkgLqbRfLkasaZV FWgqR8wiZ9KpqIlJN2Xx5UrYPlUE9U
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Provided the device driver does not implement dispatch budget accounting
(which only SCSI does) the loop in __blk_mq_do_dispatch_sched() pulls
requests from the IO scheduler as long as it is willing to give out any.
That defeats scheduling heuristics inside the scheduler by creating
false impression that the device can take more IO when it in fact
cannot.

For example with BFQ IO scheduler on top of virtio-blk device setting
blkio cgroup weight has barely any impact on observed throughput of
async IO because __blk_mq_do_dispatch_sched() always sucks out all the
IO queued in BFQ. BFQ first submits IO from higher weight cgroups but
when that is all dispatched, it will give out IO of lower weight cgroups
as well. And then we have to wait for all this IO to be dispatched to
the disk (which means lot of it actually has to complete) before the
IO scheduler is queried again for dispatching more requests. This
completely destroys any service differentiation.

So grab request tag for a request pulled out of the IO scheduler already
in __blk_mq_do_dispatch_sched() and do not pull any more requests if we
cannot get it because we are unlikely to be able to dispatch it. That
way only single request is going to wait in the dispatch list for some
tag to free.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-mq-sched.c | 12 +++++++++++-
 block/blk-mq.c       |  2 +-
 block/blk-mq.h       |  2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

Jens, can you please merge the patch? Thanks!

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 996a4b2f73aa..714e678f516a 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -168,9 +168,19 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 * in blk_mq_dispatch_rq_list().
 		 */
 		list_add_tail(&rq->queuelist, &rq_list);
+		count++;
 		if (rq->mq_hctx != hctx)
 			multi_hctxs = true;
-	} while (++count < max_dispatch);
+
+		/*
+		 * If we cannot get tag for the request, stop dequeueing
+		 * requests from the IO scheduler. We are unlikely to be able
+		 * to submit them anyway and it creates false impression for
+		 * scheduling heuristics that the device can take more IO.
+		 */
+		if (!blk_mq_get_driver_tag(rq))
+			break;
+	} while (count < max_dispatch);
 
 	if (!count) {
 		if (run_queue)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c86c01bfecdb..bc2cf80d2c3b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1100,7 +1100,7 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
 	return true;
 }
 
-static bool blk_mq_get_driver_tag(struct request *rq)
+bool blk_mq_get_driver_tag(struct request *rq)
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9ce64bc4a6c8..81a775171be7 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -259,6 +259,8 @@ static inline void blk_mq_put_driver_tag(struct request *rq)
 	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
 }
 
+bool blk_mq_get_driver_tag(struct request *rq);
+
 static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 {
 	int cpu;
-- 
2.26.2

