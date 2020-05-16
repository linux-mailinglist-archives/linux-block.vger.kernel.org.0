Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647A51D6392
	for <lists+linux-block@lfdr.de>; Sat, 16 May 2020 20:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgEPS2J (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 16 May 2020 14:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbgEPS2J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 14:28:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B8EC061A0C
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qSZKlFNnRY43dm0NsErm/NmGxAHTnLCCqSPd/aaTu2c=; b=NAJM/Cfn0pm6tmWRFaWN21ocWN
        S99XlVTq6c4v1LmOcP17mITYveDbCRzQev2SHE1uQfdKRd4AMJ8t5EDRAN9W8SdkKhlSvkxHSG+Ih
        GSoXeh/w2B7BeuV29IN9iJxRzkgL94q4CxQCIRrTm0ogY0DWXNSdN5tlqz9g6H93JwwI/EU5Q48BN
        9SNsiJFjdOxZP0HFRWZmdqyM0OnpygefrrwFkq48O7oDH2D7TNBAwzYIrpS69b9Ys6Q8FFyBqvlAL
        K7Ht398Cn+rKa6ltCeOS3yZ9diwztp7JUHh8C5nb4eqp2Rgy2QSApo76LVc+8UU5GPDL7bx2XWNz0
        8K3AZnVg==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ja1Xd-0007nq-0k; Sat, 16 May 2020 18:28:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/4] blk-mq: remove a pointless queue enter pair in blk_mq_alloc_request
Date:   Sat, 16 May 2020 20:27:59 +0200
Message-Id: <20200516182801.482930-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200516182801.482930-1-hch@lst.de>
References: <20200516182801.482930-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No need for two queue references.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b7e06673a30ba..4e62b97dceb48 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -406,10 +406,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 	if (ret)
 		return ERR_PTR(ret);
 
-	blk_queue_enter_live(q);
 	rq = blk_mq_get_request(q, NULL, &alloc_data);
-	blk_queue_exit(q);
-
 	if (!rq)
 		goto out_queue_exit;
 	rq->__data_len = 0;
-- 
2.26.2

