Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C51060CF47
	for <lists+linux-block@lfdr.de>; Tue, 25 Oct 2022 16:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiJYOko (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Oct 2022 10:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiJYOkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 10:40:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E61880522
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PJP4QnM5k+m1zXW1SQKgGJS1dFXcQb6uSyDpAxiYQaI=; b=Na+D+jSEnFmDnHIh/H+kC6qqhV
        S5gJfj0I9eOnzdD1Om7Ak4GgQjjKRdaB/YAx5+qjk29Pl+EemYg+kk2/caxkzkDFxBsLvg6QDkvy4
        NwzQSoFPm6iIq8UacRr9jScnnaX4kXMedz0o3O0hZE5AWzWW6gDDthzqoEeMm2kqVw+CWe8VjPKb1
        4154iXTU0h+rwu+EVqv7JY+MiJ56mBq7ICiJ98kT00JwZ1OjPy6+cZTkAcjqYEu4ukMYdshA3MKX8
        47zLma1x12WvmXqMQoejcJ8a0RSddkSW/FRgrcKPrza/i6WRvGlB3Kj5tqwwhNQFXehqL03Hil+pW
        uSi1bu6A==;
Received: from [12.47.128.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onL6L-005pmE-Rh; Tue, 25 Oct 2022 14:40:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 04/17] nvme: don't call nvme_kill_queues from nvme_remove_namespaces
Date:   Tue, 25 Oct 2022 07:40:07 -0700
Message-Id: <20221025144020.260458-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only the PCIe driver can mark a controller dead, and it does so in
exactly one spot just before calling nvme_remove_namespaces.  Move the
state dependent callto nvme_kill_queues out of nvme_remove_namespaces
and into the one caller where this case can happen.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c |  9 ---------
 drivers/nvme/host/pci.c  | 10 ++++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a92d07137cbd8..8eb46ca9f6acf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4560,15 +4560,6 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	/* prevent racing with ns scanning */
 	flush_work(&ctrl->scan_work);
 
-	/*
-	 * The dead states indicates the controller was not gracefully
-	 * disconnected. In that case, we won't be able to flush any data while
-	 * removing the namespaces' disks; fail all the queues now to avoid
-	 * potentially having to clean up the failed sync later.
-	 */
-	if (ctrl->state == NVME_CTRL_DEAD)
-		nvme_kill_queues(ctrl);
-
 	/* this is a no-op when called from the controller reset handler */
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ec034d4dd9eff..f971e96ffd3f6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3249,6 +3249,16 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	flush_work(&dev->ctrl.reset_work);
 	nvme_stop_ctrl(&dev->ctrl);
+
+	/*
+	 * The dead states indicates the controller was not gracefully
+	 * disconnected. In that case, we won't be able to flush any data while
+	 * removing the namespaces' disks; fail all the queues now to avoid
+	 * potentially having to clean up the failed sync later.
+	 */
+	if (dev->ctrl.state == NVME_CTRL_DEAD)
+		nvme_kill_queues(&dev->ctrl);
+
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
 	nvme_remove_attrs(dev);
-- 
2.30.2

