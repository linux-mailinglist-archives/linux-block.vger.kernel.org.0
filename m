Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9194296D4E
	for <lists+linux-block@lfdr.de>; Fri, 23 Oct 2020 13:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462703AbgJWLEE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Oct 2020 07:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462548AbgJWLED (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Oct 2020 07:04:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A242C0613CE;
        Fri, 23 Oct 2020 04:04:03 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:04:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603451041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j1o05ovjntirIj7cvm7bSPa5eySCqPWLuUvFBBxTkcA=;
        b=VU/I/Bg0fjftmhfkNoiTI5iQAkWt1oroH4F41nG/CTl2uJHdNhPckdnBQqbVas1E1ON0pK
        yWtYg+1sxh8pnuRX09q7grhMA5ExKHvEq4tUlD5e4PmTGZD8eILAiC50zsA2xoekbuC7GI
        V7Et6fYnqpFWlxEW8NaEqob68BlhofnBfRLmNmF9Vgd4t2YrRsDVn9saDXGfeMGxf6PvL9
        HcBqVwWt7NPl1ot8NBdkEbY9q7Ah/hgACZz+zThD4LBIcE5pNr69pdBISg+FwQp/IplXRh
        u0UcS7rrdehouC3VUYfoOc3rjBpHD9hmVL6CFsG1G8xBvaXus7B2u+obpb2uUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603451041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j1o05ovjntirIj7cvm7bSPa5eySCqPWLuUvFBBxTkcA=;
        b=UnEzQ4M/+js0ciQkn+pulvrti1+fg2aEU1ycvfsSoEgkxQxIRZJkVTxbb25CBaUFmUS6MF
        hm4LzqNXplO2z+DQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     David Runge <dave@sleepmap.de>
Cc:     linux-rt-users@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH RFC] blk-mq: Don't IPI requests on PREEMPT_RT
Message-ID: <20201023110400.bx3uzsb7xy5jtsea@linutronix.de>
References: <20201021175059.GA4989@hmbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021175059.GA4989@hmbx>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_complete_request_remote() will dispatch request completion to
another CPU via IPI if the CPU belongs to a different cache domain.

This breaks on PREEMPT_RT because the IPI function will complete the
request in IRQ context which includes acquiring spinlock_t typed locks.
Completing the IPI request in softirq on the remote CPU is probably less
efficient because it would require to wake ksoftirqd for this task
(which runs at SCHED_OTHER).

Ignoring the IPI request and completing the request locally is probably
the best option. It be completed either in the IRQ-thread or at the end
of the routine in softirq context.

Let blk_mq_complete_need_ipi() return that there is no need for IPI on
PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e37aa31332b70..99d2fb51e0e84 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -647,7 +647,7 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 {
 	int cpu = raw_smp_processor_id();
 
-	if (!IS_ENABLED(CONFIG_SMP) ||
+	if (!IS_ENABLED(CONFIG_SMP) || IS_ENABLED(CONFIG_PREEMPT_RT) ||
 	    !test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags))
 		return false;
 
-- 
2.28.0

