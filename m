Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F7F19D958
	for <lists+linux-block@lfdr.de>; Fri,  3 Apr 2020 16:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391061AbgDCOnO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 3 Apr 2020 10:43:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57222 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391053AbgDCOnO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Apr 2020 10:43:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 56D52297518
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     evgreen@chromium.org
Cc:     asavery@chromium.org, axboe@kernel.dk, bvanassche@acm.org,
        darrick.wong@oracle.com, dianders@chromium.org,
        gwendal@chromium.org, hch@infradead.org,
        linux-block@vger.kernel.org, martin.petersen@oracle.com,
        ming.lei@redhat.com, kernel@collabora.com
Subject: [PATCH v9 2/2] loop: Better discard support for block devices
Date:   Fri,  3 Apr 2020 16:43:04 +0200
Message-Id: <20200403144304.11630-3-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200403144304.11630-1-andrzej.p@collabora.com>
References: <20200403144304.11630-1-andrzej.p@collabora.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Evan Green <evgreen@chromium.org>

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
---
 drivers/block/loop.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6969be9a855a..d5dbe5836aa3 100644
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
2.17.1

