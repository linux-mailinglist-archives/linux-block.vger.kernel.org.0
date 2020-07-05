Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25F3214DD2
	for <lists+linux-block@lfdr.de>; Sun,  5 Jul 2020 17:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgGEP4h (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 5 Jul 2020 11:56:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:38212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbgGEP4h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 5 Jul 2020 11:56:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39645AC52;
        Sun,  5 Jul 2020 15:56:35 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [RFC PATCH 11/16] bcache: handle cache prio_buckets and disk_buckets properly for bucket size > 8MB
Date:   Sun,  5 Jul 2020 23:55:56 +0800
Message-Id: <20200705155601.5404-12-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705155601.5404-1-colyli@suse.de>
References: <20200705155601.5404-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similar to c->uuids, struct cache's prio_buckets and disk_buckets also
have the potential memory allocation failure during cache registration
if the bucket size > 8MB.

ca->prio_buckets can be stored on cache device in multiple buckets, its
in-memory space is allocated by kzalloc() interface but normally
allocated by alloc_pages() because the size > KMALLOC_MAX_CACHE_SIZE.

So allocation of ca->prio_buckets has the MAX_ORDER restriction too. If
the bucket size > 8MB, by default the page allocator will fail because
the page order > 11 (default MAX_ORDER value). ca->prio_buckets should
also use meta_bucket_bytes(), meta_bucket_pages() to decide its memory
size and use alloc_meta_bucket_pages() to allocate pages, to avoid the
allocation failure during cache set registration when bucket size > 8MB.

ca->disk_buckets is a single bucket size memory buffer, it is used to
iterate each bucket of ca->prio_buckets, and compose the bio based on
memory of ca->disk_buckets, then write ca->disk_buckets memory to cache
disk one-by-one for each bucket of ca->prio_buckets. ca->disk_buckets
should have in-memory size exact to the meta_bucket_pages(), this is the
size that ca->prio_buckets will be stored into each on-disk bucket.

This patch fixes the above issues and handle cache's prio_buckets and
disk_buckets properly for bucket size larger than 8MB.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bcache.h |  9 +++++----
 drivers/md/bcache/super.c  | 10 +++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 2bfbb80841af..0bfbf4729285 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -782,11 +782,12 @@ static inline unsigned int meta_bucket_bytes(struct cache_sb *sb)
 	return meta_bucket_pages(sb) << PAGE_SHIFT;
 }
 
-#define prios_per_bucket(c)				\
-	((bucket_bytes(c) - sizeof(struct prio_set)) /	\
+#define prios_per_bucket(ca)						\
+	((meta_bucket_bytes(&(ca)->sb) - sizeof(struct prio_set)) /	\
 	 sizeof(struct bucket_disk))
-#define prio_buckets(c)					\
-	DIV_ROUND_UP((size_t) (c)->sb.nbuckets, prios_per_bucket(c))
+
+#define prio_buckets(ca)						\
+	DIV_ROUND_UP((size_t) (ca)->sb.nbuckets, prios_per_bucket(ca))
 
 static inline size_t sector_to_bucket(struct cache_set *c, sector_t s)
 {
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 898b28bb8f17..b0e23012d6c1 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -563,7 +563,7 @@ static void prio_io(struct cache *ca, uint64_t bucket, int op,
 
 	bio->bi_iter.bi_sector	= bucket * ca->sb.bucket_size;
 	bio_set_dev(bio, ca->bdev);
-	bio->bi_iter.bi_size	= bucket_bytes(ca);
+	bio->bi_iter.bi_size	= meta_bucket_bytes(&ca->sb);
 
 	bio->bi_end_io	= prio_endio;
 	bio->bi_private = ca;
@@ -621,7 +621,7 @@ int bch_prio_write(struct cache *ca, bool wait)
 
 		p->next_bucket	= ca->prio_buckets[i + 1];
 		p->magic	= pset_magic(&ca->sb);
-		p->csum		= bch_crc64(&p->magic, bucket_bytes(ca) - 8);
+		p->csum		= bch_crc64(&p->magic, meta_bucket_bytes(&ca->sb) - 8);
 
 		bucket = bch_bucket_alloc(ca, RESERVE_PRIO, wait);
 		BUG_ON(bucket == -1);
@@ -674,7 +674,7 @@ static int prio_read(struct cache *ca, uint64_t bucket)
 			prio_io(ca, bucket, REQ_OP_READ, 0);
 
 			if (p->csum !=
-			    bch_crc64(&p->magic, bucket_bytes(ca) - 8)) {
+			    bch_crc64(&p->magic, meta_bucket_bytes(&ca->sb) - 8)) {
 				pr_warn("bad csum reading priorities\n");
 				goto out;
 			}
@@ -2215,7 +2215,7 @@ void bch_cache_release(struct kobject *kobj)
 		ca->set->cache[ca->sb.nr_this_dev] = NULL;
 	}
 
-	free_pages((unsigned long) ca->disk_buckets, ilog2(bucket_pages(ca)));
+	free_pages((unsigned long) ca->disk_buckets, ilog2(meta_bucket_pages(&ca->sb)));
 	kfree(ca->prio_buckets);
 	vfree(ca->buckets);
 
@@ -2312,7 +2312,7 @@ static int cache_alloc(struct cache *ca)
 		goto err_prio_buckets_alloc;
 	}
 
-	ca->disk_buckets = alloc_bucket_pages(GFP_KERNEL, ca);
+	ca->disk_buckets = alloc_meta_bucket_pages(GFP_KERNEL, &ca->sb);
 	if (!ca->disk_buckets) {
 		err = "ca->disk_buckets alloc failed";
 		goto err_disk_buckets_alloc;
-- 
2.26.2

