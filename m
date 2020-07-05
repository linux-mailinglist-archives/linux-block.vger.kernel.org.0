Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEB3214DD4
	for <lists+linux-block@lfdr.de>; Sun,  5 Jul 2020 17:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgGEP4j (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 5 Jul 2020 11:56:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:38258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbgGEP4i (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 5 Jul 2020 11:56:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B40BAC37;
        Sun,  5 Jul 2020 15:56:37 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [RFC PATCH 12/16] bcache: handle cache set verify_ondisk properly for bucket size > 8MB
Date:   Sun,  5 Jul 2020 23:55:57 +0800
Message-Id: <20200705155601.5404-13-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705155601.5404-1-colyli@suse.de>
References: <20200705155601.5404-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In bch_btree_cache_alloc() when CONFIG_BCACHE_DEBUG is configured,
allocate memory for c->verify_ondisk may fail if the bucket size > 8MB,
which will require __get_free_pages() to allocate continuous pages
with order > 11 (the default MAX_ORDER of Linux buddy allocator). Such
over size allocation will fail, and cause 2 problems,
- When CONFIG_BCACHE_DEBUG is configured,  bch_btree_verify() does not
  work, because c->verify_ondisk is NULL and bch_btree_verify() returns
  immediately.
- bch_btree_cache_alloc() will fail due to c->verify_ondisk allocation
  failed, then the whole cache device registration fails. And because of
  this failure, the first problem of bch_btree_verify() has no chance to
  be triggered.

This patch fixes the above problem by two means,
1) If pages allocation of c->verify_ondisk fails, set it to NULL and
   returns bch_btree_cache_alloc() with -ENOMEM.
2) When calling __get_free_pages() to allocate c->verify_ondisk pages,
   use ilog2(meta_bucket_pages(&c->sb)) to make sure ilog2() will always
   generate a pages order <= MAX_ORDER (or CONFIG_FORCE_MAX_ZONEORDER).
   Then the buddy system won't directly reject the allocation request.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/btree.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 6548a601edf0..a9d59b6c7d85 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -738,7 +738,7 @@ void bch_btree_cache_free(struct cache_set *c)
 	if (c->verify_data)
 		list_move(&c->verify_data->list, &c->btree_cache);
 
-	free_pages((unsigned long) c->verify_ondisk, ilog2(bucket_pages(c)));
+	free_pages((unsigned long) c->verify_ondisk, ilog2(meta_bucket_pages(&c->sb)));
 #endif
 
 	list_splice(&c->btree_cache_freeable,
@@ -785,7 +785,15 @@ int bch_btree_cache_alloc(struct cache_set *c)
 	mutex_init(&c->verify_lock);
 
 	c->verify_ondisk = (void *)
-		__get_free_pages(GFP_KERNEL, ilog2(bucket_pages(c)));
+		__get_free_pages(GFP_KERNEL, ilog2(meta_bucket_pages(&c->sb)));
+	if (!c->verify_ondisk) {
+		/*
+		 * Don't worry about the mca_rereserve buckets
+		 * allocated in previous for-loop, they will be
+		 * handled properly in bch_cache_set_unregister().
+		 */
+		return -ENOMEM;
+	}
 
 	c->verify_data = mca_bucket_alloc(c, &ZERO_KEY, GFP_KERNEL);
 
-- 
2.26.2

