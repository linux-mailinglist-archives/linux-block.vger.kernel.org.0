Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD4735B50C
	for <lists+linux-block@lfdr.de>; Sun, 11 Apr 2021 15:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhDKNoy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 11 Apr 2021 09:44:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:47604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235848AbhDKNoQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 352B9AFF4;
        Sun, 11 Apr 2021 13:43:59 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 7/7] bcache: fix a regression of code compiling failure in debug.c
Date:   Sun, 11 Apr 2021 21:43:16 +0800
Message-Id: <20210411134316.80274-8-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210411134316.80274-1-colyli@suse.de>
References: <20210411134316.80274-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The patch "bcache: remove PTR_CACHE" introduces a compiling failure in
debug.c with following error message,
  In file included from drivers/md/bcache/bcache.h:182:0,
                   from drivers/md/bcache/debug.c:9:
  drivers/md/bcache/debug.c: In function 'bch_btree_verify':
  drivers/md/bcache/debug.c:53:19: error: 'c' undeclared (first use in
  this function)
    bio_set_dev(bio, c->cache->bdev);
                     ^
This patch fixes the regression by replacing c->cache->bdev by b->c->
cache->bdev.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 589a052efeb1..116edda845c3 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -50,7 +50,7 @@ void bch_btree_verify(struct btree *b)
 	v->keys.ops = b->keys.ops;
 
 	bio = bch_bbio_alloc(b->c);
-	bio_set_dev(bio, c->cache->bdev);
+	bio_set_dev(bio, b->c->cache->bdev);
 	bio->bi_iter.bi_sector	= PTR_OFFSET(&b->key, 0);
 	bio->bi_iter.bi_size	= KEY_SIZE(&v->key) << 9;
 	bio->bi_opf		= REQ_OP_READ | REQ_META;
-- 
2.26.2

