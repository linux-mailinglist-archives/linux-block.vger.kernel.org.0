Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C431F2B37
	for <lists+linux-block@lfdr.de>; Tue,  9 Jun 2020 02:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbgFIAN0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 8 Jun 2020 20:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730786AbgFHXT1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Jun 2020 19:19:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5730D20814;
        Mon,  8 Jun 2020 23:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658366;
        bh=PMsorwhTLvY9AVD6bn9VbM3CY00su/7VYm4pfJi5/vQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+NTe/c0w5cQeGDGMHt0znGlj1YaJGodZ6z/4ESxjgPcNJEM+kNCAl3BFnUoVklNg
         7lsbNAiC4ETmw+BTd0g44e6fKZ5HhE69YDmmjhuQpBpDoRokE/26C23BxS1P+xgmb6
         WzFJhjLQAhHQJwC8/kqe4Lehwyy1mSgWhc52gH7g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Weiping Zhang <zhangweiping@didiglobal.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 030/175] block: alloc map and request for new hardware queue
Date:   Mon,  8 Jun 2020 19:16:23 -0400
Message-Id: <20200608231848.3366970-30-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit fd689871bbfbb41cd77379d3e9e5f4def0f7d6c6 ]

Alloc new map and request for new hardware queue when increse
hardware queue count. Before this patch, it will show a
warning for each new hardware queue, but it's not enough, these
hctx have no maps and reqeust, when a bio was mapped to these
hardware queue, it will trigger kernel panic when get request
from these hctx.

Test environment:
 * A NVMe disk supports 128 io queues
 * 96 cpus in system

A corner case can always trigger this panic, there are 96
io queues allocated for HCTX_TYPE_DEFAULT type, the corresponding kernel
log: nvme nvme0: 96/0/0 default/read/poll queues. Now we set nvme write
queues to 96, then nvme will alloc others(32) queues for read, but
blk_mq_update_nr_hw_queues does not alloc map and request for these new
added io queues. So when process read nvme disk, it will trigger kernel
panic when get request from these hardware context.

Reproduce script:

nr=$(expr `cat /sys/block/nvme0n1/device/queue_count` - 1)
echo $nr > /sys/module/nvme/parameters/write_queues
echo 1 > /sys/block/nvme0n1/device/reset_controller
dd if=/dev/nvme0n1 of=/dev/null bs=4K count=1

[ 8040.805626] ------------[ cut here ]------------
[ 8040.805627] WARNING: CPU: 82 PID: 12921 at block/blk-mq.c:2578 blk_mq_map_swqueue+0x2b6/0x2c0
[ 8040.805627] Modules linked in: nvme nvme_core nf_conntrack_netlink xt_addrtype br_netfilter overlay xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nft_counter nf_nat_tftp nf_conntrack_tftp nft_masq nf_tables_set nft_fib_inet nft_f
ib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack tun bridge nf_defrag_ipv6 nf_defrag_ipv4 stp llc ip6_tables ip_tables nft_compat rfkill ip_set nf_tables nfne
tlink sunrpc intel_rapl_msr intel_rapl_common skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass ipmi_ssif crct10dif_pclmul crc32_pclmul iTCO_wdt iTCO_vendor_support ghash_clmulni_intel intel_
cstate intel_uncore raid0 joydev intel_rapl_perf ipmi_si pcspkr mei_me ioatdma sg ipmi_devintf mei i2c_i801 dca lpc_ich ipmi_msghandler acpi_power_meter acpi_pad xfs libcrc32c sd_mod ast i2c_algo_bit drm_vram_helper drm_ttm_helper ttm d
rm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
[ 8040.805637]  ahci drm i40e libahci crc32c_intel libata t10_pi wmi dm_mirror dm_region_hash dm_log dm_mod [last unloaded: nvme_core]
[ 8040.805640] CPU: 82 PID: 12921 Comm: kworker/u194:2 Kdump: loaded Tainted: G        W         5.6.0-rc5.78317c+ #2
[ 8040.805640] Hardware name: Inspur SA5212M5/YZMB-00882-104, BIOS 4.0.9 08/27/2019
[ 8040.805641] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
[ 8040.805642] RIP: 0010:blk_mq_map_swqueue+0x2b6/0x2c0
[ 8040.805643] Code: 00 00 00 00 00 41 83 c5 01 44 39 6d 50 77 b8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b bb 98 00 00 00 89 d6 e8 8c 81 03 00 eb 83 <0f> 0b e9 52 ff ff ff 0f 1f 00 0f 1f 44 00 00 41 57 48 89 f1 41 56
[ 8040.805643] RSP: 0018:ffffba590d2e7d48 EFLAGS: 00010246
[ 8040.805643] RAX: 0000000000000000 RBX: ffff9f013e1ba800 RCX: 000000000000003d
[ 8040.805644] RDX: ffff9f00ffff6000 RSI: 0000000000000003 RDI: ffff9ed200246d90
[ 8040.805644] RBP: ffff9f00f6a79860 R08: 0000000000000000 R09: 000000000000003d
[ 8040.805645] R10: 0000000000000001 R11: ffff9f0138c3d000 R12: ffff9f00fb3a9008
[ 8040.805645] R13: 000000000000007f R14: ffffffff96822660 R15: 000000000000005f
[ 8040.805645] FS:  0000000000000000(0000) GS:ffff9f013fa80000(0000) knlGS:0000000000000000
[ 8040.805646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8040.805646] CR2: 00007f7f397fa6f8 CR3: 0000003d8240a002 CR4: 00000000007606e0
[ 8040.805647] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 8040.805647] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 8040.805647] PKRU: 55555554
[ 8040.805647] Call Trace:
[ 8040.805649]  blk_mq_update_nr_hw_queues+0x31b/0x390
[ 8040.805650]  nvme_reset_work+0xb4b/0xeab [nvme]
[ 8040.805651]  process_one_work+0x1a7/0x370
[ 8040.805652]  worker_thread+0x1c9/0x380
[ 8040.805653]  ? max_active_store+0x80/0x80
[ 8040.805655]  kthread+0x112/0x130
[ 8040.805656]  ? __kthread_parkme+0x70/0x70
[ 8040.805657]  ret_from_fork+0x35/0x40
[ 8040.805658] ---[ end trace b5f13b1e73ccb5d3 ]---
[ 8229.365135] BUG: kernel NULL pointer dereference, address: 0000000000000004
[ 8229.365165] #PF: supervisor read access in kernel mode
[ 8229.365178] #PF: error_code(0x0000) - not-present page
[ 8229.365191] PGD 0 P4D 0
[ 8229.365201] Oops: 0000 [#1] SMP PTI
[ 8229.365212] CPU: 77 PID: 13024 Comm: dd Kdump: loaded Tainted: G        W         5.6.0-rc5.78317c+ #2
[ 8229.365232] Hardware name: Inspur SA5212M5/YZMB-00882-104, BIOS 4.0.9 08/27/2019
[ 8229.365253] RIP: 0010:blk_mq_get_tag+0x227/0x250
[ 8229.365265] Code: 44 24 04 44 01 e0 48 8b 74 24 38 65 48 33 34 25 28 00 00 00 75 33 48 83 c4 40 5b 5d 41 5c 41 5d 41 5e c3 48 8d 68 10 4c 89 ef <44> 8b 60 04 48 89 ee e8 dd f9 ff ff 83 f8 ff 75 c8 e9 67 fe ff ff
[ 8229.365304] RSP: 0018:ffffba590e977970 EFLAGS: 00010246
[ 8229.365317] RAX: 0000000000000000 RBX: ffff9f00f6a79860 RCX: ffffba590e977998
[ 8229.365333] RDX: 0000000000000000 RSI: ffff9f012039b140 RDI: ffffba590e977a38
[ 8229.365349] RBP: 0000000000000010 R08: ffffda58ff94e190 R09: ffffda58ff94e198
[ 8229.365365] R10: 0000000000000011 R11: ffff9f00f6a79860 R12: 0000000000000000
[ 8229.365381] R13: ffffba590e977a38 R14: ffff9f012039b140 R15: 0000000000000001
[ 8229.365397] FS:  00007f481c230580(0000) GS:ffff9f013f940000(0000) knlGS:0000000000000000
[ 8229.365415] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8229.365428] CR2: 0000000000000004 CR3: 0000005f35e26004 CR4: 00000000007606e0
[ 8229.365444] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 8229.365460] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 8229.365476] PKRU: 55555554
[ 8229.365484] Call Trace:
[ 8229.365498]  ? finish_wait+0x80/0x80
[ 8229.365512]  blk_mq_get_request+0xcb/0x3f0
[ 8229.365525]  blk_mq_make_request+0x143/0x5d0
[ 8229.365538]  generic_make_request+0xcf/0x310
[ 8229.365553]  ? scan_shadow_nodes+0x30/0x30
[ 8229.365564]  submit_bio+0x3c/0x150
[ 8229.365576]  mpage_readpages+0x163/0x1a0
[ 8229.365588]  ? blkdev_direct_IO+0x490/0x490
[ 8229.365601]  read_pages+0x6b/0x190
[ 8229.365612]  __do_page_cache_readahead+0x1c1/0x1e0
[ 8229.365626]  ondemand_readahead+0x182/0x2f0
[ 8229.365639]  generic_file_buffered_read+0x590/0xab0
[ 8229.365655]  new_sync_read+0x12a/0x1c0
[ 8229.365666]  vfs_read+0x8a/0x140
[ 8229.365676]  ksys_read+0x59/0xd0
[ 8229.365688]  do_syscall_64+0x55/0x1d0
[ 8229.365700]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
Tested-by: Weiping Zhang <zhangweiping@didiglobal.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 757c0fd9f0cc..22ce0c6a8e6a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2493,18 +2493,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	 * If the cpu isn't present, the cpu is mapped to first hctx.
 	 */
 	for_each_possible_cpu(i) {
-		hctx_idx = set->map[HCTX_TYPE_DEFAULT].mq_map[i];
-		/* unmapped hw queue can be remapped after CPU topo changed */
-		if (!set->tags[hctx_idx] &&
-		    !__blk_mq_alloc_rq_map(set, hctx_idx)) {
-			/*
-			 * If tags initialization fail for some hctx,
-			 * that hctx won't be brought online.  In this
-			 * case, remap the current ctx to hctx[0] which
-			 * is guaranteed to always have tags allocated
-			 */
-			set->map[HCTX_TYPE_DEFAULT].mq_map[i] = 0;
-		}
 
 		ctx = per_cpu_ptr(q->queue_ctx, i);
 		for (j = 0; j < set->nr_maps; j++) {
@@ -2513,6 +2501,18 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 						HCTX_TYPE_DEFAULT, i);
 				continue;
 			}
+			hctx_idx = set->map[j].mq_map[i];
+			/* unmapped hw queue can be remapped after CPU topo changed */
+			if (!set->tags[hctx_idx] &&
+			    !__blk_mq_alloc_rq_map(set, hctx_idx)) {
+				/*
+				 * If tags initialization fail for some hctx,
+				 * that hctx won't be brought online.  In this
+				 * case, remap the current ctx to hctx[0] which
+				 * is guaranteed to always have tags allocated
+				 */
+				set->map[j].mq_map[i] = 0;
+			}
 
 			hctx = blk_mq_map_queue_type(q, j, i);
 			ctx->hctxs[j] = hctx;
-- 
2.25.1

