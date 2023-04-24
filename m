Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C926D9AD5
	for <lists+linux-block@lfdr.de>; Thu,  6 Apr 2023 16:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbjDFOnS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 6 Apr 2023 10:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239037AbjDFOmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:42:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70AFB45D
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GcTNSQ6wDs0YmVpWAR5Z7/kp8kVnhik8s2wxe0hU5tA=; b=SDU6j7KNqs3GI0dhMzrDC15gl5
        iRiEtg8/W5IWug8lNm2fphMXkUm7sFnD88hPfFRXycHBU1OTDKpqMZjpkXwbw2SwCdYWIlve1p4Qx
        ANG0F0ZSxG/i9Fdh2fdjcAHTBsLeE3n9Yjm3aAcYA53ZskgHwj7t77FdqmG9jXWmx0/XhNff+nqmq
        tvBy71PvzBSEYPye/yv7p5aVBEJ2UZhB5RyAQLrr94LTfiCmFz+tvnqLB5DSSD/s0UKTrMRxK5i11
        ZZqXdrzeD2WYKS/efkzE9oZ6YPifoNTW8Dpvdyo3hE/EZ/URYxBT4uKioUrMFg0WRhPTBTh7P+csw
        l5AulAiw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQnu-007fmv-03;
        Thu, 06 Apr 2023 14:41:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 12/16] zram: refactor zram_bdev_write
Date:   Thu,  6 Apr 2023 16:40:58 +0200
Message-Id: <20230406144102.149231-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144102.149231-1-hch@lst.de>
References: <20230406144102.149231-1-hch@lst.de>
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

Split the read/modify/write case into a separate helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 38 +++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index efda86abaf35c9..1bd6160a49b25c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1574,33 +1574,33 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	return ret;
 }
 
-static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
-				u32 index, int offset, struct bio *bio)
+/*
+ * This is a partial IO. Read the full page before writing the changes.
+ */
+static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
+				   u32 index, int offset, struct bio *bio)
 {
-	struct page *page = bvec->bv_page;
+	struct page *page = alloc_page(GFP_NOIO);
 	int ret;
 
-	if (is_partial_io(bvec)) {
-		/*
-		 * This is a partial IO. We need to read the full page
-		 * before to write the changes.
-		 */
-		page = alloc_page(GFP_NOIO);
-		if (!page)
-			return -ENOMEM;
-
-		ret = zram_read_page(zram, page, index, bio, true);
-		if (ret)
-			goto out;
+	if (!page)
+		return -ENOMEM;
 
+	ret = zram_read_page(zram, page, index, bio, true);
+	if (!ret) {
 		memcpy_from_bvec(page_address(page) + offset, bvec);
+		ret = zram_write_page(zram, page, index);
 	}
+	__free_page(page);
+	return ret;
+}
 
-	ret = zram_write_page(zram, page, index);
-out:
+static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
+			   u32 index, int offset, struct bio *bio)
+{
 	if (is_partial_io(bvec))
-		__free_page(page);
-	return ret;
+		return zram_bvec_write_partial(zram, bvec, index, offset, bio);
+	return zram_write_page(zram, bvec->bv_page, index);
 }
 
 #ifdef CONFIG_ZRAM_MULTI_COMP
-- 
2.39.2

