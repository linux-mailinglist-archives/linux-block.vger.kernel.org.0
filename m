Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17305A0791
	for <lists+linux-block@lfdr.de>; Thu, 25 Aug 2022 05:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiHYDR0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Aug 2022 23:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiHYDRY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Aug 2022 23:17:24 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9457B1E7
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 20:17:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=gumi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VNBLGlP_1661397432;
Received: from nu1m11355.sqa.nu8.tbsite.net(mailfrom:gumi@linux.alibaba.com fp:SMTPD_---0VNBLGlP_1661397432)
          by smtp.aliyun-inc.com;
          Thu, 25 Aug 2022 11:17:17 +0800
From:   Gu Mi <gumi@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Gu Mi <gumi@linux.alibaba.com>
Subject: [PATCH] block: I/O error occurs during SATA disk stress test
Date:   Thu, 25 Aug 2022 11:17:10 +0800
Message-Id: <1661397430-117734-1-git-send-email-gumi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The problem occurs in two async processes, One is when a new IO
calls the blk_mq_start_request() interface to start sending,The other
is that the block layer timer process calls the blk_mq_req_expired
interface to check whether there is an IO timeout.

When an instruction out of sequence occurs between blk_add_timer
and WRITE_ONCE(rq->state,MQ_RQ_IN_FLIGHT) in the interface
blk_mq_start_request,at this time, the block timer is checking the
new IO timeout, Since the req status has been set to MQ_RQ_IN_FLIGHT
and req->deadline is 0 at this time, the new IO will be misjudged as
a timeout.

Our repair plan is for the deadline to be 0, and we do not think
that a timeout occurs. At the same time, because the jiffies of the
32-bit system will be reversed shortly after the system is turned on,
we will add 1 jiffies to the deadline at this time.

Signed-off-by: Gu Mi <gumi@linux.alibaba.com>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b90d2d..6defaa1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1451,6 +1451,8 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 		return false;
 
 	deadline = READ_ONCE(rq->deadline);
+	if (unlikely(deadline == 0))
+		return false;
 	if (time_after_eq(jiffies, deadline))
 		return true;
 
-- 
1.8.3.1

