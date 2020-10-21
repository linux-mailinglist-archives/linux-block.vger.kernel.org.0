Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40ACF294630
	for <lists+linux-block@lfdr.de>; Wed, 21 Oct 2020 03:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439844AbgJUBQG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Oct 2020 21:16:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439843AbgJUBQG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 21:16:06 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 717E8F0672CB70BCB207;
        Wed, 21 Oct 2020 09:16:04 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Wed, 21 Oct 2020 09:16:03 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <Damien.LeMoal@wdc.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] skd: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Wed, 21 Oct 2020 09:16:46 +0800
Message-ID: <1603243006-9189-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The code has been in a irq-disabled context since it is hard IRQ. There
is no necessity to do it again.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/block/skd_main.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index ae6454c..e80b670 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2368,40 +2368,37 @@ static int skd_unquiesce_dev(struct skd_device *skdev)
 static irqreturn_t skd_reserved_isr(int irq, void *skd_host_data)
 {
 	struct skd_device *skdev = skd_host_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&skdev->lock, flags);
+	spin_lock(&skdev->lock);
 	dev_dbg(&skdev->pdev->dev, "MSIX = 0x%x\n",
 		SKD_READL(skdev, FIT_INT_STATUS_HOST));
 	dev_err(&skdev->pdev->dev, "MSIX reserved irq %d = 0x%x\n", irq,
 		SKD_READL(skdev, FIT_INT_STATUS_HOST));
 	SKD_WRITEL(skdev, FIT_INT_RESERVED_MASK, FIT_INT_STATUS_HOST);
-	spin_unlock_irqrestore(&skdev->lock, flags);
+	spin_unlock(&skdev->lock);
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t skd_statec_isr(int irq, void *skd_host_data)
 {
 	struct skd_device *skdev = skd_host_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&skdev->lock, flags);
+	spin_lock(&skdev->lock);
 	dev_dbg(&skdev->pdev->dev, "MSIX = 0x%x\n",
 		SKD_READL(skdev, FIT_INT_STATUS_HOST));
 	SKD_WRITEL(skdev, FIT_ISH_FW_STATE_CHANGE, FIT_INT_STATUS_HOST);
 	skd_isr_fwstate(skdev);
-	spin_unlock_irqrestore(&skdev->lock, flags);
+	spin_unlock(&skdev->lock);
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t skd_comp_q(int irq, void *skd_host_data)
 {
 	struct skd_device *skdev = skd_host_data;
-	unsigned long flags;
 	int flush_enqueued = 0;
 	int deferred;
 
-	spin_lock_irqsave(&skdev->lock, flags);
+	spin_lock(&skdev->lock);
 	dev_dbg(&skdev->pdev->dev, "MSIX = 0x%x\n",
 		SKD_READL(skdev, FIT_INT_STATUS_HOST));
 	SKD_WRITEL(skdev, FIT_ISH_COMPLETION_POSTED, FIT_INT_STATUS_HOST);
@@ -2415,7 +2412,7 @@ static irqreturn_t skd_comp_q(int irq, void *skd_host_data)
 	else if (!flush_enqueued)
 		schedule_work(&skdev->start_queue);
 
-	spin_unlock_irqrestore(&skdev->lock, flags);
+	spin_unlock(&skdev->lock);
 
 	return IRQ_HANDLED;
 }
@@ -2423,27 +2420,25 @@ static irqreturn_t skd_comp_q(int irq, void *skd_host_data)
 static irqreturn_t skd_msg_isr(int irq, void *skd_host_data)
 {
 	struct skd_device *skdev = skd_host_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&skdev->lock, flags);
+	spin_lock(&skdev->lock);
 	dev_dbg(&skdev->pdev->dev, "MSIX = 0x%x\n",
 		SKD_READL(skdev, FIT_INT_STATUS_HOST));
 	SKD_WRITEL(skdev, FIT_ISH_MSG_FROM_DEV, FIT_INT_STATUS_HOST);
 	skd_isr_msg_from_dev(skdev);
-	spin_unlock_irqrestore(&skdev->lock, flags);
+	spin_unlock(&skdev->lock);
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t skd_qfull_isr(int irq, void *skd_host_data)
 {
 	struct skd_device *skdev = skd_host_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&skdev->lock, flags);
+	spin_lock(&skdev->lock);
 	dev_dbg(&skdev->pdev->dev, "MSIX = 0x%x\n",
 		SKD_READL(skdev, FIT_INT_STATUS_HOST));
 	SKD_WRITEL(skdev, FIT_INT_QUEUE_FULL, FIT_INT_STATUS_HOST);
-	spin_unlock_irqrestore(&skdev->lock, flags);
+	spin_unlock(&skdev->lock);
 	return IRQ_HANDLED;
 }
 
-- 
2.7.4

