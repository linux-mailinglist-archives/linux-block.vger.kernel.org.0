Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A04E1BD67C
	for <lists+linux-block@lfdr.de>; Wed, 29 Apr 2020 09:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgD2Hsv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Apr 2020 03:48:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34900 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgD2Hst (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 03:48:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id f8so554781plt.2;
        Wed, 29 Apr 2020 00:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rl1Ig89V98KSICNcnYOewvbyukPdm2KyX4/deZVKxcQ=;
        b=UIUG+9iM6MRvpx95dEq1MKgAxuZc1cun+iIaZvL0pcyKphuRiJPdiPc3sjwT0jk0Bz
         di8bjmPCwpIuhRmVBpBfirvQI4XFN4w+/UDk48gMo2gBvLllQgac4nY88jzQdVN164Pz
         dSgVwNwwtIPr+qDvwJk6qe+3PP60jw7+V66Hm/bjLCMUnIF4AczXp7IzFFl8jGE0M3Lx
         msLpLHX+OFgz2MkIPpTeQw7R9+Hk8Q824KAl8KOJzPBTHy0SDiuuW2RTUVCgUNogrMcA
         PgVwf50zRVuDgE0lT3dju86drK2kjbbhVoFrLsVcBiER2zbjVFqc2CNw2JncTld4IAQX
         yosA==
X-Gm-Message-State: AGi0PuY1qeThHitXZJumO4anOCDm4I4Ym5nClw8wb3HP9kgIfGbCC8sY
        zwT2WPiIubiWfEqBgZnM0+c=
X-Google-Smtp-Source: APiQypL1J6zcBi/mJqjU7d7yVUKcFBe7Gs0taI1asfjEZrLoqvcz7HWlsohmhAGryuunfmNJze4IrA==
X-Received: by 2002:a17:90a:ad02:: with SMTP id r2mr1641232pjq.63.1588146529022;
        Wed, 29 Apr 2020 00:48:49 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s199sm430915pfs.124.2020.04.29.00.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:48:46 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id AFDD841381; Wed, 29 Apr 2020 07:48:45 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com
Cc:     yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v1 2/6] block: move disk announce work from register_disk() to a helper
Date:   Wed, 29 Apr 2020 07:48:40 +0000
Message-Id: <20200429074844.6241-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200429074844.6241-1-mcgrof@kernel.org>
References: <20200429074844.6241-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This moves quite a bit of code which does one thing into a helper.
We currently do not check for errors but we may decide that might
be desirable later.

This also makes the code easier to read.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 5f7faaf9cc83..091208f5f27b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -701,13 +701,29 @@ static int exact_lock(dev_t devt, void *data)
 	return 0;
 }
 
+static void disk_announce(struct gendisk *disk)
+{
+	struct device *ddev = disk_to_dev(disk);
+	struct disk_part_iter piter;
+	struct hd_struct *part;
+
+	/* announce disk after possible partitions are created */
+	dev_set_uevent_suppress(ddev, 0);
+	kobject_uevent(&ddev->kobj, KOBJ_ADD);
+
+	/* announce possible partitions */
+	disk_part_iter_init(&piter, disk, 0);
+	while ((part = disk_part_iter_next(&piter)))
+		kobject_uevent(&part_to_dev(part)->kobj, KOBJ_ADD);
+	disk_part_iter_exit(&piter);
+}
+
 static void register_disk(struct device *parent, struct gendisk *disk,
 			  const struct attribute_group **groups)
 {
 	struct device *ddev = disk_to_dev(disk);
 	struct block_device *bdev;
-	struct disk_part_iter piter;
-	struct hd_struct *part;
+
 	int err;
 
 	ddev->parent = parent;
@@ -766,15 +782,7 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 	blkdev_put(bdev, FMODE_READ);
 
 exit:
-	/* announce disk after possible partitions are created */
-	dev_set_uevent_suppress(ddev, 0);
-	kobject_uevent(&ddev->kobj, KOBJ_ADD);
-
-	/* announce possible partitions */
-	disk_part_iter_init(&piter, disk, 0);
-	while ((part = disk_part_iter_next(&piter)))
-		kobject_uevent(&part_to_dev(part)->kobj, KOBJ_ADD);
-	disk_part_iter_exit(&piter);
+	disk_announce(disk);
 
 	if (disk->queue->backing_dev_info->dev) {
 		err = sysfs_create_link(&ddev->kobj,
-- 
2.25.1

