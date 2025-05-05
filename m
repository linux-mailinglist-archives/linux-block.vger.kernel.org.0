Return-Path: <linux-block+bounces-21196-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C94E8AA954F
	for <lists+linux-block@lfdr.de>; Mon,  5 May 2025 16:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B5416E01E
	for <lists+linux-block@lfdr.de>; Mon,  5 May 2025 14:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56666625;
	Mon,  5 May 2025 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcJUw6AQ"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5B72505D6
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454729; cv=none; b=URp9uek/ZF5a9jSQmyp19245mlvo+zPg1rcxLyCLSSICvoP6lBf6U579kb+iVBsJ8giBAJjTn5fKSVnu8FaHXE7bkdL61oD/dzTyzvXq5iuvfqbVgY+IZQlhiPalXRgBNomFOx3JBonY5xQiNHildhQNcRTxTOueo2v7hce5VRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454729; c=relaxed/simple;
	bh=3J/AvLtBIx+QllT/BTSygTW8QIznasKsK2EAeRo2dwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1KKO+irQ3dFCkihUHRaLgq1/mWxlWewaPjk7KO+CKon1ecOKtllGnLgPExaETOEelmEgjyIw1fdYlhVgP6/dgB6CDqrWGK0e8Znw4eMsjNF8Scyl/AxLg6P2oi3Zo4o/RPy+Va+3FGTZP7ZRFlXF+eNIfKySxm/FuoUwbW74vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bcJUw6AQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUJxhrXby5HE9RY5CKGjCHt7YQrhgzcM0E8DYgUkbo8=;
	b=bcJUw6AQXL4XPnM0kOTEfLJqLN08OWNhxsIO9x8YdwOFKafL6tgxtmgcOuEx7ZLt+FaMnl
	lMC4VKVPS8f4LfbbvgQa6Xnb+SKdFYeUkneyPu38ybXvBn0FrhjWVVlQyBIuKvdDi028iQ
	s/lukYIm1j2Hrih1QEYBvY1ZNBP8mos=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-sCcmdkjZNPSam_-uNj0tbg-1; Mon,
 05 May 2025 10:18:44 -0400
X-MC-Unique: sCcmdkjZNPSam_-uNj0tbg-1
X-Mimecast-MFC-AGG-ID: sCcmdkjZNPSam_-uNj0tbg_1746454722
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73DA21800EC8;
	Mon,  5 May 2025 14:18:42 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DB601800352;
	Mon,  5 May 2025 14:18:40 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 06/25] block: move sched debugfs register into elvevator_register_queue
Date: Mon,  5 May 2025 22:17:44 +0800
Message-ID: <20250505141805.2751237-7-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

sched debugfs shares same lifetime with scheduler's kobject, and same
lock(elevator lock), so move sched debugfs register/unregister into
elevator_register_queue() and elevator_unregister_queue().

Then we needn't blk_mq_debugfs_register() for us to register sched
debugfs any more.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 11 -----------
 block/blk-mq-sched.c   | 11 ++---------
 block/elevator.c       |  8 ++++++++
 block/elevator.h       |  3 +++
 4 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7710c409e432..2837a8ce8054 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -625,20 +625,9 @@ void blk_mq_debugfs_register(struct request_queue *q)
 
 	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
-	/*
-	 * blk_mq_init_sched() attempted to do this already, but q->debugfs_dir
-	 * didn't exist yet (because we don't know what to name the directory
-	 * until the queue is registered to a gendisk).
-	 */
-	if (q->elevator && !q->sched_debugfs_dir)
-		blk_mq_debugfs_register_sched(q);
-
-	/* Similarly, blk_mq_init_hctx() couldn't do this previously. */
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx->debugfs_dir)
 			blk_mq_debugfs_register_hctx(q, hctx);
-		if (q->elevator && !hctx->sched_debugfs_dir)
-			blk_mq_debugfs_register_sched_hctx(q, hctx);
 	}
 
 	if (q->rq_qos) {
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 2abc5e0704e8..336a15ffecfa 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -434,7 +434,7 @@ static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
 	return 0;
 }
 
-static void blk_mq_sched_reg_debugfs(struct request_queue *q)
+void blk_mq_sched_reg_debugfs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
@@ -446,7 +446,7 @@ static void blk_mq_sched_reg_debugfs(struct request_queue *q)
 	mutex_unlock(&q->debugfs_mutex);
 }
 
-static void blk_mq_sched_unreg_debugfs(struct request_queue *q)
+void blk_mq_sched_unreg_debugfs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
@@ -503,10 +503,6 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 			}
 		}
 	}
-
-	/* sched is initialized, it is ready to export it via debugfs */
-	blk_mq_sched_reg_debugfs(q);
-
 	return 0;
 
 err_free_map_and_rqs:
@@ -544,9 +540,6 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 	unsigned long i;
 	unsigned int flags = 0;
 
-	/* unexport via debugfs before exiting sched */
-	blk_mq_sched_unreg_debugfs(q);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (e->type->ops.exit_hctx && hctx->sched_data) {
 			e->type->ops.exit_hctx(hctx, i);
diff --git a/block/elevator.c b/block/elevator.c
index b32815594892..4400eb8fe54f 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -472,6 +472,11 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 		if (uevent)
 			kobject_uevent(&e->kobj, KOBJ_ADD);
 
+		/*
+		 * Sched is initialized, it is ready to export it via
+		 * debugfs
+		 */
+		blk_mq_sched_reg_debugfs(q);
 		set_bit(ELEVATOR_FLAG_REGISTERED, &e->flags);
 	}
 	return error;
@@ -486,6 +491,9 @@ void elv_unregister_queue(struct request_queue *q)
 	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
 		kobject_del(&e->kobj);
+
+		/* unexport via debugfs before exiting sched */
+		blk_mq_sched_unreg_debugfs(q);
 	}
 }
 
diff --git a/block/elevator.h b/block/elevator.h
index e27af5492cdb..9198676644a9 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -181,4 +181,7 @@ extern struct request *elv_rb_find(struct rb_root *, sector_t);
 #define rq_entry_fifo(ptr)	list_entry((ptr), struct request, queuelist)
 #define rq_fifo_clear(rq)	list_del_init(&(rq)->queuelist)
 
+void blk_mq_sched_reg_debugfs(struct request_queue *q);
+void blk_mq_sched_unreg_debugfs(struct request_queue *q);
+
 #endif /* _ELEVATOR_H */
-- 
2.47.0


