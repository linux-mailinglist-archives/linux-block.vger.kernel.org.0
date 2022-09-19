Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304895BC10F
	for <lists+linux-block@lfdr.de>; Mon, 19 Sep 2022 03:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiISBiy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 18 Sep 2022 21:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiISBiw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2022 21:38:52 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64C9186CD;
        Sun, 18 Sep 2022 18:38:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MW6jd1nW6zlCC0;
        Mon, 19 Sep 2022 09:37:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgA3inMmyCdjeiM6BA--.44102S7;
        Mon, 19 Sep 2022 09:38:48 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next 3/3] blk-wbt: don't enable throttling if default elevator is bfq
Date:   Mon, 19 Sep 2022 09:49:39 +0800
Message-Id: <20220919014939.175497-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220919014939.175497-1-yukuai1@huaweicloud.com>
References: <20220919014939.175497-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA3inMmyCdjeiM6BA--.44102S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1kCw15ZFW3Ar47Kw1Dtrb_yoW5uw47p3
        yUGF4FkFW2gF409FWxJrnrXw43Gw4kCry7Gry8C3yFqry2krZFva1vkF1UZF1vvrZ7CFsF
        vr48trZrXF40gw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4q2_UUUUU=
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

Commit b5dc5d4d1f4f ("block,bfq: Disable writeback throttling") tries to
disable wbt for bfq, it's done by calling wbt_disable_default() in
bfq_init_queue(). However, wbt is still enabled if default elevator is
bfq:

device_add_disk
 elevator_init_mq
  bfq_init_queue
   wbt_disable_default -> done nothing

 blk_register_queue
  wbt_enable_default -> wbt is enabled

Fix the problem by checking elevator name if wbt_enable_default() is
called from blk_register_queue().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 2 +-
 block/blk-sysfs.c   | 2 +-
 block/blk-wbt.c     | 7 ++++++-
 block/blk-wbt.h     | 5 +++--
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7ea427817f7f..f769c90744fd 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7045,7 +7045,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 #endif
 
 	blk_stat_disable_accounting(bfqd->queue);
-	wbt_enable_default(bfqd->queue);
+	wbt_enable_default(bfqd->queue, false);
 
 	kfree(bfqd);
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1955bb6a284d..3e8adb95ff02 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -850,7 +850,7 @@ int blk_register_queue(struct gendisk *disk)
 		goto put_dev;
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
-	wbt_enable_default(q);
+	wbt_enable_default(q, true);
 	blk_throtl_register_queue(q);
 
 	/* Now everything is ready and send out KOBJ_ADD uevent */
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 68851c2c02d2..54acde63538d 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -27,6 +27,7 @@
 
 #include "blk-wbt.h"
 #include "blk-rq-qos.h"
+#include "elevator.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/wbt.h>
@@ -643,10 +644,14 @@ void wbt_set_write_cache(struct request_queue *q, bool write_cache_on)
 /*
  * Enable wbt if defaults are configured that way
  */
-void wbt_enable_default(struct request_queue *q)
+void wbt_enable_default(struct request_queue *q, bool check_elevator)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
 
+	if (check_elevator && q->elevator &&
+	    check_elevator_name(q->elevator, "bfq"))
+		return;
+
 	/* Throttling already enabled? */
 	if (rqos) {
 		if (RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 018d3a14cc30..4252b8077257 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -90,7 +90,7 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 
 int wbt_init(struct request_queue *);
 void wbt_disable_default(struct request_queue *);
-void wbt_enable_default(struct request_queue *);
+void wbt_enable_default(struct request_queue *, bool);
 
 u64 wbt_get_min_lat(struct request_queue *q);
 void wbt_set_min_lat(struct request_queue *q, u64 val);
@@ -109,7 +109,8 @@ static inline int wbt_init(struct request_queue *q)
 static inline void wbt_disable_default(struct request_queue *q)
 {
 }
-static inline void wbt_enable_default(struct request_queue *q)
+static inline void wbt_enable_default(struct request_queue *q,
+				      bool check_elevator)
 {
 }
 static inline void wbt_set_write_cache(struct request_queue *q, bool wc)
-- 
2.31.1

