Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DFF5FCF50
	for <lists+linux-block@lfdr.de>; Thu, 13 Oct 2022 02:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJMAQ4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Oct 2022 20:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJMAQp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 20:16:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD40015048D;
        Wed, 12 Oct 2022 17:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBCB6616B3;
        Thu, 13 Oct 2022 00:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3528CC433C1;
        Thu, 13 Oct 2022 00:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665620181;
        bh=fvegeJIp2wdais0tigzcD56CJARkRkzBSW+xsY1dQP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EB2pXyAy4npPNYzi7Dq746MZ9nMJDBjUX0b1QWV1sX0x8N16IableQde9vCiuaoTz
         L2a1s6Fkq4KdR6JnkFynh4sOZLunDtJjvgGjba9/Eml11KGuu25qcU5y5sU+cqa2wc
         bfcLCW5z4VrgCfcEtzqWXD17lxp+BvaNx6bEbsq+2MBKLuzX3lriyqI3YnJTG/gRQM
         iPPkg34+3C0FJZUSvgWVprPJS65rzkrgLaGkYfo6u7LmUNhsZv/3VhgIpdOv0NxN6l
         90g+NnB5FEN8BQ0WPcgG0bCZ3EONDHAYb1QUPpqBFVODWDJcnJv8qIl2EWSrVA3j0H
         WddU74wIm6Sew==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+38e6c55d4969a14c1534@syzkaller.appspotmail.com,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 6.0 12/67] nbd: Fix hung when signal interrupts nbd_start_device_ioctl()
Date:   Wed, 12 Oct 2022 20:14:53 -0400
Message-Id: <20221013001554.1892206-12-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013001554.1892206-1-sashal@kernel.org>
References: <20221013001554.1892206-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit 1de7c3cf48fc41cd95adb12bd1ea9033a917798a ]

syzbot reported hung task [1].  The following program is a simplified
version of the reproducer:

int main(void)
{
	int sv[2], fd;

	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv) < 0)
		return 1;
	if ((fd = open("/dev/nbd0", 0)) < 0)
		return 1;
	if (ioctl(fd, NBD_SET_SIZE_BLOCKS, 0x81) < 0)
		return 1;
	if (ioctl(fd, NBD_SET_SOCK, sv[0]) < 0)
		return 1;
	if (ioctl(fd, NBD_DO_IT) < 0)
		return 1;
	return 0;
}

When signal interrupt nbd_start_device_ioctl() waiting the condition
atomic_read(&config->recv_threads) == 0, the task can hung because it
waits the completion of the inflight IOs.

This patch fixes the issue by clearing queue, not just shutdown, when
signal interrupt nbd_start_device_ioctl().

Link: https://syzkaller.appspot.com/bug?id=7d89a3ffacd2b83fdd39549bc4d8e0a89ef21239 [1]
Reported-by: syzbot+38e6c55d4969a14c1534@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/r/20220907163502.577561-1-syoshida@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 2a709daefbc4..2a2a1d996a57 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1413,10 +1413,12 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd)
 	mutex_unlock(&nbd->config_lock);
 	ret = wait_event_interruptible(config->recv_wq,
 					 atomic_read(&config->recv_threads) == 0);
-	if (ret)
+	if (ret) {
 		sock_shutdown(nbd);
-	flush_workqueue(nbd->recv_workq);
+		nbd_clear_que(nbd);
+	}
 
+	flush_workqueue(nbd->recv_workq);
 	mutex_lock(&nbd->config_lock);
 	nbd_bdev_reset(nbd);
 	/* user requested, ignore socket errors */
-- 
2.35.1

