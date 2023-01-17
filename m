Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E8C66D7C4
	for <lists+linux-block@lfdr.de>; Tue, 17 Jan 2023 09:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbjAQIN4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Jan 2023 03:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbjAQIN2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 03:13:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA0B28868;
        Tue, 17 Jan 2023 00:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=D7iveQQJvLZA+RyWbRj86WCFcsszq3bZhAAbH9IGkEc=; b=uA1chXUQ+v2W3OmeiRzuWVlKkg
        f/WyGcEHq1NhAGU6r56rADizFFgjT7XRWDGH6jJGTTNcDg4y3GmF/8zFh/4gMQ80mRMFt6lGU09r/
        iWigeKjSPCVkAXT3tWvUn+tRSKcM8jiR57OpinaI20cGNkUYwfhvyyL4xfNRNzDFbpENDfP6i44v8
        5VngnNWra3VZqrKl+NLRCpr55UYwIwLy3DB2MexEoVHntblQrnSrd0bYLJIXC+sqDgb2XBs2TDsi4
        zS71e2rkLB6snN7H9vNOhdSEx4kxREs1FMhjPKcMn14Ow5GyI+FXDdIYWZqlyNxhzC7CJ6egbLVE6
        foTr/iIg==;
Received: from [2001:4bb8:19a:2039:eaa2:3b9e:be2e:bd2a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHh5t-00DHkV-LZ; Tue, 17 Jan 2023 08:13:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 08/15] blk-wbt: open code wbt_queue_depth_changed in wbt_update_limits
Date:   Tue, 17 Jan 2023 09:12:50 +0100
Message-Id: <20230117081257.3089859-9-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117081257.3089859-1-hch@lst.de>
References: <20230117081257.3089859-1-hch@lst.de>
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

No real need to all the method here, so open code to it to prepare
for some paramter passing changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-wbt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 542271fa99e8f7..473ae72befaf1a 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -863,9 +863,9 @@ int wbt_init(struct gendisk *disk)
 	rwb->enable_state = WBT_STATE_ON_DEFAULT;
 	rwb->wc = test_bit(QUEUE_FLAG_WC, &q->queue_flags);
 	rwb->rq_depth.default_depth = RWB_DEF_DEPTH;
+	rwb->rq_depth.queue_depth = blk_queue_depth(q);
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
-
-	wbt_queue_depth_changed(&rwb->rqos);
+	wbt_update_limits(rwb);
 
 	/*
 	 * Assign rwb and add the stats callback.
-- 
2.39.0

