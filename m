Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C822724CD
	for <lists+linux-block@lfdr.de>; Mon, 21 Sep 2020 15:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgIUNKx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Sep 2020 09:10:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727426AbgIUNKp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:45 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EA8FCE349BEBA8CD73F2;
        Mon, 21 Sep 2020 21:10:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:10:35 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] rsxx: simplify the return expression of rsxx_save_config()
Date:   Mon, 21 Sep 2020 21:10:59 +0800
Message-ID: <20200921131059.92987-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/block/rsxx/config.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/block/rsxx/config.c b/drivers/block/rsxx/config.c
index 11ed1d964..c6de88186 100644
--- a/drivers/block/rsxx/config.c
+++ b/drivers/block/rsxx/config.c
@@ -84,7 +84,6 @@ static void config_data_cpu_to_le(struct rsxx_card_cfg *cfg)
 static int rsxx_save_config(struct rsxx_cardinfo *card)
 {
 	struct rsxx_card_cfg cfg;
-	int st;
 
 	memcpy(&cfg, &card->config, sizeof(cfg));
 
@@ -107,11 +106,7 @@ static int rsxx_save_config(struct rsxx_cardinfo *card)
 	config_data_swab(&cfg);
 	config_hdr_cpu_to_be(&cfg.hdr);
 
-	st = rsxx_creg_write(card, CREG_ADD_CONFIG, sizeof(cfg), &cfg, 1);
-	if (st)
-		return st;
-
-	return 0;
+	return rsxx_creg_write(card, CREG_ADD_CONFIG, sizeof(cfg), &cfg, 1);
 }
 
 int rsxx_load_config(struct rsxx_cardinfo *card)
-- 
2.23.0

