Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83AFF1E8AF
	for <lists+linux-block@lfdr.de>; Wed, 15 May 2019 08:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbfEOG5y (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 May 2019 02:57:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:49062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfEOG5y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 May 2019 02:57:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 13EA8AD38;
        Wed, 15 May 2019 06:57:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6C2EC1E3CA1; Wed, 15 May 2019 08:57:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, hare@suse.de,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] block: Don't revalidate bdev of hidden gendisk
Date:   Wed, 15 May 2019 08:57:40 +0200
Message-Id: <20190515065740.12397-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When hidden gendisk is revalidated, there's no point in revalidating
associated block device as there's none. We would thus just create new
bdev inode, report "detected capacity change from 0 to XXX" message and
evict the bdev inode again. Avoid this pointless dance and confusing
message in the kernel log.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0f7552a87d54..9e671bbf7362 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1405,20 +1405,27 @@ void check_disk_size_change(struct gendisk *disk, struct block_device *bdev,
  */
 int revalidate_disk(struct gendisk *disk)
 {
-	struct block_device *bdev;
 	int ret = 0;
 
 	if (disk->fops->revalidate_disk)
 		ret = disk->fops->revalidate_disk(disk);
-	bdev = bdget_disk(disk, 0);
-	if (!bdev)
-		return ret;
 
-	mutex_lock(&bdev->bd_mutex);
-	check_disk_size_change(disk, bdev, ret == 0);
-	bdev->bd_invalidated = 0;
-	mutex_unlock(&bdev->bd_mutex);
-	bdput(bdev);
+	/*
+	 * Hidden disks don't have associated bdev so there's no point in
+	 * revalidating it.
+	 */
+	if (!(disk->flags & GENHD_FL_HIDDEN)) {
+		struct block_device *bdev = bdget_disk(disk, 0);
+
+		if (!bdev)
+			return ret;
+
+		mutex_lock(&bdev->bd_mutex);
+		check_disk_size_change(disk, bdev, ret == 0);
+		bdev->bd_invalidated = 0;
+		mutex_unlock(&bdev->bd_mutex);
+		bdput(bdev);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(revalidate_disk);
-- 
2.16.4

