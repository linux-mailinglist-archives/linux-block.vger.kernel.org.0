Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2A47B002F
	for <lists+linux-block@lfdr.de>; Wed, 27 Sep 2023 11:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjI0Jer (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 Sep 2023 05:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjI0Jeq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Sep 2023 05:34:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179B6E6;
        Wed, 27 Sep 2023 02:34:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8BDB71F8CC;
        Wed, 27 Sep 2023 09:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GenKmRdtrJZ/dkgyf1SakCEi/SRSx5kiH9YWEpsHADE=;
        b=G8uEc4HSjlgFcZbZA8qicXeMH1/SkYiiLwWD6wd/aEK2o/BmgjeLfo13qo+RgJRFKf4vb5
        EgPIQ9y2FpeECbR1g7lW8k//Q1KWagtnOCOG7XYREcRXWlu26vN62Yi3QT9xPDmek79Sxd
        ki62QuCpS0djuK/86PveCTZYi7wnJ40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807283;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GenKmRdtrJZ/dkgyf1SakCEi/SRSx5kiH9YWEpsHADE=;
        b=GUQiaXnlTZ5RJ/tp+H4T5IXQJD2hRrL7pyPrrx1YhM9A/GPPYEo4fBBUcD4OucPmHGzT5E
        U2cf4Ms/K4G1smAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D3D413AC6;
        Wed, 27 Sep 2023 09:34:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z2/VHjP3E2UAEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id ED264A07CF; Wed, 27 Sep 2023 11:34:42 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/29] block: Use bdev_open_by_dev() in disk_scan_partitions() and blkdev_bszset()
Date:   Wed, 27 Sep 2023 11:34:09 +0200
Message-Id: <20230927093442.25915-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087; i=jack@suse.cz; h=from:subject; bh=CZqRkTZac/cdxSBd3sqHqdAgK9+gCQBXgUh0lF/6kCc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/cTj6zStLYP1Cv12vC6i3kdvX1Pp1wjrmeubh/W bwd2hIyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3EwAKCRCcnaoHP2RA2VefB/ 9JvRJMQ+0hGIuUydFyXJXewx4/OZtSVc00PRWLeFj8hRELvZNtrtUU//CXmgrb1Qdqi2cEcsA6pWJ7 o5QNvkCEkQvr47qb8Bob64A0MSITSfGk7kuR8VNdEcpxjmtkY5hic+89OGcV3J8tE5ZCqXAkaUoMTe FzhtZONOGkny6LldLIZTgyhUO1Dgtho6rqtFkdgkfZXtxhi3SH+O141mUWDneu2CWxgjuQ6FmbufGI QNwGNDiz8HYKMczIQcJBeMdun7qvR6d3M2mYA7101Us1+rq6xzWZjmNco3VI70khoEyfRTopKivvHT HXs3ksPtMJGQt7ud5uWJd+WM9qjPcu
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Convert disk_scan_partitions() and blkdev_bszset() to use
bdev_open_by_dev().

Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/genhd.c | 12 ++++++------
 block/ioctl.c |  6 ++++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index cc32a0c704eb..4a16a424f57d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -342,7 +342,7 @@ EXPORT_SYMBOL_GPL(disk_uevent);
 
 int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 {
-	struct block_device *bdev;
+	struct bdev_handle *handle;
 	int ret = 0;
 
 	if (disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN))
@@ -366,12 +366,12 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 	}
 
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
-	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~BLK_OPEN_EXCL, NULL,
-				 NULL);
-	if (IS_ERR(bdev))
-		ret =  PTR_ERR(bdev);
+	handle = bdev_open_by_dev(disk_devt(disk), mode & ~BLK_OPEN_EXCL, NULL,
+				  NULL);
+	if (IS_ERR(handle))
+		ret = PTR_ERR(handle);
 	else
-		blkdev_put(bdev, NULL);
+		bdev_release(handle);
 
 	/*
 	 * If blkdev_get_by_dev() failed early, GD_NEED_PART_SCAN is still set,
diff --git a/block/ioctl.c b/block/ioctl.c
index d5f5cd61efd7..5d356c964352 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -467,6 +467,7 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 		int __user *argp)
 {
 	int ret, n;
+	struct bdev_handle *handle;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -478,10 +479,11 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 	if (mode & BLK_OPEN_EXCL)
 		return set_blocksize(bdev, n);
 
-	if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode, &bdev, NULL)))
+	handle = bdev_open_by_dev(bdev->bd_dev, mode, &bdev, NULL);
+	if (IS_ERR(handle))
 		return -EBUSY;
 	ret = set_blocksize(bdev, n);
-	blkdev_put(bdev, &bdev);
+	bdev_release(handle);
 
 	return ret;
 }
-- 
2.35.3

