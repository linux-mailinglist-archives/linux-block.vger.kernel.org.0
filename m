Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B4C2C5199
	for <lists+linux-block@lfdr.de>; Thu, 26 Nov 2020 10:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbgKZJsg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Nov 2020 04:48:36 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:57658 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgKZJsg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 04:48:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UGarA.G_1606384113;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UGarA.G_1606384113)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Nov 2020 17:48:34 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: [PATCH] block: fix inflight statistics of part0
Date:   Thu, 26 Nov 2020 17:48:33 +0800
Message-Id: <20201126094833.61309-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The inflight of partition 0 doesn't include inflight IOs to all
sub-partitions, since currently mq calculates inflight of specific
partition by simply camparing the value of the partition pointer.

Thus the following case is possible:

$ cat /sys/block/vda/inflight
       0        0
$ cat /sys/block/vda/vda1/inflight
       0      128

Partition 0 should be specially handled since it represents the whole
disk.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5dc032..04b6b4d21ce6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -105,7 +105,8 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 {
 	struct mq_inflight *mi = priv;
 
-	if (rq->part == mi->part && blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
+	if ((!mi->part->partno || rq->part == mi->part) &&
+	    blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
 		mi->inflight[rq_data_dir(rq)]++;
 
 	return true;
-- 
2.27.0

