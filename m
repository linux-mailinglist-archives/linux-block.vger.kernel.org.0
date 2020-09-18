Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2DC26F79C
	for <lists+linux-block@lfdr.de>; Fri, 18 Sep 2020 10:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIRIDH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 18 Sep 2020 04:03:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13291 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726199AbgIRIDG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Sep 2020 04:03:06 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D9A8E786321B13A6CBB2;
        Fri, 18 Sep 2020 16:03:04 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 16:02:58 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>,
        <andy.lavr@gmail.com>, <yuyufen@huawei.com>
Subject: [PATCH v2 2/4] block: use common interface blk_queue_registered()
Date:   Fri, 18 Sep 2020 04:03:06 -0400
Message-ID: <20200918080308.2787773-3-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200918080308.2787773-1-yuyufen@huawei.com>
References: <20200918080308.2787773-1-yuyufen@huawei.com>
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

