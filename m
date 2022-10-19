Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D311760475C
	for <lists+linux-block@lfdr.de>; Wed, 19 Oct 2022 15:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiJSNhZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Oct 2022 09:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiJSNgn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 09:36:43 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F362192DA7;
        Wed, 19 Oct 2022 06:25:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.14.30.251])
        by mail-app4 (Coremail) with SMTP id cS_KCgBXfN+2+U9jC0NkBw--.17644S2;
        Wed, 19 Oct 2022 21:21:03 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jinlong Chen <nickyc975@zju.edu.cn>
Subject: [PATCH v2] blk-mq, elevator: pair up elevator_get and elevator_put to avoid refcnt problems
Date:   Wed, 19 Oct 2022 21:20:53 +0800
Message-Id: <20221019132053.3597239-1-nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgBXfN+2+U9jC0NkBw--.17644S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWUWFyfAr18JF4UJr1fJFb_yoWrCryxpr
        Z5Gws0krs8Kr4jqr4xAw17X34rCr929ry3XrZYk34Fkrs3Kr47J3W8KFy3ZF4UCr48AFsF
        qr48tayUJa4UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvS1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI
        7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAg0IB1Zdtb-z+AADsJ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The current reference management logic of io scheduler modules contains
refcnt problems. For example, blk_mq_init_sched may fail before or after
the calling of e->ops.init_sched. If it fails before the calling, it does
nothing to the reference to the io scheduler module. But if it fails after
the calling, it releases the reference by calling kobject_put(&eq->kobj).

As the callers of blk_mq_init_sched can't know exactly where the failure
happens, they can't handle the reference to the io scheduler module
properly: releasing the reference on failure results in double-release if
blk_mq_init_sched has released it, and not releasing the reference results
in ghost reference if blk_mq_init_sched did not release it either.

The same problem also exists in io schedulers' init_sched implementations.

We can address the problem by adding releasing statements to the error
handling procedures of blk_mq_init_sched and init_sched implementations.
But that is counterintuitive and requires modifications to existing io
schedulers.

Instead, We make elevator_alloc get the io scheduler module references
that will be released by elevator_release. And then, we match each
elevator_get with an elevator_put. Therefore, each reference to an io
scheduler module explicitly has its own getter and releaser, and we no
longer need to worry about the refcnt problems.

The bugs and the patch can be validated with tools here:
https://github.com/nickyc975/linux_elv_refcnt_bug.git

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
Changes in v2:
 - reword the commit message for clarity

 block/blk-mq.c   |  6 ++++++
 block/elevator.c | 29 ++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8070b6c10e8d..2adfd52786dc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4595,6 +4595,12 @@ static void blk_mq_elv_switch_back(struct list_head *head,
 
 	mutex_lock(&q->sysfs_lock);
 	elevator_switch(q, t);
+	/**
+	 * We got a reference of the io scheduler module in blk_mq_elv_switch_none
+	 * to prevent the module from being removed. We need to put that reference
+	 * back once we are done.
+	 */
+	module_put(t->elevator_owner);
 	mutex_unlock(&q->sysfs_lock);
 }
 
diff --git a/block/elevator.c b/block/elevator.c
index bd71f0fc4e4b..aaafd415f922 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -166,9 +166,12 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
 {
 	struct elevator_queue *eq;
 
+	if (!try_module_get(e->elevator_owner))
+		goto err_out;
+
 	eq = kzalloc_node(sizeof(*eq), GFP_KERNEL, q->node);
 	if (unlikely(!eq))
-		return NULL;
+		goto err_put_elevator;
 
 	eq->type = e;
 	kobject_init(&eq->kobj, &elv_ktype);
@@ -176,6 +179,11 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
 	hash_init(eq->hash);
 
 	return eq;
+
+err_put_elevator:
+	elevator_put(e);
+err_out:
+	return NULL;
 }
 EXPORT_SYMBOL(elevator_alloc);
 
@@ -713,8 +721,9 @@ void elevator_init_mq(struct request_queue *q)
 	if (err) {
 		pr_warn("\"%s\" elevator initialization failed, "
 			"falling back to \"none\"\n", e->elevator_name);
-		elevator_put(e);
 	}
+
+	elevator_put(e);
 }
 
 /*
@@ -747,6 +756,7 @@ static int __elevator_change(struct request_queue *q, const char *name)
 {
 	char elevator_name[ELV_NAME_MAX];
 	struct elevator_type *e;
+	int ret = 0;
 
 	/* Make sure queue is not in the middle of being removed */
 	if (!blk_queue_registered(q))
@@ -762,17 +772,18 @@ static int __elevator_change(struct request_queue *q, const char *name)
 	}
 
 	strlcpy(elevator_name, name, sizeof(elevator_name));
-	e = elevator_get(q, strstrip(elevator_name), true);
-	if (!e)
-		return -EINVAL;
-
 	if (q->elevator &&
-	    elevator_match(q->elevator->type, elevator_name, 0)) {
-		elevator_put(e);
+	    elevator_match(q->elevator->type, strstrip(elevator_name), 0)) {
 		return 0;
 	}
 
-	return elevator_switch(q, e);
+	e = elevator_get(q, strstrip(elevator_name), true);
+	if (!e)
+		return -EINVAL;
+
+	ret = elevator_switch(q, e);
+	elevator_put(e);
+	return ret;
 }
 
 ssize_t elv_iosched_store(struct request_queue *q, const char *name,
-- 
2.31.1

