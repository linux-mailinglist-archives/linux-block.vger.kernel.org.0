Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4489C435AB3
	for <lists+linux-block@lfdr.de>; Thu, 21 Oct 2021 08:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhJUGIy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Oct 2021 02:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhJUGIu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 02:08:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A794C061753;
        Wed, 20 Oct 2021 23:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3ECccBF3V87U61r03r9dtFoWy4sVS87UrAHGw16xpd0=; b=hp+JOWgiVfmNlWB/QGA3DiL1Er
        SKn8nc6AsUs5Y2VzmRe03g4cwKeq86WXucsp+PUZLI3KPd/zkMXuxeH/uD2SJTzKxYrUEPncYsmP7
        kxLCyCrsK0c8p/C/5gP2aizdeyUd9Jyhpu861uJvL0ezpSH6yK6ZbRvb4oE7D2ldusDGWTrS5sRn7
        Mat8Ji8EOOfnUxOE0b0OmXHoOUfMpj4RMMWxmg5SD1AFljs0cnuRShEEDLwY1FYrcHgo1vHyg3r10
        Fmn+xjY8G5z6i2a75y8xbmXACZg7krovMGmOSZ3TZNTumRjdc+KyD9XGLXQSEuXUba/CVTaJGwJST
        TBE2F3aQ==;
Received: from [2001:4bb8:180:8777:7df0:a8d8:40cc:3310] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdRDk-006UAe-5b; Thu, 21 Oct 2021 06:06:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 7/7] block: remove QUEUE_FLAG_SCSI_PASSTHROUGH
Date:   Thu, 21 Oct 2021 08:06:07 +0200
Message-Id: <20211021060607.264371-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021060607.264371-1-hch@lst.de>
References: <20211021060607.264371-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Export scsi_device_from_queue for use with pktcdvd and use that instead
of the otherwise unused QUEUE_FLAG_SCSI_PASSTHROUGH queue flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq-debugfs.c   | 1 -
 drivers/block/pktcdvd.c  | 5 ++++-
 drivers/scsi/scsi_lib.c  | 8 ++++++++
 drivers/scsi/scsi_scan.c | 1 -
 include/linux/blkdev.h   | 3 ---
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 68ca5d21cda77..a317f05de466a 100644
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
index d7d37131ab9dd..d7bcd12394b3c 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2536,6 +2536,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	int i;
 	char b[BDEVNAME_SIZE];
 	struct block_device *bdev;
+	struct scsi_device *sdev;
 
 	if (pd->pkt_dev == dev) {
 		pkt_err(pd, "recursive setup not allowed\n");
@@ -2559,10 +2560,12 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
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
index a0f801fc8943b..9823b65d15368 100644
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
index af61fb3e1502c..558aa7ab4c4c8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -356,7 +356,6 @@ struct request_queue {
 #define QUEUE_FLAG_STATS	20	/* track IO start and completion times */
 #define QUEUE_FLAG_POLL_STATS	21	/* collecting stats for hybrid polling */
 #define QUEUE_FLAG_REGISTERED	22	/* queue has been registered to a disk */
-#define QUEUE_FLAG_SCSI_PASSTHROUGH 23	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
 #define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
@@ -390,8 +389,6 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
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

