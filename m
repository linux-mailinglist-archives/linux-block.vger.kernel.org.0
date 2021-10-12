Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F3A42A41E
	for <lists+linux-block@lfdr.de>; Tue, 12 Oct 2021 14:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbhJLMPg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Oct 2021 08:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbhJLMPg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 08:15:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB196C061570;
        Tue, 12 Oct 2021 05:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=I7haXvPyPMjdgPjSwit3nndGPAbjeS0OdfWQdG2PMsc=; b=ZDnJcuehC5CfO7ppjrxaiCC2T8
        3Nkg1MOfCuIgYqXS7M5rAg/IcAxQCR7U10V828c87vkpS7DfcQdV2eigiEyvxQReHiCKFx7p2iEO2
        N2i6cWgqriD/mGFs4ZGW5tNBqAmaIV+K8aap4S6xsTM/DJCV/v7spDiLEkeZ0j2H+YYMAeJ57my3X
        iduBNBFylYWa3zChYuGt8GWLU32FZ4jHsiAX/CF4wSfNVF1zdiniPaeYrFcJZcywN77CcTpNOnK/K
        zZ5Al+EKdePQEPefVqdkpHG2E/NZFJY5aSPMZ6IndYtKOrR7cuLD94M7JuYO4Dnqs1c/S5VCbvqDs
        zOKqiyqw==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maGdm-006UBq-Gf; Tue, 12 Oct 2021 12:12:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 7/7] block: remove QUEUE_FLAG_SCSI_PASSTHROUGH
Date:   Tue, 12 Oct 2021 14:04:45 +0200
Message-Id: <20211012120445.861860-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012120445.861860-1-hch@lst.de>
References: <20211012120445.861860-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Export scsi_device_from_queue for use with pktcdvd and use that instead
of the otherwise unused QUEUE_FLAG_SCSI_PASSTHROUGH queue flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-debugfs.c   | 1 -
 drivers/block/pktcdvd.c  | 5 ++++-
 drivers/scsi/scsi_lib.c  | 8 ++++++++
 drivers/scsi/scsi_scan.c | 1 -
 include/linux/blkdev.h   | 3 ---
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4000376330c90..8e716c20fca5d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -124,7 +124,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(STATS),
 	QUEUE_FLAG_NAME(POLL_STATS),
 	QUEUE_FLAG_NAME(REGISTERED),
-	QUEUE_FLAG_NAME(SCSI_PASSTHROUGH),
 	QUEUE_FLAG_NAME(QUIESCED),
 	QUEUE_FLAG_NAME(PCI_P2PDMA),
 	QUEUE_FLAG_NAME(ZONE_RESETALL),
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 7d3558aef58a5..e5826d09d9706 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2537,6 +2537,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	int i;
 	char b[BDEVNAME_SIZE];
 	struct block_device *bdev;
+	struct scsi_device *sdev;
 
 	if (pd->pkt_dev == dev) {
 		pkt_err(pd, "recursive setup not allowed\n");
@@ -2560,10 +2561,12 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	bdev = blkdev_get_by_dev(dev, FMODE_READ | FMODE_NDELAY, NULL);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
-	if (!blk_queue_scsi_passthrough(bdev_get_queue(bdev))) {
+	sdev = scsi_device_from_queue(bdev->bd_disk->queue);
+	if (!sdev) {
 		blkdev_put(bdev, FMODE_READ | FMODE_NDELAY);
 		return -EINVAL;
 	}
+	put_device(&sdev->sdev_gendev);
 
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index d787b7bd9cb06..e7dd427b927d6 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1967,6 +1967,14 @@ struct scsi_device *scsi_device_from_queue(struct request_queue *q)
 
 	return sdev;
 }
+/*
+ * pktcdvd should have been integrated into the SCSI layers, but for historical
+ * reasons like the old IDE driver it isn't.  This export allows it to safely
+ * probe if a given device is a SCSI one and only attach to that.
+ */
+#ifdef CONFIG_CDROM_PKTCDVD_MODULE
+EXPORT_SYMBOL_GPL(scsi_device_from_queue);
+#endif
 
 /**
  * scsi_block_requests - Utility function used by low-level drivers to prevent
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index fe22191522a3b..2808c0cb57114 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -280,7 +280,6 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	sdev->request_queue = q;
 	q->queuedata = sdev;
 	__scsi_init_queue(sdev->host, q);
-	blk_queue_flag_set(QUEUE_FLAG_SCSI_PASSTHROUGH, q);
 	WARN_ON_ONCE(!blk_get_queue(q));
 
 	depth = sdev->host->cmd_per_lun ?: 1;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 81f94a7c54521..bf8d1996e4d4a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -355,7 +355,6 @@ struct request_queue {
 #define QUEUE_FLAG_STATS	20	/* track IO start and completion times */
 #define QUEUE_FLAG_POLL_STATS	21	/* collecting stats for hybrid polling */
 #define QUEUE_FLAG_REGISTERED	22	/* queue has been registered to a disk */
-#define QUEUE_FLAG_SCSI_PASSTHROUGH 23	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
 #define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
@@ -389,8 +388,6 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_secure_erase(q) \
 	(test_bit(QUEUE_FLAG_SECERASE, &(q)->queue_flags))
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
-#define blk_queue_scsi_passthrough(q)	\
-	test_bit(QUEUE_FLAG_SCSI_PASSTHROUGH, &(q)->queue_flags)
 #define blk_queue_pci_p2pdma(q)	\
 	test_bit(QUEUE_FLAG_PCI_P2PDMA, &(q)->queue_flags)
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
-- 
2.30.2

