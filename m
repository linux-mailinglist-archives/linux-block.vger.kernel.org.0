Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201C06CAF96
	for <lists+linux-block@lfdr.de>; Mon, 27 Mar 2023 22:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjC0UOI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Mar 2023 16:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjC0UOH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:07 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0851FCB
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:17 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id cn12so6456808qtb.8
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679947996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAVSvRsxMnPc21jXZ4LrLYAk6KvY+7YTUeeMl0wWC/w=;
        b=CLUP7oeFAYfHJQqtvwc+bP57rWZpbMpzxklW95ppp5HYKRcK//rH6CJ34E5k5J0N/0
         HWqK2gkoWwcc34e7nveHlcMCo2EEbvTrFVq1MMrMmzevsqSOs0QKor7cyT26Iih6FxrC
         VU9BeNGrSbLQZrycX6uQPEtaECiqLdSf/Dxi4aCcWJbrpoButwapMGJawyEeN33Q9TCF
         0k6qxmMsUje0Xp5zusxfEGlENP3iGqdHNjfsGDMFjH4YqodAg5ZdGUSDDR5rioMPkEYg
         8n5RfjgvtI5fEPBOn/wl+NcYCk1sjJvCMIMQXoGF/FzYBvOoJmTTljn71fy/GJbzOZji
         4kvQ==
X-Gm-Message-State: AO0yUKWj3TQynyBrpW53uoIWzoowp82cujrmYHLoJcfcMdCQXxP+J3zW
        sNsriHpozjKU6cTfguNPXB1E
X-Google-Smtp-Source: AK7set8E1sQHoMgS/ejqC0UID98TZdqr1b8EC2TrHyC7jnO0V77TRODkBdML8gGustfuewA+h/qb3Q==
X-Received: by 2002:ac8:5dd0:0:b0:3e1:65f5:4a85 with SMTP id e16-20020ac85dd0000000b003e165f54a85mr17645462qtx.58.1679947996400;
        Mon, 27 Mar 2023 13:13:16 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id he8-20020a05622a600800b003b835e7e283sm380964qtb.44.2023.03.27.13.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:16 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 06/20] dm bufio: add dm_buffer_cache abstraction
Date:   Mon, 27 Mar 2023 16:11:29 -0400
Message-Id: <20230327201143.51026-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.2 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joe Thornber <ejt@redhat.com>

The buffer cache is responsible for managing the holder count,
tracking clean/dirty state, and choosing buffers via predicates.
Higher level code is responsible for allocation of buffers, IO and
eviction/cache sizing.

The buffer cache has thread safe methods for acquiring a reference
to an existing buffer. All other methods in buffer cache are _not_
threadsafe, and only contain enough locking to guarantee the safe
methods.

Rather than a single mutex, sharded rw_semaphores are used to allow
concurrent threads to 'get' buffers. Each rw_semaphore protects its
own rbtree of buffer entries.

Code that uses this new dm_buffer_cache abstraction will be introduced
in a following commit.

This commit moves the dm_buffer struct in preparation for finer grained
dm_buffer changes, in the next commit, to be more easily seen. It also
introduces temporary dm_buffer struct members to allow compilation of
this intermediate commit (they will be elided in the next commit).

This commit will cause "defined but not used" compiler warnings that
will be resolved by the next commit.

Signed-off-by: Joe Thornber <ejt@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bufio.c | 588 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 526 insertions(+), 62 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index a0bb0de0d4e7..9daff9b77cee 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -301,6 +301,517 @@ static struct lru_entry *lru_evict(struct lru *lru, le_predicate pred, void *con
 
 /*--------------------------------------------------------------*/
 
+/*
+ * Buffer state bits.
+ */
+#define B_READING	0
+#define B_WRITING	1
+#define B_DIRTY		2
+
+/*
+ * Describes how the block was allocated:
+ * kmem_cache_alloc(), __get_free_pages() or vmalloc().
+ * See the comment at alloc_buffer_data.
+ */
+enum data_mode {
+	DATA_MODE_SLAB = 0,
+	DATA_MODE_GET_FREE_PAGES = 1,
+	DATA_MODE_VMALLOC = 2,
+	DATA_MODE_LIMIT = 3
+};
+
+struct dm_buffer {
+	struct rb_node node;
+	struct list_head lru_list;
+	struct list_head global_list;
+
+	sector_t block;
+	void *data;
+	unsigned char data_mode;		/* DATA_MODE_* */
+
+	unsigned int accessed;
+	unsigned int __hold_count;
+	unsigned long last_accessed;
+
+	unsigned char list_mode;		/* LIST_* */
+	blk_status_t read_error;
+	blk_status_t write_error;
+	unsigned long state;
+	unsigned int dirty_start;
+	unsigned int dirty_end;
+	unsigned int write_start;
+	unsigned int write_end;
+	struct dm_bufio_client *c;
+	struct list_head write_list;
+	void (*end_io)(struct dm_buffer *b, blk_status_t bs);
+#ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
+#define MAX_STACK 10
+	unsigned int stack_len;
+	unsigned long stack_entries[MAX_STACK];
+#endif
+	/* Temp members to allow dm_buffer_cache code to compile */
+	atomic_t hold_count;
+	struct lru_entry lru;
+};
+
+/*--------------------------------------------------------------*/
+
+/*
+ * The buffer cache manages buffers, particularly:
+ *  - inc/dec of holder count
+ *  - setting the last_accessed field
+ *  - maintains clean/dirty state along with lru
+ *  - selecting buffers that match predicates
+ *
+ * It does *not* handle:
+ *  - allocation/freeing of buffers.
+ *  - IO
+ *  - Eviction or cache sizing.
+ *
+ * cache_get() and cache_put() are threadsafe, you do not need to
+ * protect these calls with a surrounding mutex.  All the other
+ * methods are not threadsafe; they do use locking primitives, but
+ * only enough to ensure get/put are threadsafe.
+ */
+
+#define NR_LOCKS 64
+#define LOCKS_MASK (NR_LOCKS - 1)
+
+struct buffer_tree {
+	struct rw_semaphore lock;
+	struct rb_root root;
+} ____cacheline_aligned_in_smp;
+
+struct dm_buffer_cache {
+	/*
+	 * We spread entries across multiple trees to reduce contention
+	 * on the locks.
+	 */
+	struct buffer_tree trees[NR_LOCKS];
+	struct lru lru[LIST_SIZE];
+};
+
+static inline unsigned int cache_index(sector_t block)
+{
+	return block & LOCKS_MASK;
+}
+
+static inline void cache_read_lock(struct dm_buffer_cache *bc, sector_t block)
+{
+	down_read(&bc->trees[cache_index(block)].lock);
+}
+
+static inline void cache_read_unlock(struct dm_buffer_cache *bc, sector_t block)
+{
+	up_read(&bc->trees[cache_index(block)].lock);
+}
+
+static inline void cache_write_lock(struct dm_buffer_cache *bc, sector_t block)
+{
+	down_write(&bc->trees[cache_index(block)].lock);
+}
+
+static inline void cache_write_unlock(struct dm_buffer_cache *bc, sector_t block)
+{
+	up_write(&bc->trees[cache_index(block)].lock);
+}
+
+static inline struct dm_buffer *le_to_buffer(struct lru_entry *le)
+{
+	return container_of(le, struct dm_buffer, lru);
+}
+
+static struct dm_buffer *list_to_buffer(struct list_head *l)
+{
+	struct lru_entry *le = list_entry(l, struct lru_entry, list);
+
+	if (!le)
+		return NULL;
+
+	return le_to_buffer(le);
+}
+
+static void cache_init(struct dm_buffer_cache *bc)
+{
+	unsigned int i;
+
+	for (i = 0; i < NR_LOCKS; i++) {
+		init_rwsem(&bc->trees[i].lock);
+		bc->trees[i].root = RB_ROOT;
+	}
+
+	lru_init(&bc->lru[LIST_CLEAN]);
+	lru_init(&bc->lru[LIST_DIRTY]);
+}
+
+static void cache_destroy(struct dm_buffer_cache *bc)
+{
+	unsigned int i;
+
+	for (i = 0; i < NR_LOCKS; i++)
+		WARN_ON_ONCE(!RB_EMPTY_ROOT(&bc->trees[i].root));
+
+	lru_destroy(&bc->lru[LIST_CLEAN]);
+	lru_destroy(&bc->lru[LIST_DIRTY]);
+}
+
+/*--------------*/
+
+/*
+ * not threadsafe, or racey depending how you look at it
+ */
+static inline unsigned long cache_count(struct dm_buffer_cache *bc, int list_mode)
+{
+	return bc->lru[list_mode].count;
+}
+
+static inline unsigned long cache_total(struct dm_buffer_cache *bc)
+{
+	return cache_count(bc, LIST_CLEAN) + cache_count(bc, LIST_DIRTY);
+}
+
+/*--------------*/
+
+/*
+ * Gets a specific buffer, indexed by block.
+ * If the buffer is found then its holder count will be incremented and
+ * lru_reference will be called.
+ *
+ * threadsafe
+ */
+static struct dm_buffer *__cache_get(const struct rb_root *root, sector_t block)
+{
+	struct rb_node *n = root->rb_node;
+	struct dm_buffer *b;
+
+	while (n) {
+		b = container_of(n, struct dm_buffer, node);
+
+		if (b->block == block)
+			return b;
+
+		n = block < b->block ? n->rb_left : n->rb_right;
+	}
+
+	return NULL;
+}
+
+static void __cache_inc_buffer(struct dm_buffer *b)
+{
+	atomic_inc(&b->hold_count);
+	WRITE_ONCE(b->last_accessed, jiffies);
+}
+
+static struct dm_buffer *cache_get(struct dm_buffer_cache *bc, sector_t block)
+{
+	struct dm_buffer *b;
+
+	cache_read_lock(bc, block);
+	b = __cache_get(&bc->trees[cache_index(block)].root, block);
+	if (b) {
+		lru_reference(&b->lru);
+		__cache_inc_buffer(b);
+	}
+	cache_read_unlock(bc, block);
+
+	return b;
+}
+
+/*--------------*/
+
+/*
+ * Returns true if the hold count hits zero.
+ * threadsafe
+ */
+static bool cache_put(struct dm_buffer_cache *bc, struct dm_buffer *b)
+{
+	bool r;
+
+	cache_read_lock(bc, b->block);
+	BUG_ON(!atomic_read(&b->hold_count));
+	r = atomic_dec_and_test(&b->hold_count);
+	cache_read_unlock(bc, b->block);
+
+	return r;
+}
+
+/*--------------*/
+
+typedef enum evict_result (*b_predicate)(struct dm_buffer *, void *);
+
+/*
+ * Evicts a buffer based on a predicate.  The oldest buffer that
+ * matches the predicate will be selected.  In addition to the
+ * predicate the hold_count of the selected buffer will be zero.
+ */
+struct evict_wrapper {
+	b_predicate pred;
+	void *context;
+};
+
+/*
+ * Wraps the buffer predicate turning it into an lru predicate.  Adds
+ * extra test for hold_count.
+ */
+static enum evict_result __evict_pred(struct lru_entry *le, void *context)
+{
+	struct evict_wrapper *w = context;
+	struct dm_buffer *b = le_to_buffer(le);
+
+	if (atomic_read(&b->hold_count))
+		return ER_DONT_EVICT;
+
+	return w->pred(b, w->context);
+}
+
+static struct dm_buffer *cache_evict(struct dm_buffer_cache *bc, int list_mode,
+				     b_predicate pred, void *context)
+{
+	struct evict_wrapper w = {.pred = pred, .context = context};
+	struct lru_entry *le;
+	struct dm_buffer *b;
+
+	le = lru_evict(&bc->lru[list_mode], __evict_pred, &w);
+	if (!le)
+		return NULL;
+
+	b = le_to_buffer(le);
+	/* __evict_pred will have locked the appropriate tree. */
+	rb_erase(&b->node, &bc->trees[cache_index(b->block)].root);
+
+	return b;
+}
+
+/*--------------*/
+
+/*
+ * Mark a buffer as clean or dirty. Not threadsafe.
+ */
+static void cache_mark(struct dm_buffer_cache *bc, struct dm_buffer *b, int list_mode)
+{
+	cache_write_lock(bc, b->block);
+	if (list_mode != b->list_mode) {
+		lru_remove(&bc->lru[b->list_mode], &b->lru);
+		b->list_mode = list_mode;
+		lru_insert(&bc->lru[b->list_mode], &b->lru);
+	}
+	cache_write_unlock(bc, b->block);
+}
+
+/*--------------*/
+
+/*
+ * Runs through the lru associated with 'old_mode', if the predicate matches then
+ * it moves them to 'new_mode'.  Not threadsafe.
+ */
+static void cache_mark_many(struct dm_buffer_cache *bc, int old_mode, int new_mode,
+			    b_predicate pred, void *context)
+{
+	struct lru_entry *le;
+	struct dm_buffer *b;
+	struct evict_wrapper w = {.pred = pred, .context = context};
+
+	while (true) {
+		le = lru_evict(&bc->lru[old_mode], __evict_pred, &w);
+		if (!le)
+			break;
+
+		b = le_to_buffer(le);
+		b->list_mode = new_mode;
+		lru_insert(&bc->lru[b->list_mode], &b->lru);
+	}
+}
+
+/*--------------*/
+
+/*
+ * Iterates through all clean or dirty entries calling a function for each
+ * entry.  The callback may terminate the iteration early.  Not threadsafe.
+ */
+
+/*
+ * Iterator functions should return one of these actions to indicate
+ * how the iteration should proceed.
+ */
+enum it_action {
+	IT_NEXT,
+	IT_COMPLETE,
+};
+
+typedef enum it_action (*iter_fn)(struct dm_buffer *b, void *context);
+
+static void cache_iterate(struct dm_buffer_cache *bc, int list_mode,
+			  iter_fn fn, void *context)
+{
+	struct lru *lru = &bc->lru[list_mode];
+	struct lru_entry *le, *first;
+
+	if (!lru->cursor)
+		return;
+
+	first = le = to_le(lru->cursor);
+	do {
+		struct dm_buffer *b = le_to_buffer(le);
+
+		switch (fn(b, context)) {
+		case IT_NEXT:
+			break;
+
+		case IT_COMPLETE:
+			return;
+		}
+		cond_resched();
+
+		le = to_le(le->list.next);
+	} while (le != first);
+}
+
+/*--------------*/
+
+/*
+ * Passes ownership of the buffer to the cache. Returns false if the
+ * buffer was already present (in which case ownership does not pass).
+ * eg, a race with another thread.
+ *
+ * Holder count should be 1 on insertion.
+ *
+ * Not threadsafe.
+ */
+static bool __cache_insert(struct rb_root *root, struct dm_buffer *b)
+{
+	struct rb_node **new = &root->rb_node, *parent = NULL;
+	struct dm_buffer *found;
+
+	while (*new) {
+		found = container_of(*new, struct dm_buffer, node);
+
+		if (found->block == b->block)
+			return false;
+
+		parent = *new;
+		new = b->block < found->block ?
+			&found->node.rb_left : &found->node.rb_right;
+	}
+
+	rb_link_node(&b->node, parent, new);
+	rb_insert_color(&b->node, root);
+
+	return true;
+}
+
+static bool cache_insert(struct dm_buffer_cache *bc, struct dm_buffer *b)
+{
+	bool r;
+
+	if (WARN_ON_ONCE(b->list_mode >= LIST_SIZE))
+		return false;
+
+	cache_write_lock(bc, b->block);
+	BUG_ON(atomic_read(&b->hold_count) != 1);
+	r = __cache_insert(&bc->trees[cache_index(b->block)].root, b);
+	if (r)
+		lru_insert(&bc->lru[b->list_mode], &b->lru);
+	cache_write_unlock(bc, b->block);
+
+	return r;
+}
+
+/*--------------*/
+
+/*
+ * Removes buffer from cache, ownership of the buffer passes back to the caller.
+ * Fails if the hold_count is not one (ie. the caller holds the only reference).
+ *
+ * Not threadsafe.
+ */
+static bool cache_remove(struct dm_buffer_cache *bc, struct dm_buffer *b)
+{
+	bool r;
+
+	cache_write_lock(bc, b->block);
+
+	if (atomic_read(&b->hold_count) != 1) {
+		r = false;
+	} else {
+		r = true;
+		rb_erase(&b->node, &bc->trees[cache_index(b->block)].root);
+		lru_remove(&bc->lru[b->list_mode], &b->lru);
+	}
+
+	cache_write_unlock(bc, b->block);
+
+	return r;
+}
+
+/*--------------*/
+
+typedef void (*b_release)(struct dm_buffer *);
+
+static struct dm_buffer *__find_next(struct rb_root *root, sector_t block)
+{
+	struct rb_node *n = root->rb_node;
+	struct dm_buffer *b;
+	struct dm_buffer *best = NULL;
+
+	while (n) {
+		b = container_of(n, struct dm_buffer, node);
+
+		if (b->block == block)
+			return b;
+
+		if (block <= b->block) {
+			n = n->rb_left;
+			best = b;
+		} else {
+			n = n->rb_right;
+		}
+	}
+
+	return best;
+}
+
+static void __remove_range(struct dm_buffer_cache *bc,
+			   struct rb_root *root,
+			   sector_t begin, sector_t end,
+			   b_predicate pred, b_release release)
+{
+	struct dm_buffer *b;
+
+	while (true) {
+		cond_resched();
+
+		b = __find_next(root, begin);
+		if (!b || (b->block >= end))
+			break;
+
+		begin = b->block + 1;
+
+		if (atomic_read(&b->hold_count))
+			continue;
+
+		if (pred(b, NULL) == ER_EVICT) {
+			rb_erase(&b->node, root);
+			lru_remove(&bc->lru[b->list_mode], &b->lru);
+			release(b);
+		}
+	}
+}
+
+static void cache_remove_range(struct dm_buffer_cache *bc,
+			       sector_t begin, sector_t end,
+			       b_predicate pred, b_release release)
+{
+	unsigned int i;
+
+	for (i = 0; i < NR_LOCKS; i++) {
+		down_write(&bc->trees[i].lock);
+		__remove_range(bc, &bc->trees[i].root, begin, end, pred, release);
+		up_write(&bc->trees[i].lock);
+	}
+}
+
+/*----------------------------------------------------------------*/
+
 /*
  * Linking of buffers:
  *	All buffers are linked to buffer_tree with their node field.
@@ -352,53 +863,6 @@ struct dm_bufio_client {
 	atomic_long_t need_shrink;
 };
 
-/*
- * Buffer state bits.
- */
-#define B_READING	0
-#define B_WRITING	1
-#define B_DIRTY		2
-
-/*
- * Describes how the block was allocated:
- * kmem_cache_alloc(), __get_free_pages() or vmalloc().
- * See the comment at alloc_buffer_data.
- */
-enum data_mode {
-	DATA_MODE_SLAB = 0,
-	DATA_MODE_GET_FREE_PAGES = 1,
-	DATA_MODE_VMALLOC = 2,
-	DATA_MODE_LIMIT = 3
-};
-
-struct dm_buffer {
-	struct rb_node node;
-	struct list_head lru_list;
-	struct list_head global_list;
-	sector_t block;
-	void *data;
-	unsigned char data_mode;		/* DATA_MODE_* */
-	unsigned char list_mode;		/* LIST_* */
-	blk_status_t read_error;
-	blk_status_t write_error;
-	unsigned int accessed;
-	unsigned int hold_count;
-	unsigned long state;
-	unsigned long last_accessed;
-	unsigned int dirty_start;
-	unsigned int dirty_end;
-	unsigned int write_start;
-	unsigned int write_end;
-	struct dm_bufio_client *c;
-	struct list_head write_list;
-	void (*end_io)(struct dm_buffer *buf, blk_status_t stat);
-#ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
-#define MAX_STACK 10
-	unsigned int stack_len;
-	unsigned long stack_entries[MAX_STACK];
-#endif
-};
-
 static DEFINE_STATIC_KEY_FALSE(no_sleep_enabled);
 
 /*----------------------------------------------------------------*/
@@ -516,7 +980,7 @@ static struct dm_buffer *__find(struct dm_bufio_client *c, sector_t block)
 	return NULL;
 }
 
-static struct dm_buffer *__find_next(struct dm_bufio_client *c, sector_t block)
+static struct dm_buffer *__find_next_old(struct dm_bufio_client *c, sector_t block)
 {
 	struct rb_node *n = c->buffer_tree.rb_node;
 	struct dm_buffer *b;
@@ -1040,7 +1504,7 @@ static void __flush_write_list(struct list_head *write_list)
  */
 static void __make_buffer_clean(struct dm_buffer *b)
 {
-	BUG_ON(b->hold_count);
+	BUG_ON(b->__hold_count);
 
 	/* smp_load_acquire() pairs with read_endio()'s smp_mb__before_atomic() */
 	if (!smp_load_acquire(&b->state))	/* fast case */
@@ -1067,7 +1531,7 @@ static struct dm_buffer *__get_unclaimed_buffer(struct dm_bufio_client *c)
 		    unlikely(test_bit_acquire(B_READING, &b->state)))
 			continue;
 
-		if (!b->hold_count) {
+		if (!b->__hold_count) {
 			__make_buffer_clean(b);
 			__unlink_buffer(b);
 			return b;
@@ -1081,7 +1545,7 @@ static struct dm_buffer *__get_unclaimed_buffer(struct dm_bufio_client *c)
 	list_for_each_entry_reverse(b, &c->lru[LIST_DIRTY], lru_list) {
 		BUG_ON(test_bit(B_READING, &b->state));
 
-		if (!b->hold_count) {
+		if (!b->__hold_count) {
 			__make_buffer_clean(b);
 			__unlink_buffer(b);
 			return b;
@@ -1283,7 +1747,7 @@ static struct dm_buffer *__bufio_new(struct dm_bufio_client *c, sector_t block,
 	__check_watermark(c, write_list);
 
 	b = new_b;
-	b->hold_count = 1;
+	b->__hold_count = 1;
 	b->read_error = 0;
 	b->write_error = 0;
 	__link_buffer(b, block, LIST_CLEAN);
@@ -1311,7 +1775,7 @@ static struct dm_buffer *__bufio_new(struct dm_bufio_client *c, sector_t block,
 	if (nf == NF_GET && unlikely(test_bit_acquire(B_READING, &b->state)))
 		return NULL;
 
-	b->hold_count++;
+	b->__hold_count++;
 	__relink_lru(b, test_bit(B_DIRTY, &b->state) ||
 		     test_bit(B_WRITING, &b->state));
 	return b;
@@ -1460,10 +1924,10 @@ void dm_bufio_release(struct dm_buffer *b)
 
 	dm_bufio_lock(c);
 
-	BUG_ON(!b->hold_count);
+	BUG_ON(!b->__hold_count);
 
-	b->hold_count--;
-	if (!b->hold_count) {
+	b->__hold_count--;
+	if (!b->__hold_count) {
 		wake_up(&c->free_buffer_wait);
 
 		/*
@@ -1564,12 +2028,12 @@ int dm_bufio_write_dirty_buffers(struct dm_bufio_client *c)
 		if (test_bit(B_WRITING, &b->state)) {
 			if (buffers_processed < c->n_buffers[LIST_DIRTY]) {
 				dropped_lock = 1;
-				b->hold_count++;
+				b->__hold_count++;
 				dm_bufio_unlock(c);
 				wait_on_bit_io(&b->state, B_WRITING,
 					       TASK_UNINTERRUPTIBLE);
 				dm_bufio_lock(c);
-				b->hold_count--;
+				b->__hold_count--;
 			} else
 				wait_on_bit_io(&b->state, B_WRITING,
 					       TASK_UNINTERRUPTIBLE);
@@ -1660,7 +2124,7 @@ EXPORT_SYMBOL_GPL(dm_bufio_issue_discard);
 
 static void forget_buffer_locked(struct dm_buffer *b)
 {
-	if (likely(!b->hold_count) && likely(!smp_load_acquire(&b->state))) {
+	if (likely(!b->__hold_count) && likely(!smp_load_acquire(&b->state))) {
 		__unlink_buffer(b);
 		__free_buffer_wake(b);
 	}
@@ -1694,7 +2158,7 @@ void dm_bufio_forget_buffers(struct dm_bufio_client *c, sector_t block, sector_t
 	while (block < end_block) {
 		dm_bufio_lock(c);
 
-		b = __find_next(c, block);
+		b = __find_next_old(c, block);
 		if (b) {
 			block = b->block + 1;
 			forget_buffer_locked(b);
@@ -1791,7 +2255,7 @@ static void drop_buffers(struct dm_bufio_client *c)
 			WARN_ON(!warned);
 			warned = true;
 			DMERR("leaked buffer %llx, hold count %u, list %d",
-			      (unsigned long long)b->block, b->hold_count, i);
+			      (unsigned long long)b->block, b->__hold_count, i);
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
 			stack_trace_print(b->stack_entries, b->stack_len, 1);
 			/* mark unclaimed to avoid WARN_ON below */
@@ -1828,7 +2292,7 @@ static bool __try_evict_buffer(struct dm_buffer *b, gfp_t gfp)
 			return false;
 	}
 
-	if (b->hold_count)
+	if (b->__hold_count)
 		return false;
 
 	__make_buffer_clean(b);
-- 
2.40.0

