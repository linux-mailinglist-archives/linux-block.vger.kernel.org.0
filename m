Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2BC4E569C
	for <lists+linux-block@lfdr.de>; Wed, 23 Mar 2022 17:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiCWQjV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Mar 2022 12:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiCWQjV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 12:39:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5768B7A98C
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=F6ZxHPxQkAvi8SSVUYKhrpEuw9qJyFA484+C2OJlw/A=; b=NITVaSDWGrV/1DrTteZHrxloTL
        nROFEyiFJC0i67n8MQ4JcxQAC1rDz4GeGMLUtgJRof94ONvriQHlAPRFju1N//27fmHsgjk/BFW/c
        D0zv7Yz+PF4oPirZnA+eFO+qZ1PAuQ3IPqVCmwF2f8WEyctyJHSnK67odJ0COp3Slv6dWOmmI9A+V
        hYyt7pf4rOcj77vA1hpZWjOBNJsjQNSpqqcIu+yq+9MflLKiPjYyRv3wUGeMiiz05jvKSYQ9nMAFa
        X1AGR6GVmnjLR9RuMYnixB3DrrmeZbRpC1l++2m0sS2qa3nmzkMP8CZzrlaY0RAsLNh4GWy09GKEW
        bWfRP7HA==;
Received: from [2001:4bb8:19a:b822:f080:d126:bfe4:c36c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nX3za-00EHG0-JT; Wed, 23 Mar 2022 16:37:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 01/14] block: don't print I/O error warning for dead disks
Date:   Wed, 23 Mar 2022 17:37:35 +0100
Message-Id: <20220323163748.1526919-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

When a disk has been marked dead, don't print warnings for I/O errors
as they are very much expected.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8e659dc5fcf37..5b6a7c9d0d992 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -794,7 +794,8 @@ bool blk_update_request(struct request *req, blk_status_t error,
 #endif
 
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
-		     !(req->rq_flags & RQF_QUIET))) {
+		     !(req->rq_flags & RQF_QUIET)) &&
+		     !test_bit(GD_DEAD, &req->q->disk->state)) {
 		blk_print_req_error(req, error);
 		trace_block_rq_error(req, error, nr_bytes);
 	}
-- 
2.30.2

