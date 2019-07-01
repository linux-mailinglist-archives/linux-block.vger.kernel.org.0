Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE742599B5
	for <lists+linux-block@lfdr.de>; Fri, 28 Jun 2019 14:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfF1MA4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 28 Jun 2019 08:00:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:54364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726514AbfF1MA4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 08:00:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87C7AB627;
        Fri, 28 Jun 2019 12:00:55 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 11/37] bcache: remove unncessary code in bch_btree_keys_init()
Date:   Fri, 28 Jun 2019 19:59:34 +0800
Message-Id: <20190628120000.40753-12-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190628120000.40753-1-colyli@suse.de>
References: <20190628120000.40753-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Function bch_btree_keys_init() initializes b->set[].size and
b->set[].data to zero. As the code comments indicates, these code indeed
is unncessary, because both struct btree_keys and struct bset_tree are
nested embedded into struct btree, when struct btree is filled with 0
bits by kzalloc() in mca_bucket_alloc(), b->set[].size and
b->set[].data are initialized to 0 (a.k.a NULL) already.

This patch removes the redundant code, and add comments in
bch_btree_keys_init() and mca_bucket_alloc() to explain why it's safe.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bset.c  | 15 ++++++---------
 drivers/md/bcache/btree.c |  4 ++++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
index e36a108d3648..8af9509e78bd 100644
--- a/drivers/md/bcache/bset.c
+++ b/drivers/md/bcache/bset.c
@@ -347,22 +347,19 @@ EXPORT_SYMBOL(bch_btree_keys_alloc);
 void bch_btree_keys_init(struct btree_keys *b, const struct btree_keys_ops *ops,
 			 bool *expensive_debug_checks)
 {
-	unsigned int i;
-
 	b->ops = ops;
 	b->expensive_debug_checks = expensive_debug_checks;
 	b->nsets = 0;
 	b->last_set_unwritten = 0;
 
-	/* XXX: shouldn't be needed */
-	for (i = 0; i < MAX_BSETS; i++)
-		b->set[i].size = 0;
 	/*
-	 * Second loop starts at 1 because b->keys[0]->data is the memory we
-	 * allocated
+	 * struct btree_keys in embedded in struct btree, and struct
+	 * bset_tree is embedded into struct btree_keys. They are all
+	 * initialized as 0 by kzalloc() in mca_bucket_alloc(), and
+	 * b->set[0].data is allocated in bch_btree_keys_alloc(), so we
+	 * don't have to initiate b->set[].size and b->set[].data here
+	 * any more.
 	 */
-	for (i = 1; i < MAX_BSETS; i++)
-		b->set[i].data = NULL;
 }
 EXPORT_SYMBOL(bch_btree_keys_init);
 
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 773f5fdad25f..cf38a1b031fa 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -613,6 +613,10 @@ static void mca_data_alloc(struct btree *b, struct bkey *k, gfp_t gfp)
 static struct btree *mca_bucket_alloc(struct cache_set *c,
 				      struct bkey *k, gfp_t gfp)
 {
+	/*
+	 * kzalloc() is necessary here for initialization,
+	 * see code comments in bch_btree_keys_init().
+	 */
 	struct btree *b = kzalloc(sizeof(struct btree), gfp);
 
 	if (!b)
-- 
2.16.4

