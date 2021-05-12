Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF5E37EBC6
	for <lists+linux-block@lfdr.de>; Thu, 13 May 2021 00:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245247AbhELTg1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 May 2021 15:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241960AbhELSJW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 14:09:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D7E361937;
        Wed, 12 May 2021 18:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620842717;
        bh=KGs+GX423EQ6SlbzftWO1JHtCfbjHlhj22zK/PinHBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TR9cLGfmA6hnnBVRxthlWwz5z/lHWj0V5K0X+VThbRy6RShP0g1W0ox2965cnwggO
         RxnDw9bTGrDm7oPR76zKIgSNi2rpR1pDUKTOW78Waz3cdyTYLZkvl16qsdNqCwLoQt
         UTdf2uhXbfXaOI4O2m1dHX9/+hxhQ5SyrmB9/ow1v9kt+M/BAN+IKXEwnj+Konu7jK
         KMPnYnhiav8fU3/Yk7ncpom1+2KTaVvXnHmyG/TMXyOj9wYx/1EjhnmOeTEBxFucj7
         v0d3Zy0E6HAowWHHE30Q3Vd5EZhuyHTt9yMA+rH2zf1oi47sXJJEIqHcsOONcYGkwl
         BX0AorRKKXd5w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yangerkun <yangerkun@huawei.com>,
        Pavel Begunkov <asml.silencec@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 16/18] block: reexpand iov_iter after read/write
Date:   Wed, 12 May 2021 14:04:47 -0400
Message-Id: <20210512180450.665586-16-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512180450.665586-1-sashal@kernel.org>
References: <20210512180450.665586-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: yangerkun <yangerkun@huawei.com>

[ Upstream commit cf7b39a0cbf6bf57aa07a008d46cf695add05b4c ]

We get a bug:

BUG: KASAN: slab-out-of-bounds in iov_iter_revert+0x11c/0x404
lib/iov_iter.c:1139
Read of size 8 at addr ffff0000d3fb11f8 by task

CPU: 0 PID: 12582 Comm: syz-executor.2 Not tainted
5.10.0-00843-g352c8610ccd2 #2
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x2d0 arch/arm64/kernel/stacktrace.c:132
 show_stack+0x28/0x34 arch/arm64/kernel/stacktrace.c:196
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x110/0x164 lib/dump_stack.c:118
 print_address_description+0x78/0x5c8 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report+0x148/0x1e4 mm/kasan/report.c:562
 check_memory_region_inline mm/kasan/generic.c:183 [inline]
 __asan_load8+0xb4/0xbc mm/kasan/generic.c:252
 iov_iter_revert+0x11c/0x404 lib/iov_iter.c:1139
 io_read fs/io_uring.c:3421 [inline]
 io_issue_sqe+0x2344/0x2d64 fs/io_uring.c:5943
 __io_queue_sqe+0x19c/0x520 fs/io_uring.c:6260
 io_queue_sqe+0x2a4/0x590 fs/io_uring.c:6326
 io_submit_sqe fs/io_uring.c:6395 [inline]
 io_submit_sqes+0x4c0/0xa04 fs/io_uring.c:6624
 __do_sys_io_uring_enter fs/io_uring.c:9013 [inline]
 __se_sys_io_uring_enter fs/io_uring.c:8960 [inline]
 __arm64_sys_io_uring_enter+0x190/0x708 fs/io_uring.c:8960
 __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
 el0_svc_common arch/arm64/kernel/syscall.c:158 [inline]
 do_el0_svc+0x120/0x290 arch/arm64/kernel/syscall.c:227
 el0_svc+0x1c/0x28 arch/arm64/kernel/entry-common.c:367
 el0_sync_handler+0x98/0x170 arch/arm64/kernel/entry-common.c:383
 el0_sync+0x140/0x180 arch/arm64/kernel/entry.S:670

Allocated by task 12570:
 stack_trace_save+0x80/0xb8 kernel/stacktrace.c:121
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0xdc/0x120 mm/kasan/common.c:461
 kasan_kmalloc+0xc/0x14 mm/kasan/common.c:475
 __kmalloc+0x23c/0x334 mm/slub.c:3970
 kmalloc include/linux/slab.h:557 [inline]
 __io_alloc_async_data+0x68/0x9c fs/io_uring.c:3210
 io_setup_async_rw fs/io_uring.c:3229 [inline]
 io_read fs/io_uring.c:3436 [inline]
 io_issue_sqe+0x2954/0x2d64 fs/io_uring.c:5943
 __io_queue_sqe+0x19c/0x520 fs/io_uring.c:6260
 io_queue_sqe+0x2a4/0x590 fs/io_uring.c:6326
 io_submit_sqe fs/io_uring.c:6395 [inline]
 io_submit_sqes+0x4c0/0xa04 fs/io_uring.c:6624
 __do_sys_io_uring_enter fs/io_uring.c:9013 [inline]
 __se_sys_io_uring_enter fs/io_uring.c:8960 [inline]
 __arm64_sys_io_uring_enter+0x190/0x708 fs/io_uring.c:8960
 __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
 el0_svc_common arch/arm64/kernel/syscall.c:158 [inline]
 do_el0_svc+0x120/0x290 arch/arm64/kernel/syscall.c:227
 el0_svc+0x1c/0x28 arch/arm64/kernel/entry-common.c:367
 el0_sync_handler+0x98/0x170 arch/arm64/kernel/entry-common.c:383
 el0_sync+0x140/0x180 arch/arm64/kernel/entry.S:670

Freed by task 12570:
 stack_trace_save+0x80/0xb8 kernel/stacktrace.c:121
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track+0x38/0x6c mm/kasan/common.c:56
 kasan_set_free_info+0x20/0x40 mm/kasan/generic.c:355
 __kasan_slab_free+0x124/0x150 mm/kasan/common.c:422
 kasan_slab_free+0x10/0x1c mm/kasan/common.c:431
 slab_free_hook mm/slub.c:1544 [inline]
 slab_free_freelist_hook mm/slub.c:1577 [inline]
 slab_free mm/slub.c:3142 [inline]
 kfree+0x104/0x38c mm/slub.c:4124
 io_dismantle_req fs/io_uring.c:1855 [inline]
 __io_free_req+0x70/0x254 fs/io_uring.c:1867
 io_put_req_find_next fs/io_uring.c:2173 [inline]
 __io_queue_sqe+0x1fc/0x520 fs/io_uring.c:6279
 __io_req_task_submit+0x154/0x21c fs/io_uring.c:2051
 io_req_task_submit+0x2c/0x44 fs/io_uring.c:2063
 task_work_run+0xdc/0x128 kernel/task_work.c:151
 get_signal+0x6f8/0x980 kernel/signal.c:2562
 do_signal+0x108/0x3a4 arch/arm64/kernel/signal.c:658
 do_notify_resume+0xbc/0x25c arch/arm64/kernel/signal.c:722
 work_pending+0xc/0x180

blkdev_read_iter can truncate iov_iter's count since the count + pos may
exceed the size of the blkdev. This will confuse io_read that we have
consume the iovec. And once we do the iov_iter_revert in io_read, we
will trigger the slab-out-of-bounds. Fix it by reexpand the count with
size has been truncated.

blkdev_write_iter can trigger the problem too.

Signed-off-by: yangerkun <yangerkun@huawei.com>
Acked-by: Pavel Begunkov <asml.silencec@gmail.com>
Link: https://lore.kernel.org/r/20210401071807.3328235-1-yangerkun@huawei.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/block_dev.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9f3faac49025..b34f76af59c4 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1919,6 +1919,7 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *bd_inode = bdev_file_inode(file);
 	loff_t size = i_size_read(bd_inode);
 	struct blk_plug plug;
+	size_t shorted = 0;
 	ssize_t ret;
 
 	if (bdev_read_only(I_BDEV(bd_inode)))
@@ -1933,12 +1934,17 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
-	iov_iter_truncate(from, size - iocb->ki_pos);
+	size -= iocb->ki_pos;
+	if (iov_iter_count(from) > size) {
+		shorted = iov_iter_count(from) - size;
+		iov_iter_truncate(from, size);
+	}
 
 	blk_start_plug(&plug);
 	ret = __generic_file_write_iter(iocb, from);
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
+	iov_iter_reexpand(from, iov_iter_count(from) + shorted);
 	blk_finish_plug(&plug);
 	return ret;
 }
@@ -1950,13 +1956,21 @@ ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct inode *bd_inode = bdev_file_inode(file);
 	loff_t size = i_size_read(bd_inode);
 	loff_t pos = iocb->ki_pos;
+	size_t shorted = 0;
+	ssize_t ret;
 
 	if (pos >= size)
 		return 0;
 
 	size -= pos;
-	iov_iter_truncate(to, size);
-	return generic_file_read_iter(iocb, to);
+	if (iov_iter_count(to) > size) {
+		shorted = iov_iter_count(to) - size;
+		iov_iter_truncate(to, size);
+	}
+
+	ret = generic_file_read_iter(iocb, to);
+	iov_iter_reexpand(to, iov_iter_count(to) + shorted);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(blkdev_read_iter);
 
-- 
2.30.2

