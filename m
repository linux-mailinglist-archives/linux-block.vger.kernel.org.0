Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78711F92F4
	for <lists+linux-block@lfdr.de>; Mon, 15 Jun 2020 11:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgFOJMt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 15 Jun 2020 05:12:49 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:54735 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728865AbgFOJMt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 05:12:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U.bnhqt_1592212365;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U.bnhqt_1592212365)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Jun 2020 17:12:46 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, baolin.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: Remove redundant 'return' statement
Date:   Mon, 15 Jun 2020 17:12:23 +0800
Message-Id: <a93d3ae2b37c01bc1d30b0eb229241b81405e6ad.1592212094.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The blk_mq_all_tag_iter() is a void function, thus remove
the redundant 'return' statement in this function.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-mq-tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 44f3d09..ae722f8 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -376,7 +376,7 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
 void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv)
 {
-	return __blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
+	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
 }
 
 /**
-- 
1.8.3.1

