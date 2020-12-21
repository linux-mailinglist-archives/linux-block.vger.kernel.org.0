Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7222DFC2B
	for <lists+linux-block@lfdr.de>; Mon, 21 Dec 2020 14:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgLUNE4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Dec 2020 08:04:56 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10054 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgLUNEz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Dec 2020 08:04:55 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D005M6JJpzM75P;
        Mon, 21 Dec 2020 21:03:19 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 21 Dec 2020 21:04:07 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] block: brd: Replace simple_strtol by simple_strtoul
Date:   Mon, 21 Dec 2020 21:04:40 +0800
Message-ID: <20201221130440.1920-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The simple_strtol() function is deprecated, use simple_strtoul() instead.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/block/brd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index cc49a921339f..416b2a61fac1 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -357,7 +357,7 @@ MODULE_ALIAS("rd");
 /* Legacy boot options - nonmodular */
 static int __init ramdisk_size(char *str)
 {
-	rd_size = simple_strtol(str, NULL, 0);
+	rd_size = simple_strtoul(str, NULL, 0);
 	return 1;
 }
 __setup("ramdisk_size=", ramdisk_size);
-- 
2.22.0

