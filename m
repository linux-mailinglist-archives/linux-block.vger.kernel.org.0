Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D432E7115
	for <lists+linux-block@lfdr.de>; Tue, 29 Dec 2020 14:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgL2Nve (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 29 Dec 2020 08:51:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9945 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgL2Nvd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 08:51:33 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D4wlm3FrDzhyx0;
        Tue, 29 Dec 2020 21:50:12 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 29 Dec 2020 21:50:41 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <justin@coraid.com>, Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] aoe: Use kzalloc for allocating only one thing
Date:   Tue, 29 Dec 2020 21:51:20 +0800
Message-ID: <20201229135120.23537-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use kzalloc rather than kcalloc(1,...)

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
@@

- kcalloc(1,
+ kzalloc(
          ...)
// </smpl>

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/block/aoe/aoedev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index e2ea2356da06..4d508dddc5ac 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -460,7 +460,7 @@ aoedev_by_aoeaddr(ulong maj, int min, int do_alloc)
 		}
 	if (d || !do_alloc || minor_get(&sysminor, maj, min) < 0)
 		goto out;
-	d = kcalloc(1, sizeof *d, GFP_ATOMIC);
+	d = kzalloc(sizeof *d, GFP_ATOMIC);
 	if (!d)
 		goto out;
 	d->targets = kcalloc(NTARGETS, sizeof(*d->targets), GFP_ATOMIC);
-- 
2.22.0

