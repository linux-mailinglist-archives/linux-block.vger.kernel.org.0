Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E121B6775D7
	for <lists+linux-block@lfdr.de>; Mon, 23 Jan 2023 08:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjAWHyA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Jan 2023 02:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjAWHx7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2023 02:53:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5081F742;
        Sun, 22 Jan 2023 23:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=V1/p4cUGTZ46Ejy4+xupJDRnJIrAT8o++s3ayeaORMc=; b=Pc03rO8wT9hjdQAFo/TW/gdv7x
        qK69fsanutyaBDPlGxPY0j/KGqxTdLZSx39B1QCNRxz6s3SSQcHdRsncXDBSQMpItbU/qYV7aYdvi
        K5/KKLyQAiIxxume0Pvv5+94tcU+x4iu8GQAkqzLUBHOUqYO/GSZ19qcndZqs2hf0THIICVUg8M9J
        dkSKdjpP99GmVZd3prP/7kE8NRlNU9yu/AVXAwy5r9fKgkzRbXV8XlT8lG5uxPKauRvHFE3IZa36u
        E97P5X64K842SF8rplTEuPbi2iLl748gHP0xyjNQXlNZIr9s4relhlcSR6fVJbSuUF3yW0+Lv9c1w
        FbNO+/Yg==;
Received: from [2001:4bb8:19a:27af:cb3f:eabc:1c16:9756] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJreP-00GHAu-V9; Mon, 23 Jan 2023 07:53:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] s390/dcssblk:: don't call bio_split_to_limits
Date:   Mon, 23 Jan 2023 08:53:56 +0100
Message-Id: <20230123075356.60847-1-hch@lst.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

s390 iterates over the bio using bio_for_each_segment and doesn't need
any bio splitting.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dcssblk.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index c0f85ffb2b62de..c09f2e053bf863 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -864,10 +864,6 @@ dcssblk_submit_bio(struct bio *bio)
 	unsigned long source_addr;
 	unsigned long bytes_done;
 
-	bio = bio_split_to_limits(bio);
-	if (!bio)
-		return;
-
 	bytes_done = 0;
 	dev_info = bio->bi_bdev->bd_disk->private_data;
 	if (dev_info == NULL)
-- 
2.39.0

