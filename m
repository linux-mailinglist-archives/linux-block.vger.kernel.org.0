Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FF627F9B6
	for <lists+linux-block@lfdr.de>; Thu,  1 Oct 2020 08:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbgJAGvU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Oct 2020 02:51:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:33712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgJAGvU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Oct 2020 02:51:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11EB8ABBE;
        Thu,  1 Oct 2020 06:51:18 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 05/15] bcache: explicitly make cache_set only have single cache
Date:   Thu,  1 Oct 2020 14:50:46 +0800
Message-Id: <20201001065056.24411-6-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001065056.24411-1-colyli@suse.de>
References: <20201001065056.24411-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently although the bcache code has a framework for multiple caches
in a cache set, but indeed the multiple caches never completed and users
use md raid1 for multiple copies of the cached data.

This patch does the following change in struct cache_set, to explicitly
make a cache_set only have single cache,
- Change pointer array "*cache[MAX_CACHES_PER_SET]" to a single pointer
  "*cache".
- Remove pointer array "*cache_by_alloc[MAX_CACHES_PER_SET]".
- Remove "caches_loaded".

Now the code looks as exactly what it does in practic: only one cache is
used in the cache set.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/alloc.c  |  2 +-
 drivers/md/bcache/bcache.h |  8 +++-----
 drivers/md/bcache/super.c  | 19 ++++++++-----------
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 4493ff57476d..3385f6add6df 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -501,7 +501,7 @@ int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
 
 	bkey_init(k);
 
-	ca = c->cache_by_alloc[0];
+	ca = c->cache;
 	b = bch_bucket_alloc(ca, reserve, wait);
 	if (b == -1)
 		goto err;
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 5ff6e9573935..aa112c1adba1 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -519,9 +519,7 @@ struct cache_set {
 
 	struct cache_sb		sb;
 
-	struct cache		*cache[MAX_CACHES_PER_SET];
-	struct cache		*cache_by_alloc[MAX_CACHES_PER_SET];
-	int			caches_loaded;
+	struct cache		*cache;
 
 	struct bcache_device	**devices;
 	unsigned int		devices_max_used;
@@ -808,7 +806,7 @@ static inline struct cache *PTR_CACHE(struct cache_set *c,
 				      const struct bkey *k,
 				      unsigned int ptr)
 {
-	return c->cache[PTR_DEV(k, ptr)];
+	return c->cache;
 }
 
 static inline size_t PTR_BUCKET_NR(struct cache_set *c,
@@ -890,7 +888,7 @@ do {									\
 /* Looping macros */
 
 #define for_each_cache(ca, cs, iter)					\
-	for (iter = 0; ca = cs->cache[iter], iter < (cs)->sb.nr_in_set; iter++)
+	for (iter = 0; ca = cs->cache, iter < 1; iter++)
 
 #define for_each_bucket(b, ca)						\
 	for (b = (ca)->buckets + (ca)->sb.first_bucket;			\
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 18358b67d8d6..718515644c89 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1675,7 +1675,7 @@ static void cache_set_free(struct closure *cl)
 	for_each_cache(ca, c, i)
 		if (ca) {
 			ca->set = NULL;
-			c->cache[ca->sb.nr_this_dev] = NULL;
+			c->cache = NULL;
 			kobject_put(&ca->kobj);
 		}
 
@@ -2166,7 +2166,7 @@ static const char *register_cache_set(struct cache *ca)
 
 	list_for_each_entry(c, &bch_cache_sets, list)
 		if (!memcmp(c->sb.set_uuid, ca->sb.set_uuid, 16)) {
-			if (c->cache[ca->sb.nr_this_dev])
+			if (c->cache)
 				return "duplicate cache set member";
 
 			if (!can_attach_cache(ca, c))
@@ -2216,14 +2216,11 @@ static const char *register_cache_set(struct cache *ca)
 
 	kobject_get(&ca->kobj);
 	ca->set = c;
-	ca->set->cache[ca->sb.nr_this_dev] = ca;
-	c->cache_by_alloc[c->caches_loaded++] = ca;
+	ca->set->cache = ca;
 
-	if (c->caches_loaded == c->sb.nr_in_set) {
-		err = "failed to run cache set";
-		if (run_cache_set(c) < 0)
-			goto err;
-	}
+	err = "failed to run cache set";
+	if (run_cache_set(c) < 0)
+		goto err;
 
 	return NULL;
 err:
@@ -2240,8 +2237,8 @@ void bch_cache_release(struct kobject *kobj)
 	unsigned int i;
 
 	if (ca->set) {
-		BUG_ON(ca->set->cache[ca->sb.nr_this_dev] != ca);
-		ca->set->cache[ca->sb.nr_this_dev] = NULL;
+		BUG_ON(ca->set->cache != ca);
+		ca->set->cache = NULL;
 	}
 
 	free_pages((unsigned long) ca->disk_buckets, ilog2(meta_bucket_pages(&ca->sb)));
-- 
2.26.2

