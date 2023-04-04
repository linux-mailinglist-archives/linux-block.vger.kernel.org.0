Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36A76D66C6
	for <lists+linux-block@lfdr.de>; Tue,  4 Apr 2023 17:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjDDPG1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 4 Apr 2023 11:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjDDPG0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:06:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DF226A3
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Bkt4anes3iPcDkGVJ62AANifMSHrb8KT53PWe8GiVyI=; b=gErRmXAdjDry44yHy3oDbB3RBg
        MNQVrlxJQyITE1BIZd0eiqP1SbmI2WsFrmdlhLiiwJm6ODHH5AYcMWps5RmU9HMB7LP/aSt0KZYup
        dgEdq8DOmu6gCzRgWkqEeknAn6nygwhSWa++ioMvhLxLaCYPn7BTOn8b/WdFFU9jPb5yB0+PteZgX
        OPNFqbrt04zsrU81MgCY+MgEniZC5E9cxfbMn/2pCpmsWukcj6XHYYflhWnjPcGox7fXP49S05VEG
        dBzFr1w5wEJEJrUM2IpFWtuQFb740ILMLsk/IqNV+E0V81FvhuY9iCebbRQfw8Hjm2oyWSCoGaB8e
        w0gRosDw==;
Received: from [2001:4bb8:191:a744:23e5:e88f:5622:7c79] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiEj-001vvU-2r;
        Tue, 04 Apr 2023 15:06:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 15/16] zram: fix synchronous reads
Date:   Tue,  4 Apr 2023 17:05:35 +0200
Message-Id: <20230404150536.2142108-16-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404150536.2142108-1-hch@lst.de>
References: <20230404150536.2142108-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently nothing waits for the synchronous reads before accessing
the data.  Switch them to an on-stack bio and submit_bio_wait to
make sure the I/O has actually completed when the work item has been
flushed.  This also removes the call to page_endio that would unlock
a page that has never been locked.

Drop the partial_io/sync flag, as chaining only makes sense for the
asynchronous reads of the entire page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 64 +++++++++++++----------------------
 1 file changed, 24 insertions(+), 40 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b9b14165e651f9..0a98a0ba14607a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -55,7 +55,7 @@ static const struct block_device_operations zram_devops;
 
 static void zram_free_page(struct zram *zram, size_t index);
 static int zram_read_page(struct zram *zram, struct page *page, u32 index,
-			  struct bio *bio, bool partial_io);
+			  struct bio *parent);
 
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
@@ -575,31 +575,15 @@ static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 	atomic64_dec(&zram->stats.bd_count);
 }
 
-static void zram_page_end_io(struct bio *bio)
-{
-	struct page *page = bio_first_page_all(bio);
-
-	page_endio(page, op_is_write(bio_op(bio)),
-			blk_status_to_errno(bio->bi_status));
-	bio_put(bio);
-}
-
 static void read_from_bdev_async(struct zram *zram, struct page *page,
 			unsigned long entry, struct bio *parent)
 {
 	struct bio *bio;
 
-	bio = bio_alloc(zram->bdev, 1, parent ? parent->bi_opf : REQ_OP_READ,
-			GFP_NOIO);
-
+	bio = bio_alloc(zram->bdev, 1, parent->bi_opf, GFP_NOIO);
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
 	__bio_add_page(bio, page, PAGE_SIZE, 0);
-
-	if (!parent)
-		bio->bi_end_io = zram_page_end_io;
-	else
-		bio_chain(bio, parent);
-
+	bio_chain(bio, parent);
 	submit_bio(bio);
 }
 
@@ -704,7 +688,7 @@ static ssize_t writeback_store(struct device *dev,
 		/* Need for hugepage writeback racing */
 		zram_set_flag(zram, index, ZRAM_IDLE);
 		zram_slot_unlock(zram, index);
-		if (zram_read_page(zram, page, index, NULL, false)) {
+		if (zram_read_page(zram, page, index, NULL)) {
 			zram_slot_lock(zram, index);
 			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
 			zram_clear_flag(zram, index, ZRAM_IDLE);
@@ -780,23 +764,24 @@ static ssize_t writeback_store(struct device *dev,
 	return ret;
 }
 
+#if PAGE_SIZE != 4096
 struct zram_work {
 	struct work_struct work;
 	struct zram *zram;
 	unsigned long entry;
-	struct bio *bio;
 	struct page *page;
 };
 
-#if PAGE_SIZE != 4096
 static void zram_sync_read(struct work_struct *work)
 {
 	struct zram_work *zw = container_of(work, struct zram_work, work);
-	struct zram *zram = zw->zram;
-	unsigned long entry = zw->entry;
-	struct bio *bio = zw->bio;
+	struct bio_bvec bv;
+	struct bio bio;
 
-	read_from_bdev_async(zram, zw->page, entry, bio);
+	bio_init(&bio, zw->zram->bdev, &bv, 1, REQ_OP_READ);
+	bio.bi_iter.bi_sector = zw->entry * (PAGE_SIZE >> 9);
+	__bio_add_page(&bio, zw->page, PAGE_SIZE, 0);
+	submit_bio_wait(&bio);
 }
 
 /*
@@ -805,14 +790,13 @@ static void zram_sync_read(struct work_struct *work)
  * use a worker thread context.
  */
 static int read_from_bdev_sync(struct zram *zram, struct page *page,
-				unsigned long entry, struct bio *bio)
+				unsigned long entry)
 {
 	struct zram_work work;
 
 	work.page = page;
 	work.zram = zram;
 	work.entry = entry;
-	work.bio = bio;
 
 	INIT_WORK_ONSTACK(&work.work, zram_sync_read);
 	queue_work(system_unbound_wq, &work.work);
@@ -823,7 +807,7 @@ static int read_from_bdev_sync(struct zram *zram, struct page *page,
 }
 #else
 static int read_from_bdev_sync(struct zram *zram, struct page *page,
-				unsigned long entry, struct bio *bio)
+				unsigned long entry)
 {
 	WARN_ON(1);
 	return -EIO;
@@ -831,18 +815,18 @@ static int read_from_bdev_sync(struct zram *zram, struct page *page,
 #endif
 
 static int read_from_bdev(struct zram *zram, struct page *page,
-			unsigned long entry, struct bio *parent, bool sync)
+			unsigned long entry, struct bio *parent)
 {
 	atomic64_inc(&zram->stats.bd_reads);
-	if (sync)
-		return read_from_bdev_sync(zram, page, entry, parent);
+	if (!parent)
+		return read_from_bdev_sync(zram, page, entry);
 	read_from_bdev_async(zram, page, entry, parent);
 	return 1;
 }
 #else
 static inline void reset_bdev(struct zram *zram) {};
 static int read_from_bdev(struct zram *zram, struct page *page,
-			unsigned long entry, struct bio *parent, bool sync)
+			unsigned long entry, struct bio *parent)
 {
 	return -EIO;
 }
@@ -1375,7 +1359,7 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 }
 
 static int zram_read_page(struct zram *zram, struct page *page, u32 index,
-			  struct bio *bio, bool partial_io)
+			  struct bio *parent)
 {
 	int ret;
 
@@ -1392,7 +1376,7 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 		zram_slot_unlock(zram, index);
 
 		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
-				     bio, partial_io);
+				     parent);
 	}
 
 	/* Should NEVER happen. Return bio error if it does. */
@@ -1407,14 +1391,14 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
  * always expects a full page for the output.
  */
 static int zram_bvec_read_partial(struct zram *zram, struct bio_vec *bvec,
-				  u32 index, int offset, struct bio *bio)
+				  u32 index, int offset)
 {
 	struct page *page = alloc_page(GFP_NOIO);
 	int ret;
 
 	if (!page)
 		return -ENOMEM;
-	ret = zram_read_page(zram, page, index, bio, true);
+	ret = zram_read_page(zram, page, index, NULL);
 	if (likely(!ret))
 		memcpy_to_bvec(bvec, page_address(page) + offset);
 	__free_page(page);
@@ -1425,8 +1409,8 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 			  u32 index, int offset, struct bio *bio)
 {
 	if (is_partial_io(bvec))
-		return zram_bvec_read_partial(zram, bvec, index, offset, bio);
-	return zram_read_page(zram, bvec->bv_page, index, bio, false);
+		return zram_bvec_read_partial(zram, bvec, index, offset);
+	return zram_read_page(zram, bvec->bv_page, index, bio);
 }
 
 static int zram_write_page(struct zram *zram, struct page *page, u32 index)
@@ -1566,7 +1550,7 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
 	if (!page)
 		return -ENOMEM;
 
-	ret = zram_read_page(zram, page, index, bio, true);
+	ret = zram_read_page(zram, page, index, bio);
 	if (!ret) {
 		memcpy_from_bvec(page_address(page) + offset, bvec);
 		ret = zram_write_page(zram, page, index);
-- 
2.39.2

