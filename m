Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B9F402702
	for <lists+linux-block@lfdr.de>; Tue,  7 Sep 2021 12:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245475AbhIGKTa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Sep 2021 06:19:30 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63922 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245525AbhIGKTQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 06:19:16 -0400
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 187AI0QK099781;
        Tue, 7 Sep 2021 19:18:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Tue, 07 Sep 2021 19:18:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 187AI0C0099777
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 7 Sep 2021 19:18:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH v2] brd: reduce the brd_devices_mutex scope
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <65b57a74-34db-d466-df67-c7a7bb529ae3@i-love.sakura.ne.jp>
 <20210907064958.GA29211@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e205f13d-18ff-a49c-0988-7de6ea5ff823@i-love.sakura.ne.jp>
Date:   Tue, 7 Sep 2021 19:18:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907064958.GA29211@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As with commit 8b52d8be86d72308 ("loop: reorder loop_exit"),
unregister_blkdev() needs to be called first in order to avoid calling
brd_alloc() from brd_probe() after brd_del_one() from brd_exit(). Then,
we can avoid holding global mutex during add_disk()/del_gendisk() as with
commit 1c500ad706383f1a ("loop: reduce the loop_ctl_mutex scope").

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
Changes in v2:
  s/brd->brd_number != i/brd->brd_number == i/

 drivers/block/brd.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 58ec167aa018..530b31240203 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -373,10 +373,22 @@ static int brd_alloc(int i)
 	struct gendisk *disk;
 	char buf[DISK_NAME_LEN];
 
+	mutex_lock(&brd_devices_mutex);
+	list_for_each_entry(brd, &brd_devices, brd_list) {
+		if (brd->brd_number == i) {
+			mutex_unlock(&brd_devices_mutex);
+			return -EEXIST;
+		}
+	}
 	brd = kzalloc(sizeof(*brd), GFP_KERNEL);
-	if (!brd)
+	if (!brd) {
+		mutex_unlock(&brd_devices_mutex);
 		return -ENOMEM;
+	}
 	brd->brd_number		= i;
+	list_add_tail(&brd->brd_list, &brd_devices);
+	mutex_unlock(&brd_devices_mutex);
+
 	spin_lock_init(&brd->brd_lock);
 	INIT_RADIX_TREE(&brd->brd_pages, GFP_ATOMIC);
 
@@ -411,37 +423,30 @@ static int brd_alloc(int i)
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
 	add_disk(disk);
-	list_add_tail(&brd->brd_list, &brd_devices);
 
 	return 0;
 
 out_free_dev:
+	mutex_lock(&brd_devices_mutex);
+	list_del(&brd->brd_list);
+	mutex_unlock(&brd_devices_mutex);
 	kfree(brd);
 	return -ENOMEM;
 }
 
 static void brd_probe(dev_t dev)
 {
-	int i = MINOR(dev) / max_part;
-	struct brd_device *brd;
-
-	mutex_lock(&brd_devices_mutex);
-	list_for_each_entry(brd, &brd_devices, brd_list) {
-		if (brd->brd_number == i)
-			goto out_unlock;
-	}
-
-	brd_alloc(i);
-out_unlock:
-	mutex_unlock(&brd_devices_mutex);
+	brd_alloc(MINOR(dev) / max_part);
 }
 
 static void brd_del_one(struct brd_device *brd)
 {
-	list_del(&brd->brd_list);
 	del_gendisk(brd->brd_disk);
 	blk_cleanup_disk(brd->brd_disk);
 	brd_free_pages(brd);
+	mutex_lock(&brd_devices_mutex);
+	list_del(&brd->brd_list);
+	mutex_unlock(&brd_devices_mutex);
 	kfree(brd);
 }
 
@@ -491,25 +496,21 @@ static int __init brd_init(void)
 
 	brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
 
-	mutex_lock(&brd_devices_mutex);
 	for (i = 0; i < rd_nr; i++) {
 		err = brd_alloc(i);
 		if (err)
 			goto out_free;
 	}
 
-	mutex_unlock(&brd_devices_mutex);
-
 	pr_info("brd: module loaded\n");
 	return 0;
 
 out_free:
+	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
 	debugfs_remove_recursive(brd_debugfs_dir);
 
 	list_for_each_entry_safe(brd, next, &brd_devices, brd_list)
 		brd_del_one(brd);
-	mutex_unlock(&brd_devices_mutex);
-	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
 
 	pr_info("brd: module NOT loaded !!!\n");
 	return err;
@@ -519,13 +520,12 @@ static void __exit brd_exit(void)
 {
 	struct brd_device *brd, *next;
 
+	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
 	debugfs_remove_recursive(brd_debugfs_dir);
 
 	list_for_each_entry_safe(brd, next, &brd_devices, brd_list)
 		brd_del_one(brd);
 
-	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
-
 	pr_info("brd: module unloaded\n");
 }
 
-- 
2.30.2


