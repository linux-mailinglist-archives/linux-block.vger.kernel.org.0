Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D403F98C8
	for <lists+linux-block@lfdr.de>; Fri, 27 Aug 2021 14:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245156AbhH0MHw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 27 Aug 2021 08:07:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3701 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245151AbhH0MHv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 08:07:51 -0400
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gwz1z4LpVz67g00;
        Fri, 27 Aug 2021 20:05:43 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 27 Aug 2021 14:07:00 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 27 Aug 2021 13:06:58 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <linux-scsi@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 06/13] blk-mq-sched: Rename blk_mq_sched_free_{requests -> rqs}()
Date:   Fri, 27 Aug 2021 20:01:57 +0800
Message-ID: <1630065724-69146-7-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1630065724-69146-1-git-send-email-john.garry@huawei.com>
References: <1630065724-69146-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To be more concise and consistent in naming, rename
blk_mq_sched_free_requests() -> blk_mq_sched_free_rqs().

Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/blk-core.c     | 2 +-
 block/blk-mq-sched.c | 6 +++---
 block/blk-mq-sched.h | 2 +-
 block/blk.h          | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 93b585593ebd..d8e36b08eb2b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -407,7 +407,7 @@ void blk_cleanup_queue(struct request_queue *q)
 	 */
 	mutex_lock(&q->sysfs_lock);
 	if (q->elevator)
-		blk_mq_sched_free_requests(q);
+		blk_mq_sched_free_rqs(q);
 	mutex_unlock(&q->sysfs_lock);
 
 	percpu_ref_exit(&q->q_usage_counter);
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 5f340203e6e5..3ab26154f0ea 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -631,7 +631,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 			ret = e->ops.init_hctx(hctx, i);
 			if (ret) {
 				eq = q->elevator;
-				blk_mq_sched_free_requests(q);
+				blk_mq_sched_free_rqs(q);
 				blk_mq_exit_sched(q, eq);
 				kobject_put(&eq->kobj);
 				return ret;
@@ -645,7 +645,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 err_free_sbitmap:
 	if (blk_mq_is_sbitmap_shared(q->tag_set->flags))
 		blk_mq_exit_sched_shared_sbitmap(q);
-	blk_mq_sched_free_requests(q);
+	blk_mq_sched_free_rqs(q);
 err_free_map_and_rqs:
 	blk_mq_sched_tags_teardown(q);
 	q->elevator = NULL;
@@ -656,7 +656,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
  * called in either blk_queue_cleanup or elevator_switch, tagset
  * is required for freeing requests
  */
-void blk_mq_sched_free_requests(struct request_queue *q)
+void blk_mq_sched_free_rqs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 1e46be6c5178..e70748d18754 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -28,7 +28,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
-void blk_mq_sched_free_requests(struct request_queue *q);
+void blk_mq_sched_free_rqs(struct request_queue *q);
 
 static inline bool
 blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
diff --git a/block/blk.h b/block/blk.h
index bbbcc1a64a2d..76c59ae436d8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -204,7 +204,7 @@ static inline void elevator_exit(struct request_queue *q,
 {
 	lockdep_assert_held(&q->sysfs_lock);
 
-	blk_mq_sched_free_requests(q);
+	blk_mq_sched_free_rqs(q);
 	__elevator_exit(q, e);
 }
 
-- 
2.26.2

