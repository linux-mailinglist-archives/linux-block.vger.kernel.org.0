Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD5E1D9319
	for <lists+linux-block@lfdr.de>; Tue, 19 May 2020 11:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgESJQL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 19 May 2020 05:16:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38830 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728582AbgESJQL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 05:16:11 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D5FA0470EA10BC3C83EE;
        Tue, 19 May 2020 17:16:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 19 May 2020 17:16:01 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-block@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] block/rnbd: server: fix error return code in rnbd_srv_create_dev_sysfs()
Date:   Tue, 19 May 2020 09:19:24 +0000
Message-ID: <20200519091924.134494-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix to return negative error code -ENOMEM from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 8cee532f469b ("block/rnbd: server: sysfs interface functions")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/block/rnbd/rnbd-srv-sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index 106775c074d1..5ba1a31ad626 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -52,8 +52,10 @@ int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
 
 	dev->dev_sessions_kobj = kobject_create_and_add("sessions",
 							&dev->dev_kobj);
-	if (!dev->dev_sessions_kobj)
+	if (!dev->dev_sessions_kobj) {
+		ret = -ENOMEM;
 		goto put_dev_kobj;
+	}
 
 	bdev_kobj = &disk_to_dev(bdev->bd_disk)->kobj;
 	ret = sysfs_create_link(&dev->dev_kobj, bdev_kobj, "block_dev");



