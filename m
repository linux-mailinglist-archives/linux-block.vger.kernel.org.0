Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B1F24304A
	for <lists+linux-block@lfdr.de>; Wed, 12 Aug 2020 23:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgHLVB2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Aug 2020 17:01:28 -0400
Received: from ale.deltatee.com ([204.191.154.188]:38418 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgHLVB2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 17:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kGiEj/z+vdf+Ey+9R6ahin3vijWbPQNp/8asyFRpxHo=; b=UD0VLXTjuHTts8bUCzA8XKl0vD
        15m73oV6oKBtjBUKkziwo3hSYECesrbvwqPYp9djMlLGyslrSKAxU41EK1ODx8Ekc4p3mIhqLTs1Y
        YR8jzADiMdicWWk/tvdBdAnWJ3AJCx+jfyrg+qvXjnRH51kRl9PEUb8rKHYhGPNK7zGzYrbezcdDv
        PzOCj/b0gV5S2k2kFG7etvvYkBGFqSFKBg99x13NG5bO7WODqzzqITOLr55JGuWFH3p/UuhAClPX2
        +ZwllEa+NSgwbF5v+ZY8j2Oukezs+lKG6qB5cXBfJUkn9rrLRP4HsBe9q9ozcMW2HHKbmzX8PpH2R
        rmQkjdNQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1k5xsD-0003Wb-D4; Wed, 12 Aug 2020 15:01:26 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1k5xsB-0001s9-84; Wed, 12 Aug 2020 15:01:23 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 12 Aug 2020 15:01:19 -0600
Message-Id: <20200812210119.7155-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, keith.busch@wdc.com, axboe@kernel.dk, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [RESEND PATCH] nvme: Use spin_lock_irqsave() when taking the ctrl->lock
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When locking the ctrl->lock spinlock IRQs need to be disabled to avoid a
dead lock. The new spin_lock() calls recently added produce the
following lockdep warning when running the blktest nvme/003:

    ================================
    WARNING: inconsistent lock state
    --------------------------------
    inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
    ksoftirqd/2/22 [HC0[0]:SC1[1]:HE0:SE0] takes:
    ffff888276a8c4c0 (&ctrl->lock){+.?.}-{2:2}, at: nvme_keep_alive_end_io+0x50/0xc0
    {SOFTIRQ-ON-W} state was registered at:
      lock_acquire+0x164/0x500
      _raw_spin_lock+0x28/0x40
      nvme_get_effects_log+0x37/0x1c0
      nvme_init_identify+0x9e4/0x14f0
      nvme_reset_work+0xadd/0x2360
      process_one_work+0x66b/0xb70
      worker_thread+0x6e/0x6c0
      kthread+0x1e7/0x210
      ret_from_fork+0x22/0x30
    irq event stamp: 1449221
    hardirqs last  enabled at (1449220): [<ffffffff81c58e69>] ktime_get+0xf9/0x140
    hardirqs last disabled at (1449221): [<ffffffff83129665>] _raw_spin_lock_irqsave+0x25/0x60
    softirqs last  enabled at (1449210): [<ffffffff83400447>] __do_softirq+0x447/0x595
    softirqs last disabled at (1449215): [<ffffffff81b489b5>] run_ksoftirqd+0x35/0x50

    other info that might help us debug this:
     Possible unsafe locking scenario:

           CPU0
           ----
      lock(&ctrl->lock);
      <Interrupt>
        lock(&ctrl->lock);

     *** DEADLOCK ***

    no locks held by ksoftirqd/2/22.

    stack backtrace:
    CPU: 2 PID: 22 Comm: ksoftirqd/2 Not tainted 5.8.0-rc4-eid-vmlocalyes-dbg-00157-g7236657c6b3a #1450
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
    Call Trace:
     dump_stack+0xc8/0x11a
     print_usage_bug.cold.63+0x235/0x23e
     mark_lock+0xa9c/0xcf0
     __lock_acquire+0xd9a/0x2b50
     lock_acquire+0x164/0x500
     _raw_spin_lock_irqsave+0x40/0x60
     nvme_keep_alive_end_io+0x50/0xc0
     blk_mq_end_request+0x158/0x210
     nvme_complete_rq+0x146/0x500
     nvme_loop_complete_rq+0x26/0x30 [nvme_loop]
     blk_done_softirq+0x187/0x1e0
     __do_softirq+0x118/0x595
     run_ksoftirqd+0x35/0x50
     smpboot_thread_fn+0x1d3/0x310
     kthread+0x1e7/0x210
     ret_from_fork+0x22/0x30

Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported and Effects log pages")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 15abc00db3d3..312614467adb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2971,15 +2971,16 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 static struct nvme_cel *nvme_find_cel(struct nvme_ctrl *ctrl, u8 csi)
 {
 	struct nvme_cel *cel, *ret = NULL;
+	unsigned long flags;

-	spin_lock(&ctrl->lock);
+	spin_lock_irqsave(&ctrl->lock, flags);
 	list_for_each_entry(cel, &ctrl->cels, entry) {
 		if (cel->csi == csi) {
 			ret = cel;
 			break;
 		}
 	}
-	spin_unlock(&ctrl->lock);
+	spin_unlock_irqrestore(&ctrl->lock, flags);

 	return ret;
 }
@@ -2988,6 +2989,7 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 				struct nvme_effects_log **log)
 {
 	struct nvme_cel *cel = nvme_find_cel(ctrl, csi);
+	unsigned long flags;
 	int ret;

 	if (cel)
@@ -3006,9 +3008,9 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,

 	cel->csi = csi;

-	spin_lock(&ctrl->lock);
+	spin_lock_irqsave(&ctrl->lock, flags);
 	list_add_tail(&cel->entry, &ctrl->cels);
-	spin_unlock(&ctrl->lock);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 out:
 	*log = &cel->log;
 	return 0;

base-commit: 4d3c0eaf0d44a4f8f7d53b7835e670eafc96c450
--
2.20.1
