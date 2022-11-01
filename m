Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00213614DE3
	for <lists+linux-block@lfdr.de>; Tue,  1 Nov 2022 16:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiKAPIx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Nov 2022 11:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiKAPIf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 11:08:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2DC1C905
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 08:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lGwLgdy//29RWSKEL4CO4hAmaZjxKGL0EJmVog3/l4I=; b=mNPdlA9S28uo0AvK3dq4YoTaJo
        erblOFZlqvwlcWksjJ6oZBEW88fuvkEH1elu4l2510a6BamRsMmbTLqnqTzOe2NpLuv3ycJwmOfLz
        H2vbWwQmBbbnBUMbw1xlrJfsvxXJGVpJTkgjNIiBdHwdzx/3B6IVfWIuLKrwUGbLRGLRoUnS1Hjjm
        pJ/BAKKL5H6ywHIx7KjgUA4bfwuXw/nirj+nchwwxHccxUvWJfxSelY90OM2DbFkxpjVOHWDs4u3A
        4bO2CnxIiwYTVlPu69AplCwNAbVcA7ia29Y4krh/W0gFrQSIIEc40dPbch+o8IRGJtf/7fHgxJWFT
        f6SFabHw==;
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opsll-005h10-RS; Tue, 01 Nov 2022 15:01:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 14/14] nvme: use blk_mq_[un]quiesce_tagset
Date:   Tue,  1 Nov 2022 16:00:50 +0100
Message-Id: <20221101150050.3510-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chao Leng <lengchao@huawei.com>

All controller namespaces share the same tagset, so we can use this
interface which does the optimal operation for parallel quiesce based on
the tagset type(e.g. blocking tagsets and non-blocking tagsets).

nvme connect_q should not be quiesced when quiesce tagset, so set the
QUEUE_FLAG_SKIP_TAGSET_QUIESCE to skip it when init connect_q.

Currently we use NVME_NS_STOPPED to ensure pairing quiescing and
unquiescing. If use blk_mq_[un]quiesce_tagset, NVME_NS_STOPPED will be
invalided, so introduce NVME_CTRL_STOPPED to replace NVME_NS_STOPPED.
In addition, we never really quiesce a single namespace. It is a better
choice to move the flag from ns to ctrl.

Signed-off-by: Chao Leng <lengchao@huawei.com>
[hch: rebased on top of prep patches]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chao Leng <lengchao@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 34 ++++++++--------------------------
 drivers/nvme/host/nvme.h |  2 +-
 2 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 66b0b6e110024..f94b05c585cbc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4895,6 +4895,8 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 			ret = PTR_ERR(ctrl->connect_q);
 			goto out_free_tag_set;
 		}
+		blk_queue_flag_set(QUEUE_FLAG_SKIP_TAGSET_QUIESCE,
+				   ctrl->connect_q);
 	}
 
 	ctrl->tagset = set;
@@ -5096,20 +5098,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 
-static void nvme_start_ns_queue(struct nvme_ns *ns)
-{
-	if (test_and_clear_bit(NVME_NS_STOPPED, &ns->flags))
-		blk_mq_unquiesce_queue(ns->queue);
-}
-
-static void nvme_stop_ns_queue(struct nvme_ns *ns)
-{
-	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
-		blk_mq_quiesce_queue(ns->queue);
-	else
-		blk_mq_wait_quiesce_done(ns->queue->tag_set);
-}
-
 /* let I/O to all namespaces fail in preparation for surprise removal */
 void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl)
 {
@@ -5172,23 +5160,17 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
-
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		nvme_stop_ns_queue(ns);
-	up_read(&ctrl->namespaces_rwsem);
+	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
+		blk_mq_quiesce_tagset(ctrl->tagset);
+	else
+		blk_mq_wait_quiesce_done(ctrl->tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
 void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
-
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		nvme_start_ns_queue(ns);
-	up_read(&ctrl->namespaces_rwsem);
+	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
+		blk_mq_unquiesce_tagset(ctrl->tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1cd7168002438..f9df10653f3c5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -237,6 +237,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_FAILFAST_EXPIRED	= 0,
 	NVME_CTRL_ADMIN_Q_STOPPED	= 1,
 	NVME_CTRL_STARTED_ONCE		= 2,
+	NVME_CTRL_STOPPED		= 3,
 };
 
 struct nvme_ctrl {
@@ -486,7 +487,6 @@ struct nvme_ns {
 #define NVME_NS_ANA_PENDING	2
 #define NVME_NS_FORCE_RO	3
 #define NVME_NS_READY		4
-#define NVME_NS_STOPPED		5
 
 	struct cdev		cdev;
 	struct device		cdev_device;
-- 
2.30.2

