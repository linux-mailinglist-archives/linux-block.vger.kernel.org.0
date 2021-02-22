Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E61F3220BA
	for <lists+linux-block@lfdr.de>; Mon, 22 Feb 2021 21:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhBVUSZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 22 Feb 2021 15:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhBVUSW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 15:18:22 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9B6C06174A
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 12:17:42 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id y202so14681286iof.1
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 12:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ddf66lJ+m5xONzSeCUD0kkvr/koAk3741YY+sSqL1Q=;
        b=vIjNjzXk5dcsCX8ZOoirTk8u3Bs+mMJRcrAAHY7W9MDXo+Qec37BcW/o25VeebQunK
         Rdl07Oxahb7hmqO2IDZ9dCbeRGCqL9ubs9U6za7cDAWetjeOmwcBhBK8T+DHe9tRMSZj
         dhcGhpiMngBXt0aBxOyyxjO5uVZWHlOH/nay3JqnsX04uZr3tlaya9cRkH14H7I4YfHj
         Onwridn2AUiJ3PMDOuI7Cv/7f6xy+coV2rZXRXYSqPl+G7EMWs1bGnbipMmkg29WSqd7
         t6/SbC1F6SCV3PQ01oI1o+1ouBFK6J9Zp742U76tjSdjU/UX/c2vj82eTUR4kuHIzB22
         /pbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ddf66lJ+m5xONzSeCUD0kkvr/koAk3741YY+sSqL1Q=;
        b=Mhqe8tiD/Ix83FxR/jqVBuE+CjgdceLgpnH514G8Ys+QqSw+rhgn8GSrCM7+0mKDJE
         Y1VVYZW3kwIAcme8kWBAuSnY0ES8RGTu+hR4yoE5LBzvTCyOx9YaOr3AkwgEFK4SU+Ki
         u60a1jOtEyhRx1R4S2CqQjcZbrYmINGdH+0WWY+ihWrAtXXm9mVYIukFhVqLeflayQDi
         XJV7cHTWFrOaf8phjhYQ/gY8hPGFNfkIQd4bvI6FjdHLsD+POEONEvp19kQyHc1hPQLZ
         cb2VD4dR7w8olCNt/5ZUIPf8voSNirOXp7t7aG7+1s2mlz9DfJVFz2igckaXoxLgi80o
         W6zg==
X-Gm-Message-State: AOAM532bxQ9Bz1Yn61S61JNboBBC5kHXoZR4ewThSICJFaJc+FL4PAZ9
        35JpmLdRdLh3gbXcbrCrV1R3pg==
X-Google-Smtp-Source: ABdhPJzbRL79ndIOOgIrgfIoWOhlWVTaRtFsgpSokWvK0bGnF3IM9CTPCElj2M/UtgH7W/3d5zdVmw==
X-Received: by 2002:a5d:9c88:: with SMTP id p8mr9094965iop.23.1614025061797;
        Mon, 22 Feb 2021 12:17:41 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w3sm12209333ill.80.2021.02.22.12.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 12:17:41 -0800 (PST)
Subject: Re: [PATCH] nbd: handle device refs for DESTROY_ON_DISCONNECT
 properly
To:     Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Cc:     syzbot+429d3f82d757c211bff3@syzkaller.appspotmail.com
References: <9143ed7b151cbd5e7aff0301929856b9ca0a0ba4.1614024570.git.josef@toxicpanda.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <27c6f6fb-4775-2d02-9f93-a02a76ce1166@kernel.dk>
Date:   Mon, 22 Feb 2021 13:17:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9143ed7b151cbd5e7aff0301929856b9ca0a0ba4.1614024570.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/21 1:09 PM, Josef Bacik wrote:
> There exists a race where we can be attempting to create a new nbd
> configuration while a previous configuration is going down, both
> configured with DESTROY_ON_DISCONNECT.  Normally devices all have a
> reference of 1, as they won't be cleaned up until the module is torn
> down.  However with DESTROY_ON_DISCONNECT we'll make sure that there is
> only 1 reference (generally) on the device for the config itself, and
> then once the config is dropped, the device is torn down.
> 
> The race that exists looks like this
> 
> TASK1					TASK2
> nbd_genl_connect()
>   idr_find()
>     refcount_inc_not_zero(nbd)
>       * count is 2 here ^^
> 					nbd_config_put()
> 					  nbd_put(nbd) (count is 1)
>     setup new config
>       check DESTROY_ON_DISCONNECT
> 	put_dev = true
>     if (put_dev) nbd_put(nbd)
> 	* free'd here ^^
> 
> In nbd_genl_connect() we assume that the nbd ref count will be 2,
> however clearly that won't be true if the nbd device had been setup as
> DESTROY_ON_DISCONNECT with its prior configuration.  Fix this by getting
> rid of the runtime flag to check if we need to mess with the nbd device
> refcount, and use the device NBD_DESTROY_ON_DISCONNECT flag to check if
> we need to adjust the ref counts.  This was reported by syzkaller with
> the following kasan dump
> 
> BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:71 [inline]
> BUG: KASAN: use-after-free in atomic_read include/asm-generic/atomic-instrumented.h:27 [inline]
> BUG: KASAN: use-after-free in refcount_dec_not_one+0x71/0x1e0 lib/refcount.c:76
> Read of size 4 at addr ffff888143bf71a0 by task systemd-udevd/8451
> 
> CPU: 0 PID: 8451 Comm: systemd-udevd Not tainted 5.11.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x107/0x163 lib/dump_stack.c:120
>  print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
>  __kasan_report mm/kasan/report.c:396 [inline]
>  kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
>  check_memory_region_inline mm/kasan/generic.c:179 [inline]
>  check_memory_region+0x13d/0x180 mm/kasan/generic.c:185
>  instrument_atomic_read include/linux/instrumented.h:71 [inline]
>  atomic_read include/asm-generic/atomic-instrumented.h:27 [inline]
>  refcount_dec_not_one+0x71/0x1e0 lib/refcount.c:76
>  refcount_dec_and_mutex_lock+0x19/0x140 lib/refcount.c:115
>  nbd_put drivers/block/nbd.c:248 [inline]
>  nbd_release+0x116/0x190 drivers/block/nbd.c:1508
>  __blkdev_put+0x548/0x800 fs/block_dev.c:1579
>  blkdev_put+0x92/0x570 fs/block_dev.c:1632
>  blkdev_close+0x8c/0xb0 fs/block_dev.c:1640
>  __fput+0x283/0x920 fs/file_table.c:280
>  task_work_run+0xdd/0x190 kernel/task_work.c:140
>  tracehook_notify_resume include/linux/tracehook.h:189 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
>  exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:201
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
>  syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fc1e92b5270
> Code: 73 01 c3 48 8b 0d 38 7d 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 59 c1 20 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee fb ff ff 48 89 04 24
> RSP: 002b:00007ffe8beb2d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00007fc1e92b5270
> RDX: 000000000aba9500 RSI: 0000000000000000 RDI: 0000000000000007
> RBP: 00007fc1ea16f710 R08: 000000000000004a R09: 0000000000000008
> R10: 0000562f8cb0b2a8 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000562f8cb0afd0 R14: 0000000000000003 R15: 000000000000000e
> 
> Allocated by task 1:
>  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>  kasan_set_track mm/kasan/common.c:46 [inline]
>  set_alloc_info mm/kasan/common.c:401 [inline]
>  ____kasan_kmalloc.constprop.0+0x82/0xa0 mm/kasan/common.c:429
>  kmalloc include/linux/slab.h:552 [inline]
>  kzalloc include/linux/slab.h:682 [inline]
>  nbd_dev_add+0x44/0x8e0 drivers/block/nbd.c:1673
>  nbd_init+0x250/0x271 drivers/block/nbd.c:2394
>  do_one_initcall+0x103/0x650 init/main.c:1223
>  do_initcall_level init/main.c:1296 [inline]
>  do_initcalls init/main.c:1312 [inline]
>  do_basic_setup init/main.c:1332 [inline]
>  kernel_init_freeable+0x605/0x689 init/main.c:1533
>  kernel_init+0xd/0x1b8 init/main.c:1421
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> 
> Freed by task 8451:
>  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>  kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
>  kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:356
>  ____kasan_slab_free+0xe1/0x110 mm/kasan/common.c:362
>  kasan_slab_free include/linux/kasan.h:192 [inline]
>  slab_free_hook mm/slub.c:1547 [inline]
>  slab_free_freelist_hook+0x5d/0x150 mm/slub.c:1580
>  slab_free mm/slub.c:3143 [inline]
>  kfree+0xdb/0x3b0 mm/slub.c:4139
>  nbd_dev_remove drivers/block/nbd.c:243 [inline]
>  nbd_put.part.0+0x180/0x1d0 drivers/block/nbd.c:251
>  nbd_put drivers/block/nbd.c:295 [inline]
>  nbd_config_put+0x6dd/0x8c0 drivers/block/nbd.c:1242
>  nbd_release+0x103/0x190 drivers/block/nbd.c:1507
>  __blkdev_put+0x548/0x800 fs/block_dev.c:1579
>  blkdev_put+0x92/0x570 fs/block_dev.c:1632
>  blkdev_close+0x8c/0xb0 fs/block_dev.c:1640
>  __fput+0x283/0x920 fs/file_table.c:280
>  task_work_run+0xdd/0x190 kernel/task_work.c:140
>  tracehook_notify_resume include/linux/tracehook.h:189 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
>  exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:201
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
>  syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The buggy address belongs to the object at ffff888143bf7000
>  which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 416 bytes inside of
>  1024-byte region [ffff888143bf7000, ffff888143bf7400)
> The buggy address belongs to the page:
> page:000000005238f4ce refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x143bf0
> head:000000005238f4ce order:3 compound_mapcount:0 compound_pincount:0
> flags: 0x57ff00000010200(slab|head)
> raw: 057ff00000010200 ffffea00004b1400 0000000300000003 ffff888010c41140
> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff888143bf7080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888143bf7100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff888143bf7180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                ^
>  ffff888143bf7200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Applied, thanks.

-- 
Jens Axboe

