Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0642615FD7D
	for <lists+linux-block@lfdr.de>; Sat, 15 Feb 2020 09:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgBOI3N (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 15 Feb 2020 03:29:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:42452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgBOI3N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Feb 2020 03:29:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AFDC2AEC7;
        Sat, 15 Feb 2020 08:29:11 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 2/3] bcache: make bch_btree_check() to be multiple threads
Date:   Sat, 15 Feb 2020 16:28:57 +0800
Message-Id: <20200215082858.128025-3-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200215082858.128025-1-colyli@suse.de>
References: <20200215082858.128025-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When registering a cache device, bch_btree_check() is called to check
all btree node, to make sure the btree is consistency and no corruption.

bch_btree_check() is recursively executed in single thread, when there
are a lot of data cached and the btree is huge, it may take very long
time to check all the btree nodes. In my testing, I observed it took
around 50 minutes to finish bch_btree_check().

When checking the bcache btree nodes, the cache set is not running yet,
and indeed the whole tree is in read-only state, it is safe to create
multiple threads to check the btree in parallel.

This patch tries to create multiple threads, and each thread tries to
one-by-one check the sub-tree indexed by a key from the btree root node.
The parallel thread number depends on how many keys in the btree root
node. At most BCH_BTR_CHKTHREAD_MAX (64) threads can be created, but in
practice is should be min(cpu-number/2, root-node-keys-number).

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/btree.c | 169 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/md/bcache/btree.h |  22 ++++++
 2 files changed, 188 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 99cb201809af..ce0289f58d38 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1897,13 +1897,176 @@ static int bch_btree_check_recurse(struct btree *b, struct btree_op *op)
 	return ret;
 }
 
+
+static int bch_btree_check_thread(void *arg)
+{
+	int ret;
+	struct btree_check_info *info = arg;
+	struct btree_check_state *check_state = info->state;
+	struct cache_set *c = check_state->c;
+	struct btree_iter iter;
+	struct bkey *k, *p;
+	int cur_idx, prev_idx, skip_nr;
+	int i, n;
+
+	k = p = NULL;
+	i = n = 0;
+	cur_idx = prev_idx = 0;
+	ret = 0;
+
+	/* root node keys are checked before thread created */
+	bch_btree_iter_init(&c->root->keys, &iter, NULL);
+	k = bch_btree_iter_next_filter(&iter, &c->root->keys, bch_ptr_bad);
+	BUG_ON(!k);
+
+	p = k;
+	while (k) {
+		/*
+		 * Fetch a root node key index, skip the keys which
+		 * should be fetched by other threads, then check the
+		 * sub-tree indexed by the fetched key.
+		 */
+		spin_lock(&check_state->idx_lock);
+		cur_idx = check_state->key_idx;
+		check_state->key_idx++;
+		spin_unlock(&check_state->idx_lock);
+
+		skip_nr = cur_idx - prev_idx;
+
+		while (skip_nr) {
+			k = bch_btree_iter_next_filter(&iter,
+						       &c->root->keys,
+						       bch_ptr_bad);
+			if (k)
+				p = k;
+			else {
+				/*
+				 * No more keys to check in root node,
+				 * current checking threads are enough,
+				 * stop creating more.
+				 */
+				atomic_set(&check_state->enough, 1);
+				/* Update check_state->enough earlier */
+				smp_mb();
+				goto out;
+			}
+			skip_nr--;
+			cond_resched();
+		}
+
+		if (p) {
+			struct btree_op op;
+
+			btree_node_prefetch(c->root, p);
+			c->gc_stats.nodes++;
+			bch_btree_op_init(&op, 0);
+			ret = btree(check_recurse, p, c->root, &op);
+			if (ret)
+				goto out;
+		}
+		p = NULL;
+		prev_idx = cur_idx;
+		cond_resched();
+	}
+
+out:
+	info->result = ret;
+	/* update check_state->started among all CPUs */
+	smp_mb();
+	if (atomic_dec_and_test(&check_state->started))
+		wake_up(&check_state->wait);
+
+	return ret;
+}
+
+
+
+static int bch_btree_chkthread_nr(void)
+{
+	int n = num_online_cpus()/2;
+
+	if (n == 0)
+		n = 1;
+	else if (n > BCH_BTR_CHKTHREAD_MAX)
+		n = BCH_BTR_CHKTHREAD_MAX;
+
+	return n;
+}
+
 int bch_btree_check(struct cache_set *c)
 {
-	struct btree_op op;
+	int ret = 0;
+	int i;
+	struct bkey *k = NULL;
+	struct btree_iter iter;
+	struct btree_check_state *check_state;
+	char name[32];
 
-	bch_btree_op_init(&op, SHRT_MAX);
+	/* check and mark root node keys */
+	for_each_key_filter(&c->root->keys, k, &iter, bch_ptr_invalid)
+		bch_initial_mark_key(c, c->root->level, k);
+
+	bch_initial_mark_key(c, c->root->level + 1, &c->root->key);
+
+	if (c->root->level == 0)
+		return 0;
+
+	check_state = kzalloc(sizeof(struct btree_check_state), GFP_KERNEL);
+	if (!check_state)
+		return -ENOMEM;
+
+	check_state->c = c;
+	check_state->total_threads = bch_btree_chkthread_nr();
+	check_state->key_idx = 0;
+	spin_lock_init(&check_state->idx_lock);
+	atomic_set(&check_state->started, 0);
+	atomic_set(&check_state->enough, 0);
+	init_waitqueue_head(&check_state->wait);
 
-	return btree_root(check_recurse, c, &op);
+	/*
+	 * Run multiple threads to check btree nodes in parallel,
+	 * if check_state->enough is non-zero, it means current
+	 * running check threads are enough, unncessary to create
+	 * more.
+	 */
+	for (i = 0; i < check_state->total_threads; i++) {
+		/* fetch latest check_state->enough earlier */
+		smp_mb();
+		if (atomic_read(&check_state->enough))
+			break;
+
+		check_state->infos[i].result = 0;
+		check_state->infos[i].state = check_state;
+		snprintf(name, sizeof(name), "bch_btrchk[%u]", i);
+		atomic_inc(&check_state->started);
+
+		check_state->infos[i].thread =
+			kthread_run(bch_btree_check_thread,
+				    &check_state->infos[i],
+				    name);
+		if (IS_ERR(check_state->infos[i].thread)) {
+			pr_err("fails to run thread bch_btrchk[%d]", i);
+			for (--i; i >= 0; i--)
+				kthread_stop(check_state->infos[i].thread);
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	wait_event_interruptible(check_state->wait,
+				 atomic_read(&check_state->started) == 0 ||
+				  test_bit(CACHE_SET_IO_DISABLE, &c->flags));
+
+	for (i = 0; i < check_state->total_threads; i++) {
+		if (check_state->infos[i].result) {
+			ret = check_state->infos[i].result;
+			goto out;
+		}
+	}
+
+out:
+	kfree(check_state);
+	return ret;
 }
 
 void bch_initial_gc_finish(struct cache_set *c)
diff --git a/drivers/md/bcache/btree.h b/drivers/md/bcache/btree.h
index f37153db3f6c..38ca4ab08f2f 100644
--- a/drivers/md/bcache/btree.h
+++ b/drivers/md/bcache/btree.h
@@ -145,6 +145,9 @@ struct btree {
 	struct bio		*bio;
 };
 
+
+
+
 #define BTREE_FLAG(flag)						\
 static inline bool btree_node_ ## flag(struct btree *b)			\
 {	return test_bit(BTREE_NODE_ ## flag, &b->flags); }		\
@@ -216,6 +219,25 @@ struct btree_op {
 	unsigned int		insert_collision:1;
 };
 
+struct btree_check_state;
+struct btree_check_info {
+	struct btree_check_state	*state;
+	struct task_struct		*thread;
+	int				result;
+};
+
+#define BCH_BTR_CHKTHREAD_MAX	64
+struct btree_check_state {
+	struct cache_set		*c;
+	int				total_threads;
+	int				key_idx;
+	spinlock_t			idx_lock;
+	atomic_t			started;
+	atomic_t			enough;
+	wait_queue_head_t		wait;
+	struct btree_check_info		infos[BCH_BTR_CHKTHREAD_MAX];
+};
+
 static inline void bch_btree_op_init(struct btree_op *op, int write_lock_level)
 {
 	memset(op, 0, sizeof(struct btree_op));
-- 
2.16.4

