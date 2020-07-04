Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF09B214478
	for <lists+linux-block@lfdr.de>; Sat,  4 Jul 2020 09:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGDH2d (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 4 Jul 2020 03:28:33 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:53957 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbgGDH2d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 4 Jul 2020 03:28:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U1eK0P2_1593847710;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U1eK0P2_1593847710)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 04 Jul 2020 15:28:30 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: Remove unnecessary validation before calling blk_mq_sched_completed_request()
Date:   Sat,  4 Jul 2020 15:28:21 +0800
Message-Id: <969d0e9f637b2a0dbfb3d284abfbed6fc7665ea4.1593846855.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We've already validated the 'q->elevator' before calling ->ops.completed_request()
in blk_mq_sched_completed_request(), thus no need to validate rq->internal_tag again,
and remove it.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-mq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index abcf590f6238..78572b2e1675 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -550,8 +550,7 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 		blk_stat_add(rq, now);
 	}
 
-	if (rq->internal_tag != BLK_MQ_NO_TAG)
-		blk_mq_sched_completed_request(rq, now);
+	blk_mq_sched_completed_request(rq, now);
 
 	blk_account_io_done(rq, now);
 
-- 
2.17.1

