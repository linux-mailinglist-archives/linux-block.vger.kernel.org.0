Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327DB400909
	for <lists+linux-block@lfdr.de>; Sat,  4 Sep 2021 03:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350900AbhIDBgn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 3 Sep 2021 21:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350858AbhIDBgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 21:36:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6F2C061796;
        Fri,  3 Sep 2021 18:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zFQJLYbD2Zgj6Ir3zIPXJ5PGzNwoNjONV8OHW6B6xJ8=; b=vIKe4HVbrcGJe+O/Aumba1wMJN
        kBF94W+KOj19IeRhhO/2sdeA1g7aHn3m4C9d15IGuY2OTjQ/jSf4wDeK+tCF3xbboWdiePp0ccoDD
        MVznM5UDVyVSY52xeJJ3Bavq8m1pXLvSwKrWN5ITz0jg4gqI+ve8bqHg1tkEJtyE9JosnYHwyhH7W
        1cPplJfMtWmAIFwbRG+9uMrvGh7GFb8Gl1MzRBhh8CPwycBK0xMiOpVbg91tUCB5H/DHViiwLAhhW
        G+JZlkFnkUpJTWEikIDRz89LJdTd4dvt69AikhLSDKZ5SyBgpUdjpCsc4mkKRfykoKJHG6zJA3TBp
        qdqx66Ug==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMKan-00DLbH-JX; Sat, 04 Sep 2021 01:35:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 08/14] swim: add helper for disk cleanup
Date:   Fri,  3 Sep 2021 18:35:30 -0700
Message-Id: <20210904013536.3181237-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210904013536.3181237-1-mcgrof@kernel.org>
References: <20210904013536.3181237-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Disk cleanup can be shared between exit and bringup. Use a
helper to do the work required. The only functional change at
this point is we're being overly paraoid on exit to check for
a null disk as well now, and this should be safe.

We'll later expand on this, this change just makes subsequent
changes easier to read.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/swim.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index f085ea982bb7..3deb9d9a59c0 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -771,6 +771,17 @@ static const struct blk_mq_ops swim_mq_ops = {
 	.queue_rq = swim_queue_rq,
 };
 
+static void swim_cleanup_floppy_disk(struct floppy_state *fs)
+{
+	struct gendisk *disk = fs->disk;
+
+	if (!disk)
+		return;
+
+	blk_cleanup_disk(disk);
+	blk_mq_free_tag_set(&fs->tag_set);
+}
+
 static int swim_floppy_init(struct swim_priv *swd)
 {
 	int err;
@@ -835,12 +846,7 @@ static int swim_floppy_init(struct swim_priv *swd)
 exit_put_disks:
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
 	do {
-		struct gendisk *disk = swd->unit[drive].disk;
-
-		if (!disk)
-			continue;
-		blk_cleanup_disk(disk);
-		blk_mq_free_tag_set(&swd->unit[drive].tag_set);
+		swim_cleanup_floppy_disk(&swd->unit[drive]);
 	} while (drive--);
 	return err;
 }
@@ -911,8 +917,7 @@ static int swim_remove(struct platform_device *dev)
 
 	for (drive = 0; drive < swd->floppy_count; drive++) {
 		del_gendisk(swd->unit[drive].disk);
-		blk_cleanup_disk(swd->unit[drive].disk);
-		blk_mq_free_tag_set(&swd->unit[drive].tag_set);
+		swim_cleanup_floppy_disk(&swd->unit[drive]);
 	}
 
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
-- 
2.30.2

