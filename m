Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC041D108A
	for <lists+linux-block@lfdr.de>; Wed, 13 May 2020 13:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgEMLE2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 07:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbgEMLE1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 07:04:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6A1C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 04:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VbfD2KvGIvBMNSYauqBakT43bABqCiMlwmjReq2hQqs=; b=UT94uriDHwk2xPz8bq/0oc3AFK
        9rcu3hNB4osY+nalxGd6dpaBgUTicAsO4fOTygQ1AChFD2I2ZTxHSC0JEd5doRRIvjOtWTkRXB0Sr
        WZsmibNPNQ/NWKtY9sLt1EKpjxocX+f0bALqOJWZYeXfJnlT1fBO24WMZkNBPPQJWA8FfUAt/04yx
        XlHdBUIrD5/kNPpX7ISFonkpWdBdkSujk6is+YenKQg4vTcRHAwIX7IPiLUozwZsLJYgQ1Ajw/2iZ
        fkXb3bqkQhQnxJPhibQOPUMJpMR+Sgldj8RER/trySslzY2IDy8DzquhoLynCH+COJRnpwu0jhSud
        ehVMjcug==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYpBb-0006iO-CS; Wed, 13 May 2020 11:04:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/4] block: remove a pointless queue enter pair in blk_mq_alloc_request
Date:   Wed, 13 May 2020 13:04:17 +0200
Message-Id: <20200513110419.2362556-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513110419.2362556-1-hch@lst.de>
References: <20200513110419.2362556-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No need for two queue references.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9865a36e6a6e3..a3491c1397501 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -404,10 +404,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 	if (ret)
 		return ERR_PTR(ret);
 
-	blk_queue_enter_live(q);
 	rq = blk_mq_get_request(q, NULL, &alloc_data);
-	blk_queue_exit(q);
-
 	if (!rq) {
 		blk_queue_exit(q);
 		return ERR_PTR(-EWOULDBLOCK);
-- 
2.26.2

