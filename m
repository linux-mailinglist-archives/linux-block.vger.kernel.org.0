Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B281DE6B6
	for <lists+linux-block@lfdr.de>; Mon, 21 Oct 2019 10:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfJUIiK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Oct 2019 04:38:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:44642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbfJUIiK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 04:38:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2149B19E;
        Mon, 21 Oct 2019 08:38:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 637A81E484D; Mon, 21 Oct 2019 10:38:08 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] bdev: Factor out bdev revalidation into a common helper
Date:   Mon, 21 Oct 2019 10:37:59 +0200
Message-Id: <20191021083808.19335-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191021083132.5351-1-jack@suse.cz>
References: <20191021083132.5351-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Factor out code handling revalidation of bdev on disk change into a
common helper.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9c073dbdc1b0..88c6d35ec71d 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1512,6 +1512,14 @@ EXPORT_SYMBOL(bd_set_size);
 
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
+static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
+{
+	if (invalidate)
+		invalidate_partitions(bdev->bd_disk, bdev);
+	else
+		rescan_partitions(bdev->bd_disk, bdev);
+}
+
 /*
  * bd_mutex locking:
  *
@@ -1594,12 +1602,9 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 			 * The latter is necessary to prevent ghost
 			 * partitions on a removed medium.
 			 */
-			if (bdev->bd_invalidated) {
-				if (!ret)
-					rescan_partitions(disk, bdev);
-				else if (ret == -ENOMEDIUM)
-					invalidate_partitions(disk, bdev);
-			}
+			if (bdev->bd_invalidated &&
+			    (!ret || ret == -ENOMEDIUM))
+				bdev_disk_changed(bdev, ret == -ENOMEDIUM);
 
 			if (ret)
 				goto out_clear;
@@ -1632,12 +1637,9 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 			if (bdev->bd_disk->fops->open)
 				ret = bdev->bd_disk->fops->open(bdev, mode);
 			/* the same as first opener case, read comment there */
-			if (bdev->bd_invalidated) {
-				if (!ret)
-					rescan_partitions(bdev->bd_disk, bdev);
-				else if (ret == -ENOMEDIUM)
-					invalidate_partitions(bdev->bd_disk, bdev);
-			}
+			if (bdev->bd_invalidated &&
+			    (!ret || ret == -ENOMEDIUM))
+				bdev_disk_changed(bdev, ret == -ENOMEDIUM);
 			if (ret)
 				goto out_unlock_bdev;
 		}
-- 
2.16.4

