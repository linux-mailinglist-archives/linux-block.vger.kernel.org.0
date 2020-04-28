Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAAA1BBF8C
	for <lists+linux-block@lfdr.de>; Tue, 28 Apr 2020 15:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgD1NaU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Apr 2020 09:30:20 -0400
Received: from mx2.didichuxing.com ([36.110.17.22]:14379 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1726825AbgD1NaT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 09:30:19 -0400
X-ASG-Debug-ID: 1588080614-0e4088442c560450001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.211]) by bsf01.didichuxing.com with ESMTP id ZYI8CH5czSgJj3qa; Tue, 28 Apr 2020 21:30:14 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 28 Apr
 2020 21:30:14 +0800
Date:   Tue, 28 Apr 2020 21:30:13 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tom.leiming@gmail.com>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>
Subject: [RESEND v4 5/6] block: rename __blk_mq_alloc_rq_map
Message-ID: <f39d442afa7e37bf144954f3f65a1c46a6b6fa91.1588080449.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [RESEND v4 5/6] block: rename __blk_mq_alloc_rq_map
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
X-Barracuda-Connect: localhost[172.20.36.211]
X-Barracuda-Start-Time: 1588080614
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1451
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

rename __blk_mq_alloc_rq_map to __blk_mq_alloc_map_and_request,
actually it alloc both map and request, make function name
align with function.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-mq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1c360b69155c..b6c907dbbb30 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2473,7 +2473,7 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 	}
 }
 
-static bool __blk_mq_alloc_rq_map(struct blk_mq_tag_set *set, int hctx_idx)
+static bool __blk_mq_alloc_map_and_request(struct blk_mq_tag_set *set, int hctx_idx)
 {
 	int ret = 0;
 
@@ -2527,7 +2527,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		hctx_idx = set->map[HCTX_TYPE_DEFAULT].mq_map[i];
 		/* unmapped hw queue can be remapped after CPU topo changed */
 		if (!set->tags[hctx_idx] &&
-		    !__blk_mq_alloc_rq_map(set, hctx_idx)) {
+		    !__blk_mq_alloc_map_and_request(set, hctx_idx)) {
 			/*
 			 * If tags initialization fail for some hctx,
 			 * that hctx won't be brought online.  In this
@@ -3000,7 +3000,7 @@ static int blk_mq_realloc_map_and_requests(struct blk_mq_tag_set *set, int new)
 		return 0;
 
 	for (i = now; i < new; i++)
-		if (!__blk_mq_alloc_rq_map(set, i))
+		if (!__blk_mq_alloc_map_and_request(set, i))
 			goto out_unwind;
 
 	return 0;
-- 
2.18.1

