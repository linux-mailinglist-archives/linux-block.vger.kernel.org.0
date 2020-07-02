Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3451211B87
	for <lists+linux-block@lfdr.de>; Thu,  2 Jul 2020 07:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgGBFZh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 2 Jul 2020 01:25:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7342 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbgGBFZh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Jul 2020 01:25:37 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 266CEE8286B70C0E409A;
        Thu,  2 Jul 2020 13:25:35 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 13:25:28 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH -next v2] block: make function __bio_integrity_free() static
Date:   Thu, 2 Jul 2020 13:35:43 +0800
Message-ID: <20200702053543.29293-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix sparse build warning:

block/bio-integrity.c:27:6: warning:
 symbol '__bio_integrity_free' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
v1 -> v2: fix signed-off-by
---
 block/bio-integrity.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4707e90b8ee5..9ffd7e289554 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -24,7 +24,8 @@ void blk_flush_integrity(void)
 	flush_workqueue(kintegrityd_wq);
 }
 
-void __bio_integrity_free(struct bio_set *bs, struct bio_integrity_payload *bip)
+static void __bio_integrity_free(struct bio_set *bs,
+				 struct bio_integrity_payload *bip)
 {
 	if (bs && mempool_initialized(&bs->bio_integrity_pool)) {
 		if (bip->bip_vec)

