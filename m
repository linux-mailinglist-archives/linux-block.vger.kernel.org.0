Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87B034CCF4
	for <lists+linux-block@lfdr.de>; Mon, 29 Mar 2021 11:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhC2JXs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 29 Mar 2021 05:23:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15088 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhC2JXm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 05:23:42 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F86XJ58KXz19JwG;
        Mon, 29 Mar 2021 17:21:36 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Mar 2021
 17:23:33 +0800
From:   Shixin Liu <liushixin2@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shixin Liu <liushixin2@huawei.com>
Subject: [PATCH -next 1/2] mtip32xx: use DEFINE_SPINLOCK() for spinlock
Date:   Mon, 29 Mar 2021 17:53:48 +0800
Message-ID: <20210329095349.4170870-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Signed-off-by: Shixin Liu <liushixin2@huawei.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 3be0dbc674bd..39e3280030d6 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -97,7 +97,7 @@ static int instance;
 
 static struct list_head online_list;
 static struct list_head removing_list;
-static spinlock_t dev_lock;
+static DEFINE_SPINLOCK(dev_lock);
 
 /*
  * Global variable used to hold the major block device number
@@ -4363,8 +4363,6 @@ static int __init mtip_init(void)
 
 	pr_info(MTIP_DRV_NAME " Version " MTIP_DRV_VERSION "\n");
 
-	spin_lock_init(&dev_lock);
-
 	INIT_LIST_HEAD(&online_list);
 	INIT_LIST_HEAD(&removing_list);
 
-- 
2.25.1

