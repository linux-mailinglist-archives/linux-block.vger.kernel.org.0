Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F8E1BC229
	for <lists+linux-block@lfdr.de>; Tue, 28 Apr 2020 17:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgD1PCk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Apr 2020 11:02:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3329 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbgD1PCk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 11:02:40 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BA9D042D3CB2D33CBB90;
        Tue, 28 Apr 2020 23:02:36 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Apr 2020 23:02:28 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-block@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] block: fix error return code in mm_pci_probe()
Date:   Tue, 28 Apr 2020 15:03:44 +0000
Message-ID: <20200428150344.101399-1-weiyongjun1@huawei.com>
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

Fix to return negative error code -ENOMEM from the memory alloc failed
error handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/block/umem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index d84e8a878df2..184cb8f20387 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -875,6 +875,7 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (card->mm_pages[0].desc == NULL ||
 	    card->mm_pages[1].desc == NULL) {
 		dev_printk(KERN_ERR, &card->dev->dev, "alloc failed\n");
+		ret = -ENOMEM;
 		goto failed_alloc;
 	}
 	reset_page(&card->mm_pages[0]);
@@ -886,8 +887,10 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	spin_lock_init(&card->lock);
 
 	card->queue = blk_alloc_queue(mm_make_request, NUMA_NO_NODE);
-	if (!card->queue)
+	if (!card->queue) {
+		ret = -ENOMEM;
 		goto failed_alloc;
+	}
 	card->queue->queuedata = card;
 
 	tasklet_init(&card->tasklet, process_page, (unsigned long)card);



