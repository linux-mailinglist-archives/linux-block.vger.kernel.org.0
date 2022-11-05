Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B05A61DF9E
	for <lists+linux-block@lfdr.de>; Sun,  6 Nov 2022 00:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiKEXLI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 5 Nov 2022 19:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKEXLH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Nov 2022 19:11:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FE1DFA1;
        Sat,  5 Nov 2022 16:11:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E3141F37E;
        Sat,  5 Nov 2022 23:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667689861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tDUWZN79x9yoUZIZ4Slq0fQ9VuYoYPDPcHlKsV/Y7Vw=;
        b=JvgCdou8o4dfS97npKZg5pRbK5fXqlCulxuCFr0+NOgh1posF9Azz8eVn+2/ZXGZ1bnCaC
        ZcANDFb5ZWPZ+cH5f3d8EaYdUT6jEM0mmdRZdHoy5WUxf8rcoDxOPxtPzfTse0+ssQO/n0
        SPz0uh4IY8J+ynnzL7HadbXiEbu3kLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667689861;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tDUWZN79x9yoUZIZ4Slq0fQ9VuYoYPDPcHlKsV/Y7Vw=;
        b=4r/fLg4dmd7TNYLkI7tshDLLcmJ6apt/wIR6m/SOrYAb4Q7CLgGzQci/wfsn6I00gLvGkw
        29ITplogIWibvGAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5900913AA6;
        Sat,  5 Nov 2022 23:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kVepEIXtZmMTBAAAMHmgww
        (envelope-from <krisman@suse.de>); Sat, 05 Nov 2022 23:11:01 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Hugh Dickins <hughd@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Liu Song <liusong@linux.alibaba.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH] sbitmap: Use single per-bitmap counting to wake up queued tags
Date:   Sat,  5 Nov 2022 19:10:55 -0400
Message-Id: <20221105231055.25953-1-krisman@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

sbitmap suffers from code complexity, as demonstrated by recent fixes,
and eventual lost wake ups on nested I/O completion.  The later happens,
from what I understand, due to the non-atomic nature of the updates to
wait_cnt, which needs to be subtracted and eventually reset when equal
to zero.  This two step process can eventually miss an update when a
nested completion happens to interrupt the CPU in between the wait_cnt
updates.  This is very hard to fix, as shown by the recent changes to
this code.

The code complexity arises mostly from the corner cases to avoid missed
wakes in this scenario.  In addition, the handling of wake_batch
recalculation plus the synchronization with sbq_queue_wake_up is
non-trivial.

This patchset implements the idea originally proposed by Jan [1], which
removes the need for the two-step updates of wait_cnt.  This is done by
tracking the number of completions and wakeups in always increasing,
per-bitmap counters.  Instead of having to reset the wait_cnt when it
reaches zero, we simply keep counting, and attempt to wake up N threads
in a single wait queue whenever there is enough space for a batch.
Waking up less than batch_wake shouldn't be a problem, because we
haven't changed the conditions for wake up, and the existing batch
calculation guarantees at least enough remaining completions to wake up
a batch for each queue at any time.

Performance-wise, one should expect very similar performance to the
original algorithm for the case where there is no queueing.  In both the
old algorithm and this implementation, the first thing is to check
ws_active, which bails out if there is no queueing to be managed. In the
new code, we took care to avoid accounting completions and wakeups when
there is no queueing, to not pay the cost of atomic operations
unnecessarily, since it doesn't skew the numbers.

For more interesting cases, where there is queueing, we need to take
into account the cross-communication of the atomic operations.  I've
been benchmarking by running parallel fio jobs against a single hctx
nullb in different hardware queue depth scenarios, and verifying both
IOPS and queueing.

Each experiment was repeated 5 times on a 20-CPU box, with 20 parallel
jobs. fio was issuing fixed-size randwrites with qd=64 against nullb,
varying only the hardware queue length per test.

queue size 2                 4                 8                 16                 32                 64
6.1-rc2    1681.1K (1.6K)    2633.0K (12.7K)   6940.8K (16.3K)   8172.3K (617.5K)   8391.7K (367.1K)   8606.1K (351.2K)
patched    1721.8K (15.1K)   3016.7K (3.8K)    7543.0K (89.4K)   8132.5K (303.4K)   8324.2K (230.6K)   8401.8K (284.7K)

The following is a similar experiment, ran against a nullb with a single
bitmap shared by 20 hctx spread across 2 NUMA nodes. This has 40
parallel fio jobs operating on the same device

queue size 2 	             4                 8              	16             	    32		       64
6.1-rc2	   1081.0K (2.3K)    957.2K (1.5K)     1699.1K (5.7K) 	6178.2K (124.6K)    12227.9K (37.7K)   13286.6K (92.9K)
patched	   1081.8K (2.8K)    1316.5K (5.4K)    2364.4K (1.8K) 	6151.4K  (20.0K)    11893.6K (17.5K)   12385.6K (18.4K)

It has also survived blktests and a 12h-stress run against nullb. I also
ran the code against nvme and a scsi SSD, and I didn't observe
performance regression in those. If there are other tests you think I
should run, please let me know and I will follow up with results.

[1] https://lore.kernel.org/all/aef9de29-e9f5-259a-f8be-12d1b734e72@google.com/

Cc: Hugh Dickins <hughd@google.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Liu Song <liusong@linux.alibaba.com>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 include/linux/sbitmap.h |  16 ++++--
 lib/sbitmap.c           | 122 +++++++++-------------------------------
 2 files changed, 37 insertions(+), 101 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 4d2d5205ab58..d662cf136021 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -86,11 +86,6 @@ struct sbitmap {
  * struct sbq_wait_state - Wait queue in a &struct sbitmap_queue.
  */
 struct sbq_wait_state {
-	/**
-	 * @wait_cnt: Number of frees remaining before we wake up.
-	 */
-	atomic_t wait_cnt;
-
 	/**
 	 * @wait: Wait queue.
 	 */
@@ -138,6 +133,17 @@ struct sbitmap_queue {
 	 * sbitmap_queue_get_shallow()
 	 */
 	unsigned int min_shallow_depth;
+
+	/**
+	 * @completion_cnt: Number of bits cleared passed to the
+	 * wakeup function.
+	 */
+	atomic_t completion_cnt;
+
+	/**
+	 * @wakeup_cnt: Number of thread wake ups issued.
+	 */
+	atomic_t wakeup_cnt;
 };
 
 /**
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 7280ae8ca88c..eca462cba398 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -434,6 +434,8 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 	sbq->wake_batch = sbq_calc_wake_batch(sbq, depth);
 	atomic_set(&sbq->wake_index, 0);
 	atomic_set(&sbq->ws_active, 0);
+	atomic_set(&sbq->completion_cnt, 0);
+	atomic_set(&sbq->wakeup_cnt, 0);
 
 	sbq->ws = kzalloc_node(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags, node);
 	if (!sbq->ws) {
@@ -441,40 +443,21 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
+	for (i = 0; i < SBQ_WAIT_QUEUES; i++)
 		init_waitqueue_head(&sbq->ws[i].wait);
-		atomic_set(&sbq->ws[i].wait_cnt, sbq->wake_batch);
-	}
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_init_node);
 
-static inline void __sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
-					    unsigned int wake_batch)
-{
-	int i;
-
-	if (sbq->wake_batch != wake_batch) {
-		WRITE_ONCE(sbq->wake_batch, wake_batch);
-		/*
-		 * Pairs with the memory barrier in sbitmap_queue_wake_up()
-		 * to ensure that the batch size is updated before the wait
-		 * counts.
-		 */
-		smp_mb();
-		for (i = 0; i < SBQ_WAIT_QUEUES; i++)
-			atomic_set(&sbq->ws[i].wait_cnt, 1);
-	}
-}
-
 static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
 					    unsigned int depth)
 {
 	unsigned int wake_batch;
 
 	wake_batch = sbq_calc_wake_batch(sbq, depth);
-	__sbitmap_queue_update_wake_batch(sbq, wake_batch);
+	if (sbq->wake_batch != wake_batch)
+		WRITE_ONCE(sbq->wake_batch, wake_batch);
 }
 
 void sbitmap_queue_recalculate_wake_batch(struct sbitmap_queue *sbq,
@@ -488,7 +471,8 @@ void sbitmap_queue_recalculate_wake_batch(struct sbitmap_queue *sbq,
 
 	wake_batch = clamp_val(depth / SBQ_WAIT_QUEUES,
 			min_batch, SBQ_WAKE_BATCH);
-	__sbitmap_queue_update_wake_batch(sbq, wake_batch);
+
+	WRITE_ONCE(sbq->wake_batch, wake_batch);
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_recalculate_wake_batch);
 
@@ -587,7 +571,7 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
 
-		if (waitqueue_active(&ws->wait) && atomic_read(&ws->wait_cnt)) {
+		if (waitqueue_active(&ws->wait)) {
 			if (wake_index != atomic_read(&sbq->wake_index))
 				atomic_set(&sbq->wake_index, wake_index);
 			return ws;
@@ -599,83 +583,31 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 	return NULL;
 }
 
-static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
+void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
 {
-	struct sbq_wait_state *ws;
-	unsigned int wake_batch;
-	int wait_cnt, cur, sub;
-	bool ret;
+	unsigned int wake_batch = READ_ONCE(sbq->wake_batch);
+	struct sbq_wait_state *ws = NULL;
+	unsigned int wakeups;
 
-	if (*nr <= 0)
-		return false;
+	if (!atomic_read(&sbq->ws_active))
+		return;
 
-	ws = sbq_wake_ptr(sbq);
-	if (!ws)
-		return false;
+	atomic_add(nr, &sbq->completion_cnt);
+	wakeups = atomic_read(&sbq->wakeup_cnt);
 
-	cur = atomic_read(&ws->wait_cnt);
 	do {
-		/*
-		 * For concurrent callers of this, callers should call this
-		 * function again to wakeup a new batch on a different 'ws'.
-		 */
-		if (cur == 0)
-			return true;
-		sub = min(*nr, cur);
-		wait_cnt = cur - sub;
-	} while (!atomic_try_cmpxchg(&ws->wait_cnt, &cur, wait_cnt));
-
-	/*
-	 * If we decremented queue without waiters, retry to avoid lost
-	 * wakeups.
-	 */
-	if (wait_cnt > 0)
-		return !waitqueue_active(&ws->wait);
+		if (atomic_read(&sbq->completion_cnt) - wakeups < wake_batch)
+			return;
 
-	*nr -= sub;
-
-	/*
-	 * When wait_cnt == 0, we have to be particularly careful as we are
-	 * responsible to reset wait_cnt regardless whether we've actually
-	 * woken up anybody. But in case we didn't wakeup anybody, we still
-	 * need to retry.
-	 */
-	ret = !waitqueue_active(&ws->wait);
-	wake_batch = READ_ONCE(sbq->wake_batch);
+		if (!ws) {
+			ws = sbq_wake_ptr(sbq);
+			if (!ws)
+				return;
+		}
+	} while (!atomic_try_cmpxchg(&sbq->wakeup_cnt,
+				     &wakeups, wakeups + wake_batch));
 
-	/*
-	 * Wake up first in case that concurrent callers decrease wait_cnt
-	 * while waitqueue is empty.
-	 */
 	wake_up_nr(&ws->wait, wake_batch);
-
-	/*
-	 * Pairs with the memory barrier in sbitmap_queue_resize() to
-	 * ensure that we see the batch size update before the wait
-	 * count is reset.
-	 *
-	 * Also pairs with the implicit barrier between decrementing wait_cnt
-	 * and checking for waitqueue_active() to make sure waitqueue_active()
-	 * sees result of the wakeup if atomic_dec_return() has seen the result
-	 * of atomic_set().
-	 */
-	smp_mb__before_atomic();
-
-	/*
-	 * Increase wake_index before updating wait_cnt, otherwise concurrent
-	 * callers can see valid wait_cnt in old waitqueue, which can cause
-	 * invalid wakeup on the old waitqueue.
-	 */
-	sbq_index_atomic_inc(&sbq->wake_index);
-	atomic_set(&ws->wait_cnt, wake_batch);
-
-	return ret || *nr;
-}
-
-void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
-{
-	while (__sbq_wake_up(sbq, &nr))
-		;
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
 
@@ -792,9 +724,7 @@ void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m)
 	seq_puts(m, "ws={\n");
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[i];
-
-		seq_printf(m, "\t{.wait_cnt=%d, .wait=%s},\n",
-			   atomic_read(&ws->wait_cnt),
+		seq_printf(m, "\t{.wait=%s},\n",
 			   waitqueue_active(&ws->wait) ? "active" : "inactive");
 	}
 	seq_puts(m, "}\n");
-- 
2.35.3

