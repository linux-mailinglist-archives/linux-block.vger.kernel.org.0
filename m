Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA9122D756
	for <lists+linux-block@lfdr.de>; Sat, 25 Jul 2020 14:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgGYMDc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 25 Jul 2020 08:03:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:52594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgGYMDb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jul 2020 08:03:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A534AB55;
        Sat, 25 Jul 2020 12:03:38 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        Coly Li <colyli@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 20/25] bcache: handle btree node memory allocation properly for bucket size > 8MB
Date:   Sat, 25 Jul 2020 20:00:34 +0800
Message-Id: <20200725120039.91071-21-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200725120039.91071-1-colyli@suse.de>
References: <20200725120039.91071-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently the bcache internal btree node occupies a whole bucket. When
loading the btree node from cache device into memory, mca_data_alloc()
will call bch_btree_keys_alloc() to allocate memory for the whole bucket
size, ilog2(b->c->btree_pages) is send to bch_btree_keys_alloc() as the
parameter 'page_order'.

c->btree_pages is set as bucket_pages() in bch_cache_set_alloc(), for
bucket size > 8MB, ilog2(b->c->btree_pages) is 12 for 4KB page size. By
default the maximum page order __get_free_pages() accepts is MAX_ORDER
(11), in this condition bch_btree_keys_alloc() will always fail.

Because of other over-page-order allocation failure fails the cache
device registration, such btree node allocation failure wasn't observed
during runtime. After other blocking page allocation failures for bucket
size > 8MB, this btree node allocation issue may trigger potentical risk
e.g. infinite dead-loop to retry btree node allocation after failure.

This patch fixes the potential problem by setting c->btree_pages to
meta_bucket_pages() in bch_cache_set_alloc(). In the condition that
bucket size > 8MB, meta_bucket_pages() will always return a number which
won't exceed the maximum page order of the buddy allocator.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/bcache/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 1c4a4c3557f7..172246ff5ec2 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1867,7 +1867,7 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 	c->nr_uuids		= meta_bucket_bytes(&c->sb) / sizeof(struct uuid_entry);
 	c->devices_max_used	= 0;
 	atomic_set(&c->attached_dev_nr, 0);
-	c->btree_pages		= bucket_pages(c);
+	c->btree_pages		= meta_bucket_pages(&c->sb);
 	if (c->btree_pages > BTREE_MAX_PAGES)
 		c->btree_pages = max_t(int, c->btree_pages / 4,
 				       BTREE_MAX_PAGES);
-- 
2.26.2

