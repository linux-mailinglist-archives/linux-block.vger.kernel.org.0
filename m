Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8166D66B7
	for <lists+linux-block@lfdr.de>; Tue,  4 Apr 2023 17:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjDDPFt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 4 Apr 2023 11:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjDDPFt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:05:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27663C05
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=P8w6r9qD+e70x8hoHzl3GAkv9iBoehclSbBpJPIGGtQ=; b=OE7yl12dfo1MNcr5YuTVj1ef0e
        BXztOfmXdIYAjm/xW5BRtccFnPJ6fcD5dbjCaEo96w4b3Z/eN9RmOTB1u0OAdxBtZsk/AZfM1K0wl
        zIX7CIgxsAqmr6rQh3XfQiRhfyahirlm3OCD136mg14ooH0nWNSbPLWyEsG8SKHlctTPXp7/3Qjz7
        ru08rve5QFAlqjXekX3RPNawBlUsXOVdU9NjrDdC1ypQxpGZ/LlDpxLwJGMzMnIh0KMABCkVNpA3s
        TbBKHWY0t0Y7/W7vLJSixRcc8JpFPbbN3hD5299nKJEZZ73ejrd0gJyUGdY/ZiObg0ulL5gNTi7Et
        irvhiJiA==;
Received: from [2001:4bb8:191:a744:23e5:e88f:5622:7c79] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiE9-001vpM-34;
        Tue, 04 Apr 2023 15:05:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 01/16] zram: remove valid_io_request
Date:   Tue,  4 Apr 2023 17:05:21 +0200
Message-Id: <20230404150536.2142108-2-hch@lst.de>
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

All bios hande to drivers from the block layer are checked against the
device size and for logical block alignment already, so don't duplicate
those checks.  Merge __zram_make_request into zram_submit_bio now that
there is no point in splitting them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 34 +---------------------------------
 drivers/block/zram/zram_drv.h |  1 -
 2 files changed, 1 insertion(+), 34 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aa490da3cef233..0c6b3ba2970b5f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -174,30 +174,6 @@ static inline u32 zram_get_priority(struct zram *zram, u32 index)
 	return prio & ZRAM_COMP_PRIORITY_MASK;
 }
 
-/*
- * Check if request is within bounds and aligned on zram logical blocks.
- */
-static inline bool valid_io_request(struct zram *zram,
-		sector_t start, unsigned int size)
-{
-	u64 end, bound;
-
-	/* unaligned request */
-	if (unlikely(start & (ZRAM_SECTOR_PER_LOGICAL_BLOCK - 1)))
-		return false;
-	if (unlikely(size & (ZRAM_LOGICAL_BLOCK_SIZE - 1)))
-		return false;
-
-	end = start + (size >> SECTOR_SHIFT);
-	bound = zram->disksize >> SECTOR_SHIFT;
-	/* out of range */
-	if (unlikely(start >= bound || end > bound || start > end))
-		return false;
-
-	/* I/O request is valid */
-	return true;
-}
-
 static void update_position(u32 *index, int *offset, struct bio_vec *bvec)
 {
 	*index  += (*offset + bvec->bv_len) / PAGE_SIZE;
@@ -1190,10 +1166,9 @@ static ssize_t io_stat_show(struct device *dev,
 
 	down_read(&zram->init_lock);
 	ret = scnprintf(buf, PAGE_SIZE,
-			"%8llu %8llu %8llu %8llu\n",
+			"%8llu %8llu 0 %8llu\n",
 			(u64)atomic64_read(&zram->stats.failed_reads),
 			(u64)atomic64_read(&zram->stats.failed_writes),
-			(u64)atomic64_read(&zram->stats.invalid_io),
 			(u64)atomic64_read(&zram->stats.notify_free));
 	up_read(&zram->init_lock);
 
@@ -2043,13 +2018,6 @@ static void zram_submit_bio(struct bio *bio)
 {
 	struct zram *zram = bio->bi_bdev->bd_disk->private_data;
 
-	if (!valid_io_request(zram, bio->bi_iter.bi_sector,
-					bio->bi_iter.bi_size)) {
-		atomic64_inc(&zram->stats.invalid_io);
-		bio_io_error(bio);
-		return;
-	}
-
 	__zram_make_request(zram, bio);
 }
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index c5254626f051fa..ca7a15bd48456a 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -78,7 +78,6 @@ struct zram_stats {
 	atomic64_t compr_data_size;	/* compressed size of pages stored */
 	atomic64_t failed_reads;	/* can happen when memory is too low */
 	atomic64_t failed_writes;	/* can happen when memory is too low */
-	atomic64_t invalid_io;	/* non-page-aligned I/O requests */
 	atomic64_t notify_free;	/* no. of swap slot free notifications */
 	atomic64_t same_pages;		/* no. of same element filled pages */
 	atomic64_t huge_pages;		/* no. of huge pages */
-- 
2.39.2

