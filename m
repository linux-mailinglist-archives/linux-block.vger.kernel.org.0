Return-Path: <linux-block+bounces-21211-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275F5AA958A
	for <lists+linux-block@lfdr.de>; Mon,  5 May 2025 16:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BFA166F5E
	for <lists+linux-block@lfdr.de>; Mon,  5 May 2025 14:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5665625A349;
	Mon,  5 May 2025 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfrfEvxS"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4AB1F30A4
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454791; cv=none; b=FCdTG9LgwT5cfQryk1GD3SMj2wpe8dWyNDsKUicdrCmV3IfucU4TWlOjg24kXq+XICysUDvbRipp/8wt9I1q0lVJ/QTxxKIIK7GIDtZtBNuQjPZTl1At5TN2/vjOviSIrftFHsAnv0OY6wUfQ0sJbqVg08uIZmvxThutwpVfMww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454791; c=relaxed/simple;
	bh=y/gPz/k5FH+bcnDfrn84tBgeeKu9Moah0WDwCr7F5lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5uqjfMbTZARg/vY4azMCRsYEc6zNXWiH0tKrMip+kZFEY+zzEPVHrASv9j3/Xw/R6eCCL6DyXF6UXOKNau+Rl6KNlLH9DB5Ybu9oUdp2Oo2qwcTnFs2RQcPnueL/dWaLqFm69gHg8eZq8mk6BSiTPqd37gzs6uohyTbNQ2LwS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RfrfEvxS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VINQr94PrRS25BCud4cZPykqnI/VuDnhVQTeeMgDE2I=;
	b=RfrfEvxSbgFoUdphJLaotaZotQNNtp6CB3EY/nsXL8/6izV+egsewkyNjzr/EUSMDZY8h2
	pnP3Enj4hPxPsOFUlRyQ+9Exy8zzXoAjR0SuenPkr+1WNCbBBkDt4uQIwltId2s+yAM5VQ
	uW/T8VarFA7HONmm50ajC5WU7lF1GxA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-cK6kuny4PLGbR5TwivQHbw-1; Mon,
 05 May 2025 10:19:47 -0400
X-MC-Unique: cK6kuny4PLGbR5TwivQHbw-1
X-Mimecast-MFC-AGG-ID: cK6kuny4PLGbR5TwivQHbw_1746454786
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 048541800873;
	Mon,  5 May 2025 14:19:46 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A190D19560A3;
	Mon,  5 May 2025 14:19:44 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 21/25] block: move elv_register[unregister]_queue out of elevator_lock
Date: Mon,  5 May 2025 22:17:59 +0800
Message-ID: <20250505141805.2751237-22-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Move elv_register[unregister]_queue out of ->elevator_lock & queue freezing,
so we can kill many lockdep warnings.

elv_register[unregister]_queue() is serialized, and just dealing with sysfs/
debugfs things, no need to be done with queue frozen:

- when it is called from adding disk, elevator switch isn't possible
  because ->queue_kobj isn't added yet

- when it is called from deleting disk, disable_elv_switch() is
  responsible for preventing new elevator switch and draining old
  elevator switch.

- when it is called from blk_mq_update_nr_hw_queues(), adding/removing
  disk and elevator switch can't be allowed or in-progress

With this change, elevator's ->exit() is called before calling
elv_unregister_queue, then user may call into ->show()/store() of elevator's
sysfs attributes, and we have covered this issue by adding `ELEVATOR_FLAG_DYNG`.

For blk-mq debugfs, hctx->sched_tags is always checked with ->elevator_lock by
debugfs code, meantime hctx->sched_tags is updated with ->elevator_lock, so
there isn't such issue.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c   |  3 +--
 block/elevator.c | 68 ++++++++++++++++++++++++++++++++++++------------
 2 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 29f67b0e1fd5..d1b5b75840eb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5043,11 +5043,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_debugfs_register_hctxs(q);
 	}
 
+	/* elv_update_nr_hw_queues() unfreeze queue for us */
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		elv_update_nr_hw_queues(q);
 
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_unfreeze_queue_nomemrestore(q);
 	memalloc_noio_restore(memflags);
 
 	/* Free the excess tags when nr_hw_queues shrink. */
diff --git a/block/elevator.c b/block/elevator.c
index f7e333abefe3..8578b969e173 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -49,6 +49,11 @@
 struct elv_change_ctx {
 	const char *name;
 	bool no_uevent;
+
+	/* for unregistering old elevator */
+	struct elevator_queue *old;
+	/* for registering new elevator */
+	struct elevator_queue *new;
 };
 
 static DEFINE_SPINLOCK(elv_list_lock);
@@ -158,14 +163,14 @@ static void elevator_exit(struct request_queue *q)
 {
 	struct elevator_queue *e = q->elevator;
 
+	lockdep_assert_held(&q->elevator_lock);
+
 	ioc_clear_queue(q);
 	blk_mq_sched_free_rqs(q);
 
 	mutex_lock(&e->sysfs_lock);
 	blk_mq_exit_sched(q, e);
 	mutex_unlock(&e->sysfs_lock);
-
-	kobject_put(&e->kobj);
 }
 
 static inline void __elv_rqhash_del(struct request *rq)
@@ -466,8 +471,6 @@ static int elv_register_queue(struct request_queue *q,
 {
 	int error;
 
-	lockdep_assert_held(&q->elevator_lock);
-
 	error = kobject_add(&e->kobj, &q->disk->queue_kobj, "iosched");
 	if (!error) {
 		const struct elv_fs_entry *attr = e->type->elevator_attrs;
@@ -494,8 +497,6 @@ static int elv_register_queue(struct request_queue *q,
 static void elv_unregister_queue(struct request_queue *q,
 				 struct elevator_queue *e)
 {
-	lockdep_assert_held(&q->elevator_lock);
-
 	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
 		kobject_del(&e->kobj);
@@ -586,7 +587,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
-		elv_unregister_queue(q, q->elevator);
+		ctx->old = q->elevator;
 		elevator_exit(q);
 	}
 
@@ -594,11 +595,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 		ret = blk_mq_init_sched(q, new_e);
 		if (ret)
 			goto out_unfreeze;
-		ret = elv_register_queue(q, q->elevator, !ctx->no_uevent);
-		if (ret) {
-			elevator_exit(q);
-			goto out_unfreeze;
-		}
+		ctx->new = q->elevator;
 	} else {
 		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
 		q->elevator = NULL;
@@ -619,6 +616,38 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	return ret;
 }
 
+static void elv_exit_and_release(struct request_queue *q)
+{
+	struct elevator_queue *e;
+	unsigned memflags;
+
+	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->elevator_lock);
+	e = q->elevator;
+	elevator_exit(q);
+	mutex_unlock(&q->elevator_lock);
+	blk_mq_unfreeze_queue(q, memflags);
+	if (e)
+		kobject_put(&e->kobj);
+}
+
+static int elevator_change_done(struct request_queue *q,
+				struct elv_change_ctx *ctx)
+{
+	int ret = 0;
+
+	if (ctx->old) {
+		elv_unregister_queue(q, ctx->old);
+		kobject_put(&ctx->old->kobj);
+	}
+	if (ctx->new) {
+		ret = elv_register_queue(q, ctx->new, !ctx->no_uevent);
+		if (ret)
+			elv_exit_and_release(q);
+	}
+	return ret;
+}
+
 /*
  * Switch this queue to the given IO scheduler.
  */
@@ -645,6 +674,9 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 		ret = elevator_switch(q, ctx);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
+	if (!ret)
+		ret = elevator_change_done(q, ctx);
+
 	return ret;
 }
 
@@ -654,18 +686,22 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
  */
 void elv_update_nr_hw_queues(struct request_queue *q)
 {
+	struct elv_change_ctx ctx = {};
+	int ret = -ENODEV;
+
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 
 	mutex_lock(&q->elevator_lock);
 	if (q->elevator && !blk_queue_dying(q) && !blk_queue_registered(q)) {
-		struct elv_change_ctx ctx = {
-			.name = q->elevator->type->elevator_name,
-		};
+		ctx.name = q->elevator->type->elevator_name;
 
 		/* force to reattach elevator after nr_hw_queue is updated */
-		elevator_switch(q, &ctx);
+		ret = elevator_switch(q, &ctx);
 	}
 	mutex_unlock(&q->elevator_lock);
+	blk_mq_unfreeze_queue_nomemrestore(q);
+	if (!ret)
+		WARN_ON_ONCE(elevator_change_done(q, &ctx));
 }
 
 /*
-- 
2.47.0


