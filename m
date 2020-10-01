Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A914727F9B4
	for <lists+linux-block@lfdr.de>; Thu,  1 Oct 2020 08:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbgJAGvR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Oct 2020 02:51:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:33654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgJAGvR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Oct 2020 02:51:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 77A0BB012;
        Thu,  1 Oct 2020 06:51:15 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/15] bcache: remove 'int n' from parameter list of bch_bucket_alloc_set()
Date:   Thu,  1 Oct 2020 14:50:45 +0800
Message-Id: <20201001065056.24411-5-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001065056.24411-1-colyli@suse.de>
References: <20201001065056.24411-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The parameter 'int n' from bch_bucket_alloc_set() is not cleared
defined. From the code comments n is the number of buckets to alloc, but
from the code itself 'n' is the maximum cache to iterate. Indeed all the
locations where bch_bucket_alloc_set() is called, 'n' is alwasy 1.

This patch removes the confused and unnecessary 'int n' from parameter
list of  bch_bucket_alloc_set(), and explicitly allocates only 1 bucket
for its caller.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/bcache/alloc.c  | 35 +++++++++++++++--------------------
 drivers/md/bcache/bcache.h |  4 ++--
 drivers/md/bcache/btree.c  |  2 +-
 drivers/md/bcache/super.c  |  2 +-
 4 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 52035a78d836..4493ff57476d 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -49,7 +49,7 @@
  *
  * bch_bucket_alloc() allocates a single bucket from a specific cache.
  *
- * bch_bucket_alloc_set() allocates one or more buckets from different caches
+ * bch_bucket_alloc_set() allocates one  bucket from different caches
  * out of a cache set.
  *
  * free_some_buckets() drives all the processes described above. It's called
@@ -488,34 +488,29 @@ void bch_bucket_free(struct cache_set *c, struct bkey *k)
 }
 
 int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
-			   struct bkey *k, int n, bool wait)
+			   struct bkey *k, bool wait)
 {
-	int i;
+	struct cache *ca;
+	long b;
 
 	/* No allocation if CACHE_SET_IO_DISABLE bit is set */
 	if (unlikely(test_bit(CACHE_SET_IO_DISABLE, &c->flags)))
 		return -1;
 
 	lockdep_assert_held(&c->bucket_lock);
-	BUG_ON(!n || n > c->caches_loaded || n > MAX_CACHES_PER_SET);
 
 	bkey_init(k);
 
-	/* sort by free space/prio of oldest data in caches */
-
-	for (i = 0; i < n; i++) {
-		struct cache *ca = c->cache_by_alloc[i];
-		long b = bch_bucket_alloc(ca, reserve, wait);
+	ca = c->cache_by_alloc[0];
+	b = bch_bucket_alloc(ca, reserve, wait);
+	if (b == -1)
+		goto err;
 
-		if (b == -1)
-			goto err;
+	k->ptr[0] = MAKE_PTR(ca->buckets[b].gen,
+			     bucket_to_sector(c, b),
+			     ca->sb.nr_this_dev);
 
-		k->ptr[i] = MAKE_PTR(ca->buckets[b].gen,
-				bucket_to_sector(c, b),
-				ca->sb.nr_this_dev);
-
-		SET_KEY_PTRS(k, i + 1);
-	}
+	SET_KEY_PTRS(k, 1);
 
 	return 0;
 err:
@@ -525,12 +520,12 @@ int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
 }
 
 int bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
-			 struct bkey *k, int n, bool wait)
+			 struct bkey *k, bool wait)
 {
 	int ret;
 
 	mutex_lock(&c->bucket_lock);
-	ret = __bch_bucket_alloc_set(c, reserve, k, n, wait);
+	ret = __bch_bucket_alloc_set(c, reserve, k, wait);
 	mutex_unlock(&c->bucket_lock);
 	return ret;
 }
@@ -638,7 +633,7 @@ bool bch_alloc_sectors(struct cache_set *c,
 
 		spin_unlock(&c->data_bucket_lock);
 
-		if (bch_bucket_alloc_set(c, watermark, &alloc.key, 1, wait))
+		if (bch_bucket_alloc_set(c, watermark, &alloc.key, wait))
 			return false;
 
 		spin_lock(&c->data_bucket_lock);
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 4fd03d2496d8..5ff6e9573935 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -994,9 +994,9 @@ void bch_bucket_free(struct cache_set *c, struct bkey *k);
 
 long bch_bucket_alloc(struct cache *ca, unsigned int reserve, bool wait);
 int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
-			   struct bkey *k, int n, bool wait);
+			   struct bkey *k, bool wait);
 int bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
-			 struct bkey *k, int n, bool wait);
+			 struct bkey *k, bool wait);
 bool bch_alloc_sectors(struct cache_set *c, struct bkey *k,
 		       unsigned int sectors, unsigned int write_point,
 		       unsigned int write_prio, bool wait);
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index ae7611fa42bf..e2bd03408e66 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1091,7 +1091,7 @@ struct btree *__bch_btree_node_alloc(struct cache_set *c, struct btree_op *op,
 
 	mutex_lock(&c->bucket_lock);
 retry:
-	if (__bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, 1, wait))
+	if (__bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, wait))
 		goto err;
 
 	bkey_put(c, &k.key);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 61abd6499a11..18358b67d8d6 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -486,7 +486,7 @@ static int __uuid_write(struct cache_set *c)
 	closure_init_stack(&cl);
 	lockdep_assert_held(&bch_register_lock);
 
-	if (bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, 1, true))
+	if (bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, true))
 		return 1;
 
 	size =  meta_bucket_pages(&c->sb) * PAGE_SECTORS;
-- 
2.26.2

