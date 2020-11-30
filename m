Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0BD2C81FF
	for <lists+linux-block@lfdr.de>; Mon, 30 Nov 2020 11:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgK3KUF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 Nov 2020 05:20:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:60720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728546AbgK3KUE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 05:20:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1489EAC6A;
        Mon, 30 Nov 2020 10:19:23 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2] blk-mq: Remove 'running from the wrong CPU' warning
Date:   Mon, 30 Nov 2020 11:19:21 +0100
Message-Id: <20201130101921.52754-1-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It's guaranteed that no request is in flight when a hctx is going
offline. This warning is only triggered when the wq's CPU is hot
plugged and the blk-mq is not synced up yet.

As this state is temporary and the request is still processed
correctly, better remove the warning as this is the fast path.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

v2:
  - remove the warning as suggested by Ming
v1:
  - initial version
    https://lore.kernel.org/linux-block/20201126095152.19151-1-dwagner@suse.de/

 block/blk-mq.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5dc032..7e6761804f86 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1495,31 +1495,6 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
 	int srcu_idx;
 
-	/*
-	 * We should be running this queue from one of the CPUs that
-	 * are mapped to it.
-	 *
-	 * There are at least two related races now between setting
-	 * hctx->next_cpu from blk_mq_hctx_next_cpu() and running
-	 * __blk_mq_run_hw_queue():
-	 *
-	 * - hctx->next_cpu is found offline in blk_mq_hctx_next_cpu(),
-	 *   but later it becomes online, then this warning is harmless
-	 *   at all
-	 *
-	 * - hctx->next_cpu is found online in blk_mq_hctx_next_cpu(),
-	 *   but later it becomes offline, then the warning can't be
-	 *   triggered, and we depend on blk-mq timeout handler to
-	 *   handle dispatched requests to this hctx
-	 */
-	if (!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
-		cpu_online(hctx->next_cpu)) {
-		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
-			raw_smp_processor_id(),
-			cpumask_empty(hctx->cpumask) ? "inactive": "active");
-		dump_stack();
-	}
-
 	/*
 	 * We can't run the queue inline with ints disabled. Ensure that
 	 * we catch bad users of this early.
-- 
2.16.4

