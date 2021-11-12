Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578AD44E3B9
	for <lists+linux-block@lfdr.de>; Fri, 12 Nov 2021 10:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbhKLJVe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 12 Nov 2021 04:21:34 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26304 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbhKLJVd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 04:21:33 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HrCZ61TKQzbhsh;
        Fri, 12 Nov 2021 17:13:50 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 12 Nov 2021 17:18:36 +0800
Received: from huawei.com (10.175.124.27) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 12 Nov
 2021 17:18:36 +0800
From:   Laibin Qiu <qiulaibin@huawei.com>
To:     <axboe@kernel.dk>
CC:     <dennis@kernel.org>, <tj@kernel.org>, <bo.liu@linux.alibaba.com>,
        <josef@toxicpanda.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next -V2] blkcg: Remove extra blkcg_bio_issue_init
Date:   Fri, 12 Nov 2021 17:33:54 +0800
Message-ID: <20211112093354.3581504-1-qiulaibin@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

KASAN reports a use-after-free report when doing block test:

==================================================================
[10050.967049] BUG: KASAN: use-after-free in
submit_bio_checks+0x1539/0x1550

[10050.977638] Call Trace:
[10050.978190]  dump_stack+0x9b/0xce
[10050.979674]  print_address_description.constprop.6+0x3e/0x60
[10050.983510]  kasan_report.cold.9+0x22/0x3a
[10050.986089]  submit_bio_checks+0x1539/0x1550
[10050.989576]  submit_bio_noacct+0x83/0xc80
[10050.993714]  submit_bio+0xa7/0x330
[10050.994435]  mpage_readahead+0x380/0x500
[10050.998009]  read_pages+0x1c1/0xbf0
[10051.002057]  page_cache_ra_unbounded+0x4c2/0x6f0
[10051.007413]  do_page_cache_ra+0xda/0x110
[10051.008207]  force_page_cache_ra+0x23d/0x3d0
[10051.009087]  page_cache_sync_ra+0xca/0x300
[10051.009970]  generic_file_buffered_read+0xbea/0x2130
[10051.012685]  generic_file_read_iter+0x315/0x490
[10051.014472]  blkdev_read_iter+0x113/0x1b0
[10051.015300]  aio_read+0x2ad/0x450
[10051.023786]  io_submit_one+0xc8e/0x1d60
[10051.029855]  __se_sys_io_submit+0x125/0x350
[10051.033442]  do_syscall_64+0x2d/0x40
[10051.034156]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[10051.048733] Allocated by task 18598:
[10051.049482]  kasan_save_stack+0x19/0x40
[10051.050263]  __kasan_kmalloc.constprop.1+0xc1/0xd0
[10051.051230]  kmem_cache_alloc+0x146/0x440
[10051.052060]  mempool_alloc+0x125/0x2f0
[10051.052818]  bio_alloc_bioset+0x353/0x590
[10051.053658]  mpage_alloc+0x3b/0x240
[10051.054382]  do_mpage_readpage+0xddf/0x1ef0
[10051.055250]  mpage_readahead+0x264/0x500
[10051.056060]  read_pages+0x1c1/0xbf0
[10051.056758]  page_cache_ra_unbounded+0x4c2/0x6f0
[10051.057702]  do_page_cache_ra+0xda/0x110
[10051.058511]  force_page_cache_ra+0x23d/0x3d0
[10051.059373]  page_cache_sync_ra+0xca/0x300
[10051.060198]  generic_file_buffered_read+0xbea/0x2130
[10051.061195]  generic_file_read_iter+0x315/0x490
[10051.062189]  blkdev_read_iter+0x113/0x1b0
[10051.063015]  aio_read+0x2ad/0x450
[10051.063686]  io_submit_one+0xc8e/0x1d60
[10051.064467]  __se_sys_io_submit+0x125/0x350
[10051.065318]  do_syscall_64+0x2d/0x40
[10051.066082]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[10051.067455] Freed by task 13307:
[10051.068136]  kasan_save_stack+0x19/0x40
[10051.068931]  kasan_set_track+0x1c/0x30
[10051.069726]  kasan_set_free_info+0x1b/0x30
[10051.070621]  __kasan_slab_free+0x111/0x160
[10051.071480]  kmem_cache_free+0x94/0x460
[10051.072256]  mempool_free+0xd6/0x320
[10051.072985]  bio_free+0xe0/0x130
[10051.073630]  bio_put+0xab/0xe0
[10051.074252]  bio_endio+0x3a6/0x5d0
[10051.074984]  blk_update_request+0x590/0x1370
[10051.075870]  scsi_end_request+0x7d/0x400
[10051.076667]  scsi_io_completion+0x1aa/0xe50
[10051.077503]  scsi_softirq_done+0x11b/0x240
[10051.078344]  blk_mq_complete_request+0xd4/0x120
[10051.079275]  scsi_mq_done+0xf0/0x200
[10051.080036]  virtscsi_vq_done+0xbc/0x150
[10051.080850]  vring_interrupt+0x179/0x390
[10051.081650]  __handle_irq_event_percpu+0xf7/0x490
[10051.082626]  handle_irq_event_percpu+0x7b/0x160
[10051.083527]  handle_irq_event+0xcc/0x170
[10051.084297]  handle_edge_irq+0x215/0xb20
[10051.085122]  asm_call_irq_on_stack+0xf/0x20
[10051.085986]  common_interrupt+0xae/0x120
[10051.086830]  asm_common_interrupt+0x1e/0x40

==================================================================

Bio will be checked at beginning of submit_bio_noacct(). If bio needs
to be throttled, it will start the timer and stop submit bio directly.
Bio will submit in blk_throtl_dispatch_work_fn() when the timer expires.
But in the current process, if bio is throttled, it will still set bio
issue->value by blkcg_bio_issue_init(). This is redundant and may cause
the above use-after-free.

CPU0                                   CPU1
submit_bio
submit_bio_noacct
  submit_bio_checks
    blk_throtl_bio()
      <=mod_timer(&sq->pending_timer
                                      blk_throtl_dispatch_work_fn
                                        submit_bio_noacct() <= bio have
                                        throttle tag, will throw directly
                                        and bio issue->value will be set
                                        here

                                      bio_endio()
                                      bio_put()
                                      bio_free() <= free this bio

    blkcg_bio_issue_init(bio)
      <= bio has been freed and
      will lead to UAF
  return BLK_QC_T_NONE

Fix this by remove extra blkcg_bio_issue_init.

Fixes: e439bedf6b24 (blkcg: consolidate bio_issue_init() to be a part of core)
Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
---
 block/blk-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b043de2baaac..9ee32f85d74e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -809,10 +809,8 @@ noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	if (unlikely(!current->io_context))
 		create_task_io_context(current, GFP_ATOMIC, q->node);
 
-	if (blk_throtl_bio(bio)) {
-		blkcg_bio_issue_init(bio);
+	if (blk_throtl_bio(bio))
 		return false;
-	}
 
 	blk_cgroup_bio_start(bio);
 	blkcg_bio_issue_init(bio);
-- 
2.22.0

