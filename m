Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50F981B05
	for <lists+linux-block@lfdr.de>; Mon,  5 Aug 2019 15:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbfHENLN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 5 Aug 2019 09:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730483AbfHENLN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Aug 2019 09:11:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 786072075B;
        Mon,  5 Aug 2019 13:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010672;
        bh=KnrFv3vDarcaPhQcdemoJlumUpCpVGh+3zak/sjMUo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qnMKDvt899UrATZEZrj2gSAA9lvefcI72rCMvr7D+iC9T4jpgfF6jvYfYtICyMfXy
         0HIcTYd1KcZQHYnRcz0abP/VSdf1rE7w5XpY5fB7gQBn9mCDPuVN7z4bEk6nvTQL0Q
         Q/n3ORhCL9nCFzHGbMlYWiAEQg1MCvRJJaqDUhqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-block@vger.kernel.org,
        Ratna Manoj Bolla <manoj.br@gmail.com>, nbd@other.debian.org,
        David Woodhouse <dwmw@amazon.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Munehisa Kamata <kamatam@amazon.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 60/74] nbd: replace kill_bdev() with __invalidate_device() again
Date:   Mon,  5 Aug 2019 15:03:13 +0200
Message-Id: <20190805124940.695248947@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124935.819068648@linuxfoundation.org>
References: <20190805124935.819068648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Munehisa Kamata <kamatam@amazon.com>

commit 2b5c8f0063e4b263cf2de82029798183cf85c320 upstream.

Commit abbbdf12497d ("replace kill_bdev() with __invalidate_device()")
once did this, but 29eaadc03649 ("nbd: stop using the bdev everywhere")
resurrected kill_bdev() and it has been there since then. So buffer_head
mappings still get killed on a server disconnection, and we can still
hit the BUG_ON on a filesystem on the top of the nbd device.

  EXT4-fs (nbd0): mounted filesystem with ordered data mode. Opts: (null)
  block nbd0: Receive control failed (result -32)
  block nbd0: shutting down sockets
  print_req_error: I/O error, dev nbd0, sector 66264 flags 3000
  EXT4-fs warning (device nbd0): htree_dirblock_to_tree:979: inode #2: lblock 0: comm ls: error -5 reading directory block
  print_req_error: I/O error, dev nbd0, sector 2264 flags 3000
  EXT4-fs error (device nbd0): __ext4_get_inode_loc:4690: inode #2: block 283: comm ls: unable to read itable block
  EXT4-fs error (device nbd0) in ext4_reserve_inode_write:5894: IO failure
  ------------[ cut here ]------------
  kernel BUG at fs/buffer.c:3057!
  invalid opcode: 0000 [#1] SMP PTI
  CPU: 7 PID: 40045 Comm: jbd2/nbd0-8 Not tainted 5.1.0-rc3+ #4
  Hardware name: Amazon EC2 m5.12xlarge/, BIOS 1.0 10/16/2017
  RIP: 0010:submit_bh_wbc+0x18b/0x190
  ...
  Call Trace:
   jbd2_write_superblock+0xf1/0x230 [jbd2]
   ? account_entity_enqueue+0xc5/0xf0
   jbd2_journal_update_sb_log_tail+0x94/0xe0 [jbd2]
   jbd2_journal_commit_transaction+0x12f/0x1d20 [jbd2]
   ? __switch_to_asm+0x40/0x70
   ...
   ? lock_timer_base+0x67/0x80
   kjournald2+0x121/0x360 [jbd2]
   ? remove_wait_queue+0x60/0x60
   kthread+0xf8/0x130
   ? commit_timeout+0x10/0x10 [jbd2]
   ? kthread_bind+0x10/0x10
   ret_from_fork+0x35/0x40

With __invalidate_device(), I no longer hit the BUG_ON with sync or
unmount on the disconnected device.

Fixes: 29eaadc03649 ("nbd: stop using the bdev everywhere")
Cc: linux-block@vger.kernel.org
Cc: Ratna Manoj Bolla <manoj.br@gmail.com>
Cc: nbd@other.debian.org
Cc: stable@vger.kernel.org
Cc: David Woodhouse <dwmw@amazon.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/nbd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1218,7 +1218,7 @@ static void nbd_clear_sock_ioctl(struct
 				 struct block_device *bdev)
 {
 	sock_shutdown(nbd);
-	kill_bdev(bdev);
+	__invalidate_device(bdev, true);
 	nbd_bdev_reset(bdev);
 	if (test_and_clear_bit(NBD_HAS_CONFIG_REF,
 			       &nbd->config->runtime_flags))


