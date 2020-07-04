Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8F6214476
	for <lists+linux-block@lfdr.de>; Sat,  4 Jul 2020 09:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgGDH07 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 4 Jul 2020 03:26:59 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:52822 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbgGDH06 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 4 Jul 2020 03:26:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U1eGavH_1593847613;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U1eGavH_1593847613)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 04 Jul 2020 15:26:53 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: Remove unnecessary local variable
Date:   Sat,  4 Jul 2020 15:26:14 +0800
Message-Id: <37baa5f3d47675b782652c85acf303662368e99f.1593846844.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove unnecessary local variable 'ret' in blk_mq_dispatch_hctx_list().

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-mq-sched.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 1c52e56a19b1..b8db72cf1043 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -96,7 +96,6 @@ static bool blk_mq_dispatch_hctx_list(struct list_head *rq_list)
 	struct request *rq;
 	LIST_HEAD(hctx_list);
 	unsigned int count = 0;
-	bool ret;
 
 	list_for_each_entry(rq, rq_list, queuelist) {
 		if (rq->mq_hctx != hctx) {
@@ -108,8 +107,7 @@ static bool blk_mq_dispatch_hctx_list(struct list_head *rq_list)
 	list_splice_tail_init(rq_list, &hctx_list);
 
 dispatch:
-	ret = blk_mq_dispatch_rq_list(hctx, &hctx_list, count);
-	return ret;
+	return blk_mq_dispatch_rq_list(hctx, &hctx_list, count);
 }
 
 #define BLK_MQ_BUDGET_DELAY	3		/* ms units */
-- 
2.17.1

