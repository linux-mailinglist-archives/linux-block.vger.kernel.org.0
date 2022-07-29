Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5BA584CC0
	for <lists+linux-block@lfdr.de>; Fri, 29 Jul 2022 09:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiG2Hjz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 Jul 2022 03:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiG2Hjx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 03:39:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB9781B07
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 00:39:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LvK9y08NfzmVKB;
        Fri, 29 Jul 2022 15:37:58 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Jul
 2022 15:39:49 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
        <axboe@kernel.dk>, <lengchao@huawei.com>
Subject: [PATCH 1/3] blk-mq: delete unnecessary comments
Date:   Fri, 29 Jul 2022 15:39:46 +0800
Message-ID: <20220729073948.32696-2-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20220729073948.32696-1-lengchao@huawei.com>
References: <20220729073948.32696-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To improve the quiesce time when using a large set of namespaces, nvme
need using blk_mq_quiesce_queue_nowait directly.
Thus the comments for blk_mq_quiesce_queue_nowait is unnecessary,
so delete the comments.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 block/blk-mq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 92aae03103b7..6b525640009c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -238,10 +238,6 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
-/*
- * FIXME: replace the scsi_internal_device_*block_nowait() calls in the
- * mpt3sas driver such that this function can be removed.
- */
 void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 {
 	unsigned long flags;
-- 
2.16.4

