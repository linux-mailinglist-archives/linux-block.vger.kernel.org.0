Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324C026C9D9
	for <lists+linux-block@lfdr.de>; Wed, 16 Sep 2020 21:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgIPTad (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Sep 2020 15:30:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12794 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727730AbgIPT0V (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Sep 2020 15:26:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C4B6EEB80041F2ECA3F6;
        Wed, 16 Sep 2020 19:17:09 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 19:17:06 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH] block: remove redundant mq check
Date:   Wed, 16 Sep 2020 07:17:12 -0400
Message-ID: <20200916111712.4011701-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

elv_support_iosched() will check queue_is_mq() for us. So, remove
the redundant check to clean code.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/elevator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index f0db80fec5a4..b564129a9f2d 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -616,7 +616,7 @@ int elevator_switch_mq(struct request_queue *q,
 
 static inline bool elv_support_iosched(struct request_queue *q)
 {
-	if (!q->mq_ops ||
+	if (!queue_is_mq(q) ||
 	    (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED)))
 		return false;
 	return true;
@@ -764,7 +764,7 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 {
 	int ret;
 
-	if (!queue_is_mq(q) || !elv_support_iosched(q))
+	if (!elv_support_iosched(q))
 		return count;
 
 	ret = __elevator_change(q, name);
-- 
2.25.4

