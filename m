Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6354D0F7D
	for <lists+linux-block@lfdr.de>; Tue,  8 Mar 2022 06:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbiCHFxO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Mar 2022 00:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbiCHFxG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 00:53:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B1FC1C;
        Mon,  7 Mar 2022 21:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EhggpzGbDBqxfiiX/p0aj5KOXJOK0wNvzGJmqfILDUA=; b=bUNCPvDXO4TuisINGJNRLHkOst
        8zozLVvYn6lDsZNIW1gF2Z5YbOyDyZpCZ2+3SYpz1meXIqzbIn2uCQc7Tl6dHsOE7Mf/+IoCg+M0p
        prr14xV5YhN3srj2fZZplBWtjV/WCNNzcBcugADg4enjAeRA9u8mg1ykeuAiQ3G/lIE/m9A7U+K9J
        f8/ni76mCmjScQFVriFQflSIAoule4VzkyNpU6UUGUpv0vkxJo0/E24aDFDdwkxQp9ttjL62vDmOI
        68/iRAUBrNoCXFFAcJj+Vl/sP36Jbo1CTB3v55MOZr/3ntVW2YzYz0ESNuJXyg2sOptBYBvdcpO+B
        O/cUK7ow==;
Received: from [2001:4bb8:184:7746:6f50:7a98:3141:c37b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRSlT-002il0-BZ; Tue, 08 Mar 2022 05:52:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 02/14] blk-mq: handle already freed tags gracefully in blk_mq_free_rqs
Date:   Tue,  8 Mar 2022 06:51:48 +0100
Message-Id: <20220308055200.735835-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220308055200.735835-1-hch@lst.de>
References: <20220308055200.735835-1-hch@lst.de>
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

From: Ming Lei <ming.lei@redhat.com>

To simplify further changes allow for double calling blk_mq_free_rqs on
a queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
[hch: split out from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-mq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ab4b646551334..6fd0b0f652514 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3070,6 +3070,9 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	struct blk_mq_tags *drv_tags;
 	struct page *page;
 
+	if (list_empty(&tags->page_list))
+		return;
+
 	if (blk_mq_is_shared_tags(set->flags))
 		drv_tags = set->shared_tags;
 	else
-- 
2.30.2

