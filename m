Return-Path: <linux-block+bounces-16261-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0363DA0A82E
	for <lists+linux-block@lfdr.de>; Sun, 12 Jan 2025 11:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64DD1887896
	for <lists+linux-block@lfdr.de>; Sun, 12 Jan 2025 10:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6B1185935;
	Sun, 12 Jan 2025 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="tOyJ8thl"
X-Original-To: linux-block@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2D64315A;
	Sun, 12 Jan 2025 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736676854; cv=none; b=puhN5sG722c+lRCe8QvRzjK/GrXbL+88OCdeJDfdUGiINwaIoHKopPSFeHBXn5ULzBg89zSi3lazpAMf8XHPmW4K7gFez2KM+sxw/7RlcqzrX/ZWM2nx6GYru922sxOIKOmWr7V/JheA1pZmi3wioikx8vV0Ww1U7trk5mCgqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736676854; c=relaxed/simple;
	bh=DThcMsiKpCiUffIIchuQLXGpk8elXBupZu0kyS9l9aE=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=f7e9kKkS8hKAghUmFEgaZV3k08QkWHS/gcWsQz4iQp3SYB5FvcoC7Zf7IbYPXfL/FZwGn3SHmBh0wvUhJ4tNpheDbgzZc4wmLdCy55U2cEcTellLQZyTK53hggsrqC0I4D7OixbPsZaPFImTq2Sv2tzpOSb7nT658NZzHGtIRZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=tOyJ8thl; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736676707;
	bh=b0HuQVLXBLFTK8eWeQ/w8MXUCWf1jSP/G+y0W5MfDfg=;
	h=From:Mime-Version:Subject:Message-Id:Date:To;
	b=tOyJ8thlKQpOmDTv8yX5RNT2I7qNAJSRm6ugOxPxu+wfD3ToWsO6yTvNlyOqpWkdP
	 fST9e2bJe9GYiictc70iLZCxojL9oeoc2Dj53LTyv+GK8SsXvLCKWGbHtc5q2exkSn
	 6NDzb4Kmc9Sbdqg5zj95xI0tUOt9WMoj7Aus3fdc=
X-QQ-mid: bizesmtpip3t1736676705tjeiddr
X-QQ-Originating-IP: VwRLs/PRoPO+NvNjfvNMhogo2M6k12FkNowjNkaD4Hc=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 12 Jan 2025 18:11:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16102354572167166007
From: Kun Hu <huk23@m.fudan.edu.cn>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Bug: possible deadlock in jfs_fsync
Message-Id: <359BC288-B0B1-4815-9F01-3A349B12E816@m.fudan.edu.cn>
Date: Sun, 12 Jan 2025 18:11:33 +0800
Cc: "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net
To: viro@zeniv.linux.org.uk,
 hch@lst.de,
 ming.lei@redhat.com,
 jack@suse.cz,
 josef@redhat.com
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MzMRvi13BjTi8MMAuZ8iW5Cdx2XGnabilgSK4Pv+VTBd8rbjalipzLMq
	iQBj7MQz51mBASatsLyHOFekvgIDPUoEXkhJgaT4FgW4uzNCbaduYjfyrk/MEuJU9QrrVnK
	MA10XcMVWrl3e7OWvNKRGlb5q5BoogXQ2hhm99Y7g0HxkPrAH4QN+WMYeVWAeYGhBXvrbPg
	pvs0gLuCGWshzV1ANuz0hAd9YVUSFW23mnlgSClP93K44s1ixuc1d4gm02JABi6CWRD5ciB
	tx5RPRPlX1hntVC891IwpmGQGY5zpnQKLIGskW09r4VB62+9otRW+1W25T7dr/A6BascJ3/
	Qur3nZKqMhnxvN3H+pHK+rR8LOHQhCArTain4o2acratDLCdaRlrITqYJ8aEiZXQVuVylkB
	i8pDh3+Uc/A8nDXd9TDaOMuqOl67dXEQBIfk0k+TWo/AiV3H8mugpfQoNVjPNniOKCOrW7e
	awgxiLek07fyymeGS97q8LxLu2oLVL3O2Nz1CPn/YZn5SjB2z8dzH8mKV/3vJs/MhkkXx/3
	Jue0z3Z/V6Heph7n1lmR2Y3P5jeyudSLVE9B0tl+PqZ4vwh1e+ce5rzMLpuTRpYBwyqAdA6
	/yKQq2v1J6HMi/dkcZsbV2XHUxxfBLbigPylS+7fROFqo5HjHCZjeSjUuUf3I9HAPf9yYnX
	583fOY600b+gnFB/WQSogbnCJhc0K9SvuiKmFPk2xKkNXDRc3bQyQQwXIkDA/+Knl4whYeu
	yquwFESvpNMeGoYTHyuqCzpTf6nUi/IAiAYRXzY6DeMj3RUpNuaC4I28xuxWh5UymBpqow4
	h69/CS68/Myyn6IQkrxYK9ExpGixff4AQPeCkij/Iy3cQvZl32rULsEAL8nOgLH22ll7AC5
	E2WNLLfVFMK0zZ+870+tzwifpOZfBQl7pUKl7xRiWQxmRaXxCctJmT6yXh5k8WoYU/Tr7F2
	7EZLxLP2NbIv2/QaaMPNheeVvJBto4WVHziaoLy7d4B5GhngNKAdc7IhRurXrnecmoQ0=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Hello,

When using our customized fuzzer tool to fuzz the latest Linux kernel, =
the following crash (44s)
was triggered.

HEAD commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
git tree: upstream
Console output: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/44-possible%20=
deadlock%20in%20jfs_fsync/log0
Kernel config: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/config.txt
C reproducer: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/44-possible%20=
deadlock%20in%20jfs_fsync/13generated_program.c
Syzlang reproducer: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/44-possible%20=
deadlock%20in%20jfs_fsync/13_repro.txt

We first found the issue without a stable C and Syzlang reproducers, but =
later I tried multiple rounds of replication and got the C and Syzlang =
reproducers.

I suspect the issue may stem from potential circular locking or resource =
contention, as indicated by interactions between loop_change_fd, =
blk_mq_freeze_queue, and JFS-specific functions like jfs_fsync and =
jfs_setattr. The circular locking dependency, involving locks such as =
&sb->s_type->i_mutex_key#36, &(log)->loglock, and =
&q->q_usage_counter(io)#5, suggests possible challenges in =
synchronization or dependency management. Could you kindly help review =
these areas to narrow down the root cause? Your expertise would be =
greatly appreciated.

Could you kindly help review these areas to narrow down the root cause? =
Your expertise would be greatly appreciated.

If you fix this issue, please add the following tag to the commit:
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin =
<jjtan24@m.fudan.edu.cn>

loop1: detected capacity change from 0 to 32768
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
6.13.0-rc6 #1 Tainted: G        W        =20
------------------------------------------------------
syz.1.415/3703 is trying to acquire lock:
ff11000020ac8578 (&sb->s_type->i_mutex_key#36){+.+.}-{4:4}, at: =
inode_lock include/linux/fs.h:818 [inline]
ff11000020ac8578 (&sb->s_type->i_mutex_key#36){+.+.}-{4:4}, at: =
jfs_fsync+0xaa/0x220 fs/jfs/file.c:28

but task is already holding lock:
ff11000008551db8 (&q->q_usage_counter(io)#5){++++}-{0:0}, at: =
blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:213

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&q->q_usage_counter(io)#5){++++}-{0:0}:
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x18eb/0x1fe0 block/blk-mq.c:3090
       __submit_bio+0x1ac/0xed0 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck block/blk-core.c:739 [inline]
       submit_bio_noacct_nocheck+0x67e/0xd40 block/blk-core.c:716
       submit_bio_noacct+0x649/0x13a0 block/blk-core.c:868
       metapage_write_folio+0x6ea/0xa50 fs/jfs/jfs_metapage.c:440
       write_cache_pages+0xa6/0x120 mm/page-writeback.c:2659
       metapage_writepages+0x8f/0xe0 fs/jfs/jfs_metapage.c:474
       do_writepages+0x19d/0x7d0 mm/page-writeback.c:2702
       filemap_fdatawrite_wbc+0xe9/0x120 mm/filemap.c:388
       __filemap_fdatawrite_range+0xc1/0x110 mm/filemap.c:421
       write_special_inodes+0x84/0x170 fs/jfs/jfs_logmgr.c:207
       lmLogSync+0x46b/0x840 fs/jfs/jfs_logmgr.c:937
       jfs_syncpt+0x8d/0xa0 fs/jfs/jfs_logmgr.c:1041
       jfs_sync_fs+0x84/0xb0 fs/jfs/super.c:650
       sync_filesystem fs/sync.c:66 [inline]
       sync_filesystem+0x1d5/0x2a0 fs/sync.c:30
       generic_shutdown_super+0x74/0x380 fs/super.c:621
       kill_block_super+0x3b/0x90 fs/super.c:1710
       deactivate_locked_super+0xbb/0x130 fs/super.c:473
       deactivate_super fs/super.c:506 [inline]
       deactivate_super+0xb1/0xd0 fs/super.c:502
       cleanup_mnt+0x378/0x510 fs/namespace.c:1373
       task_work_run+0x173/0x280 kernel/task_work.c:239
       resume_user_mode_work include/linux/resume_user_mode.h:50 =
[inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 =
[inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 =
[inline]
       syscall_exit_to_user_mode+0x261/0x270 kernel/entry/common.c:218
       do_syscall_64+0xd0/0x1d0 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&(log)->loglock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x16f/0x1eb0 kernel/locking/mutex.c:735
       lmLog+0x86/0xb90 fs/jfs/jfs_logmgr.c:236
       diLog fs/jfs/jfs_txnmgr.c:1452 [inline]
       txLog fs/jfs/jfs_txnmgr.c:1404 [inline]
       txCommit+0xdba/0x4720 fs/jfs/jfs_txnmgr.c:1264
       jfs_commit_inode+0x453/0x570 fs/jfs/inode.c:108
       jfs_write_inode+0x104/0x240 fs/jfs/inode.c:132
       write_inode fs/fs-writeback.c:1525 [inline]
       __writeback_single_inode+0xb09/0x1010 fs/fs-writeback.c:1745
       writeback_sb_inodes+0x5ee/0xf00 fs/fs-writeback.c:1976
       wb_writeback+0x1a9/0xb50 fs/fs-writeback.c:2156
       wb_do_writeback fs/fs-writeback.c:2303 [inline]
       wb_workfn+0x134/0xe10 fs/fs-writeback.c:2343
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0x5ee/0x1ba0 kernel/workqueue.c:3310
       worker_thread+0x59f/0xcf0 kernel/workqueue.c:3391
       kthread+0x345/0x450 kernel/kthread.c:389
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #2 (&jfs_ip->commit_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x16f/0x1eb0 kernel/locking/mutex.c:735
       jfs_truncate_nolock+0x1cf/0x300 fs/jfs/inode.c:386
       jfs_truncate+0xe9/0x170 fs/jfs/inode.c:412
       jfs_setattr+0x2cf/0x770 fs/jfs/file.c:119
       notify_change+0x677/0x1240 fs/attr.c:552
       do_truncate+0x143/0x200 fs/open.c:65
       handle_truncate fs/namei.c:3449 [inline]
       do_open fs/namei.c:3832 [inline]
       path_openat+0x22d6/0x2970 fs/namei.c:3987
       do_filp_open+0x1fa/0x2f0 fs/namei.c:4014
       do_sys_openat2+0x641/0x6e0 fs/open.c:1402
       do_sys_open+0xc7/0x150 fs/open.c:1417
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&jfs_ip->rdwrlock#3){++++}-{4:4}:
       down_write_nested+0x96/0x210 kernel/locking/rwsem.c:1693
       jfs_truncate+0xc6/0x170 fs/jfs/inode.c:411
       jfs_setattr+0x2cf/0x770 fs/jfs/file.c:119
       notify_change+0x677/0x1240 fs/attr.c:552
       do_truncate+0x143/0x200 fs/open.c:65
       handle_truncate fs/namei.c:3449 [inline]
       do_open fs/namei.c:3832 [inline]
       path_openat+0x22d6/0x2970 fs/namei.c:3987
       do_filp_open+0x1fa/0x2f0 fs/namei.c:4014
       do_sys_openat2+0x641/0x6e0 fs/open.c:1402
       do_sys_open+0xc7/0x150 fs/open.c:1417
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sb->s_type->i_mutex_key#36){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x29fe/0x4a10 kernel/locking/lockdep.c:5226
       lock_acquire kernel/locking/lockdep.c:5849 [inline]
       lock_acquire+0x1b1/0x580 kernel/locking/lockdep.c:5814
       down_write+0x92/0x200 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:818 [inline]
       jfs_fsync+0xaa/0x220 fs/jfs/file.c:28
       vfs_fsync_range+0x13d/0x230 fs/sync.c:187
       __loop_update_dio+0x18f/0x5d0 drivers/block/loop.c:204
       loop_update_dio drivers/block/loop.c:525 [inline]
       loop_change_fd drivers/block/loop.c:629 [inline]
       lo_ioctl+0x131d/0x1760 drivers/block/loop.c:1535
       blkdev_ioctl+0x27e/0x6d0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x19e/0x210 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &sb->s_type->i_mutex_key#36 --> &(log)->loglock --> =
&q->q_usage_counter(io)#5

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#5);
                               lock(&(log)->loglock);
                               lock(&q->q_usage_counter(io)#5);
  lock(&sb->s_type->i_mutex_key#36);

 *** DEADLOCK ***

3 locks held by syz.1.415/3703:
 #0: ff110000085fb360 (&lo->lo_mutex){+.+.}-{4:4}, at: =
loop_global_lock_killable+0x88/0xc0 drivers/block/loop.c:120
 #1: ff11000008551db8 (&q->q_usage_counter(io)#5){++++}-{0:0}, at: =
blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:213
 #2: ff11000008551df0 (&q->q_usage_counter(queue)#7){+.+.}-{0:0}, at: =
blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:213

stack backtrace:
CPU: 2 UID: 0 PID: 3703 Comm: syz.1.415 Tainted: G        W          =
6.13.0-rc6 #1
Tainted: [W]=3DWARN
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
 print_circular_bug.isra.0+0x5b5/0x9c0 kernel/locking/lockdep.c:2074
 check_noncircular+0x2f3/0x3d0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x29fe/0x4a10 kernel/locking/lockdep.c:5226
 lock_acquire kernel/locking/lockdep.c:5849 [inline]
 lock_acquire+0x1b1/0x580 kernel/locking/lockdep.c:5814
 down_write+0x92/0x200 kernel/locking/rwsem.c:1577
 inode_lock include/linux/fs.h:818 [inline]
 jfs_fsync+0xaa/0x220 fs/jfs/file.c:28
 vfs_fsync_range+0x13d/0x230 fs/sync.c:187
 __loop_update_dio+0x18f/0x5d0 drivers/block/loop.c:204
 loop_update_dio drivers/block/loop.c:525 [inline]
 loop_change_fd drivers/block/loop.c:629 [inline]
 lo_ioctl+0x131d/0x1760 drivers/block/loop.c:1535
 blkdev_ioctl+0x27e/0x6d0 block/ioctl.c:693
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x19e/0x210 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f79c2ea971d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 =
f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f79c1afcba8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f79c306bf80 RCX: 00007f79c2ea971d
RDX: 0000000000000004 RSI: 0000000000004c06 RDI: 0000000000000006
RBP: 00007f79c2f1e425 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f79c306bf8c R14: 00007f79c306c018 R15: 00007f79c1afcd40
 </TASK>

---------------
thanks,
Kun Hu=

