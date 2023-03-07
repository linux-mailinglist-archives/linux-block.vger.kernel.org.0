Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F77E6AE251
	for <lists+linux-block@lfdr.de>; Tue,  7 Mar 2023 15:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCGO1k (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Mar 2023 09:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCGO10 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 09:27:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74CE8C81F
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 06:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678198930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gv5iBghgfjGMwQIblGY0Ee8w9OWfXa/KQ07CaskV0k=;
        b=MMj5ZHySy20+77cXPXudrwbWYymzktDp3OfMziT3jGvu0rrh6RPgGYH+p0X59ePhxlbRRd
        uey3FMunK4jiOPILYTSOix+oO8gMjCliOdgWkjY8FE0Tr5s4fpKkJbAn0olp24phbgqTVg
        8ABV30uKtq3g9vpQrOfEDu2ip51Px0o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-XSC25OLtMEO-Q8lwj0T0xw-1; Tue, 07 Mar 2023 09:15:35 -0500
X-MC-Unique: XSC25OLtMEO-Q8lwj0T0xw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF38D38173C9;
        Tue,  7 Mar 2023 14:15:34 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 275AB400DFA1;
        Tue,  7 Mar 2023 14:15:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 01/17] io_uring: add IO_URING_F_FUSED and prepare for supporting OP_FUSED_CMD
Date:   Tue,  7 Mar 2023 22:15:04 +0800
Message-Id: <20230307141520.793891-2-ming.lei@redhat.com>
In-Reply-To: <20230307141520.793891-1-ming.lei@redhat.com>
References: <20230307141520.793891-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add flag IO_URING_F_FUSED and prepare for supporting IO_URING_OP_FUSED_CMD,
which is still one type of IO_URING_OP_URING_CMD, so it is reasonable
to reuse ->uring_cmd() for handling IO_URING_F_FUSED_CMD.

Just IO_URING_F_FUSED_CMD will carry one 64byte SQE as payload which
is handled by one slave request. The master uring command will
provide kernel buffer to the slave request.

Mark all existed drivers to not support IO_URING_F_FUSED_CMD, given it
depends if driver is capable of handling the slave request.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c  | 6 ++++++
 drivers/char/mem.c        | 4 ++++
 drivers/nvme/host/ioctl.c | 9 +++++++++
 include/linux/io_uring.h  | 7 +++++++
 4 files changed, 26 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d1d1c8d606c8..088d9efffe6b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1271,6 +1271,9 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
 			ub_cmd->result);
 
+	if (issue_flags & IO_URING_F_FUSED)
+		return -EOPNOTSUPP;
+
 	if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
 		goto out;
 
@@ -2169,6 +2172,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	struct ublk_device *ub = NULL;
 	int ret = -EINVAL;
 
+	if (issue_flags & IO_URING_F_FUSED)
+		return -EOPNOTSUPP;
+
 	if (issue_flags & IO_URING_F_NONBLOCK)
 		return -EAGAIN;
 
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index ffb101d349f0..134ba6665194 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -30,6 +30,7 @@
 #include <linux/uio.h>
 #include <linux/uaccess.h>
 #include <linux/security.h>
+#include <linux/io_uring.h>
 
 #ifdef CONFIG_IA64
 # include <linux/efi.h>
@@ -482,6 +483,9 @@ static ssize_t splice_write_null(struct pipe_inode_info *pipe, struct file *out,
 
 static int uring_cmd_null(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 {
+	if (issue_flags & IO_URING_F_FUSED)
+		return -EOPNOTSUPP;
+
 	return 0;
 }
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 723e7d5b778f..44a171bcaa90 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -773,6 +773,9 @@ int nvme_ns_chr_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 	struct nvme_ns *ns = container_of(file_inode(ioucmd->file)->i_cdev,
 			struct nvme_ns, cdev);
 
+	if (issue_flags & IO_URING_F_FUSED)
+		return -EOPNOTSUPP;
+
 	return nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
 }
 
@@ -878,6 +881,9 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 	struct nvme_ns *ns = nvme_find_path(head);
 	int ret = -EINVAL;
 
+	if (issue_flags & IO_URING_F_FUSED)
+		return -EOPNOTSUPP;
+
 	if (ns)
 		ret = nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
 	srcu_read_unlock(&head->srcu, srcu_idx);
@@ -915,6 +921,9 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 	struct nvme_ctrl *ctrl = ioucmd->file->private_data;
 	int ret;
 
+	if (issue_flags & IO_URING_F_FUSED)
+		return -EOPNOTSUPP;
+
 	/* IOPOLL not supported yet */
 	if (issue_flags & IO_URING_F_IOPOLL)
 		return -EOPNOTSUPP;
diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 934e5dd4ccc0..0676c5b4b5fe 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -20,6 +20,13 @@ enum io_uring_cmd_flags {
 	IO_URING_F_SQE128		= (1 << 8),
 	IO_URING_F_CQE32		= (1 << 9),
 	IO_URING_F_IOPOLL		= (1 << 10),
+
+	/* for FUSED_CMD only */
+	IO_URING_F_FUSED_WRITE		= (1 << 11), /* slave writes to buffer */
+	IO_URING_F_FUSED_READ		= (1 << 12), /* slave reads from buffer */
+	/* driver incapable of FUSED_CMD should fail cmd when seeing F_FUSED */
+	IO_URING_F_FUSED		= IO_URING_F_FUSED_WRITE |
+		IO_URING_F_FUSED_READ,
 };
 
 struct io_uring_cmd {
-- 
2.39.2

