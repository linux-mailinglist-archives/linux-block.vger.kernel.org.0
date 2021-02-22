Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139C73220A5
	for <lists+linux-block@lfdr.de>; Mon, 22 Feb 2021 21:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhBVUKg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 22 Feb 2021 15:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBVUKf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 15:10:35 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3BDC06174A
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 12:09:55 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id t62so13933774qke.7
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 12:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qQGQVqo4o2Y/L3lY4kodcn30+CCIeiXm+gnd4qM9ja8=;
        b=Sjj3DEkW4T3lyUz1WAsVvhlB5mzqybn6yFuLueF+Tom2nf3aZ9Dj49puFEaKVAWMQC
         u8ilc76YbgEUvR9PNRlQbtxOJYXPQk3gJv0e9I8tS4wIK/znyuQ8B5PyHOYpRaRS5doB
         sSiBDxWvLmM7oDHOBpPHKg/NZOa8WrJgt1xpBVulF1v3o+grTxahLKFn1dy1lap0Odex
         ieBp0NSzNsNMu39nLYug3ZW6TTmWPiMdFiRFoZHmfEZR8m9SEHKtYv9aecRUsHTOaXa4
         tp/iYsCQl134+783xZEyLbRaQn/EobJhzxIhwMqACNdZ+RtLAkbihGoybkfRUuFhNvFN
         FZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qQGQVqo4o2Y/L3lY4kodcn30+CCIeiXm+gnd4qM9ja8=;
        b=BUQq/1eel1gd48FJ/VKy/YrMRz83dLNEQbvKeT6IGt+1rsC0/p6uM1KBC6kFiYVL0H
         NFY5BHYh9itYwWjf4AY1oWH+0eP+Rf3VPNovwSD7nN6FvRyDLCW+NiPKo9/j91iDl9vN
         t1ghzhrehlmVMLCM07hkVfPxLLt0EIFyWkVEeCGjKsQo8+ZHsafeM/dev56btkgvlfIA
         De7TvV+OIMVSGa9BJtpbDCMhpymotT9iZLaSbv/6PtHeiAqJAKhuCG2fr7jIgnTY49ni
         ZGCwkCRQyDxuzTE09z96Y9oFe4L0KqnliWkqb1reY+wAKDlPr1D16B94rvB1DiIBG3Nq
         K0rw==
X-Gm-Message-State: AOAM532L01ivy7PcPZx0jF+4v9O0BxWijKkYruKST+77V/oXbDcusJzC
        xq+X3pcpVIWfrAE2rRQmHRxmNg==
X-Google-Smtp-Source: ABdhPJzOlDFjaM7Hb9qmExf/hgkdcichKpvPAVI5mPM0CUYBxkxc62lmMgj/ZuWah9Eq0dEoyEcpRQ==
X-Received: by 2002:a37:a70c:: with SMTP id q12mr23180346qke.378.1614024594653;
        Mon, 22 Feb 2021 12:09:54 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e190sm13333103qkd.122.2021.02.22.12.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 12:09:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, nbd@other.debian.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Cc:     syzbot+429d3f82d757c211bff3@syzkaller.appspotmail.com
Subject: [PATCH] nbd: handle device refs for DESTROY_ON_DISCONNECT properly
Date:   Mon, 22 Feb 2021 15:09:53 -0500
Message-Id: <9143ed7b151cbd5e7aff0301929856b9ca0a0ba4.1614024570.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There exists a race where we can be attempting to create a new nbd
configuration while a previous configuration is going down, both
configured with DESTROY_ON_DISCONNECT.  Normally devices all have a
reference of 1, as they won't be cleaned up until the module is torn
down.  However with DESTROY_ON_DISCONNECT we'll make sure that there is
only 1 reference (generally) on the device for the config itself, and
then once the config is dropped, the device is torn down.

The race that exists looks like this

TASK1					TASK2
nbd_genl_connect()
  idr_find()
    refcount_inc_not_zero(nbd)
      * count is 2 here ^^
					nbd_config_put()
					  nbd_put(nbd) (count is 1)
    setup new config
      check DESTROY_ON_DISCONNECT
	put_dev = true
    if (put_dev) nbd_put(nbd)
	* free'd here ^^

In nbd_genl_connect() we assume that the nbd ref count will be 2,
however clearly that won't be true if the nbd device had been setup as
DESTROY_ON_DISCONNECT with its prior configuration.  Fix this by getting
rid of the runtime flag to check if we need to mess with the nbd device
refcount, and use the device NBD_DESTROY_ON_DISCONNECT flag to check if
we need to adjust the ref counts.  This was reported by syzkaller with
the following kasan dump

BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: use-after-free in atomic_read include/asm-generic/atomic-instrumented.h:27 [inline]
BUG: KASAN: use-after-free in refcount_dec_not_one+0x71/0x1e0 lib/refcount.c:76
Read of size 4 at addr ffff888143bf71a0 by task systemd-udevd/8451

CPU: 0 PID: 8451 Comm: systemd-udevd Not tainted 5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
 check_memory_region_inline mm/kasan/generic.c:179 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:185
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic_read include/asm-generic/atomic-instrumented.h:27 [inline]
 refcount_dec_not_one+0x71/0x1e0 lib/refcount.c:76
 refcount_dec_and_mutex_lock+0x19/0x140 lib/refcount.c:115
 nbd_put drivers/block/nbd.c:248 [inline]
 nbd_release+0x116/0x190 drivers/block/nbd.c:1508
 __blkdev_put+0x548/0x800 fs/block_dev.c:1579
 blkdev_put+0x92/0x570 fs/block_dev.c:1632
 blkdev_close+0x8c/0xb0 fs/block_dev.c:1640
 __fput+0x283/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x190 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fc1e92b5270
Code: 73 01 c3 48 8b 0d 38 7d 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 59 c1 20 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee fb ff ff 48 89 04 24
RSP: 002b:00007ffe8beb2d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00007fc1e92b5270
RDX: 000000000aba9500 RSI: 0000000000000000 RDI: 0000000000000007
RBP: 00007fc1ea16f710 R08: 000000000000004a R09: 0000000000000008
R10: 0000562f8cb0b2a8 R11: 0000000000000246 R12: 0000000000000000
R13: 0000562f8cb0afd0 R14: 0000000000000003 R15: 000000000000000e

Allocated by task 1:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:401 [inline]
 ____kasan_kmalloc.constprop.0+0x82/0xa0 mm/kasan/common.c:429
 kmalloc include/linux/slab.h:552 [inline]
 kzalloc include/linux/slab.h:682 [inline]
 nbd_dev_add+0x44/0x8e0 drivers/block/nbd.c:1673
 nbd_init+0x250/0x271 drivers/block/nbd.c:2394
 do_one_initcall+0x103/0x650 init/main.c:1223
 do_initcall_level init/main.c:1296 [inline]
 do_initcalls init/main.c:1312 [inline]
 do_basic_setup init/main.c:1332 [inline]
 kernel_init_freeable+0x605/0x689 init/main.c:1533
 kernel_init+0xd/0x1b8 init/main.c:1421
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Freed by task 8451:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:356
 ____kasan_slab_free+0xe1/0x110 mm/kasan/common.c:362
 kasan_slab_free include/linux/kasan.h:192 [inline]
 slab_free_hook mm/slub.c:1547 [inline]
 slab_free_freelist_hook+0x5d/0x150 mm/slub.c:1580
 slab_free mm/slub.c:3143 [inline]
 kfree+0xdb/0x3b0 mm/slub.c:4139
 nbd_dev_remove drivers/block/nbd.c:243 [inline]
 nbd_put.part.0+0x180/0x1d0 drivers/block/nbd.c:251
 nbd_put drivers/block/nbd.c:295 [inline]
 nbd_config_put+0x6dd/0x8c0 drivers/block/nbd.c:1242
 nbd_release+0x103/0x190 drivers/block/nbd.c:1507
 __blkdev_put+0x548/0x800 fs/block_dev.c:1579
 blkdev_put+0x92/0x570 fs/block_dev.c:1632
 blkdev_close+0x8c/0xb0 fs/block_dev.c:1640
 __fput+0x283/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x190 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff888143bf7000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 416 bytes inside of
 1024-byte region [ffff888143bf7000, ffff888143bf7400)
The buggy address belongs to the page:
page:000000005238f4ce refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x143bf0
head:000000005238f4ce order:3 compound_mapcount:0 compound_pincount:0
flags: 0x57ff00000010200(slab|head)
raw: 057ff00000010200 ffffea00004b1400 0000000300000003 ffff888010c41140
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888143bf7080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888143bf7100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888143bf7180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888143bf7200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Reported-and-tested-by: syzbot+429d3f82d757c211bff3@syzkaller.appspotmail.com
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/nbd.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8b9622eb0a21..4ff71b579cfc 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -78,8 +78,7 @@ struct link_dead_args {
 #define NBD_RT_HAS_PID_FILE		3
 #define NBD_RT_HAS_CONFIG_REF		4
 #define NBD_RT_BOUND			5
-#define NBD_RT_DESTROY_ON_DISCONNECT	6
-#define NBD_RT_DISCONNECT_ON_CLOSE	7
+#define NBD_RT_DISCONNECT_ON_CLOSE	6
 
 #define NBD_DESTROY_ON_DISCONNECT	0
 #define NBD_DISCONNECT_REQUESTED	1
@@ -1904,12 +1903,21 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NBD_ATTR_CLIENT_FLAGS]) {
 		u64 flags = nla_get_u64(info->attrs[NBD_ATTR_CLIENT_FLAGS]);
 		if (flags & NBD_CFLAG_DESTROY_ON_DISCONNECT) {
-			set_bit(NBD_RT_DESTROY_ON_DISCONNECT,
-				&config->runtime_flags);
-			set_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags);
-			put_dev = true;
+			/*
+			 * We have 1 ref to keep the device around, and then 1
+			 * ref for our current operation here, which will be
+			 * inherited by the config.  If we already have
+			 * DESTROY_ON_DISCONNECT set then we know we don't have
+			 * that extra ref already held so we don't need the
+			 * put_dev.
+			 */
+			if (!test_and_set_bit(NBD_DESTROY_ON_DISCONNECT,
+					      &nbd->flags))
+				put_dev = true;
 		} else {
-			clear_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags);
+			if (test_and_clear_bit(NBD_DESTROY_ON_DISCONNECT,
+					       &nbd->flags))
+				refcount_inc(&nbd->refs);
 		}
 		if (flags & NBD_CFLAG_DISCONNECT_ON_CLOSE) {
 			set_bit(NBD_RT_DISCONNECT_ON_CLOSE,
@@ -2080,15 +2088,13 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NBD_ATTR_CLIENT_FLAGS]) {
 		u64 flags = nla_get_u64(info->attrs[NBD_ATTR_CLIENT_FLAGS]);
 		if (flags & NBD_CFLAG_DESTROY_ON_DISCONNECT) {
-			if (!test_and_set_bit(NBD_RT_DESTROY_ON_DISCONNECT,
-					      &config->runtime_flags))
+			if (!test_and_set_bit(NBD_DESTROY_ON_DISCONNECT,
+					      &nbd->flags))
 				put_dev = true;
-			set_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags);
 		} else {
-			if (test_and_clear_bit(NBD_RT_DESTROY_ON_DISCONNECT,
-					       &config->runtime_flags))
+			if (test_and_clear_bit(NBD_DESTROY_ON_DISCONNECT,
+					       &nbd->flags))
 				refcount_inc(&nbd->refs);
-			clear_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags);
 		}
 
 		if (flags & NBD_CFLAG_DISCONNECT_ON_CLOSE) {
-- 
2.26.2

