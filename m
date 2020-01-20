Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E218142928
	for <lists+linux-block@lfdr.de>; Mon, 20 Jan 2020 12:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgATLYX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Jan 2020 06:24:23 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60554 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbgATLYX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jan 2020 06:24:23 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D72B8D65E07C0BA4D496;
        Mon, 20 Jan 2020 19:24:20 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 Jan 2020
 19:24:12 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <sunke32@huawei.com>, <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <mchristi@redhat.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] nbd: fix potential NULL pointer fault in nbd_genl_disconnect
Date:   Mon, 20 Jan 2020 19:23:20 +0800
Message-ID: <20200120112320.7375-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Open /dev/nbdX first, the config_refs will be 1 and
the pointers in nbd_device are still null. Disconnect
/dev/nbdX, then reference a null recv_workq. The
protection by config_refs in nbd_genl_disconnect is useless.

To fix it, just add a check for a non null task_recv in
nbd_genl_disconnect.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 drivers/block/nbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b4607dd96185..5e1530bcb81a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2008,6 +2008,8 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 		       index);
 		return -EINVAL;
 	}
+	if (!nbd->task_recv)
+		return -EINVAL;
 	if (!refcount_inc_not_zero(&nbd->refs)) {
 		mutex_unlock(&nbd_index_mutex);
 		printk(KERN_ERR "nbd: device at index %d is going down\n",
-- 
2.17.2

