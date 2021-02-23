Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC444322BBA
	for <lists+linux-block@lfdr.de>; Tue, 23 Feb 2021 14:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhBWNxA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Feb 2021 08:53:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12641 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhBWNwx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 08:52:53 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DlL691mY9z16BjX;
        Tue, 23 Feb 2021 21:50:25 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Feb 2021 21:51:51 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        "Lauri Kasanen" <cand@gmx.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-block@vger.kernel.org>
Subject: [PATCH -next] n64: fix return value check in n64cart_probe()
Date:   Tue, 23 Feb 2021 14:01:04 +0000
Message-ID: <20210223140104.1743541-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of error, the function devm_platform_ioremap_resource()
returns ERR_PTR() and never returns NULL. The NULL test in the
return value check should be replaced with IS_ERR().

Fixes: d9b2a2bbbb4d ("block: Add n64 cart driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/block/n64cart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
index 47bdf324e962..84a0f8d0be29 100644
--- a/drivers/block/n64cart.c
+++ b/drivers/block/n64cart.c
@@ -129,8 +129,8 @@ static int __init n64cart_probe(struct platform_device *pdev)
 	}
 
 	reg_base = devm_platform_ioremap_resource(pdev, 0);
-	if (!reg_base)
-		return -EINVAL;
+	if (IS_ERR(reg_base))
+		return ERR_PTR(reg_base);
 
 	disk = alloc_disk(0);
 	if (!disk)

