Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117584065EC
	for <lists+linux-block@lfdr.de>; Fri, 10 Sep 2021 05:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhIJDS4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 9 Sep 2021 23:18:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15402 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhIJDS4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 23:18:56 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H5LYc72cKzQml5;
        Fri, 10 Sep 2021 11:13:40 +0800 (CST)
Received: from dggema773-chm.china.huawei.com (10.1.198.217) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Fri, 10 Sep 2021 11:17:43 +0800
Received: from localhost.huawei.com (10.175.124.27) by
 dggema773-chm.china.huawei.com (10.1.198.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 10 Sep 2021 11:17:42 +0800
From:   Li Jinlin <lijinlin3@huawei.com>
To:     <paolo.valente@linaro.org>
CC:     <axboe@kernel.dk>, <tj@kernel.org>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linfeilong@huawei.com>, <louhongxiang@huawei.com>
Subject: [PATCH v2] block, bfq: fix UAF in bfq_io_set_weight_legacy()
Date:   Fri, 10 Sep 2021 11:46:42 +0800
Message-ID: <20210910034642.2838054-1-lijinlin3@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema773-chm.china.huawei.com (10.1.198.217)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Li Jinlin <lijinlin3@huawei.com>

KASAN reports a use-after-free report when doing fuzz test:

[693354.104835] ==================================================================
[693354.105094] BUG: KASAN: use-after-free in bfq_io_set_weight_legacy+0xd3/0x160
[693354.105336] Read of size 4 at addr ffff888be0a35664 by task sh/1453338

[693354.105607] CPU: 41 PID: 1453338 Comm: sh Kdump: loaded Not tainted 4.18.0-147
[693354.105610] Hardware name: Huawei 2288H V5/BC11SPSCB0, BIOS 0.81 07/02/2018
[693354.105612] Call Trace:
[693354.105621]  dump_stack+0xf1/0x19b
[693354.105626]  ? show_regs_print_info+0x5/0x5
[693354.105634]  ? printk+0x9c/0xc3
[693354.105638]  ? cpumask_weight+0x1f/0x1f
[693354.105648]  print_address_description+0x70/0x360
[693354.105654]  kasan_report+0x1b2/0x330
[693354.105659]  ? bfq_io_set_weight_legacy+0xd3/0x160
[693354.105665]  ? bfq_io_set_weight_legacy+0xd3/0x160
[693354.105670]  bfq_io_set_weight_legacy+0xd3/0x160
[693354.105675]  ? bfq_cpd_init+0x20/0x20
[693354.105683]  cgroup_file_write+0x3aa/0x510
[693354.105693]  ? ___slab_alloc+0x507/0x540
[693354.105698]  ? cgroup_file_poll+0x60/0x60
[693354.105702]  ? 0xffffffff89600000
[693354.105708]  ? usercopy_abort+0x90/0x90
[693354.105716]  ? mutex_lock+0xef/0x180
[693354.105726]  kernfs_fop_write+0x1ab/0x280
[693354.105732]  ? cgroup_file_poll+0x60/0x60
[693354.105738]  vfs_write+0xe7/0x230
[693354.105744]  ksys_write+0xb0/0x140
[693354.105749]  ? __ia32_sys_read+0x50/0x50
[693354.105760]  do_syscall_64+0x112/0x370
[693354.105766]  ? syscall_return_slowpath+0x260/0x260
[693354.105772]  ? do_page_fault+0x9b/0x270
[693354.105779]  ? prepare_exit_to_usermode+0xf9/0x1a0
[693354.105784]  ? enter_from_user_mode+0x30/0x30
[693354.105793]  entry_SYSCALL_64_after_hwframe+0x65/0xca

[693354.105875] Allocated by task 1453337:
[693354.106001]  kasan_kmalloc+0xa0/0xd0
[693354.106006]  kmem_cache_alloc_node_trace+0x108/0x220
[693354.106010]  bfq_pd_alloc+0x96/0x120
[693354.106015]  blkcg_activate_policy+0x1b7/0x2b0
[693354.106020]  bfq_create_group_hierarchy+0x1e/0x80
[693354.106026]  bfq_init_queue+0x678/0x8c0
[693354.106031]  blk_mq_init_sched+0x1f8/0x460
[693354.106037]  elevator_switch_mq+0xe1/0x240
[693354.106041]  elevator_switch+0x25/0x40
[693354.106045]  elv_iosched_store+0x1a1/0x230
[693354.106049]  queue_attr_store+0x78/0xb0
[693354.106053]  kernfs_fop_write+0x1ab/0x280
[693354.106056]  vfs_write+0xe7/0x230
[693354.106060]  ksys_write+0xb0/0x140
[693354.106064]  do_syscall_64+0x112/0x370
[693354.106069]  entry_SYSCALL_64_after_hwframe+0x65/0xca

[693354.106114] Freed by task 1453336:
[693354.106225]  __kasan_slab_free+0x130/0x180
[693354.106229]  kfree+0x90/0x1b0
[693354.106233]  blkcg_deactivate_policy+0x12c/0x220
[693354.106238]  bfq_exit_queue+0xf5/0x110
[693354.106241]  blk_mq_exit_sched+0x104/0x130
[693354.106245]  __elevator_exit+0x45/0x60
[693354.106249]  elevator_switch_mq+0xd6/0x240
[693354.106253]  elevator_switch+0x25/0x40
[693354.106257]  elv_iosched_store+0x1a1/0x230
[693354.106261]  queue_attr_store+0x78/0xb0
[693354.106264]  kernfs_fop_write+0x1ab/0x280
[693354.106268]  vfs_write+0xe7/0x230
[693354.106271]  ksys_write+0xb0/0x140
[693354.106275]  do_syscall_64+0x112/0x370
[693354.106280]  entry_SYSCALL_64_after_hwframe+0x65/0xca

[693354.106329] The buggy address belongs to the object at ffff888be0a35580
                 which belongs to the cache kmalloc-1k of size 1024
[693354.106736] The buggy address is located 228 bytes inside of
                 1024-byte region [ffff888be0a35580, ffff888be0a35980)
[693354.107114] The buggy address belongs to the page:
[693354.107273] page:ffffea002f828c00 count:1 mapcount:0 mapping:ffff888107c17080 index:0x0 compound_mapcount: 0
[693354.107606] flags: 0x17ffffc0008100(slab|head)
[693354.107760] raw: 0017ffffc0008100 ffffea002fcbc808 ffffea0030bd3a08 ffff888107c17080
[693354.108020] raw: 0000000000000000 00000000001c001c 00000001ffffffff 0000000000000000
[693354.108278] page dumped because: kasan: bad access detected

[693354.108511] Memory state around the buggy address:
[693354.108671]  ffff888be0a35500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[693354.116396]  ffff888be0a35580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[693354.124473] >ffff888be0a35600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[693354.132421]                                                        ^
[693354.140284]  ffff888be0a35680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[693354.147912]  ffff888be0a35700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[693354.155281] ==================================================================

Freeing bfqg is protected by queue lock in blkcg_deactivate_policy(), 
but getting/using bfqg is protected by blkcg lock in
bfq_io_set_weight_legacy(). If bfq_io_set_weight_legacy() get bfqg
before freeing bfqg and use bfqg in the after, the use-after-free
will occur.

CPU0                             CPU1
blkcg_deactivate_policy
  spin_lock_irq(&q->queue_lock)
                                 bfq_io_set_weight_legacy  
                                   spin_lock_irq(&blkcg->lock)
                                   blkg_to_bfqg(blkg)
                                     pd_to_bfqg(blkg->pd[pol->plid])
                                     ^^^^^^blkg->pd[pol->plid] != NULL
                                           bfqg != NULL
  pol->pd_free_fn(blkg->pd[pol->plid])
    pd_to_bfqg(blkg->pd[pol->plid])
    bfqg_put(bfqg)
      kfree(bfqg)
  blkg->pd[pol->plid] = NULL
  spin_unlock_irq(q->queue_lock);
                                   bfq_group_set_weight(bfqg, val, 0)
                                     bfqg->entity.new_weight
                                     ^^^^^^trigger uaf here 
                                   spin_unlock_irq(&blkcg->lock);

To fix this use-after-free, instead of holding blkcg->lock while
walking ->blkg_list and getting/using bfqg, RCU walk ->blkg_list and
hold the blkg's queue lock while getting/using bfqg.

Fixes: e21b7a0b9887 ("block, bfq: add full hierarchical scheduling and cgroups support")
Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
---
changes since v1 send with Message-ID:
20210909133737.1930835-1-lijinlin3@huawei.com

 - add "block, bfq:" to subject

 block/bfq-cgroup.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index e2f14508f2d6..7209060caa90 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1025,21 +1025,25 @@ static int bfq_io_set_weight_legacy(struct cgroup_subsys_state *css,
 	struct blkcg *blkcg = css_to_blkcg(css);
 	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(blkcg);
 	struct blkcg_gq *blkg;
+	struct bfq_group *bfqg;
 	int ret = -ERANGE;
 
 	if (val < BFQ_MIN_WEIGHT || val > BFQ_MAX_WEIGHT)
 		return ret;
 
 	ret = 0;
-	spin_lock_irq(&blkcg->lock);
 	bfqgd->weight = (unsigned short)val;
-	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
-		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
+		spin_lock_irq(&blkg->q->queue_lock);
+		bfqg = blkg_to_bfqg(blkg);
 
 		if (bfqg)
 			bfq_group_set_weight(bfqg, val, 0);
+		spin_unlock_irq(&blkg->q->queue_lock);
 	}
-	spin_unlock_irq(&blkcg->lock);
+	rcu_read_unlock();
 
 	return ret;
 }
-- 
2.27.0

