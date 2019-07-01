Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40262599A8
	for <lists+linux-block@lfdr.de>; Fri, 28 Jun 2019 14:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfF1MAb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 28 Jun 2019 08:00:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:54150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726837AbfF1MAb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 08:00:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2941BB631;
        Fri, 28 Jun 2019 12:00:30 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 05/37] bcache: avoid flushing btree node in cache_set_flush() if io disabled
Date:   Fri, 28 Jun 2019 19:59:28 +0800
Message-Id: <20190628120000.40753-6-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190628120000.40753-1-colyli@suse.de>
References: <20190628120000.40753-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When cache_set_flush() is called for too many I/O errors detected on
cache device and the cache set is retiring, inside the function it
doesn't make sense to flushing cached btree nodes from c->btree_cache
because CACHE_SET_IO_DISABLE is set on c->flags already and all I/Os
onto cache device will be rejected.

This patch checks in cache_set_flush() that whether CACHE_SET_IO_DISABLE
is set. If yes, then avoids to flush the cached btree nodes to reduce
more time and make cache set retiring more faster.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index ba2ad093bc80..dc6702c2c4b6 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1553,13 +1553,17 @@ static void cache_set_flush(struct closure *cl)
 	if (!IS_ERR_OR_NULL(c->root))
 		list_add(&c->root->list, &c->btree_cache);
 
-	/* Should skip this if we're unregistering because of an error */
-	list_for_each_entry(b, &c->btree_cache, list) {
-		mutex_lock(&b->write_lock);
-		if (btree_node_dirty(b))
-			__bch_btree_node_write(b, NULL);
-		mutex_unlock(&b->write_lock);
-	}
+	/*
+	 * Avoid flushing cached nodes if cache set is retiring
+	 * due to too many I/O errors detected.
+	 */
+	if (!test_bit(CACHE_SET_IO_DISABLE, &c->flags))
+		list_for_each_entry(b, &c->btree_cache, list) {
+			mutex_lock(&b->write_lock);
+			if (btree_node_dirty(b))
+				__bch_btree_node_write(b, NULL);
+			mutex_unlock(&b->write_lock);
+		}
 
 	for_each_cache(ca, c, i)
 		if (ca->alloc_thread)
-- 
2.16.4

