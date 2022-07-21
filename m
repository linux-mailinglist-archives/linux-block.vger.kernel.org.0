Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5857C3B4
	for <lists+linux-block@lfdr.de>; Thu, 21 Jul 2022 07:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiGUFQw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Jul 2022 01:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGUFQw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 01:16:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C3479ED1
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 22:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=p3Kp8ytO8RxIl5ARh+MIw1lb0SipwSEVu685ZQVathA=; b=A5SMgryannzoUmJYdZgZ7/0usX
        0NBMRJQrK0bAx4Dt9RamjpLFEaZzPSSnN3RcVXP+HUJiBnlEuyfOk38QMWvMF4NCbQb5+zYrjJfpK
        JV7CW6XRY3KbxKRPd/daN6TgONndX2QDf9NOBBlfKuXrGTl+/y02WhVfVdQNjHfQvASdUHydBWr55
        bMyfVyZdSzyFJaD52SuOY7EiXSGm7V8pHUjYNNoK/eILqkrkZUUukSA8bTLO3PktK4MQHm+//7qrA
        8Jk+iUHHTslnZw+6dmwaJXNWlKe6DQNmiHHKnDiXPlC8WVyf2xtZfk/idZMgTDk1DPX42g0EXSyde
        vA7dcY5Q==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEOYL-00HDaL-UK; Thu, 21 Jul 2022 05:16:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/8] ublk: simplify ublk_ch_open and ublk_ch_release
Date:   Thu, 21 Jul 2022 07:16:28 +0200
Message-Id: <20220721051632.1676890-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721051632.1676890-1-hch@lst.de>
References: <20220721051632.1676890-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

fops->open and fops->release are always paired.  Use simple atomic bit
ops ot indicate if the device is opened instead of a count that can
only be 0 and 1 and a useless cmpxchg loop in ublk_ch_release.

Also don't bother clearing file->private_data is the file is about to
be freed anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/ublk_drv.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index deabcb23ae2af..1f7bbbc3276a2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -125,7 +125,8 @@ struct ublk_device {
 	struct cdev		cdev;
 	struct device		cdev_dev;
 
-	atomic_t		ch_open_cnt;
+#define UB_STATE_OPEN		(1 << 0)
+	unsigned long		state;
 	int			ub_number;
 
 	struct mutex		mutex;
@@ -647,21 +648,17 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 	struct ublk_device *ub = container_of(inode->i_cdev,
 			struct ublk_device, cdev);
 
-	if (atomic_cmpxchg(&ub->ch_open_cnt, 0, 1) == 0) {
-		filp->private_data = ub;
-		return 0;
-	}
-	return -EBUSY;
+	if (test_and_set_bit(UB_STATE_OPEN, &ub->state))
+		return -EBUSY;
+	filp->private_data = ub;
+	return 0;
 }
 
 static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
 
-	while (atomic_cmpxchg(&ub->ch_open_cnt, 1, 0) != 1)
-		cpu_relax();
-
-	filp->private_data = NULL;
+	clear_bit(UB_STATE_OPEN, &ub->state);
 	return 0;
 }
 
-- 
2.30.2

