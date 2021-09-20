Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6C4114C2
	for <lists+linux-block@lfdr.de>; Mon, 20 Sep 2021 14:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbhITMoq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Sep 2021 08:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238895AbhITMoi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:44:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB476C061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 05:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nE1rzcP+uxAtim1Xl9bMmZThKHSxIApngt/BrvVLTQQ=; b=ZMyDsLD4S9EFlsrpfOLMqxrXpo
        0XhEOb1VZQjwAMyQyjMynmXuQE5ay4ceJMucfPql22O4XcAd3WqwREx4SVQa6E6uzdEtzrS/uJoC3
        pjj9FyH5ZZ/tapYuO9/E+nu2ie5VP8jLXxERV5UTcErAHoa/rNX4/TxCszVjc7M2VDR7loOnmNxHf
        lG+C2wdnDz8aFoPISYTnoeUZ55XDdioeXinS/93+9TfGZuTN0GcA4JOWVynArh1PeENlPF5vJeRy3
        2hEzpXRdPTZwuxyAv0/jD4VzRlCu/v5jqtzJtkcG9hpvM0QvCBFfr3aesAKpmmjwAKo8jUIcgYA5/
        bi83XBEw==;
Received: from [2001:4bb8:184:72db:7ad9:14d9:8599:3025] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSIcR-002fR1-Oj; Mon, 20 Sep 2021 12:42:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 13/17] block: drop unused includes in <linux/blkdev.h>
Date:   Mon, 20 Sep 2021 14:33:24 +0200
Message-Id: <20210920123328.1399408-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920123328.1399408-1-hch@lst.de>
References: <20210920123328.1399408-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drop various include not actually used in blkdev.h itself.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-ps-historical-service-time.c | 1 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c     | 1 +
 include/linux/blkdev.h                     | 7 -------
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm-ps-historical-service-time.c b/drivers/md/dm-ps-historical-service-time.c
index 1856a1b125cc1..875bca30a0dd5 100644
--- a/drivers/md/dm-ps-historical-service-time.c
+++ b/drivers/md/dm-ps-historical-service-time.c
@@ -27,6 +27,7 @@
 #include <linux/blkdev.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/sched/clock.h>
 
 
 #define DM_MSG_PREFIX	"multipath historical-service-time"
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 3ab669dc806f6..27884f3106ab8 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2017 Hisilicon Limited.
  */
 
+#include <linux/sched/clock.h>
 #include "hisi_sas.h"
 #define DRV_NAME "hisi_sas_v3_hw"
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d815238f61ed9..46a703394f7f4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -3,8 +3,6 @@
 #define _LINUX_BLKDEV_H
 
 #include <linux/sched.h>
-#include <linux/sched/clock.h>
-#include <linux/major.h>
 #include <linux/genhd.h>
 #include <linux/list.h>
 #include <linux/llist.h>
@@ -12,17 +10,12 @@
 #include <linux/timer.h>
 #include <linux/workqueue.h>
 #include <linux/wait.h>
-#include <linux/mempool.h>
-#include <linux/pfn.h>
 #include <linux/bio.h>
-#include <linux/stringify.h>
 #include <linux/gfp.h>
-#include <linux/smp.h>
 #include <linux/rcupdate.h>
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
-#include <linux/pm.h>
 #include <linux/sbitmap.h>
 
 struct module;
-- 
2.30.2

