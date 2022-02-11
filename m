Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C4B4B22DE
	for <lists+linux-block@lfdr.de>; Fri, 11 Feb 2022 11:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiBKKMz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Feb 2022 05:12:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245387AbiBKKMx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 05:12:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5968B38
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 02:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644574370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OCznZB9XUEaL51A9sQsnkkI9WGbFaGVnbKslc/GJPyU=;
        b=fdkF9TaDMBclMmPL8gTkw3lQtNMEmhxIHQTfZv8Cq8harqkzSNn+hJfEuZH8MTwbJaUc7U
        Zl4BNxVVpvOge+gBR5YALCzAZ5oG1r56Sz6LhEIuv5M4vMZjt4O62HXULBKvHIogcB8LnB
        FfRkY5D+ePzKfcPa5dfihmevCafYZ1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-dCcmW5zYOCCJwMLEAptIFQ-1; Fri, 11 Feb 2022 05:12:48 -0500
X-MC-Unique: dCcmW5zYOCCJwMLEAptIFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48C56189DF41;
        Fri, 11 Feb 2022 10:12:47 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96B121057F7C;
        Fri, 11 Feb 2022 10:12:45 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] block: partition include/linux/blk-cgroup.h
Date:   Fri, 11 Feb 2022 18:11:49 +0800
Message-Id: <20220211101149.2368042-4-ming.lei@redhat.com>
In-Reply-To: <20220211101149.2368042-1-ming.lei@redhat.com>
References: <20220211101149.2368042-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Partition include/linux/blk-cgroup.h into two parts: one is public part,
the other is block layer private part.

Suggested by Christoph Hellwig.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bfq-iosched.h         |   1 -
 block/bio.c                 |   2 +-
 block/blk-cgroup-rwstat.h   |   2 +-
 block/blk-cgroup.c          |   2 +-
 block/blk-cgroup.h          | 477 ++++++++++++++++++++++++++++++++++++
 block/blk-core.c            |   2 +-
 block/blk-crypto-fallback.c |   2 +-
 block/blk-iocost.c          |   2 +-
 block/blk-iolatency.c       |   2 +-
 block/blk-ioprio.c          |   2 +-
 block/blk-sysfs.c           |   2 +-
 block/blk-throttle.c        |   1 -
 block/bounce.c              |   2 +-
 block/elevator.c            |   2 +-
 include/linux/blk-cgroup.h  | 459 +---------------------------------
 15 files changed, 493 insertions(+), 467 deletions(-)
 create mode 100644 block/blk-cgroup.h

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 07288b9da389..72255ec44f8f 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -8,7 +8,6 @@
 
 #include <linux/blktrace_api.h>
 #include <linux/hrtimer.h>
-#include <linux/blk-cgroup.h>
 
 #include "blk-cgroup-rwstat.h"
 
diff --git a/block/bio.c b/block/bio.c
index 18d34b33351b..b15f5466ce08 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -15,7 +15,6 @@
 #include <linux/mempool.h>
 #include <linux/workqueue.h>
 #include <linux/cgroup.h>
-#include <linux/blk-cgroup.h>
 #include <linux/highmem.h>
 #include <linux/sched/sysctl.h>
 #include <linux/blk-crypto.h>
@@ -24,6 +23,7 @@
 #include <trace/events/block.h>
 #include "blk.h"
 #include "blk-rq-qos.h"
+#include "blk-cgroup.h"
 
 struct bio_alloc_cache {
 	struct bio		*free_list;
diff --git a/block/blk-cgroup-rwstat.h b/block/blk-cgroup-rwstat.h
index ee746919c41f..9f2723b34b75 100644
--- a/block/blk-cgroup-rwstat.h
+++ b/block/blk-cgroup-rwstat.h
@@ -6,7 +6,7 @@
 #ifndef _BLK_CGROUP_RWSTAT_H
 #define _BLK_CGROUP_RWSTAT_H
 
-#include <linux/blk-cgroup.h>
+#include "blk-cgroup.h"
 
 enum blkg_rwstat_type {
 	BLKG_RWSTAT_READ,
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 35deaceba1f0..4108d445c73a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -26,11 +26,11 @@
 #include <linux/delay.h>
 #include <linux/atomic.h>
 #include <linux/ctype.h>
-#include <linux/blk-cgroup.h>
 #include <linux/tracehook.h>
 #include <linux/psi.h>
 #include <linux/part_stat.h>
 #include "blk.h"
+#include "blk-cgroup.h"
 #include "blk-ioprio.h"
 #include "blk-throttle.h"
 
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
new file mode 100644
index 000000000000..3e91803c4a55
--- /dev/null
+++ b/block/blk-cgroup.h
@@ -0,0 +1,477 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BLK_CGROUP_PRIVATE_H
+#define _BLK_CGROUP_PRIVATE_H
+/*
+ * block cgroup private header
+ *
+ * Based on ideas and code from CFQ, CFS and BFQ:
+ * Copyright (C) 2003 Jens Axboe <axboe@kernel.dk>
+ *
+ * Copyright (C) 2008 Fabio Checconi <fabio@gandalf.sssup.it>
+ *		      Paolo Valente <paolo.valente@unimore.it>
+ *
+ * Copyright (C) 2009 Vivek Goyal <vgoyal@redhat.com>
+ * 	              Nauman Rafique <nauman@google.com>
+ */
+
+#include <linux/blk-cgroup.h>
+
+/* percpu_counter batch for blkg_[rw]stats, per-cpu drift doesn't matter */
+#define BLKG_STAT_CPU_BATCH	(INT_MAX / 2)
+
+#ifdef CONFIG_BLK_CGROUP
+
+/*
+ * A blkcg_gq (blkg) is association between a block cgroup (blkcg) and a
+ * request_queue (q).  This is used by blkcg policies which need to track
+ * information per blkcg - q pair.
+ *
+ * There can be multiple active blkcg policies and each blkg:policy pair is
+ * represented by a blkg_policy_data which is allocated and freed by each
+ * policy's pd_alloc/free_fn() methods.  A policy can allocate private data
+ * area by allocating larger data structure which embeds blkg_policy_data
+ * at the beginning.
+ */
+struct blkg_policy_data {
+	/* the blkg and policy id this per-policy data belongs to */
+	struct blkcg_gq			*blkg;
+	int				plid;
+};
+
+/*
+ * Policies that need to keep per-blkcg data which is independent from any
+ * request_queue associated to it should implement cpd_alloc/free_fn()
+ * methods.  A policy can allocate private data area by allocating larger
+ * data structure which embeds blkcg_policy_data at the beginning.
+ * cpd_init() is invoked to let each policy handle per-blkcg data.
+ */
+struct blkcg_policy_data {
+	/* the blkcg and policy id this per-policy data belongs to */
+	struct blkcg			*blkcg;
+	int				plid;
+};
+
+typedef struct blkcg_policy_data *(blkcg_pol_alloc_cpd_fn)(gfp_t gfp);
+typedef void (blkcg_pol_init_cpd_fn)(struct blkcg_policy_data *cpd);
+typedef void (blkcg_pol_free_cpd_fn)(struct blkcg_policy_data *cpd);
+typedef void (blkcg_pol_bind_cpd_fn)(struct blkcg_policy_data *cpd);
+typedef struct blkg_policy_data *(blkcg_pol_alloc_pd_fn)(gfp_t gfp,
+				struct request_queue *q, struct blkcg *blkcg);
+typedef void (blkcg_pol_init_pd_fn)(struct blkg_policy_data *pd);
+typedef void (blkcg_pol_online_pd_fn)(struct blkg_policy_data *pd);
+typedef void (blkcg_pol_offline_pd_fn)(struct blkg_policy_data *pd);
+typedef void (blkcg_pol_free_pd_fn)(struct blkg_policy_data *pd);
+typedef void (blkcg_pol_reset_pd_stats_fn)(struct blkg_policy_data *pd);
+typedef bool (blkcg_pol_stat_pd_fn)(struct blkg_policy_data *pd,
+				struct seq_file *s);
+
+struct blkcg_policy {
+	int				plid;
+	/* cgroup files for the policy */
+	struct cftype			*dfl_cftypes;
+	struct cftype			*legacy_cftypes;
+
+	/* operations */
+	blkcg_pol_alloc_cpd_fn		*cpd_alloc_fn;
+	blkcg_pol_init_cpd_fn		*cpd_init_fn;
+	blkcg_pol_free_cpd_fn		*cpd_free_fn;
+	blkcg_pol_bind_cpd_fn		*cpd_bind_fn;
+
+	blkcg_pol_alloc_pd_fn		*pd_alloc_fn;
+	blkcg_pol_init_pd_fn		*pd_init_fn;
+	blkcg_pol_online_pd_fn		*pd_online_fn;
+	blkcg_pol_offline_pd_fn		*pd_offline_fn;
+	blkcg_pol_free_pd_fn		*pd_free_fn;
+	blkcg_pol_reset_pd_stats_fn	*pd_reset_stats_fn;
+	blkcg_pol_stat_pd_fn		*pd_stat_fn;
+};
+
+extern struct blkcg blkcg_root;
+extern bool blkcg_debug_stats;
+
+struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
+				      struct request_queue *q, bool update_hint);
+int blkcg_init_queue(struct request_queue *q);
+void blkcg_exit_queue(struct request_queue *q);
+
+/* Blkio controller policy registration */
+int blkcg_policy_register(struct blkcg_policy *pol);
+void blkcg_policy_unregister(struct blkcg_policy *pol);
+int blkcg_activate_policy(struct request_queue *q,
+			  const struct blkcg_policy *pol);
+void blkcg_deactivate_policy(struct request_queue *q,
+			     const struct blkcg_policy *pol);
+
+const char *blkg_dev_name(struct blkcg_gq *blkg);
+void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
+		       u64 (*prfill)(struct seq_file *,
+				     struct blkg_policy_data *, int),
+		       const struct blkcg_policy *pol, int data,
+		       bool show_total);
+u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v);
+
+struct blkg_conf_ctx {
+	struct block_device		*bdev;
+	struct blkcg_gq			*blkg;
+	char				*body;
+};
+
+struct block_device *blkcg_conf_open_bdev(char **inputp);
+int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
+		   char *input, struct blkg_conf_ctx *ctx);
+void blkg_conf_finish(struct blkg_conf_ctx *ctx);
+
+/**
+ * blkcg_css - find the current css
+ *
+ * Find the css associated with either the kthread or the current task.
+ * This may return a dying css, so it is up to the caller to use tryget logic
+ * to confirm it is alive and well.
+ */
+static inline struct cgroup_subsys_state *blkcg_css(void)
+{
+	struct cgroup_subsys_state *css;
+
+	css = kthread_blkcg();
+	if (css)
+		return css;
+	return task_css(current, io_cgrp_id);
+}
+
+/**
+ * __bio_blkcg - internal, inconsistent version to get blkcg
+ *
+ * DO NOT USE.
+ * This function is inconsistent and consequently is dangerous to use.  The
+ * first part of the function returns a blkcg where a reference is owned by the
+ * bio.  This means it does not need to be rcu protected as it cannot go away
+ * with the bio owning a reference to it.  However, the latter potentially gets
+ * it from task_css().  This can race against task migration and the cgroup
+ * dying.  It is also semantically different as it must be called rcu protected
+ * and is susceptible to failure when trying to get a reference to it.
+ * Therefore, it is not ok to assume that *_get() will always succeed on the
+ * blkcg returned here.
+ */
+static inline struct blkcg *__bio_blkcg(struct bio *bio)
+{
+	if (bio && bio->bi_blkg)
+		return bio->bi_blkg->blkcg;
+	return css_to_blkcg(blkcg_css());
+}
+
+/**
+ * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
+ * @return: true if this bio needs to be submitted with the root blkg context.
+ *
+ * In order to avoid priority inversions we sometimes need to issue a bio as if
+ * it were attached to the root blkg, and then backcharge to the actual owning
+ * blkg.  The idea is we do bio_blkcg() to look up the actual context for the
+ * bio and attach the appropriate blkg to the bio.  Then we call this helper and
+ * if it is true run with the root blkg for that queue and then do any
+ * backcharging to the originating cgroup once the io is complete.
+ */
+static inline bool bio_issue_as_root_blkg(struct bio *bio)
+{
+	return (bio->bi_opf & (REQ_META | REQ_SWAP)) != 0;
+}
+
+/**
+ * __blkg_lookup - internal version of blkg_lookup()
+ * @blkcg: blkcg of interest
+ * @q: request_queue of interest
+ * @update_hint: whether to update lookup hint with the result or not
+ *
+ * This is internal version and shouldn't be used by policy
+ * implementations.  Looks up blkgs for the @blkcg - @q pair regardless of
+ * @q's bypass state.  If @update_hint is %true, the caller should be
+ * holding @q->queue_lock and lookup hint is updated on success.
+ */
+static inline struct blkcg_gq *__blkg_lookup(struct blkcg *blkcg,
+					     struct request_queue *q,
+					     bool update_hint)
+{
+	struct blkcg_gq *blkg;
+
+	if (blkcg == &blkcg_root)
+		return q->root_blkg;
+
+	blkg = rcu_dereference(blkcg->blkg_hint);
+	if (blkg && blkg->q == q)
+		return blkg;
+
+	return blkg_lookup_slowpath(blkcg, q, update_hint);
+}
+
+/**
+ * blkg_lookup - lookup blkg for the specified blkcg - q pair
+ * @blkcg: blkcg of interest
+ * @q: request_queue of interest
+ *
+ * Lookup blkg for the @blkcg - @q pair.  This function should be called
+ * under RCU read lock.
+ */
+static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
+					   struct request_queue *q)
+{
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	return __blkg_lookup(blkcg, q, false);
+}
+
+/**
+ * blk_queue_root_blkg - return blkg for the (blkcg_root, @q) pair
+ * @q: request_queue of interest
+ *
+ * Lookup blkg for @q at the root level. See also blkg_lookup().
+ */
+static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
+{
+	return q->root_blkg;
+}
+
+/**
+ * blkg_to_pdata - get policy private data
+ * @blkg: blkg of interest
+ * @pol: policy of interest
+ *
+ * Return pointer to private data associated with the @blkg-@pol pair.
+ */
+static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
+						  struct blkcg_policy *pol)
+{
+	return blkg ? blkg->pd[pol->plid] : NULL;
+}
+
+static inline struct blkcg_policy_data *blkcg_to_cpd(struct blkcg *blkcg,
+						     struct blkcg_policy *pol)
+{
+	return blkcg ? blkcg->cpd[pol->plid] : NULL;
+}
+
+/**
+ * pdata_to_blkg - get blkg associated with policy private data
+ * @pd: policy private data of interest
+ *
+ * @pd is policy private data.  Determine the blkg it's associated with.
+ */
+static inline struct blkcg_gq *pd_to_blkg(struct blkg_policy_data *pd)
+{
+	return pd ? pd->blkg : NULL;
+}
+
+static inline struct blkcg *cpd_to_blkcg(struct blkcg_policy_data *cpd)
+{
+	return cpd ? cpd->blkcg : NULL;
+}
+
+/**
+ * blkg_path - format cgroup path of blkg
+ * @blkg: blkg of interest
+ * @buf: target buffer
+ * @buflen: target buffer length
+ *
+ * Format the path of the cgroup of @blkg into @buf.
+ */
+static inline int blkg_path(struct blkcg_gq *blkg, char *buf, int buflen)
+{
+	return cgroup_path(blkg->blkcg->css.cgroup, buf, buflen);
+}
+
+/**
+ * blkg_get - get a blkg reference
+ * @blkg: blkg to get
+ *
+ * The caller should be holding an existing reference.
+ */
+static inline void blkg_get(struct blkcg_gq *blkg)
+{
+	percpu_ref_get(&blkg->refcnt);
+}
+
+/**
+ * blkg_tryget - try and get a blkg reference
+ * @blkg: blkg to get
+ *
+ * This is for use when doing an RCU lookup of the blkg.  We may be in the midst
+ * of freeing this blkg, so we can only use it if the refcnt is not zero.
+ */
+static inline bool blkg_tryget(struct blkcg_gq *blkg)
+{
+	return blkg && percpu_ref_tryget(&blkg->refcnt);
+}
+
+/**
+ * blkg_put - put a blkg reference
+ * @blkg: blkg to put
+ */
+static inline void blkg_put(struct blkcg_gq *blkg)
+{
+	percpu_ref_put(&blkg->refcnt);
+}
+
+/**
+ * blkg_for_each_descendant_pre - pre-order walk of a blkg's descendants
+ * @d_blkg: loop cursor pointing to the current descendant
+ * @pos_css: used for iteration
+ * @p_blkg: target blkg to walk descendants of
+ *
+ * Walk @c_blkg through the descendants of @p_blkg.  Must be used with RCU
+ * read locked.  If called under either blkcg or queue lock, the iteration
+ * is guaranteed to include all and only online blkgs.  The caller may
+ * update @pos_css by calling css_rightmost_descendant() to skip subtree.
+ * @p_blkg is included in the iteration and the first node to be visited.
+ */
+#define blkg_for_each_descendant_pre(d_blkg, pos_css, p_blkg)		\
+	css_for_each_descendant_pre((pos_css), &(p_blkg)->blkcg->css)	\
+		if (((d_blkg) = __blkg_lookup(css_to_blkcg(pos_css),	\
+					      (p_blkg)->q, false)))
+
+/**
+ * blkg_for_each_descendant_post - post-order walk of a blkg's descendants
+ * @d_blkg: loop cursor pointing to the current descendant
+ * @pos_css: used for iteration
+ * @p_blkg: target blkg to walk descendants of
+ *
+ * Similar to blkg_for_each_descendant_pre() but performs post-order
+ * traversal instead.  Synchronization rules are the same.  @p_blkg is
+ * included in the iteration and the last node to be visited.
+ */
+#define blkg_for_each_descendant_post(d_blkg, pos_css, p_blkg)		\
+	css_for_each_descendant_post((pos_css), &(p_blkg)->blkcg->css)	\
+		if (((d_blkg) = __blkg_lookup(css_to_blkcg(pos_css),	\
+					      (p_blkg)->q, false)))
+
+bool __blkcg_punt_bio_submit(struct bio *bio);
+
+static inline bool blkcg_punt_bio_submit(struct bio *bio)
+{
+	if (bio->bi_opf & REQ_CGROUP_PUNT)
+		return __blkcg_punt_bio_submit(bio);
+	else
+		return false;
+}
+
+static inline void blkcg_bio_issue_init(struct bio *bio)
+{
+	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
+}
+
+static inline void blkcg_use_delay(struct blkcg_gq *blkg)
+{
+	if (WARN_ON_ONCE(atomic_read(&blkg->use_delay) < 0))
+		return;
+	if (atomic_add_return(1, &blkg->use_delay) == 1)
+		atomic_inc(&blkg->blkcg->css.cgroup->congestion_count);
+}
+
+static inline int blkcg_unuse_delay(struct blkcg_gq *blkg)
+{
+	int old = atomic_read(&blkg->use_delay);
+
+	if (WARN_ON_ONCE(old < 0))
+		return 0;
+	if (old == 0)
+		return 0;
+
+	/*
+	 * We do this song and dance because we can race with somebody else
+	 * adding or removing delay.  If we just did an atomic_dec we'd end up
+	 * negative and we'd already be in trouble.  We need to subtract 1 and
+	 * then check to see if we were the last delay so we can drop the
+	 * congestion count on the cgroup.
+	 */
+	while (old) {
+		int cur = atomic_cmpxchg(&blkg->use_delay, old, old - 1);
+		if (cur == old)
+			break;
+		old = cur;
+	}
+
+	if (old == 0)
+		return 0;
+	if (old == 1)
+		atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
+	return 1;
+}
+
+/**
+ * blkcg_set_delay - Enable allocator delay mechanism with the specified delay amount
+ * @blkg: target blkg
+ * @delay: delay duration in nsecs
+ *
+ * When enabled with this function, the delay is not decayed and must be
+ * explicitly cleared with blkcg_clear_delay(). Must not be mixed with
+ * blkcg_[un]use_delay() and blkcg_add_delay() usages.
+ */
+static inline void blkcg_set_delay(struct blkcg_gq *blkg, u64 delay)
+{
+	int old = atomic_read(&blkg->use_delay);
+
+	/* We only want 1 person setting the congestion count for this blkg. */
+	if (!old && atomic_cmpxchg(&blkg->use_delay, old, -1) == old)
+		atomic_inc(&blkg->blkcg->css.cgroup->congestion_count);
+
+	atomic64_set(&blkg->delay_nsec, delay);
+}
+
+/**
+ * blkcg_clear_delay - Disable allocator delay mechanism
+ * @blkg: target blkg
+ *
+ * Disable use_delay mechanism. See blkcg_set_delay().
+ */
+static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
+{
+	int old = atomic_read(&blkg->use_delay);
+
+	/* We only want 1 person clearing the congestion count for this blkg. */
+	if (old && atomic_cmpxchg(&blkg->use_delay, old, 0) == old)
+		atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
+}
+
+void blk_cgroup_bio_start(struct bio *bio);
+void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
+#else	/* CONFIG_BLK_CGROUP */
+
+struct blkg_policy_data {
+};
+
+struct blkcg_policy_data {
+};
+
+struct blkcg_policy {
+};
+
+#ifdef CONFIG_BLOCK
+
+static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
+static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
+{ return NULL; }
+static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
+static inline void blkcg_exit_queue(struct request_queue *q) { }
+static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
+static inline void blkcg_policy_unregister(struct blkcg_policy *pol) { }
+static inline int blkcg_activate_policy(struct request_queue *q,
+					const struct blkcg_policy *pol) { return 0; }
+static inline void blkcg_deactivate_policy(struct request_queue *q,
+					   const struct blkcg_policy *pol) { }
+
+static inline struct blkcg *__bio_blkcg(struct bio *bio) { return NULL; }
+
+static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
+						  struct blkcg_policy *pol) { return NULL; }
+static inline struct blkcg_gq *pd_to_blkg(struct blkg_policy_data *pd) { return NULL; }
+static inline char *blkg_path(struct blkcg_gq *blkg) { return NULL; }
+static inline void blkg_get(struct blkcg_gq *blkg) { }
+static inline void blkg_put(struct blkcg_gq *blkg) { }
+
+static inline bool blkcg_punt_bio_submit(struct bio *bio) { return false; }
+static inline void blkcg_bio_issue_init(struct bio *bio) { }
+static inline void blk_cgroup_bio_start(struct bio *bio) { }
+
+#define blk_queue_for_each_rl(rl, q)	\
+	for ((rl) = &(q)->root_rl; (rl); (rl) = NULL)
+
+#endif	/* CONFIG_BLOCK */
+#endif	/* CONFIG_BLK_CGROUP */
+
+#endif /* _BLK_CGROUP_PRIVATE_H */
diff --git a/block/blk-core.c b/block/blk-core.c
index ff972b968f25..5a4a59041629 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -34,7 +34,6 @@
 #include <linux/delay.h>
 #include <linux/ratelimit.h>
 #include <linux/pm_runtime.h>
-#include <linux/blk-cgroup.h>
 #include <linux/t10-pi.h>
 #include <linux/debugfs.h>
 #include <linux/bpf.h>
@@ -49,6 +48,7 @@
 #include "blk.h"
 #include "blk-mq-sched.h"
 #include "blk-pm.h"
+#include "blk-cgroup.h"
 #include "blk-throttle.h"
 
 struct dentry *blk_debugfs_root;
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index c87aba8584c6..18c8eafe20b9 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -10,7 +10,6 @@
 #define pr_fmt(fmt) "blk-crypto-fallback: " fmt
 
 #include <crypto/skcipher.h>
-#include <linux/blk-cgroup.h>
 #include <linux/blk-crypto.h>
 #include <linux/blk-crypto-profile.h>
 #include <linux/blkdev.h>
@@ -20,6 +19,7 @@
 #include <linux/random.h>
 #include <linux/scatterlist.h>
 
+#include "blk-cgroup.h"
 #include "blk-crypto-internal.h"
 
 static unsigned int num_prealloc_bounce_pg = 32;
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 769b64394298..70a0a3d680a3 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -178,12 +178,12 @@
 #include <linux/time64.h>
 #include <linux/parser.h>
 #include <linux/sched/signal.h>
-#include <linux/blk-cgroup.h>
 #include <asm/local.h>
 #include <asm/local64.h>
 #include "blk-rq-qos.h"
 #include "blk-stat.h"
 #include "blk-wbt.h"
+#include "blk-cgroup.h"
 
 #ifdef CONFIG_TRACEPOINTS
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 6593c7123b97..010e658d44a8 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -74,9 +74,9 @@
 #include <linux/sched/signal.h>
 #include <trace/events/block.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-cgroup.h>
 #include "blk-rq-qos.h"
 #include "blk-stat.h"
+#include "blk-cgroup.h"
 #include "blk.h"
 
 #define DEFAULT_SCALE_COOKIE 1000000U
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 2e7f10e1c03f..79e797f5d194 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -12,11 +12,11 @@
  *   Documentation/admin-guide/cgroup-v2.rst.
  */
 
-#include <linux/blk-cgroup.h>
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include "blk-cgroup.h"
 #include "blk-ioprio.h"
 #include "blk-rq-qos.h"
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9f32882ceb2f..4c6b7dff71e5 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -10,7 +10,6 @@
 #include <linux/backing-dev.h>
 #include <linux/blktrace_api.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-cgroup.h>
 #include <linux/debugfs.h>
 
 #include "blk.h"
@@ -18,6 +17,7 @@
 #include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
 #include "blk-wbt.h"
+#include "blk-cgroup.h"
 #include "blk-throttle.h"
 
 struct queue_sysfs_entry {
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7c462c006b26..73640d80e99e 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -10,7 +10,6 @@
 #include <linux/blkdev.h>
 #include <linux/bio.h>
 #include <linux/blktrace_api.h>
-#include <linux/blk-cgroup.h>
 #include "blk.h"
 #include "blk-cgroup-rwstat.h"
 #include "blk-stat.h"
diff --git a/block/bounce.c b/block/bounce.c
index 3fd3bc6fd5db..3d50d19cde72 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -14,7 +14,6 @@
 #include <linux/pagemap.h>
 #include <linux/mempool.h>
 #include <linux/blkdev.h>
-#include <linux/blk-cgroup.h>
 #include <linux/backing-dev.h>
 #include <linux/init.h>
 #include <linux/hash.h>
@@ -24,6 +23,7 @@
 
 #include <trace/events/block.h>
 #include "blk.h"
+#include "blk-cgroup.h"
 
 #define POOL_SIZE	64
 #define ISA_POOL_SIZE	16
diff --git a/block/elevator.c b/block/elevator.c
index ec98aed39c4f..6847ab6e7aa5 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -35,7 +35,6 @@
 #include <linux/hash.h>
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
-#include <linux/blk-cgroup.h>
 
 #include <trace/events/block.h>
 
@@ -44,6 +43,7 @@
 #include "blk-mq-sched.h"
 #include "blk-pm.h"
 #include "blk-wbt.h"
+#include "blk-cgroup.h"
 
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index bdc49bd4eef0..f2ad8ed8f777 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -25,12 +25,8 @@
 #include <linux/kthread.h>
 #include <linux/fs.h>
 
-/* percpu_counter batch for blkg_[rw]stats, per-cpu drift doesn't matter */
-#define BLKG_STAT_CPU_BATCH	(INT_MAX / 2)
-
 #define FC_APPID_LEN              129
 
-
 #ifdef CONFIG_BLK_CGROUP
 
 enum blkg_iostat_type {
@@ -42,6 +38,7 @@ enum blkg_iostat_type {
 };
 
 struct blkcg_gq;
+struct blkg_policy_data;
 
 struct blkcg {
 	struct cgroup_subsys_state	css;
@@ -74,36 +71,6 @@ struct blkg_iostat_set {
 	struct blkg_iostat		last;
 };
 
-/*
- * A blkcg_gq (blkg) is association between a block cgroup (blkcg) and a
- * request_queue (q).  This is used by blkcg policies which need to track
- * information per blkcg - q pair.
- *
- * There can be multiple active blkcg policies and each blkg:policy pair is
- * represented by a blkg_policy_data which is allocated and freed by each
- * policy's pd_alloc/free_fn() methods.  A policy can allocate private data
- * area by allocating larger data structure which embeds blkg_policy_data
- * at the beginning.
- */
-struct blkg_policy_data {
-	/* the blkg and policy id this per-policy data belongs to */
-	struct blkcg_gq			*blkg;
-	int				plid;
-};
-
-/*
- * Policies that need to keep per-blkcg data which is independent from any
- * request_queue associated to it should implement cpd_alloc/free_fn()
- * methods.  A policy can allocate private data area by allocating larger
- * data structure which embeds blkcg_policy_data at the beginning.
- * cpd_init() is invoked to let each policy handle per-blkcg data.
- */
-struct blkcg_policy_data {
-	/* the blkcg and policy id this per-policy data belongs to */
-	struct blkcg			*blkcg;
-	int				plid;
-};
-
 /* association between a blk cgroup and a request queue */
 struct blkcg_gq {
 	/* Pointer to the associated request_queue */
@@ -139,120 +106,17 @@ struct blkcg_gq {
 	struct rcu_head			rcu_head;
 };
 
-typedef struct blkcg_policy_data *(blkcg_pol_alloc_cpd_fn)(gfp_t gfp);
-typedef void (blkcg_pol_init_cpd_fn)(struct blkcg_policy_data *cpd);
-typedef void (blkcg_pol_free_cpd_fn)(struct blkcg_policy_data *cpd);
-typedef void (blkcg_pol_bind_cpd_fn)(struct blkcg_policy_data *cpd);
-typedef struct blkg_policy_data *(blkcg_pol_alloc_pd_fn)(gfp_t gfp,
-				struct request_queue *q, struct blkcg *blkcg);
-typedef void (blkcg_pol_init_pd_fn)(struct blkg_policy_data *pd);
-typedef void (blkcg_pol_online_pd_fn)(struct blkg_policy_data *pd);
-typedef void (blkcg_pol_offline_pd_fn)(struct blkg_policy_data *pd);
-typedef void (blkcg_pol_free_pd_fn)(struct blkg_policy_data *pd);
-typedef void (blkcg_pol_reset_pd_stats_fn)(struct blkg_policy_data *pd);
-typedef bool (blkcg_pol_stat_pd_fn)(struct blkg_policy_data *pd,
-				struct seq_file *s);
-
-struct blkcg_policy {
-	int				plid;
-	/* cgroup files for the policy */
-	struct cftype			*dfl_cftypes;
-	struct cftype			*legacy_cftypes;
-
-	/* operations */
-	blkcg_pol_alloc_cpd_fn		*cpd_alloc_fn;
-	blkcg_pol_init_cpd_fn		*cpd_init_fn;
-	blkcg_pol_free_cpd_fn		*cpd_free_fn;
-	blkcg_pol_bind_cpd_fn		*cpd_bind_fn;
-
-	blkcg_pol_alloc_pd_fn		*pd_alloc_fn;
-	blkcg_pol_init_pd_fn		*pd_init_fn;
-	blkcg_pol_online_pd_fn		*pd_online_fn;
-	blkcg_pol_offline_pd_fn		*pd_offline_fn;
-	blkcg_pol_free_pd_fn		*pd_free_fn;
-	blkcg_pol_reset_pd_stats_fn	*pd_reset_stats_fn;
-	blkcg_pol_stat_pd_fn		*pd_stat_fn;
-};
-
-extern struct blkcg blkcg_root;
 extern struct cgroup_subsys_state * const blkcg_root_css;
-extern bool blkcg_debug_stats;
-
-struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
-				      struct request_queue *q, bool update_hint);
-int blkcg_init_queue(struct request_queue *q);
-void blkcg_exit_queue(struct request_queue *q);
-
-/* Blkio controller policy registration */
-int blkcg_policy_register(struct blkcg_policy *pol);
-void blkcg_policy_unregister(struct blkcg_policy *pol);
-int blkcg_activate_policy(struct request_queue *q,
-			  const struct blkcg_policy *pol);
-void blkcg_deactivate_policy(struct request_queue *q,
-			     const struct blkcg_policy *pol);
-
-const char *blkg_dev_name(struct blkcg_gq *blkg);
-void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
-		       u64 (*prfill)(struct seq_file *,
-				     struct blkg_policy_data *, int),
-		       const struct blkcg_policy *pol, int data,
-		       bool show_total);
-u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v);
-
-struct blkg_conf_ctx {
-	struct block_device		*bdev;
-	struct blkcg_gq			*blkg;
-	char				*body;
-};
-
-struct block_device *blkcg_conf_open_bdev(char **inputp);
-int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
-		   char *input, struct blkg_conf_ctx *ctx);
-void blkg_conf_finish(struct blkg_conf_ctx *ctx);
 
-/**
- * blkcg_css - find the current css
- *
- * Find the css associated with either the kthread or the current task.
- * This may return a dying css, so it is up to the caller to use tryget logic
- * to confirm it is alive and well.
- */
-static inline struct cgroup_subsys_state *blkcg_css(void)
-{
-	struct cgroup_subsys_state *css;
-
-	css = kthread_blkcg();
-	if (css)
-		return css;
-	return task_css(current, io_cgrp_id);
-}
+void blkcg_destroy_blkgs(struct blkcg *blkcg);
+void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
+void blkcg_maybe_throttle_current(void);
 
 static inline struct blkcg *css_to_blkcg(struct cgroup_subsys_state *css)
 {
 	return css ? container_of(css, struct blkcg, css) : NULL;
 }
 
-/**
- * __bio_blkcg - internal, inconsistent version to get blkcg
- *
- * DO NOT USE.
- * This function is inconsistent and consequently is dangerous to use.  The
- * first part of the function returns a blkcg where a reference is owned by the
- * bio.  This means it does not need to be rcu protected as it cannot go away
- * with the bio owning a reference to it.  However, the latter potentially gets
- * it from task_css().  This can race against task migration and the cgroup
- * dying.  It is also semantically different as it must be called rcu protected
- * and is susceptible to failure when trying to get a reference to it.
- * Therefore, it is not ok to assume that *_get() will always succeed on the
- * blkcg returned here.
- */
-static inline struct blkcg *__bio_blkcg(struct bio *bio)
-{
-	if (bio && bio->bi_blkg)
-		return bio->bi_blkg->blkcg;
-	return css_to_blkcg(blkcg_css());
-}
-
 /**
  * bio_blkcg - grab the blkcg associated with a bio
  * @bio: target bio
@@ -288,22 +152,6 @@ static inline bool blk_cgroup_congested(void)
 	return ret;
 }
 
-/**
- * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
- * @return: true if this bio needs to be submitted with the root blkg context.
- *
- * In order to avoid priority inversions we sometimes need to issue a bio as if
- * it were attached to the root blkg, and then backcharge to the actual owning
- * blkg.  The idea is we do bio_blkcg() to look up the actual context for the
- * bio and attach the appropriate blkg to the bio.  Then we call this helper and
- * if it is true run with the root blkg for that queue and then do any
- * backcharging to the originating cgroup once the io is complete.
- */
-static inline bool bio_issue_as_root_blkg(struct bio *bio)
-{
-	return (bio->bi_opf & (REQ_META | REQ_SWAP)) != 0;
-}
-
 /**
  * blkcg_parent - get the parent of a blkcg
  * @blkcg: blkcg of interest
@@ -315,96 +163,6 @@ static inline struct blkcg *blkcg_parent(struct blkcg *blkcg)
 	return css_to_blkcg(blkcg->css.parent);
 }
 
-/**
- * __blkg_lookup - internal version of blkg_lookup()
- * @blkcg: blkcg of interest
- * @q: request_queue of interest
- * @update_hint: whether to update lookup hint with the result or not
- *
- * This is internal version and shouldn't be used by policy
- * implementations.  Looks up blkgs for the @blkcg - @q pair regardless of
- * @q's bypass state.  If @update_hint is %true, the caller should be
- * holding @q->queue_lock and lookup hint is updated on success.
- */
-static inline struct blkcg_gq *__blkg_lookup(struct blkcg *blkcg,
-					     struct request_queue *q,
-					     bool update_hint)
-{
-	struct blkcg_gq *blkg;
-
-	if (blkcg == &blkcg_root)
-		return q->root_blkg;
-
-	blkg = rcu_dereference(blkcg->blkg_hint);
-	if (blkg && blkg->q == q)
-		return blkg;
-
-	return blkg_lookup_slowpath(blkcg, q, update_hint);
-}
-
-/**
- * blkg_lookup - lookup blkg for the specified blkcg - q pair
- * @blkcg: blkcg of interest
- * @q: request_queue of interest
- *
- * Lookup blkg for the @blkcg - @q pair.  This function should be called
- * under RCU read lock.
- */
-static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
-					   struct request_queue *q)
-{
-	WARN_ON_ONCE(!rcu_read_lock_held());
-	return __blkg_lookup(blkcg, q, false);
-}
-
-/**
- * blk_queue_root_blkg - return blkg for the (blkcg_root, @q) pair
- * @q: request_queue of interest
- *
- * Lookup blkg for @q at the root level. See also blkg_lookup().
- */
-static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
-{
-	return q->root_blkg;
-}
-
-/**
- * blkg_to_pdata - get policy private data
- * @blkg: blkg of interest
- * @pol: policy of interest
- *
- * Return pointer to private data associated with the @blkg-@pol pair.
- */
-static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
-						  struct blkcg_policy *pol)
-{
-	return blkg ? blkg->pd[pol->plid] : NULL;
-}
-
-static inline struct blkcg_policy_data *blkcg_to_cpd(struct blkcg *blkcg,
-						     struct blkcg_policy *pol)
-{
-	return blkcg ? blkcg->cpd[pol->plid] : NULL;
-}
-
-/**
- * pdata_to_blkg - get blkg associated with policy private data
- * @pd: policy private data of interest
- *
- * @pd is policy private data.  Determine the blkg it's associated with.
- */
-static inline struct blkcg_gq *pd_to_blkg(struct blkg_policy_data *pd)
-{
-	return pd ? pd->blkg : NULL;
-}
-
-static inline struct blkcg *cpd_to_blkcg(struct blkcg_policy_data *cpd)
-{
-	return cpd ? cpd->blkcg : NULL;
-}
-
-extern void blkcg_destroy_blkgs(struct blkcg *blkcg);
-
 /**
  * blkcg_pin_online - pin online state
  * @blkcg: blkcg of interest
@@ -437,231 +195,24 @@ static inline void blkcg_unpin_online(struct blkcg *blkcg)
 	} while (blkcg);
 }
 
-/**
- * blkg_path - format cgroup path of blkg
- * @blkg: blkg of interest
- * @buf: target buffer
- * @buflen: target buffer length
- *
- * Format the path of the cgroup of @blkg into @buf.
- */
-static inline int blkg_path(struct blkcg_gq *blkg, char *buf, int buflen)
-{
-	return cgroup_path(blkg->blkcg->css.cgroup, buf, buflen);
-}
-
-/**
- * blkg_get - get a blkg reference
- * @blkg: blkg to get
- *
- * The caller should be holding an existing reference.
- */
-static inline void blkg_get(struct blkcg_gq *blkg)
-{
-	percpu_ref_get(&blkg->refcnt);
-}
-
-/**
- * blkg_tryget - try and get a blkg reference
- * @blkg: blkg to get
- *
- * This is for use when doing an RCU lookup of the blkg.  We may be in the midst
- * of freeing this blkg, so we can only use it if the refcnt is not zero.
- */
-static inline bool blkg_tryget(struct blkcg_gq *blkg)
-{
-	return blkg && percpu_ref_tryget(&blkg->refcnt);
-}
-
-/**
- * blkg_put - put a blkg reference
- * @blkg: blkg to put
- */
-static inline void blkg_put(struct blkcg_gq *blkg)
-{
-	percpu_ref_put(&blkg->refcnt);
-}
-
-/**
- * blkg_for_each_descendant_pre - pre-order walk of a blkg's descendants
- * @d_blkg: loop cursor pointing to the current descendant
- * @pos_css: used for iteration
- * @p_blkg: target blkg to walk descendants of
- *
- * Walk @c_blkg through the descendants of @p_blkg.  Must be used with RCU
- * read locked.  If called under either blkcg or queue lock, the iteration
- * is guaranteed to include all and only online blkgs.  The caller may
- * update @pos_css by calling css_rightmost_descendant() to skip subtree.
- * @p_blkg is included in the iteration and the first node to be visited.
- */
-#define blkg_for_each_descendant_pre(d_blkg, pos_css, p_blkg)		\
-	css_for_each_descendant_pre((pos_css), &(p_blkg)->blkcg->css)	\
-		if (((d_blkg) = __blkg_lookup(css_to_blkcg(pos_css),	\
-					      (p_blkg)->q, false)))
-
-/**
- * blkg_for_each_descendant_post - post-order walk of a blkg's descendants
- * @d_blkg: loop cursor pointing to the current descendant
- * @pos_css: used for iteration
- * @p_blkg: target blkg to walk descendants of
- *
- * Similar to blkg_for_each_descendant_pre() but performs post-order
- * traversal instead.  Synchronization rules are the same.  @p_blkg is
- * included in the iteration and the last node to be visited.
- */
-#define blkg_for_each_descendant_post(d_blkg, pos_css, p_blkg)		\
-	css_for_each_descendant_post((pos_css), &(p_blkg)->blkcg->css)	\
-		if (((d_blkg) = __blkg_lookup(css_to_blkcg(pos_css),	\
-					      (p_blkg)->q, false)))
-
-bool __blkcg_punt_bio_submit(struct bio *bio);
-
-static inline bool blkcg_punt_bio_submit(struct bio *bio)
-{
-	if (bio->bi_opf & REQ_CGROUP_PUNT)
-		return __blkcg_punt_bio_submit(bio);
-	else
-		return false;
-}
-
-static inline void blkcg_bio_issue_init(struct bio *bio)
-{
-	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
-}
-
-static inline void blkcg_use_delay(struct blkcg_gq *blkg)
-{
-	if (WARN_ON_ONCE(atomic_read(&blkg->use_delay) < 0))
-		return;
-	if (atomic_add_return(1, &blkg->use_delay) == 1)
-		atomic_inc(&blkg->blkcg->css.cgroup->congestion_count);
-}
-
-static inline int blkcg_unuse_delay(struct blkcg_gq *blkg)
-{
-	int old = atomic_read(&blkg->use_delay);
-
-	if (WARN_ON_ONCE(old < 0))
-		return 0;
-	if (old == 0)
-		return 0;
-
-	/*
-	 * We do this song and dance because we can race with somebody else
-	 * adding or removing delay.  If we just did an atomic_dec we'd end up
-	 * negative and we'd already be in trouble.  We need to subtract 1 and
-	 * then check to see if we were the last delay so we can drop the
-	 * congestion count on the cgroup.
-	 */
-	while (old) {
-		int cur = atomic_cmpxchg(&blkg->use_delay, old, old - 1);
-		if (cur == old)
-			break;
-		old = cur;
-	}
-
-	if (old == 0)
-		return 0;
-	if (old == 1)
-		atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
-	return 1;
-}
-
-/**
- * blkcg_set_delay - Enable allocator delay mechanism with the specified delay amount
- * @blkg: target blkg
- * @delay: delay duration in nsecs
- *
- * When enabled with this function, the delay is not decayed and must be
- * explicitly cleared with blkcg_clear_delay(). Must not be mixed with
- * blkcg_[un]use_delay() and blkcg_add_delay() usages.
- */
-static inline void blkcg_set_delay(struct blkcg_gq *blkg, u64 delay)
-{
-	int old = atomic_read(&blkg->use_delay);
-
-	/* We only want 1 person setting the congestion count for this blkg. */
-	if (!old && atomic_cmpxchg(&blkg->use_delay, old, -1) == old)
-		atomic_inc(&blkg->blkcg->css.cgroup->congestion_count);
-
-	atomic64_set(&blkg->delay_nsec, delay);
-}
-
-/**
- * blkcg_clear_delay - Disable allocator delay mechanism
- * @blkg: target blkg
- *
- * Disable use_delay mechanism. See blkcg_set_delay().
- */
-static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
-{
-	int old = atomic_read(&blkg->use_delay);
-
-	/* We only want 1 person clearing the congestion count for this blkg. */
-	if (old && atomic_cmpxchg(&blkg->use_delay, old, 0) == old)
-		atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
-}
-
-void blk_cgroup_bio_start(struct bio *bio);
-void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
-void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
-void blkcg_maybe_throttle_current(void);
 #else	/* CONFIG_BLK_CGROUP */
 
 struct blkcg {
 };
 
-struct blkg_policy_data {
-};
-
-struct blkcg_policy_data {
-};
-
 struct blkcg_gq {
 };
 
-struct blkcg_policy {
-};
-
 #define blkcg_root_css	((struct cgroup_subsys_state *)ERR_PTR(-EINVAL))
 
 static inline void blkcg_maybe_throttle_current(void) { }
 static inline bool blk_cgroup_congested(void) { return false; }
 
 #ifdef CONFIG_BLOCK
-
 static inline void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay) { }
-
-static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
-static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
-{ return NULL; }
-static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
-static inline void blkcg_exit_queue(struct request_queue *q) { }
-static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
-static inline void blkcg_policy_unregister(struct blkcg_policy *pol) { }
-static inline int blkcg_activate_policy(struct request_queue *q,
-					const struct blkcg_policy *pol) { return 0; }
-static inline void blkcg_deactivate_policy(struct request_queue *q,
-					   const struct blkcg_policy *pol) { }
-
-static inline struct blkcg *__bio_blkcg(struct bio *bio) { return NULL; }
 static inline struct blkcg *bio_blkcg(struct bio *bio) { return NULL; }
+#endif /* CONFIG_BLOCK */
 
-static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
-						  struct blkcg_policy *pol) { return NULL; }
-static inline struct blkcg_gq *pd_to_blkg(struct blkg_policy_data *pd) { return NULL; }
-static inline char *blkg_path(struct blkcg_gq *blkg) { return NULL; }
-static inline void blkg_get(struct blkcg_gq *blkg) { }
-static inline void blkg_put(struct blkcg_gq *blkg) { }
-
-static inline bool blkcg_punt_bio_submit(struct bio *bio) { return false; }
-static inline void blkcg_bio_issue_init(struct bio *bio) { }
-static inline void blk_cgroup_bio_start(struct bio *bio) { }
-
-#define blk_queue_for_each_rl(rl, q)	\
-	for ((rl) = &(q)->root_rl; (rl); (rl) = NULL)
-
-#endif	/* CONFIG_BLOCK */
 #endif	/* CONFIG_BLK_CGROUP */
 
 #ifdef CONFIG_BLK_CGROUP_FC_APPID
-- 
2.31.1

