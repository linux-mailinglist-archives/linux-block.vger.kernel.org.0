Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF12A778CF1
	for <lists+linux-block@lfdr.de>; Fri, 11 Aug 2023 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbjHKLFz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Aug 2023 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbjHKLFR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2023 07:05:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EE6E58;
        Fri, 11 Aug 2023 04:05:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DCFDF1F895;
        Fri, 11 Aug 2023 11:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691751905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sUywVmnHgB6WDmr1bSP7I5Das1AhBrcGVGMzyHmpeYM=;
        b=binFoihiN586MuJCJRpuRS/xF9iJMWnc5eFm+hH+8bJRcfwjrxvb6RKiWu+SwtK859hOMr
        l6lq3cAvAZVCncsD8HUrgEJoHLmZcrY4njuesyA4ayvT4kvv3I8zCEZMFZaaCu51wxZj4B
        VNQHDcZXDt53cO9Q9D0JmS6/6EjUzT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691751905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sUywVmnHgB6WDmr1bSP7I5Das1AhBrcGVGMzyHmpeYM=;
        b=c4HGwJyo+7C/rtHIsSgPcgEPjfB/uRb1sEkmW1VhiBWoPsR9K08upr2n7emLWQFxJJAKDL
        TurYTKHoq9c9TiBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C59B7139FD;
        Fri, 11 Aug 2023 11:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x0XHL+EV1mRORQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 11:05:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0911BA078B; Fri, 11 Aug 2023 13:05:05 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Joern Engel <joern@lazybastard.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 12/29] mtd: block2mtd: Convert to bdev_open_by_dev/path()
Date:   Fri, 11 Aug 2023 13:04:43 +0200
Message-Id: <20230811110504.27514-12-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810171429.31759-1-jack@suse.cz>
References: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6082; i=jack@suse.cz; h=from:subject; bh=zrzvoMsGBKwNTYQ1CHBX/zUflHBF8k8siIyJa7ZUiAA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk1hXNl2oBXeXfkbBeMC1wYP2F1ErV8xaPc1mdMKkZ uGtMKjqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZNYVzQAKCRCcnaoHP2RA2XrFB/ 4l9sn6iqFwNjsG8teFa6KNfxzj/r+7nocbrHoBGU3jwwIfa4xH/prrUhcOkZh4tnNkFxsZjKSlImmP tKU1nDCTYDHkVUdMGmqgRM2nMNHmBq06/rH90yKtKo4tYPco4mKXlhFB6UyPnN91F8TqpvS5ewPq3o VD1pmc5KSB3DbKmUl6Z25wsH3rjW1WLiuJmAZ2ZajqDtRJ3Maxd1Mt5b0h8ChmMTGn5RR8vPa8zXum Z+QLTjSzJDfelr7YFg6Xhjb1ijKKYmZuPh42Rf//oNgG+exWi0hXlROXAxX+wXFibLtoWcMqzAllCz AnG1LYHQcnRpJZpgPjhela+bWRcyfG
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Convert block2mtd to use bdev_open_by_dev() and bdev_open_by_path() and
pass the handle around.

CC: Joern Engel <joern@lazybastard.org>
CC: linux-mtd@lists.infradead.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/mtd/devices/block2mtd.c | 51 +++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index be106dc20ff3..aa44a23ec045 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -37,7 +37,7 @@
 /* Info for the block device */
 struct block2mtd_dev {
 	struct list_head list;
-	struct block_device *blkdev;
+	struct bdev_handle *bdev_handle;
 	struct mtd_info mtd;
 	struct mutex write_mutex;
 };
@@ -55,7 +55,8 @@ static struct page *page_read(struct address_space *mapping, pgoff_t index)
 /* erase a specified part of the device */
 static int _block2mtd_erase(struct block2mtd_dev *dev, loff_t to, size_t len)
 {
-	struct address_space *mapping = dev->blkdev->bd_inode->i_mapping;
+	struct address_space *mapping =
+				dev->bdev_handle->bdev->bd_inode->i_mapping;
 	struct page *page;
 	pgoff_t index = to >> PAGE_SHIFT;	// page index
 	int pages = len >> PAGE_SHIFT;
@@ -105,6 +106,8 @@ static int block2mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
 		size_t *retlen, u_char *buf)
 {
 	struct block2mtd_dev *dev = mtd->priv;
+	struct address_space *mapping =
+				dev->bdev_handle->bdev->bd_inode->i_mapping;
 	struct page *page;
 	pgoff_t index = from >> PAGE_SHIFT;
 	int offset = from & (PAGE_SIZE-1);
@@ -117,7 +120,7 @@ static int block2mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
 			cpylen = len;	// this page
 		len = len - cpylen;
 
-		page = page_read(dev->blkdev->bd_inode->i_mapping, index);
+		page = page_read(mapping, index);
 		if (IS_ERR(page))
 			return PTR_ERR(page);
 
@@ -139,7 +142,8 @@ static int _block2mtd_write(struct block2mtd_dev *dev, const u_char *buf,
 		loff_t to, size_t len, size_t *retlen)
 {
 	struct page *page;
-	struct address_space *mapping = dev->blkdev->bd_inode->i_mapping;
+	struct address_space *mapping =
+				dev->bdev_handle->bdev->bd_inode->i_mapping;
 	pgoff_t index = to >> PAGE_SHIFT;	// page index
 	int offset = to & ~PAGE_MASK;	// page offset
 	int cpylen;
@@ -194,7 +198,7 @@ static int block2mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
 static void block2mtd_sync(struct mtd_info *mtd)
 {
 	struct block2mtd_dev *dev = mtd->priv;
-	sync_blockdev(dev->blkdev);
+	sync_blockdev(dev->bdev_handle->bdev);
 	return;
 }
 
@@ -206,10 +210,10 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
 
 	kfree(dev->mtd.name);
 
-	if (dev->blkdev) {
-		invalidate_mapping_pages(dev->blkdev->bd_inode->i_mapping,
-					0, -1);
-		blkdev_put(dev->blkdev, NULL);
+	if (dev->bdev_handle) {
+		invalidate_mapping_pages(
+			dev->bdev_handle->bdev->bd_inode->i_mapping, 0, -1);
+		bdev_release(dev->bdev_handle);
 	}
 
 	kfree(dev);
@@ -219,10 +223,10 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
  * This function is marked __ref because it calls the __init marked
  * early_lookup_bdev when called from the early boot code.
  */
-static struct block_device __ref *mdtblock_early_get_bdev(const char *devname,
+static struct bdev_handle __ref *mdtblock_early_get_bdev(const char *devname,
 		blk_mode_t mode, int timeout, struct block2mtd_dev *dev)
 {
-	struct block_device *bdev = ERR_PTR(-ENODEV);
+	struct bdev_handle *bdev_handle = ERR_PTR(-ENODEV);
 #ifndef MODULE
 	int i;
 
@@ -230,7 +234,7 @@ static struct block_device __ref *mdtblock_early_get_bdev(const char *devname,
 	 * We can't use early_lookup_bdev from a running system.
 	 */
 	if (system_state >= SYSTEM_RUNNING)
-		return bdev;
+		return bdev_handle;
 
 	/*
 	 * We might not have the root device mounted at this point.
@@ -249,19 +253,20 @@ static struct block_device __ref *mdtblock_early_get_bdev(const char *devname,
 		wait_for_device_probe();
 
 		if (!early_lookup_bdev(devname, &devt)) {
-			bdev = blkdev_get_by_dev(devt, mode, dev, NULL);
-			if (!IS_ERR(bdev))
+			bdev_handle = bdev_open_by_dev(devt, mode, dev, NULL);
+			if (!IS_ERR(bdev_handle))
 				break;
 		}
 	}
 #endif
-	return bdev;
+	return bdev_handle;
 }
 
 static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		char *label, int timeout)
 {
 	const blk_mode_t mode = BLK_OPEN_READ | BLK_OPEN_WRITE;
+	struct bdev_handle *bdev_handle;
 	struct block_device *bdev;
 	struct block2mtd_dev *dev;
 	char *name;
@@ -274,21 +279,23 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		return NULL;
 
 	/* Get a handle on the device */
-	bdev = blkdev_get_by_path(devname, mode, dev, NULL);
-	if (IS_ERR(bdev))
-		bdev = mdtblock_early_get_bdev(devname, mode, timeout, dev);
-	if (IS_ERR(bdev)) {
+	bdev_handle = bdev_open_by_path(devname, mode, dev, NULL);
+	if (IS_ERR(bdev_handle))
+		bdev_handle = mdtblock_early_get_bdev(devname, mode, timeout,
+						      dev);
+	if (IS_ERR(bdev_handle)) {
 		pr_err("error: cannot open device %s\n", devname);
 		goto err_free_block2mtd;
 	}
-	dev->blkdev = bdev;
+	dev->bdev_handle = bdev_handle;
+	bdev = bdev_handle->bdev;
 
 	if (MAJOR(bdev->bd_dev) == MTD_BLOCK_MAJOR) {
 		pr_err("attempting to use an MTD device as a block device\n");
 		goto err_free_block2mtd;
 	}
 
-	if ((long)dev->blkdev->bd_inode->i_size % erase_size) {
+	if ((long)bdev->bd_inode->i_size % erase_size) {
 		pr_err("erasesize must be a divisor of device size\n");
 		goto err_free_block2mtd;
 	}
@@ -306,7 +313,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 
 	dev->mtd.name = name;
 
-	dev->mtd.size = dev->blkdev->bd_inode->i_size & PAGE_MASK;
+	dev->mtd.size = bdev->bd_inode->i_size & PAGE_MASK;
 	dev->mtd.erasesize = erase_size;
 	dev->mtd.writesize = 1;
 	dev->mtd.writebufsize = PAGE_SIZE;
-- 
2.35.3

