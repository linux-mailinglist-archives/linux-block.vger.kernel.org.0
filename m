Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DD657CB7F
	for <lists+linux-block@lfdr.de>; Thu, 21 Jul 2022 15:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiGUNJl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Jul 2022 09:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiGUNJb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 09:09:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D83265B5
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Zz/G9dmP2WzZl3Xu5xi8dGB4TZuDhuXkdNh4koQvt5Y=; b=l3XLOXqzLJnG7EIXWtxa1KFwke
        cHzf9i32v3zws0AFoA7/BhoUEvLwYF7T7jxB7cBtbB8zCmSfeyZ/fmhTBo4t1hWbgOGlwEHuJg7nT
        oW4kdZxgIW4xHGmBYLUbxpriceoT2UTsuKYWaLqKl2azYOjqlCkXQHMifZR4qadBDPWHzqekOKqcb
        aDQ2LtXp3QvAN8iYljMhU4Dy2vTLqHkXk3nEcmctd++y3xA1hkrOCkxI/IHoDoOwlcWroH8SrUvLX
        D7zflH+6N9/WHa098YBzesXNNEtmXkAcT2jQToe2ceFjyltfozxfCzbs788/DaJkPUhOUtQSvlhj7
        Sw/QJ53Q==;
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEVvj-006moa-4K; Thu, 21 Jul 2022 13:09:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/8] ublk: remove the empty open and release block device operations
Date:   Thu, 21 Jul 2022 15:09:11 +0200
Message-Id: <20220721130916.1869719-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721130916.1869719-1-hch@lst.de>
References: <20220721130916.1869719-1-hch@lst.de>
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

No need to define empty versions, they can just be left out.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 07913b5bccd90..deabcb23ae2af 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -208,19 +208,8 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
 			PAGE_SIZE);
 }
 
-static int ublk_open(struct block_device *bdev, fmode_t mode)
-{
-	return 0;
-}
-
-static void ublk_release(struct gendisk *disk, fmode_t mode)
-{
-}
-
 static const struct block_device_operations ub_fops = {
 	.owner =	THIS_MODULE,
-	.open =		ublk_open,
-	.release =	ublk_release,
 };
 
 #define UBLK_MAX_PIN_PAGES	32
-- 
2.30.2

