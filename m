Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C404140476F
	for <lists+linux-block@lfdr.de>; Thu,  9 Sep 2021 11:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhIIJB7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 9 Sep 2021 05:01:59 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19019 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhIIJB6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 05:01:58 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H4tCy73dqzbmFN;
        Thu,  9 Sep 2021 16:56:46 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 17:00:48 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 17:00:48 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>
Subject: [PATCH] n64cart: fix return value check in n64cart_probe()
Date:   Thu, 9 Sep 2021 17:06:08 +0800
Message-ID: <20210909090608.2989716-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of error, the function devm_platform_ioremap_resource()
returns ERR_PTR() and never returns NULL. The NULL test in the
return value check should be replaced with IS_ERR().

Fixes: d9b2a2bbbb4d ("block: Add n64 cart driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/block/n64cart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
index c84be0028f63..26798da661bd 100644
--- a/drivers/block/n64cart.c
+++ b/drivers/block/n64cart.c
@@ -129,8 +129,8 @@ static int __init n64cart_probe(struct platform_device *pdev)
 	}
 
 	reg_base = devm_platform_ioremap_resource(pdev, 0);
-	if (!reg_base)
-		return -EINVAL;
+	if (IS_ERR(reg_base))
+		return PTR_ERR(reg_base);
 
 	disk = blk_alloc_disk(NUMA_NO_NODE);
 	if (!disk)
-- 
2.25.1

