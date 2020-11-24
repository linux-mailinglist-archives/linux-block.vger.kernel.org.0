Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136862C1C15
	for <lists+linux-block@lfdr.de>; Tue, 24 Nov 2020 04:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgKXDdx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Nov 2020 22:33:53 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:36537 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727161AbgKXDdx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 22:33:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UGN.XXZ_1606188830;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UGN.XXZ_1606188830)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Nov 2020 11:33:50 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] blk-iocost: Just open code the q_name()
Date:   Tue, 24 Nov 2020 11:33:32 +0800
Message-Id: <3bdc9526ac839a6952db8cd50cf0e75280614b1d.1606186717.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The simple q_name() function is only called from ioc_name(),
just open code it to make code more readable.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-iocost.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 103ccbd..089f3fe 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -665,17 +665,14 @@ static struct ioc *q_to_ioc(struct request_queue *q)
 	return rqos_to_ioc(rq_qos_id(q, RQ_QOS_COST));
 }
 
-static const char *q_name(struct request_queue *q)
+static const char __maybe_unused *ioc_name(struct ioc *ioc)
 {
+	struct request_queue *q = ioc->rqos.q;
+
 	if (blk_queue_registered(q))
 		return kobject_name(q->kobj.parent);
-	else
-		return "<unknown>";
-}
 
-static const char __maybe_unused *ioc_name(struct ioc *ioc)
-{
-	return q_name(ioc->rqos.q);
+	return "<unknown>";
 }
 
 static struct ioc_gq *pd_to_iocg(struct blkg_policy_data *pd)
-- 
1.8.3.1

