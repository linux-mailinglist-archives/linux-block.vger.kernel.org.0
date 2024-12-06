Return-Path: <linux-block+bounces-14957-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45B99E686E
	for <lists+linux-block@lfdr.de>; Fri,  6 Dec 2024 09:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8499C16A558
	for <lists+linux-block@lfdr.de>; Fri,  6 Dec 2024 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294C11DC19D;
	Fri,  6 Dec 2024 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4i1byS8"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0D328B6
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472405; cv=none; b=DVI1WgZwRB6KM7MnpgnIl2UYlYdsKMP24jRpj4G2A8WGxK7C7dQswtHHupB42Ruc8ymC575ZaX5XGyqi9qCmexIdQE96uitAnGnHXXlhbefVB3tkeOa0mET0FJCp9SO3iNtLZW8TRslpjSNAAm2wjzJ2gBlHAlYWQh0Ra5b9VIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472405; c=relaxed/simple;
	bh=CUZtKVsBMN6zZXCJ1D/I6eGBeadBE+KPdYYFfUqcQoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uK7iiaCEuLoGIejPN1lkSdVagTTnSCZ/9/MLl/ke85mnLkPJSZOFoHrG3Vb7+5zwiSqjETZNwE90X+zRmZ3/FaIUSFgjnv18nVrAaJUX3ovMCuEG0gYQUjPnA5LLDjNk08Iaxqne4igPh2Z1ZWsy5i1KShRsEADkFRj+h7Gn7XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4i1byS8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733472400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YZnRPu0zVPCYOpvT+/enxeT0EosgA0YAwFoJBwDT9WY=;
	b=X4i1byS8x7E0xFG0Uj8ToqXmHimdyvU9ssN/J7G0BC7OhH0w0qzw4v5XTkI+ifcNC7d9tM
	m3twbVE42t4rI+yZDbCghJKuQGy0lRW1YGNlNbs5GEuaaGpgBl7FvDBNSLKLgzLK0h5gF1
	zKwXhIcV1OjNJ6fkD23B9MrtjY2Leko=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-ZE4GzzTNMoCWT3SqXumHvg-1; Fri,
 06 Dec 2024 03:06:39 -0500
X-MC-Unique: ZE4GzzTNMoCWT3SqXumHvg-1
X-Mimecast-MFC-AGG-ID: ZE4GzzTNMoCWT3SqXumHvg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 680111954AFF;
	Fri,  6 Dec 2024 08:06:37 +0000 (UTC)
Received: from localhost (unknown [10.72.112.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 270361954200;
	Fri,  6 Dec 2024 08:06:35 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>,
	Babu Moger <babu.moger@amd.com>,
	Luck Tony <tony.luck@intel.com>
Subject: [PATCH] blk-mq: move cpuhp callback registering out of q->sysfs_lock
Date: Fri,  6 Dec 2024 16:06:22 +0800
Message-ID: <20241206080622.942110-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Registering and unregistering cpuhp requires global cpu hotplug lock,
which is used everywhere. Meantime q->sysfs_lock is used in block layer
almost everywhere.

It is easy to trigger lockdep warning[1] by connecting the two locks.

Fix the warning by moving blk-mq's cpuhp callback registering out of
q->sysfs_lock. Add one dedicated global lock for covering registering &
unregistering hctx's cpuhp, and it is safe to do so because hctx is
guaranteed to be live if our request_queue is live.

[1] https://lore.kernel.org/lkml/Z04pz3AlvI4o0Mr8@agluck-desk3/

Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Peter Newman <peternewman@google.com>
Cc: Babu Moger <babu.moger@amd.com>
Reported-by: Luck Tony <tony.luck@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 103 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a404465036de..aa340b097b6e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -43,6 +43,7 @@
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
+static DEFINE_MUTEX(blk_mq_cpuhp_lock);
 
 static void blk_mq_insert_request(struct request *rq, blk_insert_t flags);
 static void blk_mq_request_bypass_insert(struct request *rq,
@@ -3739,13 +3740,91 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
-static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
+static void __blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
 {
-	if (!(hctx->flags & BLK_MQ_F_STACKING))
+	lockdep_assert_held(&blk_mq_cpuhp_lock);
+
+	if (!(hctx->flags & BLK_MQ_F_STACKING) &&
+	    !hlist_unhashed(&hctx->cpuhp_online)) {
 		cpuhp_state_remove_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
 						    &hctx->cpuhp_online);
-	cpuhp_state_remove_instance_nocalls(CPUHP_BLK_MQ_DEAD,
-					    &hctx->cpuhp_dead);
+		INIT_HLIST_NODE(&hctx->cpuhp_online);
+	}
+
+	if (!hlist_unhashed(&hctx->cpuhp_dead)) {
+		cpuhp_state_remove_instance_nocalls(CPUHP_BLK_MQ_DEAD,
+						    &hctx->cpuhp_dead);
+		INIT_HLIST_NODE(&hctx->cpuhp_dead);
+	}
+}
+
+static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
+{
+	mutex_lock(&blk_mq_cpuhp_lock);
+	__blk_mq_remove_cpuhp(hctx);
+	mutex_unlock(&blk_mq_cpuhp_lock);
+}
+
+static void __blk_mq_add_cpuhp(struct blk_mq_hw_ctx *hctx)
+{
+	lockdep_assert_held(&blk_mq_cpuhp_lock);
+
+	if (!(hctx->flags & BLK_MQ_F_STACKING) &&
+	    hlist_unhashed(&hctx->cpuhp_online))
+		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+				&hctx->cpuhp_online);
+
+	if (hlist_unhashed(&hctx->cpuhp_dead))
+		cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD,
+				&hctx->cpuhp_dead);
+}
+
+static void __blk_mq_remove_cpuhp_list(struct list_head *head)
+{
+	struct blk_mq_hw_ctx *hctx;
+
+	lockdep_assert_held(&blk_mq_cpuhp_lock);
+
+	list_for_each_entry(hctx, head, hctx_list)
+		__blk_mq_remove_cpuhp(hctx);
+}
+
+/*
+ * Unregister cpuhp callbacks from exited hw queues
+ *
+ * Safe to call if this `request_queue` is live
+ */
+static void blk_mq_remove_hw_queues_cpuhp(struct request_queue *q)
+{
+	LIST_HEAD(hctx_list);
+
+	spin_lock(&q->unused_hctx_lock);
+	list_splice_init(&q->unused_hctx_list, &hctx_list);
+	spin_unlock(&q->unused_hctx_lock);
+
+	mutex_lock(&blk_mq_cpuhp_lock);
+	__blk_mq_remove_cpuhp_list(&hctx_list);
+	mutex_unlock(&blk_mq_cpuhp_lock);
+
+	spin_lock(&q->unused_hctx_lock);
+	list_splice(&hctx_list, &q->unused_hctx_list);
+	spin_unlock(&q->unused_hctx_lock);
+}
+
+/*
+ * Register cpuhp callbacks from all hw queues
+ *
+ * Safe to call if this `request_queue` is live
+ */
+static void blk_mq_add_hw_queues_cpuhp(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long i;
+
+	mutex_lock(&blk_mq_cpuhp_lock);
+	queue_for_each_hw_ctx(q, hctx, i)
+		__blk_mq_add_cpuhp(hctx);
+	mutex_unlock(&blk_mq_cpuhp_lock);
 }
 
 /*
@@ -3796,8 +3875,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
 
-	blk_mq_remove_cpuhp(hctx);
-
 	xa_erase(&q->hctx_table, hctx_idx);
 
 	spin_lock(&q->unused_hctx_lock);
@@ -3814,6 +3891,7 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (i == nr_queue)
 			break;
+		blk_mq_remove_cpuhp(hctx);
 		blk_mq_exit_hctx(q, set, hctx, i);
 	}
 }
@@ -3837,11 +3915,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (xa_insert(&q->hctx_table, hctx_idx, hctx, GFP_KERNEL))
 		goto exit_flush_rq;
 
-	if (!(hctx->flags & BLK_MQ_F_STACKING))
-		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
-				&hctx->cpuhp_online);
-	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
-
 	return 0;
 
  exit_flush_rq:
@@ -3876,6 +3949,8 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	INIT_DELAYED_WORK(&hctx->run_work, blk_mq_run_work_fn);
 	spin_lock_init(&hctx->lock);
 	INIT_LIST_HEAD(&hctx->dispatch);
+	INIT_HLIST_NODE(&hctx->cpuhp_dead);
+	INIT_HLIST_NODE(&hctx->cpuhp_online);
 	hctx->queue = q;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_QUEUE_SHARED;
 
@@ -4414,6 +4489,12 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	xa_for_each_start(&q->hctx_table, j, hctx, j)
 		blk_mq_exit_hctx(q, set, hctx, j);
 	mutex_unlock(&q->sysfs_lock);
+
+	/* unregister cpuhp callbacks for exited hctxs */
+	blk_mq_remove_hw_queues_cpuhp(q);
+
+	/* register cpuhp for new initialized hctxs */
+	blk_mq_add_hw_queues_cpuhp(q);
 }
 
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
-- 
2.44.0


