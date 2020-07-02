Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A4B211AB1
	for <lists+linux-block@lfdr.de>; Thu,  2 Jul 2020 05:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgGBDol (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Jul 2020 23:44:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbgGBDol (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Jul 2020 23:44:41 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 32BCFA1ED79A72ABBA2E;
        Thu,  2 Jul 2020 11:44:39 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 11:44:31 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        "Ming Lei" <ming.lei@redhat.com>
CC:     Hulk Robot <hulkci@huawei.com>, <linux-block@vger.kernel.org>
Subject: [PATCH -next] block: remove unused but set variable 'hctx'
Date:   Thu, 2 Jul 2020 11:54:45 +0800
Message-ID: <20200702035445.22780-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hulk Robot <hulkci@huawei.com>

After commit 37f4a24c2469 ("blk-mq: centralise related handling
into blk_mq_get_driver_tag"), 'hctx' is never be used. Gcc report
build warning:

block/blk-flush.c:222:24: warning:
 variable hctx set but not used [-Wunused-but-set-variable]
  222 |  struct blk_mq_hw_ctx *hctx;
      |                        ^~~~

Just removing it to avoid build warning.

Signed-off-by: Hulk Robot <hulkci@huawei.com>
---
 block/blk-flush.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index e756db088d84..a20fe125e9fa 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -219,7 +219,6 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	struct request *rq, *n;
 	unsigned long flags = 0;
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
-	struct blk_mq_hw_ctx *hctx;
 
 	blk_account_io_flush(flush_rq);
 
@@ -235,7 +234,6 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	if (fq->rq_status != BLK_STS_OK)
 		error = fq->rq_status;
 
-	hctx = flush_rq->mq_hctx;
 	if (!q->elevator)
 		flush_rq->tag = BLK_MQ_NO_TAG;
 	else

