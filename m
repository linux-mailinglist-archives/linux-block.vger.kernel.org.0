Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4842C1C1F
	for <lists+linux-block@lfdr.de>; Tue, 24 Nov 2020 04:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgKXDeG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Nov 2020 22:34:06 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:44165 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726158AbgKXDdw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 22:33:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UGNJgeB_1606188829;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UGNJgeB_1606188829)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Nov 2020 11:33:49 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] blk-iocost: Remove unnecessary advance declaration
Date:   Tue, 24 Nov 2020 11:33:31 +0800
Message-Id: <aebd196113ec2086a92cb05c158c02591caa8079.1606186717.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove unnecessary advance declaration of struct ioc_gq.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-iocost.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 4ffde36..103ccbd 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -370,8 +370,6 @@ enum {
 	AUTOP_SSD_FAST,
 };
 
-struct ioc_gq;
-
 struct ioc_params {
 	u32				qos[NR_QOS_PARAMS];
 	u64				i_lcoefs[NR_I_LCOEFS];
-- 
1.8.3.1

