Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8957A23E9BC
	for <lists+linux-block@lfdr.de>; Fri,  7 Aug 2020 11:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgHGJGq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 7 Aug 2020 05:06:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9351 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726788AbgHGJGq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Aug 2020 05:06:46 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 619953548C054214279A;
        Fri,  7 Aug 2020 17:06:44 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 7 Aug 2020
 17:06:38 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <lengchao@huawei.com>
Subject: [PATCH v2 3/3] nvme-core: reduce io pause time when fail over
Date:   Fri, 7 Aug 2020 17:06:38 +0800
Message-ID: <20200807090638.29748-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We test nvme over roce fail over with multipath when 1000 namespaces
configured, io pause more than 10 seconds. The reason: nvme_stop_queues
will quiesce all queues for each namespace when io timeout cause path
error. Quiesce queue wait all ongoing dispatches finished through
synchronize_rcu, need more than 10 milliseconds for each wait,
thus io pause more than 10 seconds.

To reduce io pause time, we introduce async mechanism for sync SRCU
and quiesce queue. In nvme_stop_queues, we can first call
blk_mq_quiesce_queue_async, and then blk_mq_quiesce_queue_async_wait,
thus reduce serial quiesce queue wait time. Cancel io will quickly,
multipath will fail over to retry quickly.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2c5bc4fb702..2716ba89bffa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4313,11 +4313,16 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	atomic_t count;
+
+	atomic_set(&count, 0);
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_quiesce_queue(ns->queue);
+		blk_mq_quiesce_queue_async(ns->queue, &count);
 	up_read(&ctrl->namespaces_rwsem);
+
+	blk_mq_quiesce_queue_async_wait(&count);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
-- 
2.16.4

