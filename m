Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5569280C07
	for <lists+linux-block@lfdr.de>; Fri,  2 Oct 2020 03:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbgJBBj3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Oct 2020 21:39:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:55694 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387483AbgJBBj3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Oct 2020 21:39:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11E18B225;
        Fri,  2 Oct 2020 01:39:28 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>, Vicente Bergas <vicencb@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v4] mmc: core: don't set limits.discard_granularity as 0
Date:   Fri,  2 Oct 2020 09:38:52 +0800
Message-Id: <20201002013852.51968-1-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In mmc_queue_setup_discard() the mmc driver queue's discard_granularity
might be set as 0 (when card->pref_erase > max_discard) while the mmc
device still declares to support discard operation. This is buggy and
triggered the following kernel warning message,

WARNING: CPU: 0 PID: 135 at __blkdev_issue_discard+0x200/0x294
CPU: 0 PID: 135 Comm: f2fs_discard-17 Not tainted 5.9.0-rc6 #1
Hardware name: Google Kevin (DT)
pstate: 00000005 (nzcv daif -PAN -UAO BTYPE=--)
pc : __blkdev_issue_discard+0x200/0x294
lr : __blkdev_issue_discard+0x54/0x294
sp : ffff800011dd3b10
x29: ffff800011dd3b10 x28: 0000000000000000 x27: ffff800011dd3cc4 x26: ffff800011dd3e18 x25: 000000000004e69b x24: 0000000000000c40 x23: ffff0000f1deaaf0 x22: ffff0000f2849200 x21: 00000000002734d8 x20: 0000000000000008 x19: 0000000000000000 x18: 0000000000000000 x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000 x14: 0000000000000394 x13: 0000000000000000 x12: 0000000000000000 x11: 0000000000000000 x10: 00000000000008b0 x9 : ffff800011dd3cb0 x8 : 000000000004e69b x7 : 0000000000000000 x6 : ffff0000f1926400 x5 : ffff0000f1940800 x4 : 0000000000000000 x3 : 0000000000000c40 x2 : 0000000000000008 x1 : 00000000002734d8 x0 : 0000000000000000 Call trace:
__blkdev_issue_discard+0x200/0x294
__submit_discard_cmd+0x128/0x374
__issue_discard_cmd_orderly+0x188/0x244
__issue_discard_cmd+0x2e8/0x33c
issue_discard_thread+0xe8/0x2f0
kthread+0x11c/0x120
ret_from_fork+0x10/0x1c
---[ end trace e4c8023d33dfe77a ]---

This patch fixes the issue by setting discard_granularity as SECTOR_SIZE
instead of 0 when (card->pref_erase > max_discard) is true. Now no more
complain from __blkdev_issue_discard() for the improper value of discard
granularity.

This issue is exposed after commit b35fd7422c2f ("block: check queue's
limits.discard_granularity in __blkdev_issue_discard()"), a "Fixes:" tag
is also added for the commit to make sure people won't miss this patch
after applying the change of __blkdev_issue_discard().

Fixes: e056a1b5b67b ("mmc: queue: let host controllers specify maximum discard timeout")
Fixes: b35fd7422c2f ("block: check queue's limits.discard_granularity in __blkdev_issue_discard()").
Reported-and-tested-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
---
Changelog,
v4, update to Reported-and-tested-by tag for Vicente Bergas.
v3, add Fixes tag for both commits.
v2, change commit id of the Fixes tag.
v1, initial version.

 drivers/mmc/core/queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 6c022ef0f84d..350d0cc4ee62 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -190,7 +190,7 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 	q->limits.discard_granularity = card->pref_erase << 9;
 	/* granularity must not be greater than max. discard */
 	if (card->pref_erase > max_discard)
-		q->limits.discard_granularity = 0;
+		q->limits.discard_granularity = SECTOR_SIZE;
 	if (mmc_can_secure_erase_trim(card))
 		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
 }
-- 
2.26.2

