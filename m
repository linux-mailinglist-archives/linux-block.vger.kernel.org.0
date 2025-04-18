Return-Path: <linux-block+bounces-19998-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861DFA93AEF
	for <lists+linux-block@lfdr.de>; Fri, 18 Apr 2025 18:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098C1189C2D8
	for <lists+linux-block@lfdr.de>; Fri, 18 Apr 2025 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9740E126BF7;
	Fri, 18 Apr 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ru0ch4QR"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1B41DE89C
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994286; cv=none; b=C6q/QKd8kUJYuBdWtTe4+IzoNe1UnrQR+N6BcxI4PIA1SZ/0svg7vFcHiVCEWcRLm0jkLOOplhkLvKy0HYh6rzJ2PA9uInYnZGPzZ5r02rIVqgbxkRoYqxopwPWzZAHVXTaMoBEDybfiqjIHrdfB8YKLneA3Gt+KfdHNLNJebt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994286; c=relaxed/simple;
	bh=8Toy+V4rnFoxPInuVlP3u0TQYfThUJ2xkaMNF9U6IsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSReRCO6t632zCJ9aEp5p9cIfn7ZVDBALZu1s3s1YKlSkxbS8li2oZMpGKcR1jn1q6uIfB8ojmpXzFVz28BH2QRTWjPaMLb/QFcwoPYR3ZWYMHF2TGIzimKcfuS0QkhGSIjyH7sfMDLyPVuUcqth4dNth76I5yz7JNdLZQosA4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ru0ch4QR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=za3jlM+C3nArmNJzhk0X6IST5v0fosk18GaQWJKeyuY=;
	b=Ru0ch4QRvTmqzJz/zLAxJvxo9RfRCArQgFVHsSLlZzOooM8Bn9JknuJQMkX2spuGUasghF
	v05bXwPKVKbPBXFmK0ZxFSQvyCaKI7RR1edWw/URIrwuqwQvscQogR5SWqUWEMnygU//2Z
	itDS68HFHTENG9PQXpA1ePEUiQCuzko=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-ofvF3Ij-NiukJcfyOggtQQ-1; Fri,
 18 Apr 2025 12:38:00 -0400
X-MC-Unique: ofvF3Ij-NiukJcfyOggtQQ-1
X-Mimecast-MFC-AGG-ID: ofvF3Ij-NiukJcfyOggtQQ_1744994279
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44E2418001D5;
	Fri, 18 Apr 2025 16:37:59 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AE8F19560BA;
	Fri, 18 Apr 2025 16:37:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 09/20] block: simplify elevator rebuild for updating nr_hw_queues
Date: Sat, 19 Apr 2025 00:36:50 +0800
Message-ID: <20250418163708.442085-10-ming.lei@redhat.com>
In-Reply-To: <20250418163708.442085-1-ming.lei@redhat.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

In blk_mq_update_nr_hw_queues(), nr_hw_queues changes and elevator data
depends on it, so elevator has to be rebuilt.

Now elevator switch isn't allowed during blk_mq_update_nr_hw_queues(), so
we can simply call elevator_change() to rebuild elevator sched tags after
nr_hw_queues is updated.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c   | 103 ++++++-----------------------------------------
 block/blk.h      |   4 +-
 block/elevator.c |  12 +++---
 3 files changed, 22 insertions(+), 97 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e1662617cc7a..0f4a5e674874 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4929,88 +4929,10 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	return ret;
 }
 
-/*
- * request_queue and elevator_type pair.
- * It is just used by __blk_mq_update_nr_hw_queues to cache
- * the elevator_type associated with a request_queue.
- */
-struct blk_mq_qe_pair {
-	struct list_head node;
-	struct request_queue *q;
-	struct elevator_type *type;
-};
-
-/*
- * Cache the elevator_type in qe pair list and switch the
- * io scheduler to 'none'
- */
-static bool blk_mq_elv_switch_none(struct list_head *head,
-		struct request_queue *q)
-{
-	struct blk_mq_qe_pair *qe;
-
-	qe = kmalloc(sizeof(*qe), GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
-	if (!qe)
-		return false;
-
-	/* Accessing q->elevator needs protection from ->elevator_lock. */
-	mutex_lock(&q->elevator_lock);
-
-	if (!q->elevator) {
-		kfree(qe);
-		goto unlock;
-	}
-
-	INIT_LIST_HEAD(&qe->node);
-	qe->q = q;
-	qe->type = q->elevator->type;
-	/* keep a reference to the elevator module as we'll switch back */
-	__elevator_get(qe->type);
-	list_add(&qe->node, head);
-	elevator_disable(q);
-unlock:
-	mutex_unlock(&q->elevator_lock);
-
-	return true;
-}
-
-static struct blk_mq_qe_pair *blk_lookup_qe_pair(struct list_head *head,
-						struct request_queue *q)
-{
-	struct blk_mq_qe_pair *qe;
-
-	list_for_each_entry(qe, head, node)
-		if (qe->q == q)
-			return qe;
-
-	return NULL;
-}
-
-static void blk_mq_elv_switch_back(struct list_head *head,
-				  struct request_queue *q)
-{
-	struct blk_mq_qe_pair *qe;
-	struct elevator_type *t;
-
-	qe = blk_lookup_qe_pair(head, q);
-	if (!qe)
-		return;
-	t = qe->type;
-	list_del(&qe->node);
-	kfree(qe);
-
-	mutex_lock(&q->elevator_lock);
-	elevator_switch(q, t);
-	/* drop the reference acquired in blk_mq_elv_switch_none */
-	elevator_put(t);
-	mutex_unlock(&q->elevator_lock);
-}
-
 static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 							int nr_hw_queues)
 {
 	struct request_queue *q;
-	LIST_HEAD(head);
 	int prev_nr_hw_queues = set->nr_hw_queues;
 	unsigned int memflags;
 	int i;
@@ -5028,15 +4950,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue_nomemsave(q);
 
-	/*
-	 * Switch IO scheduler to 'none', cleaning up the data associated
-	 * with the previous scheduler. We will switch back once we are done
-	 * updating the new sw to hw queue mappings.
-	 */
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		if (!blk_mq_elv_switch_none(&head, q))
-			goto switch_back;
-
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_debugfs_unregister_hctxs(q);
 		blk_mq_sysfs_unregister_hctxs(q);
@@ -5070,9 +4983,19 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_debugfs_register_hctxs(q);
 	}
 
-switch_back:
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_elv_switch_back(&head, q);
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		const char *name = "none";
+
+		mutex_lock(&q->elevator_lock);
+		if (q->elevator && !blk_queue_dying(q))
+			name = q->elevator->type->elevator_name;
+		/*
+		 * nr_hw_queues is changed and elevator data depends on
+		 * it, so we have to force to rebuild elevator
+		 */
+		__elevator_change(q, name, true);
+		mutex_unlock(&q->elevator_lock);
+	}
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_unfreeze_queue_nomemrestore(q);
diff --git a/block/blk.h b/block/blk.h
index 006e3be433d2..0c3cc1af2525 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -319,8 +319,8 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-int elevator_switch(struct request_queue *q, struct elevator_type *new_e);
-void elevator_disable(struct request_queue *q);
+int __elevator_change(struct request_queue *q, const char *elevator_name,
+		      bool force);
 void elevator_exit(struct request_queue *q);
 int elv_register_queue(struct request_queue *q, bool uevent);
 void elv_unregister_queue(struct request_queue *q);
diff --git a/block/elevator.c b/block/elevator.c
index c23912652f96..f4c02a6c045d 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -621,7 +621,7 @@ void elevator_init_mq(struct request_queue *q)
  * If switching fails, we are most likely running out of memory and not able
  * to restore the old io scheduler, so leaving the io scheduler being none.
  */
-int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
+static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 {
 	int ret;
 
@@ -657,7 +657,7 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	return ret;
 }
 
-void elevator_disable(struct request_queue *q)
+static void elevator_disable(struct request_queue *q)
 {
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
@@ -677,7 +677,8 @@ void elevator_disable(struct request_queue *q)
 /*
  * Switch this queue to the given IO scheduler.
  */
-static int elevator_change(struct request_queue *q, const char *elevator_name)
+int __elevator_change(struct request_queue *q, const char *elevator_name,
+		      bool force)
 {
 	struct elevator_type *e;
 	int ret;
@@ -692,7 +693,8 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 		return 0;
 	}
 
-	if (q->elevator && elevator_match(q->elevator->type, elevator_name))
+	if (!force && q->elevator &&
+	    elevator_match(q->elevator->type, elevator_name))
 		return 0;
 
 	e = elevator_find_get(elevator_name);
@@ -743,7 +745,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
-	ret = elevator_change(q, name);
+	ret = __elevator_change(q, name, false);
 	if (!ret)
 		ret = count;
 	mutex_unlock(&q->elevator_lock);
-- 
2.47.0


