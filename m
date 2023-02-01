Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B20686736
	for <lists+linux-block@lfdr.de>; Wed,  1 Feb 2023 14:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjBANmQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Feb 2023 08:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjBANmM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2023 08:42:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B7F4942A;
        Wed,  1 Feb 2023 05:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9hT4YGzxdUMjI1G3k+P5k9XchTvCbH8X55QelLq/VlQ=; b=LxdpzbbthOrsOSDHET2Z6gcMzJ
        nRz65DWno1Kqv9CZu5RBedK+koImAtDOlb1rUxP7FJGs8Kps/pU26MR200llfhrMMcJNou5yCjk6q
        0LF+qQCpVPce7Xyg1wqu9yySj01kjv/YBprNSyWzUadhujUuYDWQc/1xwTEg4tCN67+5MnpporZC4
        0+SjH+2G8dda+oNM9vIhQN+b/Y5xB8DLJpYA2ymbtMJDaSrWH4rQ5Y4IEFVzD5ZFcUBH9gJ0aFYvr
        DATsB7DIbEvAps3HU6PqzPlQ+IubwDOutOkwGZ7vvn+wL7mtKTIDxCeBbV/z+zb2rulYD/5WT4NjB
        CuEzQh7Q==;
Received: from [2001:4bb8:19a:272a:3635:31c6:c223:d428] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNDNC-00C7Z5-7A; Wed, 01 Feb 2023 13:42:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 13/19] blk-rq-qos: make rq_qos_add and rq_qos_del more useful
Date:   Wed,  1 Feb 2023 14:41:17 +0100
Message-Id: <20230201134123.2656505-14-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230201134123.2656505-1-hch@lst.de>
References: <20230201134123.2656505-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Switch to passing a gendisk, and make rq_qos_add initialize all required
fields and drop the not required q argument from rq_qos_del.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
---
 block/blk-iocost.c    | 13 +++----------
 block/blk-iolatency.c | 14 ++++----------
 block/blk-rq-qos.c    | 13 ++++++++++---
 block/blk-rq-qos.h    |  5 +++--
 block/blk-wbt.c       |  5 +----
 5 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index dbb93f4f68d979..5f28463cba0afe 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2843,9 +2843,7 @@ static struct rq_qos_ops ioc_rqos_ops = {
 
 static int blk_iocost_init(struct gendisk *disk)
 {
-	struct request_queue *q = disk->queue;
 	struct ioc *ioc;
-	struct rq_qos *rqos;
 	int i, cpu, ret;
 
 	ioc = kzalloc(sizeof(*ioc), GFP_KERNEL);
@@ -2868,11 +2866,6 @@ static int blk_iocost_init(struct gendisk *disk)
 		local64_set(&ccs->rq_wait_ns, 0);
 	}
 
-	rqos = &ioc->rqos;
-	rqos->id = RQ_QOS_COST;
-	rqos->ops = &ioc_rqos_ops;
-	rqos->q = q;
-
 	spin_lock_init(&ioc->lock);
 	timer_setup(&ioc->timer, ioc_timer_fn, 0);
 	INIT_LIST_HEAD(&ioc->active_iocgs);
@@ -2896,17 +2889,17 @@ static int blk_iocost_init(struct gendisk *disk)
 	 * called before policy activation completion, can't assume that the
 	 * target bio has an iocg associated and need to test for NULL iocg.
 	 */
-	ret = rq_qos_add(q, rqos);
+	ret = rq_qos_add(&ioc->rqos, disk, RQ_QOS_COST, &ioc_rqos_ops);
 	if (ret)
 		goto err_free_ioc;
 
-	ret = blkcg_activate_policy(q, &blkcg_policy_iocost);
+	ret = blkcg_activate_policy(disk->queue, &blkcg_policy_iocost);
 	if (ret)
 		goto err_del_qos;
 	return 0;
 
 err_del_qos:
-	rq_qos_del(q, rqos);
+	rq_qos_del(&ioc->rqos);
 err_free_ioc:
 	free_percpu(ioc->pcpu_stat);
 	kfree(ioc);
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index b55eac2cf91944..1c394bd77aa0b4 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -757,24 +757,18 @@ static void blkiolatency_enable_work_fn(struct work_struct *work)
 
 int blk_iolatency_init(struct gendisk *disk)
 {
-	struct request_queue *q = disk->queue;
 	struct blk_iolatency *blkiolat;
-	struct rq_qos *rqos;
 	int ret;
 
 	blkiolat = kzalloc(sizeof(*blkiolat), GFP_KERNEL);
 	if (!blkiolat)
 		return -ENOMEM;
 
-	rqos = &blkiolat->rqos;
-	rqos->id = RQ_QOS_LATENCY;
-	rqos->ops = &blkcg_iolatency_ops;
-	rqos->q = q;
-
-	ret = rq_qos_add(q, rqos);
+	ret = rq_qos_add(&blkiolat->rqos, disk, RQ_QOS_LATENCY,
+			 &blkcg_iolatency_ops);
 	if (ret)
 		goto err_free;
-	ret = blkcg_activate_policy(q, &blkcg_policy_iolatency);
+	ret = blkcg_activate_policy(disk->queue, &blkcg_policy_iolatency);
 	if (ret)
 		goto err_qos_del;
 
@@ -784,7 +778,7 @@ int blk_iolatency_init(struct gendisk *disk)
 	return 0;
 
 err_qos_del:
-	rq_qos_del(q, rqos);
+	rq_qos_del(&blkiolat->rqos);
 err_free:
 	kfree(blkiolat);
 	return ret;
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index aae98dcb01ebe7..14bee1bd761362 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -295,8 +295,15 @@ void rq_qos_exit(struct request_queue *q)
 	}
 }
 
-int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
+int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
+		struct rq_qos_ops *ops)
 {
+	struct request_queue *q = disk->queue;
+
+	rqos->q = q;
+	rqos->id = id;
+	rqos->ops = ops;
+
 	/*
 	 * No IO can be in-flight when adding rqos, so freeze queue, which
 	 * is fine since we only support rq_qos for blk-mq queue.
@@ -326,11 +333,11 @@ int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
 	spin_unlock_irq(&q->queue_lock);
 	blk_mq_unfreeze_queue(q);
 	return -EBUSY;
-
 }
 
-void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
+void rq_qos_del(struct rq_qos *rqos)
 {
+	struct request_queue *q = rqos->q;
 	struct rq_qos **cur;
 
 	/*
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 805eee8b031d00..22552785aa31ed 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -85,8 +85,9 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 	init_waitqueue_head(&rq_wait->wait);
 }
 
-int rq_qos_add(struct request_queue *q, struct rq_qos *rqos);
-void rq_qos_del(struct request_queue *q, struct rq_qos *rqos);
+int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
+		struct rq_qos_ops *ops);
+void rq_qos_del(struct rq_qos *rqos);
 
 typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
 typedef void (cleanup_cb_t)(struct rq_wait *rqw, void *private_data);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 119a43671089ea..75565ae2775297 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -932,9 +932,6 @@ int wbt_init(struct gendisk *disk)
 	for (i = 0; i < WBT_NUM_RWQ; i++)
 		rq_wait_init(&rwb->rq_wait[i]);
 
-	rwb->rqos.id = RQ_QOS_WBT;
-	rwb->rqos.ops = &wbt_rqos_ops;
-	rwb->rqos.q = q;
 	rwb->last_comp = rwb->last_issue = jiffies;
 	rwb->win_nsec = RWB_WINDOW_NSEC;
 	rwb->enable_state = WBT_STATE_ON_DEFAULT;
@@ -947,7 +944,7 @@ int wbt_init(struct gendisk *disk)
 	/*
 	 * Assign rwb and add the stats callback.
 	 */
-	ret = rq_qos_add(q, &rwb->rqos);
+	ret = rq_qos_add(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
 	if (ret)
 		goto err_free;
 
-- 
2.39.0

