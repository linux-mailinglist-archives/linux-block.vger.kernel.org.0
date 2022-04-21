Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85635509AC6
	for <lists+linux-block@lfdr.de>; Thu, 21 Apr 2022 10:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386697AbiDUIhk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Apr 2022 04:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386731AbiDUIhh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 04:37:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2C281EC68
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650530086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xGZv9P4S9fhBdH6JIW7sdFGzYHSOLiHRjd4lI4R/2pw=;
        b=ToPaZI3sipGtYTa0vypwolQvqv8dMsbaIYPuFHRpnXjPXvSSkAEVT8hfWnOWaEijgVa+Gb
        Dm+qCLnnAOIu53I/7CaF4b9kar+fWcfvwXuFQLx7Nu9LqoFwHplnlPiQGkoNmmJWry283e
        /UfQeW/y/PpO0/e6cMqDqovdeOteFgc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-LiNgnq3cNXefG_dh0iyagQ-1; Thu, 21 Apr 2022 04:34:43 -0400
X-MC-Unique: LiNgnq3cNXefG_dh0iyagQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7093C381D8AC;
        Thu, 21 Apr 2022 08:34:42 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B2EC111E3EC;
        Thu, 21 Apr 2022 08:34:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] block: fix "Directory XXXXX with parent 'block' already present!"
Date:   Thu, 21 Apr 2022 16:34:31 +0800
Message-Id: <20220421083431.2917311-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
created when adding disk, and removed when releasing request queue.

There is small window between releasing disk and releasing request
queue, and during the period, one disk with same name may be created
and added, so debugfs_create_dir() may complain with "Directory XXXXX
with parent 'block' already present!"

Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
and the dir name is named with q->id from beginning, and switched to
disk name when adding disk, and finally changed to q->id in disk_release().

Reported-by: Dan Williams <dan.j.williams@intel.com>
Cc: yukuai (C) <yukuai3@huawei.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c  | 4 ++++
 block/blk-sysfs.c | 4 ++--
 block/genhd.c     | 8 ++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f305cb66c72a..245ec664753d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -438,6 +438,7 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 {
 	struct request_queue *q;
 	int ret;
+	char q_name[16];
 
 	q = kmem_cache_alloc_node(blk_get_queue_kmem_cache(alloc_srcu),
 			GFP_KERNEL | __GFP_ZERO, node_id);
@@ -495,6 +496,9 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 	blk_set_default_limits(&q->limits);
 	q->nr_requests = BLKDEV_DEFAULT_RQ;
 
+	sprintf(q_name, "%d", q->id);
+	q->debugfs_dir = debugfs_create_dir(q_name, blk_debugfs_root);
+
 	return q;
 
 fail_stats:
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 88bd41d4cb59..1f986c20a07b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -837,8 +837,8 @@ int blk_register_queue(struct gendisk *disk)
 	}
 
 	mutex_lock(&q->debugfs_mutex);
-	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
-					    blk_debugfs_root);
+	q->debugfs_dir = debugfs_rename(blk_debugfs_root, q->debugfs_dir,
+			blk_debugfs_root, kobject_name(q->kobj.parent));
 	mutex_unlock(&q->debugfs_mutex);
 
 	if (queue_is_mq(q)) {
diff --git a/block/genhd.c b/block/genhd.c
index 36532b931841..08895f9f7087 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -25,6 +25,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/badblocks.h>
 #include <linux/part_stat.h>
+#include <linux/debugfs.h>
 #include "blk-throttle.h"
 
 #include "blk.h"
@@ -1160,6 +1161,7 @@ static void disk_release_mq(struct request_queue *q)
 static void disk_release(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
+	char q_name[16];
 
 	might_sleep();
 	WARN_ON_ONCE(disk_live(disk));
@@ -1173,6 +1175,12 @@ static void disk_release(struct device *dev)
 	kfree(disk->random);
 	xa_destroy(&disk->part_tbl);
 
+	mutex_lock(&disk->queue->debugfs_mutex);
+	sprintf(q_name, "%d", disk->queue->id);
+	disk->queue->debugfs_dir = debugfs_rename(blk_debugfs_root,
+			disk->queue->debugfs_dir, blk_debugfs_root, q_name);
+	mutex_unlock(&disk->queue->debugfs_mutex);
+
 	disk->queue->disk = NULL;
 	blk_put_queue(disk->queue);
 
-- 
2.31.1

