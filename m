Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9007829D825
	for <lists+linux-block@lfdr.de>; Wed, 28 Oct 2020 23:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbgJ1W36 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Oct 2020 18:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387570AbgJ1W30 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Oct 2020 18:29:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9C4C0613D2;
        Wed, 28 Oct 2020 15:29:26 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603894382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CqSkQpMY6URuz0G0Q4TnfzC+8Rq7slmLYOYzQAzOWGc=;
        b=31D5ynv45XvdzRDTEELN87qhI/8dZPSaNTNTJOCAB47le0wvb6YrGebef1K6+R/yD/U6aU
        aZ64XufcS/VUufhS7Ix6k2Xdd/nsIwWTrOQMf1QxkAHv0VF+qOQygb1VZGNOUnEwAknB17
        xZ2CrxmX+E4AELBSKoqbTUFaG3OuM3ZlDPxznTpQuXbTGUdIGacOtnmb13e1fJx6IBSKuC
        OhJpbARqtRuXXBOqZjh0a2y+lpPXH6A7pPv+nNAzKUKCF7M1fewCX05oSLRGX78+aldNf2
        /PNLIH4ZgPav3aYvutCTrNdtRazco7kK/v1SHMy7J1oywJ3q/DP6BoFlCvGTeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603894382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CqSkQpMY6URuz0G0Q4TnfzC+8Rq7slmLYOYzQAzOWGc=;
        b=VzXM6tXWEg+XudQIjBFsQQy6kC9HVzTMeWbxvOMd5pYMok+TJDPH/B6ziFhpiKsdGF2Njk
        C3Ye3gLCeVxDAXCg==
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3] blk-mq: Don't complete on a remote CPU in force threaded mode
Date:   Wed, 28 Oct 2020 15:12:49 +0100
Message-Id: <20201028141251.3608598-1-bigeasy@linutronix.de>
In-Reply-To: <20201028065616.GA24449@infradead.org>
References: <20201028065616.GA24449@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With force threaded interrupts enabled, raising softirq from an SMP
function call will always result in waking the ksoftirqd thread. This is
not optimal given that the thread runs at SCHED_OTHER priority.

Completing the request in hard IRQ-context on PREEMPT_RT (which enforces
the force threaded mode) is bad because the completion handler may
acquire sleeping locks which violate the locking context.

Disable request completing on a remote CPU in force threaded mode.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 block/blk-mq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5dc0320..421a40968c9ff 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -648,6 +648,14 @@ static inline bool blk_mq_complete_need_ipi(struct req=
uest *rq)
 	if (!IS_ENABLED(CONFIG_SMP) ||
 	    !test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags))
 		return false;
+	/*
+	 * With force threaded interrupts enabled, raising softirq from an SMP
+	 * function call will always result in waking the ksoftirqd thread.
+	 * This is probably worse than completing the request on a different
+	 * cache domain.
+	 */
+	if (force_irqthreads)
+		return false;
=20
 	/* same CPU or cache domain?  Complete locally */
 	if (cpu =3D=3D rq->mq_ctx->cpu ||
--=20
2.28.0

