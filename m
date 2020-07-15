Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065DD22048D
	for <lists+linux-block@lfdr.de>; Wed, 15 Jul 2020 07:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgGOFqn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Jul 2020 01:46:43 -0400
Received: from [195.135.220.15] ([195.135.220.15]:38516 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbgGOFqm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 01:46:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 25D35AC20;
        Wed, 15 Jul 2020 05:46:44 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH v2 10/17] bcache: handle c->uuids properly for bucket size > 8MB
Date:   Wed, 15 Jul 2020 13:46:05 +0800
Message-Id: <20200715054612.6349-11-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715054612.6349-1-colyli@suse.de>
References: <20200715054612.6349-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bcache allocates a whole bucket to store c->uuids on cache device, and
allocates continuous pages to store it in-memory. When the bucket size
exceeds maximum allocable continuous pages, bch_cache_set_alloc() will
fail and cache device registration will fail.

This patch allocates c->uuids by alloc_meta_bucket_pages(), and uses
ilog2(meta_bucket_pages(c)) to indicate order of c->uuids pages when
free it. When writing c->uuids to cache device, its size is decided
by meta_bucket_pages(c) * PAGE_SECTORS. Now c->uuids is properly handled
for bucket size > 8MB.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 73086cf6a2f3..9e1f2f529fc3 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -466,6 +466,7 @@ static int __uuid_write(struct cache_set *c)
 	BKEY_PADDED(key) k;
 	struct closure cl;
 	struct cache *ca;
+	unsigned int size;
 
 	closure_init_stack(&cl);
 	lockdep_assert_held(&bch_register_lock);
@@ -473,7 +474,8 @@ static int __uuid_write(struct cache_set *c)
 	if (bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, 1, true))
 		return 1;
 
-	SET_KEY_SIZE(&k.key, c->sb.bucket_size);
+	size =  meta_bucket_pages(&c->sb) * PAGE_SECTORS;
+	SET_KEY_SIZE(&k.key, size);
 	uuid_io(c, REQ_OP_WRITE, 0, &k.key, &cl);
 	closure_sync(&cl);
 
@@ -1656,7 +1658,7 @@ static void cache_set_free(struct closure *cl)
 		}
 
 	bch_bset_sort_state_free(&c->sort);
-	free_pages((unsigned long) c->uuids, ilog2(bucket_pages(c)));
+	free_pages((unsigned long) c->uuids, ilog2(meta_bucket_pages(&c->sb)));
 
 	if (c->moving_gc_wq)
 		destroy_workqueue(c->moving_gc_wq);
@@ -1862,7 +1864,7 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 
 	c->bucket_bits		= ilog2(sb->bucket_size);
 	c->block_bits		= ilog2(sb->block_size);
-	c->nr_uuids		= bucket_bytes(c) / sizeof(struct uuid_entry);
+	c->nr_uuids		= meta_bucket_bytes(&c->sb) / sizeof(struct uuid_entry);
 	c->devices_max_used	= 0;
 	atomic_set(&c->attached_dev_nr, 0);
 	c->btree_pages		= bucket_pages(c);
@@ -1913,7 +1915,7 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 			BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER))
 		goto err;
 
-	c->uuids = alloc_bucket_pages(GFP_KERNEL, c);
+	c->uuids = alloc_meta_bucket_pages(GFP_KERNEL, &c->sb);
 	if (!c->uuids)
 		goto err;
 
-- 
2.26.2

