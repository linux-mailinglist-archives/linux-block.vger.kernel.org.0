Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393DA3A13DD
	for <lists+linux-block@lfdr.de>; Wed,  9 Jun 2021 14:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbhFIMNh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Jun 2021 08:13:37 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3924 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239736AbhFIMNb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 08:13:31 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0Qqc75lwz6wjl;
        Wed,  9 Jun 2021 20:08:28 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 20:11:31 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 20:11:30 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] aoe: remove unnecessary oom message
Date:   Wed, 9 Jun 2021 20:11:25 +0800
Message-ID: <20210609121125.13883-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 drivers/block/aoe/aoechr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
index ab41be625a53..8eea2529da20 100644
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -140,10 +140,8 @@ bail:		spin_unlock_irqrestore(&emsgs_lock, flags);
 	}
 
 	mp = kmemdup(msg, n, GFP_ATOMIC);
-	if (mp == NULL) {
-		printk(KERN_ERR "aoe: allocation failure, len=%ld\n", n);
+	if (!mp)
 		goto bail;
-	}
 
 	em->msg = mp;
 	em->flags |= EMFL_VALID;
-- 
2.25.1


