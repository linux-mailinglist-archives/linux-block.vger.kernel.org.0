Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A6149DAC8
	for <lists+linux-block@lfdr.de>; Thu, 27 Jan 2022 07:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbiA0Gf5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Jan 2022 01:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbiA0Gf4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 01:35:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8EEC061748
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 22:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=53g90lZBMh/ldzirlFZP4n9i+Wwo32QW2GhtYSf7T5E=; b=323ruvMNhoFxk0yMLNR6FMnW2n
        c3S+XozGz3ml41cKLEU3r7JvjCgJrsIZF+mfZBqpc/NoQwCGoijkERTMt+qPMYlx8lzwSaYaN/oSL
        xih95alit5YSpXkqplB8JRMmYscE7ODhr+rOv/kTOQDfIiTd5KchqQ/MteugMlZluvWLiY87sUogI
        V/f1wiJwI/bvOc0fWlEHBMgDSX1+ArRKIc+xEGeaTzOxwiyyz7zhdzHEU7q2fgU6aCJtFe3/2pDLh
        i7Qf+76YDpABHH72y4qdqXAleaASSf3eeoPtWTS9MHwPIZj6xfxui2TAD5w2fEaOMc/7UAQ27KZ8S
        hkAYpUBw==;
Received: from 213-225-10-69.nat.highway.a1.net ([213.225.10.69] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCyNt-00EY10-RY; Thu, 27 Jan 2022 06:35:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: [PATCH 01/14] drbd: set ->bi_bdev in drbd_req_new
Date:   Thu, 27 Jan 2022 07:35:33 +0100
Message-Id: <20220127063546.1314111-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127063546.1314111-1-hch@lst.de>
References: <20220127063546.1314111-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make sure the newly allocated bio has the correct bi_bdev set from the
start.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_req.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 3235532ae0778..8d44e96c4c4ef 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -31,6 +31,7 @@ static struct drbd_request *drbd_req_new(struct drbd_device *device, struct bio
 	memset(req, 0, sizeof(*req));
 
 	req->private_bio = bio_clone_fast(bio_src, GFP_NOIO, &drbd_io_bio_set);
+	bio_set_dev(req->private_bio, device->ldev->backing_bdev);
 	req->private_bio->bi_private = req;
 	req->private_bio->bi_end_io = drbd_request_endio;
 
@@ -1151,8 +1152,6 @@ drbd_submit_req_private_bio(struct drbd_request *req)
 	else
 		type = DRBD_FAULT_DT_RD;
 
-	bio_set_dev(bio, device->ldev->backing_bdev);
-
 	/* State may have changed since we grabbed our reference on the
 	 * ->ldev member. Double check, and short-circuit to endio.
 	 * In case the last activity log transaction failed to get on
-- 
2.30.2

