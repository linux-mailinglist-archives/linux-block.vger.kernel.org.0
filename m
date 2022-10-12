Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A165FC2E5
	for <lists+linux-block@lfdr.de>; Wed, 12 Oct 2022 11:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJLJSa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Oct 2022 05:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJLJS2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 05:18:28 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E32FBC468;
        Wed, 12 Oct 2022 02:18:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MnRq02R0gzl4KT;
        Wed, 12 Oct 2022 17:16:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgAnKMpehkZjlH+ZAA--.8980S6;
        Wed, 12 Oct 2022 17:18:24 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        linan122@huawei.com
Subject: [PATCH v2 2/4] blk-iocost: don't release 'ioc->lock' while updating params
Date:   Wed, 12 Oct 2022 17:40:33 +0800
Message-Id: <20221012094035.390056-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221012094035.390056-1-yukuai1@huaweicloud.com>
References: <20221012094035.390056-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnKMpehkZjlH+ZAA--.8980S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAr18ZFW8JFyfAw4rCF17KFg_yoW5CF1rpF
        yFg39Iq3yjyrn2vrnFgrsY9r1ru397KryxAFykJrn3Jr12qrnaqF1DCry09FyUtFWfJrZ8
        XrWrX3yFyF4UArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

ioc_qos_write() and ioc_cost_model_write() are the same:

1) hold lock to read 'ioc->params' to local variable;
2) update params to local variable without lock;
3) hold lock to write local variable to 'ioc->params';

In theroy, if user updates params concurrenty, the params might be lost:

t1: update params a		t2: update params b
spin_lock_irq(&ioc->lock);
memcpy(qos, ioc->params.qos, sizeof(qos))
spin_unlock_irq(&ioc->lock);

qos[a] = xxx;

				spin_lock_irq(&ioc->lock);
				memcpy(qos, ioc->params.qos, sizeof(qos))
				spin_unlock_irq(&ioc->lock);

				qos[b] = xxx;

spin_lock_irq(&ioc->lock);
memcpy(ioc->params.qos, qos, sizeof(qos));
ioc_refresh_params(ioc, true);
spin_unlock_irq(&ioc->lock);

				spin_lock_irq(&ioc->lock);
				// updates of a will be lost
				memcpy(ioc->params.qos, qos, sizeof(qos));
				ioc_refresh_params(ioc, true);
				spin_unlock_irq(&ioc->lock);

Althrough this is not common case, the problem can by fixed easily by
holding the lock through the read, update, write process.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 08036476e6fa..6d36a4bd4382 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3191,7 +3191,6 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	memcpy(qos, ioc->params.qos, sizeof(qos));
 	enable = ioc->enabled;
 	user = ioc->user_qos_params;
-	spin_unlock_irq(&ioc->lock);
 
 	while ((p = strsep(&input, " \t\n"))) {
 		substring_t args[MAX_OPT_ARGS];
@@ -3258,8 +3257,6 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	if (qos[QOS_MIN] > qos[QOS_MAX])
 		goto einval;
 
-	spin_lock_irq(&ioc->lock);
-
 	if (enable) {
 		blk_stat_enable_accounting(disk->queue);
 		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
@@ -3284,6 +3281,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	blkdev_put_no_open(bdev);
 	return nbytes;
 einval:
+	spin_unlock_irq(&ioc->lock);
 	ret = -EINVAL;
 err:
 	blkdev_put_no_open(bdev);
@@ -3359,7 +3357,6 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	spin_lock_irq(&ioc->lock);
 	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
 	user = ioc->user_cost_model;
-	spin_unlock_irq(&ioc->lock);
 
 	while ((p = strsep(&input, " \t\n"))) {
 		substring_t args[MAX_OPT_ARGS];
@@ -3396,7 +3393,6 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 		user = true;
 	}
 
-	spin_lock_irq(&ioc->lock);
 	if (user) {
 		memcpy(ioc->params.i_lcoefs, u, sizeof(u));
 		ioc->user_cost_model = true;
@@ -3410,6 +3406,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	return nbytes;
 
 einval:
+	spin_unlock_irq(&ioc->lock);
 	ret = -EINVAL;
 err:
 	blkdev_put_no_open(bdev);
-- 
2.31.1

