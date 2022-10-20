Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A446057AD
	for <lists+linux-block@lfdr.de>; Thu, 20 Oct 2022 08:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJTGsi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Oct 2022 02:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJTGsf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 02:48:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F37EAC86
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 23:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AF6Ju2q/dWCQlF7Triohzn1CBZ1NZ4psoUijJc0/B0M=; b=znuGKGNbbHivk1BnSU1AU1spZ2
        6zGc6K632lLBbVhXOvVGY0Z75bnYjE6fg4R0dyTOyFTYJ6G/Nlus2dfzGtl59YGc5fzuNYhvu9AvB
        qRbDEqZMrO1FJTZJ/hmz65Fe2l9TP6SYxEo2+fZEohKeKZBAWzN9O20AgW9w9YTDZV/JATOhxLDHf
        whcuTUa/eNrI8PTm+P2Fjh8m01fuIyoNL+cRlxorXolkA6catoyPDIqd+RisPgKDU/uRkrj7hdRSO
        g3CAtvtmsaIA4H0tbZBdth5Kumvukfi6qUO85FnFyydP78jwmjMW7/Qm9ZWe0tLO19HYXWq+qVvTU
        rCQKLaIg==;
Received: from [88.128.92.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olPM0-00BJf8-Ts; Thu, 20 Oct 2022 06:48:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinlong Chen <nickyc975@zju.edu.cn>, linux-block@vger.kernel.org
Subject: [PATCH 3/4] block: check for an unchanged elevator earlier in __elevator_change
Date:   Thu, 20 Oct 2022 08:48:18 +0200
Message-Id: <20221020064819.1469928-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020064819.1469928-1-hch@lst.de>
References: <20221020064819.1469928-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jinlong Chen <nickyc975@zju.edu.cn>

No need to find the actual elevator_type struct for this comparism,
the name is all that is needed.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/elevator.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index b7f098f735b6b..887becfe6a8d4 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -755,16 +755,13 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 		return elevator_switch(q, NULL);
 	}
 
+	if (q->elevator && elevator_match(q->elevator->type, elevator_name, 0))
+		return 0;
+
 	e = elevator_get(q, elevator_name, true);
 	if (!e)
 		return -EINVAL;
 
-	if (q->elevator &&
-	    elevator_match(q->elevator->type, elevator_name, 0)) {
-		elevator_put(e);
-		return 0;
-	}
-
 	return elevator_switch(q, e);
 }
 
-- 
2.30.2

