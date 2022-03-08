Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4914D110B
	for <lists+linux-block@lfdr.de>; Tue,  8 Mar 2022 08:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241341AbiCHHe2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Mar 2022 02:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344498AbiCHHe2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 02:34:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A8BF34BA0
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 23:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646724811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SaSnakrvIg1TcmepQTEfT1E0waW5Hb47uVeuRo/lQfY=;
        b=C3XDxVRuAiaxxb+WGlJdHIvDuctxwvesdPB10dPh8YjnrEQ/HFqq4g4GgZptgSNNgb0EKr
        YHztH67QHwRqAwB541tDlk+Cq+cI5a8DwXGT2iJ3TCeRD2E53KfbAxXOuncTkpDF6/E/a/
        beZetcYSyf39P49cEykTSqTfis2bHgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-9-BPUllbPdS8KKDhBu10_A-1; Tue, 08 Mar 2022 02:33:27 -0500
X-MC-Unique: 9-BPUllbPdS8KKDhBu10_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A429F180FD74;
        Tue,  8 Mar 2022 07:33:26 +0000 (UTC)
Received: from localhost (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F15D01F413;
        Tue,  8 Mar 2022 07:33:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 5/6] blk-mq: prepare for implementing hctx table via xarray
Date:   Tue,  8 Mar 2022 15:32:18 +0800
Message-Id: <20220308073219.91173-6-ming.lei@redhat.com>
In-Reply-To: <20220308073219.91173-1-ming.lei@redhat.com>
References: <20220308073219.91173-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is inevitable to cause use-after-free on q->queue_hw_ctx between
queue_for_each_hw_ctx() and blk_mq_update_nr_hw_queues(). And converting
to xarray can fix the uaf, meantime code gets cleaner.

Prepare for converting q->queue_hctx_ctx into xarray, one thing is that
xa_for_each() can only accept 'unsigned long' as index, so changes type
of hctx index of queue_for_each_hw_ctx() into 'unsigned long'.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c        |  6 +++---
 block/blk-mq-sched.c          |  9 +++++----
 block/blk-mq-sysfs.c          | 16 ++++++++++------
 block/blk-mq-tag.c            |  2 +-
 block/blk-mq.c                | 30 ++++++++++++++++--------------
 drivers/block/rnbd/rnbd-clt.c |  2 +-
 6 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3a790eb4995c..e2880f6deb34 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -707,7 +707,7 @@ static void debugfs_create_files(struct dentry *parent, void *data,
 void blk_mq_debugfs_register(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
-	int i;
+	unsigned long i;
 
 	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
@@ -780,7 +780,7 @@ void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
 void blk_mq_debugfs_register_hctxs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
-	int i;
+	unsigned long i;
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_debugfs_register_hctx(q, hctx);
@@ -789,7 +789,7 @@ void blk_mq_debugfs_register_hctxs(struct request_queue *q)
 void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
-	int i;
+	unsigned long i;
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_debugfs_unregister_hctx(hctx);
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55488ba97823..e6ad8f761474 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -515,7 +515,7 @@ static void blk_mq_exit_sched_shared_tags(struct request_queue *queue)
 static void blk_mq_sched_tags_teardown(struct request_queue *q, unsigned int flags)
 {
 	struct blk_mq_hw_ctx *hctx;
-	int i;
+	unsigned long i;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->sched_tags) {
@@ -550,9 +550,10 @@ static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
 
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 {
-	unsigned int i, flags = q->tag_set->flags;
+	unsigned int flags = q->tag_set->flags;
 	struct blk_mq_hw_ctx *hctx;
 	struct elevator_queue *eq;
+	unsigned long i;
 	int ret;
 
 	if (!e) {
@@ -618,7 +619,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 void blk_mq_sched_free_rqs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
-	int i;
+	unsigned long i;
 
 	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
 		blk_mq_free_rqs(q->tag_set, q->sched_shared_tags,
@@ -635,7 +636,7 @@ void blk_mq_sched_free_rqs(struct request_queue *q)
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 {
 	struct blk_mq_hw_ctx *hctx;
-	unsigned int i;
+	unsigned long i;
 	unsigned int flags = 0;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 674786574075..c08426975856 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -206,7 +206,7 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
 void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
-	int i;
+	unsigned long i;
 
 	lockdep_assert_held(&q->sysfs_dir_lock);
 
@@ -255,7 +255,8 @@ void blk_mq_sysfs_init(struct request_queue *q)
 int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
-	int ret, i;
+	unsigned long i, j;
+	int ret;
 
 	WARN_ON_ONCE(!q->kobj.parent);
 	lockdep_assert_held(&q->sysfs_dir_lock);
@@ -278,8 +279,10 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 	return ret;
 
 unreg:
-	while (--i >= 0)
-		blk_mq_unregister_hctx(q->queue_hw_ctx[i]);
+	queue_for_each_hw_ctx(q, hctx, j) {
+		if (j < i)
+			blk_mq_unregister_hctx(hctx);
+	}
 
 	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(q->mq_kobj);
@@ -290,7 +293,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 void blk_mq_sysfs_unregister(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
-	int i;
+	unsigned long i;
 
 	mutex_lock(&q->sysfs_dir_lock);
 	if (!q->mq_sysfs_init_done)
@@ -306,7 +309,8 @@ void blk_mq_sysfs_unregister(struct request_queue *q)
 int blk_mq_sysfs_register(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
-	int i, ret = 0;
+	unsigned long i;
+	int ret = 0;
 
 	mutex_lock(&q->sysfs_dir_lock);
 	if (!q->mq_sysfs_init_done)
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 0fd409b8e86e..1850a4225e12 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -515,7 +515,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 		bt_for_each(NULL, q, btags, fn, priv, false);
 	} else {
 		struct blk_mq_hw_ctx *hctx;
-		int i;
+		unsigned long i;
 
 		queue_for_each_hw_ctx(q, hctx, i) {
 			struct blk_mq_tags *tags = hctx->tags;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 57ae9df0f4dc..bffdd71c670d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -312,7 +312,7 @@ EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 void blk_mq_wake_waiters(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
-	unsigned int i;
+	unsigned long i;
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		if (blk_mq_hw_queue_mapped(hctx))
@@ -1442,7 +1442,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 		container_of(work, struct request_queue, timeout_work);
 	unsigned long next = 0;
 	struct blk_mq_hw_ctx *hctx;
-	int i;
+	unsigned long i;
 
 	/* A deadlock might occur if a request is stuck requiring a
 	 * timeout at the same time a queue freeze is waiting
@@ -2143,7 +2143,7 @@ static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
 void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 {
 	struct blk_mq_hw_ctx *hctx, *sq_hctx;
-	int i;
+	unsigned long i;
 
 	sq_hctx = NULL;
 	if (blk_mq_has_sqsched(q))
@@ -2171,7 +2171,7 @@ EXPORT_SYMBOL(blk_mq_run_hw_queues);
 void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
 {
 	struct blk_mq_hw_ctx *hctx, *sq_hctx;
-	int i;
+	unsigned long i;
 
 	sq_hctx = NULL;
 	if (blk_mq_has_sqsched(q))
@@ -2209,7 +2209,7 @@ EXPORT_SYMBOL(blk_mq_delay_run_hw_queues);
 bool blk_mq_queue_stopped(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
-	int i;
+	unsigned long i;
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		if (blk_mq_hctx_stopped(hctx))
@@ -2248,7 +2248,7 @@ EXPORT_SYMBOL(blk_mq_stop_hw_queue);
 void blk_mq_stop_hw_queues(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
-	int i;
+	unsigned long i;
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_stop_hw_queue(hctx);
@@ -2266,7 +2266,7 @@ EXPORT_SYMBOL(blk_mq_start_hw_queue);
 void blk_mq_start_hw_queues(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
-	int i;
+	unsigned long i;
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_start_hw_queue(hctx);
@@ -2286,7 +2286,7 @@ EXPORT_SYMBOL_GPL(blk_mq_start_stopped_hw_queue);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async)
 {
 	struct blk_mq_hw_ctx *hctx;
-	int i;
+	unsigned long i;
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_start_stopped_hw_queue(hctx, async);
@@ -3446,7 +3446,7 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 		struct blk_mq_tag_set *set, int nr_queue)
 {
 	struct blk_mq_hw_ctx *hctx;
-	unsigned int i;
+	unsigned long i;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (i == nr_queue)
@@ -3637,7 +3637,8 @@ static void __blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 
 static void blk_mq_map_swqueue(struct request_queue *q)
 {
-	unsigned int i, j, hctx_idx;
+	unsigned int j, hctx_idx;
+	unsigned long i;
 	struct blk_mq_hw_ctx *hctx;
 	struct blk_mq_ctx *ctx;
 	struct blk_mq_tag_set *set = q->tag_set;
@@ -3744,7 +3745,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 {
 	struct blk_mq_hw_ctx *hctx;
-	int i;
+	unsigned long i;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (shared) {
@@ -3844,7 +3845,7 @@ static int blk_mq_alloc_ctxs(struct request_queue *q)
 void blk_mq_release(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx, *next;
-	int i;
+	unsigned long i;
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		WARN_ON_ONCE(hctx && list_empty(&hctx->hctx_list));
@@ -4362,7 +4363,8 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
-	int i, ret;
+	int ret;
+	unsigned long i;
 
 	if (!set)
 		return -EINVAL;
@@ -4738,7 +4740,7 @@ void blk_mq_cancel_work_sync(struct request_queue *q)
 {
 	if (queue_is_mq(q)) {
 		struct blk_mq_hw_ctx *hctx;
-		int i;
+		unsigned long i;
 
 		cancel_delayed_work_sync(&q->requeue_work);
 
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index c08971de369f..58304f978e10 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1343,7 +1343,7 @@ static inline void rnbd_init_hw_queue(struct rnbd_clt_dev *dev,
 
 static void rnbd_init_mq_hw_queues(struct rnbd_clt_dev *dev)
 {
-	int i;
+	unsigned long i;
 	struct blk_mq_hw_ctx *hctx;
 	struct rnbd_queue *q;
 
-- 
2.31.1

