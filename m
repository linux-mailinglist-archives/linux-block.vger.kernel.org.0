Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4553142B38
	for <lists+linux-block@lfdr.de>; Mon, 20 Jan 2020 13:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgATMqt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Jan 2020 07:46:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:53424 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgATMqt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jan 2020 07:46:49 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 25D258781940879D0680;
        Mon, 20 Jan 2020 20:46:47 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 Jan 2020
 20:46:39 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <sunke32@huawei.com>, <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <mchristi@redhat.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>
Subject: [v2] nbd: fix potential NULL pointer fault in nbd_genl_disconnect
Date:   Mon, 20 Jan 2020 20:45:49 +0800
Message-ID: <20200120124549.27648-1-sunke32@huawei.com>
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
v1 -> v2:

add an omitted mutex_unlock.
---
 drivers/block/nbd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b4607dd96185..668bc9cb92ed 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2008,6 +2008,10 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 		       index);
 		return -EINVAL;
 	}
+	if (!nbd->task_recv) {
+		mutex_unlock(&nbd_index_mutex);
+		return -EINVAL;
+	}
 	if (!refcount_inc_not_zero(&nbd->refs)) {
 		mutex_unlock(&nbd_index_mutex);
 		printk(KERN_ERR "nbd: device at index %d is going down\n",
-- 
2.17.2

