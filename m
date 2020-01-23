Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D84B146F00
	for <lists+linux-block@lfdr.de>; Thu, 23 Jan 2020 18:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgAWRCr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 Jan 2020 12:02:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:51702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729715AbgAWRCr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jan 2020 12:02:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0C452AC50;
        Thu, 23 Jan 2020 17:02:45 +0000 (UTC)
From:   colyli@suse.de
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>
Subject: [PATCH 08/17] bcache: store a pointer to the on-disk sb in the cache and cached_dev structures
Date:   Fri, 24 Jan 2020 01:01:33 +0800
Message-Id: <20200123170142.98974-9-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200123170142.98974-1-colyli@suse.de>
References: <20200123170142.98974-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

This allows to properly build the superblock bio including the offset in
the page using the normal bio helpers.  This fixes writing the superblock
for page sizes larger than 4k where the sb write bio would need an offset
in the bio_vec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bcache.h |  2 ++
 drivers/md/bcache/super.c  | 34 +++++++++++++++-------------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 9198c1b480d9..adf26a21fcd1 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -301,6 +301,7 @@ struct cached_dev {
 	struct block_device	*bdev;
 
 	struct cache_sb		sb;
+	struct cache_sb_disk	*sb_disk;
 	struct bio		sb_bio;
 	struct bio_vec		sb_bv[1];
 	struct closure		sb_write;
@@ -403,6 +404,7 @@ enum alloc_reserve {
 struct cache {
 	struct cache_set	*set;
 	struct cache_sb		sb;
+	struct cache_sb_disk	*sb_disk;
 	struct bio		sb_bio;
 	struct bio_vec		sb_bv[1];
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index b30e4c6011d2..5797c03f993e 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -207,15 +207,15 @@ static void write_bdev_super_endio(struct bio *bio)
 	closure_put(&dc->sb_write);
 }
 
-static void __write_super(struct cache_sb *sb, struct bio *bio)
+static void __write_super(struct cache_sb *sb, struct cache_sb_disk *out,
+		struct bio *bio)
 {
-	struct cache_sb_disk *out = page_address(bio_first_page_all(bio));
 	unsigned int i;
 
+	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_META;
 	bio->bi_iter.bi_sector	= SB_SECTOR;
-	bio->bi_iter.bi_size	= SB_SIZE;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC|REQ_META);
-	bch_bio_map(bio, NULL);
+	__bio_add_page(bio, virt_to_page(out), SB_SIZE,
+			offset_in_page(out));
 
 	out->offset		= cpu_to_le64(sb->offset);
 	out->version		= cpu_to_le64(sb->version);
@@ -257,14 +257,14 @@ void bch_write_bdev_super(struct cached_dev *dc, struct closure *parent)
 	down(&dc->sb_write_mutex);
 	closure_init(cl, parent);
 
-	bio_reset(bio);
+	bio_init(bio, dc->sb_bv, 1);
 	bio_set_dev(bio, dc->bdev);
 	bio->bi_end_io	= write_bdev_super_endio;
 	bio->bi_private = dc;
 
 	closure_get(cl);
 	/* I/O request sent to backing device */
-	__write_super(&dc->sb, bio);
+	__write_super(&dc->sb, dc->sb_disk, bio);
 
 	closure_return_with_destructor(cl, bch_write_bdev_super_unlock);
 }
@@ -306,13 +306,13 @@ void bcache_write_super(struct cache_set *c)
 
 		SET_CACHE_SYNC(&ca->sb, CACHE_SYNC(&c->sb));
 
-		bio_reset(bio);
+		bio_init(bio, ca->sb_bv, 1);
 		bio_set_dev(bio, ca->bdev);
 		bio->bi_end_io	= write_super_endio;
 		bio->bi_private = ca;
 
 		closure_get(cl);
-		__write_super(&ca->sb, bio);
+		__write_super(&ca->sb, ca->sb_disk, bio);
 	}
 
 	closure_return_with_destructor(cl, bcache_write_super_unlock);
@@ -1275,8 +1275,8 @@ static void cached_dev_free(struct closure *cl)
 
 	mutex_unlock(&bch_register_lock);
 
-	if (dc->sb_bio.bi_inline_vecs[0].bv_page)
-		put_page(bio_first_page_all(&dc->sb_bio));
+	if (dc->sb_disk)
+		put_page(virt_to_page(dc->sb_disk));
 
 	if (!IS_ERR_OR_NULL(dc->bdev))
 		blkdev_put(dc->bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
@@ -1365,9 +1365,7 @@ static int register_bdev(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 	memcpy(&dc->sb, sb, sizeof(struct cache_sb));
 	dc->bdev = bdev;
 	dc->bdev->bd_holder = dc;
-
-	bio_init(&dc->sb_bio, dc->sb_bio.bi_inline_vecs, 1);
-	bio_first_bvec_all(&dc->sb_bio)->bv_page = virt_to_page(sb_disk);
+	dc->sb_disk = sb_disk;
 
 	if (cached_dev_init(dc, sb->block_size << 9))
 		goto err;
@@ -2137,8 +2135,8 @@ void bch_cache_release(struct kobject *kobj)
 	for (i = 0; i < RESERVE_NR; i++)
 		free_fifo(&ca->free[i]);
 
-	if (ca->sb_bio.bi_inline_vecs[0].bv_page)
-		put_page(bio_first_page_all(&ca->sb_bio));
+	if (ca->sb_disk)
+		put_page(virt_to_page(ca->sb_disk));
 
 	if (!IS_ERR_OR_NULL(ca->bdev))
 		blkdev_put(ca->bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
@@ -2270,9 +2268,7 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 	memcpy(&ca->sb, sb, sizeof(struct cache_sb));
 	ca->bdev = bdev;
 	ca->bdev->bd_holder = ca;
-
-	bio_init(&ca->sb_bio, ca->sb_bio.bi_inline_vecs, 1);
-	bio_first_bvec_all(&ca->sb_bio)->bv_page = virt_to_page(sb_disk);
+	ca->sb_disk = sb_disk;
 
 	if (blk_queue_discard(bdev_get_queue(bdev)))
 		ca->discard = CACHE_DISCARD(&ca->sb);
-- 
2.16.4

