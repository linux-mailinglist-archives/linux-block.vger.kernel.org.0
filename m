Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1C626BF1D
	for <lists+linux-block@lfdr.de>; Wed, 16 Sep 2020 10:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgIPIXv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Sep 2020 04:23:51 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:38139 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIPIXu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Sep 2020 04:23:50 -0400
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 16 Sep 2020 01:23:50 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 16 Sep 2020 01:23:48 -0700
Received: from hydcbspbld03.qualcomm.com ([10.242.221.48])
  by ironmsg01-blr.qualcomm.com with ESMTP; 16 Sep 2020 13:53:35 +0530
Received: by hydcbspbld03.qualcomm.com (Postfix, from userid 2304101)
        id 2E9F220EAA; Wed, 16 Sep 2020 13:53:34 +0530 (IST)
From:   Pradeep P V K <ppvk@codeaurora.org>
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, Pradeep P V K <ppvk@codeaurora.org>
Subject: [PATCH V3] block: Fix use-after-free issue while accessing ioscheduler lock
Date:   Wed, 16 Sep 2020 13:53:31 +0530
Message-Id: <1600244611-55554-1-git-send-email-ppvk@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Observes below crash while accessing (use-after-free) lock member
of bfq data.

context#1			context#2
				process_one_work()
kthread()			blk_mq_run_work_fn()
worker_thread()			 ->__blk_mq_run_hw_queue()
process_one_work()		  ->blk_mq_sched_dispatch_requests()
__blk_release_queue()		    ->blk_mq_do_dispatch_sched()
->__elevator_exit()
  ->blk_mq_exit_sched()
    ->exit_sched()
      ->kfree()
				       ->bfq_dispatch_request()
				         ->spin_unlock_irq(&bfqd->lock)

This is because of the kblockd delayed work that might got scheduled
around blk_release_queue() and accessed use-after-free member of
bfq_data.

240.212359:   <2> Unable to handle kernel paging request at
virtual address ffffffee2e33ad70
...
240.212637:   <2> Workqueue: kblockd blk_mq_run_work_fn
240.212649:   <2> pstate: 00c00085 (nzcv daIf +PAN +UAO)
240.212666:   <2> pc : queued_spin_lock_slowpath+0x10c/0x2e0
240.212677:   <2> lr : queued_spin_lock_slowpath+0x84/0x2e0
...
Call trace:
240.212865:   <2>  queued_spin_lock_slowpath+0x10c/0x2e0
240.212876:   <2>  do_raw_spin_lock+0xf0/0xf4
240.212890:   <2>  _raw_spin_lock_irq+0x74/0x94
240.212906:   <2>  bfq_dispatch_request+0x4c/0xd60
240.212918:   <2>  blk_mq_do_dispatch_sched+0xe0/0x1f0
240.212927:   <2>  blk_mq_sched_dispatch_requests+0x130/0x194
240.212940:   <2>  __blk_mq_run_hw_queue+0x100/0x158
240.212950:   <2>  blk_mq_run_work_fn+0x1c/0x28
240.212963:   <2>  process_one_work+0x280/0x460
240.212973:   <2>  worker_thread+0x27c/0x4dc
240.212986:   <2>  kthread+0x160/0x170

Fix this by cancelling the delayed work if any before elevator exits.

Changes since V2:
- Retained the code logic and Reviewed-by signoff from V1 Patch
  as per Ming comments.
- Moved the new local variables into queue_is_mq() branch.
- Removed 'cancel_delayed_work_sync' from blk_mq_hw_sysfs_release()

Changes since V1:
- Moved the logic into blk_cleanup_queue() as per Ming comments.

Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sysfs.c | 1 -
 block/blk-sysfs.c    | 8 ++++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 06222939..24bc9cc 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -36,7 +36,6 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
 	struct blk_mq_hw_ctx *hctx = container_of(kobj, struct blk_mq_hw_ctx,
 						  kobj);
 
-	cancel_delayed_work_sync(&hctx->run_work);
 
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
 		cleanup_srcu_struct(hctx->srcu);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 81722cd..73a2137 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -788,9 +788,13 @@ static void blk_release_queue(struct kobject *kobj)
 
 	blk_free_queue_stats(q->stats);
 
-	if (queue_is_mq(q))
+	if (queue_is_mq(q)) {
+		struct blk_mq_hw_ctx *hctx;
+		int i;
 		cancel_delayed_work_sync(&q->requeue_work);
-
+		queue_for_each_hw_ctx(q, hctx, i)
+			cancel_delayed_work_sync(&hctx->run_work);
+	}
 	blk_exit_queue(q);
 
 	blk_queue_free_zone_bitmaps(q);
-- 
2.7.4

