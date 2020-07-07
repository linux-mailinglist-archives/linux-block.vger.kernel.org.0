Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD2621688D
	for <lists+linux-block@lfdr.de>; Tue,  7 Jul 2020 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGGIqQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Jul 2020 04:46:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36564 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgGGIqP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Jul 2020 04:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594111573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIUjGZlGq7r4VPMZlY5hjKjO/lR8b42Aa+UVkakrz6k=;
        b=iZ0i6X1zsCws52RBDy34W1DtpylHhCCBEeQJdp3t4NjyVXZtHRyoMqQPyuCdRweaAyvGVy
        xtXfBZnmX+Kt8oOTqUaid/sckqp15V3PybtaqEkNCd2ZCGoYkNrUOJd/NcTnETkn4HQD1H
        zeaqoYVgq2h64+Ng22UYSTfiuR8ropg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-9B1yxLeGOgq4Zt70GPS9kA-1; Tue, 07 Jul 2020 04:46:11 -0400
X-MC-Unique: 9B1yxLeGOgq4Zt70GPS9kA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D89D3107ACF2;
        Tue,  7 Jul 2020 08:46:10 +0000 (UTC)
Received: from localhost (ovpn-12-188.pek2.redhat.com [10.72.12.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C0E35D9F3;
        Tue,  7 Jul 2020 08:46:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] block: loop: share code of reread partitions
Date:   Tue,  7 Jul 2020 16:45:51 +0800
Message-Id: <20200707084552.3294693-2-ming.lei@redhat.com>
In-Reply-To: <20200707084552.3294693-1-ming.lei@redhat.com>
References: <20200707084552.3294693-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

loop_reread_partitions() has been there for rereading partitions, so
replace the open code in __loop_clr_fd() with loop_reread_partitions()
by passing 'locked' parameter.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a943207705dd..0e08468b9ce0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -650,13 +650,17 @@ static inline void loop_update_dio(struct loop_device *lo)
 }
 
 static void loop_reread_partitions(struct loop_device *lo,
-				   struct block_device *bdev)
+				   struct block_device *bdev, bool locked)
 {
 	int rc;
 
-	mutex_lock(&bdev->bd_mutex);
-	rc = bdev_disk_changed(bdev, false);
-	mutex_unlock(&bdev->bd_mutex);
+	if (locked) {
+		rc = bdev_disk_changed(bdev, false);
+	} else {
+		mutex_lock(&bdev->bd_mutex);
+		rc = bdev_disk_changed(bdev, false);
+		mutex_unlock(&bdev->bd_mutex);
+	}
 	if (rc)
 		pr_warn("%s: partition scan of loop%d (%s) failed (rc=%d)\n",
 			__func__, lo->lo_number, lo->lo_file_name, rc);
@@ -754,7 +758,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	 */
 	fput(old_file);
 	if (partscan)
-		loop_reread_partitions(lo, bdev);
+		loop_reread_partitions(lo, bdev, false);
 	return 0;
 
 out_err:
@@ -1179,7 +1183,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	bdgrab(bdev);
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan)
-		loop_reread_partitions(lo, bdev);
+		loop_reread_partitions(lo, bdev, false);
 	if (claimed_bdev)
 		bd_abort_claiming(bdev, claimed_bdev, loop_configure);
 	return 0;
@@ -1270,16 +1274,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 		 * must be at least one and it can only become zero when the
 		 * current holder is released.
 		 */
-		if (!release)
-			mutex_lock(&bdev->bd_mutex);
-		err = bdev_disk_changed(bdev, false);
-		if (!release)
-			mutex_unlock(&bdev->bd_mutex);
-		if (err)
-			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
-				__func__, lo_number, err);
-		/* Device is gone, no point in returning error */
-		err = 0;
+		loop_reread_partitions(lo, bdev, release);
 	}
 
 	/*
@@ -1420,7 +1415,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan)
-		loop_reread_partitions(lo, bdev);
+		loop_reread_partitions(lo, bdev, false);
 
 	return err;
 }
-- 
2.25.2

