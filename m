Return-Path: <linux-block+bounces-6545-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EB08B1C9D
	for <lists+linux-block@lfdr.de>; Thu, 25 Apr 2024 10:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83F21F21958
	for <lists+linux-block@lfdr.de>; Thu, 25 Apr 2024 08:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5F0839E0;
	Thu, 25 Apr 2024 08:10:39 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C357318A
	for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032639; cv=none; b=MTb0ah5mkLJyiVLFaicJ0QcjHj2GexfjRko4T7cnwuTPCPIDfbVZqUR33cS2fhKBGBsWI6ayqMpj2bqP7FWOCaNs7acF83Cz6y/1oMW61zLRK6vLlKfWsUZR5KPn22cUhSHV8WCuqL8CAvd3XCO70fD6ChAjHWeoiuIoqE3ACFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032639; c=relaxed/simple;
	bh=jyKsK1dz2L5hYxM9rofbJhFXA/vw/fu6ITUF8bP6KM0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kaFwU1w5gOwknQLHQntIAIfOB/8m80o6OmdE7P60OsF7TtsmOj48D33qcjUcQiYDLTbp9lMTWaR65wEXsavWrAB0yiW0insxdcQ0MnQn6/zTbPuaXlVYzsRnxxCfCkyxcnSPnWpnb0vWeOwDx/BsR2mDBbZ6rBmoOLDaB9QJpGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da41c44e78so76502839f.1
        for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 01:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714032636; x=1714637436;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WX8uYCHjJP4rhNAvoX3TgmhDSoXbZBcCaeMCB4UUw8Q=;
        b=l1xpaM5cPPNfEnEeZyAdECeP7ryjPR3JdlkFRUN1LrwWz554Ol/m/YD1cO9gq/RneU
         3gdpxd0EYRMtZURv37arJyWx773sQdop05yriOILhuzPuKLZ15zwYQodtpCvaaze9772
         dGvlEHwqof2t7Yd1IBVhBHdHNF0X6BXpBXnxGqVxL3lTnpQKZQLm5zTj5CR75cFLSmOf
         ZgyEVyDrkctAaO2YM71umHPIkYPVqzG47QEGcfHoC4RqCxv+SMqvX1b4nIeuCQOxgUtd
         QoqF4h2XANP2TY/e3UKvjjsWnXe8DcpyTZH31afcAcvpqO8QJe44vOeOVuV6GC1j7ss+
         VSBw==
X-Forwarded-Encrypted: i=1; AJvYcCVY/i0b7Qk6Yv4NUrmUAhV9Y/iEISSSptkcwrHVbNqSZN9QIajIL47rMG0x31xmq53/fLiybj5LJcqO+bL1zz8XeP0K0q6o7vUVy68=
X-Gm-Message-State: AOJu0Yys36bGwO8WeN6sFA4rXGM2g2NozLM67UNglYGoIdaRnYgRKlHE
	jvaQT3xePZjttoGvZ5Z6uDJ6xhAmd1krusuQdvBYUsatBn6ZIonlPoIV9JQy4M81B2Wm6vKd9vC
	xze2JOWJ6K1INWwNp7+J+RtqDjiU6Zk0jdjPAdLKedXG1l14pG+20pa0=
X-Google-Smtp-Source: AGHT+IF80jQN0AdHolGsIbKeqO9QtFnKimOBsi6laIuPPKVMzJ567GH22LgtRKsW8r881iqY9xgZvjKiOykDh3GVzWJZ3sJ9lKEm
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60cc:b0:7da:eb31:7c9d with SMTP id
 ft12-20020a05660260cc00b007daeb317c9dmr67006iob.2.1714032636696; Thu, 25 Apr
 2024 01:10:36 -0700 (PDT)
Date: Thu, 25 Apr 2024 01:10:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071af590616e7522e@google.com>
Subject: [syzbot] [block?] WARNING in stack_depot_save_flags
From: syzbot <syzbot+008359eebe36a927e9f6@syzkaller.appspotmail.com>
To: axboe@kernel.dk, justin@coraid.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=12eb21c7180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=008359eebe36a927e9f6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ed666f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111d6e10980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65d3f3eb786e/disk-f99c5f56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799cf7f28ff8/vmlinux-f99c5f56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab26c60c3845/bzImage-f99c5f56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+008359eebe36a927e9f6@syzkaller.appspotmail.com

------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 0 PID: 0 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Modules linked in:

CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d de 69 01 04 00 74 06 90 c3 cc cc cc cc c6 05 cf 69 01 04 01 90 48 c7 c7 20 ba aa 8b e8 f8 e5 e7 f5 90 <0f> 0b 90 90 90 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
RSP: 0018:ffffc90000007458 EFLAGS: 00010246

RAX: 3d6c26024352bb00 RBX: 1ffff92000000e98 RCX: ffffffff8de94680
RDX: 0000000000000102 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900000075a8 R08: ffffffff8157cc12 R09: 1ffff110172851a2
R10: dffffc0000000000 R11: ffffed10172851a3 R12: 1ffff92000000e94
R13: dffffc0000000000 R14: ffffc900000074c0 R15: 0000000000000046
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f976a9f53c0 CR3: 000000007ba22000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 lock_acquire+0x3db/0x530 kernel/locking/lockdep.c:5757
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 stack_depot_save_flags+0x246/0x860 lib/stackdepot.c:681
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_save_track+0x51/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc_node+0x192/0x380 mm/slub.c:3903
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:658
 alloc_skb include/linux/skbuff.h:1318 [inline]
 new_skb drivers/block/aoe/aoecmd.c:66 [inline]
 aoecmd_cfg_pkts drivers/block/aoe/aoecmd.c:427 [inline]
 aoecmd_cfg+0x2d3/0xa30 drivers/block/aoe/aoecmd.c:1362
 call_timer_fn+0x17e/0x600 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2408 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2419
 run_timer_base kernel/time/timer.c:2428 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2438
 __do_softirq+0x2bc/0x943 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:113
Code: 90 90 90 90 90 90 90 90 90 65 48 8b 04 25 80 ce 03 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d 15 4a 98 00 f3 0f 1e fa fb f4 <fa> c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffffff8de07ca8 EFLAGS: 00000246

RAX: ffffffff8de94680 RBX: ffff88801ae9b864 RCX: 0000000000014b69
RDX: 0000000000000001 RSI: ffff88801ae9b800 RDI: ffff88801ae9b864
RBP: 0000000000039f18 R08: ffff8880b9437d0b R09: 1ffff11017286fa1
R10: dffffc0000000000 R11: ffffffff8b701580 R12: ffff88801cbd8000
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8e8a2e80
 acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x118/0x490 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x375/0x5d0 kernel/sched/idle.c:332
 cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:430
 rest_init+0x2e0/0x300 init/main.c:730
 arch_call_rest_init+0xe/0x10 init/main.c:831
 start_kernel+0x47a/0x500 init/main.c:1077
 x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
 x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
 common_startup_64+0x13e/0x147
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	65 48 8b 04 25 80 ce 	mov    %gs:0x3ce80,%rax
  10:	03 00
  12:	48 f7 00 08 00 00 00 	testq  $0x8,(%rax)
  19:	75 10                	jne    0x2b
  1b:	66 90                	xchg   %ax,%ax
  1d:	0f 00 2d 15 4a 98 00 	verw   0x984a15(%rip)        # 0x984a39
  24:	f3 0f 1e fa          	endbr64
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  37:	00 00
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

