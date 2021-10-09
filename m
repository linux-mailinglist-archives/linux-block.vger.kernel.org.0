Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1021427774
	for <lists+linux-block@lfdr.de>; Sat,  9 Oct 2021 06:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhJIEzQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 9 Oct 2021 00:55:16 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56961 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhJIEzP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Oct 2021 00:55:15 -0400
Received: by mail-io1-f69.google.com with SMTP id c13-20020a05660221cd00b005dc19a5a0d7so9015730ioc.23
        for <linux-block@vger.kernel.org>; Fri, 08 Oct 2021 21:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ldq/eeJq55e5+SnKc0ChFcNirMVqpAzKLm/VtRdsn4c=;
        b=5OPzcCtIfbZVSou9hfdXrLrZSjhPCrh4eTL/ANAU/uKBDPDLvvuD0yavpTxVdDFKCs
         NuDuF0kbTy7Uec4shrmL8232Ssx7TvJ70sRewydj9JIx0RrEOc377PHiOfcMqr+DNgwm
         EasKAjbZIgSb3PKJL7IxFu6YFCy6OdM32B6TNNKm9V0ECLAOmh633Zhl3ZZHz9+T0ypV
         XjZFCi/JUf3sGQyBAHYlEGUaM3BGS6p9HMq+dLhVOHO1wk/9iXTUmnhNQSwugkA2axK5
         F270p/HmOOFY8kLouciR2uhFm8mTypdnbpZ3PXnFaIHWHJFNuTxNqj+bDPiLC8wWkgPc
         l54g==
X-Gm-Message-State: AOAM532lnKmCkT8XbDCqc+giSPVJEjNu61t3iukCKCIhTKBoq1spY0P9
        LcVe+za0r3iLwvu/EhakzU8c19XjqD0Lio/QFJWz6Qhh7rTD
X-Google-Smtp-Source: ABdhPJxMIID9TjnBtS6ROM82KgV7SKERDvMp7ZY85sRJx8N5facJf6FMq0sHZ75amlvQWH546VGDw/QV28faeE/Q6Hb3FGJIbeHX
MIME-Version: 1.0
X-Received: by 2002:a02:a90c:: with SMTP id n12mr10243738jam.89.1633755197469;
 Fri, 08 Oct 2021 21:53:17 -0700 (PDT)
Date:   Fri, 08 Oct 2021 21:53:17 -0700
In-Reply-To: <0000000000004a5adf05cc593ca9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031f84a05cde44697@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in bdev_free_inode
From:   syzbot <syzbot+8281086e8a6fbfbd952a@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    741668ef7832 Merge tag 'usb-5.15-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101a9d00b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76f7496a8217e5ec
dashboard link: https://syzkaller.appspot.com/bug?extid=8281086e8a6fbfbd952a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170487b7300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8281086e8a6fbfbd952a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in bdev_free_inode+0x202/0x220 block/bdev.c:407
Read of size 8 at addr ffff88806e022148 by task systemd-udevd/8843

CPU: 1 PID: 8843 Comm: systemd-udevd Not tainted 5.15.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x6c/0x2d6 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 bdev_free_inode+0x202/0x220 block/bdev.c:407
 i_callback+0x3f/0x70 fs/inode.c:226
 rcu_do_batch kernel/rcu/tree.c:2508 [inline]
 rcu_core+0x7ab/0x1470 kernel/rcu/tree.c:2743
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:636
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:__sanitizer_cov_trace_const_cmp1+0x77/0x80 kernel/kcov.c:272
Code: f0 72 27 41 0f b6 fb 41 0f b6 c9 48 83 c2 01 48 c7 44 30 e0 01 00 00 00 48 89 7c 30 e8 48 89 4c 30 f0 4c 89 54 d8 20 48 89 10 <5b> c3 0f 1f 80 00 00 00 00 53 41 89 fb 41 89 f1 bf 03 00 00 00 65
RSP: 0018:ffffc9000ddef8f8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff888075942040
RDX: 0000000000000000 RSI: ffff888075942040 RDI: 0000000000000003
RBP: ffff88801e525f00 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff83a9492a R11: 0000000000000010 R12: 0000000000000002
R13: 000000000000010d R14: dffffc0000000000 R15: 0000000000000000
 tomoyo_domain_quota_is_ok+0x32a/0x550 security/tomoyo/util.c:1092
 tomoyo_supervisor+0x2f2/0xf00 security/tomoyo/common.c:2089
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission security/tomoyo/file.c:587 [inline]
 tomoyo_path_permission+0x270/0x3a0 security/tomoyo/file.c:573
 tomoyo_path_perm+0x2f0/0x400 security/tomoyo/file.c:838
 security_inode_getattr+0xcf/0x140 security/security.c:1333
 vfs_getattr fs/stat.c:157 [inline]
 vfs_fstat+0x43/0xb0 fs/stat.c:182
 __do_sys_newfstat+0x81/0x100 fs/stat.c:422
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fc02b7062e2
Code: 48 8b 05 b9 db 2b 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 83 ff 01 77 33 48 63 fe b8 05 00 00 00 48 89 d6 0f 05 <48> 3d 00 f0 ff ff 77 06 f3 c3 0f 1f 40 00 48 8b 15 81 db 2b 00 f7
RSP: 002b:00007fffd25fb168 EFLAGS: 00000246 ORIG_RAX: 0000000000000005
RAX: ffffffffffffffda RBX: 00007fc02b9c1440 RCX: 00007fc02b7062e2
RDX: 00007fffd25fb170 RSI: 00007fffd25fb170 RDI: 0000000000000007
RBP: 000055a86b68e0d0 R08: 00007fc02c8948c0 R09: 0000000000000230
R10: 000055a869f246bb R11: 0000000000000246 R12: 000055a869f246bb
R13: 0000000000000002 R14: 00007fc02b9c1440 R15: 0000000000000002

Allocated by task 15227:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa1/0xd0 mm/kasan/common.c:522
 kasan_kmalloc include/linux/kasan.h:264 [inline]
 kmem_cache_alloc_node_trace+0x20b/0x5d0 mm/slab.c:3619
 kmalloc_node include/linux/slab.h:609 [inline]
 kzalloc_node include/linux/slab.h:732 [inline]
 __alloc_disk_node+0x77/0x580 block/genhd.c:1238
 __blk_mq_alloc_disk+0xed/0x160 block/blk-mq.c:3140
 loop_add+0x340/0x960 drivers/block/loop.c:2344
 loop_control_get_free drivers/block/loop.c:2501 [inline]
 loop_control_ioctl+0x227/0x4a0 drivers/block/loop.c:2516
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 15227:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xd1/0x110 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 __cache_free mm/slab.c:3445 [inline]
 kfree+0x10a/0x2c0 mm/slab.c:3803
 __alloc_disk_node+0x474/0x580 block/genhd.c:1275
 __blk_mq_alloc_disk+0xed/0x160 block/blk-mq.c:3140
 loop_add+0x340/0x960 drivers/block/loop.c:2344
 loop_control_get_free drivers/block/loop.c:2501 [inline]
 loop_control_ioctl+0x227/0x4a0 drivers/block/loop.c:2516
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xa7/0xd0 mm/kasan/generic.c:348
 kvfree_call_rcu+0x74/0x990 kernel/rcu/tree.c:3552
 neigh_destroy+0x419/0x620 net/core/neighbour.c:859
 neigh_release include/net/neighbour.h:425 [inline]
 neigh_cleanup_and_release+0x1fd/0x340 net/core/neighbour.c:103
 neigh_del net/core/neighbour.c:197 [inline]
 neigh_remove_one+0x37d/0x460 net/core/neighbour.c:218
 neigh_forced_gc net/core/neighbour.c:248 [inline]
 neigh_alloc net/core/neighbour.c:395 [inline]
 ___neigh_create+0x1799/0x26b0 net/core/neighbour.c:583
 ip6_finish_output2+0x1089/0x1500 net/ipv6/ip6_output.c:123
 __ip6_finish_output net/ipv6/ip6_output.c:191 [inline]
 __ip6_finish_output+0x4c1/0x1050 net/ipv6/ip6_output.c:170
 ip6_finish_output+0x32/0x200 net/ipv6/ip6_output.c:201
 NF_HOOK_COND include/linux/netfilter.h:296 [inline]
 ip6_output+0x1e4/0x530 net/ipv6/ip6_output.c:224
 dst_output include/net/dst.h:450 [inline]
 NF_HOOK include/linux/netfilter.h:307 [inline]
 ndisc_send_skb+0xa99/0x17f0 net/ipv6/ndisc.c:508
 ndisc_send_rs+0x12e/0x6f0 net/ipv6/ndisc.c:702
 addrconf_rs_timer+0x3f2/0x820 net/ipv6/addrconf.c:3893
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1466 [inline]
 __run_timers.part.0+0x675/0xa20 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558

The buggy address belongs to the object at ffff88806e022000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 328 bytes inside of
 1024-byte region [ffff88806e022000, ffff88806e022400)
The buggy address belongs to the page:
page:ffffea0001b80880 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88806e022800 pfn:0x6e022
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea00006c07c8 ffffea0000846d88 ffff888010c40700
raw: ffff88806e022800 ffff88806e022000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2c2220(__GFP_HIGH|__GFP_ATOMIC|__GFP_NOWARN|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_THISNODE), pid 158, ts 99636399470, free_ts 99492418189
 prep_new_page mm/page_alloc.c:2424 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4153
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5375
 __alloc_pages_node include/linux/gfp.h:570 [inline]
 kmem_getpages mm/slab.c:1377 [inline]
 cache_grow_begin+0x75/0x460 mm/slab.c:2593
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2965
 ____cache_alloc mm/slab.c:3048 [inline]
 ____cache_alloc mm/slab.c:3031 [inline]
 slab_alloc_node mm/slab.c:3249 [inline]
 kmem_cache_alloc_node_trace+0x4ca/0x5d0 mm/slab.c:3617
 __do_kmalloc_node mm/slab.c:3639 [inline]
 __kmalloc_node_track_caller+0x38/0x60 mm/slab.c:3654
 kmalloc_reserve net/core/skbuff.c:355 [inline]
 __alloc_skb+0xde/0x340 net/core/skbuff.c:426
 alloc_skb include/linux/skbuff.h:1116 [inline]
 wg_socket_send_buffer_to_peer+0x2f/0x170 drivers/net/wireguard/socket.c:191
 wg_packet_send_handshake_initiation+0x212/0x340 drivers/net/wireguard/send.c:40
 wg_packet_handshake_send_worker+0x18/0x30 drivers/net/wireguard/send.c:51
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3315 [inline]
 free_unref_page_list+0x1a9/0xfa0 mm/page_alloc.c:3431
 release_pages+0x830/0x20b0 mm/swap.c:963
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu mm/mmu_gather.c:249 [inline]
 tlb_finish_mmu+0x165/0x8c0 mm/mmu_gather.c:340
 exit_mmap+0x1ea/0x630 mm/mmap.c:3173
 __mmput+0x122/0x4b0 kernel/fork.c:1115
 mmput+0x58/0x60 kernel/fork.c:1136
 free_bprm+0x65/0x2e0 fs/exec.c:1483
 kernel_execve+0x380/0x460 fs/exec.c:1980
 call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff88806e022000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806e022080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806e022100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff88806e022180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806e022200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	f0 72 27             	lock jb 0x2a
   3:	41 0f b6 fb          	movzbl %r11b,%edi
   7:	41 0f b6 c9          	movzbl %r9b,%ecx
   b:	48 83 c2 01          	add    $0x1,%rdx
   f:	48 c7 44 30 e0 01 00 	movq   $0x1,-0x20(%rax,%rsi,1)
  16:	00 00
  18:	48 89 7c 30 e8       	mov    %rdi,-0x18(%rax,%rsi,1)
  1d:	48 89 4c 30 f0       	mov    %rcx,-0x10(%rax,%rsi,1)
  22:	4c 89 54 d8 20       	mov    %r10,0x20(%rax,%rbx,8)
  27:	48 89 10             	mov    %rdx,(%rax)
* 2a:	5b                   	pop    %rbx <-- trapping instruction
  2b:	c3                   	retq
  2c:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  33:	53                   	push   %rbx
  34:	41 89 fb             	mov    %edi,%r11d
  37:	41 89 f1             	mov    %esi,%r9d
  3a:	bf 03 00 00 00       	mov    $0x3,%edi
  3f:	65                   	gs

