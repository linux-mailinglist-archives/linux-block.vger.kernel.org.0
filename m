Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AE63D4C36
	for <lists+linux-block@lfdr.de>; Sun, 25 Jul 2021 07:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhGYFRd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 25 Jul 2021 01:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGYFRc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Jul 2021 01:17:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9383DC061757
        for <linux-block@vger.kernel.org>; Sat, 24 Jul 2021 22:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KmPrq3TQD2AmLlZFKAQVrnHptYU7+R/m6jCQncAlyy4=; b=JcpezeT3mutyTPnsogdyoZRSLl
        I/+aCZf0u6ITN/wNYsKLbiNPGNv+LafIHENkJ21X7FJQwm9QHtdtsEMXqGjQckHKDIhuezUHsMWHr
        Om5nNlxF4OJsS5crjWVb/AlT8zc5mh9Ar1xPC6MHmICxi6mhbA3J6927d0sDnc7skye8ZiwF4mCqx
        ttwEwMohNZw6I+YKnyD6Kh4jCN4sGWFHoEHAVvxaAhaDtnwrZIB8vE6Z+FAmZvmtzD2wjZaI6V/6U
        oEJjkB2D35SC7mlYpoFKGIsp8h7H46U4Dj3K5CO2ou3lO5NHodAw3qF7kgPOeE/m4nxC/z6hcNvlY
        tvqQb6Yg==;
Received: from [2001:4bb8:184:87c5:a8b3:bdfd:fc9b:6250] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7X8g-00CppZ-0w; Sun, 25 Jul 2021 05:57:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 7/8] dm: delay registering the gendisk
Date:   Sun, 25 Jul 2021 07:54:57 +0200
Message-Id: <20210725055458.29008-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210725055458.29008-1-hch@lst.de>
References: <20210725055458.29008-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

device mapper is currently the only outlier that tries to call
register_disk after add_disk, leading to fairly inconsistent state
of these block layer data structures.  Instead change device-mapper
to just register the gendisk later now that the holder mechanism
can cope with that.

Note that this introduces a user visible change: the dm kobject is
now only visible after the initial table has been loaded.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-rq.c |  1 -
 drivers/md/dm.c    | 23 +++++++++++------------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 0dbd48cbdff9..5b95eea517d1 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -559,7 +559,6 @@ int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
 	err = blk_mq_init_allocated_queue(md->tag_set, md->queue);
 	if (err)
 		goto out_tag_set;
-	elevator_init_mq(md->queue);
 	return 0;
 
 out_tag_set:
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index f003bd5b93ce..7981b7287628 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1693,7 +1693,10 @@ static void cleanup_mapped_device(struct mapped_device *md)
 		spin_lock(&_minor_lock);
 		md->disk->private_data = NULL;
 		spin_unlock(&_minor_lock);
-		del_gendisk(md->disk);
+		if (dm_get_md_type(md) != DM_TYPE_NONE) {
+			dm_sysfs_exit(md);
+			del_gendisk(md->disk);
+		}
 		dm_queue_destroy_keyslot_manager(md->queue);
 		blk_cleanup_disk(md->disk);
 	}
@@ -1788,7 +1791,6 @@ static struct mapped_device *alloc_dev(int minor)
 			goto bad;
 	}
 
-	add_disk_no_queue_reg(md->disk);
 	format_dev_t(md->name, MKDEV(_major, minor));
 
 	md->wq = alloc_workqueue("kdmflush", WQ_MEM_RECLAIM, 0);
@@ -1989,19 +1991,12 @@ static struct dm_table *__unbind(struct mapped_device *md)
  */
 int dm_create(int minor, struct mapped_device **result)
 {
-	int r;
 	struct mapped_device *md;
 
 	md = alloc_dev(minor);
 	if (!md)
 		return -ENXIO;
 
-	r = dm_sysfs_init(md);
-	if (r) {
-		free_dev(md);
-		return r;
-	}
-
 	*result = md;
 	return 0;
 }
@@ -2081,10 +2076,15 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 	r = dm_table_set_restrictions(t, md->queue, &limits);
 	if (r)
 		return r;
-	md->type = type;
 
-	blk_register_queue(md->disk);
+	add_disk(md->disk);
 
+	r = dm_sysfs_init(md);
+	if (r) {
+		del_gendisk(md->disk);
+		return r;
+	}
+	md->type = type;
 	return 0;
 }
 
@@ -2190,7 +2190,6 @@ static void __dm_destroy(struct mapped_device *md, bool wait)
 		DMWARN("%s: Forcibly removing mapped_device still in use! (%d users)",
 		       dm_device_name(md), atomic_read(&md->holders));
 
-	dm_sysfs_exit(md);
 	dm_table_destroy(__unbind(md));
 	free_dev(md);
 }
-- 
2.30.2

