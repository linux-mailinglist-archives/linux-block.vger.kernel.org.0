Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33535258DE1
	for <lists+linux-block@lfdr.de>; Tue,  1 Sep 2020 14:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgIAMGI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Sep 2020 08:06:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728064AbgIAMAw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Sep 2020 08:00:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8217CE36630B98D27A37;
        Tue,  1 Sep 2020 20:00:42 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 20:00:33 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <axboe@kernel.dk>, <ebiggers@google.com>, <satyat@google.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] block: Fix potential NULL pointer dereference in __bio_crypt_clone()
Date:   Tue, 1 Sep 2020 07:59:21 -0400
Message-ID: <20200901115921.8926-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

mempool_alloc() may return NULL if __GFP_DIRECT_RECLAIM is not set in
gfp_mask under memory pressure. So we should check the return value of
mempool_alloc() against NULL before dereference.

Fixes: a892c8d52c02 ("block: Inline encryption support for blk-mq")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 block/blk-crypto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 2d5e60023b08..046aff85cfa3 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -98,7 +98,8 @@ void __bio_crypt_free_ctx(struct bio *bio)
 void __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask)
 {
 	dst->bi_crypt_context = mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
-	*dst->bi_crypt_context = *src->bi_crypt_context;
+	if (likely(dst->bi_crypt_context))
+		*dst->bi_crypt_context = *src->bi_crypt_context;
 }
 EXPORT_SYMBOL_GPL(__bio_crypt_clone);
 
-- 
2.19.1

