Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64376521646
	for <lists+linux-block@lfdr.de>; Tue, 10 May 2022 15:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242210AbiEJNGr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 10 May 2022 09:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242201AbiEJNGi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 09:06:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D02026195A;
        Tue, 10 May 2022 06:02:38 -0700 (PDT)
Received: from kwepemi500003.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KyJ852rZWz1JBxP;
        Tue, 10 May 2022 21:01:25 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500003.china.huawei.com (7.221.188.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 21:02:36 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 21:02:35 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next 2/2] block, bfq: make bfq_has_work() more accurate
Date:   Tue, 10 May 2022 21:16:29 +0800
Message-ID: <20220510131629.1964415-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220510131629.1964415-1-yukuai3@huawei.com>
References: <20220510131629.1964415-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bfq_has_work() is using busy_queues currently, which is not accurate
because bfq_queue is busy doesn't represent that it has requests. Since
bfqd aready has a counter 'queued' to record how many requests are in
bfq, use it instead of busy_queues.

Noted that bfq_has_work() can be called with 'bfqd->lock' held, thus the
lock can't be held in bfq_has_work() to protect 'bfqd->queued'.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 61750696e87f..1d2f8110c26b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5063,11 +5063,11 @@ static bool bfq_has_work(struct blk_mq_hw_ctx *hctx)
 	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
 
 	/*
-	 * Avoiding lock: a race on bfqd->busy_queues should cause at
+	 * Avoiding lock: a race on bfqd->queued should cause at
 	 * most a call to dispatch for nothing
 	 */
 	return !list_empty_careful(&bfqd->dispatch) ||
-		bfq_tot_busy_queues(bfqd) > 0;
+		READ_ONCE(bfqd->queued);
 }
 
 static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
-- 
2.31.1

