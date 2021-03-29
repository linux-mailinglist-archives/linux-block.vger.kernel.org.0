Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E188C34CCF6
	for <lists+linux-block@lfdr.de>; Mon, 29 Mar 2021 11:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhC2JYU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 29 Mar 2021 05:24:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15089 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhC2JXs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 05:23:48 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F86XP5cJYz19JwG;
        Mon, 29 Mar 2021 17:21:41 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Mar 2021
 17:23:34 +0800
From:   Shixin Liu <liushixin2@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shixin Liu <liushixin2@huawei.com>
Subject: [PATCH -next 2/2] mtip32xx: use LIST_HEAD() for list_head
Date:   Mon, 29 Mar 2021 17:53:49 +0800
Message-ID: <20210329095349.4170870-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329095349.4170870-1-liushixin2@huawei.com>
References: <20210329095349.4170870-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's no need to declare a list and then init it manually,
just use the LIST_HEAD() macro.

Signed-off-by: Shixin Liu <liushixin2@huawei.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 39e3280030d6..07c8b99b88c1 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -95,8 +95,8 @@
 /* Device instance number, incremented each time a device is probed. */
 static int instance;
 
-static struct list_head online_list;
-static struct list_head removing_list;
+static LIST_HEAD(online_list);
+static LIST_HEAD(removing_list);
 static DEFINE_SPINLOCK(dev_lock);
 
 /*
@@ -4363,9 +4363,6 @@ static int __init mtip_init(void)
 
 	pr_info(MTIP_DRV_NAME " Version " MTIP_DRV_VERSION "\n");
 
-	INIT_LIST_HEAD(&online_list);
-	INIT_LIST_HEAD(&removing_list);
-
 	/* Allocate a major block device number to use with this driver. */
 	error = register_blkdev(0, MTIP_DRV_NAME);
 	if (error <= 0) {
-- 
2.25.1

