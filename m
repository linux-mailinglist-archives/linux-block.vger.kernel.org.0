Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC04261EAD8
	for <lists+linux-block@lfdr.de>; Mon,  7 Nov 2022 07:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKGGRP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 7 Nov 2022 01:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiKGGRO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 01:17:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBFD101CE
        for <linux-block@vger.kernel.org>; Sun,  6 Nov 2022 22:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HLfO/iwe9Ln5f/q4JkcbiR4l389VnqS1ymF7ZDIO2do=; b=o/mKKkybpWaB+qoIyWZ1QIG7an
        5lBYPxJelxF7qRLFQxP2vHi6rfRrITqPgFG4BuUkK1UkovsrL5EMZ6TfUi/UDkel4WxpQXbf4t41I
        P8Ey1wyOY7aUS1gmBo94okd8v21faMQYuToNoo9O8ZLS6dNORcO/6teo3wu6AoYv5bJf3RWktK1ZW
        TR0L/ySlYPOvu8juvRj2U76+V0+yqu2g9Hy+K/sWwPkzezgf5f55gcN9cCqE398KYLjyiPOygP52l
        ScJWV8w6mx7eZh3bhD/KwJ2v0KZqoa39IEdq+JmKt5I3vlEbETm3T6EgVP8l9OgDK0SVx+WGnNYpK
        OuGEFdng==;
Received: from [2001:4bb8:191:2450:bd6a:c86c:b287:8b99] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1orvRV-00C6SB-0l; Mon, 07 Nov 2022 06:17:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: remove blk_mq_alloc_tag_set_tags
Date:   Mon,  7 Nov 2022 07:17:06 +0100
Message-Id: <20221107061706.1269999-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a trivial wrapper with a single caller, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7ff3415c8eadc..d26238f0de323 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4403,12 +4403,6 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 	return 0;
 }
 
-static int blk_mq_alloc_tag_set_tags(struct blk_mq_tag_set *set,
-				int new_nr_hw_queues)
-{
-	return blk_mq_realloc_tag_set_tags(set, 0, new_nr_hw_queues);
-}
-
 /*
  * Alloc a tag set to be associated with one or more request queues.
  * May fail with EINVAL for various error conditions. May adjust the
@@ -4471,7 +4465,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 			goto out_free_srcu;
 	}
 
-	ret = blk_mq_alloc_tag_set_tags(set, set->nr_hw_queues);
+	ret = blk_mq_realloc_tag_set_tags(set, 0, set->nr_hw_queues);
 	if (ret)
 		goto out_cleanup_srcu;
 
-- 
2.30.2

