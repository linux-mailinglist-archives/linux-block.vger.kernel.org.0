Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4B12B07D9
	for <lists+linux-block@lfdr.de>; Thu, 12 Nov 2020 15:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgKLOyJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Nov 2020 09:54:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7891 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgKLOyJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 09:54:09 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CX4P118Mgz7658;
        Thu, 12 Nov 2020 22:53:57 +0800 (CST)
Received: from localhost (10.174.176.180) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 12 Nov 2020
 22:53:58 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] nbd: Fix passing zero to 'PTR_ERR' warning
Date:   Thu, 12 Nov 2020 22:53:48 +0800
Message-ID: <20201112145348.51284-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.176.180]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix smatch warning:

drivers/block/nbd.c:698 nbd_read_stat() warn: passing zero to 'ERR_PTR'

sock_xmit() never return 0, remove check 0 to fix this warning.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index aaae9220f3a0..1620d1217581 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -691,7 +691,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 	reply.magic = 0;
 	iov_iter_kvec(&to, READ, &iov, 1, sizeof(reply));
 	result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
-	if (result <= 0) {
+	if (result < 0) {
 		if (!nbd_disconnected(config))
 			dev_err(disk_to_dev(nbd->disk),
 				"Receive control failed (result %d)\n", result);
-- 
2.17.1

