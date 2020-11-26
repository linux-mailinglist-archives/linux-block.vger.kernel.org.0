Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC0B2C5026
	for <lists+linux-block@lfdr.de>; Thu, 26 Nov 2020 09:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgKZIRW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Nov 2020 03:17:22 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:3019 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388814AbgKZIRU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:17:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UGaAtDg_1606378581;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UGaAtDg_1606378581)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Nov 2020 16:16:21 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] blk-iocost: Remove unnecessary advance declaration
Date:   Thu, 26 Nov 2020 16:16:12 +0800
Message-Id: <11d402aa9ac6cfc478a3b5a127c091cf50654cf8.1606378475.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
References: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
References: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove unnecessary advance declaration of struct ioc_gq.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Tejun Heo <tj@kernel.org>
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

