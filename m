Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5510122EB6
	for <lists+linux-block@lfdr.de>; Tue, 17 Dec 2019 15:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfLQO2n (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Dec 2019 09:28:43 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:40211 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728896AbfLQO2n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 09:28:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TlCbT0S_1576592909;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TlCbT0S_1576592909)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Dec 2019 22:28:37 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, xlpang@linux.alibaba.com,
        Wen Yang <wenyang@linux.alibaba.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: make the io_ticks counter more accurate
Date:   Tue, 17 Dec 2019 22:28:28 +0800
Message-Id: <20191217142828.79295-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of the jiffies, we should update the io_ticks counter
with the passed in parameter 'now'.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 379f6f5..eb71873 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1365,7 +1365,7 @@ void blk_account_io_done(struct request *req, u64 now)
 		part_stat_lock();
 		part = req->part;
 
-		update_io_ticks(part, jiffies);
+		update_io_ticks(part, now);
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
-- 
1.8.3.1

