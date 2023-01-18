Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECC5671028
	for <lists+linux-block@lfdr.de>; Wed, 18 Jan 2023 02:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjARBjN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Jan 2023 20:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjARBjG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 20:39:06 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F6051404;
        Tue, 17 Jan 2023 17:39:04 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NxT1t73qPz4f4fws;
        Wed, 18 Jan 2023 09:38:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDnjOqxTcdjBACUBw--.30342S11;
        Wed, 18 Jan 2023 09:39:01 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com, jack@suse.cz
Subject: [PATCH v4 10/14] blk-mq: simplify flush check in blk_mq_dispatch_rq_list
Date:   Wed, 18 Jan 2023 17:37:22 +0800
Message-Id: <20230118093726.3939160-10-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230118093726.3939160-1-shikemeng@huaweicloud.com>
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnjOqxTcdjBACUBw--.30342S11
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW7tr1DXFW7tryrWr43Awb_yoW8Xr4DpF
        W3Ca9Fkr4agw42yry8CaykG3WDAwsYkFn8WrZ3Cw1agF45Cr4xtrWSgw47WFWkArsaya1a
        qFWUWFWjvFyUXa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU058n7UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

1. Remove check of needs_resource and ret == BLK_STS_DEV_RESOURCE.
For busy error BLK_STS*_RESOURCE, request will always be added
back to list, so need_resource will not be true and ret will
not be == BLK_STS_DEV_RESOURCE if list is empty. We could remove
these dead check.

2. Check ret of last request instead of errors
If list is empty, we only need to explicitly commit_rqs
if error happens at last request which is stored in ret. So check
ret of last request instead of errors to remove unnecessary
commit_rqs triggered by errors returned from previous request.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c945a4602849..d4fdb01475b6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2108,9 +2108,9 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	/* If we didn't flush the entire list, we could have told the driver
 	 * there was more coming, but that turned out to be a lie.
 	 */
-	if ((!list_empty(list) || errors || needs_resource ||
-	     ret == BLK_STS_DEV_RESOURCE) && q->mq_ops->commit_rqs && queued)
-		q->mq_ops->commit_rqs(hctx);
+	if (!list_empty(list) || ret != BLK_STS_OK)
+		blk_mq_commit_rqs(hctx, queued, false);
+
 	/*
 	 * Any items that need requeuing? Stuff them into hctx->dispatch,
 	 * that is where we will continue on next queue run.
-- 
2.30.0

