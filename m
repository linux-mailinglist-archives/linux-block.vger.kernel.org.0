Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892B658575A
	for <lists+linux-block@lfdr.de>; Sat, 30 Jul 2022 01:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbiG2Xc1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 Jul 2022 19:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiG2Xc0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 19:32:26 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4782D32058
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 16:32:24 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id l17-20020a056e02067100b002dc8a10b55eso3541504ilt.1
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 16:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=I8Ob+O+PNrOlj9GfENzUL+MK99llxYcgTACfwbVdlDc=;
        b=LOutdazJThe9poawx4OxQf+cTPzjGarXNfcP/OF2Y04pCFOgcRqbXehaB1XjHCP+6K
         b4ZSSfFOvpwKblpFVH+MsO6/P6bFkeD6lW1Af5xqxS85tDo1v4UL1yUTtu/H/nWM3Yl8
         pcvoL8F7N735BjBNkcvdAq5VWuLmqpSSa6cykhcH7MDr7+bN/Aj28/HP9BOB3ey/AgHb
         InklcTKwRdPU7qfnYNK7TMxHXBb2Alj1Ey3XA8vE2zHlZJ0Ojimuxama1nfXdp246NpC
         RrEZXIYkdCcA0nvh5jswsBoIv0Bse5okAgmfJrgWx9VdUhLYgadmV2JiDLXy64PVLK04
         x7xw==
X-Gm-Message-State: AJIora/lTmHmAUxL37KOHj0iIJeEMt58z8qj/yEkD0xXApo8uPYSceqO
        HbKzIOUZhKryeBLq0oniEoDj0ktBDN/fu6Ei1A48Q/g42B45
X-Google-Smtp-Source: AGRyM1toAajZrHrmv+exMo73Bd40szZlEVAzG1lYwFrJ4muY4skqDfYUhZDxVEeEucabB37ij7BqQ3TRwJWrx6+9BVoovDah8cqv
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a8:b0:341:64c4:8c59 with SMTP id
 v40-20020a05663835a800b0034164c48c59mr2228049jal.175.1659137543624; Fri, 29
 Jul 2022 16:32:23 -0700 (PDT)
Date:   Fri, 29 Jul 2022 16:32:23 -0700
In-Reply-To: <000000000000921fd405db62096a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebdf3505e4fa0f84@google.com>
Subject: Re: [syzbot] possible deadlock in throtl_pending_timer_fn
From:   syzbot <syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    cb71b93c2dc3 Add linux-next specific files for 20220628
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=154438f2080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=934ebb67352c8a490bf3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17713dee080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d24952080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.19.0-rc4-next-20220628-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor358/3597 is trying to acquire lock:
ffff888146f83aa0 (&q->queue_lock){..-.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:385 [inline]
ffff888146f83aa0 (&q->queue_lock){..-.}-{2:2}, at: throtl_pending_timer_fn+0xf7/0x1690 block/blk-throttle.c:1152

but task is already holding lock:
ffffc900001e0d70 ((&sq->pending_timer)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:31 [inline]
ffffc900001e0d70 ((&sq->pending_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x6b0 kernel/time/timer.c:1464

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 ((&sq->pending_timer)){+.-.}-{0:0}:
       del_timer_sync+0x5b/0x1b0 kernel/time/timer.c:1417
       throtl_pd_free+0x15/0x40 block/blk-throttle.c:500
       blkcg_deactivate_policy block/blk-cgroup.c:1520 [inline]
       blkcg_deactivate_policy+0x2d2/0x4e0 block/blk-cgroup.c:1498
       blk_throtl_exit+0x8a/0x1a0 block/blk-throttle.c:2336
       blkcg_init_queue+0x19b/0x620 block/blk-cgroup.c:1301
       __alloc_disk_node+0x260/0x610 block/genhd.c:1365
       __blk_mq_alloc_disk+0x133/0x1c0 block/blk-mq.c:3927
       loop_add+0x3e2/0xaf0 drivers/block/loop.c:1978
       loop_control_ioctl+0x133/0x540 drivers/block/loop.c:2151
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x46/0xb0

-> #1 (&blkcg->lock){....}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
       spin_lock include/linux/spinlock.h:360 [inline]
       blkg_create+0x45e/0x1000 block/blk-cgroup.c:344
       blkcg_init_queue+0xb2/0x620 block/blk-cgroup.c:1282
       __alloc_disk_node+0x260/0x610 block/genhd.c:1365
       __blk_alloc_disk+0x35/0x70 block/genhd.c:1405
       brd_alloc.part.0+0x27f/0x7a0 drivers/block/brd.c:391
       brd_alloc drivers/block/brd.c:374 [inline]
       brd_init+0x1b8/0x24b drivers/block/brd.c:477
       do_one_initcall+0xfe/0x650 init/main.c:1300
       do_initcall_level init/main.c:1375 [inline]
       do_initcalls init/main.c:1391 [inline]
       do_basic_setup init/main.c:1410 [inline]
       kernel_init_freeable+0x6b1/0x73a init/main.c:1617
       kernel_init+0x1a/0x1d0 init/main.c:1506
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

-> #0 (&q->queue_lock){..-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2abe/0x5660 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5665 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
       __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
       _raw_spin_lock_irq+0x32/0x50 kernel/locking/spinlock.c:170
       spin_lock_irq include/linux/spinlock.h:385 [inline]
       throtl_pending_timer_fn+0xf7/0x1690 block/blk-throttle.c:1152
       call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
       expire_timers kernel/time/timer.c:1519 [inline]
       __run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
       __run_timers kernel/time/timer.c:1768 [inline]
       run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
       __do_softirq+0x29b/0x9c2 kernel/softirq.c:571
       invoke_softirq kernel/softirq.c:445 [inline]
       __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
       irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
       sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1106
       asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
       lock_acquire+0x1ef/0x570 kernel/locking/lockdep.c:5633
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
       spin_lock include/linux/spinlock.h:360 [inline]
       new_inode_pseudo fs/inode.c:1022 [inline]
       new_inode+0x48/0x270 fs/inode.c:1047
       debugfs_get_inode+0x1a/0x130 fs/debugfs/inode.c:72
       debugfs_create_dir+0xdc/0x4d0 fs/debugfs/inode.c:578
       bdi_debug_register mm/backing-dev.c:112 [inline]
       bdi_register_va.part.0+0x22d/0x800 mm/backing-dev.c:880
       bdi_register_va mm/backing-dev.c:908 [inline]
       bdi_register+0x12a/0x140 mm/backing-dev.c:905
       device_add_disk+0x83c/0xe20 block/genhd.c:513
       add_disk include/linux/blkdev.h:768 [inline]
       loop_add+0x884/0xaf0 drivers/block/loop.c:2031
       loop_control_ioctl+0x133/0x540 drivers/block/loop.c:2151
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x46/0xb0

other info that might help us debug this:

Chain exists of:
  &q->queue_lock --> &blkcg->lock --> (&sq->pending_timer)

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((&sq->pending_timer));
                               lock(&blkcg->lock);
                               lock((&sq->pending_timer));
  lock(&q->queue_lock);

 *** DEADLOCK ***

3 locks held by syz-executor358/3597:
 #0: ffff888140c48b70 (&sb->s_type->i_mutex_key#3){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #0: ffff888140c48b70 (&sb->s_type->i_mutex_key#3){+.+.}-{3:3}, at: start_creating.part.0+0xb2/0x280 fs/debugfs/inode.c:348
 #1: ffff8880761cf340 (&sb->s_type->i_lock_key#7){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:360 [inline]
 #1: ffff8880761cf340 (&sb->s_type->i_lock_key#7){+.+.}-{2:2}, at: new_inode_pseudo fs/inode.c:1022 [inline]
 #1: ffff8880761cf340 (&sb->s_type->i_lock_key#7){+.+.}-{2:2}, at: new_inode+0x48/0x270 fs/inode.c:1047
 #2: ffffc900001e0d70 ((&sq->pending_timer)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:31 [inline]
 #2: ffffc900001e0d70 ((&sq->pending_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x6b0 kernel/time/timer.c:1464

stack backtrace:
CPU: 1 PID: 3597 Comm: syz-executor358 Not tainted 5.19.0-rc4-next-20220628-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x2abe/0x5660 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5665 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x32/0x50 kernel/locking/spinlock.c:170
 spin_lock_irq include/linux/spinlock.h:385 [inline]
 throtl_pending_timer_fn+0xf7/0x1690 block/blk-throttle.c:1152
 call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
 __run_timers kernel/time/timer.c:1768 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:lock_acquire+0x1ef/0x570 kernel/locking/lockdep.c:5633
Code: e7 a3 7e 83 f8 01 0f 85 e8 02 00 00 9c 58 f6 c4 02 0f 85 fb 02 00 00 48 83 7c 24 08 00 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc90002fffaa0 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff920005fff56 RCX: ffffffff815e3c0e
RDX: 1ffff11004088899 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff906a5967
R10: fffffbfff20d4b2c R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8880761cf340 R15: 0000000000000000
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:360 [inline]
 new_inode_pseudo fs/inode.c:1022 [inline]
 new_inode+0x48/0x270 fs/inode.c:1047
 debugfs_get_inode+0x1a/0x130 fs/debugfs/inode.c:72
 debugfs_create_dir+0xdc/0x4d0 fs/debugfs/inode.c:578
 bdi_debug_register mm/backing-dev.c:112 [inline]
 bdi_register_va.part.0+0x22d/0x800 mm/backing-dev.c:880
 bdi_register_va mm/backing-dev.c:908 [inline]
 bdi_register+0x12a/0x140 mm/backing-dev.c:905
 device_add_disk+0x83c/0xe20 block/genhd.c:513
 add_disk include/linux/blkdev.h:768 [inline]
 loop_add+0x884/0xaf0 drivers/block/loop.c:2031
 loop_control_ioctl+0x133/0x540 drivers/block/loop.c:2151
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f92d80b4079
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcc0861258 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f92d80b4079
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 00007ffcc0861270 R08: 0000000000000002 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	e7 a3                	out    %eax,$0xa3
   2:	7e 83                	jle    0xffffff87
   4:	f8                   	clc
   5:	01 0f                	add    %ecx,(%rdi)
   7:	85 e8                	test   %ebp,%eax
   9:	02 00                	add    (%rax),%al
   b:	00 9c 58 f6 c4 02 0f 	add    %bl,0xf02c4f6(%rax,%rbx,2)
  12:	85 fb                	test   %edi,%ebx
  14:	02 00                	add    (%rax),%al
  16:	00 48 83             	add    %cl,-0x7d(%rax)
  19:	7c 24                	jl     0x3f
  1b:	08 00                	or     %al,(%rax)
  1d:	74 01                	je     0x20
  1f:	fb                   	sti
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	48 01 c3             	add    %rax,%rbx <-- trapping instruction
  2d:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  34:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  3b:	00
  3c:	48                   	rex.W
  3d:	8b                   	.byte 0x8b
  3e:	84                   	.byte 0x84
  3f:	24                   	.byte 0x24

