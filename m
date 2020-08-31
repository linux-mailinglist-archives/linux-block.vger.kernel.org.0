Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458CD257F23
	for <lists+linux-block@lfdr.de>; Mon, 31 Aug 2020 18:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgHaQ6m (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 31 Aug 2020 12:58:42 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:43103 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbgHaQ6W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 12:58:22 -0400
Received: by mail-il1-f200.google.com with SMTP id 2so5573133ill.10
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 09:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+ZTs2n83Tkv9civzXKXQz/dyybMvLYTtTFdf222myQU=;
        b=QajCR6xakhu+HM29vYGn9NzjplGx4AY5M400Si/9ElnLdwtv5gsW3SHh0hJPOnS4TZ
         uXEt/gUXMp2h5nUwfkh85x1EzpqSjveVSFNLdx250QGz5YvOdyYkvUpJ1+82MpDDV/Vr
         UxxjSFq85VtECNwI8yPaCZiCWXyKSX0co8JGAFlq0JKBsQVLD87t0PUH5FbmSsKcGOet
         Mn1MurOmyWDUkwR5TPV01iMbtimG+pu7NwMfLwniU7ran7iItXGfk/YrHlBpxsV7ilvI
         +DrBvEe4SVpnZWskniY7fZi3zFz6S9WJ/H2Bk17MUirDA1zkTClEdBh6IjQT7umponV/
         1euw==
X-Gm-Message-State: AOAM533HH0a6O8mPCf2MfxkCRgbDexgH4slXp2kdLHMb3HgjrCg5pBYl
        w2CEwhp8IGwHnZndDPc3F1dClxxmm2KFFz7d+xxBVdmk/S69
X-Google-Smtp-Source: ABdhPJy97nCt55gGNTuN6WXoY0AozhHr8Q2AcDXTatLhN0TANhDMJJyv6r1BNny+Gn5crQ6UsyoekIZ6uRtQE2Pe0zOgBkzYje1W
MIME-Version: 1.0
X-Received: by 2002:a92:1b4d:: with SMTP id b74mr2202700ilb.198.1598893101025;
 Mon, 31 Aug 2020 09:58:21 -0700 (PDT)
Date:   Mon, 31 Aug 2020 09:58:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000520ffc05ae2f4fee@google.com>
Subject: KASAN: use-after-free Read in bdev_del_partition
From:   syzbot <syzbot+6448f3c229bc52b82f69@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, johannes.thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dcc5c6f0 Merge tag 'x86-urgent-2020-08-30' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e8ca85900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
dashboard link: https://syzkaller.appspot.com/bug?extid=6448f3c229bc52b82f69
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154e2285900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f6e915900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6448f3c229bc52b82f69@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in kobject_put+0x245/0x2c0 lib/kobject.c:748
Read of size 1 at addr ffff8880a384e9bc by task syz-executor027/6982

CPU: 0 PID: 6982 Comm: syz-executor027 Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 print_address_description+0x66/0x620 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 kobject_put+0x245/0x2c0 lib/kobject.c:748
 delete_partition block/partitions/core.c:324 [inline]
 bdev_del_partition+0x26a/0x380 block/partitions/core.c:549
 blkpg_do_ioctl+0x12b/0x2e0 block/ioctl.c:33
 blkpg_ioctl block/ioctl.c:69 [inline]
 blkdev_ioctl+0x352/0x5d0 block/ioctl.c:589
 block_ioctl+0xbc/0x100 fs/block_dev.c:1871
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:739
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446959
Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db 06 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4a7a555d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 0000000000446959
RDX: 0000000020000000 RSI: 0000000000001269 RDI: 0000000000000005
RBP: 00000000006dbc30 R08: 00007f4a7a556700 R09: 0000000000000000
R10: 00007f4a7a556700 R11: 0000000000000246 R12: 00000000006dbc3c
R13: 00000000000000a9 R14: 00b747111e42e3ec R15: 02ba2b7a04b8ac00

Allocated by task 6977:
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x100/0x130 mm/kasan/common.c:461
 kmem_cache_alloc_trace+0x1e4/0x2e0 mm/slab.c:3550
 kmalloc include/linux/slab.h:554 [inline]
 kzalloc include/linux/slab.h:666 [inline]
 kobject_create lib/kobject.c:783 [inline]
 kobject_create_and_add+0x57/0x240 lib/kobject.c:809
 add_partition+0x884/0xcb0 block/partitions/core.c:443
 bdev_add_partition+0x1c9/0x230 block/partitions/core.c:518
 blkpg_do_ioctl+0x295/0x2e0 block/ioctl.c:52
 blkpg_ioctl block/ioctl.c:69 [inline]
 blkdev_ioctl+0x352/0x5d0 block/ioctl.c:589
 block_ioctl+0xbc/0x100 fs/block_dev.c:1871
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:739
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 6979:
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track+0x3d/0x70 mm/kasan/common.c:56
 kasan_set_free_info+0x17/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xdd/0x110 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kfree+0x113/0x200 mm/slab.c:3756
 kobject_cleanup lib/kobject.c:704 [inline]
 kobject_release lib/kobject.c:735 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1a0/0x2c0 lib/kobject.c:752
 delete_partition block/partitions/core.c:324 [inline]
 bdev_del_partition+0x26a/0x380 block/partitions/core.c:549
 blkpg_do_ioctl+0x12b/0x2e0 block/ioctl.c:33
 blkpg_ioctl block/ioctl.c:69 [inline]
 blkdev_ioctl+0x352/0x5d0 block/ioctl.c:589
 block_ioctl+0xbc/0x100 fs/block_dev.c:1871
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:739
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8880a384e980
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 60 bytes inside of
 64-byte region [ffff8880a384e980, ffff8880a384e9c0)
The buggy address belongs to the page:
page:00000000f601aef4 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xa384e
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea000263b548 ffffea00029bbac8 ffff8880aa440200
raw: 0000000000000000 ffff8880a384e000 0000000100000020 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a384e880: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff8880a384e900: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff8880a384e980: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                        ^
 ffff8880a384ea00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff8880a384ea80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
