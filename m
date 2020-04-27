Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887EC1BA432
	for <lists+linux-block@lfdr.de>; Mon, 27 Apr 2020 15:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgD0NFA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Apr 2020 09:05:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3355 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726539AbgD0NFA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 09:05:00 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 01A9311A128EA96CEFB4;
        Mon, 27 Apr 2020 21:04:57 +0800 (CST)
Received: from huawei.com (10.175.113.49) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Apr 2020
 21:04:49 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        "Chaitanya Kulkarni" <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] blk-mq-debugfs: update blk_queue_flag_name[] accordingly for new flags
Date:   Mon, 27 Apr 2020 21:34:45 +0800
Message-ID: <20200427133445.26215-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.49]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Else there may be magic numbers in /sys/kernel/debug/block/*/state.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 block/blk-mq-debugfs.c | 3 +++
 include/linux/blkdev.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7a79db81a63f..49fdbc8a025f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -125,6 +125,9 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(REGISTERED),
 	QUEUE_FLAG_NAME(SCSI_PASSTHROUGH),
 	QUEUE_FLAG_NAME(QUIESCED),
+	QUEUE_FLAG_NAME(PCI_P2PDMA),
+	QUEUE_FLAG_NAME(ZONE_RESETALL),
+	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32868fbedc9e..d56ef0def78b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -585,6 +585,7 @@ struct request_queue {
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
 
+/* Need to update blk_queue_flag_name[] accordingly */
 #define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
 #define QUEUE_FLAG_DYING	1	/* queue being torn down */
 #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
-- 
2.21.1

