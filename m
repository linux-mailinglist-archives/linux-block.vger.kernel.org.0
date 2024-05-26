Return-Path: <linux-block+bounces-7751-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFC78CF3CE
	for <lists+linux-block@lfdr.de>; Sun, 26 May 2024 11:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7F61C2123F
	for <lists+linux-block@lfdr.de>; Sun, 26 May 2024 09:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4879131BDA;
	Sun, 26 May 2024 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf6YDH/J"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE8131BCE;
	Sun, 26 May 2024 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716631; cv=none; b=iWh62DIqyqjvHVss/Dm7LmXnld+zfGMyDfnQJNRhevVFSlJwq+pOGyp0OUxH39/ihWhtvXNuDSaqs2q9BuDxkDHMl57xRIZmnDR0SS1lBi3C93dUKDwwsxBmcVQg5rrjerJT5UGz7gxEpICj+yO8EwWX4aXFCzOHujxD/ATjRrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716631; c=relaxed/simple;
	bh=4Hx/U7MiYIQ+eFnMWjsQEcNrONO+JzOpAm5p7GNLqT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WX6YeutLHKmfp2/p2dzu7EDgROUSy/9aI5r1PZ9CUr8fbbLemVjOFmHXL+1vGJh+z0WK1qdomwIIoQ3AJEuJKKQ8/PbroAkZtH3AhobLNBNGvMn/+UkgvWDFOriPSCyN9Lkj6ZHJlp+77C6BDq2IRtteJ4m4ySLJKq+HqLU0NrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mf6YDH/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3C7C32781;
	Sun, 26 May 2024 09:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716631;
	bh=4Hx/U7MiYIQ+eFnMWjsQEcNrONO+JzOpAm5p7GNLqT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mf6YDH/Jbluhd0jBFucAIme0m1vfYoz0kKMb5sfpqkuAiIXFc+HpeUcPoUl/90TM7
	 eK+7/j669KyrqpeVqGijG5KnWJuf77Y3hUQHRngk/MD6GD8A9n5vRVWtLkaljVqz71
	 16C2vP5tug+T00j2W9lty8/GjhZXNFjD4FCfziwpHbBgkc+/1N1jHiqEpRw9tR4MVo
	 gAov8BUF/3YU0w7K8kHxS9zxh+HpWvPFe6J/cnpxeHFik4nFhhjcHyJXVAZxvrwTHw
	 Y61MzYE2op7Vo76UcRIE7VEtPnECqQ/xM18TuppFql6khPQzzsgBbvRmsxPq0gH4sa
	 ugymWNZFRsPZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Justin Stitt <justinstitt@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	linux-block@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 5/5] block/ioctl: prefer different overflow check
Date: Sun, 26 May 2024 05:43:41 -0400
Message-ID: <20240526094342.3413841-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094342.3413841-1-sashal@kernel.org>
References: <20240526094342.3413841-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.217
Content-Transfer-Encoding: 8bit

From: Justin Stitt <justinstitt@google.com>

[ Upstream commit ccb326b5f9e623eb7f130fbbf2505ec0e2dcaff9 ]

Running syzkaller with the newly reintroduced signed integer overflow
sanitizer shows this report:

[   62.982337] ------------[ cut here ]------------
[   62.985692] cgroup: Invalid name
[   62.986211] UBSAN: signed-integer-overflow in ../block/ioctl.c:36:46
[   62.989370] 9pnet_fd: p9_fd_create_tcp (7343): problem connecting socket to 127.0.0.1
[   62.992992] 9223372036854775807 + 4095 cannot be represented in type 'long long'
[   62.997827] 9pnet_fd: p9_fd_create_tcp (7345): problem connecting socket to 127.0.0.1
[   62.999369] random: crng reseeded on system resumption
[   63.000634] GUP no longer grows the stack in syz-executor.2 (7353): 20002000-20003000 (20001000)
[   63.000668] CPU: 0 PID: 7353 Comm: syz-executor.2 Not tainted 6.8.0-rc2-00035-gb3ef86b5a957 #1
[   63.000677] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   63.000682] Call Trace:
[   63.000686]  <TASK>
[   63.000731]  dump_stack_lvl+0x93/0xd0
[   63.000919]  __get_user_pages+0x903/0xd30
[   63.001030]  __gup_longterm_locked+0x153e/0x1ba0
[   63.001041]  ? _raw_read_unlock_irqrestore+0x17/0x50
[   63.001072]  ? try_get_folio+0x29c/0x2d0
[   63.001083]  internal_get_user_pages_fast+0x1119/0x1530
[   63.001109]  iov_iter_extract_pages+0x23b/0x580
[   63.001206]  bio_iov_iter_get_pages+0x4de/0x1220
[   63.001235]  iomap_dio_bio_iter+0x9b6/0x1410
[   63.001297]  __iomap_dio_rw+0xab4/0x1810
[   63.001316]  iomap_dio_rw+0x45/0xa0
[   63.001328]  ext4_file_write_iter+0xdde/0x1390
[   63.001372]  vfs_write+0x599/0xbd0
[   63.001394]  ksys_write+0xc8/0x190
[   63.001403]  do_syscall_64+0xd4/0x1b0
[   63.001421]  ? arch_exit_to_user_mode_prepare+0x3a/0x60
[   63.001479]  entry_SYSCALL_64_after_hwframe+0x6f/0x77
[   63.001535] RIP: 0033:0x7f7fd3ebf539
[   63.001551] Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
[   63.001562] RSP: 002b:00007f7fd32570c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   63.001584] RAX: ffffffffffffffda RBX: 00007f7fd3ff3f80 RCX: 00007f7fd3ebf539
[   63.001590] RDX: 4db6d1e4f7e43360 RSI: 0000000020000000 RDI: 0000000000000004
[   63.001595] RBP: 00007f7fd3f1e496 R08: 0000000000000000 R09: 0000000000000000
[   63.001599] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   63.001604] R13: 0000000000000006 R14: 00007f7fd3ff3f80 R15: 00007ffd415ad2b8
...
[   63.018142] ---[ end trace ]---

Historically, the signed integer overflow sanitizer did not work in the
kernel due to its interaction with `-fwrapv` but this has since been
changed [1] in the newest version of Clang; It was re-enabled in the
kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
sanitizer").

Let's rework this overflow checking logic to not actually perform an
overflow during the check itself, thus avoiding the UBSAN splat.

[1]: https://github.com/llvm/llvm-project/pull/82432

Signed-off-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20240507-b4-sio-block-ioctl-v3-1-ba0c2b32275e@google.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index bc97698e0e8a3..11e692741f17c 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -32,7 +32,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	if (op == BLKPG_DEL_PARTITION)
 		return bdev_del_partition(bdev, p.pno);
 
-	if (p.start < 0 || p.length <= 0 || p.start + p.length < 0)
+	if (p.start < 0 || p.length <= 0 || LLONG_MAX - p.length < p.start)
 		return -EINVAL;
 	/* Check that the partition is aligned to the block size */
 	if (!IS_ALIGNED(p.start | p.length, bdev_logical_block_size(bdev)))
-- 
2.43.0


