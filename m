Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC52B4D1E
	for <lists+linux-block@lfdr.de>; Tue, 17 Sep 2019 13:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfIQLoJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Sep 2019 07:44:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53490 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726106AbfIQLoJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 07:44:09 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4D4FF57F123E32BD66FD;
        Tue, 17 Sep 2019 19:44:07 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 17 Sep 2019
 19:44:01 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH] rq-qos: get rid of redundant wbt_update_limits()
Date:   Tue, 17 Sep 2019 20:04:27 +0800
Message-ID: <20190917120427.15008-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have updated limits after calling wbt_set_min_lat(). No need to
update again.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-sysfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9bfa3ea4ed63..62d79916e429 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -482,7 +482,6 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 	blk_mq_quiesce_queue(q);
 
 	wbt_set_min_lat(q, val);
-	wbt_update_limits(q);
 
 	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q);
-- 
2.17.2

