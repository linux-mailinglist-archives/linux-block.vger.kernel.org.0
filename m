Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FAD552C35
	for <lists+linux-block@lfdr.de>; Tue, 21 Jun 2022 09:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345300AbiFUHjs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Jun 2022 03:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347633AbiFUHjY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 03:39:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26FD11177
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 00:39:22 -0700 (PDT)
Date:   Tue, 21 Jun 2022 09:39:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655797161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Q3f9DC+rdLKK/gPUiHSoO4yoHtEOLzqdL/QVbpywb3k=;
        b=if//QQb3RhdLAeeuW1D+UFdWXVWxIouHO2C14JJvjARn611Q/qW26xBiD5/quPmkI+5oCk
        4L55+yHrlYjYU0LPT26Wn4tLZ7Eet1bG6VADUXDTCCduFXojd6AiU1rrvgcrshyTbjooVZ
        Jz/bpIjcj7qBEn5lIUIpvZW2SJVvgLQbXrMZzxkJtpNb4qzhdHzCOICab/pK2PWhoB4Nn+
        BwUXIBQP2WdIUyhJt7Tgq5s5LMmKcQ7x/liuFwfTGDIsudWq2SDNW/yoCnYhb5KVlJWwH4
        Uk/hfXAo7szXxV6XL+k979vHZ5zp4oD2QJ86cXfNXPakTroNkHJyPxc4zF/fFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655797161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Q3f9DC+rdLKK/gPUiHSoO4yoHtEOLzqdL/QVbpywb3k=;
        b=4sUUQJ7esBmKFvnuJwiqwNyKbR8yWixPgQ+DwMbOJjB57+nhi7lQBfPl/O2+s7HKOONx+W
        jobmN5E2y+8S08Dg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH REPOST] blk-mq: Don't disable preemption around
  __blk_mq_run_hw_queue().
Message-ID: <YrF1p2n0MxHQ3fcJ@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__blk_mq_delay_run_hw_queue() disables preemption to get a stable
current CPU number and then invokes __blk_mq_run_hw_queue() if the CPU
number is part the mask.

__blk_mq_run_hw_queue() acquires a spin_lock_t which is a sleeping lock
on PREEMPT_RT and can't be acquired with disabled preemption.

If it is important that the current CPU matches the requested CPU mask
and that the context does not migrate to another CPU while
__blk_mq_run_hw_queue() is invoked then it possible to achieve this by
disabling migration and keeping the context preemptible.

Disable only migration while testing the CPU mask and invoking
__blk_mq_run_hw_queue().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/YnQHqx/5+54jd+U+@linutronix.de
Link: https://lore.kernel.org/r/YqISXf6GAQeWqcR+@linutronix.de
---
 block/blk-mq.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2083,14 +2083,14 @@ static void __blk_mq_delay_run_hw_queue(
 		return;
 
 	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		int cpu = get_cpu();
-		if (cpumask_test_cpu(cpu, hctx->cpumask)) {
+		migrate_disable();
+		if (cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 			__blk_mq_run_hw_queue(hctx);
-			put_cpu();
+			migrate_enable();
 			return;
 		}
 
-		put_cpu();
+		migrate_enable();
 	}
 
 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
