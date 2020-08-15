Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE564245236
	for <lists+linux-block@lfdr.de>; Sat, 15 Aug 2020 23:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHOVoM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 15 Aug 2020 17:44:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:54984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgHOVnt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Aug 2020 17:43:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7C1DB798;
        Sat, 15 Aug 2020 04:11:25 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 05/14] bcache: only use block_bytes() on struct cache
Date:   Sat, 15 Aug 2020 12:10:34 +0800
Message-Id: <20200815041043.45116-6-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200815041043.45116-1-colyli@suse.de>
References: <20200815041043.45116-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Because struct cache_set and struct cache both have struct cache_sb,
therefore macro block_bytes() can be used on both of them. When removing
the embedded struct cache_sb from struct cache_set, this macro won't be
used on struct cache_set anymore.

This patch unifies all block_bytes() usage only on struct cache, this is
one of the preparation to remove the embedded struct cache_sb from
struct cache_set.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bcache.h  |  2 +-
 drivers/md/bcache/btree.c   | 24 ++++++++++++------------
 drivers/md/bcache/debug.c   |  8 ++++----
 drivers/md/bcache/journal.c |  8 ++++----
 drivers/md/bcache/request.c |  2 +-
 drivers/md/bcache/super.c   |  2 +-
 drivers/md/bcache/sysfs.c   |  2 +-
 7 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 94a62acac4fc..29bec61cafbb 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -759,7 +759,7 @@ struct bbio {
 
 #define bucket_pages(c)		((c)->sb.bucket_size / PAGE_SECTORS)
 #define bucket_bytes(c)		((c)->sb.bucket_size << 9)
-#define block_bytes(c)		((c)->sb.block_size << 9)
+#define block_bytes(ca)		((ca)->sb.block_size << 9)
 
 static inline unsigned int meta_bucket_pages(struct cache_sb *sb)
 {
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 0817ad510d9f..c91b4d58a5b3 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -104,7 +104,7 @@
 
 static inline struct bset *write_block(struct btree *b)
 {
-	return ((void *) btree_bset_first(b)) + b->written * block_bytes(b->c);
+	return ((void *) btree_bset_first(b)) + b->written * block_bytes(b->c->cache);
 }
 
 static void bch_btree_init_next(struct btree *b)
@@ -173,7 +173,7 @@ void bch_btree_node_read_done(struct btree *b)
 			goto err;
 
 		err = "bad btree header";
-		if (b->written + set_blocks(i, block_bytes(b->c)) >
+		if (b->written + set_blocks(i, block_bytes(b->c->cache)) >
 		    btree_blocks(b))
 			goto err;
 
@@ -199,13 +199,13 @@ void bch_btree_node_read_done(struct btree *b)
 
 		bch_btree_iter_push(iter, i->start, bset_bkey_last(i));
 
-		b->written += set_blocks(i, block_bytes(b->c));
+		b->written += set_blocks(i, block_bytes(b->c->cache));
 	}
 
 	err = "corrupted btree";
 	for (i = write_block(b);
 	     bset_sector_offset(&b->keys, i) < KEY_SIZE(&b->key);
-	     i = ((void *) i) + block_bytes(b->c))
+	     i = ((void *) i) + block_bytes(b->c->cache))
 		if (i->seq == b->keys.set[0].data->seq)
 			goto err;
 
@@ -347,7 +347,7 @@ static void do_btree_node_write(struct btree *b)
 
 	b->bio->bi_end_io	= btree_node_write_endio;
 	b->bio->bi_private	= cl;
-	b->bio->bi_iter.bi_size	= roundup(set_bytes(i), block_bytes(b->c));
+	b->bio->bi_iter.bi_size	= roundup(set_bytes(i), block_bytes(b->c->cache));
 	b->bio->bi_opf		= REQ_OP_WRITE | REQ_META | REQ_FUA;
 	bch_bio_map(b->bio, i);
 
@@ -423,10 +423,10 @@ void __bch_btree_node_write(struct btree *b, struct closure *parent)
 
 	do_btree_node_write(b);
 
-	atomic_long_add(set_blocks(i, block_bytes(b->c)) * b->c->sb.block_size,
+	atomic_long_add(set_blocks(i, block_bytes(b->c->cache)) * b->c->sb.block_size,
 			&PTR_CACHE(b->c, &b->key, 0)->btree_sectors_written);
 
-	b->written += set_blocks(i, block_bytes(b->c));
+	b->written += set_blocks(i, block_bytes(b->c->cache));
 }
 
 void bch_btree_node_write(struct btree *b, struct closure *parent)
@@ -1344,7 +1344,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 
 	if (nodes < 2 ||
 	    __set_blocks(b->keys.set[0].data, keys,
-			 block_bytes(b->c)) > blocks * (nodes - 1))
+			 block_bytes(b->c->cache)) > blocks * (nodes - 1))
 		return 0;
 
 	for (i = 0; i < nodes; i++) {
@@ -1378,7 +1378,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 			     k = bkey_next(k)) {
 				if (__set_blocks(n1, n1->keys + keys +
 						 bkey_u64s(k),
-						 block_bytes(b->c)) > blocks)
+						 block_bytes(b->c->cache)) > blocks)
 					break;
 
 				last = k;
@@ -1394,7 +1394,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 			 * though)
 			 */
 			if (__set_blocks(n1, n1->keys + n2->keys,
-					 block_bytes(b->c)) >
+					 block_bytes(b->c->cache)) >
 			    btree_blocks(new_nodes[i]))
 				goto out_unlock_nocoalesce;
 
@@ -1403,7 +1403,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 			last = &r->b->key;
 		}
 
-		BUG_ON(__set_blocks(n1, n1->keys + keys, block_bytes(b->c)) >
+		BUG_ON(__set_blocks(n1, n1->keys + keys, block_bytes(b->c->cache)) >
 		       btree_blocks(new_nodes[i]));
 
 		if (last)
@@ -2210,7 +2210,7 @@ static int btree_split(struct btree *b, struct btree_op *op,
 		goto err;
 
 	split = set_blocks(btree_bset_first(n1),
-			   block_bytes(n1->c)) > (btree_blocks(b) * 4) / 5;
+			   block_bytes(n1->c->cache)) > (btree_blocks(b) * 4) / 5;
 
 	if (split) {
 		unsigned int keys = 0;
diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 0ccc1b0baa42..b00fd08d696b 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -25,8 +25,8 @@ struct dentry *bcache_debug;
 	for (i = (start);						\
 	     (void *) i < (void *) (start) + (KEY_SIZE(&b->key) << 9) &&\
 	     i->seq == (start)->seq;					\
-	     i = (void *) i + set_blocks(i, block_bytes(b->c)) *	\
-		 block_bytes(b->c))
+	     i = (void *) i + set_blocks(i, block_bytes(b->c->cache)) *	\
+		 block_bytes(b->c->cache))
 
 void bch_btree_verify(struct btree *b)
 {
@@ -82,14 +82,14 @@ void bch_btree_verify(struct btree *b)
 
 		for_each_written_bset(b, ondisk, i) {
 			unsigned int block = ((void *) i - (void *) ondisk) /
-				block_bytes(b->c);
+				block_bytes(b->c->cache);
 
 			pr_err("*** on disk block %u:\n", block);
 			bch_dump_bset(&b->keys, i, block);
 		}
 
 		pr_err("*** block %zu not written\n",
-		       ((void *) i - (void *) ondisk) / block_bytes(b->c));
+		       ((void *) i - (void *) ondisk) / block_bytes(b->c->cache));
 
 		for (j = 0; j < inmemory->keys; j++)
 			if (inmemory->d[j] != sorted->d[j])
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 027d0f8c4daf..ccd5de0ab0fe 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -98,7 +98,7 @@ reread:		left = ca->sb.bucket_size - offset;
 				return ret;
 			}
 
-			blocks = set_blocks(j, block_bytes(ca->set));
+			blocks = set_blocks(j, block_bytes(ca));
 
 			/*
 			 * Nodes in 'list' are in linear increasing order of
@@ -734,7 +734,7 @@ static void journal_write_unlocked(struct closure *cl)
 	struct cache *ca = c->cache;
 	struct journal_write *w = c->journal.cur;
 	struct bkey *k = &c->journal.key;
-	unsigned int i, sectors = set_blocks(w->data, block_bytes(c)) *
+	unsigned int i, sectors = set_blocks(w->data, block_bytes(ca)) *
 		c->sb.block_size;
 
 	struct bio *bio;
@@ -754,7 +754,7 @@ static void journal_write_unlocked(struct closure *cl)
 		return;
 	}
 
-	c->journal.blocks_free -= set_blocks(w->data, block_bytes(c));
+	c->journal.blocks_free -= set_blocks(w->data, block_bytes(ca));
 
 	w->data->btree_level = c->root->level;
 
@@ -847,7 +847,7 @@ static struct journal_write *journal_wait_for_write(struct cache_set *c,
 		struct journal_write *w = c->journal.cur;
 
 		sectors = __set_blocks(w->data, w->data->keys + nkeys,
-				       block_bytes(c)) * c->sb.block_size;
+				       block_bytes(c->cache)) * c->sb.block_size;
 
 		if (sectors <= min_t(size_t,
 				     c->journal.blocks_free * c->sb.block_size,
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index c7cadaafa947..02408fdbf5bb 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -99,7 +99,7 @@ static int bch_keylist_realloc(struct keylist *l, unsigned int u64s,
 	 * bch_data_insert_keys() will insert the keys created so far
 	 * and finish the rest when the keylist is empty.
 	 */
-	if (newsize * sizeof(uint64_t) > block_bytes(c) - sizeof(struct jset))
+	if (newsize * sizeof(uint64_t) > block_bytes(c->cache) - sizeof(struct jset))
 		return -ENOMEM;
 
 	return __bch_keylist_realloc(l, u64s);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 77f5673adbbc..5636648902e3 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1528,7 +1528,7 @@ static int flash_dev_run(struct cache_set *c, struct uuid_entry *u)
 
 	kobject_init(&d->kobj, &bch_flash_dev_ktype);
 
-	if (bcache_device_init(d, block_bytes(c), u->sectors,
+	if (bcache_device_init(d, block_bytes(c->cache), u->sectors,
 			NULL, &bcache_flash_ops))
 		goto err;
 
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index ac06c0bc3c0a..b9f524ab5cc8 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -714,7 +714,7 @@ SHOW(__bch_cache_set)
 	sysfs_print(synchronous,		CACHE_SYNC(&c->sb));
 	sysfs_print(journal_delay_ms,		c->journal_delay_ms);
 	sysfs_hprint(bucket_size,		bucket_bytes(c));
-	sysfs_hprint(block_size,		block_bytes(c));
+	sysfs_hprint(block_size,		block_bytes(c->cache));
 	sysfs_print(tree_depth,			c->root->level);
 	sysfs_print(root_usage_percent,		bch_root_usage(c));
 
-- 
2.26.2

