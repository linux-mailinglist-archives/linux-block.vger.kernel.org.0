Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8754E4E5FAD
	for <lists+linux-block@lfdr.de>; Thu, 24 Mar 2022 08:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348763AbiCXHxD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 24 Mar 2022 03:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348772AbiCXHxD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 03:53:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ED399686
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=v/cgVFIJcE16+kkB3x9gkYped74xP+Aa4p3lIpwiZu8=; b=pt4fl8tAnIXsApJo0iBmVF0DiV
        ceqw71xKKGwpIjYsB2+T7GozAkU54SuQw+6iHuQG8xc7P3Q213+I5GrIC7FXOK4+nVebnDlGv2Uay
        W2wlD7xCU+YSnVdkgExFldcrOUVdSNpaxVJYAXqCfTuQG3r2u91Q2FsuQv/dikpqF4sQq7F81GFAx
        K9EQ4eaj6FSH+Mw0pTqwsGULQcClPe6qnzXiMLUEQK+Mj7J41wJgU/51MbD40kBfJpg0rmQ4V06K1
        BHogNW/PhX63C19BJSRNntTemTqgl3Vf9rGrXdG93WV2ezXiNwt0CQ1JRR91UA+qsCQow2IN+zgvy
        px5WEdqQ==;
Received: from [2001:4bb8:19a:b822:f71:16c0:5841:924e] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXIFi-00FzTq-33; Thu, 24 Mar 2022 07:51:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: [PATCH 02/13] zram: cleanup reset_store
Date:   Thu, 24 Mar 2022 08:51:08 +0100
Message-Id: <20220324075119.1556334-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220324075119.1556334-1-hch@lst.de>
References: <20220324075119.1556334-1-hch@lst.de>
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

Use a local variable for the gendisk instead of the part0 block_device,
as the gendisk is what this function actually operates on.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e9474b02012de..fd83fad59beb1 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1786,7 +1786,7 @@ static ssize_t reset_store(struct device *dev,
 	int ret;
 	unsigned short do_reset;
 	struct zram *zram;
-	struct block_device *bdev;
+	struct gendisk *disk;
 
 	ret = kstrtou16(buf, 10, &do_reset);
 	if (ret)
@@ -1796,26 +1796,26 @@ static ssize_t reset_store(struct device *dev,
 		return -EINVAL;
 
 	zram = dev_to_zram(dev);
-	bdev = zram->disk->part0;
+	disk = zram->disk;
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
+	mutex_lock(&disk->open_mutex);
 	/* Do not reset an active device or claimed device */
-	if (bdev->bd_openers || zram->claim) {
-		mutex_unlock(&bdev->bd_disk->open_mutex);
+	if (disk->part0->bd_openers || zram->claim) {
+		mutex_unlock(&disk->open_mutex);
 		return -EBUSY;
 	}
 
 	/* From now on, anyone can't open /dev/zram[0-9] */
 	zram->claim = true;
-	mutex_unlock(&bdev->bd_disk->open_mutex);
+	mutex_unlock(&disk->open_mutex);
 
 	/* Make sure all the pending I/O are finished */
-	sync_blockdev(bdev);
+	sync_blockdev(disk->part0);
 	zram_reset_device(zram);
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
+	mutex_lock(&disk->open_mutex);
 	zram->claim = false;
-	mutex_unlock(&bdev->bd_disk->open_mutex);
+	mutex_unlock(&disk->open_mutex);
 
 	return len;
 }
-- 
2.30.2

