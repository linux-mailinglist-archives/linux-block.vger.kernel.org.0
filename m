Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894C12880AF
	for <lists+linux-block@lfdr.de>; Fri,  9 Oct 2020 05:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgJIDX0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 8 Oct 2020 23:23:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14755 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729660AbgJIDX0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 23:23:26 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1B0CF66A123025B734D8;
        Fri,  9 Oct 2020 11:23:24 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 11:23:22 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>
Subject: [RESEND PATCH v2 3/7] block: use helper function to test queue register
Date:   Thu, 8 Oct 2020 23:26:29 -0400
Message-ID: <20201009032633.83645-4-yuyufen@huawei.com>
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

We have defined common interface blk_queue_registered() to
test QUEUE_FLAG_REGISTERED. Just use it.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-iocost.c | 2 +-
 block/elevator.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index d37b55db2409..24a4dedae207 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -618,7 +618,7 @@ static struct ioc *q_to_ioc(struct request_queue *q)
 
 static const char *q_name(struct request_queue *q)
 {
-	if (test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
+	if (blk_queue_registered(q))
 		return kobject_name(q->kobj.parent);
 	else
 		return "<unknown>";
diff --git a/block/elevator.c b/block/elevator.c
index b506895b34c7..431a2a1c896e 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -672,7 +672,7 @@ void elevator_init_mq(struct request_queue *q)
 	if (!elv_support_iosched(q))
 		return;
 
-	WARN_ON_ONCE(test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags));
+	WARN_ON_ONCE(blk_queue_registered(q));
 
 	if (unlikely(q->elevator))
 		return;
-- 
2.25.4

