Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF60635E30
	for <lists+linux-block@lfdr.de>; Wed, 23 Nov 2022 13:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiKWMvt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Nov 2022 07:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238023AbiKWMv2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 07:51:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8047FF0B;
        Wed, 23 Nov 2022 04:44:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6459A61CB0;
        Wed, 23 Nov 2022 12:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146C1C43154;
        Wed, 23 Nov 2022 12:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669207456;
        bh=09ZYWzk9+I53RcxDP1NElPvoxKFt5KB7UxXSWWtfdKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hqSW1RlGFt52xPPVJIIQfRdFvRjSu2PlXfQ3+Xz4KXj4RRwL82kd9J7oa+TvMzbn+
         V+F+50uR+8CCsylP1P1lmhrDsuhhmCS81XwowZvnRJ0AtYUs8vwGaUQ6RwltXVHyZH
         +6gksAy1tyHuv9ym9jRmOVXoMWkUpWnedsLlNVGq4t9JPwK3OR6TBulG7z6zPPDJct
         R4e3nBH5eeqtZCmBKs5DThTk4Y0flzBVEm2P48VUKls5E44dEmuf4F7vmN3q7QsiT0
         50VzuQCRMFoBdd7i7qPrzDLwoaQSt5CeAAhHb+vkeZ5SrGGT62jFrj9pyNfTAMBszG
         OImOIUoaf1soQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 16/22] block: make blk_set_default_limits() private
Date:   Wed, 23 Nov 2022 07:43:31 -0500
Message-Id: <20221123124339.265912-16-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221123124339.265912-1-sashal@kernel.org>
References: <20221123124339.265912-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit b3228254bb6e91e57f920227f72a1a7d81925d81 ]

There are no external users of this function.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20221110184501.2451620-4-kbusch@meta.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-settings.c   | 1 -
 block/blk.h            | 1 +
 include/linux/blkdev.h | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index c3aa7f8ee388..6ae1ca626304 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -61,7 +61,6 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->misaligned = 0;
 	lim->zoned = BLK_ZONED_NONE;
 }
-EXPORT_SYMBOL(blk_set_default_limits);
 
 /**
  * blk_set_stacking_limits - set default limits for stacking devices
diff --git a/block/blk.h b/block/blk.h
index 997941cd999f..7d7a646bc6e1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -243,6 +243,7 @@ void blk_rq_set_mixed_merge(struct request *rq);
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio);
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio);
 
+void blk_set_default_limits(struct queue_limits *lim);
 int blk_dev_init(void);
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 98fdf5a31fd6..82270bf8e620 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1177,7 +1177,6 @@ extern void blk_queue_io_min(struct request_queue *q, unsigned int min);
 extern void blk_limits_io_opt(struct queue_limits *limits, unsigned int opt);
 extern void blk_queue_io_opt(struct request_queue *q, unsigned int opt);
 extern void blk_set_queue_depth(struct request_queue *q, unsigned int depth);
-extern void blk_set_default_limits(struct queue_limits *lim);
 extern void blk_set_stacking_limits(struct queue_limits *lim);
 extern int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			    sector_t offset);
-- 
2.35.1

