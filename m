Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A122880AC
	for <lists+linux-block@lfdr.de>; Fri,  9 Oct 2020 05:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbgJIDX0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 8 Oct 2020 23:23:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14757 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730078AbgJIDX0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 23:23:26 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 22EB0D0E36ABE8CA138D;
        Fri,  9 Oct 2020 11:23:24 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 11:23:21 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>
Subject: [RESEND PATCH v2 1/7] block: invoke blk_mq_exit_sched no matter whether have .exit_sched
Date:   Thu, 8 Oct 2020 23:26:27 -0400
Message-ID: <20201009032633.83645-2-yuyufen@huawei.com>
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

We will register debugfs for scheduler no matter whether it have
defined callback funciton .exit_sched. So, blk_mq_exit_sched()
is always needed to unregister debugfs. Also, q->elevator should
be set as NULL after exiting scheduler.

For now, since all register scheduler have defined .exit_sched,
it will not cause any actual problem. But It will be more reasonable
to do this change.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-sysfs.c | 1 -
 block/elevator.c  | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 7dda709f3ccb..ee2cd4d1054c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -883,7 +883,6 @@ static void blk_exit_queue(struct request_queue *q)
 	if (q->elevator) {
 		ioc_clear_queue(q);
 		__elevator_exit(q, q->elevator);
-		q->elevator = NULL;
 	}
 
 	/*
diff --git a/block/elevator.c b/block/elevator.c
index 90ed7a28c21d..7d76b61e157a 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -191,8 +191,7 @@ static void elevator_release(struct kobject *kobj)
 void __elevator_exit(struct request_queue *q, struct elevator_queue *e)
 {
 	mutex_lock(&e->sysfs_lock);
-	if (e->type->ops.exit_sched)
-		blk_mq_exit_sched(q, e);
+	blk_mq_exit_sched(q, e);
 	mutex_unlock(&e->sysfs_lock);
 
 	kobject_put(&e->kobj);
-- 
2.25.4

