Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130CC2119AF
	for <lists+linux-block@lfdr.de>; Thu,  2 Jul 2020 03:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgGBBiF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Jul 2020 21:38:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6795 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbgGBBiF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Jul 2020 21:38:05 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B87F4352656D9B68CC44;
        Thu,  2 Jul 2020 09:38:03 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 09:37:53 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH -next] block: make function __bio_integrity_free() static
Date:   Thu, 2 Jul 2020 09:48:07 +0800
Message-ID: <20200702014807.32432-1-weiyongjun1@huawei.com>
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

From: Hulk Robot <hulkci@huawei.com>

Fix sparse build warning:

block/bio-integrity.c:27:6: warning:
 symbol '__bio_integrity_free' was not declared. Should it be static?

Signed-off-by: Hulk Robot <hulkci@huawei.com>
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

