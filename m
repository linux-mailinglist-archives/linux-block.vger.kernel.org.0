Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3517224E72B
	for <lists+linux-block@lfdr.de>; Sat, 22 Aug 2020 13:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgHVLp5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 22 Aug 2020 07:45:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:56690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgHVLpz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Aug 2020 07:45:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5754DAD2C;
        Sat, 22 Aug 2020 11:46:19 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 03/12] bcache: remove for_each_cache()
Date:   Sat, 22 Aug 2020 19:45:27 +0800
Message-Id: <20200822114536.23491-4-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200822114536.23491-1-colyli@suse.de>
References: <20200822114536.23491-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since now each cache_set explicitly has single cache, for_each_cache()
is unnecessary. This patch removes this macro, and update all locations
where it is used, and makes sure all code logic still being consistent.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/bcache/alloc.c    |  17 ++-
 drivers/md/bcache/bcache.h   |   9 +-
 drivers/md/bcache/btree.c    | 103 +++++++---------
 drivers/md/bcache/journal.c  | 229 ++++++++++++++++-------------------
 drivers/md/bcache/movinggc.c |  58 +++++----
 drivers/md/bcache/super.c    | 115 ++++++++----------
 6 files changed, 237 insertions(+), 294 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 3385f6add6df..1b8310992dd0 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -88,7 +88,6 @@ void bch_rescale_priorities(struct cache_set *c, int sectors)
 	struct cache *ca;
 	struct bucket *b;
 	unsigned long next = c->nbuckets * c->sb.bucket_size / 1024;
-	unsigned int i;
 	int r;
 
 	atomic_sub(sectors, &c->rescale);
@@ -104,14 +103,14 @@ void bch_rescale_priorities(struct cache_set *c, int sectors)
 
 	c->min_prio = USHRT_MAX;
 
-	for_each_cache(ca, c, i)
-		for_each_bucket(b, ca)
-			if (b->prio &&
-			    b->prio != BTREE_PRIO &&
-			    !atomic_read(&b->pin)) {
-				b->prio--;
-				c->min_prio = min(c->min_prio, b->prio);
-			}
+	ca = c->cache;
+	for_each_bucket(b, ca)
+		if (b->prio &&
+		    b->prio != BTREE_PRIO &&
+		    !atomic_read(&b->pin)) {
+			b->prio--;
+			c->min_prio = min(c->min_prio, b->prio);
+		}
 
 	mutex_unlock(&c->bucket_lock);
 }
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index aa112c1adba1..7ffe6b2d179b 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -887,9 +887,6 @@ do {									\
 
 /* Looping macros */
 
-#define for_each_cache(ca, cs, iter)					\
-	for (iter = 0; ca = cs->cache, iter < 1; iter++)
-
 #define for_each_bucket(b, ca)						\
 	for (b = (ca)->buckets + (ca)->sb.first_bucket;			\
 	     b < (ca)->buckets + (ca)->sb.nbuckets; b++)
@@ -931,11 +928,9 @@ static inline uint8_t bucket_gc_gen(struct bucket *b)
 
 static inline void wake_up_allocators(struct cache_set *c)
 {
-	struct cache *ca;
-	unsigned int i;
+	struct cache *ca = c->cache;
 
-	for_each_cache(ca, c, i)
-		wake_up_process(ca->alloc_thread);
+	wake_up_process(ca->alloc_thread);
 }
 
 static inline void closure_bio_submit(struct cache_set *c,
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index e2a719fed53b..0817ad510d9f 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1167,19 +1167,18 @@ static void make_btree_freeing_key(struct btree *b, struct bkey *k)
 static int btree_check_reserve(struct btree *b, struct btree_op *op)
 {
 	struct cache_set *c = b->c;
-	struct cache *ca;
-	unsigned int i, reserve = (c->root->level - b->level) * 2 + 1;
+	struct cache *ca = c->cache;
+	unsigned int reserve = (c->root->level - b->level) * 2 + 1;
 
 	mutex_lock(&c->bucket_lock);
 
-	for_each_cache(ca, c, i)
-		if (fifo_used(&ca->free[RESERVE_BTREE]) < reserve) {
-			if (op)
-				prepare_to_wait(&c->btree_cache_wait, &op->wait,
-						TASK_UNINTERRUPTIBLE);
-			mutex_unlock(&c->bucket_lock);
-			return -EINTR;
-		}
+	if (fifo_used(&ca->free[RESERVE_BTREE]) < reserve) {
+		if (op)
+			prepare_to_wait(&c->btree_cache_wait, &op->wait,
+					TASK_UNINTERRUPTIBLE);
+		mutex_unlock(&c->bucket_lock);
+		return -EINTR;
+	}
 
 	mutex_unlock(&c->bucket_lock);
 
@@ -1695,7 +1694,6 @@ static void btree_gc_start(struct cache_set *c)
 {
 	struct cache *ca;
 	struct bucket *b;
-	unsigned int i;
 
 	if (!c->gc_mark_valid)
 		return;
@@ -1705,14 +1703,14 @@ static void btree_gc_start(struct cache_set *c)
 	c->gc_mark_valid = 0;
 	c->gc_done = ZERO_KEY;
 
-	for_each_cache(ca, c, i)
-		for_each_bucket(b, ca) {
-			b->last_gc = b->gen;
-			if (!atomic_read(&b->pin)) {
-				SET_GC_MARK(b, 0);
-				SET_GC_SECTORS_USED(b, 0);
-			}
+	ca = c->cache;
+	for_each_bucket(b, ca) {
+		b->last_gc = b->gen;
+		if (!atomic_read(&b->pin)) {
+			SET_GC_MARK(b, 0);
+			SET_GC_SECTORS_USED(b, 0);
 		}
+	}
 
 	mutex_unlock(&c->bucket_lock);
 }
@@ -1721,7 +1719,8 @@ static void bch_btree_gc_finish(struct cache_set *c)
 {
 	struct bucket *b;
 	struct cache *ca;
-	unsigned int i;
+	unsigned int i, j;
+	uint64_t *k;
 
 	mutex_lock(&c->bucket_lock);
 
@@ -1739,7 +1738,6 @@ static void bch_btree_gc_finish(struct cache_set *c)
 		struct bcache_device *d = c->devices[i];
 		struct cached_dev *dc;
 		struct keybuf_key *w, *n;
-		unsigned int j;
 
 		if (!d || UUID_FLASH_ONLY(&c->uuids[i]))
 			continue;
@@ -1756,29 +1754,27 @@ static void bch_btree_gc_finish(struct cache_set *c)
 	rcu_read_unlock();
 
 	c->avail_nbuckets = 0;
-	for_each_cache(ca, c, i) {
-		uint64_t *i;
 
-		ca->invalidate_needs_gc = 0;
+	ca = c->cache;
+	ca->invalidate_needs_gc = 0;
 
-		for (i = ca->sb.d; i < ca->sb.d + ca->sb.keys; i++)
-			SET_GC_MARK(ca->buckets + *i, GC_MARK_METADATA);
+	for (k = ca->sb.d; k < ca->sb.d + ca->sb.keys; k++)
+		SET_GC_MARK(ca->buckets + *k, GC_MARK_METADATA);
 
-		for (i = ca->prio_buckets;
-		     i < ca->prio_buckets + prio_buckets(ca) * 2; i++)
-			SET_GC_MARK(ca->buckets + *i, GC_MARK_METADATA);
+	for (k = ca->prio_buckets;
+	     k < ca->prio_buckets + prio_buckets(ca) * 2; k++)
+		SET_GC_MARK(ca->buckets + *k, GC_MARK_METADATA);
 
-		for_each_bucket(b, ca) {
-			c->need_gc	= max(c->need_gc, bucket_gc_gen(b));
+	for_each_bucket(b, ca) {
+		c->need_gc	= max(c->need_gc, bucket_gc_gen(b));
 
-			if (atomic_read(&b->pin))
-				continue;
+		if (atomic_read(&b->pin))
+			continue;
 
-			BUG_ON(!GC_MARK(b) && GC_SECTORS_USED(b));
+		BUG_ON(!GC_MARK(b) && GC_SECTORS_USED(b));
 
-			if (!GC_MARK(b) || GC_MARK(b) == GC_MARK_RECLAIMABLE)
-				c->avail_nbuckets++;
-		}
+		if (!GC_MARK(b) || GC_MARK(b) == GC_MARK_RECLAIMABLE)
+			c->avail_nbuckets++;
 	}
 
 	mutex_unlock(&c->bucket_lock);
@@ -1830,12 +1826,10 @@ static void bch_btree_gc(struct cache_set *c)
 
 static bool gc_should_run(struct cache_set *c)
 {
-	struct cache *ca;
-	unsigned int i;
+	struct cache *ca = c->cache;
 
-	for_each_cache(ca, c, i)
-		if (ca->invalidate_needs_gc)
-			return true;
+	if (ca->invalidate_needs_gc)
+		return true;
 
 	if (atomic_read(&c->sectors_to_gc) < 0)
 		return true;
@@ -2081,9 +2075,8 @@ int bch_btree_check(struct cache_set *c)
 
 void bch_initial_gc_finish(struct cache_set *c)
 {
-	struct cache *ca;
+	struct cache *ca = c->cache;
 	struct bucket *b;
-	unsigned int i;
 
 	bch_btree_gc_finish(c);
 
@@ -2098,20 +2091,18 @@ void bch_initial_gc_finish(struct cache_set *c)
 	 * This is only safe for buckets that have no live data in them, which
 	 * there should always be some of.
 	 */
-	for_each_cache(ca, c, i) {
-		for_each_bucket(b, ca) {
-			if (fifo_full(&ca->free[RESERVE_PRIO]) &&
-			    fifo_full(&ca->free[RESERVE_BTREE]))
-				break;
+	for_each_bucket(b, ca) {
+		if (fifo_full(&ca->free[RESERVE_PRIO]) &&
+		    fifo_full(&ca->free[RESERVE_BTREE]))
+			break;
 
-			if (bch_can_invalidate_bucket(ca, b) &&
-			    !GC_MARK(b)) {
-				__bch_invalidate_one_bucket(ca, b);
-				if (!fifo_push(&ca->free[RESERVE_PRIO],
-				   b - ca->buckets))
-					fifo_push(&ca->free[RESERVE_BTREE],
-						  b - ca->buckets);
-			}
+		if (bch_can_invalidate_bucket(ca, b) &&
+		    !GC_MARK(b)) {
+			__bch_invalidate_one_bucket(ca, b);
+			if (!fifo_push(&ca->free[RESERVE_PRIO],
+			   b - ca->buckets))
+				fifo_push(&ca->free[RESERVE_BTREE],
+					  b - ca->buckets);
 		}
 	}
 
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 77fbfd52edcf..027d0f8c4daf 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -179,112 +179,109 @@ int bch_journal_read(struct cache_set *c, struct list_head *list)
 		ret;							\
 	})
 
-	struct cache *ca;
-	unsigned int iter;
+	struct cache *ca = c->cache;
 	int ret = 0;
+	struct journal_device *ja = &ca->journal;
+	DECLARE_BITMAP(bitmap, SB_JOURNAL_BUCKETS);
+	unsigned int i, l, r, m;
+	uint64_t seq;
 
-	for_each_cache(ca, c, iter) {
-		struct journal_device *ja = &ca->journal;
-		DECLARE_BITMAP(bitmap, SB_JOURNAL_BUCKETS);
-		unsigned int i, l, r, m;
-		uint64_t seq;
-
-		bitmap_zero(bitmap, SB_JOURNAL_BUCKETS);
-		pr_debug("%u journal buckets\n", ca->sb.njournal_buckets);
+	bitmap_zero(bitmap, SB_JOURNAL_BUCKETS);
+	pr_debug("%u journal buckets\n", ca->sb.njournal_buckets);
 
+	/*
+	 * Read journal buckets ordered by golden ratio hash to quickly
+	 * find a sequence of buckets with valid journal entries
+	 */
+	for (i = 0; i < ca->sb.njournal_buckets; i++) {
 		/*
-		 * Read journal buckets ordered by golden ratio hash to quickly
-		 * find a sequence of buckets with valid journal entries
+		 * We must try the index l with ZERO first for
+		 * correctness due to the scenario that the journal
+		 * bucket is circular buffer which might have wrapped
 		 */
-		for (i = 0; i < ca->sb.njournal_buckets; i++) {
-			/*
-			 * We must try the index l with ZERO first for
-			 * correctness due to the scenario that the journal
-			 * bucket is circular buffer which might have wrapped
-			 */
-			l = (i * 2654435769U) % ca->sb.njournal_buckets;
+		l = (i * 2654435769U) % ca->sb.njournal_buckets;
 
-			if (test_bit(l, bitmap))
-				break;
+		if (test_bit(l, bitmap))
+			break;
 
-			if (read_bucket(l))
-				goto bsearch;
-		}
+		if (read_bucket(l))
+			goto bsearch;
+	}
 
-		/*
-		 * If that fails, check all the buckets we haven't checked
-		 * already
-		 */
-		pr_debug("falling back to linear search\n");
+	/*
+	 * If that fails, check all the buckets we haven't checked
+	 * already
+	 */
+	pr_debug("falling back to linear search\n");
 
-		for_each_clear_bit(l, bitmap, ca->sb.njournal_buckets)
-			if (read_bucket(l))
-				goto bsearch;
+	for_each_clear_bit(l, bitmap, ca->sb.njournal_buckets)
+		if (read_bucket(l))
+			goto bsearch;
 
-		/* no journal entries on this device? */
-		if (l == ca->sb.njournal_buckets)
-			continue;
+	/* no journal entries on this device? */
+	if (l == ca->sb.njournal_buckets)
+		goto out;
 bsearch:
-		BUG_ON(list_empty(list));
+	BUG_ON(list_empty(list));
 
-		/* Binary search */
-		m = l;
-		r = find_next_bit(bitmap, ca->sb.njournal_buckets, l + 1);
-		pr_debug("starting binary search, l %u r %u\n", l, r);
+	/* Binary search */
+	m = l;
+	r = find_next_bit(bitmap, ca->sb.njournal_buckets, l + 1);
+	pr_debug("starting binary search, l %u r %u\n", l, r);
 
-		while (l + 1 < r) {
-			seq = list_entry(list->prev, struct journal_replay,
-					 list)->j.seq;
+	while (l + 1 < r) {
+		seq = list_entry(list->prev, struct journal_replay,
+				 list)->j.seq;
 
-			m = (l + r) >> 1;
-			read_bucket(m);
+		m = (l + r) >> 1;
+		read_bucket(m);
 
-			if (seq != list_entry(list->prev, struct journal_replay,
-					      list)->j.seq)
-				l = m;
-			else
-				r = m;
-		}
+		if (seq != list_entry(list->prev, struct journal_replay,
+				      list)->j.seq)
+			l = m;
+		else
+			r = m;
+	}
 
-		/*
-		 * Read buckets in reverse order until we stop finding more
-		 * journal entries
-		 */
-		pr_debug("finishing up: m %u njournal_buckets %u\n",
-			 m, ca->sb.njournal_buckets);
-		l = m;
+	/*
+	 * Read buckets in reverse order until we stop finding more
+	 * journal entries
+	 */
+	pr_debug("finishing up: m %u njournal_buckets %u\n",
+		 m, ca->sb.njournal_buckets);
+	l = m;
 
-		while (1) {
-			if (!l--)
-				l = ca->sb.njournal_buckets - 1;
+	while (1) {
+		if (!l--)
+			l = ca->sb.njournal_buckets - 1;
 
-			if (l == m)
-				break;
+		if (l == m)
+			break;
 
-			if (test_bit(l, bitmap))
-				continue;
+		if (test_bit(l, bitmap))
+			continue;
 
-			if (!read_bucket(l))
-				break;
-		}
+		if (!read_bucket(l))
+			break;
+	}
 
-		seq = 0;
+	seq = 0;
 
-		for (i = 0; i < ca->sb.njournal_buckets; i++)
-			if (ja->seq[i] > seq) {
-				seq = ja->seq[i];
-				/*
-				 * When journal_reclaim() goes to allocate for
-				 * the first time, it'll use the bucket after
-				 * ja->cur_idx
-				 */
-				ja->cur_idx = i;
-				ja->last_idx = ja->discard_idx = (i + 1) %
-					ca->sb.njournal_buckets;
+	for (i = 0; i < ca->sb.njournal_buckets; i++)
+		if (ja->seq[i] > seq) {
+			seq = ja->seq[i];
+			/*
+			 * When journal_reclaim() goes to allocate for
+			 * the first time, it'll use the bucket after
+			 * ja->cur_idx
+			 */
+			ja->cur_idx = i;
+			ja->last_idx = ja->discard_idx = (i + 1) %
+				ca->sb.njournal_buckets;
 
-			}
-	}
+		}
 
+out:
 	if (!list_empty(list))
 		c->journal.seq = list_entry(list->prev,
 					    struct journal_replay,
@@ -342,12 +339,10 @@ void bch_journal_mark(struct cache_set *c, struct list_head *list)
 
 static bool is_discard_enabled(struct cache_set *s)
 {
-	struct cache *ca;
-	unsigned int i;
+	struct cache *ca = s->cache;
 
-	for_each_cache(ca, s, i)
-		if (ca->discard)
-			return true;
+	if (ca->discard)
+		return true;
 
 	return false;
 }
@@ -633,9 +628,10 @@ static void do_journal_discard(struct cache *ca)
 static void journal_reclaim(struct cache_set *c)
 {
 	struct bkey *k = &c->journal.key;
-	struct cache *ca;
+	struct cache *ca = c->cache;
 	uint64_t last_seq;
-	unsigned int iter, n = 0;
+	unsigned int next;
+	struct journal_device *ja = &ca->journal;
 	atomic_t p __maybe_unused;
 
 	atomic_long_inc(&c->reclaim);
@@ -647,46 +643,31 @@ static void journal_reclaim(struct cache_set *c)
 
 	/* Update last_idx */
 
-	for_each_cache(ca, c, iter) {
-		struct journal_device *ja = &ca->journal;
-
-		while (ja->last_idx != ja->cur_idx &&
-		       ja->seq[ja->last_idx] < last_seq)
-			ja->last_idx = (ja->last_idx + 1) %
-				ca->sb.njournal_buckets;
-	}
+	while (ja->last_idx != ja->cur_idx &&
+	       ja->seq[ja->last_idx] < last_seq)
+		ja->last_idx = (ja->last_idx + 1) %
+			ca->sb.njournal_buckets;
 
-	for_each_cache(ca, c, iter)
-		do_journal_discard(ca);
+	do_journal_discard(ca);
 
 	if (c->journal.blocks_free)
 		goto out;
 
-	/*
-	 * Allocate:
-	 * XXX: Sort by free journal space
-	 */
-
-	for_each_cache(ca, c, iter) {
-		struct journal_device *ja = &ca->journal;
-		unsigned int next = (ja->cur_idx + 1) % ca->sb.njournal_buckets;
+	next = (ja->cur_idx + 1) % ca->sb.njournal_buckets;
+	/* No space available on this device */
+	if (next == ja->discard_idx)
+		goto out;
 
-		/* No space available on this device */
-		if (next == ja->discard_idx)
-			continue;
+	ja->cur_idx = next;
+	k->ptr[0] = MAKE_PTR(0,
+			     bucket_to_sector(c, ca->sb.d[ja->cur_idx]),
+			     ca->sb.nr_this_dev);
+	atomic_long_inc(&c->reclaimed_journal_buckets);
 
-		ja->cur_idx = next;
-		k->ptr[n++] = MAKE_PTR(0,
-				  bucket_to_sector(c, ca->sb.d[ja->cur_idx]),
-				  ca->sb.nr_this_dev);
-		atomic_long_inc(&c->reclaimed_journal_buckets);
-	}
+	bkey_init(k);
+	SET_KEY_PTRS(k, 1);
+	c->journal.blocks_free = c->sb.bucket_size >> c->block_bits;
 
-	if (n) {
-		bkey_init(k);
-		SET_KEY_PTRS(k, n);
-		c->journal.blocks_free = c->sb.bucket_size >> c->block_bits;
-	}
 out:
 	if (!journal_full(&c->journal))
 		__closure_wake_up(&c->journal.wait);
@@ -750,7 +731,7 @@ static void journal_write_unlocked(struct closure *cl)
 	__releases(c->journal.lock)
 {
 	struct cache_set *c = container_of(cl, struct cache_set, journal.io);
-	struct cache *ca;
+	struct cache *ca = c->cache;
 	struct journal_write *w = c->journal.cur;
 	struct bkey *k = &c->journal.key;
 	unsigned int i, sectors = set_blocks(w->data, block_bytes(c)) *
@@ -780,9 +761,7 @@ static void journal_write_unlocked(struct closure *cl)
 	bkey_copy(&w->data->btree_root, &c->root->key);
 	bkey_copy(&w->data->uuid_bucket, &c->uuid_bucket);
 
-	for_each_cache(ca, c, i)
-		w->data->prio_bucket[ca->sb.nr_this_dev] = ca->prio_buckets[0];
-
+	w->data->prio_bucket[ca->sb.nr_this_dev] = ca->prio_buckets[0];
 	w->data->magic		= jset_magic(&c->sb);
 	w->data->version	= BCACHE_JSET_VERSION;
 	w->data->last_seq	= last_seq(&c->journal);
diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
index 5872d6470470..b9c3d27ec093 100644
--- a/drivers/md/bcache/movinggc.c
+++ b/drivers/md/bcache/movinggc.c
@@ -196,50 +196,48 @@ static unsigned int bucket_heap_top(struct cache *ca)
 
 void bch_moving_gc(struct cache_set *c)
 {
-	struct cache *ca;
+	struct cache *ca = c->cache;
 	struct bucket *b;
-	unsigned int i;
+	unsigned long sectors_to_move, reserve_sectors;
 
 	if (!c->copy_gc_enabled)
 		return;
 
 	mutex_lock(&c->bucket_lock);
 
-	for_each_cache(ca, c, i) {
-		unsigned long sectors_to_move = 0;
-		unsigned long reserve_sectors = ca->sb.bucket_size *
+	sectors_to_move = 0;
+	reserve_sectors = ca->sb.bucket_size *
 			     fifo_used(&ca->free[RESERVE_MOVINGGC]);
 
-		ca->heap.used = 0;
-
-		for_each_bucket(b, ca) {
-			if (GC_MARK(b) == GC_MARK_METADATA ||
-			    !GC_SECTORS_USED(b) ||
-			    GC_SECTORS_USED(b) == ca->sb.bucket_size ||
-			    atomic_read(&b->pin))
-				continue;
-
-			if (!heap_full(&ca->heap)) {
-				sectors_to_move += GC_SECTORS_USED(b);
-				heap_add(&ca->heap, b, bucket_cmp);
-			} else if (bucket_cmp(b, heap_peek(&ca->heap))) {
-				sectors_to_move -= bucket_heap_top(ca);
-				sectors_to_move += GC_SECTORS_USED(b);
-
-				ca->heap.data[0] = b;
-				heap_sift(&ca->heap, 0, bucket_cmp);
-			}
-		}
+	ca->heap.used = 0;
+
+	for_each_bucket(b, ca) {
+		if (GC_MARK(b) == GC_MARK_METADATA ||
+		    !GC_SECTORS_USED(b) ||
+		    GC_SECTORS_USED(b) == ca->sb.bucket_size ||
+		    atomic_read(&b->pin))
+			continue;
 
-		while (sectors_to_move > reserve_sectors) {
-			heap_pop(&ca->heap, b, bucket_cmp);
-			sectors_to_move -= GC_SECTORS_USED(b);
+		if (!heap_full(&ca->heap)) {
+			sectors_to_move += GC_SECTORS_USED(b);
+			heap_add(&ca->heap, b, bucket_cmp);
+		} else if (bucket_cmp(b, heap_peek(&ca->heap))) {
+			sectors_to_move -= bucket_heap_top(ca);
+			sectors_to_move += GC_SECTORS_USED(b);
+
+			ca->heap.data[0] = b;
+			heap_sift(&ca->heap, 0, bucket_cmp);
 		}
+	}
 
-		while (heap_pop(&ca->heap, b, bucket_cmp))
-			SET_GC_MOVE(b, 1);
+	while (sectors_to_move > reserve_sectors) {
+		heap_pop(&ca->heap, b, bucket_cmp);
+		sectors_to_move -= GC_SECTORS_USED(b);
 	}
 
+	while (heap_pop(&ca->heap, b, bucket_cmp))
+		SET_GC_MOVE(b, 1);
+
 	mutex_unlock(&c->bucket_lock);
 
 	c->moving_gc_keys.last_scanned = ZERO_KEY;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index e9ccfa17beb8..91883d5c4b62 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -343,8 +343,9 @@ static void bcache_write_super_unlock(struct closure *cl)
 void bcache_write_super(struct cache_set *c)
 {
 	struct closure *cl = &c->sb_write;
-	struct cache *ca;
-	unsigned int i, version = BCACHE_SB_VERSION_CDEV_WITH_UUID;
+	struct cache *ca = c->cache;
+	struct bio *bio = &ca->sb_bio;
+	unsigned int version = BCACHE_SB_VERSION_CDEV_WITH_UUID;
 
 	down(&c->sb_write_mutex);
 	closure_init(cl, &c->cl);
@@ -354,23 +355,19 @@ void bcache_write_super(struct cache_set *c)
 	if (c->sb.version > version)
 		version = c->sb.version;
 
-	for_each_cache(ca, c, i) {
-		struct bio *bio = &ca->sb_bio;
-
-		ca->sb.version		= version;
-		ca->sb.seq		= c->sb.seq;
-		ca->sb.last_mount	= c->sb.last_mount;
+	ca->sb.version		= version;
+	ca->sb.seq		= c->sb.seq;
+	ca->sb.last_mount	= c->sb.last_mount;
 
-		SET_CACHE_SYNC(&ca->sb, CACHE_SYNC(&c->sb));
+	SET_CACHE_SYNC(&ca->sb, CACHE_SYNC(&c->sb));
 
-		bio_init(bio, ca->sb_bv, 1);
-		bio_set_dev(bio, ca->bdev);
-		bio->bi_end_io	= write_super_endio;
-		bio->bi_private = ca;
+	bio_init(bio, ca->sb_bv, 1);
+	bio_set_dev(bio, ca->bdev);
+	bio->bi_end_io	= write_super_endio;
+	bio->bi_private = ca;
 
-		closure_get(cl);
-		__write_super(&ca->sb, ca->sb_disk, bio);
-	}
+	closure_get(cl);
+	__write_super(&ca->sb, ca->sb_disk, bio);
 
 	closure_return_with_destructor(cl, bcache_write_super_unlock);
 }
@@ -772,26 +769,22 @@ static void bcache_device_unlink(struct bcache_device *d)
 	lockdep_assert_held(&bch_register_lock);
 
 	if (d->c && !test_and_set_bit(BCACHE_DEV_UNLINK_DONE, &d->flags)) {
-		unsigned int i;
-		struct cache *ca;
+		struct cache *ca = d->c->cache;
 
 		sysfs_remove_link(&d->c->kobj, d->name);
 		sysfs_remove_link(&d->kobj, "cache");
 
-		for_each_cache(ca, d->c, i)
-			bd_unlink_disk_holder(ca->bdev, d->disk);
+		bd_unlink_disk_holder(ca->bdev, d->disk);
 	}
 }
 
 static void bcache_device_link(struct bcache_device *d, struct cache_set *c,
 			       const char *name)
 {
-	unsigned int i;
-	struct cache *ca;
+	struct cache *ca = c->cache;
 	int ret;
 
-	for_each_cache(ca, d->c, i)
-		bd_link_disk_holder(ca->bdev, d->disk);
+	bd_link_disk_holder(ca->bdev, d->disk);
 
 	snprintf(d->name, BCACHEDEVNAME_SIZE,
 		 "%s%u", name, d->id);
@@ -1663,7 +1656,6 @@ static void cache_set_free(struct closure *cl)
 {
 	struct cache_set *c = container_of(cl, struct cache_set, cl);
 	struct cache *ca;
-	unsigned int i;
 
 	debugfs_remove(c->debug);
 
@@ -1672,12 +1664,12 @@ static void cache_set_free(struct closure *cl)
 	bch_journal_free(c);
 
 	mutex_lock(&bch_register_lock);
-	for_each_cache(ca, c, i)
-		if (ca) {
-			ca->set = NULL;
-			c->cache = NULL;
-			kobject_put(&ca->kobj);
-		}
+	ca = c->cache;
+	if (ca) {
+		ca->set = NULL;
+		c->cache = NULL;
+		kobject_put(&ca->kobj);
+	}
 
 	bch_bset_sort_state_free(&c->sort);
 	free_pages((unsigned long) c->uuids, ilog2(meta_bucket_pages(&c->sb)));
@@ -1703,9 +1695,8 @@ static void cache_set_free(struct closure *cl)
 static void cache_set_flush(struct closure *cl)
 {
 	struct cache_set *c = container_of(cl, struct cache_set, caching);
-	struct cache *ca;
+	struct cache *ca = c->cache;
 	struct btree *b;
-	unsigned int i;
 
 	bch_cache_accounting_destroy(&c->accounting);
 
@@ -1730,9 +1721,8 @@ static void cache_set_flush(struct closure *cl)
 			mutex_unlock(&b->write_lock);
 		}
 
-	for_each_cache(ca, c, i)
-		if (ca->alloc_thread)
-			kthread_stop(ca->alloc_thread);
+	if (ca->alloc_thread)
+		kthread_stop(ca->alloc_thread);
 
 	if (c->journal.cur) {
 		cancel_delayed_work_sync(&c->journal.work);
@@ -1973,16 +1963,14 @@ static int run_cache_set(struct cache_set *c)
 {
 	const char *err = "cannot allocate memory";
 	struct cached_dev *dc, *t;
-	struct cache *ca;
+	struct cache *ca = c->cache;
 	struct closure cl;
-	unsigned int i;
 	LIST_HEAD(journal);
 	struct journal_replay *l;
 
 	closure_init_stack(&cl);
 
-	for_each_cache(ca, c, i)
-		c->nbuckets += ca->sb.nbuckets;
+	c->nbuckets = ca->sb.nbuckets;
 	set_gc_sectors(c);
 
 	if (CACHE_SYNC(&c->sb)) {
@@ -2002,10 +1990,8 @@ static int run_cache_set(struct cache_set *c)
 		j = &list_entry(journal.prev, struct journal_replay, list)->j;
 
 		err = "IO error reading priorities";
-		for_each_cache(ca, c, i) {
-			if (prio_read(ca, j->prio_bucket[ca->sb.nr_this_dev]))
-				goto err;
-		}
+		if (prio_read(ca, j->prio_bucket[ca->sb.nr_this_dev]))
+			goto err;
 
 		/*
 		 * If prio_read() fails it'll call cache_set_error and we'll
@@ -2049,9 +2035,8 @@ static int run_cache_set(struct cache_set *c)
 		bch_journal_next(&c->journal);
 
 		err = "error starting allocator thread";
-		for_each_cache(ca, c, i)
-			if (bch_cache_allocator_start(ca))
-				goto err;
+		if (bch_cache_allocator_start(ca))
+			goto err;
 
 		/*
 		 * First place it's safe to allocate: btree_check() and
@@ -2070,28 +2055,23 @@ static int run_cache_set(struct cache_set *c)
 		if (bch_journal_replay(c, &journal))
 			goto err;
 	} else {
-		pr_notice("invalidating existing data\n");
-
-		for_each_cache(ca, c, i) {
-			unsigned int j;
+		unsigned int j;
 
-			ca->sb.keys = clamp_t(int, ca->sb.nbuckets >> 7,
-					      2, SB_JOURNAL_BUCKETS);
+		pr_notice("invalidating existing data\n");
+		ca->sb.keys = clamp_t(int, ca->sb.nbuckets >> 7,
+					2, SB_JOURNAL_BUCKETS);
 
-			for (j = 0; j < ca->sb.keys; j++)
-				ca->sb.d[j] = ca->sb.first_bucket + j;
-		}
+		for (j = 0; j < ca->sb.keys; j++)
+			ca->sb.d[j] = ca->sb.first_bucket + j;
 
 		bch_initial_gc_finish(c);
 
 		err = "error starting allocator thread";
-		for_each_cache(ca, c, i)
-			if (bch_cache_allocator_start(ca))
-				goto err;
+		if (bch_cache_allocator_start(ca))
+			goto err;
 
 		mutex_lock(&c->bucket_lock);
-		for_each_cache(ca, c, i)
-			bch_prio_write(ca, true);
+		bch_prio_write(ca, true);
 		mutex_unlock(&c->bucket_lock);
 
 		err = "cannot allocate new UUID bucket";
@@ -2467,13 +2447,14 @@ static bool bch_is_open_backing(struct block_device *bdev)
 static bool bch_is_open_cache(struct block_device *bdev)
 {
 	struct cache_set *c, *tc;
-	struct cache *ca;
-	unsigned int i;
 
-	list_for_each_entry_safe(c, tc, &bch_cache_sets, list)
-		for_each_cache(ca, c, i)
-			if (ca->bdev == bdev)
-				return true;
+	list_for_each_entry_safe(c, tc, &bch_cache_sets, list) {
+		struct cache *ca = c->cache;
+
+		if (ca->bdev == bdev)
+			return true;
+	}
+
 	return false;
 }
 
-- 
2.26.2

