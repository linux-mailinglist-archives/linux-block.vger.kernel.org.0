Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C273C54C4FA
	for <lists+linux-block@lfdr.de>; Wed, 15 Jun 2022 11:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiFOJrq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Jun 2022 05:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344435AbiFOJro (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 05:47:44 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CB724097
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 02:47:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VGSOOZl_1655286442;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VGSOOZl_1655286442)
          by smtp.aliyun-inc.com;
          Wed, 15 Jun 2022 17:47:41 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: adjust the judgment order in submit_bio
Date:   Wed, 15 Jun 2022 17:47:22 +0800
Message-Id: <1655286442-104784-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

BIO_WORKINGSET is rarer than read, so adjust to the first one to judge.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 block/blk-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 06ff5bb..7b6809b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -901,8 +901,8 @@ void submit_bio(struct bio *bio)
 	 * the submitting cgroup IO-throttled, submission can be a significant
 	 * part of overall IO time.
 	 */
-	if (unlikely(bio_op(bio) == REQ_OP_READ &&
-	    bio_flagged(bio, BIO_WORKINGSET))) {
+	if (unlikely(bio_flagged(bio, BIO_WORKINGSET) &&
+		bio_op(bio) == REQ_OP_READ)) {
 		unsigned long pflags;
 
 		psi_memstall_enter(&pflags);
-- 
1.8.3.1

