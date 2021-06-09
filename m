Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDC53A1447
	for <lists+linux-block@lfdr.de>; Wed,  9 Jun 2021 14:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFIM06 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Jun 2021 08:26:58 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5355 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhFIM04 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 08:26:56 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G0R683Mzmz6tmD;
        Wed,  9 Jun 2021 20:21:04 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 20:24:56 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 20:24:55 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] sx8: remove unnecessary oom message
Date:   Wed, 9 Jun 2021 20:24:50 +0800
Message-ID: <20210609122450.14098-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/block/sx8.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 2cdf2771f8e8..71dcfde042ab 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1429,8 +1429,6 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	host = kzalloc(sizeof(*host), GFP_KERNEL);
 	if (!host) {
-		printk(KERN_ERR DRV_NAME "(%s): memory alloc failure\n",
-		       pci_name(pdev));
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
-- 
2.25.1


