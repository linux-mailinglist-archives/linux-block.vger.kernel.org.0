Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1553E96F6
	for <lists+linux-block@lfdr.de>; Wed, 11 Aug 2021 19:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhHKRmM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Aug 2021 13:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhHKRmL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 13:42:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A93C061765
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 10:41:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id nt11so4718362pjb.2
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZZZs1W/zfDc/tHiN7yIDMio4xg0kwJOmJiQzDNC4GXk=;
        b=e05ZjV1ol917aJw/mhuD8oAzOvEs0PSYyEwoitqn4u66fT/Og7e7FMKb87/NW2Cbn8
         biFqGsMFQ6dMX6vsZ6cyjmxcMxwCV1Cps6nqa/0oDxejj//B/exg0oIyY/TDLO2Sig+e
         BNP/tV0OcbWik/EqCDaYJ+fgS3tHvgn8ttigbHhH/8AiQbwbSKy7AFIebOsNyootEwZx
         gBf7cCNlPtO2RuilAMvPKxZh9YDBW/0+G6jkTh9bFXr6P9URRUOWZ5/ReQzxCM9tvicQ
         MXRfXaYnipOIx3Jq5bwmwqcnsqDD8zxywv4sxVpgrLkfL1q+RNBZBtTkg+L3iuW8cFqb
         h0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=ZZZs1W/zfDc/tHiN7yIDMio4xg0kwJOmJiQzDNC4GXk=;
        b=bp/F9FUqF6bKVdFKHQ4t2UM8gh5kuaWs9MOsCpaXbdyZS3HT9AiUtBUEfA63Yv5hAA
         QjTnHvMYyLlatUq23JP4tfWM3lvo4u3C6PM4+GdvRAlbVoMo7ZsccSJlH6ieIdqXImJp
         zFsRE6t1KbQ6AO5OK2deK3DdxBlPZEZVDAcwJLgQtigO67LuNOBhAuOCbJYpPy/trzFO
         r2s33oJTnB9zwKbSBmi6Zd4EmgvnLV1saqgy6mYyVdSRPm1HpWGOKFEQ9Y7s5WmaKDqp
         9zlw73NrOW8KLt/UWoSAOazXNX5ucvUIivN+Y5x/JrjxlqFueV68ckKwtEVsuxlLQhdS
         br8w==
X-Gm-Message-State: AOAM531iDJh8xAlNx2boh81jcuJPk/cMgMzcZo4XMn7lMtYZc7Nx24Cg
        +pawVpoIZxabTz/iZle/fv8=
X-Google-Smtp-Source: ABdhPJxiKi3zAIji1Gq15WM+64OC8Dkmxq+6psU1umjYUtKanmAjg1/jCHJFUrW9TIBjnAnU1sVmpg==
X-Received: by 2002:a62:36c5:0:b029:32b:83fa:3a3e with SMTP id d188-20020a6236c50000b029032b83fa3a3emr29733106pfa.52.1628703707114;
        Wed, 11 Aug 2021 10:41:47 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id k6sm7340354pjl.55.2021.08.11.10.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 10:41:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 11 Aug 2021 07:41:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
Message-ID: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From e150c6478e453fe27b5cf83ed5d03b7582b6d35e Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 11 Aug 2021 07:29:20 -1000

This reverts commit 08a9ad8bf607 ("block/mq-deadline: Add cgroup support")
and a follow-up commit c06bc5a3fb42 ("block/mq-deadline: Remove a
WARN_ON_ONCE() call"). The added cgroup support has the following issues:

* It breaks cgroup interface file format rule by adding custom elements to a
  nested key-value file.

* It registers mq-deadline as a cgroup-aware policy even though all it's
  doing is collecting per-cgroup stats. Even if we need these stats, this
  isn't the right way to add them.

* It hasn't been reviewed from cgroup side.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/Kconfig.iosched                       |   6 -
 block/Makefile                              |   2 -
 block/mq-deadline-cgroup.c                  | 126 --------------------
 block/mq-deadline-cgroup.h                  | 114 ------------------
 block/{mq-deadline-main.c => mq-deadline.c} |  73 +++---------
 5 files changed, 14 insertions(+), 307 deletions(-)
 delete mode 100644 block/mq-deadline-cgroup.c
 delete mode 100644 block/mq-deadline-cgroup.h
 rename block/{mq-deadline-main.c => mq-deadline.c} (95%)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 64053d67a97b7..2f2158e05a91c 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -9,12 +9,6 @@ config MQ_IOSCHED_DEADLINE
 	help
 	  MQ version of the deadline IO scheduler.
 
-config MQ_IOSCHED_DEADLINE_CGROUP
-       tristate
-       default y
-       depends on MQ_IOSCHED_DEADLINE
-       depends on BLK_CGROUP
-
 config MQ_IOSCHED_KYBER
 	tristate "Kyber I/O scheduler"
 	default y
diff --git a/block/Makefile b/block/Makefile
index bfbe4e13ca1ef..1e1afa10f869d 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -22,8 +22,6 @@ obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= blk-ioprio.o
 obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
 obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= blk-iocost.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
-mq-deadline-y += mq-deadline-main.o
-mq-deadline-$(CONFIG_MQ_IOSCHED_DEADLINE_CGROUP)+= mq-deadline-cgroup.o
 obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
 bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
 obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
diff --git a/block/mq-deadline-cgroup.c b/block/mq-deadline-cgroup.c
deleted file mode 100644
index 3b4bfddec39f3..0000000000000
--- a/block/mq-deadline-cgroup.c
+++ /dev/null
@@ -1,126 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/blk-cgroup.h>
-#include <linux/ioprio.h>
-
-#include "mq-deadline-cgroup.h"
-
-static struct blkcg_policy dd_blkcg_policy;
-
-static struct blkcg_policy_data *dd_cpd_alloc(gfp_t gfp)
-{
-	struct dd_blkcg *pd;
-
-	pd = kzalloc(sizeof(*pd), gfp);
-	if (!pd)
-		return NULL;
-	pd->stats = alloc_percpu_gfp(typeof(*pd->stats),
-				     GFP_KERNEL | __GFP_ZERO);
-	if (!pd->stats) {
-		kfree(pd);
-		return NULL;
-	}
-	return &pd->cpd;
-}
-
-static void dd_cpd_free(struct blkcg_policy_data *cpd)
-{
-	struct dd_blkcg *dd_blkcg = container_of(cpd, typeof(*dd_blkcg), cpd);
-
-	free_percpu(dd_blkcg->stats);
-	kfree(dd_blkcg);
-}
-
-static struct dd_blkcg *dd_blkcg_from_pd(struct blkg_policy_data *pd)
-{
-	return container_of(blkcg_to_cpd(pd->blkg->blkcg, &dd_blkcg_policy),
-			    struct dd_blkcg, cpd);
-}
-
-/*
- * Convert an association between a block cgroup and a request queue into a
- * pointer to the mq-deadline information associated with a (blkcg, queue) pair.
- */
-struct dd_blkcg *dd_blkcg_from_bio(struct bio *bio)
-{
-	struct blkg_policy_data *pd;
-
-	pd = blkg_to_pd(bio->bi_blkg, &dd_blkcg_policy);
-	if (!pd)
-		return NULL;
-
-	return dd_blkcg_from_pd(pd);
-}
-
-static size_t dd_pd_stat(struct blkg_policy_data *pd, char *buf, size_t size)
-{
-	static const char *const prio_class_name[] = {
-		[IOPRIO_CLASS_NONE]	= "NONE",
-		[IOPRIO_CLASS_RT]	= "RT",
-		[IOPRIO_CLASS_BE]	= "BE",
-		[IOPRIO_CLASS_IDLE]	= "IDLE",
-	};
-	struct dd_blkcg *blkcg = dd_blkcg_from_pd(pd);
-	int res = 0;
-	u8 prio;
-
-	for (prio = 0; prio < ARRAY_SIZE(blkcg->stats->stats); prio++)
-		res += scnprintf(buf + res, size - res,
-			" [%s] dispatched=%u inserted=%u merged=%u",
-			prio_class_name[prio],
-			ddcg_sum(blkcg, dispatched, prio) +
-			ddcg_sum(blkcg, merged, prio) -
-			ddcg_sum(blkcg, completed, prio),
-			ddcg_sum(blkcg, inserted, prio) -
-			ddcg_sum(blkcg, completed, prio),
-			ddcg_sum(blkcg, merged, prio));
-
-	return res;
-}
-
-static struct blkg_policy_data *dd_pd_alloc(gfp_t gfp, struct request_queue *q,
-					    struct blkcg *blkcg)
-{
-	struct dd_blkg *pd;
-
-	pd = kzalloc(sizeof(*pd), gfp);
-	if (!pd)
-		return NULL;
-	return &pd->pd;
-}
-
-static void dd_pd_free(struct blkg_policy_data *pd)
-{
-	struct dd_blkg *dd_blkg = container_of(pd, typeof(*dd_blkg), pd);
-
-	kfree(dd_blkg);
-}
-
-static struct blkcg_policy dd_blkcg_policy = {
-	.cpd_alloc_fn		= dd_cpd_alloc,
-	.cpd_free_fn		= dd_cpd_free,
-
-	.pd_alloc_fn		= dd_pd_alloc,
-	.pd_free_fn		= dd_pd_free,
-	.pd_stat_fn		= dd_pd_stat,
-};
-
-int dd_activate_policy(struct request_queue *q)
-{
-	return blkcg_activate_policy(q, &dd_blkcg_policy);
-}
-
-void dd_deactivate_policy(struct request_queue *q)
-{
-	blkcg_deactivate_policy(q, &dd_blkcg_policy);
-}
-
-int __init dd_blkcg_init(void)
-{
-	return blkcg_policy_register(&dd_blkcg_policy);
-}
-
-void __exit dd_blkcg_exit(void)
-{
-	blkcg_policy_unregister(&dd_blkcg_policy);
-}
diff --git a/block/mq-deadline-cgroup.h b/block/mq-deadline-cgroup.h
deleted file mode 100644
index 0143fd74f3cea..0000000000000
--- a/block/mq-deadline-cgroup.h
+++ /dev/null
@@ -1,114 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#if !defined(_MQ_DEADLINE_CGROUP_H_)
-#define _MQ_DEADLINE_CGROUP_H_
-
-#include <linux/blk-cgroup.h>
-
-struct request_queue;
-
-/**
- * struct io_stats_per_prio - I/O statistics per I/O priority class.
- * @inserted: Number of inserted requests.
- * @merged: Number of merged requests.
- * @dispatched: Number of dispatched requests.
- * @completed: Number of I/O completions.
- */
-struct io_stats_per_prio {
-	local_t inserted;
-	local_t merged;
-	local_t dispatched;
-	local_t completed;
-};
-
-/* I/O statistics per I/O cgroup per I/O priority class (IOPRIO_CLASS_*). */
-struct blkcg_io_stats {
-	struct io_stats_per_prio stats[4];
-};
-
-/**
- * struct dd_blkcg - Per cgroup data.
- * @cpd: blkcg_policy_data structure.
- * @stats: I/O statistics.
- */
-struct dd_blkcg {
-	struct blkcg_policy_data cpd;	/* must be the first member */
-	struct blkcg_io_stats __percpu *stats;
-};
-
-/*
- * Count one event of type 'event_type' and with I/O priority class
- * 'prio_class'.
- */
-#define ddcg_count(ddcg, event_type, prio_class) do {			\
-if (ddcg) {								\
-	struct blkcg_io_stats *io_stats = get_cpu_ptr((ddcg)->stats);	\
-									\
-	BUILD_BUG_ON(!__same_type((ddcg), struct dd_blkcg *));		\
-	BUILD_BUG_ON(!__same_type((prio_class), u8));			\
-	local_inc(&io_stats->stats[(prio_class)].event_type);		\
-	put_cpu_ptr(io_stats);						\
-}									\
-} while (0)
-
-/*
- * Returns the total number of ddcg_count(ddcg, event_type, prio_class) calls
- * across all CPUs. No locking or barriers since it is fine if the returned
- * sum is slightly outdated.
- */
-#define ddcg_sum(ddcg, event_type, prio) ({				\
-	unsigned int cpu;						\
-	u32 sum = 0;							\
-									\
-	BUILD_BUG_ON(!__same_type((ddcg), struct dd_blkcg *));		\
-	BUILD_BUG_ON(!__same_type((prio), u8));				\
-	for_each_present_cpu(cpu)					\
-		sum += local_read(&per_cpu_ptr((ddcg)->stats, cpu)->	\
-				  stats[(prio)].event_type);		\
-	sum;								\
-})
-
-#ifdef CONFIG_BLK_CGROUP
-
-/**
- * struct dd_blkg - Per (cgroup, request queue) data.
- * @pd: blkg_policy_data structure.
- */
-struct dd_blkg {
-	struct blkg_policy_data pd;	/* must be the first member */
-};
-
-struct dd_blkcg *dd_blkcg_from_bio(struct bio *bio);
-int dd_activate_policy(struct request_queue *q);
-void dd_deactivate_policy(struct request_queue *q);
-int __init dd_blkcg_init(void);
-void __exit dd_blkcg_exit(void);
-
-#else /* CONFIG_BLK_CGROUP */
-
-static inline struct dd_blkcg *dd_blkcg_from_bio(struct bio *bio)
-{
-	return NULL;
-}
-
-static inline int dd_activate_policy(struct request_queue *q)
-{
-	return 0;
-}
-
-static inline void dd_deactivate_policy(struct request_queue *q)
-{
-}
-
-static inline int dd_blkcg_init(void)
-{
-	return 0;
-}
-
-static inline void dd_blkcg_exit(void)
-{
-}
-
-#endif /* CONFIG_BLK_CGROUP */
-
-#endif /* _MQ_DEADLINE_CGROUP_H_ */
diff --git a/block/mq-deadline-main.c b/block/mq-deadline.c
similarity index 95%
rename from block/mq-deadline-main.c
rename to block/mq-deadline.c
index 6f612e6dc82b6..a09761cbdf12e 100644
--- a/block/mq-deadline-main.c
+++ b/block/mq-deadline.c
@@ -25,7 +25,6 @@
 #include "blk-mq-debugfs.h"
 #include "blk-mq-tag.h"
 #include "blk-mq-sched.h"
-#include "mq-deadline-cgroup.h"
 
 /*
  * See Documentation/block/deadline-iosched.rst
@@ -57,6 +56,14 @@ enum dd_prio {
 
 enum { DD_PRIO_COUNT = 3 };
 
+/* I/O statistics per I/O priority. */
+struct io_stats_per_prio {
+	local_t inserted;
+	local_t merged;
+	local_t dispatched;
+	local_t completed;
+};
+
 /* I/O statistics for all I/O priorities (enum dd_prio). */
 struct io_stats {
 	struct io_stats_per_prio stats[DD_PRIO_COUNT];
@@ -79,9 +86,6 @@ struct deadline_data {
 	 * run time data
 	 */
 
-	/* Request queue that owns this data structure. */
-	struct request_queue *queue;
-
 	struct dd_per_prio per_prio[DD_PRIO_COUNT];
 
 	/* Data direction of latest dispatched request. */
@@ -234,10 +238,8 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const u8 ioprio_class = dd_rq_ioclass(next);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
-	struct dd_blkcg *blkcg = next->elv.priv[0];
 
 	dd_count(dd, merged, prio);
-	ddcg_count(blkcg, merged, ioprio_class);
 
 	/*
 	 * if next expires before rq, assign its expire time to rq
@@ -375,7 +377,6 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 {
 	struct request *rq, *next_rq;
 	enum dd_data_dir data_dir;
-	struct dd_blkcg *blkcg;
 	enum dd_prio prio;
 	u8 ioprio_class;
 
@@ -474,8 +475,6 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	ioprio_class = dd_rq_ioclass(rq);
 	prio = ioprio_class_to_prio[ioprio_class];
 	dd_count(dd, dispatched, prio);
-	blkcg = rq->elv.priv[0];
-	ddcg_count(blkcg, dispatched, ioprio_class);
 	/*
 	 * If the request needs its target zone locked, do it.
 	 */
@@ -569,8 +568,6 @@ static void dd_exit_sched(struct elevator_queue *e)
 	struct deadline_data *dd = e->elevator_data;
 	enum dd_prio prio;
 
-	dd_deactivate_policy(dd->queue);
-
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
@@ -584,7 +581,7 @@ static void dd_exit_sched(struct elevator_queue *e)
 }
 
 /*
- * Initialize elevator private data (deadline_data) and associate with blkcg.
+ * initialize elevator private data (deadline_data).
  */
 static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 {
@@ -593,12 +590,6 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	enum dd_prio prio;
 	int ret = -ENOMEM;
 
-	/*
-	 * Initialization would be very tricky if the queue is not frozen,
-	 * hence the warning statement below.
-	 */
-	WARN_ON_ONCE(!percpu_ref_is_zero(&q->q_usage_counter));
-
 	eq = elevator_alloc(q, e);
 	if (!eq)
 		return ret;
@@ -614,8 +605,6 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	if (!dd->stats)
 		goto free_dd;
 
-	dd->queue = q;
-
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
@@ -635,17 +624,9 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	spin_lock_init(&dd->lock);
 	spin_lock_init(&dd->zone_lock);
 
-	ret = dd_activate_policy(q);
-	if (ret)
-		goto free_stats;
-
-	ret = 0;
 	q->elevator = eq;
 	return 0;
 
-free_stats:
-	free_percpu(dd->stats);
-
 free_dd:
 	kfree(dd);
 
@@ -718,7 +699,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
 	struct dd_per_prio *per_prio;
 	enum dd_prio prio;
-	struct dd_blkcg *blkcg;
 	LIST_HEAD(free);
 
 	lockdep_assert_held(&dd->lock);
@@ -729,18 +709,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	 */
 	blk_req_zone_write_unlock(rq);
 
-	/*
-	 * If a block cgroup has been associated with the submitter and if an
-	 * I/O priority has been set in the associated block cgroup, use the
-	 * lowest of the cgroup priority and the request priority for the
-	 * request. If no priority has been set in the request, use the cgroup
-	 * priority.
-	 */
 	prio = ioprio_class_to_prio[ioprio_class];
 	dd_count(dd, inserted, prio);
-	blkcg = dd_blkcg_from_bio(rq->bio);
-	ddcg_count(blkcg, inserted, ioprio_class);
-	rq->elv.priv[0] = blkcg;
 
 	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
 		blk_mq_free_requests(&free);
@@ -789,10 +759,12 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 	spin_unlock(&dd->lock);
 }
 
-/* Callback from inside blk_mq_rq_ctx_init(). */
+/*
+ * Nothing to do here. This is defined only to ensure that .finish_request
+ * method is called upon request completion.
+ */
 static void dd_prepare_request(struct request *rq)
 {
-	rq->elv.priv[0] = NULL;
 }
 
 /*
@@ -815,13 +787,11 @@ static void dd_finish_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	struct deadline_data *dd = q->elevator->elevator_data;
-	struct dd_blkcg *blkcg = rq->elv.priv[0];
 	const u8 ioprio_class = dd_rq_ioclass(rq);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
 	dd_count(dd, completed, prio);
-	ddcg_count(blkcg, completed, ioprio_class);
 
 	if (blk_queue_is_zoned(q)) {
 		unsigned long flags;
@@ -1144,26 +1114,11 @@ MODULE_ALIAS("mq-deadline-iosched");
 
 static int __init deadline_init(void)
 {
-	int ret;
-
-	ret = elv_register(&mq_deadline);
-	if (ret)
-		goto out;
-	ret = dd_blkcg_init();
-	if (ret)
-		goto unreg;
-
-out:
-	return ret;
-
-unreg:
-	elv_unregister(&mq_deadline);
-	goto out;
+	return elv_register(&mq_deadline);
 }
 
 static void __exit deadline_exit(void)
 {
-	dd_blkcg_exit();
 	elv_unregister(&mq_deadline);
 }
 
-- 
2.32.0

