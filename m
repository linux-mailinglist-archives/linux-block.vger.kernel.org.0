Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379AF4C5DBB
	for <lists+linux-block@lfdr.de>; Sun, 27 Feb 2022 18:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiB0RWo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 27 Feb 2022 12:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiB0RWk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Feb 2022 12:22:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69486C967;
        Sun, 27 Feb 2022 09:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CQUvlsmrvEOvao7gpxSccrPKDKA68ZFzfzs9XLF0OFM=; b=Atx5PKX+bZdjTlceiYk+bqysMv
        dFXi65fM5NjZAATl9FdHLnuRe2dyQBlnlq3b64yr3TAk3M5eKraM5UwlZjuTMIZ1+SgVhXaHwD/Rm
        nYtnSo/o+1IR8uA5x/CaRI3gR8Z89/Jj/g+19z0xTAVtA4gcySnD17/mvOfkRIroI3X3omApnM9aH
        fDS0TIeKrcPEyBqPY+1MI2kAs5rBlDX6eOEInXWnDpB3wkOl3ZcWOR1zLw3x1KdaiLt46dzc1PYCo
        mkWm6KrjdaM6DOLuwHxZTALtHs3gOXm6EvQ03aYZTXJ7mtr2k0wtE/CK9w+uMcL7e237biBFrkIi0
        64VicaeA==;
Received: from 91-118-163-82.static.upcbusiness.at ([91.118.163.82] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nONFC-009s0O-8q; Sun, 27 Feb 2022 17:22:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 05/14] sd: call sd_zbc_release_disk before releasing the scsi_device reference
Date:   Sun, 27 Feb 2022 18:21:35 +0100
Message-Id: <20220227172144.508118-6-hch@lst.de>
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

sd_zbc_release_disk accesses disk->device, so ensure that actually still has
a valid reference.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 7479e7cb36b43..7bfebf5b2832d 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3672,9 +3672,9 @@ static void scsi_disk_release(struct device *dev)
 
 	disk->private_data = NULL;
 	put_disk(disk);
-	put_device(&sdkp->device->sdev_gendev);
 
 	sd_zbc_release_disk(sdkp);
+	put_device(&sdkp->device->sdev_gendev);
 
 	kfree(sdkp);
 }
-- 
2.30.2

