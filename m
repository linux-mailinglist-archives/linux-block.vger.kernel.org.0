Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E661B8806
	for <lists+linux-block@lfdr.de>; Sat, 25 Apr 2020 19:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgDYRKM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 25 Apr 2020 13:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgDYRKK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 13:10:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC60C09B04D
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2020 10:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mEyemBN1R63ffK1Pru6zyhE2jDvnwuWZL/23fSw0KK0=; b=fAxyxJF4wVi2P9IQDCaVwfrIi5
        owM6HkH0zE9dn0pKp7HhPb2lgley+GnZKmq5H4mXX/djbLAS6Z5/nSSGkyqmyWmpPXzMJ7t+v3EYb
        0lSwg0l8Z2vpaXYYBUmf2X9UPEmRXR5dW356kKOLeHFHUsRpdga5tI38MVovZYANUre9ajakd3myh
        IxJyM2BDtc34xfiBYMH3kBjokXGdTcb4AQUASkMYgPA97EP6RJnInmqNFC36CZ3N5zjWw617oWXRJ
        D4h9DJ/YNDtnUdoi9w/kmHmpRtyeZycJwQN8HscOUzfrQLYqW4XH0o7CVxCR/HIC7mGVmZlIfs28+
        vKevEdFw==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSOJd-0003OK-Uz; Sat, 25 Apr 2020 17:10:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 09/11] block: remove a pointless queue enter pair in blk_mq_alloc_request
Date:   Sat, 25 Apr 2020 19:09:42 +0200
Message-Id: <20200425170944.968861-10-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200425170944.968861-1-hch@lst.de>
References: <20200425170944.968861-1-hch@lst.de>
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
index 0d94437362644..fc1df2a5969a0 100644
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
2.26.1

