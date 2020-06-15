Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964171F8CDE
	for <lists+linux-block@lfdr.de>; Mon, 15 Jun 2020 06:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgFOEH7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 15 Jun 2020 00:07:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5888 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbgFOEH6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 00:07:58 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C0EECCC1801FA386502A;
        Mon, 15 Jun 2020 12:07:55 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 15 Jun 2020
 12:07:54 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-block@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@canonical.com>
Subject: [PATCH] virtio-blk: free vblk-vqs in error path of virtblk_probe()
Date:   Mon, 15 Jun 2020 12:14:59 +0800
Message-ID: <20200615041459.22477-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.25.0.4.g0ad7144999
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Else there will be memory leak if alloc_disk() fails.

Fixes: 6a27b656fc02 ("block: virtio-blk: support multi virt queues per virtio-blk device")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/block/virtio_blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 9d21bf0f155e..980df853ee49 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -878,6 +878,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	put_disk(vblk->disk);
 out_free_vq:
 	vdev->config->del_vqs(vdev);
+	kfree(vblk->vqs);
 out_free_vblk:
 	kfree(vblk);
 out_free_index:
-- 
2.25.0.4.g0ad7144999

