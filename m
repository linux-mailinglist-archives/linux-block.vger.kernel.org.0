Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3670394AED
	for <lists+linux-block@lfdr.de>; Sat, 29 May 2021 09:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhE2Hgg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 29 May 2021 03:36:36 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:2345 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhE2Hgg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 May 2021 03:36:36 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FsY9n2YfNz1BFks;
        Sat, 29 May 2021 15:30:21 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 15:34:58 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 15:34:58 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-block@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH] block, bfq: remove the repeated declaration
Date:   Sat, 29 May 2021 15:34:49 +0800
Message-ID: <1622273689-14747-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Function 'bfq_entity_to_bfqq' is declared twice, so remove the
repeated declaration.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 block/bfq-iosched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 99c2a3cb081e..ab72fb1df74d 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -955,8 +955,6 @@ struct bfq_group {
 };
 #endif
 
-struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
-
 /* --------------- main algorithm interface ----------------- */
 
 #define BFQ_SERVICE_TREE_INIT	((struct bfq_service_tree)		\
-- 
2.7.4

