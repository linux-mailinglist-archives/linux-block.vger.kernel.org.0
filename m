Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1DB012A9F5
	for <lists+linux-block@lfdr.de>; Thu, 26 Dec 2019 04:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLZDKf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Dec 2019 22:10:35 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:47498 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726885AbfLZDKf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Dec 2019 22:10:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TlwmUT6_1577329818;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TlwmUT6_1577329818)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Dec 2019 11:10:33 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, xlpang@linux.alibaba.com,
        Wen Yang <wenyang@linux.alibaba.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: make the io_ticks counter more accurate
Date:   Thu, 26 Dec 2019 11:10:14 +0800
Message-Id: <20191226031014.58970-1-wenyang@linux.alibaba.com>
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
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
v2->v1: Use the same clock source for io_ticks and other statistics in the diskstats

 block/blk-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 379f6f5..da7de9f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1365,7 +1365,7 @@ void blk_account_io_done(struct request *req, u64 now)
 		part_stat_lock();
 		part = req->part;
 
-		update_io_ticks(part, jiffies);
+		update_io_ticks(part, nsecs_to_jiffies(now));
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
@@ -1407,7 +1407,7 @@ void blk_account_io_start(struct request *rq, bool new_io)
 		rq->part = part;
 	}
 
-	update_io_ticks(part, jiffies);
+	update_io_ticks(part, nsecs_to_jiffies(ktime_get_ns()));
 
 	part_stat_unlock();
 }
-- 
1.8.3.1

