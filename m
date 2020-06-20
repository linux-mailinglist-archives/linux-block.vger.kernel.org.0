Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32936201FA0
	for <lists+linux-block@lfdr.de>; Sat, 20 Jun 2020 04:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbgFTCCN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 19 Jun 2020 22:02:13 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:64835 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731502AbgFTCCM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 22:02:12 -0400
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jun 2020 22:02:12 EDT
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 1CD944E1155;
        Sat, 20 Jun 2020 09:53:50 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH V2] drivers/block: Use kobj_to_dev() API
Date:   Sat, 20 Jun 2020 09:53:43 +0800
Message-Id: <1592618024-28990-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHUIZGk5MHU0dTkJMVkpOQklNSkNLSEtOSkxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjI6Egw5Qjg5GQIqLRcMIVEr
        NQ5PCTdVSlVKTkJJTUpDS0hLQ0JIVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTVlXWQgBWUFKQ0hPNwY+
X-HM-Tid: 0a72cf6e95479376kuws1cd944e1155
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use kobj_to_dev() API instead of container_of().

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 9d21bf0..c808405
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -630,7 +630,7 @@ static struct attribute *virtblk_attrs[] = {
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

