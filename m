Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386784D79F3
	for <lists+linux-block@lfdr.de>; Mon, 14 Mar 2022 05:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiCNEq3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 14 Mar 2022 00:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiCNEq2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 00:46:28 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8712413D6C
        for <linux-block@vger.kernel.org>; Sun, 13 Mar 2022 21:45:19 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id w28-20020a05660205dc00b00645d3cdb0f7so11477358iox.10
        for <linux-block@vger.kernel.org>; Sun, 13 Mar 2022 21:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lU/XIXKZn4F9zm+7igwJpi8XQqygtgEUGB9afzywV84=;
        b=jGgVnLkLUmkNfJle7wNji2U/7AQ0xr96rZHVf8aUmWl5+p4GrrLkcGXbROdOAa5GwM
         6HUMTvi9rcWaQsUA9f2Qm+9EcpU57vTBHH4LNDB9amRDFzFENMsAcU2WXLr+PigSHz/Q
         qorMxpuSj2hOAYLXr9aNyu7e8eCWo+xP7gZokfxUbod8/GFQ7q6NF7HKsNPJmHlLzBcr
         L2yItVjzcPC78rYnSoFDwgymfActEi+QmDwvMGGaYd1JOgyYhDDEWA9TPsIizJwNqpy3
         2x/nwhHBUJvrr9qHoW9jFtDZ1uUwPPioFzJuw1gW7mPrGEI13EpyYXU2twtLQ+smOGXc
         E3lw==
X-Gm-Message-State: AOAM531FppL3PFBHoTZHyIwGwFy0M0af85GcGM+LZq2JRBxz2Y5LS2jD
        IOhfTzQ8CMT9Vtx/kZ+1nM/Vs9AeZvOv2SfA1Ec1aGYdM0on
X-Google-Smtp-Source: ABdhPJyhmOxjYABwFXVuB/sdOK1y3ea0X8uCodi46W0+sHCqZF1fF2n2DiFaKEB3fjEHxcO1Dfqi0Cr4unV5Lq/qN3OsEE2nxa0X
MIME-Version: 1.0
X-Received: by 2002:a6b:fd0c:0:b0:645:d261:ba25 with SMTP id
 c12-20020a6bfd0c000000b00645d261ba25mr18103925ioi.124.1647233118924; Sun, 13
 Mar 2022 21:45:18 -0700 (PDT)
Date:   Sun, 13 Mar 2022 21:45:18 -0700
In-Reply-To: <00000000000099c4ca05da07e42f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea753505da2658d5@google.com>
Subject: Re: [syzbot] possible deadlock in blkdev_put (3)
From:   syzbot <syzbot+6479585dfd4dedd3f7e1@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hch@lst.de, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    f0e18b03fcaf Merge tag 'x86_urgent_for_v5.17_rc8' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1547fb03700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aba0ab2928a512c2
dashboard link: https://syzkaller.appspot.com/bug?extid=6479585dfd4dedd3f7e1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1704bd29700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f78d41700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6479585dfd4dedd3f7e1@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.17.0-rc7-syzkaller-00241-gf0e18b03fcaf #0 Not tainted
------------------------------------------------------
udevd/3652 is trying to acquire lock:
ffff888018c7a938 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0xe1/0x13a0 kernel/workqueue.c:2824

but task is already holding lock:
ffff88801a0fa918 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x99/0x950 block/bdev.c:902

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (&disk->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:600 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:733
       blkdev_get_by_dev.part.0+0x40e/0xc70 block/bdev.c:804
       blkdev_get_by_dev+0x6b/0x80 block/bdev.c:847
       swsusp_check+0x97/0x420 kernel/power/swap.c:1526
       software_resume.part.0+0x102/0x1f0 kernel/power/hibernate.c:979
       software_resume kernel/power/hibernate.c:86 [inline]
       resume_store+0x161/0x190 kernel/power/hibernate.c:1181
       kobj_attr_store+0x50/0x80 lib/kobject.c:856
       sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
       kernfs_fop_write_iter+0x3f8/0x610 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2074 [inline]
       new_sync_write+0x431/0x660 fs/read_write.c:503
       vfs_write+0x7cd/0xae0 fs/read_write.c:590
       ksys_write+0x12d/0x250 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #5 (system_transition_mutex/1){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:600 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:733
       software_resume.part.0+0x19/0x1f0 kernel/power/hibernate.c:934
       software_resume kernel/power/hibernate.c:86 [inline]
       resume_store+0x161/0x190 kernel/power/hibernate.c:1181
       kobj_attr_store+0x50/0x80 lib/kobject.c:856
       sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
       kernfs_fop_write_iter+0x3f8/0x610 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2074 [inline]
       new_sync_write+0x431/0x660 fs/read_write.c:503
       vfs_write+0x7cd/0xae0 fs/read_write.c:590
       ksys_write+0x12d/0x250 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #4 (&of->mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:600 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:733
       kernfs_seq_start+0x47/0x470 fs/kernfs/file.c:112
       seq_read_iter+0x2c6/0x1280 fs/seq_file.c:225
       kernfs_fop_read_iter+0x514/0x6f0 fs/kernfs/file.c:241
       call_read_iter include/linux/fs.h:2068 [inline]
       new_sync_read+0x429/0x6e0 fs/read_write.c:400
       vfs_read+0x35c/0x600 fs/read_write.c:481
       ksys_read+0x12d/0x250 fs/read_write.c:619
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #3 (&p->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:600 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:733
       seq_read_iter+0xdf/0x1280 fs/seq_file.c:182
       call_read_iter include/linux/fs.h:2068 [inline]
       generic_file_splice_read+0x45b/0x6d0 fs/splice.c:311
       do_splice_to+0x1bf/0x250 fs/splice.c:796
       splice_direct_to_actor+0x2c2/0x8c0 fs/splice.c:870
       do_splice_direct+0x1b3/0x280 fs/splice.c:979
       do_sendfile+0xaf2/0x1250 fs/read_write.c:1245
       __do_sys_sendfile64 fs/read_write.c:1310 [inline]
       __se_sys_sendfile64 fs/read_write.c:1296 [inline]
       __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1296
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (sb_writers#3){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1722 [inline]
       sb_start_write include/linux/fs.h:1792 [inline]
       file_start_write include/linux/fs.h:2937 [inline]
       lo_write_bvec drivers/block/loop.c:243 [inline]
       lo_write_simple drivers/block/loop.c:266 [inline]
       do_req_filebacked drivers/block/loop.c:495 [inline]
       loop_handle_cmd drivers/block/loop.c:1852 [inline]
       loop_process_work+0x1499/0x1db0 drivers/block/loop.c:1892
       process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
       worker_thread+0x657/0x1110 kernel/workqueue.c:2454
       kthread+0x2e9/0x3a0 kernel/kthread.c:377
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
       process_one_work+0x91b/0x1650 kernel/workqueue.c:2283
       worker_thread+0x657/0x1110 kernel/workqueue.c:2454
       kthread+0x2e9/0x3a0 kernel/kthread.c:377
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #0 ((wq_completion)loop0){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3063 [inline]
       check_prevs_add kernel/locking/lockdep.c:3186 [inline]
       validate_chain kernel/locking/lockdep.c:3801 [inline]
       __lock_acquire+0x2ad4/0x56c0 kernel/locking/lockdep.c:5027
       lock_acquire kernel/locking/lockdep.c:5639 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
       flush_workqueue+0x110/0x13a0 kernel/workqueue.c:2827
       drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2992
       destroy_workqueue+0x71/0x800 kernel/workqueue.c:4429
       __loop_clr_fd+0x1ab/0xe20 drivers/block/loop.c:1124
       lo_release+0x1ac/0x1f0 drivers/block/loop.c:1756
       blkdev_put_whole block/bdev.c:689 [inline]
       blkdev_put+0x2de/0x950 block/bdev.c:944
       blkdev_close+0x6a/0x80 block/fops.c:517
       __fput+0x286/0x9f0 fs/file_table.c:317
       task_work_run+0xdd/0x1a0 kernel/task_work.c:164
       tracehook_notify_resume include/linux/tracehook.h:188 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
       exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
       __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
       syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
       do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  (wq_completion)loop0 --> system_transition_mutex/1 --> &disk->open_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&disk->open_mutex);
                               lock(system_transition_mutex/1);
                               lock(&disk->open_mutex);
  lock((wq_completion)loop0);

 *** DEADLOCK ***

1 lock held by udevd/3652:
 #0: ffff88801a0fa918 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x99/0x950 block/bdev.c:902

stack backtrace:
CPU: 0 PID: 3652 Comm: udevd Not tainted 5.17.0-rc7-syzkaller-00241-gf0e18b03fcaf #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2143
 check_prev_add kernel/locking/lockdep.c:3063 [inline]
 check_prevs_add kernel/locking/lockdep.c:3186 [inline]
 validate_chain kernel/locking/lockdep.c:3801 [inline]
 __lock_acquire+0x2ad4/0x56c0 kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5639 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
 flush_workqueue+0x110/0x13a0 kernel/workqueue.c:2827
 drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2992
 destroy_workqueue+0x71/0x800 kernel/workqueue.c:4429
 __loop_clr_fd+0x1ab/0xe20 drivers/block/loop.c:1124
 lo_release+0x1ac/0x1f0 drivers/block/loop.c:1756
 blkdev_put_whole block/bdev.c:689 [inline]
 blkdev_put+0x2de/0x950 block/bdev.c:944
 blkdev_close+0x6a/0x80 block/fops.c:517
 __fput+0x286/0x9f0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0ca7b90fc3
Code: 48 ff ff ff b8 ff ff ff ff e9 3e ff ff ff 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
RSP: 002b:00007ffcf6cd76d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f0ca7a396a8 RCX: 00007f0ca7b90fc3
RDX: 000000000000001c RSI: 00007ffcf6cd6ed8 RDI: 0000000000000008
RBP: 0000564a5512feb0 R08: 0000000000000007 R09: 0000564a55126a00
R10: 0000000002423870 R11: 0000000000000246 R12: 0000000000000002
R13: 0000564a55116f80 R14: 0000000000000008 R15: 0000564a550e82c0
 </TASK>
I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
Buffer I/O error on dev loop0, logical block 0, async page read

