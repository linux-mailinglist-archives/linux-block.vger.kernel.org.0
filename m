Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FFE483FDF
	for <lists+linux-block@lfdr.de>; Tue,  4 Jan 2022 11:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiADK0R (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 4 Jan 2022 05:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiADK0Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jan 2022 05:26:16 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040D0C061761;
        Tue,  4 Jan 2022 02:26:16 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e202so63984379ybf.4;
        Tue, 04 Jan 2022 02:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+9T/07leZYL+u6jeCf+ODELS7jGXLy0BCeiUyoOyR1c=;
        b=cT0GAxJrjzD92ynzS4sf/JBBRHe2rAL6bQZSUTOwCUslvJ/pQXBHoEk1RpirF17P8h
         CkI4sTAWwe3/IPXum4b58EiAZVBORC88BReAh9Wv+GHZYYt/tzau+FstS03mt4Aa9bhz
         eicoWjMGD5noFGW6PgPvo7US97ZISsyGYbWU3IbkuV7vuD7SW/tDDTqPQPyJULD9p0QJ
         y9tVkiYXpBjSvSYRT8LiBBHDS3mITrkh1L5TaFTdo/rc9jMPXuE7gq4Th/j99Ss8aIAx
         1JnSN/NV07Ur1lXKL/gINlJhgpily5DLFifFhhcN2S9VbJaYKXLMckD7Mqo1ZLrdSXnG
         qkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+9T/07leZYL+u6jeCf+ODELS7jGXLy0BCeiUyoOyR1c=;
        b=Zic7GMsZRpS2dYfNakRTG5DOeQ7xGxtNjlTlexSlnBECmvLcG2tKAjZxI6ycEcPx3P
         WVcglsieDkdY+Evsz48QO6cj1z1uTqAelqlrY4wxcxL85XH/KxmyHgNdS/XrVuIHf7LK
         9QBJ+Yr4+sKme26bjoiKSp5EpFxdytuMMdJPteu2VC8pyssDrU1OJrVBIcLkqKnqKA/U
         cv95KMQu9HywwpxeIjPruuluHr2t8TuHHEPfWtEEMR+o1aUgNN9yY1EuVtMwsN18rNZu
         tuj0z/2f7p6uIYG9BLMb9wOX/DtaNzU0YPRCQKkRaSFOokwL9bl2rU7TnZLKGlG830dT
         aJYA==
X-Gm-Message-State: AOAM530aK8fagYPHVDabFav8XLEwiqPyDoI/nQU9uc79vsxLT9Cwm6OA
        1i3y+MfivN1M+FWYs5jT8v9FDkRrml+pHNcj0/k=
X-Google-Smtp-Source: ABdhPJzJWVZsFcDUbxHMqKQdXnh4Xx3kfG4A23r/I8INgKKCTE4phhTXKO9KlZ5iltZVrJ+vxPspLIzKzI4bBCmqdQo=
X-Received: by 2002:a25:b293:: with SMTP id k19mr55021388ybj.627.1641291975222;
 Tue, 04 Jan 2022 02:26:15 -0800 (PST)
MIME-Version: 1.0
From:   kvartet <xyru1999@gmail.com>
Date:   Tue, 4 Jan 2022 18:26:04 +0800
Message-ID: <CAFkrUshANwa2iLNdjZypUUam7-tarKNp-EAhJMDbJciHKCXe7Q@mail.gmail.com>
Subject: INFO: task hung in blk_mq_get_tag
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc:     sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

When using Syzkaller to fuzz the latest Linux kernel, the following
crash was triggered.

HEAD commit: a7904a538933 Linux 5.16-rc6
git tree: upstream
console output: https://paste.ubuntu.com/p/sBNS3rSWFq/plain/
kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.

If you fix this issue, please add the following tag to the commit:
Reported-by: Yiru Xu <xyru1999@gmail.com>


INFO: task syz-executor.7:13121 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.7  state:D stack:27760 pid:13121 ppid: 12530 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 io_schedule+0xb3/0x120 kernel/sched/core.c:8371
 blk_mq_get_tag+0x58d/0xac0 block/blk-mq-tag.c:158
 __blk_mq_alloc_requests+0x674/0xe00 block/blk-mq.c:486
 blk_mq_alloc_request+0x116/0x210 block/blk-mq.c:520
 scsi_alloc_request+0x1f/0x60 drivers/scsi/scsi_lib.c:1103
 sg_start_req drivers/scsi/sg.c:1727 [inline]
 sg_common_write.isra.0+0x50e/0x1f30 drivers/scsi/sg.c:807
 sg_write+0x7c9/0xda0 drivers/scsi/sg.c:711
 vfs_write+0x22a/0xae0 fs/read_write.c:588
 ksys_write+0x12d/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f90924fe89d
RSP: 002b:00007f9090e6fc28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f909261df60 RCX: 00007f90924fe89d
RDX: 0000000000000030 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007f909256b00d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff4495088f R14: 00007f909261df60 R15: 00007f9090e6fdc0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/39:
 #0: ffffffff8bb80e20 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
1 lock held by in:imklog/6764:
 #0: ffff888018636b70 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0xe9/0x100 fs/file.c:1034
3 locks held by syz-fuzzer/6689:
 #0: ffff888102adc460 (sb_writers#5){.+.+}-{0:0}, at:
do_rmdir+0x1d0/0x390 fs/namei.c:4013
 #1: ffff88802af421d8 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at:
inode_lock_nested include/linux/fs.h:818 [inline]
 #1: ffff88802af421d8 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at:
do_rmdir+0x21b/0x390 fs/namei.c:4017
 #2: ffff888113c5b5c8 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
inode_lock include/linux/fs.h:783 [inline]
 #2: ffff888113c5b5c8 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
vfs_rmdir fs/namei.c:3958 [inline]
 #2: ffff888113c5b5c8 (&type->i_mutex_dir_key#4){++++}-{3:3}, at:
vfs_rmdir+0xe3/0x570 fs/namei.c:3946
3 locks held by kworker/u9:21/13658:
 #0: ffff888100ff0138 ((wq_completion)writeback){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888100ff0138 ((wq_completion)writeback){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888100ff0138 ((wq_completion)writeback){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff888100ff0138 ((wq_completion)writeback){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888100ff0138 ((wq_completion)writeback){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888100ff0138 ((wq_completion)writeback){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc9000f8bfdc8
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffff8881000940e0 (&type->s_umount_key#47){.+.+}-{3:3}, at:
trylock_super+0x1d/0x100 fs/super.c:418
4 locks held by kworker/2:10/30001:
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc9001352fdc8
((work_completion)(&ap->scsi_rescan_task)){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffff8881075ac2a0 (&ap->scsi_scan_mutex){+.+.}-{3:3}, at:
ata_scsi_dev_rescan+0x38/0x230 drivers/ata/libata-scsi.c:4646
 #3: ffff888107c9a3e0 (&dev->mutex){....}-{3:3}, at: device_lock
include/linux/device.h:760 [inline]
 #3: ffff888107c9a3e0 (&dev->mutex){....}-{3:3}, at:
scsi_rescan_device+0x28/0x210 drivers/scsi/scsi_scan.c:1555

=============================================

NMI backtrace for cpu 2
CPU: 2 PID: 39 Comm: khungtaskd Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1a1/0x1e0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xcc8/0x1010 kernel/hung_task.c:295
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 2 to CPUs 0-1,3:
NMI backtrace for cpu 0
CPU: 0 PID: 11470 Comm: kworker/u8:5 Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: bat_events batadv_nc_worker
RIP: 0010:lockdep_enabled kernel/locking/lockdep.c:91 [inline]
RIP: 0010:lock_acquire kernel/locking/lockdep.c:5613 [inline]
RIP: 0010:lock_acquire+0x13b/0x520 kernel/locking/lockdep.c:5602
Code: 85 c5 01 00 00 65 48 8b 14 25 40 70 02 00 48 8d ba 1c 0a 00 00
48 b8 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 0f b6 0c 01 <48> 89
f8 83 e0 07 83 c0 03 38 c8 7c 08 84 c9 0f 85 80 03 00 00 8b
RSP: 0018:ffffc9000fc7fbf0 EFLAGS: 00000213
RAX: dffffc0000000000 RBX: 1ffff92001f8ff80 RCX: 0000000000000000
RDX: ffff888054573980 RSI: 0000000000000001 RDI: ffff88805457439c
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1b20a2b
R10: ffffffff8d905157 R11: fffffbfff1b20a2a R12: 0000000000000002
R13: ffffffff8bb80e20 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563740b0c900 CR3: 000000000b88e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 rcu_lock_acquire include/linux/rcupdate.h:268 [inline]
 rcu_read_lock include/linux/rcupdate.h:688 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:412 [inline]
 batadv_nc_worker+0x114/0x770 net/batman-adv/network-coding.c:723
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2298
 worker_thread+0x90/0xed0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
NMI backtrace for cpu 1 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 1 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:733
NMI backtrace for cpu 3
CPU: 3 PID: 3047 Comm: systemd-journal Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:get_reg+0xef/0x170 arch/x86/kernel/unwind_orc.c:405
Code: 11 00 0f 85 8d 00 00 00 49 89 45 00 41 bc 01 00 00 00 48 83 c4
08 5b 44 89 e0 5d 41 5c 41 5d c3 48 8d 7c f5 00 e8 01 fc ff ff <4c> 89
e9 48 ba 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 11 00 75
RSP: 0018:ffffc9000128f928 EFLAGS: 00000202
RAX: 00007ffd54a44fe0 RBX: ffffc9000128fa50 RCX: 1ffff92000251f54
RDX: 0000000000000006 RSI: 0000000000000004 RDI: ffffc9000128ff78
RBP: ffffc9000128ff58 R08: ffffffff8ea3f366 R09: ffffffff8ea3f360
R10: ffffc9000128faaf R11: 0000000000088089 R12: 0000000000000001
R13: ffffc9000128f9d8 R14: ffffc9000128fa50 R15: ffffc9000128ff58
FS:  00007fbeac5ba8c0(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbea9dca000 CR3: 000000001b63f000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 unwind_next_frame+0xfe8/0x1780 arch/x86/kernel/unwind_orc.c:595
 arch_stack_walk+0x7d/0xe0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:522
 kasan_kmalloc include/linux/kasan.h:269 [inline]
 __kmalloc+0x1d2/0x3d0 mm/slub.c:4423
 kmalloc include/linux/slab.h:595 [inline]
 kzalloc include/linux/slab.h:724 [inline]
 lsm_cred_alloc security/security.c:537 [inline]
 security_prepare_creds+0x10e/0x190 security/security.c:1692
 prepare_creds+0x56e/0x7b0 kernel/cred.c:291
 access_override_creds fs/open.c:351 [inline]
 do_faccessat+0x3f4/0x850 fs/open.c:415
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fbeab8769c7
Code: 83 c4 08 48 3d 01 f0 ff ff 73 01 c3 48 8b 0d c8 d4 2b 00 f7 d8
64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 15 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d a1 d4 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd54a44fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00007ffd54a47ec0 RCX: 00007fbeab8769c7
RDX: 00007fbeac2e7a00 RSI: 0000000000000000 RDI: 000055b9fe0f89a3
RBP: 00007ffd54a44fe0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000069 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffd54a47ec0 R15: 00007ffd54a454d0
 </TASK>
----------------
Code disassembly (best guess):
   0: 85 c5                test   %eax,%ebp
   2: 01 00                add    %eax,(%rax)
   4: 00 65 48              add    %ah,0x48(%rbp)
   7: 8b 14 25 40 70 02 00 mov    0x27040,%edx
   e: 48 8d ba 1c 0a 00 00 lea    0xa1c(%rdx),%rdi
  15: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  1c: fc ff df
  1f: 48 89 f9              mov    %rdi,%rcx
  22: 48 c1 e9 03          shr    $0x3,%rcx
  26: 0f b6 0c 01          movzbl (%rcx,%rax,1),%ecx
* 2a: 48 89 f8              mov    %rdi,%rax <-- trapping instruction
  2d: 83 e0 07              and    $0x7,%eax
  30: 83 c0 03              add    $0x3,%eax
  33: 38 c8                cmp    %cl,%al
  35: 7c 08                jl     0x3f
  37: 84 c9                test   %cl,%cl
  39: 0f 85 80 03 00 00    jne    0x3bf
  3f: 8b                    .byte 0x8b



Best Regards,
Yiru
