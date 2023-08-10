Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F38776ECB
	for <lists+linux-block@lfdr.de>; Thu, 10 Aug 2023 05:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjHJDyk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Aug 2023 23:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjHJDyg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 23:54:36 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BC4E5F;
        Wed,  9 Aug 2023 20:54:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RLtN45QlQz4f3kFj;
        Thu, 10 Aug 2023 11:54:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgA3xqh1X9RksnRqAQ--.45635S4;
        Thu, 10 Aug 2023 11:54:31 +0800 (CST)
From:   Li Lingfeng <lilingfeng@huaweicloud.com>
To:     tj@kernel.org
Cc:     josef@toxicpanda.com, axboe@kernel.dk, mkoutny@suse.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        yukuai3@huawei.com, linan122@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com,
        lilingfeng3@huawei.com
Subject: [PATCH -next v3] block: remove init_mutex and open-code blk_iolatency_try_init
Date:   Thu, 10 Aug 2023 11:51:11 +0800
Message-Id: <20230810035111.2236335-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3xqh1X9RksnRqAQ--.45635S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW8GF48WFWkJr4DCF1fXrb_yoW8Kw1Up3
        ySgrsIy3yUGrs3XF1kKw4xur15K3y8Kry7GF4fCFyrJr1j9r1agF18ZF1FqFWfZrZ5Aan5
        KF48J34kGr4rG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        fUoOJ5UUUUU
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Li Lingfeng <lilingfeng3@huawei.com>

Commit a13696b83da4 ("blk-iolatency: Make initialization lazy") adds
a mutex named "init_mutex" in blk_iolatency_try_init for the race
condition of initializing RQ_QOS_LATENCY.
Now a new lock has been add to struct request_queue by commit a13bd91be223
("block/rq_qos: protect rq_qos apis with a new lock"). And it has been
held in blkg_conf_open_bdev before calling blk_iolatency_init.
So it's not necessary to keep init_mutex in blk_iolatency_try_init, just
remove it.

Since init_mutex has been removed, blk_iolatency_try_init can be
open-coded back to iolatency_set_limit() like ioc_qos_write().

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
  v1->v2: open-code blk_iolatency_try_init()
  v2->v3: add lockdep check
 block/blk-iolatency.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index fd5fec989e39..c16aef4be036 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -824,29 +824,6 @@ static void iolatency_clear_scaling(struct blkcg_gq *blkg)
 	}
 }
 
-static int blk_iolatency_try_init(struct blkg_conf_ctx *ctx)
-{
-	static DEFINE_MUTEX(init_mutex);
-	int ret;
-
-	ret = blkg_conf_open_bdev(ctx);
-	if (ret)
-		return ret;
-
-	/*
-	 * blk_iolatency_init() may fail after rq_qos_add() succeeds which can
-	 * confuse iolat_rq_qos() test. Make the test and init atomic.
-	 */
-	mutex_lock(&init_mutex);
-
-	if (!iolat_rq_qos(ctx->bdev->bd_queue))
-		ret = blk_iolatency_init(ctx->bdev->bd_disk);
-
-	mutex_unlock(&init_mutex);
-
-	return ret;
-}
-
 static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 			     size_t nbytes, loff_t off)
 {
@@ -861,7 +838,17 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 
 	blkg_conf_init(&ctx, buf);
 
-	ret = blk_iolatency_try_init(&ctx);
+	ret = blkg_conf_open_bdev(&ctx);
+	if (ret)
+		goto out;
+
+	/*
+	 * blk_iolatency_init() may fail after rq_qos_add() succeeds which can
+	 * confuse iolat_rq_qos() test. Make the test and init atomic.
+	 */
+	lockdep_assert_held(ctx.bdev->bd_queue->rq_qos_mutex);
+	if (!iolat_rq_qos(ctx.bdev->bd_queue))
+		ret = blk_iolatency_init(ctx.bdev->bd_disk);
 	if (ret)
 		goto out;
 
-- 
2.39.2

