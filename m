Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD2A1AEE7D
	for <lists+linux-block@lfdr.de>; Sat, 18 Apr 2020 16:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgDROMx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 18 Apr 2020 10:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbgDROJ4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Apr 2020 10:09:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 363EA22272;
        Sat, 18 Apr 2020 14:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587218995;
        bh=Ivk+dFE3vBDfPp2V+SICdUuKd5Bd1SZYW4iiGwIWm9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQ5OmsUMZecVpJUt63m8NlP9IGTmAan4yDz+4LAtGKyDgcfnL0wt+BqVCD8K7BemW
         H4C1aU7lXVoihzNljlvAYu8+vU+f8NisV0EKSfxWuVe3ohiBGVObId7e28iS3nTrHU
         Muikd+YtER91YsD5dpkxzq7Z9wsO9GFVXVdph7ds=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 35/75] loop: Better discard support for block devices
Date:   Sat, 18 Apr 2020 10:08:30 -0400
Message-Id: <20200418140910.8280-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Evan Green <evgreen@chromium.org>

[ Upstream commit c52abf563049e787c1341cdf15c7dbe1bfbc951b ]

If the backing device for a loop device is itself a block device,
then mirror the "write zeroes" capabilities of the underlying
block device into the loop device. Copy this capability into both
max_write_zeroes_sectors and max_discard_sectors of the loop device.

The reason for this is that REQ_OP_DISCARD on a loop device translates
into blkdev_issue_zeroout(), rather than blkdev_issue_discard(). This
presents a consistent interface for loop devices (that discarded data
is zeroed), regardless of the backing device type of the loop device.
There should be no behavior change for loop devices backed by regular
files.

This change fixes blktest block/003, and removes an extraneous
error print in block/013 when testing on a loop device backed
by a block device that does not support discard.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
[used updated version of Evan's comment in loop_config_discard()]
[moved backingq to local scope, removed redundant braces]
Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 739b372a51128..d943e713d5e34 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -427,11 +427,12 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	 * information.
 	 */
 	struct file *file = lo->lo_backing_file;
+	struct request_queue *q = lo->lo_queue;
 	int ret;
 
 	mode |= FALLOC_FL_KEEP_SIZE;
 
-	if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
+	if (!blk_queue_discard(q)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
@@ -865,28 +866,47 @@ static void loop_config_discard(struct loop_device *lo)
 	struct inode *inode = file->f_mapping->host;
 	struct request_queue *q = lo->lo_queue;
 
+	/*
+	 * If the backing device is a block device, mirror its zeroing
+	 * capability. Set the discard sectors to the block device's zeroing
+	 * capabilities because loop discards result in blkdev_issue_zeroout(),
+	 * not blkdev_issue_discard(). This maintains consistent behavior with
+	 * file-backed loop devices: discarded regions read back as zero.
+	 */
+	if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {
+		struct request_queue *backingq;
+
+		backingq = bdev_get_queue(inode->i_bdev);
+		blk_queue_max_discard_sectors(q,
+			backingq->limits.max_write_zeroes_sectors);
+
+		blk_queue_max_write_zeroes_sectors(q,
+			backingq->limits.max_write_zeroes_sectors);
+
 	/*
 	 * We use punch hole to reclaim the free space used by the
 	 * image a.k.a. discard. However we do not support discard if
 	 * encryption is enabled, because it may give an attacker
 	 * useful information.
 	 */
-	if ((!file->f_op->fallocate) ||
-	    lo->lo_encrypt_key_size) {
+	} else if (!file->f_op->fallocate || lo->lo_encrypt_key_size) {
 		q->limits.discard_granularity = 0;
 		q->limits.discard_alignment = 0;
 		blk_queue_max_discard_sectors(q, 0);
 		blk_queue_max_write_zeroes_sectors(q, 0);
-		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
-		return;
-	}
 
-	q->limits.discard_granularity = inode->i_sb->s_blocksize;
-	q->limits.discard_alignment = 0;
+	} else {
+		q->limits.discard_granularity = inode->i_sb->s_blocksize;
+		q->limits.discard_alignment = 0;
 
-	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
-	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
-	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
+		blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
+		blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
+	}
+
+	if (q->limits.max_write_zeroes_sectors)
+		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
 }
 
 static void loop_unprepare_queue(struct loop_device *lo)
-- 
2.20.1

