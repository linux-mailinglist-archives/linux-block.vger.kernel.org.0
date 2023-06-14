Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374C272FB1E
	for <lists+linux-block@lfdr.de>; Wed, 14 Jun 2023 12:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjFNKgi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 14 Jun 2023 06:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbjFNKgg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 06:36:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFB5196;
        Wed, 14 Jun 2023 03:36:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0991F2249A;
        Wed, 14 Jun 2023 10:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686738994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NIIcfUemKWRz/5KG0RjzVvyeJ6eobZSmA29DvyfVaCQ=;
        b=NFeJwS1kaDfQdzTpufTWdB3jnvcdwukD9630GEP9+Jnbk4Jr49aWRD7M50t0rYTFiAq9fW
        BQDQWMbJvXJid7nfBqH+j1yqMc98UGCtBeui2ME3EXppfd0TH/uC43nk4/N/KICqTIrF5q
        a0Hz92pED1utQiSWlV/9JaKuJLROGDI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9D271357F;
        Wed, 14 Jun 2023 10:36:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2DjRJzGYiWSTfQAAMHmgww
        (envelope-from <mwilck@suse.com>); Wed, 14 Jun 2023 10:36:33 +0000
From:   mwilck@suse.com
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Martin Wilck <mwilck@suse.com>
Subject: [PATCH v7 3/7] scsi: merge scsi_internal_device_block() and device_block()
Date:   Wed, 14 Jun 2023 12:36:12 +0200
Message-Id: <20230614103616.31857-4-mwilck@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614103616.31857-1-mwilck@suse.com>
References: <20230614103616.31857-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

scsi_internal_device_block() is only called from device_block().
Merge the two functions, and call the result scsi_device_block(),
as the name device_block() is confusingly generic.

Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/scsi_lib.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 496bdfc19c95..69fb7a9d8883 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2781,13 +2781,12 @@ int scsi_internal_device_block_nowait(struct scsi_device *sdev)
 EXPORT_SYMBOL_GPL(scsi_internal_device_block_nowait);
 
 /**
- * scsi_internal_device_block - try to transition to the SDEV_BLOCK state
+ * scsi_device_block - try to transition to the SDEV_BLOCK state
  * @sdev: device to block
+ * @data: dummy argument, ignored
  *
  * Pause SCSI command processing on the specified device and wait until all
- * ongoing scsi_request_fn() / scsi_queue_rq() calls have finished. May sleep.
- *
- * Returns zero if successful or a negative error code upon failure.
+ * ongoing scsi_queue_rq() calls have finished. May sleep.
  *
  * Note:
  * This routine transitions the device to the SDEV_BLOCK state (which must be
@@ -2795,7 +2794,7 @@ EXPORT_SYMBOL_GPL(scsi_internal_device_block_nowait);
  * is paused until the device leaves the SDEV_BLOCK state. See also
  * scsi_internal_device_unblock().
  */
-static int scsi_internal_device_block(struct scsi_device *sdev)
+static void scsi_device_block(struct scsi_device *sdev, void *data)
 {
 	int err;
 
@@ -2805,7 +2804,8 @@ static int scsi_internal_device_block(struct scsi_device *sdev)
 		scsi_stop_queue(sdev, false);
 	mutex_unlock(&sdev->state_mutex);
 
-	return err;
+	WARN_ONCE(err, "__scsi_internal_device_block_nowait(%s) failed: err = %d\n",
+		  dev_name(&sdev->sdev_gendev), err);
 }
 
 /**
@@ -2888,23 +2888,12 @@ static int scsi_internal_device_unblock(struct scsi_device *sdev,
 	return ret;
 }
 
-static void
-device_block(struct scsi_device *sdev, void *data)
-{
-	int ret;
-
-	ret = scsi_internal_device_block(sdev);
-
-	WARN_ONCE(ret, "scsi_internal_device_block(%s) failed: ret = %d\n",
-		  dev_name(&sdev->sdev_gendev), ret);
-}
-
 static int
 target_block(struct device *dev, void *data)
 {
 	if (scsi_is_target_device(dev))
 		starget_for_each_device(to_scsi_target(dev), NULL,
-					device_block);
+					scsi_device_block);
 	return 0;
 }
 
@@ -2913,7 +2902,7 @@ scsi_target_block(struct device *dev)
 {
 	if (scsi_is_target_device(dev))
 		starget_for_each_device(to_scsi_target(dev), NULL,
-					device_block);
+					scsi_device_block);
 	else
 		device_for_each_child(dev, NULL, target_block);
 }
-- 
2.40.1

