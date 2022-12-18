Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA0864FFA8
	for <lists+linux-block@lfdr.de>; Sun, 18 Dec 2022 17:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiLRQFL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 18 Dec 2022 11:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiLRQEj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Dec 2022 11:04:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82330B7F7;
        Sun, 18 Dec 2022 08:03:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F66860DCA;
        Sun, 18 Dec 2022 16:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C5EC433F2;
        Sun, 18 Dec 2022 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671379380;
        bh=3gsHSt0wuiY6019cjs5JAUJmceQVZDeXBuBdLOIk2KA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdhAhFW0DSZ5cRwAf7SAtKN5ym00m9QDvGQ0taH/cFRQac8AdyeScIsYuLl8NhOTs
         NdTJCHEyknCAkaoigvcCkras8zQpr3zsXa4G4rrfkcAzdxoXOZ6E28XtCXgFudKVEt
         0yvG+nkeqlJ8NegOpE36NX6kYPmDVxW46VRTMPVyLOkF1rw+OJ7iRrJCddeJWZ9J/I
         Uq//4hwm2E88qELqJg+PH8eXoaXT+6ZAyjH/mv0jkw/sSoc4cckJbi78ypcxAtyIJ9
         6dUSrOBECPV28dhqDVsQskfNJqSvADzb8Y9ivjiLG1ZssKLsX2ca0n6RkZL7K92k0b
         DDSAqHeEyhQKA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Jeffery <djeffery@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 17/85] blk-mq: avoid double ->queue_rq() because of early timeout
Date:   Sun, 18 Dec 2022 11:00:34 -0500
Message-Id: <20221218160142.925394-17-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221218160142.925394-1-sashal@kernel.org>
References: <20221218160142.925394-1-sashal@kernel.org>
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

From: David Jeffery <djeffery@redhat.com>

[ Upstream commit 82c229476b8f6afd7e09bc4dc77d89dc19ff7688 ]

David Jeffery found one double ->queue_rq() issue, so far it can
be triggered in VM use case because of long vmexit latency or preempt
latency of vCPU pthread or long page fault in vCPU pthread, then block
IO req could be timed out before queuing the request to hardware but after
calling blk_mq_start_request() during ->queue_rq(), then timeout handler
may handle it by requeue, then double ->queue_rq() is caused, and kernel
panic.

So far, it is driver's responsibility to cover the race between timeout
and completion, so it seems supposed to be solved in driver in theory,
given driver has enough knowledge.

But it is really one common problem, lots of driver could have similar
issue, and could be hard to fix all affected drivers, even it isn't easy
for driver to handle the race. So David suggests this patch by draining
in-progress ->queue_rq() for solving this issue.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: virtualization@lists.linux-foundation.org
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20221026051957.358818-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 56 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 228a6696d835..0b855e033a83 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1529,7 +1529,13 @@ static void blk_mq_rq_timed_out(struct request *req)
 	blk_add_timer(req);
 }
 
-static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
+struct blk_expired_data {
+	bool has_timedout_rq;
+	unsigned long next;
+	unsigned long timeout_start;
+};
+
+static bool blk_mq_req_expired(struct request *rq, struct blk_expired_data *expired)
 {
 	unsigned long deadline;
 
@@ -1539,13 +1545,13 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 		return false;
 
 	deadline = READ_ONCE(rq->deadline);
-	if (time_after_eq(jiffies, deadline))
+	if (time_after_eq(expired->timeout_start, deadline))
 		return true;
 
-	if (*next == 0)
-		*next = deadline;
-	else if (time_after(*next, deadline))
-		*next = deadline;
+	if (expired->next == 0)
+		expired->next = deadline;
+	else if (time_after(expired->next, deadline))
+		expired->next = deadline;
 	return false;
 }
 
@@ -1561,7 +1567,7 @@ void blk_mq_put_rq_ref(struct request *rq)
 
 static bool blk_mq_check_expired(struct request *rq, void *priv)
 {
-	unsigned long *next = priv;
+	struct blk_expired_data *expired = priv;
 
 	/*
 	 * blk_mq_queue_tag_busy_iter() has locked the request, so it cannot
@@ -1570,7 +1576,18 @@ static bool blk_mq_check_expired(struct request *rq, void *priv)
 	 * it was completed and reallocated as a new request after returning
 	 * from blk_mq_check_expired().
 	 */
-	if (blk_mq_req_expired(rq, next))
+	if (blk_mq_req_expired(rq, expired)) {
+		expired->has_timedout_rq = true;
+		return false;
+	}
+	return true;
+}
+
+static bool blk_mq_handle_expired(struct request *rq, void *priv)
+{
+	struct blk_expired_data *expired = priv;
+
+	if (blk_mq_req_expired(rq, expired))
 		blk_mq_rq_timed_out(rq);
 	return true;
 }
@@ -1579,7 +1596,9 @@ static void blk_mq_timeout_work(struct work_struct *work)
 {
 	struct request_queue *q =
 		container_of(work, struct request_queue, timeout_work);
-	unsigned long next = 0;
+	struct blk_expired_data expired = {
+		.timeout_start = jiffies,
+	};
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
@@ -1599,10 +1618,23 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
+	/* check if there is any timed-out request */
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &expired);
+	if (expired.has_timedout_rq) {
+		/*
+		 * Before walking tags, we must ensure any submit started
+		 * before the current time has finished. Since the submit
+		 * uses srcu or rcu, wait for a synchronization point to
+		 * ensure all running submits have finished
+		 */
+		blk_mq_wait_quiesce_done(q);
+
+		expired.next = 0;
+		blk_mq_queue_tag_busy_iter(q, blk_mq_handle_expired, &expired);
+	}
 
-	if (next != 0) {
-		mod_timer(&q->timeout, next);
+	if (expired.next != 0) {
+		mod_timer(&q->timeout, expired.next);
 	} else {
 		/*
 		 * Request timeouts are handled as a forward rolling timer. If
-- 
2.35.1

