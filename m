Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B333547B8DF
	for <lists+linux-block@lfdr.de>; Tue, 21 Dec 2021 04:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhLUDKC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Dec 2021 22:10:02 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33885 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLUDKB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 22:10:01 -0500
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JJ1ds1SJZzcc6b;
        Tue, 21 Dec 2021 11:09:37 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 11:09:59 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 21 Dec
 2021 11:09:58 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>, <fchecconi@gmail.com>, <avanzini.arianna@gmail.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 3/4] block, bfq: don't move oom_bfqq
Date:   Tue, 21 Dec 2021 11:21:34 +0800
Message-ID: <20211221032135.878550-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211221032135.878550-1-yukuai3@huawei.com>
References: <20211221032135.878550-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Our test report a UAF:

[ 2073.019181] ==================================================================
[ 2073.019188] BUG: KASAN: use-after-free in __bfq_put_async_bfqq+0xa0/0x168
[ 2073.019191] Write of size 8 at addr ffff8000ccf64128 by task rmmod/72584
[ 2073.019192]
[ 2073.019196] CPU: 0 PID: 72584 Comm: rmmod Kdump: loaded Not tainted 4.19.90-yk #5
[ 2073.019198] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[ 2073.019200] Call trace:
[ 2073.019203]  dump_backtrace+0x0/0x310
[ 2073.019206]  show_stack+0x28/0x38
[ 2073.019210]  dump_stack+0xec/0x15c
[ 2073.019216]  print_address_description+0x68/0x2d0
[ 2073.019220]  kasan_report+0x238/0x2f0
[ 2073.019224]  __asan_store8+0x88/0xb0
[ 2073.019229]  __bfq_put_async_bfqq+0xa0/0x168
[ 2073.019233]  bfq_put_async_queues+0xbc/0x208
[ 2073.019236]  bfq_pd_offline+0x178/0x238
[ 2073.019240]  blkcg_deactivate_policy+0x1f0/0x420
[ 2073.019244]  bfq_exit_queue+0x128/0x178
[ 2073.019249]  blk_mq_exit_sched+0x12c/0x160
[ 2073.019252]  elevator_exit+0xc8/0xd0
[ 2073.019256]  blk_exit_queue+0x50/0x88
[ 2073.019259]  blk_cleanup_queue+0x228/0x3d8
[ 2073.019267]  null_del_dev+0xfc/0x1e0 [null_blk]
[ 2073.019274]  null_exit+0x90/0x114 [null_blk]
[ 2073.019278]  __arm64_sys_delete_module+0x358/0x5a0
[ 2073.019282]  el0_svc_common+0xc8/0x320
[ 2073.019287]  el0_svc_handler+0xf8/0x160
[ 2073.019290]  el0_svc+0x10/0x218
[ 2073.019291]
[ 2073.019294] Allocated by task 14163:
[ 2073.019301]  kasan_kmalloc+0xe0/0x190
[ 2073.019305]  kmem_cache_alloc_node_trace+0x1cc/0x418
[ 2073.019308]  bfq_pd_alloc+0x54/0x118
[ 2073.019313]  blkcg_activate_policy+0x250/0x460
[ 2073.019317]  bfq_create_group_hierarchy+0x38/0x110
[ 2073.019321]  bfq_init_queue+0x6d0/0x948
[ 2073.019325]  blk_mq_init_sched+0x1d8/0x390
[ 2073.019330]  elevator_switch_mq+0x88/0x170
[ 2073.019334]  elevator_switch+0x140/0x270
[ 2073.019338]  elv_iosched_store+0x1a4/0x2a0
[ 2073.019342]  queue_attr_store+0x90/0xe0
[ 2073.019348]  sysfs_kf_write+0xa8/0xe8
[ 2073.019351]  kernfs_fop_write+0x1f8/0x378
[ 2073.019359]  __vfs_write+0xe0/0x360
[ 2073.019363]  vfs_write+0xf0/0x270
[ 2073.019367]  ksys_write+0xdc/0x1b8
[ 2073.019371]  __arm64_sys_write+0x50/0x60
[ 2073.019375]  el0_svc_common+0xc8/0x320
[ 2073.019380]  el0_svc_handler+0xf8/0x160
[ 2073.019383]  el0_svc+0x10/0x218
[ 2073.019385]
[ 2073.019387] Freed by task 72584:
[ 2073.019391]  __kasan_slab_free+0x120/0x228
[ 2073.019394]  kasan_slab_free+0x10/0x18
[ 2073.019397]  kfree+0x94/0x368
[ 2073.019400]  bfqg_put+0x64/0xb0
[ 2073.019404]  bfqg_and_blkg_put+0x90/0xb0
[ 2073.019408]  bfq_put_queue+0x220/0x228
[ 2073.019413]  __bfq_put_async_bfqq+0x98/0x168
[ 2073.019416]  bfq_put_async_queues+0xbc/0x208
[ 2073.019420]  bfq_pd_offline+0x178/0x238
[ 2073.019424]  blkcg_deactivate_policy+0x1f0/0x420
[ 2073.019429]  bfq_exit_queue+0x128/0x178
[ 2073.019433]  blk_mq_exit_sched+0x12c/0x160
[ 2073.019437]  elevator_exit+0xc8/0xd0
[ 2073.019440]  blk_exit_queue+0x50/0x88
[ 2073.019443]  blk_cleanup_queue+0x228/0x3d8
[ 2073.019451]  null_del_dev+0xfc/0x1e0 [null_blk]
[ 2073.019459]  null_exit+0x90/0x114 [null_blk]
[ 2073.019462]  __arm64_sys_delete_module+0x358/0x5a0
[ 2073.019467]  el0_svc_common+0xc8/0x320
[ 2073.019471]  el0_svc_handler+0xf8/0x160
[ 2073.019474]  el0_svc+0x10/0x218
[ 2073.019475]
[ 2073.019479] The buggy address belongs to the object at ffff8000ccf63f00
 which belongs to the cache kmalloc-1024 of size 1024
[ 2073.019484] The buggy address is located 552 bytes inside of
 1024-byte region [ffff8000ccf63f00, ffff8000ccf64300)
[ 2073.019486] The buggy address belongs to the page:
[ 2073.019492] page:ffff7e000333d800 count:1 mapcount:0 mapping:ffff8000c0003a00 index:0x0 compound_mapcount: 0
[ 2073.020123] flags: 0x7ffff0000008100(slab|head)
[ 2073.020403] raw: 07ffff0000008100 ffff7e0003334c08 ffff7e00001f5a08 ffff8000c0003a00
[ 2073.020409] raw: 0000000000000000 00000000001c001c 00000001ffffffff 0000000000000000
[ 2073.020411] page dumped because: kasan: bad access detected
[ 2073.020412]
[ 2073.020414] Memory state around the buggy address:
[ 2073.020420]  ffff8000ccf64000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2073.020424]  ffff8000ccf64080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2073.020428] >ffff8000ccf64100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2073.020430]                                   ^
[ 2073.020434]  ffff8000ccf64180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2073.020438]  ffff8000ccf64200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2073.020439] ==================================================================

The same problem exist in mainline as well.

This is because oom_bfqq is moved to a non-root group, thus root_group
is freed earlier.

Thus fix the problem by don't move oom_bfqq.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 0f62546a72d4..8e8cf6b3d946 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -651,6 +651,12 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	if (old_parent == bfqg)
 		return;
 
+	/*
+	 * oom_bfqq is not allowed to move, oom_bfqq will hold ref to root_group
+	 * until elevator exit.
+	 */
+	if (bfqq == &bfqd->oom_bfqq)
+		return;
 	/*
 	 * Get extra reference to prevent bfqq from being freed in
 	 * next possible expire or deactivate.
-- 
2.31.1

