Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431D33526F2
	for <lists+linux-block@lfdr.de>; Fri,  2 Apr 2021 09:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhDBHdU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 2 Apr 2021 03:33:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15529 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhDBHdT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Apr 2021 03:33:19 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FBWtN37pHzNsDn;
        Fri,  2 Apr 2021 15:30:36 +0800 (CST)
Received: from huawei.com (10.67.174.166) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Fri, 2 Apr 2021
 15:33:10 +0800
From:   Zucheng Zheng <zhengzucheng@huawei.com>
To:     <justin@coraid.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hucool.lihua@huawei.com>
Subject: [PATCH -next] driver: aoe: use DEFINE_SPINLOCK() for spinlock
Date:   Fri, 2 Apr 2021 15:33:11 +0800
Message-ID: <20210402073311.74558-1-zhengzucheng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.166]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zucheng Zheng <zhengzucheng@huawei.com>
---
 drivers/block/aoe/aoenet.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 63773a90581d..46cce83c155d 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -47,7 +47,7 @@ static int __init aoe_iflist_setup(char *str)
 __setup("aoe_iflist=", aoe_iflist_setup);
 #endif
 
-static spinlock_t txlock;
+static DEFINE_SPINLOCK(txlock);
 static struct sk_buff_head skbtxq;
 
 /* enters with txlock held */
@@ -201,7 +201,6 @@ aoenet_init(void)
 {
 	skb_queue_head_init(&skbtxq);
 	init_waitqueue_head(&txwq);
-	spin_lock_init(&txlock);
 	kts.lock = &txlock;
 	kts.fn = tx;
 	kts.waitq = &txwq;
-- 
2.17.1

