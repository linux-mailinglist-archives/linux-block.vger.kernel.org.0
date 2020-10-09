Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349772880B3
	for <lists+linux-block@lfdr.de>; Fri,  9 Oct 2020 05:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbgJIDXc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 8 Oct 2020 23:23:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731496AbgJIDXc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 23:23:32 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3B973270E6E465FA9B43;
        Fri,  9 Oct 2020 11:23:29 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 11:23:26 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>
Subject: [RESEND PATCH v2 7/7] blk-mq: get rid of the dead flush handle code path
Date:   Thu, 8 Oct 2020 23:26:33 -0400
Message-ID: <20201009032633.83645-8-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201009032633.83645-1-yuyufen@huawei.com>
References: <20201009032633.83645-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After commit 923218f6166a ("blk-mq: don't allocate driver tag upfront
for flush rq"), blk_mq_submit_bio() will call blk_insert_flush()
directly to handle flush request rather than blk_mq_sched_insert_request()
in the case of elevator.

Then, all flush request either have set RQF_FLUSH_SEQ flag when call
blk_mq_sched_insert_request(), or have inserted into hctx->dispatch.
So, remove the dead code path.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-mq-sched.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index d2790e5b06d1..606298fff5db 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -525,12 +525,6 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
-	/* flush rq in flush machinery need to be dispatched directly */
-	if (!(rq->rq_flags & RQF_FLUSH_SEQ) && op_is_flush(rq->cmd_flags)) {
-		blk_insert_flush(rq);
-		goto run;
-	}
-
 	WARN_ON(e && (rq->tag != -1));
 
 	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
-- 
2.25.4

