Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F10C24C97F
	for <lists+linux-block@lfdr.de>; Fri, 21 Aug 2020 03:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHUBVj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Aug 2020 21:21:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10295 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbgHUBVi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 21:21:38 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 84070A2E4909C830C548;
        Fri, 21 Aug 2020 09:21:33 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 21 Aug 2020 09:21:21 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <pbonzini@redhat.com>,
        <stefanha@redhat.com>, <axboe@kernel.dk>,
        <virtualization@lists.linux-foundation.org>,
        <linux-block@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] virtio-blk: Use kobj_to_dev() instead of container_of()
Date:   Fri, 21 Aug 2020 09:19:15 +0800
Message-ID: <1597972755-60633-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use kobj_to_dev() instead of container_of()

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 63b213e0..eb367b5 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -631,7 +631,7 @@ static struct attribute *virtblk_attrs[] = {
 static umode_t virtblk_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct gendisk *disk = dev_to_disk(dev);
 	struct virtio_blk *vblk = disk->private_data;
 	struct virtio_device *vdev = vblk->vdev;
-- 
2.7.4

