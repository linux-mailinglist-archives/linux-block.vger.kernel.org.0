Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9437A9C770
	for <lists+linux-block@lfdr.de>; Mon, 26 Aug 2019 04:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfHZCwn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 25 Aug 2019 22:52:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbfHZCwm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Aug 2019 22:52:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19F7C81F19;
        Mon, 26 Aug 2019 02:52:42 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29E5D608C1;
        Mon, 26 Aug 2019 02:52:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V3 5/5] block: split .sysfs_lock into two locks
Date:   Mon, 26 Aug 2019 10:51:46 +0800
Message-Id: <20190826025146.31158-6-ming.lei@redhat.com>
In-Reply-To: <20190826025146.31158-1-ming.lei@redhat.com>
References: <20190826025146.31158-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 26 Aug 2019 02:52:42 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The kernfs built-in lock of 'kn->count' is held in sysfs .show/.store
path. Meantime, inside block's .show/.store callback, q->sysfs_lock is
required.

However, when mq & iosched kobjects are removed via
blk_mq_unregister_dev() & elv_unregister_queue(), q->sysfs_lock is held
too. This way causes AB-BA lock because the kernfs built-in lock of
'kn-count' is required inside kobject_del() too, see the lockdep warning[1].

On the other hand, it isn't necessary to acquire q->sysfs_lock for
both blk_mq_unregister_dev() & elv_unregister_queue() because
clearing REGISTERED flag prevents storing to 'queue/scheduler'
from being happened. Also sysfs write(store) is exclusive, so no
necessary to hold the lock for elv_unregister_queue() when it is
called in switching elevator path.

So split .sysfs_lock into two: one is still named as .sysfs_lock for
covering sync .store, the other one is named as .sysfs_dir_lock
for covering kobjects and related status change.

sysfs itself can handle the race between add/remove kobjects and
showing/storing attributes under kobjects. For switching scheduler
via storing to 'queue/scheduler', we use the queue flag of
QUEUE_FLAG_REGISTERED with .sysfs_lock for avoiding the race, then
we can avoid to hold .sysfs_lock during removing/adding kobjects.

[1]  lockdep warning
    ======================================================
    WARNING: possible circular locking dependency detected
    5.3.0-rc3-00044-g73277fc75ea0 #1380 Not tainted
    ------------------------------------------------------
    rmmod/777 is trying to acquire lock:
    00000000ac50e981 (kn->count#202){++++}, at: kernfs_remove_by_name_ns+0x59/0x72

    but task is already holding lock:
    00000000fb16ae21 (&q->sysfs_lock){+.+.}, at: blk_unregister_queue+0x78/0x10b

    which lock already depends on the new lock.

    the existing dependency chain (in reverse order) is:

    -> #1 (&q->sysfs_lock){+.+.}:
           __lock_acquire+0x95f/0xa2f
           lock_acquire+0x1b4/0x1e8
           __mutex_lock+0x14a/0xa9b
           blk_mq_hw_sysfs_show+0x63/0xb6
           sysfs_kf_seq_show+0x11f/0x196
           seq_read+0x2cd/0x5f2
           vfs_read+0xc7/0x18c
           ksys_read+0xc4/0x13e
           do_syscall_64+0xa7/0x295
           entry_SYSCALL_64_after_hwframe+0x49/0xbe

    -> #0 (kn->count#202){++++}:
           check_prev_add+0x5d2/0xc45
           validate_chain+0xed3/0xf94
           __lock_acquire+0x95f/0xa2f
           lock_acquire+0x1b4/0x1e8
           __kernfs_remove+0x237/0x40b
           kernfs_remove_by_name_ns+0x59/0x72
           remove_files+0x61/0x96
           sysfs_remove_group+0x81/0xa4
           sysfs_remove_groups+0x3b/0x44
           kobject_del+0x44/0x94
           blk_mq_unregister_dev+0x83/0xdd
           blk_unregister_queue+0xa0/0x10b
           del_gendisk+0x259/0x3fa
           null_del_dev+0x8b/0x1c3 [null_blk]
           null_exit+0x5c/0x95 [null_blk]
           __se_sys_delete_module+0x204/0x337
           do_syscall_64+0xa7/0x295
           entry_SYSCALL_64_after_hwframe+0x49/0xbe

    other info that might help us debug this:

     Possible unsafe locking scenario:

           CPU0                    CPU1
           ----                    ----
      lock(&q->sysfs_lock);
                                   lock(kn->count#202);
                                   lock(&q->sysfs_lock);
      lock(kn->count#202);

     *** DEADLOCK ***

    2 locks held by rmmod/777:
     #0: 00000000e69bd9de (&lock){+.+.}, at: null_exit+0x2e/0x95 [null_blk]
     #1: 00000000fb16ae21 (&q->sysfs_lock){+.+.}, at: blk_unregister_queue+0x78/0x10b

    stack backtrace:
    CPU: 0 PID: 777 Comm: rmmod Not tainted 5.3.0-rc3-00044-g73277fc75ea0 #1380
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-20180724_192412-buildhw-07.phx4
    Call Trace:
     dump_stack+0x9a/0xe6
     check_noncircular+0x207/0x251
     ? print_circular_bug+0x32a/0x32a
     ? find_usage_backwards+0x84/0xb0
     check_prev_add+0x5d2/0xc45
     validate_chain+0xed3/0xf94
     ? check_prev_add+0xc45/0xc45
     ? mark_lock+0x11b/0x804
     ? check_usage_forwards+0x1ca/0x1ca
     __lock_acquire+0x95f/0xa2f
     lock_acquire+0x1b4/0x1e8
     ? kernfs_remove_by_name_ns+0x59/0x72
     __kernfs_remove+0x237/0x40b
     ? kernfs_remove_by_name_ns+0x59/0x72
     ? kernfs_next_descendant_post+0x7d/0x7d
     ? strlen+0x10/0x23
     ? strcmp+0x22/0x44
     kernfs_remove_by_name_ns+0x59/0x72
     remove_files+0x61/0x96
     sysfs_remove_group+0x81/0xa4
     sysfs_remove_groups+0x3b/0x44
     kobject_del+0x44/0x94
     blk_mq_unregister_dev+0x83/0xdd
     blk_unregister_queue+0xa0/0x10b
     del_gendisk+0x259/0x3fa
     ? disk_events_poll_msecs_store+0x12b/0x12b
     ? check_flags+0x1ea/0x204
     ? mark_held_locks+0x1f/0x7a
     null_del_dev+0x8b/0x1c3 [null_blk]
     null_exit+0x5c/0x95 [null_blk]
     __se_sys_delete_module+0x204/0x337
     ? free_module+0x39f/0x39f
     ? blkcg_maybe_throttle_current+0x8a/0x718
     ? rwlock_bug+0x62/0x62
     ? __blkcg_punt_bio_submit+0xd0/0xd0
     ? trace_hardirqs_on_thunk+0x1a/0x20
     ? mark_held_locks+0x1f/0x7a
     ? do_syscall_64+0x4c/0x295
     do_syscall_64+0xa7/0x295
     entry_SYSCALL_64_after_hwframe+0x49/0xbe
    RIP: 0033:0x7fb696cdbe6b
    Code: 73 01 c3 48 8b 0d 1d 20 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 008
    RSP: 002b:00007ffec9588788 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
    RAX: ffffffffffffffda RBX: 0000559e589137c0 RCX: 00007fb696cdbe6b
    RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000559e58913828
    RBP: 0000000000000000 R08: 00007ffec9587701 R09: 0000000000000000
    R10: 00007fb696d4eae0 R11: 0000000000000206 R12: 00007ffec95889b0
    R13: 00007ffec95896b3 R14: 0000559e58913260 R15: 0000559e589137c0

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       |  1 +
 block/blk-mq-sysfs.c   | 12 +++++------
 block/blk-sysfs.c      | 46 ++++++++++++++++++++++++++----------------
 block/blk.h            |  2 +-
 block/elevator.c       | 46 ++++++++++++++++++++++++++++++++++--------
 include/linux/blkdev.h |  1 +
 6 files changed, 76 insertions(+), 32 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 919629ce4015..2792f7cf7bef 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -520,6 +520,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	mutex_init(&q->blk_trace_mutex);
 #endif
 	mutex_init(&q->sysfs_lock);
+	mutex_init(&q->sysfs_dir_lock);
 	spin_lock_init(&q->queue_lock);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 6ddde3774ebe..a0d3ce30fa08 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -270,7 +270,7 @@ void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	lockdep_assert_held(&q->sysfs_lock);
+	lockdep_assert_held(&q->sysfs_dir_lock);
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
@@ -320,7 +320,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 	int ret, i;
 
 	WARN_ON_ONCE(!q->kobj.parent);
-	lockdep_assert_held(&q->sysfs_lock);
+	lockdep_assert_held(&q->sysfs_dir_lock);
 
 	ret = kobject_add(q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
 	if (ret < 0)
@@ -354,7 +354,7 @@ void blk_mq_sysfs_unregister(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	mutex_lock(&q->sysfs_lock);
+	mutex_lock(&q->sysfs_dir_lock);
 	if (!q->mq_sysfs_init_done)
 		goto unlock;
 
@@ -362,7 +362,7 @@ void blk_mq_sysfs_unregister(struct request_queue *q)
 		blk_mq_unregister_hctx(hctx);
 
 unlock:
-	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->sysfs_dir_lock);
 }
 
 int blk_mq_sysfs_register(struct request_queue *q)
@@ -370,7 +370,7 @@ int blk_mq_sysfs_register(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i, ret = 0;
 
-	mutex_lock(&q->sysfs_lock);
+	mutex_lock(&q->sysfs_dir_lock);
 	if (!q->mq_sysfs_init_done)
 		goto unlock;
 
@@ -381,7 +381,7 @@ int blk_mq_sysfs_register(struct request_queue *q)
 	}
 
 unlock:
-	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->sysfs_dir_lock);
 
 	return ret;
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 5b0b5224cfd4..5941a0176f87 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -938,6 +938,7 @@ int blk_register_queue(struct gendisk *disk)
 	int ret;
 	struct device *dev = disk_to_dev(disk);
 	struct request_queue *q = disk->queue;
+	bool has_elevator = false;
 
 	if (WARN_ON(!q))
 		return -ENXIO;
@@ -945,7 +946,6 @@ int blk_register_queue(struct gendisk *disk)
 	WARN_ONCE(blk_queue_registered(q),
 		  "%s is registering an already registered queue\n",
 		  kobject_name(&dev->kobj));
-	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
 
 	/*
 	 * SCSI probing may synchronously create and destroy a lot of
@@ -966,7 +966,7 @@ int blk_register_queue(struct gendisk *disk)
 		return ret;
 
 	/* Prevent changes through sysfs until registration is completed. */
-	mutex_lock(&q->sysfs_lock);
+	mutex_lock(&q->sysfs_dir_lock);
 
 	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
 	if (ret < 0) {
@@ -987,26 +987,37 @@ int blk_register_queue(struct gendisk *disk)
 		blk_mq_debugfs_register(q);
 	}
 
-	kobject_uevent(&q->kobj, KOBJ_ADD);
-
-	wbt_enable_default(q);
-
-	blk_throtl_register_queue(q);
-
+	/*
+	 * The queue's kobject ADD uevent isn't sent out, also the
+	 * flag of QUEUE_FLAG_REGISTERED isn't set yet, so elevator
+	 * switch won't happen at all.
+	 */
 	if (q->elevator) {
-		ret = elv_register_queue(q);
+		ret = elv_register_queue(q, false);
 		if (ret) {
-			mutex_unlock(&q->sysfs_lock);
-			kobject_uevent(&q->kobj, KOBJ_REMOVE);
+			mutex_unlock(&q->sysfs_dir_lock);
 			kobject_del(&q->kobj);
 			blk_trace_remove_sysfs(dev);
 			kobject_put(&dev->kobj);
 			return ret;
 		}
+		has_elevator = true;
 	}
+
+	mutex_lock(&q->sysfs_lock);
+	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
+	wbt_enable_default(q);
+	blk_throtl_register_queue(q);
+	mutex_unlock(&q->sysfs_lock);
+
+	/* Now everything is ready and send out KOBJ_ADD uevent */
+	kobject_uevent(&q->kobj, KOBJ_ADD);
+	if (has_elevator)
+		kobject_uevent(&q->elevator->kobj, KOBJ_ADD);
+
 	ret = 0;
 unlock:
-	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->sysfs_dir_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_register_queue);
@@ -1021,6 +1032,7 @@ EXPORT_SYMBOL_GPL(blk_register_queue);
 void blk_unregister_queue(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
+	bool has_elevator;
 
 	if (WARN_ON(!q))
 		return;
@@ -1035,25 +1047,25 @@ void blk_unregister_queue(struct gendisk *disk)
 	 * concurrent elv_iosched_store() calls.
 	 */
 	mutex_lock(&q->sysfs_lock);
-
 	blk_queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
+	has_elevator = !!q->elevator;
+	mutex_unlock(&q->sysfs_lock);
 
+	mutex_lock(&q->sysfs_dir_lock);
 	/*
 	 * Remove the sysfs attributes before unregistering the queue data
 	 * structures that can be modified through sysfs.
 	 */
 	if (queue_is_mq(q))
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
-	mutex_unlock(&q->sysfs_lock);
 
 	kobject_uevent(&q->kobj, KOBJ_REMOVE);
 	kobject_del(&q->kobj);
 	blk_trace_remove_sysfs(disk_to_dev(disk));
 
-	mutex_lock(&q->sysfs_lock);
-	if (q->elevator)
+	if (has_elevator)
 		elv_unregister_queue(q);
-	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->sysfs_dir_lock);
 
 	kobject_put(&disk_to_dev(disk)->kobj);
 }
diff --git a/block/blk.h b/block/blk.h
index de6b2e146d6e..e4619fc5c99a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -188,7 +188,7 @@ int elevator_init_mq(struct request_queue *q);
 int elevator_switch_mq(struct request_queue *q,
 			      struct elevator_type *new_e);
 void __elevator_exit(struct request_queue *, struct elevator_queue *);
-int elv_register_queue(struct request_queue *q);
+int elv_register_queue(struct request_queue *q, bool uevent);
 void elv_unregister_queue(struct request_queue *q);
 
 static inline void elevator_exit(struct request_queue *q,
diff --git a/block/elevator.c b/block/elevator.c
index 03d923196569..748a9888e348 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -470,13 +470,16 @@ static struct kobj_type elv_ktype = {
 	.release	= elevator_release,
 };
 
-int elv_register_queue(struct request_queue *q)
+/*
+ * elv_register_queue is called from either blk_register_queue or
+ * elevator_switch, elevator switch is prevented from being happen
+ * in the two paths, so it is safe to not hold q->sysfs_lock.
+ */
+int elv_register_queue(struct request_queue *q, bool uevent)
 {
 	struct elevator_queue *e = q->elevator;
 	int error;
 
-	lockdep_assert_held(&q->sysfs_lock);
-
 	error = kobject_add(&e->kobj, &q->kobj, "%s", "iosched");
 	if (!error) {
 		struct elv_fs_entry *attr = e->type->elevator_attrs;
@@ -487,24 +490,34 @@ int elv_register_queue(struct request_queue *q)
 				attr++;
 			}
 		}
-		kobject_uevent(&e->kobj, KOBJ_ADD);
+		if (uevent)
+			kobject_uevent(&e->kobj, KOBJ_ADD);
+
+		mutex_lock(&q->sysfs_lock);
 		e->registered = 1;
+		mutex_unlock(&q->sysfs_lock);
 	}
 	return error;
 }
 
+/*
+ * elv_unregister_queue is called from either blk_unregister_queue or
+ * elevator_switch, elevator switch is prevented from being happen
+ * in the two paths, so it is safe to not hold q->sysfs_lock.
+ */
 void elv_unregister_queue(struct request_queue *q)
 {
-	lockdep_assert_held(&q->sysfs_lock);
-
 	if (q) {
 		struct elevator_queue *e = q->elevator;
 
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
 		kobject_del(&e->kobj);
+
+		mutex_lock(&q->sysfs_lock);
 		e->registered = 0;
 		/* Re-enable throttling in case elevator disabled it */
 		wbt_enable_default(q);
+		mutex_unlock(&q->sysfs_lock);
 	}
 }
 
@@ -567,10 +580,23 @@ int elevator_switch_mq(struct request_queue *q,
 	lockdep_assert_held(&q->sysfs_lock);
 
 	if (q->elevator) {
-		if (q->elevator->registered)
+		if (q->elevator->registered) {
+			mutex_unlock(&q->sysfs_lock);
+
 			elv_unregister_queue(q);
+
+			mutex_lock(&q->sysfs_lock);
+		}
 		ioc_clear_queue(q);
 		elevator_exit(q, q->elevator);
+
+		/*
+		 * sysfs_lock may be dropped, so re-check if queue is
+		 * unregistered. If yes, don't switch to new elevator
+		 * any more
+		 */
+		if (!blk_queue_registered(q))
+			return 0;
 	}
 
 	ret = blk_mq_init_sched(q, new_e);
@@ -578,7 +604,11 @@ int elevator_switch_mq(struct request_queue *q,
 		goto out;
 
 	if (new_e) {
-		ret = elv_register_queue(q);
+		mutex_unlock(&q->sysfs_lock);
+
+		ret = elv_register_queue(q, true);
+
+		mutex_lock(&q->sysfs_lock);
 		if (ret) {
 			elevator_exit(q, q->elevator);
 			goto out;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6041755984f4..e271c3a176fa 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -539,6 +539,7 @@ struct request_queue {
 	struct delayed_work	requeue_work;
 
 	struct mutex		sysfs_lock;
+	struct mutex		sysfs_dir_lock;
 
 	/*
 	 * for reusing dead hctx instance in case of updating
-- 
2.20.1

