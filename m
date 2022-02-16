Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222454B8711
	for <lists+linux-block@lfdr.de>; Wed, 16 Feb 2022 12:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiBPLuD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Feb 2022 06:50:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiBPLt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 06:49:56 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD501CFA35;
        Wed, 16 Feb 2022 03:49:44 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y9so2187521pjf.1;
        Wed, 16 Feb 2022 03:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/PFb/0cBLQV+uKEKVqTk2arsQ0Wb2EWF5MUutWYpsZM=;
        b=qXP7n62Q8GDdHxpwO7YXTbt9kAPrkZZ8iujcpJeLAoWwV9XCvi1iB4Vvq+3ZSvkFb4
         StPfj/dRRWqkXYGCZh2r7Z62+dpP0pOqcY+b4Emb0sGF76rJpto7ldA5VJO0qmKGAuBU
         TvT7a3nY6i+9w8tKXmPe3YFKBWFpzWjqDjdce9i1qxrZiUAvOE4lXaWB4T2n72mIPdt5
         bhmFK1nmwZ3UdgxPWFApOGXTlWORByOc7XkkmemYUsRoe8LKjnHcqpqlm+7yUjou+RtZ
         k5o/YCjF1TTJ7U0G715siyHMl1bmI1skEcRXqKhV0L5OPSq+LJl9PeyIUr8QmH4gs7uQ
         n9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/PFb/0cBLQV+uKEKVqTk2arsQ0Wb2EWF5MUutWYpsZM=;
        b=LbdK/LD1CzTEbpE8c1ZbQaDqQOf2sbf+04JX4yrgq7I/mdqRr2QiUTquSWxYmW3bBC
         GRFfJ3dsXnXE4DawnQOu3mkMKgCtkyX/nJbMJTNrSvHwBWDBvKZ02CyGnpc8ViUIdIba
         2Pa4HPg3Qr2XadYLaPX/xLNveJIf4CRWgUiqj90KIZUtK4+G4F7vT1jt4Bc/G9OW3vg1
         ihYwgMoqk6UnLMBhY8az6Rwyaccx192a9MY1NoIokHFH4ibvWz3ovlf0rBevlnv0pNpI
         oiptAt2AEUbCpY28MLc03Ul3GJYqf+B9pmroCCEjgQQcsmJ/yUYsx5WbXIrpb27G+5Ro
         6Uvw==
X-Gm-Message-State: AOAM5326Ux5Claso5q7KkzMHD+adjuv3//2FkyBE7c0GB6cHn9yJQsIs
        yZ7M7xzkxLlOOwHCOUnrLxU=
X-Google-Smtp-Source: ABdhPJyOOIfs4iwf4ctUDaFKQGdjhuqAOMo3KCjAFd5ClE1lstGITqLEN+KprkpaOzo+SQ86BzaEZQ==
X-Received: by 2002:a17:90b:3e8c:b0:1b8:a738:9f84 with SMTP id rj12-20020a17090b3e8c00b001b8a7389f84mr1287270pjb.232.1645012183888;
        Wed, 16 Feb 2022 03:49:43 -0800 (PST)
Received: from localhost.localdomain ([61.16.102.69])
        by smtp.gmail.com with ESMTPSA id q1sm26209119pfs.112.2022.02.16.03.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:49:43 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V3 3/6] blk-iolatency: make iolatency pluggable
Date:   Wed, 16 Feb 2022 19:48:06 +0800
Message-Id: <20220216114809.84551-4-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220216114809.84551-1-jianchao.wan9@gmail.com>
References: <20220216114809.84551-1-jianchao.wan9@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make blk-iolatency pluggable. Then we can close or open it through
/sys/block/xxx/queue/qos.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-cgroup.c     |  6 ------
 block/blk-iolatency.c  | 33 +++++++++++++++++++++++++--------
 block/blk-mq-debugfs.c |  2 --
 block/blk-rq-qos.h     |  6 ------
 block/blk.h            |  6 ------
 5 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 650f7e27989f..3ae2aa557aef 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1203,12 +1203,6 @@ int blkcg_init_queue(struct request_queue *q)
 	if (ret)
 		goto err_destroy_all;
 
-	ret = blk_iolatency_init(q);
-	if (ret) {
-		blk_throtl_exit(q);
-		goto err_destroy_all;
-	}
-
 	return 0;
 
 err_destroy_all:
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 6593c7123b97..b0596a7a35f0 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -90,6 +90,12 @@ struct blk_iolatency {
 	atomic_t enabled;
 };
 
+static struct rq_qos_ops blkcg_iolatency_ops;
+static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
+{
+	return rq_qos_by_id(q, blkcg_iolatency_ops.id);
+}
+
 static inline struct blk_iolatency *BLKIOLATENCY(struct rq_qos *rqos)
 {
 	return container_of(rqos, struct blk_iolatency, rqos);
@@ -646,13 +652,18 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 
 	del_timer_sync(&blkiolat->timer);
 	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iolatency);
+	rq_qos_deactivate(rqos);
 	kfree(blkiolat);
 }
 
+static int blk_iolatency_init(struct request_queue *q);
 static struct rq_qos_ops blkcg_iolatency_ops = {
+	.name = "iolat",
+	.flags = RQOS_FLAG_CGRP_POL,
 	.throttle = blkcg_iolatency_throttle,
 	.done_bio = blkcg_iolatency_done_bio,
 	.exit = blkcg_iolatency_exit,
+	.init = blk_iolatency_init,
 };
 
 static void blkiolatency_timer_fn(struct timer_list *t)
@@ -727,15 +738,10 @@ int blk_iolatency_init(struct request_queue *q)
 		return -ENOMEM;
 
 	rqos = &blkiolat->rqos;
-	rqos->id = RQ_QOS_LATENCY;
-	rqos->ops = &blkcg_iolatency_ops;
-	rqos->q = q;
-
-	rq_qos_add(q, rqos);
-
+	rq_qos_activate(q, rqos, &blkcg_iolatency_ops);
 	ret = blkcg_activate_policy(q, &blkcg_policy_iolatency);
 	if (ret) {
-		rq_qos_del(q, rqos);
+		rq_qos_deactivate(rqos);
 		kfree(blkiolat);
 		return ret;
 	}
@@ -1046,12 +1052,23 @@ static struct blkcg_policy blkcg_policy_iolatency = {
 
 static int __init iolatency_init(void)
 {
-	return blkcg_policy_register(&blkcg_policy_iolatency);
+	int ret;
+
+	ret = rq_qos_register(&blkcg_iolatency_ops);
+	if (ret)
+		return ret;
+
+	ret = blkcg_policy_register(&blkcg_policy_iolatency);
+	if (ret)
+		rq_qos_unregister(&blkcg_iolatency_ops);
+
+	return ret;
 }
 
 static void __exit iolatency_exit(void)
 {
 	blkcg_policy_unregister(&blkcg_policy_iolatency);
+	rq_qos_unregister(&blkcg_iolatency_ops);
 }
 
 module_init(iolatency_init);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 5094c2d3700a..ec1f74bdea74 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -826,8 +826,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 static const char *rq_qos_id_to_name(enum rq_qos_id id)
 {
 	switch (id) {
-	case RQ_QOS_LATENCY:
-		return "latency";
 	case RQ_QOS_COST:
 		return "cost";
 	case RQ_QOS_IOPRIO:
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 171a83d6de45..2a919db52fef 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -14,7 +14,6 @@
 struct blk_mq_debugfs_attr;
 
 enum rq_qos_id {
-	RQ_QOS_LATENCY,
 	RQ_QOS_COST,
 	RQ_QOS_IOPRIO,
 };
@@ -95,11 +94,6 @@ static inline struct rq_qos *rq_qos_by_id(struct request_queue *q, int id)
 	return rqos;
 }
 
-static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
-{
-	return rq_qos_id(q, RQ_QOS_LATENCY);
-}
-
 static inline void rq_wait_init(struct rq_wait *rq_wait)
 {
 	atomic_set(&rq_wait->inflight, 0);
diff --git a/block/blk.h b/block/blk.h
index 8bd43b3ad33d..1a314257b6a3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -400,12 +400,6 @@ static inline void blk_queue_bounce(struct request_queue *q, struct bio **bio)
 		__blk_queue_bounce(q, bio);	
 }
 
-#ifdef CONFIG_BLK_CGROUP_IOLATENCY
-extern int blk_iolatency_init(struct request_queue *q);
-#else
-static inline int blk_iolatency_init(struct request_queue *q) { return 0; }
-#endif
-
 struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp);
 
 #ifdef CONFIG_BLK_DEV_ZONED
-- 
2.17.1

