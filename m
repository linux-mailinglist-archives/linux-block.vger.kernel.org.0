Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38154CB72A
	for <lists+linux-block@lfdr.de>; Thu,  3 Mar 2022 07:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiCCGs6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 3 Mar 2022 01:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCCGs5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 01:48:57 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520FD443E2;
        Wed,  2 Mar 2022 22:48:12 -0800 (PST)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K8M2h297fzBrW5;
        Thu,  3 Mar 2022 14:46:20 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 3 Mar 2022 14:48:09 +0800
From:   Zhang Wensheng <zhangwensheng5@huawei.com>
To:     <paolo.valente@linaro.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <zhangwensheng5@huawei.com>
Subject: [PATCH -next v4] bfq: fix use-after-free in bfq_dispatch_request
Date:   Thu, 3 Mar 2022 15:03:34 +0800
Message-ID: <20220303070334.3020168-1-zhangwensheng5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

KASAN reports a use-after-free report when doing normal scsi-mq test

[69832.239032] ==================================================================
[69832.241810] BUG: KASAN: use-after-free in bfq_dispatch_request+0x1045/0x44b0
[69832.243267] Read of size 8 at addr ffff88802622ba88 by task kworker/3:1H/155
[69832.244656]
[69832.245007] CPU: 3 PID: 155 Comm: kworker/3:1H Not tainted 5.10.0-10295-g576c6382529e #8
[69832.246626] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[69832.249069] Workqueue: kblockd blk_mq_run_work_fn
[69832.250022] Call Trace:
[69832.250541]  dump_stack+0x9b/0xce
[69832.251232]  ? bfq_dispatch_request+0x1045/0x44b0
[69832.252243]  print_address_description.constprop.6+0x3e/0x60
[69832.253381]  ? __cpuidle_text_end+0x5/0x5
[69832.254211]  ? vprintk_func+0x6b/0x120
[69832.254994]  ? bfq_dispatch_request+0x1045/0x44b0
[69832.255952]  ? bfq_dispatch_request+0x1045/0x44b0
[69832.256914]  kasan_report.cold.9+0x22/0x3a
[69832.257753]  ? bfq_dispatch_request+0x1045/0x44b0
[69832.258755]  check_memory_region+0x1c1/0x1e0
[69832.260248]  bfq_dispatch_request+0x1045/0x44b0
[69832.261181]  ? bfq_bfqq_expire+0x2440/0x2440
[69832.262032]  ? blk_mq_delay_run_hw_queues+0xf9/0x170
[69832.263022]  __blk_mq_do_dispatch_sched+0x52f/0x830
[69832.264011]  ? blk_mq_sched_request_inserted+0x100/0x100
[69832.265101]  __blk_mq_sched_dispatch_requests+0x398/0x4f0
[69832.266206]  ? blk_mq_do_dispatch_ctx+0x570/0x570
[69832.267147]  ? __switch_to+0x5f4/0xee0
[69832.267898]  blk_mq_sched_dispatch_requests+0xdf/0x140
[69832.268946]  __blk_mq_run_hw_queue+0xc0/0x270
[69832.269840]  blk_mq_run_work_fn+0x51/0x60
[69832.278170]  process_one_work+0x6d4/0xfe0
[69832.278984]  worker_thread+0x91/0xc80
[69832.279726]  ? __kthread_parkme+0xb0/0x110
[69832.280554]  ? process_one_work+0xfe0/0xfe0
[69832.281414]  kthread+0x32d/0x3f0
[69832.282082]  ? kthread_park+0x170/0x170
[69832.282849]  ret_from_fork+0x1f/0x30
[69832.283573]
[69832.283886] Allocated by task 7725:
[69832.284599]  kasan_save_stack+0x19/0x40
[69832.285385]  __kasan_kmalloc.constprop.2+0xc1/0xd0
[69832.286350]  kmem_cache_alloc_node+0x13f/0x460
[69832.287237]  bfq_get_queue+0x3d4/0x1140
[69832.287993]  bfq_get_bfqq_handle_split+0x103/0x510
[69832.289015]  bfq_init_rq+0x337/0x2d50
[69832.289749]  bfq_insert_requests+0x304/0x4e10
[69832.290634]  blk_mq_sched_insert_requests+0x13e/0x390
[69832.291629]  blk_mq_flush_plug_list+0x4b4/0x760
[69832.292538]  blk_flush_plug_list+0x2c5/0x480
[69832.293392]  io_schedule_prepare+0xb2/0xd0
[69832.294209]  io_schedule_timeout+0x13/0x80
[69832.295014]  wait_for_common_io.constprop.1+0x13c/0x270
[69832.296137]  submit_bio_wait+0x103/0x1a0
[69832.296932]  blkdev_issue_discard+0xe6/0x160
[69832.297794]  blk_ioctl_discard+0x219/0x290
[69832.298614]  blkdev_common_ioctl+0x50a/0x1750
[69832.304715]  blkdev_ioctl+0x470/0x600
[69832.305474]  block_ioctl+0xde/0x120
[69832.306232]  vfs_ioctl+0x6c/0xc0
[69832.306877]  __se_sys_ioctl+0x90/0xa0
[69832.307629]  do_syscall_64+0x2d/0x40
[69832.308362]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[69832.309382]
[69832.309701] Freed by task 155:
[69832.310328]  kasan_save_stack+0x19/0x40
[69832.311121]  kasan_set_track+0x1c/0x30
[69832.311868]  kasan_set_free_info+0x1b/0x30
[69832.312699]  __kasan_slab_free+0x111/0x160
[69832.313524]  kmem_cache_free+0x94/0x460
[69832.314367]  bfq_put_queue+0x582/0x940
[69832.315112]  __bfq_bfqd_reset_in_service+0x166/0x1d0
[69832.317275]  bfq_bfqq_expire+0xb27/0x2440
[69832.318084]  bfq_dispatch_request+0x697/0x44b0
[69832.318991]  __blk_mq_do_dispatch_sched+0x52f/0x830
[69832.319984]  __blk_mq_sched_dispatch_requests+0x398/0x4f0
[69832.321087]  blk_mq_sched_dispatch_requests+0xdf/0x140
[69832.322225]  __blk_mq_run_hw_queue+0xc0/0x270
[69832.323114]  blk_mq_run_work_fn+0x51/0x60
[69832.323942]  process_one_work+0x6d4/0xfe0
[69832.324772]  worker_thread+0x91/0xc80
[69832.325518]  kthread+0x32d/0x3f0
[69832.326205]  ret_from_fork+0x1f/0x30
[69832.326932]
[69832.338297] The buggy address belongs to the object at ffff88802622b968
[69832.338297]  which belongs to the cache bfq_queue of size 512
[69832.340766] The buggy address is located 288 bytes inside of
[69832.340766]  512-byte region [ffff88802622b968, ffff88802622bb68)
[69832.343091] The buggy address belongs to the page:
[69832.344097] page:ffffea0000988a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802622a528 pfn:0x26228
[69832.346214] head:ffffea0000988a00 order:2 compound_mapcount:0 compound_pincount:0
[69832.347719] flags: 0x1fffff80010200(slab|head)
[69832.348625] raw: 001fffff80010200 ffffea0000dbac08 ffff888017a57650 ffff8880179fe840
[69832.354972] raw: ffff88802622a528 0000000000120008 00000001ffffffff 0000000000000000
[69832.356547] page dumped because: kasan: bad access detected
[69832.357652]
[69832.357970] Memory state around the buggy address:
[69832.358926]  ffff88802622b980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[69832.360358]  ffff88802622ba00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[69832.361810] >ffff88802622ba80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[69832.363273]                       ^
[69832.363975]  ffff88802622bb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
[69832.375960]  ffff88802622bb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[69832.377405] ==================================================================

In bfq_dispatch_requestfunction, it may have function call:

bfq_dispatch_request
	__bfq_dispatch_request
		bfq_select_queue
			bfq_bfqq_expire
				__bfq_bfqd_reset_in_service
					bfq_put_queue
						kmem_cache_free
In this function call, in_serv_queue has beed expired and meet the
conditions to free. In the function bfq_dispatch_request, the address
of in_serv_queue pointing to has been released. For getting the value
of idle_timer_disabled, it will get flags value from the address which
in_serv_queue pointing to, then the problem of use-after-free happens;

Fix the problem by check in_serv_queue == bfqd->in_service_queue, to
get the value of idle_timer_disabled if in_serve_queue is equel to
bfqd->in_service_queue. If the space of in_serv_queue pointing has
been released, this judge will aviod use-after-free problem.
And if in_serv_queue may be expired or finished, the idle_timer_disabled
will be false which would not give effects to bfq_update_dispatch_stats.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
---
 block/bfq-iosched.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 36a66e97e3c2..8735f075230f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5181,7 +5181,7 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
 	struct request *rq;
 	struct bfq_queue *in_serv_queue;
-	bool waiting_rq, idle_timer_disabled;
+	bool waiting_rq, idle_timer_disabled = false;
 
 	spin_lock_irq(&bfqd->lock);
 
@@ -5189,14 +5189,15 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	waiting_rq = in_serv_queue && bfq_bfqq_wait_request(in_serv_queue);
 
 	rq = __bfq_dispatch_request(hctx);
-
-	idle_timer_disabled =
-		waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
+	if (in_serv_queue == bfqd->in_service_queue) {
+		idle_timer_disabled =
+			waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
+	}
 
 	spin_unlock_irq(&bfqd->lock);
-
-	bfq_update_dispatch_stats(hctx->queue, rq, in_serv_queue,
-				  idle_timer_disabled);
+	bfq_update_dispatch_stats(hctx->queue, rq,
+			idle_timer_disabled ? in_serv_queue : NULL,
+				idle_timer_disabled);
 
 	return rq;
 }
-- 
2.31.1

