Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9471A4F8F80
	for <lists+linux-block@lfdr.de>; Fri,  8 Apr 2022 09:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiDHH0q (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 8 Apr 2022 03:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiDHH0p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Apr 2022 03:26:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C057E369E1D;
        Fri,  8 Apr 2022 00:24:41 -0700 (PDT)
Received: from kwepemi100009.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KZV5Q6gtSzBs9J;
        Fri,  8 Apr 2022 15:20:26 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100009.china.huawei.com (7.221.188.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 15:24:39 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 8 Apr
 2022 15:24:38 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <yukuai3@huawei.com>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next RFC v2 3/8] sbitmap: make sure waitqueues are balanced
Date:   Fri, 8 Apr 2022 15:39:11 +0800
Message-ID: <20220408073916.1428590-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220408073916.1428590-1-yukuai3@huawei.com>
References: <20220408073916.1428590-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, same waitqueue might be woken up continuously:

__sbq_wake_up		__sbq_wake_up
 sbq_wake_ptr -> assume	0
			 sbq_wake_ptr -> 0
 atomic_dec_return
			atomic_dec_return
 atomic_cmpxchg -> succeed
			 atomic_cmpxchg -> failed
			  return true

			__sbq_wake_up
			 sbq_wake_ptr
			  atomic_read(&sbq->wake_index) -> still 0
 sbq_index_atomic_inc -> inc to 1
			  if (waitqueue_active(&ws->wait))
			   if (wake_index != atomic_read(&sbq->wake_index))
			    atomic_set -> reset from 1 to 0
 wake_up_nr -> wake up first waitqueue
			    // continue to wake up in first waitqueue

What's worse, io hung is possible in theory because wake up might be
missed. For example, 2 * wake_batch tags are put, while only wake_batch
threads are worken:

__sbq_wake_up
 atomic_cmpxchg -> reset wait_cnt
			__sbq_wake_up -> decrease wait_cnt
			...
			__sbq_wake_up -> wait_cnt is decreased to 0 again
			 atomic_cmpxchg
			 sbq_index_atomic_inc -> increase wake_index
			 wake_up_nr -> wake up and waitqueue might be empty
 sbq_index_atomic_inc -> increase again, one waitqueue is skipped
 wake_up_nr -> invalid wake up because old wakequeue might be empty

To fix the problem, refactor to make sure waitqueues will be woken up
one by one, and also choose the next waitqueue by the number of threads
that are waiting to keep waitqueues balanced.

Test cmd: nr_requests is 64, and queue_depth is 32
[global]
filename=/dev/sda
ioengine=libaio
direct=1
allow_mounted_write=0
group_reporting

[test]
rw=randwrite
bs=4k
numjobs=512
iodepth=2

Before this patch, waitqueues can be extremly unbalanced, for example:
ws_active=484
ws={
        {.wait_cnt=8, .waiters_cnt=117},
        {.wait_cnt=8, .waiters_cnt=59},
        {.wait_cnt=8, .waiters_cnt=76},
        {.wait_cnt=8, .waiters_cnt=0},
        {.wait_cnt=5, .waiters_cnt=24},
        {.wait_cnt=8, .waiters_cnt=12},
        {.wait_cnt=8, .waiters_cnt=21},
        {.wait_cnt=8, .waiters_cnt=175},
}

With this patch, waitqueues is always balanced, for example:
ws_active=477
ws={
        {.wait_cnt=8, .waiters_cnt=59},
        {.wait_cnt=6, .waiters_cnt=62},
        {.wait_cnt=8, .waiters_cnt=61},
        {.wait_cnt=8, .waiters_cnt=60},
        {.wait_cnt=8, .waiters_cnt=63},
        {.wait_cnt=8, .waiters_cnt=56},
        {.wait_cnt=8, .waiters_cnt=59},
        {.wait_cnt=8, .waiters_cnt=57},
}

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/sbitmap.c | 81 ++++++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 393f2b71647a..176fba0252d7 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -575,68 +575,71 @@ void sbitmap_queue_min_shallow_depth(struct sbitmap_queue *sbq,
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_min_shallow_depth);
 
-static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
+/* always choose the 'ws' with the max waiters */
+static void sbq_update_wake_index(struct sbitmap_queue *sbq,
+				  int old_wake_index)
 {
-	int i, wake_index;
+	int index, wake_index;
+	int max_waiters = 0;
 
-	if (!atomic_read(&sbq->ws_active))
-		return NULL;
+	if (old_wake_index != atomic_read(&sbq->wake_index))
+		return;
 
-	wake_index = atomic_read(&sbq->wake_index);
-	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
-		struct sbq_wait_state *ws = &sbq->ws[wake_index];
+	for (wake_index = 0; wake_index < SBQ_WAIT_QUEUES; wake_index++) {
+		struct sbq_wait_state *ws;
+		int waiters;
 
-		if (waitqueue_active(&ws->wait)) {
-			if (wake_index != atomic_read(&sbq->wake_index))
-				atomic_set(&sbq->wake_index, wake_index);
-			return ws;
-		}
+		if (wake_index == old_wake_index)
+			continue;
 
-		wake_index = sbq_index_inc(wake_index);
+		ws = &sbq->ws[wake_index];
+		waiters = atomic_read(&ws->waiters_cnt);
+		if (waiters > max_waiters) {
+			max_waiters = waiters;
+			index = wake_index;
+		}
 	}
 
-	return NULL;
+	if (max_waiters)
+		atomic_cmpxchg(&sbq->wake_index, old_wake_index, index);
 }
 
 static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 {
 	struct sbq_wait_state *ws;
 	unsigned int wake_batch;
-	int wait_cnt;
+	int wait_cnt, wake_index;
 
-	ws = sbq_wake_ptr(sbq);
-	if (!ws)
+	if (!atomic_read(&sbq->ws_active))
 		return false;
 
+	wake_index = atomic_read(&sbq->wake_index);
+	ws = &sbq->ws[wake_index];
 	wait_cnt = atomic_dec_return(&ws->wait_cnt);
-	if (wait_cnt <= 0) {
-		int ret;
-
-		wake_batch = READ_ONCE(sbq->wake_batch);
-
-		/*
-		 * Pairs with the memory barrier in sbitmap_queue_resize() to
-		 * ensure that we see the batch size update before the wait
-		 * count is reset.
-		 */
-		smp_mb__before_atomic();
-
+	if (wait_cnt > 0) {
+		return false;
+	} else if (wait_cnt < 0) {
 		/*
-		 * For concurrent callers of this, the one that failed the
-		 * atomic_cmpxhcg() race should call this function again
+		 * Concurrent callers should call this function again
 		 * to wakeup a new batch on a different 'ws'.
 		 */
-		ret = atomic_cmpxchg(&ws->wait_cnt, wait_cnt, wake_batch);
-		if (ret == wait_cnt) {
-			sbq_index_atomic_inc(&sbq->wake_index);
-			wake_up_nr(&ws->wait, wake_batch);
-			return false;
-		}
-
+		sbq_update_wake_index(sbq, wake_index);
 		return true;
 	}
 
-	return false;
+	sbq_update_wake_index(sbq, wake_index);
+	wake_batch = READ_ONCE(sbq->wake_batch);
+
+	/*
+	 * Pairs with the memory barrier in sbitmap_queue_resize() to
+	 * ensure that we see the batch size update before the wait
+	 * count is reset.
+	 */
+	smp_mb__before_atomic();
+	atomic_set(&ws->wait_cnt, wake_batch);
+	wake_up_nr(&ws->wait, wake_batch);
+
+	return true;
 }
 
 void sbitmap_queue_wake_up(struct sbitmap_queue *sbq)
-- 
2.31.1

