Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3DC35B4D3
	for <lists+linux-block@lfdr.de>; Sun, 11 Apr 2021 15:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbhDKNoL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 11 Apr 2021 09:44:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:47322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235569AbhDKNn7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57DB4ABD0;
        Sun, 11 Apr 2021 13:43:39 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>
Subject: [PATCH 2/7] bcache: remove PTR_CACHE
Date:   Sun, 11 Apr 2021 21:43:11 +0800
Message-Id: <20210411134316.80274-3-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210411134316.80274-1-colyli@suse.de>
References: <20210411134316.80274-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Remove the PTR_CACHE inline and replace it with a direct dereference
of c->cache.

(Coly Li: fix the typo from PTR_BUCKET to PTR_CACHE in commit log)

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/alloc.c     |  5 ++---
 drivers/md/bcache/bcache.h    | 11 ++---------
 drivers/md/bcache/btree.c     |  4 ++--
 drivers/md/bcache/debug.c     |  2 +-
 drivers/md/bcache/extents.c   |  4 ++--
 drivers/md/bcache/io.c        |  4 ++--
 drivers/md/bcache/journal.c   |  2 +-
 drivers/md/bcache/writeback.c |  5 ++---
 8 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 8c371d5eef8e..097577ae3c47 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -482,8 +482,7 @@ void bch_bucket_free(struct cache_set *c, struct bkey *k)
 	unsigned int i;
 
 	for (i = 0; i < KEY_PTRS(k); i++)
-		__bch_bucket_free(PTR_CACHE(c, k, i),
-				  PTR_BUCKET(c, k, i));
+		__bch_bucket_free(c->cache, PTR_BUCKET(c, k, i));
 }
 
 int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
@@ -674,7 +673,7 @@ bool bch_alloc_sectors(struct cache_set *c,
 		SET_PTR_OFFSET(&b->key, i, PTR_OFFSET(&b->key, i) + sectors);
 
 		atomic_long_add(sectors,
-				&PTR_CACHE(c, &b->key, i)->sectors_written);
+				&c->cache->sectors_written);
 	}
 
 	if (b->sectors_free < c->cache->sb.block_size)
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 848dd4db1659..0a4551e165ab 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -804,13 +804,6 @@ static inline sector_t bucket_remainder(struct cache_set *c, sector_t s)
 	return s & (c->cache->sb.bucket_size - 1);
 }
 
-static inline struct cache *PTR_CACHE(struct cache_set *c,
-				      const struct bkey *k,
-				      unsigned int ptr)
-{
-	return c->cache;
-}
-
 static inline size_t PTR_BUCKET_NR(struct cache_set *c,
 				   const struct bkey *k,
 				   unsigned int ptr)
@@ -822,7 +815,7 @@ static inline struct bucket *PTR_BUCKET(struct cache_set *c,
 					const struct bkey *k,
 					unsigned int ptr)
 {
-	return PTR_CACHE(c, k, ptr)->buckets + PTR_BUCKET_NR(c, k, ptr);
+	return c->cache->buckets + PTR_BUCKET_NR(c, k, ptr);
 }
 
 static inline uint8_t gen_after(uint8_t a, uint8_t b)
@@ -841,7 +834,7 @@ static inline uint8_t ptr_stale(struct cache_set *c, const struct bkey *k,
 static inline bool ptr_available(struct cache_set *c, const struct bkey *k,
 				 unsigned int i)
 {
-	return (PTR_DEV(k, i) < MAX_CACHES_PER_SET) && PTR_CACHE(c, k, i);
+	return (PTR_DEV(k, i) < MAX_CACHES_PER_SET) && c->cache;
 }
 
 /* Btree key macros */
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index fe6dce125aba..183a58c89377 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -426,7 +426,7 @@ void __bch_btree_node_write(struct btree *b, struct closure *parent)
 	do_btree_node_write(b);
 
 	atomic_long_add(set_blocks(i, block_bytes(b->c->cache)) * b->c->cache->sb.block_size,
-			&PTR_CACHE(b->c, &b->key, 0)->btree_sectors_written);
+			&b->c->cache->btree_sectors_written);
 
 	b->written += set_blocks(i, block_bytes(b->c->cache));
 }
@@ -1161,7 +1161,7 @@ static void make_btree_freeing_key(struct btree *b, struct bkey *k)
 
 	for (i = 0; i < KEY_PTRS(k); i++)
 		SET_PTR_GEN(k, i,
-			    bch_inc_gen(PTR_CACHE(b->c, &b->key, i),
+			    bch_inc_gen(b->c->cache,
 					PTR_BUCKET(b->c, &b->key, i)));
 
 	mutex_unlock(&b->c->bucket_lock);
diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 63e809f38e3f..589a052efeb1 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -50,7 +50,7 @@ void bch_btree_verify(struct btree *b)
 	v->keys.ops = b->keys.ops;
 
 	bio = bch_bbio_alloc(b->c);
-	bio_set_dev(bio, PTR_CACHE(b->c, &b->key, 0)->bdev);
+	bio_set_dev(bio, c->cache->bdev);
 	bio->bi_iter.bi_sector	= PTR_OFFSET(&b->key, 0);
 	bio->bi_iter.bi_size	= KEY_SIZE(&v->key) << 9;
 	bio->bi_opf		= REQ_OP_READ | REQ_META;
diff --git a/drivers/md/bcache/extents.c b/drivers/md/bcache/extents.c
index f4658a1f37b8..d626ffcbecb9 100644
--- a/drivers/md/bcache/extents.c
+++ b/drivers/md/bcache/extents.c
@@ -50,7 +50,7 @@ static bool __ptr_invalid(struct cache_set *c, const struct bkey *k)
 
 	for (i = 0; i < KEY_PTRS(k); i++)
 		if (ptr_available(c, k, i)) {
-			struct cache *ca = PTR_CACHE(c, k, i);
+			struct cache *ca = c->cache;
 			size_t bucket = PTR_BUCKET_NR(c, k, i);
 			size_t r = bucket_remainder(c, PTR_OFFSET(k, i));
 
@@ -71,7 +71,7 @@ static const char *bch_ptr_status(struct cache_set *c, const struct bkey *k)
 
 	for (i = 0; i < KEY_PTRS(k); i++)
 		if (ptr_available(c, k, i)) {
-			struct cache *ca = PTR_CACHE(c, k, i);
+			struct cache *ca = c->cache;
 			size_t bucket = PTR_BUCKET_NR(c, k, i);
 			size_t r = bucket_remainder(c, PTR_OFFSET(k, i));
 
diff --git a/drivers/md/bcache/io.c b/drivers/md/bcache/io.c
index dad71a6b7889..e4388fe3ab7e 100644
--- a/drivers/md/bcache/io.c
+++ b/drivers/md/bcache/io.c
@@ -36,7 +36,7 @@ void __bch_submit_bbio(struct bio *bio, struct cache_set *c)
 	struct bbio *b = container_of(bio, struct bbio, bio);
 
 	bio->bi_iter.bi_sector	= PTR_OFFSET(&b->key, 0);
-	bio_set_dev(bio, PTR_CACHE(c, &b->key, 0)->bdev);
+	bio_set_dev(bio, c->cache->bdev);
 
 	b->submit_time_us = local_clock_us();
 	closure_bio_submit(c, bio, bio->bi_private);
@@ -137,7 +137,7 @@ void bch_bbio_count_io_errors(struct cache_set *c, struct bio *bio,
 			      blk_status_t error, const char *m)
 {
 	struct bbio *b = container_of(bio, struct bbio, bio);
-	struct cache *ca = PTR_CACHE(c, &b->key, 0);
+	struct cache *ca = c->cache;
 	int is_read = (bio_data_dir(bio) == READ ? 1 : 0);
 
 	unsigned int threshold = op_is_write(bio_op(bio))
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index c6613e817333..de2c0d7699cf 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -768,7 +768,7 @@ static void journal_write_unlocked(struct closure *cl)
 	w->data->csum		= csum_set(w->data);
 
 	for (i = 0; i < KEY_PTRS(k); i++) {
-		ca = PTR_CACHE(c, k, i);
+		ca = c->cache;
 		bio = &ca->journal.bio;
 
 		atomic_long_add(sectors, &ca->meta_sectors_written);
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 82d4e0880a99..bcd550a2b0da 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -416,7 +416,7 @@ static void read_dirty_endio(struct bio *bio)
 	struct dirty_io *io = w->private;
 
 	/* is_read = 1 */
-	bch_count_io_errors(PTR_CACHE(io->dc->disk.c, &w->key, 0),
+	bch_count_io_errors(io->dc->disk.c->cache,
 			    bio->bi_status, 1,
 			    "reading dirty data from cache");
 
@@ -510,8 +510,7 @@ static void read_dirty(struct cached_dev *dc)
 			dirty_init(w);
 			bio_set_op_attrs(&io->bio, REQ_OP_READ, 0);
 			io->bio.bi_iter.bi_sector = PTR_OFFSET(&w->key, 0);
-			bio_set_dev(&io->bio,
-				    PTR_CACHE(dc->disk.c, &w->key, 0)->bdev);
+			bio_set_dev(&io->bio, dc->disk.c->cache->bdev);
 			io->bio.bi_end_io	= read_dirty_endio;
 
 			if (bch_bio_alloc_pages(&io->bio, GFP_KERNEL))
-- 
2.26.2

