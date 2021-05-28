Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27F6394289
	for <lists+linux-block@lfdr.de>; Fri, 28 May 2021 14:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhE1Mc3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 28 May 2021 08:32:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:54894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235001AbhE1McY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 May 2021 08:32:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622205049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yAWimkCJOF8VvCzPNPfupyiQUXAA993DaWEsfdN06VQ=;
        b=FB03TVQVgN8o+699KO7atOoNfkhdRcy+aWH/o8fx5e3SNDak6QL/bseCbsbNRdxcr8tqaW
        y8GTBCJ49Fzi5QlMcwV0fGlr6gJx4squICNs4S4CVBs9uEd+oKFgs/o6iUQWsJz9yfWHkt
        hUlytBzkpPMo//YQjBkcsg/0Pgy23qY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622205049;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yAWimkCJOF8VvCzPNPfupyiQUXAA993DaWEsfdN06VQ=;
        b=JHp3FNlTwjOHloPBTLbrYPBXLmzhddIvkhMFrIbljNVt7sdtTHJY+K08RZ/ttRLX/7I42/
        r+Jc3TbAnMmjP6Ag==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18F4BACF2;
        Fri, 28 May 2021 12:30:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D4E501F2CA0; Fri, 28 May 2021 14:30:48 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Khazhy Kumykov <khazhy@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] blk: Fix lock inversion between ioc lock and bfqd lock
Date:   Fri, 28 May 2021 14:30:41 +0200
Message-Id: <20210528123041.29914-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210528123041.29914-1-jack@suse.cz>
References: <20210528123041.29914-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9355; h=from:subject; bh=1H2cPjtQSQvOADsPpoXe8J+1NjU6mWemJ63IRuXJgXM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBgsOJqgCh8GmMrcT4DME0Mw7/WDW8hykF3KpcCNzrx y1DHLY2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYLDiagAKCRCcnaoHP2RA2URaCA CFd9o+EyYC1HbD5Osk+wbtVkyT2dtJ577AtfaiaILEsYUSxkk+soE1brISft+brC2v54l8nR2Iji1f F5K+ebQzWhW9N+4KVW5p8/U9l11JqFUv7ChLhe2cT8CjfR0rEv874gUgzXkzc4aPbORUlaGf2H7xGD pw3B3Kj2DfcKYnuhgizVSryE5q8l0QIpYfUPAFPeWI2m5jPbywuS2ZGx9rLTcP85wwDtr/f2v6qqSJ /ObGqDeqqKKLwgD4o9Epqw3mzikuLWU9LNg2RrShti8KvY4R+TiBtkaDKFdoXPldg1Tnrl8Hrr9Mum vP1cKJs1klWa1HXcRT0VogNimtyuA3
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Lockdep complains about lock inversion between ioc->lock and bfqd->lock:

bfqd -> ioc:
 put_io_context+0x33/0x90 -> ioc->lock grabbed
 blk_mq_free_request+0x51/0x140
 blk_put_request+0xe/0x10
 blk_attempt_req_merge+0x1d/0x30
 elv_attempt_insert_merge+0x56/0xa0
 blk_mq_sched_try_insert_merge+0x4b/0x60
 bfq_insert_requests+0x9e/0x18c0 -> bfqd->lock grabbed
 blk_mq_sched_insert_requests+0xd6/0x2b0
 blk_mq_flush_plug_list+0x154/0x280
 blk_finish_plug+0x40/0x60
 ext4_writepages+0x696/0x1320
 do_writepages+0x1c/0x80
 __filemap_fdatawrite_range+0xd7/0x120
 sync_file_range+0xac/0xf0

ioc->bfqd:
 bfq_exit_icq+0xa3/0xe0 -> bfqd->lock grabbed
 put_io_context_active+0x78/0xb0 -> ioc->lock grabbed
 exit_io_context+0x48/0x50
 do_exit+0x7e9/0xdd0
 do_group_exit+0x54/0xc0

To avoid this inversion we change blk_mq_sched_try_insert_merge() to not
free the merged request but rather leave that upto the caller similarly
to blk_mq_sched_try_merge(). And in bfq_insert_requests() we make sure
to free all the merged requests after dropping bfqd->lock.

Fixes: aee69d78dec0 ("block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler")
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c      |  6 ++++--
 block/blk-merge.c        | 19 ++++++++-----------
 block/blk-mq-sched.c     |  5 +++--
 block/blk-mq-sched.h     |  3 ++-
 block/blk-mq.h           | 11 +++++++++++
 block/blk.h              |  2 +-
 block/elevator.c         | 11 ++++++++---
 block/mq-deadline.c      |  5 ++++-
 include/linux/elevator.h |  3 ++-
 9 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 50a29fdf51da..5e076396b588 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2317,9 +2317,9 @@ static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 
 	ret = blk_mq_sched_try_merge(q, bio, nr_segs, &free);
 
+	spin_unlock_irq(&bfqd->lock);
 	if (free)
 		blk_mq_free_request(free);
-	spin_unlock_irq(&bfqd->lock);
 
 	return ret;
 }
@@ -5933,14 +5933,16 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	struct bfq_queue *bfqq;
 	bool idle_timer_disabled = false;
 	unsigned int cmd_flags;
+	LIST_HEAD(free);
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	if (!cgroup_subsys_on_dfl(io_cgrp_subsys) && rq->bio)
 		bfqg_stats_update_legacy_io(q, rq);
 #endif
 	spin_lock_irq(&bfqd->lock);
-	if (blk_mq_sched_try_insert_merge(q, rq)) {
+	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
 		spin_unlock_irq(&bfqd->lock);
+		blk_mq_free_requests(&free);
 		return;
 	}
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 4d97fb6dd226..1398b52a24b4 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -846,18 +846,15 @@ static struct request *attempt_front_merge(struct request_queue *q,
 	return NULL;
 }
 
-int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
-			  struct request *next)
+/*
+ * Try to merge 'next' into 'rq'. Return true if the merge happened, false
+ * otherwise. The caller is responsible for freeing 'next' if the merge
+ * happened.
+ */
+bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
+			   struct request *next)
 {
-	struct request *free;
-
-	free = attempt_merge(q, rq, next);
-	if (free) {
-		blk_put_request(free);
-		return 1;
-	}
-
-	return 0;
+	return attempt_merge(q, rq, next);
 }
 
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 714e678f516a..bf0a3dec8226 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -400,9 +400,10 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 	return ret;
 }
 
-bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq)
+bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
+				   struct list_head *free)
 {
-	return rq_mergeable(rq) && elv_attempt_insert_merge(q, rq);
+	return rq_mergeable(rq) && elv_attempt_insert_merge(q, rq, free);
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
 
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 5b18ab915c65..8b70de4b8d23 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -11,7 +11,8 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **merged_request);
 bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs);
-bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq);
+bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
+				   struct list_head *free);
 void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx);
 void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 81a775171be7..20ef743a3ff6 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -301,6 +301,17 @@ static inline struct blk_plug *blk_mq_plug(struct request_queue *q,
 	return NULL;
 }
 
+/* Free all requests on the list */
+static inline void blk_mq_free_requests(struct list_head *list)
+{
+	while (!list_empty(list)) {
+		struct request *rq = list_entry_rq(list->next);
+
+		list_del_init(&rq->queuelist);
+		blk_mq_free_request(rq);
+	}
+}
+
 /*
  * For shared tag users, we track the number of currently active users
  * and attempt to provide a fair share of the tag depth for each of them.
diff --git a/block/blk.h b/block/blk.h
index 8b3591aee0a5..99ef4f7e7a70 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -225,7 +225,7 @@ ssize_t part_timeout_store(struct device *, struct device_attribute *,
 void __blk_queue_split(struct bio **bio, unsigned int *nr_segs);
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
-int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
+bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 				struct request *next);
 unsigned int blk_recalc_rq_segments(struct request *rq);
 void blk_rq_set_mixed_merge(struct request *rq);
diff --git a/block/elevator.c b/block/elevator.c
index 440699c28119..62e9c672da7c 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -350,9 +350,11 @@ enum elv_merge elv_merge(struct request_queue *q, struct request **req,
  * we can append 'rq' to an existing request, so we can throw 'rq' away
  * afterwards.
  *
- * Returns true if we merged, false otherwise
+ * Returns true if we merged, false otherwise. 'free' will contain all
+ * requests that need to be freed.
  */
-bool elv_attempt_insert_merge(struct request_queue *q, struct request *rq)
+bool elv_attempt_insert_merge(struct request_queue *q, struct request *rq,
+			      struct list_head *free)
 {
 	struct request *__rq;
 	bool ret;
@@ -363,8 +365,10 @@ bool elv_attempt_insert_merge(struct request_queue *q, struct request *rq)
 	/*
 	 * First try one-hit cache.
 	 */
-	if (q->last_merge && blk_attempt_req_merge(q, q->last_merge, rq))
+	if (q->last_merge && blk_attempt_req_merge(q, q->last_merge, rq)) {
+		list_add(&rq->queuelist, free);
 		return true;
+	}
 
 	if (blk_queue_noxmerges(q))
 		return false;
@@ -378,6 +382,7 @@ bool elv_attempt_insert_merge(struct request_queue *q, struct request *rq)
 		if (!__rq || !blk_attempt_req_merge(q, __rq, rq))
 			break;
 
+		list_add(&rq->queuelist, free);
 		/* The merged request could be merged with others, try again */
 		ret = true;
 		rq = __rq;
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 8eea2cbf2bf4..7136262819f1 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -487,6 +487,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const int data_dir = rq_data_dir(rq);
+	LIST_HEAD(free);
 
 	/*
 	 * This may be a requeue of a write request that has locked its
@@ -494,8 +495,10 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	 */
 	blk_req_zone_write_unlock(rq);
 
-	if (blk_mq_sched_try_insert_merge(q, rq))
+	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
+		blk_mq_free_requests(&free);
 		return;
+	}
 
 	trace_block_rq_insert(rq);
 
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index dcb2f9022c1d..1a5965174f5b 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -117,7 +117,8 @@ extern void elv_merge_requests(struct request_queue *, struct request *,
 			       struct request *);
 extern void elv_merged_request(struct request_queue *, struct request *,
 		enum elv_merge);
-extern bool elv_attempt_insert_merge(struct request_queue *, struct request *);
+extern bool elv_attempt_insert_merge(struct request_queue *, struct request *,
+				     struct list_head *);
 extern struct request *elv_former_request(struct request_queue *, struct request *);
 extern struct request *elv_latter_request(struct request_queue *, struct request *);
 
-- 
2.26.2

