Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E464BFAA3
	for <lists+linux-block@lfdr.de>; Tue, 22 Feb 2022 15:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiBVOP1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Feb 2022 09:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiBVOPZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 09:15:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72702160412;
        Tue, 22 Feb 2022 06:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3obkjTecc+tBmDXw3y9QiE7nas6q/YaXMeQ/pRJ2RoA=; b=eB0uobuHJiWfSO6bM0iNGxQ93z
        wrvg4nDEpMMfmcIydF8pVuMR3o+OoposoBfj9A8XkEWVSyyQCYS/l9Gatp9YI1IFq0nIw6eySWPUs
        seMO06kHSN0clHh1U9ji0DWPEQUwyICdC3o1ArQIUbw9UIwQjWT8rTqENqFi7jUGn2vMkQmh5noCU
        BIzaWgme7VEduQn0QMQ2FqEhRa7EsgJx1Y3xWw45M8WToy2FhJodq/mo3lyyib7TUWFazc6VtNbqR
        q5dEI9UyjEv6qsqub9qbEOxYRe31X/bngkkbr1jtSqHiA1Gy0tq2/O8k5si/7HipK57YUGjb7w1f/
        QfZ/Gocg==;
Received: from [2001:4bb8:198:f8fc:c22a:ebfc:be8d:63c2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMVwP-009qD8-JW; Tue, 22 Feb 2022 14:14:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 02/12] blk-mq: handle already freed tags gracefully in blk_mq_free_rqs
Date:   Tue, 22 Feb 2022 15:14:40 +0100
Message-Id: <20220222141450.591193-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222141450.591193-1-hch@lst.de>
References: <20220222141450.591193-1-hch@lst.de>
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
---
 block/blk-mq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ee80853473d1e..63e2d3fd60946 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3061,6 +3061,9 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
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

