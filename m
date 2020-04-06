Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6322A19FE24
	for <lists+linux-block@lfdr.de>; Mon,  6 Apr 2020 21:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgDFTg2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 6 Apr 2020 15:36:28 -0400
Received: from mx1.didichuxing.com ([111.202.154.82]:16581 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1725933AbgDFTg2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Apr 2020 15:36:28 -0400
X-ASG-Debug-ID: 1586201785-0e4108639e378b00001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.235]) by bsf02.didichuxing.com with ESMTP id VVvo7nAv8wFIfdV4; Tue, 07 Apr 2020 03:36:25 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 7 Apr
 2020 03:36:25 +0800
Date:   Tue, 7 Apr 2020 03:36:24 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v3 2/7] block: rename __blk_mq_alloc_rq_maps
Message-ID: <51ece5240eda7e9ab80be0abf784a05fba7eef1a.1586199103.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v3 2/7] block: rename __blk_mq_alloc_rq_maps
Mail-Followup-To: axboe@kernel.dk, linux-block@vger.kernel.org
References: <cover.1586199103.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1586199103.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS02.didichuxing.com (172.20.36.211) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.235]
X-Barracuda-Start-Time: 1586201785
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 975
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81033
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rename __blk_mq_alloc_rq_maps to __blk_mq_alloc_rq_map_and_requests,
this function allocs both map and request, make function name align
with funtion.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3a482ce7ed28..5a322130aaf2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2978,7 +2978,7 @@ void blk_mq_exit_queue(struct request_queue *q)
 	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
 }
 
-static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
+static int __blk_mq_alloc_rq_map_and_requests(struct blk_mq_tag_set *set)
 {
 	int i;
 
@@ -3007,7 +3007,7 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 
 	depth = set->queue_depth;
 	do {
-		err = __blk_mq_alloc_rq_maps(set);
+		err = __blk_mq_alloc_rq_map_and_requests(set);
 		if (!err)
 			break;
 
-- 
2.18.1

