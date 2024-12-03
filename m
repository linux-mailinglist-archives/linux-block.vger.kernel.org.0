Return-Path: <linux-block+bounces-14807-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC70D9E1927
	for <lists+linux-block@lfdr.de>; Tue,  3 Dec 2024 11:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4412AB24EA0
	for <lists+linux-block@lfdr.de>; Tue,  3 Dec 2024 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19C91E0B80;
	Tue,  3 Dec 2024 10:05:30 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24B51DF997
	for <linux-block@vger.kernel.org>; Tue,  3 Dec 2024 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220330; cv=none; b=q25FCkaOzqxCuCZfL2+7Rf3kDzEUiN5h7yhfcC3+0blY+580T67Ycr9flo2hcN7kxE3ebjYB0Jh/0hUkYx80zIRhj5chD+2QpojTGrDXIxsbYyNh6IJv19BP2B+cJvJ7lcnhu4Xb2mV5BnfygQrKvAVidnKIyMNsA81OGtfc8Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220330; c=relaxed/simple;
	bh=eGLCsoU5UhPayHYJyQH3fZBUXUGqw78JsWtb370OmIs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GlXHaSNVQchOm3HDIJEBZSsY5IrpLAaoQ0umRQARQOlRTM3q4hx9OEtankk74O6TtdfILbSe+arNEMD0mJmERWixn0qfvhqmH2fRATAg2sF1wW1HVRE6qkxNkB6laxpihouESugSj5iktR15b8HBi35Thv1YhvugpPnd4RXf6RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a77a808c27so63339375ab.1
        for <linux-block@vger.kernel.org>; Tue, 03 Dec 2024 02:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220328; x=1733825128;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMMZQhF3ZH/YIe95dgi57cUCdWtzNg5zbvtUk78lXHc=;
        b=DG9DLpdpoJc7IK+icxhkfa/DR8LYun3u2JnlD07gHu5+qSagSJV/z/1pmw3F0090AE
         qe1HgnB+BCOAOsLXG94uxF/3J56S9AdLfA8TN8zCXFm+d0p0enNKj2cj2KBofSKFUI0H
         M8QHyIP2R/Z766h5MnNSYJztRYKp/bWV5JYMIuJtNDRGFaFudWgTfeBhOGpOp0ogpnWg
         AgqMRwQ6ZT8B3c+0/zSGY7D5eANQENqp3zgWvKF6PgAPu8z5wVkS/pgOiDgC1j3bimO9
         qcJFrOjWoYHzFav4vPOfNNFPnJ/Hu1hlrY6ozhQmXu0UiLKX3C3B6TqZu52Fp4JUMCtG
         6osA==
X-Forwarded-Encrypted: i=1; AJvYcCUuQ6mWYj5biDR9UBk0cpq9FPZosfG/miqPBYMBhzfAQihxAdgutp/j3QIBSCOzWmgooa8to5WlBIkk4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ73dQKnqSHoyEWD+CLvGWO4Qh66TPM+2lA8jBBHvHBMSoQhOH
	d/B0eFhjplTiS6JgLiNS8a23NgQYkDg/cyGaGd6927iGLJ/YKHV0iRFYIUX7dWiBn4mOiJsBJ3k
	CQb8G9H9LiQrutasIFED5//mSwkD2pkeQtViraz+WDnv2rgPUJVztHiU=
X-Google-Smtp-Source: AGHT+IFykq5RbW+qOR9z1bnYfFVE4hMxZqSrj6KCqL2c9r3GmC1xiwHvf4gTEkvbc5e49InrsBc9OPr8+lTIiuLVAytGDwZAWiWu
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:3a7:e701:bd0f with SMTP id
 e9e14a558f8ab-3a7f9aa4e27mr19568675ab.21.1733220328063; Tue, 03 Dec 2024
 02:05:28 -0800 (PST)
Date: Tue, 03 Dec 2024 02:05:28 -0800
In-Reply-To: <67455483.050a0220.1286eb.000f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674ed7e8.050a0220.48a03.0031.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] BUG: unable to handle kernel paging request in
 try_to_wake_up (2)
From: syzbot <syzbot+b7cf50a0c173770dcb14@syzkaller.appspotmail.com>
To: axboe@kernel.dk, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    cdd30ebb1b9f module: Convert symbol namespace to string li..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17f78330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91c852e3d1d7c1a6
dashboard link: https://syzkaller.appspot.com/bug?extid=b7cf50a0c173770dcb14
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140e75e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b1e80f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e7e1e116ea6e/disk-cdd30ebb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/76410fd02a13/vmlinux-cdd30ebb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/60bcdb55dd9c/bzImage-cdd30ebb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e76e3f28b6bd/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7cf50a0c173770dcb14@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __lock_acquire+0x78/0x2100 kernel/locking/lockdep.c:5089
Read of size 8 at addr ffff8880259d2818 by task kworker/u8:3/52

CPU: 1 UID: 0 PID: 52 Comm: kworker/u8:3 Not tainted 6.13.0-rc1-syzkaller-00002-gcdd30ebb1b9f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: btrfs-delalloc btrfs_work_helper
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 __lock_acquire+0x78/0x2100 kernel/locking/lockdep.c:5089
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
 try_to_wake_up+0xc2/0x1470 kernel/sched/core.c:4205
 submit_compressed_extents+0xdf/0x16e0 fs/btrfs/inode.c:1615
 run_ordered_work fs/btrfs/async-thread.c:288 [inline]
 btrfs_work_helper+0x96f/0xc40 fs/btrfs/async-thread.c:324
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 2:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_node_noprof+0x1d9/0x380 mm/slub.c:4205
 alloc_task_struct_node kernel/fork.c:180 [inline]
 dup_task_struct+0x57/0x8c0 kernel/fork.c:1113
 copy_process+0x5d1/0x3d50 kernel/fork.c:2225
 kernel_clone+0x223/0x870 kernel/fork.c:2807
 kernel_thread+0x1bc/0x240 kernel/fork.c:2869
 create_kthread kernel/kthread.c:412 [inline]
 kthreadd+0x60d/0x810 kernel/kthread.c:767
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 24:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kmem_cache_free+0x195/0x410 mm/slub.c:4700
 put_task_struct include/linux/sched/task.h:144 [inline]
 delayed_put_task_struct+0x125/0x300 kernel/exit.c:227
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:943
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 __call_rcu_common kernel/rcu/tree.c:3086 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
 context_switch kernel/sched/core.c:5372 [inline]
 __schedule+0x1803/0x4be0 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_timeout+0xb0/0x290 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 kthread_stop+0x19e/0x640 kernel/kthread.c:712
 close_ctree+0x524/0xd60 fs/btrfs/disk-io.c:4328
 generic_shutdown_super+0x139/0x2d0 fs/super.c:642
 kill_anon_super+0x3b/0x70 fs/super.c:1237
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2112
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 ptrace_notify+0x2d2/0x380 kernel/signal.c:2503
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc7/0x1d0 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x24a/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880259d1e00
 which belongs to the cache task_struct of size 7424
The buggy address is located 2584 bytes inside of
 freed 7424-byte region [ffff8880259d1e00, ffff8880259d3b00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x259d0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802f4b56c1
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801bafe500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000001f5000000 ffff88802f4b56c1
head: 00fff00000000040 ffff88801bafe500 dead000000000100 dead000000000122
head: 0000000000000000 0000000000040004 00000001f5000000 ffff88802f4b56c1
head: 00fff00000000003 ffffea0000967401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 12, tgid 12 (kworker/u8:1), ts 7328037942, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2408
 allocate_slab+0x5a/0x2f0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 kmem_cache_alloc_node_noprof+0x269/0x380 mm/slub.c:4205
 alloc_task_struct_node kernel/fork.c:180 [inline]
 dup_task_struct+0x57/0x8c0 kernel/fork.c:1113
 copy_process+0x5d1/0x3d50 kernel/fork.c:2225
 kernel_clone+0x223/0x870 kernel/fork.c:2807
 user_mode_thread+0x132/0x1a0 kernel/fork.c:2885
 call_usermodehelper_exec_work+0x5c/0x230 kernel/umh.c:171
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880259d2700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880259d2780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880259d2800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff8880259d2880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880259d2900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

