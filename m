Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4681427D1
	for <lists+linux-block@lfdr.de>; Mon, 20 Jan 2020 11:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgATKEy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Jan 2020 05:04:54 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:40616 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbgATKEy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jan 2020 05:04:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ToE0t8W_1579514685;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0ToE0t8W_1579514685)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Jan 2020 18:04:51 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Wen Yang <wenyang@linux.alibaba.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block, bfq: improve arithmetic division in bfq_delta()
Date:   Mon, 20 Jan 2020 18:04:43 +0800
Message-Id: <20200120100443.45563-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

do_div() does a 64-by-32 division. Use div64_ul() instead of it
if the divisor is unsigned long, to avoid truncation to 32-bit.
And as a nice side effect also cleans up the function a bit.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 block/bfq-wf2q.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 05f0bf4a1144..ffe9ce9faa89 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -277,10 +277,7 @@ struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity)
  */
 static u64 bfq_delta(unsigned long service, unsigned long weight)
 {
-	u64 d = (u64)service << WFQ_SERVICE_SHIFT;
-
-	do_div(d, weight);
-	return d;
+	return div64_ul((u64)service << WFQ_SERVICE_SHIFT, weight);
 }
 
 /**
-- 
2.23.0

