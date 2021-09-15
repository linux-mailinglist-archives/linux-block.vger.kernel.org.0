Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B405A40BFD7
	for <lists+linux-block@lfdr.de>; Wed, 15 Sep 2021 08:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbhIOGxJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Sep 2021 02:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbhIOGxJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 02:53:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CF2C061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 23:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Sf/dHmZ/1wg0Sn5fGWHaLXpan3fyRcS3+lhKw5tnryo=; b=hxYTQTwv89ISy4AB9v87wEdu2V
        jlOzciJpHGCxrXlaJXOjOSVCQvs69uiETnLqaWVONlHBm0JoLED4pMMU8tCXQGnFEGvuZjfE6ZsdT
        l//4jm4+FZlw0FhJe9L05XmRnT17YDxg1MVpHwM3HoKnGGTcA+uXu0wN48hJTWIotR14v+rg8H9Br
        ao3ffimeJqXwr89t1NQTMzy9T0KVEyvyo0y63jOYngg1hYBq+UAb1zHGIOM1CndFtwIDEFPXamiF+
        YqjCaJRsy7fRe8vlgt5Bc4qnukkSX46CBDZ2LGnXyOmKlrrHRBsukohqsvXvxqwCAUrTPhBUCQMkR
        5Xth2/jg==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOl3-00FR5d-MC; Wed, 15 Sep 2021 06:51:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 12/17] block: move elevator.h to block/
Date:   Wed, 15 Sep 2021 08:40:39 +0200
Message-Id: <20210915064044.950534-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915064044.950534-1-hch@lst.de>
References: <20210915064044.950534-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Except for the features passed to blk_queue_required_elevator_features,
elevator.h is only needed internally to the block layer.  Move the
ELEVATOR_F_* definitions to blkdev.h, and the move elevator.h to
block/, dropping all the spurious includes outside of that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-cgroup.c                  |  2 +-
 block/bfq-iosched.c                 |  2 +-
 block/blk-mq-sched.h                |  1 +
 block/blk-mq-tag.h                  |  2 ++
 block/blk.h                         |  2 ++
 block/elevator.c                    |  2 +-
 {include/linux => block}/elevator.h | 20 +++-----------------
 block/kyber-iosched.c               |  2 +-
 block/mq-deadline.c                 |  2 +-
 drivers/block/amiflop.c             |  1 -
 drivers/scsi/lpfc/lpfc.h            |  1 +
 include/linux/blkdev.h              | 11 +++++++++--
 init/main.c                         |  1 -
 13 files changed, 23 insertions(+), 26 deletions(-)
 rename {include/linux => block}/elevator.h (93%)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index e2f14508f2d6e..8826daedd61c1 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -6,13 +6,13 @@
 #include <linux/slab.h>
 #include <linux/blkdev.h>
 #include <linux/cgroup.h>
-#include <linux/elevator.h>
 #include <linux/ktime.h>
 #include <linux/rbtree.h>
 #include <linux/ioprio.h>
 #include <linux/sbitmap.h>
 #include <linux/delay.h>
 
+#include "elevator.h"
 #include "bfq-iosched.h"
 
 #ifdef CONFIG_BFQ_CGROUP_DEBUG
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index dd13c2bbc29c1..f045ac8f07adf 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -117,7 +117,6 @@
 #include <linux/slab.h>
 #include <linux/blkdev.h>
 #include <linux/cgroup.h>
-#include <linux/elevator.h>
 #include <linux/ktime.h>
 #include <linux/rbtree.h>
 #include <linux/ioprio.h>
@@ -127,6 +126,7 @@
 
 #include <trace/events/block.h>
 
+#include "elevator.h"
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 5246ae0407047..5181487db7923 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -2,6 +2,7 @@
 #ifndef BLK_MQ_SCHED_H
 #define BLK_MQ_SCHED_H
 
+#include "elevator.h"
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 8ed55af084273..f0a0ee758a556 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -2,6 +2,8 @@
 #ifndef INT_BLK_MQ_TAG_H
 #define INT_BLK_MQ_TAG_H
 
+struct blk_mq_alloc_data;
+
 /*
  * Tag address space map.
  */
diff --git a/block/blk.h b/block/blk.h
index 7d2a0ba7ed21d..82ab26add08df 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -12,6 +12,8 @@
 #include "blk-mq.h"
 #include "blk-mq-sched.h"
 
+struct elevator_type;
+
 /* Max future timer expiry for timeouts */
 #define BLK_MAX_TIMEOUT		(5 * HZ)
 
diff --git a/block/elevator.c b/block/elevator.c
index ff45d8388f487..57be09cd7f6dd 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -26,7 +26,6 @@
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/blkdev.h>
-#include <linux/elevator.h>
 #include <linux/bio.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -40,6 +39,7 @@
 
 #include <trace/events/block.h>
 
+#include "elevator.h"
 #include "blk.h"
 #include "blk-mq-sched.h"
 #include "blk-pm.h"
diff --git a/include/linux/elevator.h b/block/elevator.h
similarity index 93%
rename from include/linux/elevator.h
rename to block/elevator.h
index 80633f3b600c2..16cd8bdedb7ea 100644
--- a/include/linux/elevator.h
+++ b/block/elevator.h
@@ -1,17 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_ELEVATOR_H
-#define _LINUX_ELEVATOR_H
+#ifndef _ELEVATOR_H
+#define _ELEVATOR_H
 
 #include <linux/percpu.h>
 #include <linux/hashtable.h>
 
-#ifdef CONFIG_BLOCK
-
 struct io_cq;
 struct elevator_type;
-#ifdef CONFIG_BLK_DEBUG_FS
 struct blk_mq_debugfs_attr;
-#endif
 
 /*
  * Return values from elevator merger
@@ -167,14 +163,4 @@ extern struct request *elv_rb_find(struct rb_root *, sector_t);
 #define rq_entry_fifo(ptr)	list_entry((ptr), struct request, queuelist)
 #define rq_fifo_clear(rq)	list_del_init(&(rq)->queuelist)
 
-/*
- * Elevator features.
- */
-
-/* Supports zoned block devices sequential write constraint */
-#define ELEVATOR_F_ZBD_SEQ_WRITE	(1U << 0)
-/* Supports scheduling on multiple hardware queues */
-#define ELEVATOR_F_MQ_AWARE		(1U << 1)
-
-#endif /* CONFIG_BLOCK */
-#endif
+#endif /* _ELEVATOR_H */
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 15a8be57203d6..5808f0ea0b79f 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -9,12 +9,12 @@
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
-#include <linux/elevator.h>
 #include <linux/module.h>
 #include <linux/sbitmap.h>
 
 #include <trace/events/block.h>
 
+#include "elevator.h"
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 7f3c3932b723e..47f042fa6a688 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -9,7 +9,6 @@
 #include <linux/fs.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
-#include <linux/elevator.h>
 #include <linux/bio.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -20,6 +19,7 @@
 
 #include <trace/events/block.h>
 
+#include "elevator.h"
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 8b1714021498c..b892e5185d6fa 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -64,7 +64,6 @@
 #include <linux/mutex.h>
 #include <linux/fs.h>
 #include <linux/blk-mq.h>
-#include <linux/elevator.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index befeb7c342903..337e6ed248218 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -22,6 +22,7 @@
  *******************************************************************/
 
 #include <scsi/scsi_host.h>
+#include <linux/hashtable.h>
 #include <linux/ktime.h>
 #include <linux/workqueue.h>
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4bcbb1ae2d66a..d815238f61ed9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -251,8 +251,6 @@ static inline unsigned short req_get_ioprio(struct request *req)
 	return req->ioprio;
 }
 
-#include <linux/elevator.h>
-
 struct bio_vec;
 
 enum blk_eh_timer_return {
@@ -1124,6 +1122,15 @@ extern void blk_queue_dma_alignment(struct request_queue *, int);
 extern void blk_queue_update_dma_alignment(struct request_queue *, int);
 extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
 extern void blk_queue_write_cache(struct request_queue *q, bool enabled, bool fua);
+
+/*
+ * Elevator features for blk_queue_required_elevator_features:
+ */
+/* Supports zoned block devices sequential write constraint */
+#define ELEVATOR_F_ZBD_SEQ_WRITE	(1U << 0)
+/* Supports scheduling on multiple hardware queues */
+#define ELEVATOR_F_MQ_AWARE		(1U << 1)
+
 extern void blk_queue_required_elevator_features(struct request_queue *q,
 						 unsigned int features);
 extern bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
diff --git a/init/main.c b/init/main.c
index 3f72169344412..330aae01e728c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -83,7 +83,6 @@
 #include <linux/ptrace.h>
 #include <linux/pti.h>
 #include <linux/blkdev.h>
-#include <linux/elevator.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
-- 
2.30.2

