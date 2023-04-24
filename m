Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC066E071B
	for <lists+linux-block@lfdr.de>; Thu, 13 Apr 2023 08:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDMGlL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 13 Apr 2023 02:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDMGlL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:41:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232307ECF
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mFKtbH0M89Wtn0hvR0brNsM0KwpUQpDtio5jGd5lFzk=; b=ZeQgIbFVwDYjrVLlqUP7tSJfbe
        e8IKUqWiPYJImtFCvCW86FG5weApJHYOq60JtYWvNnFU7sZXXy04w+BEwdVAALLtZXyOBwRH7RE4B
        TvxGciFpdUqe0J6z5aUPOQsJKp64joHRCZvkSQJM4Gu9f5V3WGCu/bBMFduLVNq2pf0IvAPOlUv36
        OzucFI0SdkZqLnve1f6Oo0wJQSeuh+ORJtq55ikB3DwO/BKRGK01Nmc4lI/J82yB69ESDihe7lXnB
        C4a8Gjj8nbkcMopVx/H5O393Q8eTFErpe3sr/towm+WDJNPL6KiRcuRb4PSPWFyUkhPKoXB4QW/Mu
        tePly3aA==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmqdm-005BRa-2a;
        Thu, 13 Apr 2023 06:41:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 03/20] blk-mq: include <linux/blk-mq.h> in block/blk-mq.h
Date:   Thu, 13 Apr 2023 08:40:40 +0200
Message-Id: <20230413064057.707578-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413064057.707578-1-hch@lst.de>
References: <20230413064057.707578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

block/blk-mq.h needs various definitions from <linux/blk-mq.h>,
include it there instead of relying on the source files to include
both.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-flush.c      | 1 -
 block/blk-mq-cpumap.c  | 1 -
 block/blk-mq-debugfs.c | 1 -
 block/blk-mq-pci.c     | 1 -
 block/blk-mq-sched.c   | 1 -
 block/blk-mq-sysfs.c   | 1 -
 block/blk-mq-tag.c     | 1 -
 block/blk-mq-virtio.c  | 1 -
 block/blk-mq.c         | 1 -
 block/blk-mq.h         | 1 +
 block/blk-pm.c         | 1 -
 block/blk-stat.c       | 1 -
 block/blk-sysfs.c      | 1 -
 block/kyber-iosched.c  | 1 -
 block/mq-deadline.c    | 1 -
 15 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index a13a1d6caa0f3e..3c81b0af5b3964 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -68,7 +68,6 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/gfp.h>
-#include <linux/blk-mq.h>
 #include <linux/part_stat.h>
 
 #include "blk.h"
diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 0c612c19feb8b1..9638b25fd52124 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -12,7 +12,6 @@
 #include <linux/cpu.h>
 #include <linux/group_cpus.h>
 
-#include <linux/blk-mq.h>
 #include "blk.h"
 #include "blk-mq.h"
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index ace2bcf1cf9a6f..d23a8554ec4aeb 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -7,7 +7,6 @@
 #include <linux/blkdev.h>
 #include <linux/debugfs.h>
 
-#include <linux/blk-mq.h>
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index a90b88fd1332ce..d47b5c73c9eb71 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -4,7 +4,6 @@
  */
 #include <linux/kobject.h>
 #include <linux/blkdev.h>
-#include <linux/blk-mq.h>
 #include <linux/blk-mq-pci.h>
 #include <linux/pci.h>
 #include <linux/module.h>
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 1029e8eed5eef6..c4b2d44b2d4ebf 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -6,7 +6,6 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/blk-mq.h>
 #include <linux/list_sort.h>
 
 #include <trace/events/block.h>
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index ba84caa868dd54..156e9bb07abf1a 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -10,7 +10,6 @@
 #include <linux/workqueue.h>
 #include <linux/smp.h>
 
-#include <linux/blk-mq.h>
 #include "blk.h"
 #include "blk-mq.h"
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 1f8b065d72c5f2..d6af9d431dc631 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -9,7 +9,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 
-#include <linux/blk-mq.h>
 #include <linux/delay.h>
 #include "blk.h"
 #include "blk-mq.h"
diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
index 6589f076a09635..68d0945c0b08a2 100644
--- a/block/blk-mq-virtio.c
+++ b/block/blk-mq-virtio.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016 Christoph Hellwig.
  */
 #include <linux/device.h>
-#include <linux/blk-mq.h>
 #include <linux/blk-mq-virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/module.h>
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 545600be2063ac..29014a0f9f39b1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -32,7 +32,6 @@
 
 #include <trace/events/block.h>
 
-#include <linux/blk-mq.h>
 #include <linux/t10-pi.h>
 #include "blk.h"
 #include "blk-mq.h"
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 7a041fecea02e4..fa13b694ff27d6 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -2,6 +2,7 @@
 #ifndef INT_BLK_MQ_H
 #define INT_BLK_MQ_H
 
+#include <linux/blk-mq.h>
 #include "blk-stat.h"
 
 struct blk_mq_tag_set;
diff --git a/block/blk-pm.c b/block/blk-pm.c
index 8af5ee54feb406..6b72b2e03fc8a8 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/blk-mq.h>
 #include <linux/blk-pm.h>
 #include <linux/blkdev.h>
 #include <linux/pm_runtime.h>
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 74a1a8c32d86f8..6226405142ff95 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -6,7 +6,6 @@
  */
 #include <linux/kernel.h>
 #include <linux/rculist.h>
-#include <linux/blk-mq.h>
 
 #include "blk-stat.h"
 #include "blk-mq.h"
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1a743b4f29582d..a642085838531f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -9,7 +9,6 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/blktrace_api.h>
-#include <linux/blk-mq.h>
 #include <linux/debugfs.h>
 
 #include "blk.h"
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index d0a4838ce7fc63..3f9fb2090c9158 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -8,7 +8,6 @@
 
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
-#include <linux/blk-mq.h>
 #include <linux/module.h>
 #include <linux/sbitmap.h>
 
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index a18526e11194ca..af9e79050dcc1f 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -8,7 +8,6 @@
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/blkdev.h>
-#include <linux/blk-mq.h>
 #include <linux/bio.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-- 
2.39.2

