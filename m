Return-Path: <linux-block+bounces-20942-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52470AA41FE
	for <lists+linux-block@lfdr.de>; Wed, 30 Apr 2025 06:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A303B8381
	for <lists+linux-block@lfdr.de>; Wed, 30 Apr 2025 04:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272EB6AD3;
	Wed, 30 Apr 2025 04:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQnWTRWI"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCBD1DACB1
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987802; cv=none; b=OJH/q2sxTr6lpA6oOfxm6J2nDYCoj3OS0auntY15N343P9Hpse2YKrdIbQxhUxfGHTn6XzFo11udV5wOBescVFNTybHXOFJ99i8uP7VmwbITr+CeqmmrPvziu6aZgaTW5+nafQLIovWhNp7GlTB7tjXNKm42zDCyZRxCAMj7Bg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987802; c=relaxed/simple;
	bh=TC7HvHMB4aS+hECZj7gR4stqYw6oEfg2xcvQfNs8EGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Evh59Wx5oQa2cRVAoqHJo0P8XJcWkEgMjK/488Jq+nS78hxcjEx/m/+Kqsk2Zf2UzWu0rou25OgZpZtV3R9qqkrJC0t5kW/WSeQdFuFY4CDWnMg8mDob146my6sciwFN4U34oxpt2Bi4izK7+jiwDnvnu5Wgm38s+13rP0NMjrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQnWTRWI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MlDq2+0QMhktmfFpI7DbVoC07bMHdIIH4ZiugSsPp4=;
	b=RQnWTRWIWSDVstQP6loDgo4FFyPUjXt7L4Im7ZjwTPInK9n7wZXdKWbHr4073er4GDLKZR
	1MoatC3BO3W2WggFaUmcmT8zcLSjGA1xGFbJt5FkmmYY5oRkVwXu/v27VfLoC5EzBt3C+P
	6xYSyydZ5jKEfeOi2L4tdw7S5S4U60c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-r5YIer3NOfqIvVLX6gpS-A-1; Wed,
 30 Apr 2025 00:36:35 -0400
X-MC-Unique: r5YIer3NOfqIvVLX6gpS-A-1
X-Mimecast-MFC-AGG-ID: r5YIer3NOfqIvVLX6gpS-A_1745987793
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A622D195609D;
	Wed, 30 Apr 2025 04:36:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A91E4180045C;
	Wed, 30 Apr 2025 04:36:32 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 15/24] block: unifying elevator change
Date: Wed, 30 Apr 2025 12:35:17 +0800
Message-ID: <20250430043529.1950194-16-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Elevator change is one well-define behavior:

- tear down current elevator if it exists

- setup new elevator

It is supposed to cover any case for changing elevator by single
internal API, typically the following cases:

- setup default elevator in add_disk()

- switch to none in del_disk()

- reset elevator in blk_mq_update_nr_hw_queues()

- switch elevator in sysfs `store` elevator attribute

This patch uses elevator_change() to cover all above cases:

- every elevator switch is serialized with each other: add_disk/del_disk/
store elevator is serialized already, blk_mq_update_nr_hw_queues() uses
srcu for syncing with the other three cases

- for both add_disk()/del_disk(), queue freeze works at atomic mode
or has been froze, so the freeze in elevator_change() won't add extra
delay

- `struct elev_change_ctx` instance holds any info for changing elevator

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c |  19 +++-----
 block/blk.h       |   5 +-
 block/elevator.c  | 116 +++++++++++++++++++++-------------------------
 block/genhd.c     |  28 ++---------
 4 files changed, 67 insertions(+), 101 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1f9b45b0b9ee..741e607dfab6 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -869,14 +869,9 @@ int blk_register_queue(struct gendisk *disk)
 	if (ret)
 		goto out_unregister_ia_ranges;
 
+	if (queue_is_mq(q))
+		elevator_set_default(q);
 	mutex_lock(&q->elevator_lock);
-	if (q->elevator) {
-		ret = elv_register_queue(q, false);
-		if (ret) {
-			mutex_unlock(&q->elevator_lock);
-			goto out_crypto_sysfs_unregister;
-		}
-	}
 	wbt_enable_default(disk);
 	mutex_unlock(&q->elevator_lock);
 
@@ -902,8 +897,6 @@ int blk_register_queue(struct gendisk *disk)
 
 	return ret;
 
-out_crypto_sysfs_unregister:
-	blk_crypto_sysfs_unregister(disk);
 out_unregister_ia_ranges:
 	disk_unregister_independent_access_ranges(disk);
 out_debugfs_remove:
@@ -951,9 +944,11 @@ void blk_unregister_queue(struct gendisk *disk)
 		blk_mq_sysfs_unregister(disk);
 	blk_crypto_sysfs_unregister(disk);
 
-	mutex_lock(&q->elevator_lock);
-	elv_unregister_queue(q);
-	mutex_unlock(&q->elevator_lock);
+	if (queue_is_mq(q)) {
+		blk_mq_quiesce_queue(q);
+		elevator_set_none(q);
+		blk_mq_unquiesce_queue(q);
+	}
 
 	mutex_lock(&q->sysfs_lock);
 	disk_unregister_independent_access_ranges(disk);
diff --git a/block/blk.h b/block/blk.h
index 98fd3a6f5ec9..23b6ed27e5d1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -323,9 +323,8 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 bool blk_insert_flush(struct request *rq);
 
 void elv_update_nr_hw_queues(struct request_queue *q);
-void elevator_exit(struct request_queue *q);
-int elv_register_queue(struct request_queue *q, bool uevent);
-void elv_unregister_queue(struct request_queue *q);
+void elevator_set_default(struct request_queue *q);
+void elevator_set_none(struct request_queue *q);
 
 ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
 		char *buf);
diff --git a/block/elevator.c b/block/elevator.c
index 5188bb0119f0..aaec9584ed72 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -154,7 +154,7 @@ static void elevator_release(struct kobject *kobj)
 	kfree(e);
 }
 
-void elevator_exit(struct request_queue *q)
+static void elevator_exit(struct request_queue *q)
 {
 	struct elevator_queue *e = q->elevator;
 
@@ -458,7 +458,7 @@ static const struct kobj_type elv_ktype = {
 	.release	= elevator_release,
 };
 
-int elv_register_queue(struct request_queue *q, bool uevent)
+static int elv_register_queue(struct request_queue *q, bool uevent)
 {
 	struct elevator_queue *e = q->elevator;
 	int error;
@@ -488,7 +488,7 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 	return error;
 }
 
-void elv_unregister_queue(struct request_queue *q)
+static void elv_unregister_queue(struct request_queue *q)
 {
 	struct elevator_queue *e = q->elevator;
 
@@ -561,66 +561,6 @@ void elv_unregister(struct elevator_type *e)
 }
 EXPORT_SYMBOL_GPL(elv_unregister);
 
-/*
- * For single queue devices, default to using mq-deadline. If we have multiple
- * queues or mq-deadline is not available, default to "none".
- */
-static struct elevator_type *elevator_get_default(struct request_queue *q)
-{
-	if (q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
-		return NULL;
-
-	if (q->nr_hw_queues != 1 &&
-	    !blk_mq_is_shared_tags(q->tag_set->flags))
-		return NULL;
-
-	return elevator_find_get("mq-deadline");
-}
-
-/*
- * Use the default elevator settings. If the chosen elevator initialization
- * fails, fall back to the "none" elevator (no elevator).
- */
-void elevator_init_mq(struct request_queue *q)
-{
-	struct elevator_type *e;
-	unsigned int memflags;
-	int err;
-
-	WARN_ON_ONCE(blk_queue_registered(q));
-
-	if (unlikely(q->elevator))
-		return;
-
-	e = elevator_get_default(q);
-	if (!e)
-		return;
-
-	/*
-	 * We are called before adding disk, when there isn't any FS I/O,
-	 * so freezing queue plus canceling dispatch work is enough to
-	 * drain any dispatch activities originated from passthrough
-	 * requests, then no need to quiesce queue which may add long boot
-	 * latency, especially when lots of disks are involved.
-	 *
-	 * Disk isn't added yet, so verifying queue lock only manually.
-	 */
-	memflags = blk_mq_freeze_queue(q);
-
-	blk_mq_cancel_work_sync(q);
-
-	err = blk_mq_init_sched(q, e);
-
-	blk_mq_unfreeze_queue(q, memflags);
-
-	if (err) {
-		pr_warn("\"%s\" elevator initialization failed, "
-			"falling back to \"none\"\n", e->elevator_name);
-	}
-
-	elevator_put(e);
-}
-
 /*
  * Switch to new_e io scheduler.
  *
@@ -688,6 +628,16 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
 
 	memflags = blk_mq_freeze_queue(q);
+	/*
+	 * May be called before adding disk, when there isn't any FS I/O,
+	 * so freezing queue plus canceling dispatch work is enough to
+	 * drain any dispatch activities originated from passthrough
+	 * requests, then no need to quiesce queue which may add long boot
+	 * latency, especially when lots of disks are involved.
+	 *
+	 * Disk isn't added yet, so verifying queue lock only manually.
+	 */
+	blk_mq_cancel_work_sync(q);
 	mutex_lock(&q->elevator_lock);
 	if (!(q->elevator && elevator_match(q->elevator->type, ctx->name)))
 		ret = elevator_switch(q, ctx);
@@ -716,6 +666,46 @@ void elv_update_nr_hw_queues(struct request_queue *q)
 	mutex_unlock(&q->elevator_lock);
 }
 
+/*
+ * Use the default elevator settings. If the chosen elevator initialization
+ * fails, fall back to the "none" elevator (no elevator).
+ */
+void elevator_set_default(struct request_queue *q)
+{
+	struct elv_change_ctx ctx = {
+		.name = "mq-deadline",
+		.no_uevent = true,
+	};
+	int err = 0;
+
+	if (q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
+		return;
+
+	/*
+	 * For single queue devices, default to using mq-deadline. If we
+	 * have multiple queues or mq-deadline is not available, default
+	 * to "none".
+	 */
+	if (elevator_find_get(ctx.name) && (q->nr_hw_queues == 1 ||
+			 blk_mq_is_shared_tags(q->tag_set->flags)))
+		err = elevator_change(q, &ctx);
+	if (err < 0)
+		pr_warn("\"%s\" elevator initialization, failed %d, "
+			"falling back to \"none\"\n", ctx.name, err);
+}
+
+void elevator_set_none(struct request_queue *q)
+{
+	struct elv_change_ctx ctx = {
+		.name	= "none",
+	};
+	int err;
+
+	err = elevator_change(q, &ctx);
+	if (err < 0)
+		pr_warn("%s: set none elevator failed %d\n", __func__, err);
+}
+
 static void elv_iosched_load_module(const char *elevator_name)
 {
 	struct elevator_type *found;
diff --git a/block/genhd.c b/block/genhd.c
index 340fb4555963..0c34cc1a4eae 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -406,12 +406,6 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
 		 */
 		if (disk->fops->submit_bio || disk->fops->poll_bio)
 			return -EINVAL;
-
-		/*
-		 * Initialize the I/O scheduler code and pick a default one if
-		 * needed.
-		 */
-		elevator_init_mq(disk->queue);
 	} else {
 		if (!disk->fops->submit_bio)
 			return -EINVAL;
@@ -428,7 +422,7 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
 	ret = -EINVAL;
 	if (disk->major) {
 		if (WARN_ON(!disk->minors))
-			goto out_exit_elevator;
+			goto out;
 
 		if (disk->minors > DISK_MAX_PARTS) {
 			pr_err("block: can't allocate more than %d partitions\n",
@@ -438,14 +432,14 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
 		if (disk->first_minor > MINORMASK ||
 		    disk->minors > MINORMASK + 1 ||
 		    disk->first_minor + disk->minors > MINORMASK + 1)
-			goto out_exit_elevator;
+			goto out;
 	} else {
 		if (WARN_ON(disk->minors))
-			goto out_exit_elevator;
+			goto out;
 
 		ret = blk_alloc_ext_minor();
 		if (ret < 0)
-			goto out_exit_elevator;
+			goto out;
 		disk->major = BLOCK_EXT_MAJOR;
 		disk->first_minor = ret;
 	}
@@ -554,12 +548,7 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
 out_free_ext_minor:
 	if (disk->major == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(disk->first_minor);
-out_exit_elevator:
-	if (disk->queue->elevator) {
-		mutex_lock(&disk->queue->elevator_lock);
-		elevator_exit(disk->queue);
-		mutex_unlock(&disk->queue->elevator_lock);
-	}
+out:
 	return ret;
 }
 
@@ -745,14 +734,7 @@ static void __del_gendisk(struct gendisk *disk)
 	if (queue_is_mq(q))
 		blk_mq_cancel_work_sync(q);
 
-	blk_mq_quiesce_queue(q);
-	if (q->elevator) {
-		mutex_lock(&q->elevator_lock);
-		elevator_exit(q);
-		mutex_unlock(&q->elevator_lock);
-	}
 	rq_qos_exit(q);
-	blk_mq_unquiesce_queue(q);
 
 	/*
 	 * If the disk does not own the queue, allow using passthrough requests
-- 
2.47.0


