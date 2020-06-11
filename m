Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D391F61DD
	for <lists+linux-block@lfdr.de>; Thu, 11 Jun 2020 08:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgFKGpF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 11 Jun 2020 02:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgFKGpE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 02:45:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF17BC08C5C1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 23:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Rxjf2h70f0yXXhmT9oYO9mwTP6V9/lowlBJa+ppheSo=; b=beWoUoTUk42h/lLLCQmjdgimfb
        VXUQyE+RwftpOoSkAvdVmrHzBMyNnmdW7LNa/QyWcFMTw6/f7tLpGYd7+hVQsakkhA9unJ3gPIsm3
        FO5c8DQ3N4dV3Ei8tWaoWj8QVO9maSCjBWnmucytHjtXCyaAFaBm3kHzR/COc1DXl+OTSSBg3k1Gi
        +elYwr2TmZhGTKB8KHVpN57AxnZl6tqcaLM+cQ+VgMlbpawOPE/Uo226ASash5zTkCQqRlk2gcS/l
        AuHahesIw2fx0h2n2pk7QnYNXaSufclQ3wHg49EA5dBq4fcjPLEDOhods2DfHDWFKvtaNLgZpYDWL
        ECpxLC/w==;
Received: from [2001:4bb8:18c:317f:efe9:d6fc:cdd9:b4ec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjGxT-0004vA-Pp; Thu, 11 Jun 2020 06:45:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infrdead.org
Subject: [PATCH 03/12] blk-mq: remove raise_blk_irq
Date:   Thu, 11 Jun 2020 08:44:43 +0200
Message-Id: <20200611064452.12353-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200611064452.12353-1-hch@lst.de>
References: <20200611064452.12353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

By open coding raise_blk_irq in the only caller, and replacing the
ifdef CONFIG_SMP with an IS_ENABLED check the flow in the caller
can be significantly simplified.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 40 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa1917949f0ded..9d3928456af1c8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -613,37 +613,11 @@ static void blk_mq_trigger_softirq(struct request *rq)
 		raise_softirq_irqoff(BLOCK_SOFTIRQ);
 }
 
-#ifdef CONFIG_SMP
 static void trigger_softirq(void *data)
 {
 	blk_mq_trigger_softirq(data);
 }
 
-/*
- * Setup and invoke a run of 'trigger_softirq' on the given cpu.
- */
-static int raise_blk_irq(int cpu, struct request *rq)
-{
-	if (cpu_online(cpu)) {
-		call_single_data_t *data = &rq->csd;
-
-		data->func = trigger_softirq;
-		data->info = rq;
-		data->flags = 0;
-
-		smp_call_function_single_async(cpu, data);
-		return 0;
-	}
-
-	return 1;
-}
-#else /* CONFIG_SMP */
-static int raise_blk_irq(int cpu, struct request *rq)
-{
-	return 1;
-}
-#endif
-
 static int blk_softirq_cpu_dead(unsigned int cpu)
 {
 	/*
@@ -688,11 +662,17 @@ static void __blk_complete_request(struct request *req)
 	 * support multiple interrupts, so current CPU is unique actually. This
 	 * avoids IPI sending from current CPU to the first CPU of a group.
 	 */
-	if (ccpu == cpu || shared) {
-do_local:
+	if (IS_ENABLED(CONFIG_SMP) &&
+	    ccpu != cpu && !shared && cpu_online(ccpu)) {
+		call_single_data_t *data = &req->csd;
+
+		data->func = trigger_softirq;
+		data->info = req;
+		data->flags = 0;
+		smp_call_function_single_async(cpu, data);
+	} else {
 		blk_mq_trigger_softirq(req);
-	} else if (raise_blk_irq(ccpu, req))
-		goto do_local;
+	}
 
 	local_irq_restore(flags);
 }
-- 
2.26.2

