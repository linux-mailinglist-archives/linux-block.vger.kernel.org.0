Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E44FABC2
	for <lists+linux-block@lfdr.de>; Wed, 13 Nov 2019 09:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKMIGM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 Nov 2019 03:06:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:53656 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726613AbfKMIGM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 03:06:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 608E5AC44;
        Wed, 13 Nov 2019 08:06:10 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>
Subject: [PATCH 12/12] bcache: don't export symbols
Date:   Wed, 13 Nov 2019 16:03:26 +0800
Message-Id: <20191113080326.69989-13-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191113080326.69989-1-colyli@suse.de>
References: <20191113080326.69989-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

None of the exported bcache symbols are actually used anywhere.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bset.c    | 15 ---------------
 drivers/md/bcache/closure.c |  7 -------
 2 files changed, 22 deletions(-)

diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
index f37a429f093d..cffcdc9feefb 100644
--- a/drivers/md/bcache/bset.c
+++ b/drivers/md/bcache/bset.c
@@ -311,7 +311,6 @@ void bch_btree_keys_free(struct btree_keys *b)
 	t->tree = NULL;
 	t->data = NULL;
 }
-EXPORT_SYMBOL(bch_btree_keys_free);
 
 int bch_btree_keys_alloc(struct btree_keys *b,
 			 unsigned int page_order,
@@ -344,7 +343,6 @@ int bch_btree_keys_alloc(struct btree_keys *b,
 	bch_btree_keys_free(b);
 	return -ENOMEM;
 }
-EXPORT_SYMBOL(bch_btree_keys_alloc);
 
 void bch_btree_keys_init(struct btree_keys *b, const struct btree_keys_ops *ops,
 			 bool *expensive_debug_checks)
@@ -363,7 +361,6 @@ void bch_btree_keys_init(struct btree_keys *b, const struct btree_keys_ops *ops,
 	 * any more.
 	 */
 }
-EXPORT_SYMBOL(bch_btree_keys_init);
 
 /* Binary tree stuff for auxiliary search trees */
 
@@ -680,7 +677,6 @@ void bch_bset_init_next(struct btree_keys *b, struct bset *i, uint64_t magic)
 
 	bch_bset_build_unwritten_tree(b);
 }
-EXPORT_SYMBOL(bch_bset_init_next);
 
 /*
  * Build auxiliary binary tree 'struct bset_tree *t', this tree is used to
@@ -734,7 +730,6 @@ void bch_bset_build_written_tree(struct btree_keys *b)
 	     j = inorder_next(j, t->size))
 		make_bfloat(t, j);
 }
-EXPORT_SYMBOL(bch_bset_build_written_tree);
 
 /* Insert */
 
@@ -782,7 +777,6 @@ fix_right:	do {
 			j = j * 2 + 1;
 		} while (j < t->size);
 }
-EXPORT_SYMBOL(bch_bset_fix_invalidated_key);
 
 static void bch_bset_fix_lookup_table(struct btree_keys *b,
 				      struct bset_tree *t,
@@ -857,7 +851,6 @@ bool bch_bkey_try_merge(struct btree_keys *b, struct bkey *l, struct bkey *r)
 
 	return b->ops->key_merge(b, l, r);
 }
-EXPORT_SYMBOL(bch_bkey_try_merge);
 
 void bch_bset_insert(struct btree_keys *b, struct bkey *where,
 		     struct bkey *insert)
@@ -877,7 +870,6 @@ void bch_bset_insert(struct btree_keys *b, struct bkey *where,
 	bkey_copy(where, insert);
 	bch_bset_fix_lookup_table(b, t, where);
 }
-EXPORT_SYMBOL(bch_bset_insert);
 
 unsigned int bch_btree_insert_key(struct btree_keys *b, struct bkey *k,
 			      struct bkey *replace_key)
@@ -933,7 +925,6 @@ copy:	bkey_copy(m, k);
 merged:
 	return status;
 }
-EXPORT_SYMBOL(bch_btree_insert_key);
 
 /* Lookup */
 
@@ -1079,7 +1070,6 @@ struct bkey *__bch_bset_search(struct btree_keys *b, struct bset_tree *t,
 
 	return i.l;
 }
-EXPORT_SYMBOL(__bch_bset_search);
 
 /* Btree iterator */
 
@@ -1134,7 +1124,6 @@ struct bkey *bch_btree_iter_init(struct btree_keys *b,
 {
 	return __bch_btree_iter_init(b, iter, search, b->set);
 }
-EXPORT_SYMBOL(bch_btree_iter_init);
 
 static inline struct bkey *__bch_btree_iter_next(struct btree_iter *iter,
 						 btree_iter_cmp_fn *cmp)
@@ -1167,7 +1156,6 @@ struct bkey *bch_btree_iter_next(struct btree_iter *iter)
 	return __bch_btree_iter_next(iter, btree_iter_cmp);
 
 }
-EXPORT_SYMBOL(bch_btree_iter_next);
 
 struct bkey *bch_btree_iter_next_filter(struct btree_iter *iter,
 					struct btree_keys *b, ptr_filter_fn fn)
@@ -1198,7 +1186,6 @@ int bch_bset_sort_state_init(struct bset_sort_state *state,
 
 	return mempool_init_page_pool(&state->pool, 1, page_order);
 }
-EXPORT_SYMBOL(bch_bset_sort_state_init);
 
 static void btree_mergesort(struct btree_keys *b, struct bset *out,
 			    struct btree_iter *iter,
@@ -1315,7 +1302,6 @@ void bch_btree_sort_partial(struct btree_keys *b, unsigned int start,
 
 	EBUG_ON(oldsize >= 0 && bch_count_data(b) != oldsize);
 }
-EXPORT_SYMBOL(bch_btree_sort_partial);
 
 void bch_btree_sort_and_fix_extents(struct btree_keys *b,
 				    struct btree_iter *iter,
@@ -1368,7 +1354,6 @@ void bch_btree_sort_lazy(struct btree_keys *b, struct bset_sort_state *state)
 out:
 	bch_bset_build_written_tree(b);
 }
-EXPORT_SYMBOL(bch_btree_sort_lazy);
 
 void bch_btree_keys_stats(struct btree_keys *b, struct bset_stats *stats)
 {
diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
index c12cd809ab19..0164a1fe94a9 100644
--- a/drivers/md/bcache/closure.c
+++ b/drivers/md/bcache/closure.c
@@ -45,7 +45,6 @@ void closure_sub(struct closure *cl, int v)
 {
 	closure_put_after_sub(cl, atomic_sub_return(v, &cl->remaining));
 }
-EXPORT_SYMBOL(closure_sub);
 
 /*
  * closure_put - decrement a closure's refcount
@@ -54,7 +53,6 @@ void closure_put(struct closure *cl)
 {
 	closure_put_after_sub(cl, atomic_dec_return(&cl->remaining));
 }
-EXPORT_SYMBOL(closure_put);
 
 /*
  * closure_wake_up - wake up all closures on a wait list, without memory barrier
@@ -76,7 +74,6 @@ void __closure_wake_up(struct closure_waitlist *wait_list)
 		closure_sub(cl, CLOSURE_WAITING + 1);
 	}
 }
-EXPORT_SYMBOL(__closure_wake_up);
 
 /**
  * closure_wait - add a closure to a waitlist
@@ -96,7 +93,6 @@ bool closure_wait(struct closure_waitlist *waitlist, struct closure *cl)
 
 	return true;
 }
-EXPORT_SYMBOL(closure_wait);
 
 struct closure_syncer {
 	struct task_struct	*task;
@@ -131,7 +127,6 @@ void __sched __closure_sync(struct closure *cl)
 
 	__set_current_state(TASK_RUNNING);
 }
-EXPORT_SYMBOL(__closure_sync);
 
 #ifdef CONFIG_BCACHE_CLOSURES_DEBUG
 
@@ -149,7 +144,6 @@ void closure_debug_create(struct closure *cl)
 	list_add(&cl->all, &closure_list);
 	spin_unlock_irqrestore(&closure_list_lock, flags);
 }
-EXPORT_SYMBOL(closure_debug_create);
 
 void closure_debug_destroy(struct closure *cl)
 {
@@ -162,7 +156,6 @@ void closure_debug_destroy(struct closure *cl)
 	list_del(&cl->all);
 	spin_unlock_irqrestore(&closure_list_lock, flags);
 }
-EXPORT_SYMBOL(closure_debug_destroy);
 
 static struct dentry *closure_debug;
 
-- 
2.16.4

