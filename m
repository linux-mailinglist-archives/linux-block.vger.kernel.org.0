Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0641BBF89
	for <lists+linux-block@lfdr.de>; Tue, 28 Apr 2020 15:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgD1N35 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Apr 2020 09:29:57 -0400
Received: from mx1.didichuxing.com ([111.202.154.82]:13349 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1726825AbgD1N34 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 09:29:56 -0400
X-ASG-Debug-ID: 1588080591-0e4088442b5603c0001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.175]) by bsf01.didichuxing.com with ESMTP id H7tc4hIPOuxPlAxw; Tue, 28 Apr 2020 21:29:51 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 28 Apr
 2020 21:29:51 +0800
Date:   Tue, 28 Apr 2020 21:29:49 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tom.leiming@gmail.com>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>
Subject: [RESEND v4 3/6] block: refactor __blk_mq_alloc_rq_maps
Message-ID: <099ba8795dd54ad79939ff3c32eca48c665e498f.1588080449.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [RESEND v4 3/6] block: refactor __blk_mq_alloc_rq_maps
Mail-Followup-To: axboe@kernel.dk, tom.leiming@gmail.com,
        bvanassche@acm.org, linux-block@vger.kernel.org
References: <cover.1588080449.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1588080449.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.175]
X-Barracuda-Start-Time: 1588080591
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 3877
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81478
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch add a new member nr_allocated_map_rqs to the
struct blk_mq_tag_set to record the number of maps and requests have
been allocated for this tagset.

Now there are two problems when we increase/decrease hardware queue:

For increase, we do not allocate maps and request for the new
allocated hardware queue, it will be fixed in the next patch.

For decrease, when driver decrease hardware queue, set->nr_hw_queues
will be changed firstly in blk_mq_realloc_tag_set_tags or
__blk_mq_update_nr_hw_queues, then blk_mq_realloc_hw_ctxs and
blk_mq_map_swqueue, even blk_mq_free_tag_set have no chance to free
these hardware queue resource, because they iterate hardware queue by
for (i = 0; i < set->nr_hw_queues; i++).

Since request needs lots of memory, it's not easy alloc so many memory
dynamically, espeicially when system is under memory pressure.

This patch allow nr_hw_queues does not equal to the nr_allocated_map_rqs,
to avoid alloc/free memory when change hardware queue count.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-mq.c         | 26 +++++++++++++++++++-------
 include/linux/blk-mq.h |  1 +
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a79afbe60ca6..8393cb50bdc8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2484,8 +2484,10 @@ static bool __blk_mq_alloc_rq_map(struct blk_mq_tag_set *set, int hctx_idx)
 
 	ret = blk_mq_alloc_rqs(set, set->tags[hctx_idx], hctx_idx,
 				set->queue_depth);
-	if (!ret)
+	if (!ret) {
+		set->nr_allocated_map_rqs++;
 		return true;
+	}
 
 	blk_mq_free_rq_map(set->tags[hctx_idx]);
 	set->tags[hctx_idx] = NULL;
@@ -2499,6 +2501,7 @@ static void blk_mq_free_map_and_requests(struct blk_mq_tag_set *set,
 		blk_mq_free_rqs(set, set->tags[hctx_idx], hctx_idx);
 		blk_mq_free_rq_map(set->tags[hctx_idx]);
 		set->tags[hctx_idx] = NULL;
+		set->nr_allocated_map_rqs--;
 	}
 }
 
@@ -2983,18 +2986,27 @@ void blk_mq_exit_queue(struct request_queue *q)
 	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
 }
 
-static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
+/*
+ * Only append new map and requests, if new > now, all of these maps and
+ * request will be released when cleanup whole tag set. Because requests
+ * will cost lots memory, if system's memory is under a pressure, it's not
+ * easy to allocate too much memory.
+ */
+static int blk_mq_realloc_map_and_requests(struct blk_mq_tag_set *set, int new)
 {
-	int i;
+	int i, now = set->nr_allocated_map_rqs;
+
+	if (new <= now)
+		return 0;
 
-	for (i = 0; i < set->nr_hw_queues; i++)
+	for (i = now; i < new; i++)
 		if (!__blk_mq_alloc_rq_map(set, i))
 			goto out_unwind;
 
 	return 0;
 
 out_unwind:
-	while (--i >= 0)
+	while (--i >= now)
 		blk_mq_free_map_and_requests(set, i);
 
 	return -ENOMEM;
@@ -3012,7 +3024,7 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 
 	depth = set->queue_depth;
 	do {
-		err = __blk_mq_alloc_rq_maps(set);
+		err = blk_mq_realloc_map_and_requests(set, set->nr_hw_queues);
 		if (!err)
 			break;
 
@@ -3189,7 +3201,7 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 {
 	int i, j;
 
-	for (i = 0; i < set->nr_hw_queues; i++)
+	for (i = 0; i < set->nr_allocated_map_rqs; i++)
 		blk_mq_free_map_and_requests(set, i);
 
 	for (j = 0; j < set->nr_maps; j++) {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f389d7c724bd..d950435cd3c6 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -240,6 +240,7 @@ struct blk_mq_tag_set {
 	unsigned int		nr_maps;
 	const struct blk_mq_ops	*ops;
 	unsigned int		nr_hw_queues;
+	unsigned int		nr_allocated_map_rqs;
 	unsigned int		queue_depth;
 	unsigned int		reserved_tags;
 	unsigned int		cmd_size;
-- 
2.18.1

