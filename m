Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223142880AE
	for <lists+linux-block@lfdr.de>; Fri,  9 Oct 2020 05:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgJIDX0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 8 Oct 2020 23:23:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729593AbgJIDX0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 23:23:26 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 16F4CB4E61498A36C986;
        Fri,  9 Oct 2020 11:23:24 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 11:23:22 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>
Subject: [RESEND PATCH v2 2/7] block: remove redundant mq check
Date:   Thu, 8 Oct 2020 23:26:28 -0400
Message-ID: <20201009032633.83645-3-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201009032633.83645-1-yuyufen@huawei.com>
References: <20201009032633.83645-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
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
index 7d76b61e157a..b506895b34c7 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -615,7 +615,7 @@ int elevator_switch_mq(struct request_queue *q,
 
 static inline bool elv_support_iosched(struct request_queue *q)
 {
-	if (!q->mq_ops ||
+	if (!queue_is_mq(q) ||
 	    (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED)))
 		return false;
 	return true;
@@ -763,7 +763,7 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 {
 	int ret;
 
-	if (!queue_is_mq(q) || !elv_support_iosched(q))
+	if (!elv_support_iosched(q))
 		return count;
 
 	ret = __elevator_change(q, name);
-- 
2.25.4

