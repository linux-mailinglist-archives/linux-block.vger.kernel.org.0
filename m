Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EA06566D7
	for <lists+linux-block@lfdr.de>; Tue, 27 Dec 2022 03:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiL0Cai (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 26 Dec 2022 21:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiL0CaW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Dec 2022 21:30:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D0863EC
        for <linux-block@vger.kernel.org>; Mon, 26 Dec 2022 18:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672108178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=st/Ppd9xFjCa5g7EoOG6hJl1d4pQHA9WlVf2GNzTSfY=;
        b=N0I7XOs1JtVuvlJtS+qqLupOttTJX+pFmoXNJnlJCd7bTcYfOPmv52A+RHkGFMjpLtLhiA
        SvZHbBMHPJbzznEraQ65lAx33hCURwOXF3HGevPQq2lEPubbLFUFRNRIqm08GP+9L8Iy7a
        snjxLyzdgeBUxihThVrPcuIYkj6GHtw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-rIe0rOvePWiAl2Dl682lHA-1; Mon, 26 Dec 2022 21:29:35 -0500
X-MC-Unique: rIe0rOvePWiAl2Dl682lHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5DCE3806723;
        Tue, 27 Dec 2022 02:29:34 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D11640C2004;
        Tue, 27 Dec 2022 02:29:32 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 5/6] genirq/affinity: Move group_cpus_evenly() into lib/
Date:   Tue, 27 Dec 2022 10:29:04 +0800
Message-Id: <20221227022905.352674-6-ming.lei@redhat.com>
In-Reply-To: <20221227022905.352674-1-ming.lei@redhat.com>
References: <20221227022905.352674-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

group_cpus_evenly() has become one generic helper which can be used for
other subsystems, so move it into lib/.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 MAINTAINERS                |   2 +
 include/linux/group_cpus.h |  14 ++
 kernel/irq/affinity.c      | 398 +---------------------------------
 lib/Makefile               |   2 +
 lib/group_cpus.c           | 427 +++++++++++++++++++++++++++++++++++++
 5 files changed, 446 insertions(+), 397 deletions(-)
 create mode 100644 include/linux/group_cpus.h
 create mode 100644 lib/group_cpus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bb77a3ed9d54..2b6ba935f4bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10881,6 +10881,8 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	kernel/irq/
+F:	include/linux/group_cpus.h
+F:	lib/group_cpus.c
 
 IRQCHIP DRIVERS
 M:	Thomas Gleixner <tglx@linutronix.de>
diff --git a/include/linux/group_cpus.h b/include/linux/group_cpus.h
new file mode 100644
index 000000000000..e42807ec61f6
--- /dev/null
+++ b/include/linux/group_cpus.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2016 Thomas Gleixner.
+ * Copyright (C) 2016-2017 Christoph Hellwig.
+ */
+
+#ifndef __LINUX_GROUP_CPUS_H
+#define __LINUX_GROUP_CPUS_H
+#include <linux/kernel.h>
+#include <linux/cpu.h>
+
+struct cpumask *group_cpus_evenly(unsigned int numgrps);
+
+#endif
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 54083331f1bc..44a4eba80315 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -7,403 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
-#include <linux/sort.h>
-
-static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
-				unsigned int cpus_per_grp)
-{
-	const struct cpumask *siblmsk;
-	int cpu, sibl;
-
-	for ( ; cpus_per_grp > 0; ) {
-		cpu = cpumask_first(nmsk);
-
-		/* Should not happen, but I'm too lazy to think about it */
-		if (cpu >= nr_cpu_ids)
-			return;
-
-		cpumask_clear_cpu(cpu, nmsk);
-		cpumask_set_cpu(cpu, irqmsk);
-		cpus_per_grp--;
-
-		/* If the cpu has siblings, use them first */
-		siblmsk = topology_sibling_cpumask(cpu);
-		for (sibl = -1; cpus_per_grp > 0; ) {
-			sibl = cpumask_next(sibl, siblmsk);
-			if (sibl >= nr_cpu_ids)
-				break;
-			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
-				continue;
-			cpumask_set_cpu(sibl, irqmsk);
-			cpus_per_grp--;
-		}
-	}
-}
-
-static cpumask_var_t *alloc_node_to_cpumask(void)
-{
-	cpumask_var_t *masks;
-	int node;
-
-	masks = kcalloc(nr_node_ids, sizeof(cpumask_var_t), GFP_KERNEL);
-	if (!masks)
-		return NULL;
-
-	for (node = 0; node < nr_node_ids; node++) {
-		if (!zalloc_cpumask_var(&masks[node], GFP_KERNEL))
-			goto out_unwind;
-	}
-
-	return masks;
-
-out_unwind:
-	while (--node >= 0)
-		free_cpumask_var(masks[node]);
-	kfree(masks);
-	return NULL;
-}
-
-static void free_node_to_cpumask(cpumask_var_t *masks)
-{
-	int node;
-
-	for (node = 0; node < nr_node_ids; node++)
-		free_cpumask_var(masks[node]);
-	kfree(masks);
-}
-
-static void build_node_to_cpumask(cpumask_var_t *masks)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		cpumask_set_cpu(cpu, masks[cpu_to_node(cpu)]);
-}
-
-static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
-				const struct cpumask *mask, nodemask_t *nodemsk)
-{
-	int n, nodes = 0;
-
-	/* Calculate the number of nodes in the supplied affinity mask */
-	for_each_node(n) {
-		if (cpumask_intersects(mask, node_to_cpumask[n])) {
-			node_set(n, *nodemsk);
-			nodes++;
-		}
-	}
-	return nodes;
-}
-
-struct node_groups {
-	unsigned id;
-
-	union {
-		unsigned ngroups;
-		unsigned ncpus;
-	};
-};
-
-static int ncpus_cmp_func(const void *l, const void *r)
-{
-	const struct node_groups *ln = l;
-	const struct node_groups *rn = r;
-
-	return ln->ncpus - rn->ncpus;
-}
-
-/*
- * Allocate group number for each node, so that for each node:
- *
- * 1) the allocated number is >= 1
- *
- * 2) the allocated number is <= active CPU number of this node
- *
- * The actual allocated total groups may be less than @numgrps when
- * active total CPU number is less than @numgrps.
- *
- * Active CPUs means the CPUs in '@cpu_mask AND @node_to_cpumask[]'
- * for each node.
- */
-static void alloc_nodes_groups(unsigned int numgrps,
-			       cpumask_var_t *node_to_cpumask,
-			       const struct cpumask *cpu_mask,
-			       const nodemask_t nodemsk,
-			       struct cpumask *nmsk,
-			       struct node_groups *node_groups)
-{
-	unsigned n, remaining_ncpus = 0;
-
-	for (n = 0; n < nr_node_ids; n++) {
-		node_groups[n].id = n;
-		node_groups[n].ncpus = UINT_MAX;
-	}
-
-	for_each_node_mask(n, nodemsk) {
-		unsigned ncpus;
-
-		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
-		ncpus = cpumask_weight(nmsk);
-
-		if (!ncpus)
-			continue;
-		remaining_ncpus += ncpus;
-		node_groups[n].ncpus = ncpus;
-	}
-
-	numgrps = min_t(unsigned, remaining_ncpus, numgrps);
-
-	sort(node_groups, nr_node_ids, sizeof(node_groups[0]),
-	     ncpus_cmp_func, NULL);
-
-	/*
-	 * Allocate groups for each node according to the ratio of this
-	 * node's nr_cpus to remaining un-assigned ncpus. 'numgrps' is
-	 * bigger than number of active numa nodes. Always start the
-	 * allocation from the node with minimized nr_cpus.
-	 *
-	 * This way guarantees that each active node gets allocated at
-	 * least one group, and the theory is simple: over-allocation
-	 * is only done when this node is assigned by one group, so
-	 * other nodes will be allocated >= 1 groups, since 'numgrps' is
-	 * bigger than number of numa nodes.
-	 *
-	 * One perfect invariant is that number of allocated groups for
-	 * each node is <= CPU count of this node:
-	 *
-	 * 1) suppose there are two nodes: A and B
-	 * 	ncpu(X) is CPU count of node X
-	 * 	grps(X) is the group count allocated to node X via this
-	 * 	algorithm
-	 *
-	 * 	ncpu(A) <= ncpu(B)
-	 * 	ncpu(A) + ncpu(B) = N
-	 * 	grps(A) + grps(B) = G
-	 *
-	 * 	grps(A) = max(1, round_down(G * ncpu(A) / N))
-	 * 	grps(B) = G - grps(A)
-	 *
-	 * 	both N and G are integer, and 2 <= G <= N, suppose
-	 * 	G = N - delta, and 0 <= delta <= N - 2
-	 *
-	 * 2) obviously grps(A) <= ncpu(A) because:
-	 *
-	 * 	if grps(A) is 1, then grps(A) <= ncpu(A) given
-	 * 	ncpu(A) >= 1
-	 *
-	 * 	otherwise,
-	 * 		grps(A) <= G * ncpu(A) / N <= ncpu(A), given G <= N
-	 *
-	 * 3) prove how grps(B) <= ncpu(B):
-	 *
-	 * 	if round_down(G * ncpu(A) / N) == 0, vecs(B) won't be
-	 * 	over-allocated, so grps(B) <= ncpu(B),
-	 *
-	 * 	otherwise:
-	 *
-	 * 	grps(A) =
-	 * 		round_down(G * ncpu(A) / N) =
-	 * 		round_down((N - delta) * ncpu(A) / N) =
-	 * 		round_down((N * ncpu(A) - delta * ncpu(A)) / N)	 >=
-	 * 		round_down((N * ncpu(A) - delta * N) / N)	 =
-	 * 		cpu(A) - delta
-	 *
-	 * 	then:
-	 *
-	 * 	grps(A) - G >= ncpu(A) - delta - G
-	 * 	=>
-	 * 	G - grps(A) <= G + delta - ncpu(A)
-	 * 	=>
-	 * 	grps(B) <= N - ncpu(A)
-	 * 	=>
-	 * 	grps(B) <= cpu(B)
-	 *
-	 * For nodes >= 3, it can be thought as one node and another big
-	 * node given that is exactly what this algorithm is implemented,
-	 * and we always re-calculate 'remaining_ncpus' & 'numgrps', and
-	 * finally for each node X: grps(X) <= ncpu(X).
-	 *
-	 */
-	for (n = 0; n < nr_node_ids; n++) {
-		unsigned ngroups, ncpus;
-
-		if (node_groups[n].ncpus == UINT_MAX)
-			continue;
-
-		WARN_ON_ONCE(numgrps == 0);
-
-		ncpus = node_groups[n].ncpus;
-		ngroups = max_t(unsigned, 1,
-				 numgrps * ncpus / remaining_ncpus);
-		WARN_ON_ONCE(ngroups > ncpus);
-
-		node_groups[n].ngroups = ngroups;
-
-		remaining_ncpus -= ncpus;
-		numgrps -= ngroups;
-	}
-}
-
-static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
-			       cpumask_var_t *node_to_cpumask,
-			       const struct cpumask *cpu_mask,
-			       struct cpumask *nmsk, struct cpumask *masks)
-{
-	unsigned int i, n, nodes, cpus_per_grp, extra_grps, done = 0;
-	unsigned int last_grp = numgrps;
-	unsigned int curgrp = startgrp;
-	nodemask_t nodemsk = NODE_MASK_NONE;
-	struct node_groups *node_groups;
-
-	if (cpumask_empty(cpu_mask))
-		return 0;
-
-	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
-
-	/*
-	 * If the number of nodes in the mask is greater than or equal the
-	 * number of groups we just spread the groups across the nodes.
-	 */
-	if (numgrps <= nodes) {
-		for_each_node_mask(n, nodemsk) {
-			/* Ensure that only CPUs which are in both masks are set */
-			cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
-			cpumask_or(&masks[curgrp], &masks[curgrp], nmsk);
-			if (++curgrp == last_grp)
-				curgrp = 0;
-		}
-		return numgrps;
-	}
-
-	node_groups = kcalloc(nr_node_ids,
-			       sizeof(struct node_groups),
-			       GFP_KERNEL);
-	if (!node_groups)
-		return -ENOMEM;
-
-	/* allocate group number for each node */
-	alloc_nodes_groups(numgrps, node_to_cpumask, cpu_mask,
-			   nodemsk, nmsk, node_groups);
-	for (i = 0; i < nr_node_ids; i++) {
-		unsigned int ncpus, v;
-		struct node_groups *nv = &node_groups[i];
-
-		if (nv->ngroups == UINT_MAX)
-			continue;
-
-		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_mask, node_to_cpumask[nv->id]);
-		ncpus = cpumask_weight(nmsk);
-		if (!ncpus)
-			continue;
-
-		WARN_ON_ONCE(nv->ngroups > ncpus);
-
-		/* Account for rounding errors */
-		extra_grps = ncpus - nv->ngroups * (ncpus / nv->ngroups);
-
-		/* Spread allocated groups on CPUs of the current node */
-		for (v = 0; v < nv->ngroups; v++, curgrp++) {
-			cpus_per_grp = ncpus / nv->ngroups;
-
-			/* Account for extra groups to compensate rounding errors */
-			if (extra_grps) {
-				cpus_per_grp++;
-				--extra_grps;
-			}
-
-			/*
-			 * wrapping has to be considered given 'startgrp'
-			 * may start anywhere
-			 */
-			if (curgrp >= last_grp)
-				curgrp = 0;
-			grp_spread_init_one(&masks[curgrp], nmsk,
-						cpus_per_grp);
-		}
-		done += nv->ngroups;
-	}
-	kfree(node_groups);
-	return done;
-}
-
-/*
- * build affinity in two stages for each group, and try to put close CPUs
- * in viewpoint of CPU and NUMA locality into same group, and we run
- * two-stage grouping:
- *
- *	1) allocate present CPUs on these groups evenly first
- *	2) allocate other possible CPUs on these groups evenly
- */
-static struct cpumask *group_cpus_evenly(unsigned int numgrps)
-{
-	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
-	cpumask_var_t *node_to_cpumask;
-	cpumask_var_t nmsk, npresmsk;
-	int ret = -ENOMEM;
-	struct cpumask *masks = NULL;
-
-	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
-		return NULL;
-
-	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
-		goto fail_nmsk;
-
-	node_to_cpumask = alloc_node_to_cpumask();
-	if (!node_to_cpumask)
-		goto fail_npresmsk;
-
-	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
-	if (!masks)
-		goto fail_node_to_cpumask;
-
-	/* Stabilize the cpumasks */
-	cpus_read_lock();
-	build_node_to_cpumask(node_to_cpumask);
-
-	/* grouping present CPUs first */
-	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-				  cpu_present_mask, nmsk, masks);
-	if (ret < 0)
-		goto fail_build_affinity;
-	nr_present = ret;
-
-	/*
-	 * Allocate non present CPUs starting from the next group to be
-	 * handled. If the grouping of present CPUs already exhausted the
-	 * group space, assign the non present CPUs to the already
-	 * allocated out groups.
-	 */
-	if (nr_present >= numgrps)
-		curgrp = 0;
-	else
-		curgrp = nr_present;
-	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
-	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-				  npresmsk, nmsk, masks);
-	if (ret >= 0)
-		nr_others = ret;
-
- fail_build_affinity:
-	cpus_read_unlock();
-
-	if (ret >= 0)
-		WARN_ON(nr_present + nr_others < numgrps);
-
- fail_node_to_cpumask:
-	free_node_to_cpumask(node_to_cpumask);
-
- fail_npresmsk:
-	free_cpumask_var(npresmsk);
-
- fail_nmsk:
-	free_cpumask_var(nmsk);
-	if (ret < 0) {
-		kfree(masks);
-		return NULL;
-	}
-	return masks;
-}
+#include <linux/group_cpus.h>
 
 static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
 {
diff --git a/lib/Makefile b/lib/Makefile
index 59bd7c2f793a..bea177e7b21d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -355,6 +355,8 @@ obj-$(CONFIG_SBITMAP) += sbitmap.o
 
 obj-$(CONFIG_PARMAN) += parman.o
 
+obj-y += group_cpus.o
+
 # GCC library routines
 obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
 obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
diff --git a/lib/group_cpus.c b/lib/group_cpus.c
new file mode 100644
index 000000000000..99f08c6cb9d9
--- /dev/null
+++ b/lib/group_cpus.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Thomas Gleixner.
+ * Copyright (C) 2016-2017 Christoph Hellwig.
+ */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/cpu.h>
+#include <linux/sort.h>
+#include <linux/group_cpus.h>
+
+static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
+				unsigned int cpus_per_grp)
+{
+	const struct cpumask *siblmsk;
+	int cpu, sibl;
+
+	for ( ; cpus_per_grp > 0; ) {
+		cpu = cpumask_first(nmsk);
+
+		/* Should not happen, but I'm too lazy to think about it */
+		if (cpu >= nr_cpu_ids)
+			return;
+
+		cpumask_clear_cpu(cpu, nmsk);
+		cpumask_set_cpu(cpu, irqmsk);
+		cpus_per_grp--;
+
+		/* If the cpu has siblings, use them first */
+		siblmsk = topology_sibling_cpumask(cpu);
+		for (sibl = -1; cpus_per_grp > 0; ) {
+			sibl = cpumask_next(sibl, siblmsk);
+			if (sibl >= nr_cpu_ids)
+				break;
+			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
+				continue;
+			cpumask_set_cpu(sibl, irqmsk);
+			cpus_per_grp--;
+		}
+	}
+}
+
+static cpumask_var_t *alloc_node_to_cpumask(void)
+{
+	cpumask_var_t *masks;
+	int node;
+
+	masks = kcalloc(nr_node_ids, sizeof(cpumask_var_t), GFP_KERNEL);
+	if (!masks)
+		return NULL;
+
+	for (node = 0; node < nr_node_ids; node++) {
+		if (!zalloc_cpumask_var(&masks[node], GFP_KERNEL))
+			goto out_unwind;
+	}
+
+	return masks;
+
+out_unwind:
+	while (--node >= 0)
+		free_cpumask_var(masks[node]);
+	kfree(masks);
+	return NULL;
+}
+
+static void free_node_to_cpumask(cpumask_var_t *masks)
+{
+	int node;
+
+	for (node = 0; node < nr_node_ids; node++)
+		free_cpumask_var(masks[node]);
+	kfree(masks);
+}
+
+static void build_node_to_cpumask(cpumask_var_t *masks)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		cpumask_set_cpu(cpu, masks[cpu_to_node(cpu)]);
+}
+
+static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
+				const struct cpumask *mask, nodemask_t *nodemsk)
+{
+	int n, nodes = 0;
+
+	/* Calculate the number of nodes in the supplied affinity mask */
+	for_each_node(n) {
+		if (cpumask_intersects(mask, node_to_cpumask[n])) {
+			node_set(n, *nodemsk);
+			nodes++;
+		}
+	}
+	return nodes;
+}
+
+struct node_groups {
+	unsigned id;
+
+	union {
+		unsigned ngroups;
+		unsigned ncpus;
+	};
+};
+
+static int ncpus_cmp_func(const void *l, const void *r)
+{
+	const struct node_groups *ln = l;
+	const struct node_groups *rn = r;
+
+	return ln->ncpus - rn->ncpus;
+}
+
+/*
+ * Allocate group number for each node, so that for each node:
+ *
+ * 1) the allocated number is >= 1
+ *
+ * 2) the allocated number is <= active CPU number of this node
+ *
+ * The actual allocated total groups may be less than @numgrps when
+ * active total CPU number is less than @numgrps.
+ *
+ * Active CPUs means the CPUs in '@cpu_mask AND @node_to_cpumask[]'
+ * for each node.
+ */
+static void alloc_nodes_groups(unsigned int numgrps,
+			       cpumask_var_t *node_to_cpumask,
+			       const struct cpumask *cpu_mask,
+			       const nodemask_t nodemsk,
+			       struct cpumask *nmsk,
+			       struct node_groups *node_groups)
+{
+	unsigned n, remaining_ncpus = 0;
+
+	for (n = 0; n < nr_node_ids; n++) {
+		node_groups[n].id = n;
+		node_groups[n].ncpus = UINT_MAX;
+	}
+
+	for_each_node_mask(n, nodemsk) {
+		unsigned ncpus;
+
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+		ncpus = cpumask_weight(nmsk);
+
+		if (!ncpus)
+			continue;
+		remaining_ncpus += ncpus;
+		node_groups[n].ncpus = ncpus;
+	}
+
+	numgrps = min_t(unsigned, remaining_ncpus, numgrps);
+
+	sort(node_groups, nr_node_ids, sizeof(node_groups[0]),
+	     ncpus_cmp_func, NULL);
+
+	/*
+	 * Allocate groups for each node according to the ratio of this
+	 * node's nr_cpus to remaining un-assigned ncpus. 'numgrps' is
+	 * bigger than number of active numa nodes. Always start the
+	 * allocation from the node with minimized nr_cpus.
+	 *
+	 * This way guarantees that each active node gets allocated at
+	 * least one group, and the theory is simple: over-allocation
+	 * is only done when this node is assigned by one group, so
+	 * other nodes will be allocated >= 1 groups, since 'numgrps' is
+	 * bigger than number of numa nodes.
+	 *
+	 * One perfect invariant is that number of allocated groups for
+	 * each node is <= CPU count of this node:
+	 *
+	 * 1) suppose there are two nodes: A and B
+	 * 	ncpu(X) is CPU count of node X
+	 * 	grps(X) is the group count allocated to node X via this
+	 * 	algorithm
+	 *
+	 * 	ncpu(A) <= ncpu(B)
+	 * 	ncpu(A) + ncpu(B) = N
+	 * 	grps(A) + grps(B) = G
+	 *
+	 * 	grps(A) = max(1, round_down(G * ncpu(A) / N))
+	 * 	grps(B) = G - grps(A)
+	 *
+	 * 	both N and G are integer, and 2 <= G <= N, suppose
+	 * 	G = N - delta, and 0 <= delta <= N - 2
+	 *
+	 * 2) obviously grps(A) <= ncpu(A) because:
+	 *
+	 * 	if grps(A) is 1, then grps(A) <= ncpu(A) given
+	 * 	ncpu(A) >= 1
+	 *
+	 * 	otherwise,
+	 * 		grps(A) <= G * ncpu(A) / N <= ncpu(A), given G <= N
+	 *
+	 * 3) prove how grps(B) <= ncpu(B):
+	 *
+	 * 	if round_down(G * ncpu(A) / N) == 0, vecs(B) won't be
+	 * 	over-allocated, so grps(B) <= ncpu(B),
+	 *
+	 * 	otherwise:
+	 *
+	 * 	grps(A) =
+	 * 		round_down(G * ncpu(A) / N) =
+	 * 		round_down((N - delta) * ncpu(A) / N) =
+	 * 		round_down((N * ncpu(A) - delta * ncpu(A)) / N)	 >=
+	 * 		round_down((N * ncpu(A) - delta * N) / N)	 =
+	 * 		cpu(A) - delta
+	 *
+	 * 	then:
+	 *
+	 * 	grps(A) - G >= ncpu(A) - delta - G
+	 * 	=>
+	 * 	G - grps(A) <= G + delta - ncpu(A)
+	 * 	=>
+	 * 	grps(B) <= N - ncpu(A)
+	 * 	=>
+	 * 	grps(B) <= cpu(B)
+	 *
+	 * For nodes >= 3, it can be thought as one node and another big
+	 * node given that is exactly what this algorithm is implemented,
+	 * and we always re-calculate 'remaining_ncpus' & 'numgrps', and
+	 * finally for each node X: grps(X) <= ncpu(X).
+	 *
+	 */
+	for (n = 0; n < nr_node_ids; n++) {
+		unsigned ngroups, ncpus;
+
+		if (node_groups[n].ncpus == UINT_MAX)
+			continue;
+
+		WARN_ON_ONCE(numgrps == 0);
+
+		ncpus = node_groups[n].ncpus;
+		ngroups = max_t(unsigned, 1,
+				 numgrps * ncpus / remaining_ncpus);
+		WARN_ON_ONCE(ngroups > ncpus);
+
+		node_groups[n].ngroups = ngroups;
+
+		remaining_ncpus -= ncpus;
+		numgrps -= ngroups;
+	}
+}
+
+static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
+			       cpumask_var_t *node_to_cpumask,
+			       const struct cpumask *cpu_mask,
+			       struct cpumask *nmsk, struct cpumask *masks)
+{
+	unsigned int i, n, nodes, cpus_per_grp, extra_grps, done = 0;
+	unsigned int last_grp = numgrps;
+	unsigned int curgrp = startgrp;
+	nodemask_t nodemsk = NODE_MASK_NONE;
+	struct node_groups *node_groups;
+
+	if (cpumask_empty(cpu_mask))
+		return 0;
+
+	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
+
+	/*
+	 * If the number of nodes in the mask is greater than or equal the
+	 * number of groups we just spread the groups across the nodes.
+	 */
+	if (numgrps <= nodes) {
+		for_each_node_mask(n, nodemsk) {
+			/* Ensure that only CPUs which are in both masks are set */
+			cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+			cpumask_or(&masks[curgrp], &masks[curgrp], nmsk);
+			if (++curgrp == last_grp)
+				curgrp = 0;
+		}
+		return numgrps;
+	}
+
+	node_groups = kcalloc(nr_node_ids,
+			       sizeof(struct node_groups),
+			       GFP_KERNEL);
+	if (!node_groups)
+		return -ENOMEM;
+
+	/* allocate group number for each node */
+	alloc_nodes_groups(numgrps, node_to_cpumask, cpu_mask,
+			   nodemsk, nmsk, node_groups);
+	for (i = 0; i < nr_node_ids; i++) {
+		unsigned int ncpus, v;
+		struct node_groups *nv = &node_groups[i];
+
+		if (nv->ngroups == UINT_MAX)
+			continue;
+
+		/* Get the cpus on this node which are in the mask */
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[nv->id]);
+		ncpus = cpumask_weight(nmsk);
+		if (!ncpus)
+			continue;
+
+		WARN_ON_ONCE(nv->ngroups > ncpus);
+
+		/* Account for rounding errors */
+		extra_grps = ncpus - nv->ngroups * (ncpus / nv->ngroups);
+
+		/* Spread allocated groups on CPUs of the current node */
+		for (v = 0; v < nv->ngroups; v++, curgrp++) {
+			cpus_per_grp = ncpus / nv->ngroups;
+
+			/* Account for extra groups to compensate rounding errors */
+			if (extra_grps) {
+				cpus_per_grp++;
+				--extra_grps;
+			}
+
+			/*
+			 * wrapping has to be considered given 'startgrp'
+			 * may start anywhere
+			 */
+			if (curgrp >= last_grp)
+				curgrp = 0;
+			grp_spread_init_one(&masks[curgrp], nmsk,
+						cpus_per_grp);
+		}
+		done += nv->ngroups;
+	}
+	kfree(node_groups);
+	return done;
+}
+
+#ifdef CONFIG_SMP
+/**
+ * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
+ * @numgrps: number of groups
+ *
+ * Return: cpumask array if successful, NULL otherwise. And each element
+ * includes CPUs assigned to this group
+ *
+ * Try to put close CPUs from viewpoint of CPU and NUMA locality into
+ * same group, and run two-stage grouping:
+ *	1) allocate present CPUs on these groups evenly first
+ *	2) allocate other possible CPUs on these groups evenly
+ *
+ * We guarantee in the resulted grouping that all CPUs are covered, and
+ * no same CPU is assigned to multiple groups
+ */
+struct cpumask *group_cpus_evenly(unsigned int numgrps)
+{
+	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
+	cpumask_var_t *node_to_cpumask;
+	cpumask_var_t nmsk, npresmsk;
+	int ret = -ENOMEM;
+	struct cpumask *masks = NULL;
+
+	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
+		return NULL;
+
+	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
+		goto fail_nmsk;
+
+	node_to_cpumask = alloc_node_to_cpumask();
+	if (!node_to_cpumask)
+		goto fail_npresmsk;
+
+	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
+	if (!masks)
+		goto fail_node_to_cpumask;
+
+	/* Stabilize the cpumasks */
+	cpus_read_lock();
+	build_node_to_cpumask(node_to_cpumask);
+
+	/* grouping present CPUs first */
+	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
+				  cpu_present_mask, nmsk, masks);
+	if (ret < 0)
+		goto fail_build_affinity;
+	nr_present = ret;
+
+	/*
+	 * Allocate non present CPUs starting from the next group to be
+	 * handled. If the grouping of present CPUs already exhausted the
+	 * group space, assign the non present CPUs to the already
+	 * allocated out groups.
+	 */
+	if (nr_present >= numgrps)
+		curgrp = 0;
+	else
+		curgrp = nr_present;
+	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
+	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
+				  npresmsk, nmsk, masks);
+	if (ret >= 0)
+		nr_others = ret;
+
+ fail_build_affinity:
+	cpus_read_unlock();
+
+	if (ret >= 0)
+		WARN_ON(nr_present + nr_others < numgrps);
+
+ fail_node_to_cpumask:
+	free_node_to_cpumask(node_to_cpumask);
+
+ fail_npresmsk:
+	free_cpumask_var(npresmsk);
+
+ fail_nmsk:
+	free_cpumask_var(nmsk);
+	if (ret < 0) {
+		kfree(masks);
+		return NULL;
+	}
+	return masks;
+}
+#else
+struct cpumask *group_cpus_evenly(unsigned int numgrps)
+{
+	struct cpumask *masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
+
+	if (!masks)
+		return NULL;
+
+	/* assign all CPUs(cpu 0) to the 1st group only */
+	cpumask_copy(&masks[0], cpu_possible_mask);
+	return masks;
+}
+#endif
-- 
2.31.1

