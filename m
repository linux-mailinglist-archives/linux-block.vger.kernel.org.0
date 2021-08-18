Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C733F006F
	for <lists+linux-block@lfdr.de>; Wed, 18 Aug 2021 11:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhHRJ3c (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 Aug 2021 05:29:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232797AbhHRJ30 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 05:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629278931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CGASuNGI+2J2jTBBe37sNWGItRWa7EFH1lrmPMFQTfc=;
        b=LPw0eKyNaUQnjjFYgigw/oTcu1mAiHTZRsaKBynWUw9U9TrLJMqQyqwOHtFR57U4+R/vdE
        +5DmijScjFGhXZIWos6Wmcyf6PYf3Ii+cH2N8Wrrz9b3tuFSh1VyTJh6ZYfjss3e5k9RmB
        l291+CzwlPJNhwIA+emceV5pGJKVBzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-OlyjjNzmMdmj5DwzlXlNbg-1; Wed, 18 Aug 2021 05:28:49 -0400
X-MC-Unique: OlyjjNzmMdmj5DwzlXlNbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EAD093921;
        Wed, 18 Aug 2021 09:28:48 +0000 (UTC)
Received: from localhost (ovpn-8-40.pek2.redhat.com [10.72.8.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A99FA100EB3D;
        Wed, 18 Aug 2021 09:28:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 4/7] genirq/affinity: rename irq_build_affinity_masks as group_cpus_evenly
Date:   Wed, 18 Aug 2021 17:28:09 +0800
Message-Id: <20210818092812.787558-5-ming.lei@redhat.com>
In-Reply-To: <20210818092812.787558-1-ming.lei@redhat.com>
References: <20210818092812.787558-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Map irq vector into group, so we can abstract the algorithm for generic
use case.

Rename irq_build_affinity_masks as group_cpus_evenly, so we can reuse
the API for blk-mq to make default queue mapping.

No functional change, just rename vector as group.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 241 +++++++++++++++++++++---------------------
 1 file changed, 121 insertions(+), 120 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index aef12ec05dcf..ad0ce4b5a28e 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -9,13 +9,13 @@
 #include <linux/cpu.h>
 #include <linux/sort.h>
 
-static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
-				unsigned int cpus_per_vec)
+static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
+				unsigned int cpus_per_grp)
 {
 	const struct cpumask *siblmsk;
 	int cpu, sibl;
 
-	for ( ; cpus_per_vec > 0; ) {
+	for ( ; cpus_per_grp > 0; ) {
 		cpu = cpumask_first(nmsk);
 
 		/* Should not happen, but I'm too lazy to think about it */
@@ -24,18 +24,18 @@ static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 
 		cpumask_clear_cpu(cpu, nmsk);
 		cpumask_set_cpu(cpu, irqmsk);
-		cpus_per_vec--;
+		cpus_per_grp--;
 
 		/* If the cpu has siblings, use them first */
 		siblmsk = topology_sibling_cpumask(cpu);
-		for (sibl = -1; cpus_per_vec > 0; ) {
+		for (sibl = -1; cpus_per_grp > 0; ) {
 			sibl = cpumask_next(sibl, siblmsk);
 			if (sibl >= nr_cpu_ids)
 				break;
 			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
 				continue;
 			cpumask_set_cpu(sibl, irqmsk);
-			cpus_per_vec--;
+			cpus_per_grp--;
 		}
 	}
 }
@@ -95,48 +95,48 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 	return nodes;
 }
 
-struct node_vectors {
+struct node_groups {
 	unsigned id;
 
 	union {
-		unsigned nvectors;
+		unsigned ngroups;
 		unsigned ncpus;
 	};
 };
 
 static int ncpus_cmp_func(const void *l, const void *r)
 {
-	const struct node_vectors *ln = l;
-	const struct node_vectors *rn = r;
+	const struct node_groups *ln = l;
+	const struct node_groups *rn = r;
 
 	return ln->ncpus - rn->ncpus;
 }
 
 /*
- * Allocate vector number for each node, so that for each node:
+ * Allocate group number for each node, so that for each node:
  *
  * 1) the allocated number is >= 1
  *
- * 2) the allocated numbver is <= active CPU number of this node
+ * 2) the allocated number is <= active CPU number of this node
  *
- * The actual allocated total vectors may be less than @numvecs when
- * active total CPU number is less than @numvecs.
+ * The actual allocated total groups may be less than @numgrps when
+ * active total CPU number is less than @numgrps.
  *
  * Active CPUs means the CPUs in '@cpu_mask AND @node_to_cpumask[]'
  * for each node.
  */
-static void alloc_nodes_vectors(unsigned int numvecs,
-				cpumask_var_t *node_to_cpumask,
-				const struct cpumask *cpu_mask,
-				const nodemask_t nodemsk,
-				struct cpumask *nmsk,
-				struct node_vectors *node_vectors)
+static void alloc_nodes_groups(unsigned int numgrps,
+			       cpumask_var_t *node_to_cpumask,
+			       const struct cpumask *cpu_mask,
+			       const nodemask_t nodemsk,
+			       struct cpumask *nmsk,
+			       struct node_groups *node_groups)
 {
 	unsigned n, remaining_ncpus = 0;
 
 	for (n = 0; n < nr_node_ids; n++) {
-		node_vectors[n].id = n;
-		node_vectors[n].ncpus = UINT_MAX;
+		node_groups[n].id = n;
+		node_groups[n].ncpus = UINT_MAX;
 	}
 
 	for_each_node_mask(n, nodemsk) {
@@ -148,61 +148,61 @@ static void alloc_nodes_vectors(unsigned int numvecs,
 		if (!ncpus)
 			continue;
 		remaining_ncpus += ncpus;
-		node_vectors[n].ncpus = ncpus;
+		node_groups[n].ncpus = ncpus;
 	}
 
-	numvecs = min_t(unsigned, remaining_ncpus, numvecs);
+	numgrps = min_t(unsigned, remaining_ncpus, numgrps);
 
-	sort(node_vectors, nr_node_ids, sizeof(node_vectors[0]),
+	sort(node_groups, nr_node_ids, sizeof(node_groups[0]),
 	     ncpus_cmp_func, NULL);
 
 	/*
-	 * Allocate vectors for each node according to the ratio of this
-	 * node's nr_cpus to remaining un-assigned ncpus. 'numvecs' is
+	 * Allocate groups for each node according to the ratio of this
+	 * node's nr_cpus to remaining un-assigned ncpus. 'numgrps' is
 	 * bigger than number of active numa nodes. Always start the
 	 * allocation from the node with minimized nr_cpus.
 	 *
 	 * This way guarantees that each active node gets allocated at
-	 * least one vector, and the theory is simple: over-allocation
-	 * is only done when this node is assigned by one vector, so
-	 * other nodes will be allocated >= 1 vector, since 'numvecs' is
+	 * least one group, and the theory is simple: over-allocation
+	 * is only done when this node is assigned by one group, so
+	 * other nodes will be allocated >= 1 groups, since 'numgrps' is
 	 * bigger than number of numa nodes.
 	 *
-	 * One perfect invariant is that number of allocated vectors for
+	 * One perfect invariant is that number of allocated groups for
 	 * each node is <= CPU count of this node:
 	 *
 	 * 1) suppose there are two nodes: A and B
 	 * 	ncpu(X) is CPU count of node X
-	 * 	vecs(X) is the vector count allocated to node X via this
+	 * 	grps(X) is the group count allocated to node X via this
 	 * 	algorithm
 	 *
 	 * 	ncpu(A) <= ncpu(B)
 	 * 	ncpu(A) + ncpu(B) = N
-	 * 	vecs(A) + vecs(B) = V
+	 * 	grps(A) + grps(B) = G
 	 *
-	 * 	vecs(A) = max(1, round_down(V * ncpu(A) / N))
-	 * 	vecs(B) = V - vecs(A)
+	 * 	grps(A) = max(1, round_down(G * ncpu(A) / N))
+	 * 	grps(B) = G - grps(A)
 	 *
-	 * 	both N and V are integer, and 2 <= V <= N, suppose
-	 * 	V = N - delta, and 0 <= delta <= N - 2
+	 * 	both N and G are integer, and 2 <= G <= N, suppose
+	 * 	G = N - delta, and 0 <= delta <= N - 2
 	 *
-	 * 2) obviously vecs(A) <= ncpu(A) because:
+	 * 2) obviously grps(A) <= ncpu(A) because:
 	 *
-	 * 	if vecs(A) is 1, then vecs(A) <= ncpu(A) given
+	 * 	if grps(A) is 1, then grps(A) <= ncpu(A) given
 	 * 	ncpu(A) >= 1
 	 *
 	 * 	otherwise,
-	 * 		vecs(A) <= V * ncpu(A) / N <= ncpu(A), given V <= N
+	 * 		grps(A) <= G * ncpu(A) / N <= ncpu(A), given G <= N
 	 *
-	 * 3) prove how vecs(B) <= ncpu(B):
+	 * 3) prove how grps(B) <= ncpu(B):
 	 *
-	 * 	if round_down(V * ncpu(A) / N) == 0, vecs(B) won't be
-	 * 	over-allocated, so vecs(B) <= ncpu(B),
+	 * 	if round_down(G * ncpu(A) / N) == 0, vecs(B) won't be
+	 * 	over-allocated, so grps(B) <= ncpu(B),
 	 *
 	 * 	otherwise:
 	 *
-	 * 	vecs(A) =
-	 * 		round_down(V * ncpu(A) / N) =
+	 * 	grps(A) =
+	 * 		round_down(G * ncpu(A) / N) =
 	 * 		round_down((N - delta) * ncpu(A) / N) =
 	 * 		round_down((N * ncpu(A) - delta * ncpu(A)) / N)	 >=
 	 * 		round_down((N * ncpu(A) - delta * N) / N)	 =
@@ -210,52 +210,50 @@ static void alloc_nodes_vectors(unsigned int numvecs,
 	 *
 	 * 	then:
 	 *
-	 * 	vecs(A) - V >= ncpu(A) - delta - V
+	 * 	grps(A) - G >= ncpu(A) - delta - G
 	 * 	=>
-	 * 	V - vecs(A) <= V + delta - ncpu(A)
+	 * 	G - grps(A) <= G + delta - ncpu(A)
 	 * 	=>
-	 * 	vecs(B) <= N - ncpu(A)
+	 * 	grps(B) <= N - ncpu(A)
 	 * 	=>
-	 * 	vecs(B) <= cpu(B)
+	 * 	grps(B) <= cpu(B)
 	 *
 	 * For nodes >= 3, it can be thought as one node and another big
 	 * node given that is exactly what this algorithm is implemented,
-	 * and we always re-calculate 'remaining_ncpus' & 'numvecs', and
-	 * finally for each node X: vecs(X) <= ncpu(X).
+	 * and we always re-calculate 'remaining_ncpus' & 'numgrps', and
+	 * finally for each node X: grps(X) <= ncpu(X).
 	 *
 	 */
 	for (n = 0; n < nr_node_ids; n++) {
-		unsigned nvectors, ncpus;
+		unsigned ngroups, ncpus;
 
-		if (node_vectors[n].ncpus == UINT_MAX)
+		if (node_groups[n].ncpus == UINT_MAX)
 			continue;
 
-		WARN_ON_ONCE(numvecs == 0);
+		WARN_ON_ONCE(numgrps == 0);
 
-		ncpus = node_vectors[n].ncpus;
-		nvectors = max_t(unsigned, 1,
-				 numvecs * ncpus / remaining_ncpus);
-		WARN_ON_ONCE(nvectors > ncpus);
+		ncpus = node_groups[n].ncpus;
+		ngroups = max_t(unsigned, 1,
+				 numgrps * ncpus / remaining_ncpus);
+		WARN_ON_ONCE(ngroups > ncpus);
 
-		node_vectors[n].nvectors = nvectors;
+		node_groups[n].ngroups = ngroups;
 
 		remaining_ncpus -= ncpus;
-		numvecs -= nvectors;
+		numgrps -= ngroups;
 	}
 }
 
-static int __irq_build_affinity_masks(unsigned int startvec,
-				      unsigned int numvecs,
-				      cpumask_var_t *node_to_cpumask,
-				      const struct cpumask *cpu_mask,
-				      struct cpumask *nmsk,
-				      struct cpumask *masks)
+static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
+			       cpumask_var_t *node_to_cpumask,
+			       const struct cpumask *cpu_mask,
+			       struct cpumask *nmsk, struct cpumask *masks)
 {
-	unsigned int i, n, nodes, cpus_per_vec, extra_vecs, done = 0;
-	unsigned int last_affv = numvecs;
-	unsigned int curvec = startvec;
+	unsigned int i, n, nodes, cpus_per_grp, extra_grps, done = 0;
+	unsigned int last_grp = numgrps;
+	unsigned int curgrp = startgrp;
 	nodemask_t nodemsk = NODE_MASK_NONE;
-	struct node_vectors *node_vectors;
+	struct node_groups *node_groups;
 
 	if (!cpumask_weight(cpu_mask))
 		return 0;
@@ -264,33 +262,33 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 
 	/*
 	 * If the number of nodes in the mask is greater than or equal the
-	 * number of vectors we just spread the vectors across the nodes.
+	 * number of groups we just spread the groups across the nodes.
 	 */
-	if (numvecs <= nodes) {
+	if (numgrps <= nodes) {
 		for_each_node_mask(n, nodemsk) {
-			cpumask_or(&masks[curvec], &masks[curvec],
+			cpumask_or(&masks[curgrp], &masks[curgrp],
 				   node_to_cpumask[n]);
-			if (++curvec == last_affv)
-				curvec = 0;
+			if (++curgrp == last_grp)
+				curgrp = 0;
 		}
-		return numvecs;
+		return numgrps;
 	}
 
-	node_vectors = kcalloc(nr_node_ids,
-			       sizeof(struct node_vectors),
+	node_groups = kcalloc(nr_node_ids,
+			       sizeof(struct node_groups),
 			       GFP_KERNEL);
-	if (!node_vectors)
+	if (!node_groups)
 		return -ENOMEM;
 
-	/* allocate vector number for each node */
-	alloc_nodes_vectors(numvecs, node_to_cpumask, cpu_mask,
-			    nodemsk, nmsk, node_vectors);
+	/* allocate group number for each node */
+	alloc_nodes_groups(numgrps, node_to_cpumask, cpu_mask,
+			   nodemsk, nmsk, node_groups);
 
 	for (i = 0; i < nr_node_ids; i++) {
 		unsigned int ncpus, v;
-		struct node_vectors *nv = &node_vectors[i];
+		struct node_groups *nv = &node_groups[i];
 
-		if (nv->nvectors == UINT_MAX)
+		if (nv->ngroups == UINT_MAX)
 			continue;
 
 		/* Get the cpus on this node which are in the mask */
@@ -299,44 +297,47 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 		if (!ncpus)
 			continue;
 
-		WARN_ON_ONCE(nv->nvectors > ncpus);
+		WARN_ON_ONCE(nv->ngroups > ncpus);
 
 		/* Account for rounding errors */
-		extra_vecs = ncpus - nv->nvectors * (ncpus / nv->nvectors);
+		extra_grps = ncpus - nv->ngroups * (ncpus / nv->ngroups);
 
-		/* Spread allocated vectors on CPUs of the current node */
-		for (v = 0; v < nv->nvectors; v++, curvec++) {
-			cpus_per_vec = ncpus / nv->nvectors;
+		/* Spread allocated groups on CPUs of the current node */
+		for (v = 0; v < nv->ngroups; v++, curgrp++) {
+			cpus_per_grp = ncpus / nv->ngroups;
 
-			/* Account for extra vectors to compensate rounding errors */
-			if (extra_vecs) {
-				cpus_per_vec++;
-				--extra_vecs;
+			/* Account for extra groups to compensate rounding errors */
+			if (extra_grps) {
+				cpus_per_grp++;
+				--extra_grps;
 			}
 
 			/*
-			 * wrapping has to be considered given 'startvec'
+			 * wrapping has to be considered given 'startgrp'
 			 * may start anywhere
 			 */
-			if (curvec >= last_affv)
-				curvec = 0;
-			irq_spread_init_one(&masks[curvec], nmsk,
-						cpus_per_vec);
+			if (curgrp >= last_grp)
+				curgrp = 0;
+			grp_spread_init_one(&masks[curgrp], nmsk,
+						cpus_per_grp);
 		}
-		done += nv->nvectors;
+		done += nv->ngroups;
 	}
-	kfree(node_vectors);
+	kfree(node_groups);
 	return done;
 }
 
 /*
- * build affinity in two stages:
- *	1) spread present CPU on these vectors
- *	2) spread other possible CPUs on these vectors
+ * build affinity in two stages for each group, and try to put close CPUs
+ * in viewpoint of CPU and NUMA locality into same group, and we run
+ * two-stage grouping:
+ *
+ *	1) allocate present CPUs on these groups evenly first
+ *	2) allocate other possible CPUs on these groups evenly
  */
-static struct cpumask *irq_build_affinity_masks(unsigned int numvecs)
+static struct cpumask *group_cpus_evenly(unsigned int numgrps)
 {
-	unsigned int curvec = 0, nr_present = 0, nr_others = 0;
+	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
 	cpumask_var_t *node_to_cpumask;
 	cpumask_var_t nmsk, npresmsk;
 	int ret = -ENOMEM;
@@ -352,7 +353,7 @@ static struct cpumask *irq_build_affinity_masks(unsigned int numvecs)
 	if (!node_to_cpumask)
 		goto fail_npresmsk;
 
-	masks = kcalloc(numvecs, sizeof(*masks), GFP_KERNEL);
+	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
 		goto fail_node_to_cpumask;
 
@@ -360,26 +361,26 @@ static struct cpumask *irq_build_affinity_masks(unsigned int numvecs)
 	cpus_read_lock();
 	build_node_to_cpumask(node_to_cpumask);
 
-	/* Spread on present CPUs starting from affd->pre_vectors */
-	ret = __irq_build_affinity_masks(curvec, numvecs, node_to_cpumask,
-					 cpu_present_mask, nmsk, masks);
+	/* grouping present CPUs first */
+	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
+				  cpu_present_mask, nmsk, masks);
 	if (ret < 0)
 		goto fail_build_affinity;
 	nr_present = ret;
 
 	/*
-	 * Spread on non present CPUs starting from the next vector to be
-	 * handled. If the spreading of present CPUs already exhausted the
-	 * vector space, assign the non present CPUs to the already spread
-	 * out vectors.
+	 * Allocate non present CPUs starting from the next group to be
+	 * handled. If the grouping of present CPUs already exhausted the
+	 * group space, assign the non present CPUs to the already
+	 * allocated out groups.
 	 */
-	if (nr_present >= numvecs)
-		curvec = 0;
+	if (nr_present >= numgrps)
+		curgrp = 0;
 	else
-		curvec = nr_present;
+		curgrp = nr_present;
 	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
-	ret = __irq_build_affinity_masks(curvec, numvecs, node_to_cpumask,
-					 npresmsk, nmsk, masks);
+	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
+				  npresmsk, nmsk, masks);
 	if (ret >= 0)
 		nr_others = ret;
 
@@ -387,7 +388,7 @@ static struct cpumask *irq_build_affinity_masks(unsigned int numvecs)
 	cpus_read_unlock();
 
 	if (ret >= 0)
-		WARN_ON(nr_present + nr_others < numvecs);
+		WARN_ON(nr_present + nr_others < numgrps);
 
  fail_node_to_cpumask:
 	free_node_to_cpumask(node_to_cpumask);
@@ -466,7 +467,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
 		unsigned int this_vecs = affd->set_size[i];
 		int j;
-		struct cpumask *result = irq_build_affinity_masks(this_vecs);
+		struct cpumask *result = group_cpus_evenly(this_vecs);
 
 		if (!result) {
 			kfree(masks);
-- 
2.31.1

