Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A418727E35
	for <lists+linux-block@lfdr.de>; Thu,  8 Jun 2023 13:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbjFHLGc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 8 Jun 2023 07:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbjFHLGD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jun 2023 07:06:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D6C3A82;
        Thu,  8 Jun 2023 04:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vY4TzS76/rJ2xce2OD2MlrdJfdqE96jSdZdHV2ROwoI=; b=qtZc66QRnp6ItyMHZhuUGe4A72
        oyK4P17k4i9Jb1HIO4XtasJgiPIm6p6crRVvWHHR0j0/9GEb6CBkbLV9MTbVP6DdY2Mfm98SLeTnT
        9mLNMtLmQhKjNylaC1PAef4Q7FzQ0pBzRblaH4gZF769uixkLEtT9ztqGg04mcOqgLBwawZL50W7T
        kHxO4V5h7JuAnuMXQ0G/NZW9PIiYBaQWnXrk81+Xg/nignplbrRscS+3zydxIt3mk4CjPW8jF4lFD
        nbbYeIBITvF/v2l/ARUaUnGbAWR0CzX5NkYxlkYPZdMZ/gNvUDFfOcfgqIodGUOmv+5VAAilMRx5f
        DB4z1kzA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7DR0-0092dV-19;
        Thu, 08 Jun 2023 11:04:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 22/30] mtd: block: use a simple bool to track open for write
Date:   Thu,  8 Jun 2023 13:02:50 +0200
Message-Id: <20230608110258.189493-23-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608110258.189493-1-hch@lst.de>
References: <20230608110258.189493-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of propagating the fmode_t, just use a bool to track if a mtd
block device was opened for writing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Christian Brauner <brauner@kernel.org>
Acked-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/mtd_blkdevs.c    | 2 +-
 drivers/mtd/mtdblock.c       | 2 +-
 include/linux/mtd/blktrans.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index f0bb09fde95e3a..bd0b7545364349 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -208,7 +208,7 @@ static int blktrans_open(struct gendisk *disk, fmode_t mode)
 	ret = __get_mtd_device(dev->mtd);
 	if (ret)
 		goto error_release;
-	dev->file_mode = mode;
+	dev->writable = mode & FMODE_WRITE;
 
 unlock:
 	dev->open++;
diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
index a0a1194dc1d902..fa476fb4dffb6c 100644
--- a/drivers/mtd/mtdblock.c
+++ b/drivers/mtd/mtdblock.c
@@ -294,7 +294,7 @@ static void mtdblock_release(struct mtd_blktrans_dev *mbd)
 		 * It was the last usage. Free the cache, but only sync if
 		 * opened for writing.
 		 */
-		if (mbd->file_mode & FMODE_WRITE)
+		if (mbd->writable)
 			mtd_sync(mbd->mtd);
 		vfree(mtdblk->cache_data);
 	}
diff --git a/include/linux/mtd/blktrans.h b/include/linux/mtd/blktrans.h
index 15cc9b95e32b52..6e471436bba556 100644
--- a/include/linux/mtd/blktrans.h
+++ b/include/linux/mtd/blktrans.h
@@ -34,7 +34,7 @@ struct mtd_blktrans_dev {
 	struct blk_mq_tag_set *tag_set;
 	spinlock_t queue_lock;
 	void *priv;
-	fmode_t file_mode;
+	bool writable;
 };
 
 struct mtd_blktrans_ops {
-- 
2.39.2

