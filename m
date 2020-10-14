Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3730B28E102
	for <lists+linux-block@lfdr.de>; Wed, 14 Oct 2020 15:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbgJNNHF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 14 Oct 2020 09:07:05 -0400
Received: from smtp.h3c.com ([60.191.123.50]:42096 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbgJNNHF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Oct 2020 09:07:05 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTPS id 09ED6ZUb097099
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 21:06:35 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 14 Oct 2020 21:06:38 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] blk-mq: add helper function to test hctx inactive
Date:   Wed, 14 Oct 2020 20:56:48 +0800
Message-ID: <20201014125648.13778-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 09ED6ZUb097099
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce helper function blk_mq_hctx_inactive() to test
BLK_MQ_S_INACTIVE as we already done for BLK_MQ_S_STOPPED.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 block/blk-mq-tag.c | 2 +-
 block/blk-mq.h     | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 32d82e23b..3119572bc 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -153,7 +153,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	 * Give up this allocation if the hctx is inactive.  The caller will
 	 * retry on an active hctx.
 	 */
-	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state))) {
+	if (unlikely(blk_mq_hctx_inactive(data->hctx))) {
 		blk_mq_put_tag(tags, data->ctx, tag + tag_offset);
 		return BLK_MQ_NO_TAG;
 	}
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 863a2f334..9813269c2 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -171,6 +171,11 @@ static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
 	return test_bit(BLK_MQ_S_STOPPED, &hctx->state);
 }
 
+static inline bool blk_mq_hctx_inactive(struct blk_mq_hw_ctx *hctx)
+{
+	return test_bit(BLK_MQ_S_INACTIVE, &hctx->state);
+}
+
 static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 {
 	return hctx->nr_ctx && hctx->tags;
-- 
2.17.1

