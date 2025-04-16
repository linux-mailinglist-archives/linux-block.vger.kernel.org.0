Return-Path: <linux-block+bounces-19760-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E66CA8AEC3
	for <lists+linux-block@lfdr.de>; Wed, 16 Apr 2025 05:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8C41904791
	for <lists+linux-block@lfdr.de>; Wed, 16 Apr 2025 03:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDFD190462;
	Wed, 16 Apr 2025 03:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScLf2F7R"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EC62288FE
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775721; cv=none; b=oOloHaXu2kICq+FWSvOJDw1owofLNdAtOMwfeeDzydvt1yVenopdcJ0hnU+0fZsa8sYgKZ29iN3o4zV9hbpeA5hn2RO1DJ4753OOJRQKv8MxydL18uhvYYYX+7LMwdFr0YCc79wC/jKK2eGCrcfJ2DO3RlxWUJiHIF+YcR61SBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775721; c=relaxed/simple;
	bh=zYoktFhbO2/HhHx3KxJga9aG9oEKBjLSXcH9YU6KSLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mH2Ud12h0qoyi2bfkrm4MFrDMQxwW9YlxW+5J/E3acYSkSUE6vDs8DlOTPf75FiheWUvG/kRfqHioBybTvK7om1gQ8n2oRFs5XnIWFFxrDmafs6tPNLw1XufyCGhH75xHsm+xp+f+82XQeystbuE8VioPAFGZQlJXn3RoosvCVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ScLf2F7R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744775718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVev0oDTxcCwbd0t2y+bMOQRrIpW0xGg2+bUOul8wpk=;
	b=ScLf2F7R0WkoNRhdbO09Z1L4GeAPkemQJO/bQc8UufmSzihyCTjTyhpKWB/gRBmrlOMCNW
	xOx8ICOcCZkWxr98GojFTvQDFU/fGedyBqdHjne7dcJJRh0CtyFP3weOi6uEl6/B+AAN5k
	zW3/nb+RmqJLldEqM4xLVPCsy+ckhyY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-46dcfYDSPXyk-OymLqYeig-1; Tue,
 15 Apr 2025 23:55:15 -0400
X-MC-Unique: 46dcfYDSPXyk-OymLqYeig-1
X-Mimecast-MFC-AGG-ID: 46dcfYDSPXyk-OymLqYeig_1744775714
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CED71955DC5;
	Wed, 16 Apr 2025 03:55:14 +0000 (UTC)
Received: from localhost (unknown [10.72.116.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A447B3001D9F;
	Wed, 16 Apr 2025 03:55:13 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 5/8] ublk: improve detection and handling of ublk server exit
Date: Wed, 16 Apr 2025 11:54:39 +0800
Message-ID: <20250416035444.99569-6-ming.lei@redhat.com>
In-Reply-To: <20250416035444.99569-1-ming.lei@redhat.com>
References: <20250416035444.99569-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Uday Shankar <ushankar@purestorage.com>

There are currently two ways in which ublk server exit is detected by
ublk_drv:

1. uring_cmd cancellation. If there are any outstanding uring_cmds which
   have not been completed to the ublk server when it exits, io_uring
   calls the uring_cmd callback with a special cancellation flag as the
   issuing task is exiting.
2. I/O timeout. This is needed in addition to the above to handle the
   "saturated queue" case, when all I/Os for a given queue are in the
   ublk server, and therefore there are no outstanding uring_cmds to
   cancel when the ublk server exits.

There are a couple of issues with this approach:

- It is complex and inelegant to have two methods to detect the same
  condition
- The second method detects ublk server exit only after a long delay
  (~30s, the default timeout assigned by the block layer). This delays
  the nosrv behavior from kicking in and potential subsequent recovery
  of the device.

The second issue is brought to light with the new test_generic_06 which
will be added in following patch. It fails before this fix:

selftests: ublk: test_generic_06.sh
dev id is 0
dd: error writing '/dev/ublkb0': Input/output error
1+0 records in
0+0 records out
0 bytes copied, 30.0611 s, 0.0 kB/s
DEAD
dd took 31 seconds to exit (>= 5s tolerance)!
generic_06 : [FAIL]

Fix this by instead detecting and handling ublk server exit in the
character file release callback. This has several advantages:

- This one place can handle both saturated and unsaturated queues. Thus,
  it replaces both preexisting methods of detecting ublk server exit.
- It runs quickly on ublk server exit - there is no 30s delay.
- It starts the process of removing task references in ublk_drv. This is
  needed if we want to relax restrictions in the driver like letting
  only one thread serve each queue

There is also the disadvantage that the character file release callback
can also be triggered by intentional close of the file, which is a
significant behavior change. Preexisting ublk servers (libublksrv) are
dependent on the ability to open/close the file multiple times. To
address this, only transition to a nosrv state if the file is released
while the ublk device is live. This allows for programs to open/close
the file multiple times during setup. It is still a behavior change if a
ublk server decides to close/reopen the file while the device is LIVE
(i.e. while it is responsible for serving I/O), but that would be highly
unusual. This behavior is in line with what is done by FUSE, which is
very similar to ublk in that a userspace daemon is providing services
traditionally provided by the kernel.

With this change in, the new test (and all other selftests, and all
ublksrv tests) pass:

selftests: ublk: test_generic_06.sh
dev id is 0
dd: error writing '/dev/ublkb0': Input/output error
1+0 records in
0+0 records out
0 bytes copied, 0.0376731 s, 0.0 kB/s
DEAD
generic_04 : [PASS]

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 223 +++++++++++++++++++++------------------
 1 file changed, 123 insertions(+), 100 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1fe39cf85b2f..b0a7e5acb2eb 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -199,8 +199,6 @@ struct ublk_device {
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
 	unsigned int		nr_privileged_daemon;
-
-	struct work_struct	nosrv_work;
 };
 
 /* header of ublk_params */
@@ -209,8 +207,9 @@ struct ublk_params_header {
 	__u32	types;
 };
 
-static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
-
+static void ublk_stop_dev_unlocked(struct ublk_device *ub);
+static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
+static void __ublk_quiesce_dev(struct ublk_device *ub);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		struct ublk_queue *ubq, int tag, size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
@@ -1336,8 +1335,6 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 {
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
-	unsigned int nr_inflight = 0;
-	int i;
 
 	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
 		if (!ubq->timeout) {
@@ -1348,26 +1345,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 		return BLK_EH_DONE;
 	}
 
-	if (!ubq_daemon_is_dying(ubq))
-		return BLK_EH_RESET_TIMER;
-
-	for (i = 0; i < ubq->q_depth; i++) {
-		struct ublk_io *io = &ubq->ios[i];
-
-		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
-			nr_inflight++;
-	}
-
-	/* cancelable uring_cmd can't help us if all commands are in-flight */
-	if (nr_inflight == ubq->q_depth) {
-		struct ublk_device *ub = ubq->dev;
-
-		if (ublk_abort_requests(ub, ubq)) {
-			schedule_work(&ub->nosrv_work);
-		}
-		return BLK_EH_DONE;
-	}
-
 	return BLK_EH_RESET_TIMER;
 }
 
@@ -1525,13 +1502,105 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 	ub->nr_privileged_daemon = 0;
 }
 
+static struct gendisk *ublk_get_disk(struct ublk_device *ub)
+{
+	struct gendisk *disk;
+
+	spin_lock(&ub->lock);
+	disk = ub->ub_disk;
+	if (disk)
+		get_device(disk_to_dev(disk));
+	spin_unlock(&ub->lock);
+
+	return disk;
+}
+
+static void ublk_put_disk(struct gendisk *disk)
+{
+	if (disk)
+		put_device(disk_to_dev(disk));
+}
+
 static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
+	struct gendisk *disk;
+	int i;
+
+	/*
+	 * disk isn't attached yet, either device isn't live, or it has
+	 * been removed already, so we needn't to do anything
+	 */
+	disk = ublk_get_disk(ub);
+	if (!disk)
+		goto out;
+
+	/*
+	 * All uring_cmd are done now, so abort any request outstanding to
+	 * the ublk server
+	 *
+	 * This can be done in lockless way because ublk server has been
+	 * gone
+	 *
+	 * More importantly, we have to provide forward progress guarantee
+	 * without holding ub->mutex, otherwise control task grabbing
+	 * ub->mutex triggers deadlock
+	 *
+	 * All requests may be inflight, so ->canceling may not be set, set
+	 * it now.
+	 */
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		ubq->canceling = true;
+		ublk_abort_queue(ub, ubq);
+	}
+	blk_mq_kick_requeue_list(disk->queue);
+
+	/*
+	 * All infligh requests have been completed or requeued and any new
+	 * request will be failed or requeued via `->canceling` now, so it is
+	 * fine to grab ub->mutex now.
+	 */
+	mutex_lock(&ub->mutex);
+
+	/* double check after grabbing lock */
+	if (!ub->ub_disk)
+		goto unlock;
+
+	/*
+	 * Transition the device to the nosrv state. What exactly this
+	 * means depends on the recovery flags
+	 */
+	blk_mq_quiesce_queue(disk->queue);
+	if (ublk_nosrv_should_stop_dev(ub)) {
+		/*
+		 * Allow any pending/future I/O to pass through quickly
+		 * with an error. This is needed because del_gendisk
+		 * waits for all pending I/O to complete
+		 */
+		for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+			ublk_get_queue(ub, i)->force_abort = true;
+		blk_mq_unquiesce_queue(disk->queue);
+
+		ublk_stop_dev_unlocked(ub);
+	} else {
+		if (ublk_nosrv_dev_should_queue_io(ub)) {
+			__ublk_quiesce_dev(ub);
+		} else {
+			ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
+			for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+				ublk_get_queue(ub, i)->fail_io = true;
+		}
+		blk_mq_unquiesce_queue(disk->queue);
+	}
+unlock:
+	mutex_unlock(&ub->mutex);
+	ublk_put_disk(disk);
 
 	/* all uring_cmd has been done now, reset device & ubq */
 	ublk_reset_ch_dev(ub);
-
+out:
 	clear_bit(UB_STATE_OPEN, &ub->state);
 	return 0;
 }
@@ -1627,37 +1696,22 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 }
 
 /* Must be called when queue is frozen */
-static bool ublk_mark_queue_canceling(struct ublk_queue *ubq)
+static void ublk_mark_queue_canceling(struct ublk_queue *ubq)
 {
-	bool canceled;
-
 	spin_lock(&ubq->cancel_lock);
-	canceled = ubq->canceling;
-	if (!canceled)
+	if (!ubq->canceling)
 		ubq->canceling = true;
 	spin_unlock(&ubq->cancel_lock);
-
-	return canceled;
 }
 
-static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
+static void ublk_start_cancel(struct ublk_queue *ubq)
 {
-	bool was_canceled = ubq->canceling;
-	struct gendisk *disk;
-
-	if (was_canceled)
-		return false;
-
-	spin_lock(&ub->lock);
-	disk = ub->ub_disk;
-	if (disk)
-		get_device(disk_to_dev(disk));
-	spin_unlock(&ub->lock);
+	struct ublk_device *ub = ubq->dev;
+	struct gendisk *disk = ublk_get_disk(ub);
 
 	/* Our disk has been dead */
 	if (!disk)
-		return false;
-
+		return;
 	/*
 	 * Now we are serialized with ublk_queue_rq()
 	 *
@@ -1666,15 +1720,9 @@ static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
 	 * touch completed uring_cmd
 	 */
 	blk_mq_quiesce_queue(disk->queue);
-	was_canceled = ublk_mark_queue_canceling(ubq);
-	if (!was_canceled) {
-		/* abort queue is for making forward progress */
-		ublk_abort_queue(ub, ubq);
-	}
+	ublk_mark_queue_canceling(ubq);
 	blk_mq_unquiesce_queue(disk->queue);
-	put_device(disk_to_dev(disk));
-
-	return !was_canceled;
+	ublk_put_disk(disk);
 }
 
 static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
@@ -1698,6 +1746,17 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
 /*
  * The ublk char device won't be closed when calling cancel fn, so both
  * ublk device and queue are guaranteed to be live
+ *
+ * Two-stage cancel:
+ *
+ * - make every active uring_cmd done in ->cancel_fn()
+ *
+ * - aborting inflight ublk IO requests in ublk char device release handler,
+ *   which depends on 1st stage because device can only be closed iff all
+ *   uring_cmd are done
+ *
+ * Do _not_ try to acquire ub->mutex before all inflight requests are
+ * aborted, otherwise deadlock may be caused.
  */
 static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
@@ -1705,8 +1764,6 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
 	struct task_struct *task;
-	struct ublk_device *ub;
-	bool need_schedule;
 	struct ublk_io *io;
 
 	if (WARN_ON_ONCE(!ubq))
@@ -1719,16 +1776,12 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	if (WARN_ON_ONCE(task && task != ubq->ubq_daemon))
 		return;
 
-	ub = ubq->dev;
-	need_schedule = ublk_abort_requests(ub, ubq);
+	if (!ubq->canceling)
+		ublk_start_cancel(ubq);
 
 	io = &ubq->ios[pdu->tag];
 	WARN_ON_ONCE(io->cmd != cmd);
 	ublk_cancel_cmd(ubq, io, issue_flags);
-
-	if (need_schedule) {
-		schedule_work(&ub->nosrv_work);
-	}
 }
 
 static inline bool ublk_queue_ready(struct ublk_queue *ubq)
@@ -1787,13 +1840,11 @@ static void __ublk_quiesce_dev(struct ublk_device *ub)
 			__func__, ub->dev_info.dev_id,
 			ub->dev_info.state == UBLK_S_DEV_LIVE ?
 			"LIVE" : "QUIESCED");
-	blk_mq_quiesce_queue(ub->ub_disk->queue);
 	/* mark every queue as canceling */
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_get_queue(ub, i)->canceling = true;
 	ublk_wait_tagset_rqs_idle(ub);
 	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
-	blk_mq_unquiesce_queue(ub->ub_disk->queue);
 }
 
 static void ublk_force_abort_dev(struct ublk_device *ub)
@@ -1830,50 +1881,25 @@ static struct gendisk *ublk_detach_disk(struct ublk_device *ub)
 	return disk;
 }
 
-static void ublk_stop_dev(struct ublk_device *ub)
+static void ublk_stop_dev_unlocked(struct ublk_device *ub)
+	__must_hold(&ub->mutex)
 {
 	struct gendisk *disk;
 
-	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
-		goto unlock;
+		return;
+
 	if (ublk_nosrv_dev_should_queue_io(ub))
 		ublk_force_abort_dev(ub);
 	del_gendisk(ub->ub_disk);
 	disk = ublk_detach_disk(ub);
 	put_disk(disk);
- unlock:
-	mutex_unlock(&ub->mutex);
-	ublk_cancel_dev(ub);
 }
 
-static void ublk_nosrv_work(struct work_struct *work)
+static void ublk_stop_dev(struct ublk_device *ub)
 {
-	struct ublk_device *ub =
-		container_of(work, struct ublk_device, nosrv_work);
-	int i;
-
-	if (ublk_nosrv_should_stop_dev(ub)) {
-		ublk_stop_dev(ub);
-		return;
-	}
-
 	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
-		goto unlock;
-
-	if (ublk_nosrv_dev_should_queue_io(ub)) {
-		__ublk_quiesce_dev(ub);
-	} else {
-		blk_mq_quiesce_queue(ub->ub_disk->queue);
-		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
-		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-			ublk_get_queue(ub, i)->fail_io = true;
-		}
-		blk_mq_unquiesce_queue(ub->ub_disk->queue);
-	}
-
- unlock:
+	ublk_stop_dev_unlocked(ub);
 	mutex_unlock(&ub->mutex);
 	ublk_cancel_dev(ub);
 }
@@ -2502,7 +2528,6 @@ static void ublk_remove(struct ublk_device *ub)
 	bool unprivileged;
 
 	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->nosrv_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
 	unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
 	ublk_put_device(ub);
@@ -2787,7 +2812,6 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 		goto out_unlock;
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->lock);
-	INIT_WORK(&ub->nosrv_work, ublk_nosrv_work);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
 	if (ret < 0)
@@ -2919,7 +2943,6 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
 static int ublk_ctrl_stop_dev(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->nosrv_work);
 	return 0;
 }
 
-- 
2.47.0


