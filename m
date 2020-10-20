Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25962880B1
	for <lists+linux-block@lfdr.de>; Fri,  9 Oct 2020 05:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgJIDXb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 8 Oct 2020 23:23:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731496AbgJIDXa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 23:23:30 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3775669E723C11863117;
        Fri,  9 Oct 2020 11:23:29 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 11:23:25 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>
Subject: [RESEND PATCH v2 6/7] block: get rid of unnecessary local variable
Date:   Thu, 8 Oct 2020 23:26:32 -0400
Message-ID: <20201009032633.83645-7-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201009032633.83645-1-yuyufen@huawei.com>
References: <20201009032633.83645-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since whole elevator register is protectd by sysfs_lock, we
don't need extras 'has_elevator'. Just use q->elevator directly.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-sysfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index ee2cd4d1054c..d13a70ed39bf 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -976,7 +976,6 @@ int blk_register_queue(struct gendisk *disk)
 	int ret;
 	struct device *dev = disk_to_dev(disk);
 	struct request_queue *q = disk->queue;
-	bool has_elevator = false;
 
 	if (WARN_ON(!q))
 		return -ENXIO;
@@ -1040,7 +1039,6 @@ int blk_register_queue(struct gendisk *disk)
 			kobject_put(&dev->kobj);
 			return ret;
 		}
-		has_elevator = true;
 	}
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
@@ -1049,7 +1047,7 @@ int blk_register_queue(struct gendisk *disk)
 
 	/* Now everything is ready and send out KOBJ_ADD uevent */
 	kobject_uevent(&q->kobj, KOBJ_ADD);
-	if (has_elevator)
+	if (q->elevator)
 		kobject_uevent(&q->elevator->kobj, KOBJ_ADD);
 	mutex_unlock(&q->sysfs_lock);
 
-- 
2.25.4

