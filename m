Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5014C5DB4
	for <lists+linux-block@lfdr.de>; Sun, 27 Feb 2022 18:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiB0RWh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 27 Feb 2022 12:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiB0RWh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Feb 2022 12:22:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ED36C967;
        Sun, 27 Feb 2022 09:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=goU22Nk69fNlQzMoLN2QlZz52Zy9ESYhbN9FApBLNk0=; b=ytNiRAsYKt3r2/Khp1gUoUYzfm
        9jgRRHC46l/+c/JRbBkQhvuGvAC0vI7C+01UpvtOZk8SbHugor5l6O56P3GoipA8bVclKfZ6kx6jm
        GS4Xty6pQjaP7sZR9N1XUPHEQLRpjYet3vjks6scfPCbequinHFPVAYCSTEqAfZT2dR573izGNZ6X
        8sd/JwYDpqFLanON55VYB7U+4M4JfO1iTNvQY4eyl8cIRaVWlvBxCXWBH8sPz372lHyfJVbZEK4c+
        Joai3XiOQ46E8f72tg06yGTeGFvmTGqZ2VIPMajYeq8GVSCYgHrkqM9BxT/gyJ3ji6JsOGgNFWKi7
        +Z6guXag==;
Received: from 91-118-163-82.static.upcbusiness.at ([91.118.163.82] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nONF7-009ryc-0I; Sun, 27 Feb 2022 17:21:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 03/14] scsi: don't use disk->private_data to find the scsi_driver
Date:   Sun, 27 Feb 2022 18:21:33 +0100
Message-Id: <20220227172144.508118-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220227172144.508118-1-hch@lst.de>
References: <20220227172144.508118-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Requiring every ULP to have the scsi_drive as first member of the
private data is rather fragile and not necessary anyway.  Just use
the driver hanging off the SCSI device instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c          | 3 +--
 drivers/scsi/sd.h          | 3 +--
 drivers/scsi/sr.c          | 5 ++---
 drivers/scsi/sr.h          | 1 -
 drivers/scsi/st.c          | 1 -
 drivers/scsi/st.h          | 1 -
 include/scsi/scsi_cmnd.h   | 9 ---------
 include/scsi/scsi_driver.h | 9 +++++++--
 8 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 2d648d27bfd71..2a1e19e871d30 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3515,7 +3515,6 @@ static int sd_probe(struct device *dev)
 	}
 
 	sdkp->device = sdp;
-	sdkp->driver = &sd_template;
 	sdkp->disk = gd;
 	sdkp->index = index;
 	sdkp->max_retries = SD_MAX_RETRIES;
@@ -3548,7 +3547,7 @@ static int sd_probe(struct device *dev)
 	gd->minors = SD_MINORS;
 
 	gd->fops = &sd_fops;
-	gd->private_data = &sdkp->driver;
+	gd->private_data = sdkp;
 
 	/* defaults, until the device tells us otherwise */
 	sdp->sector_size = 512;
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 2e5932bde43d1..303aa1c23aefb 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -68,7 +68,6 @@ enum {
 };
 
 struct scsi_disk {
-	struct scsi_driver *driver;	/* always &sd_template */
 	struct scsi_device *device;
 	struct device	dev;
 	struct gendisk	*disk;
@@ -131,7 +130,7 @@ struct scsi_disk {
 
 static inline struct scsi_disk *scsi_disk(struct gendisk *disk)
 {
-	return container_of(disk->private_data, struct scsi_disk, driver);
+	return disk->private_data;
 }
 
 #define sd_printk(prefix, sdsk, fmt, a...)				\
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index f925b1f1f9ada..569bda76a5175 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -147,7 +147,7 @@ static void sr_kref_release(struct kref *kref);
 
 static inline struct scsi_cd *scsi_cd(struct gendisk *disk)
 {
-	return container_of(disk->private_data, struct scsi_cd, driver);
+	return disk->private_data;
 }
 
 static int sr_runtime_suspend(struct device *dev)
@@ -692,7 +692,6 @@ static int sr_probe(struct device *dev)
 
 	cd->device = sdev;
 	cd->disk = disk;
-	cd->driver = &sr_template;
 	cd->capacity = 0x1fffff;
 	cd->device->changed = 1;	/* force recheck CD type */
 	cd->media_present = 1;
@@ -713,7 +712,7 @@ static int sr_probe(struct device *dev)
 	sr_vendor_init(cd);
 
 	set_capacity(disk, cd->capacity);
-	disk->private_data = &cd->driver;
+	disk->private_data = cd;
 
 	if (register_cdrom(disk, &cd->cdi))
 		goto fail_minor;
diff --git a/drivers/scsi/sr.h b/drivers/scsi/sr.h
index 1609f02ed29ac..d80af3fcb6f97 100644
--- a/drivers/scsi/sr.h
+++ b/drivers/scsi/sr.h
@@ -32,7 +32,6 @@ struct scsi_device;
 
 
 typedef struct scsi_cd {
-	struct scsi_driver *driver;
 	unsigned capacity;	/* size in blocks                       */
 	struct scsi_device *device;
 	unsigned int vendor;	/* vendor code, see sr_vendor.c         */
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index e869e90e05afe..ebe9412c86f43 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4276,7 +4276,6 @@ static int st_probe(struct device *dev)
 		goto out_buffer_free;
 	}
 	kref_init(&tpnt->kref);
-	tpnt->driver = &st_template;
 
 	tpnt->device = SDp;
 	if (SDp->scsi_level <= 2)
diff --git a/drivers/scsi/st.h b/drivers/scsi/st.h
index c0ef0d9aaf8a2..7a68eaba7e810 100644
--- a/drivers/scsi/st.h
+++ b/drivers/scsi/st.h
@@ -117,7 +117,6 @@ struct scsi_tape_stats {
 
 /* The tape drive descriptor */
 struct scsi_tape {
-	struct scsi_driver *driver;
 	struct scsi_device *device;
 	struct mutex lock;	/* For serialization */
 	struct completion wait;	/* For SCSI commands */
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 6794d7322cbde..e3a4c67794b14 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -13,7 +13,6 @@
 #include <scsi/scsi_request.h>
 
 struct Scsi_Host;
-struct scsi_driver;
 
 /*
  * MAX_COMMAND_SIZE is:
@@ -159,14 +158,6 @@ static inline void *scsi_cmd_priv(struct scsi_cmnd *cmd)
 	return cmd + 1;
 }
 
-/* make sure not to use it with passthrough commands */
-static inline struct scsi_driver *scsi_cmd_to_driver(struct scsi_cmnd *cmd)
-{
-	struct request *rq = scsi_cmd_to_rq(cmd);
-
-	return *(struct scsi_driver **)rq->q->disk->private_data;
-}
-
 void scsi_done(struct scsi_cmnd *cmd);
 
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
diff --git a/include/scsi/scsi_driver.h b/include/scsi/scsi_driver.h
index 6dffa8555a390..4ce1988b2ba01 100644
--- a/include/scsi/scsi_driver.h
+++ b/include/scsi/scsi_driver.h
@@ -4,11 +4,10 @@
 
 #include <linux/blk_types.h>
 #include <linux/device.h>
+#include <scsi/scsi_cmnd.h>
 
 struct module;
 struct request;
-struct scsi_cmnd;
-struct scsi_device;
 
 struct scsi_driver {
 	struct device_driver	gendrv;
@@ -31,4 +30,10 @@ extern int scsi_register_interface(struct class_interface *);
 #define scsi_unregister_interface(intf) \
 	class_interface_unregister(intf)
 
+/* make sure not to use it with passthrough commands */
+static inline struct scsi_driver *scsi_cmd_to_driver(struct scsi_cmnd *cmd)
+{
+	return to_scsi_driver(cmd->device->sdev_gendev.driver);
+}
+
 #endif /* _SCSI_SCSI_DRIVER_H */
-- 
2.30.2

