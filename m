Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E3170E7DD
	for <lists+linux-block@lfdr.de>; Tue, 23 May 2023 23:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbjEWVrY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 May 2023 17:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbjEWVrV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 17:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC0818E
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684878389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OTVayQTP1dhlLa4ni7VZ3jGZ3Jhye6Ab4mQLwtPJXYA=;
        b=ZLO58RqfH3BQOTno8mx0ASMOaq4qG5ATKCh51raFn4Kgb8AI3Rjibcht6GsNYB22FLpKEJ
        EqJLGCrEPt5a7OvPubwvFVutRs11ev87SzEWB2DXoghWF03EFBn/8NeBFTa084+KniCGCE
        6kmdeS6zSLnTwlxN2ezKPmssnhGCvx8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-qJqshg8qPHG857rVrQoeuA-1; Tue, 23 May 2023 17:46:28 -0400
X-MC-Unique: qJqshg8qPHG857rVrQoeuA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62386d1f3ecso857376d6.2
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878387; x=1687470387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTVayQTP1dhlLa4ni7VZ3jGZ3Jhye6Ab4mQLwtPJXYA=;
        b=C0HhPfrWyL0fxKrkjdRwGRe6AmGKZcZGFMCBc3l1NOQ6iLLlLm0trqFcCfxl75pgGa
         eRcPM53x+tVWaf/b0HZ5MwnBNQ5z1VAM4UUYdMS22hRfDTf421woQk0YyhY1LLuDqNSz
         VyjUiaLlHtVMwU1k6S0mfLU4JbElj5fIkkpHxQgYGFvfUkS3bXIskcl7VOCx9LDHxY7g
         wI8EZeIXFeTDF3nD7matXl2NAW0Qvs2MI4qQ9wxF+9UejrCiCXm6y3si2WUbhhso1/hR
         OL9zAdB074W5owL7mo91cGqLB296p1yVhjthdbCf2BuUKWYeRYys1rXdUGyQ/fKR1Fht
         sg4Q==
X-Gm-Message-State: AC+VfDx6i54XsCE2ByBkDL55kPKmipmvPtEjR6rbYf9xhO0oZl5u1+Wg
        GpUNUl3tncaxjGMnBEfYAsu5ZxpHJ9KbTXwWwEj0gY3KMWCeoQAIIteB+fPNMO0EOVwttJprVqX
        lLD4hOcqVE5CnvkCvHgwkmC3CjHlKyP8=
X-Received: by 2002:a05:6214:2306:b0:61b:6fcd:34b7 with SMTP id gc6-20020a056214230600b0061b6fcd34b7mr28327017qvb.17.1684878386660;
        Tue, 23 May 2023 14:46:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Q+Yoz25SMByRTOnbMoU6h1KdwtlRnMJEdMFAl6TfhY001J7N6s1noXPe12sIvClkBzjjGdA==
X-Received: by 2002:a05:6214:2306:b0:61b:6fcd:34b7 with SMTP id gc6-20020a056214230600b0061b6fcd34b7mr28326982qvb.17.1684878386048;
        Tue, 23 May 2023 14:46:26 -0700 (PDT)
Received: from bf36-1.. (173-166-2-198-newengland.hfc.comcastbusiness.net. [173.166.2.198])
        by smtp.gmail.com with ESMTPSA id el14-20020ad459ce000000b0062119a7a7a3sm3086780qvb.4.2023.05.23.14.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:46:25 -0700 (PDT)
From:   "J. corwin Coburn" <corwin@redhat.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org
Cc:     vdo-devel@redhat.com, "J. corwin Coburn" <corwin@redhat.com>
Subject: [PATCH v2 20/39] Add flush support to vdo.
Date:   Tue, 23 May 2023 17:45:20 -0400
Message-Id: <20230523214539.226387-21-corwin@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523214539.226387-1-corwin@redhat.com>
References: <20230523214539.226387-1-corwin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds support for handling incoming flush and/or FUA bios. Each
such bio is assigned to a struct vdo_flush. These are allocated as needed,
but there is always one kept in reserve in case allocations fail. In the
event of an allocation failure, bios may need to wait for an outstanding
flush to complete.

The logical address space is partitioned into logical zones, each handled
by its own thread. Each zone keeps a list of all data_vios handling write
requests for logical addresses in that zone. When a flush bio is processed,
each logical zone is informed of the flush. When all of the writes which
are in progress at the time of the notification have completed in all
zones, the flush bio is then allowed to complete.

Signed-off-by: J. corwin Coburn <corwin@redhat.com>
---
 drivers/md/dm-vdo/flush.c        | 563 +++++++++++++++++++++++++++++++
 drivers/md/dm-vdo/flush.h        |  44 +++
 drivers/md/dm-vdo/logical-zone.c | 378 +++++++++++++++++++++
 drivers/md/dm-vdo/logical-zone.h |  87 +++++
 4 files changed, 1072 insertions(+)
 create mode 100644 drivers/md/dm-vdo/flush.c
 create mode 100644 drivers/md/dm-vdo/flush.h
 create mode 100644 drivers/md/dm-vdo/logical-zone.c
 create mode 100644 drivers/md/dm-vdo/logical-zone.h

diff --git a/drivers/md/dm-vdo/flush.c b/drivers/md/dm-vdo/flush.c
new file mode 100644
index 00000000000..e5088ac08a6
--- /dev/null
+++ b/drivers/md/dm-vdo/flush.c
@@ -0,0 +1,563 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright Red Hat
+ */
+
+#include "flush.h"
+
+#include <linux/mempool.h>
+#include <linux/spinlock.h>
+
+#include "logger.h"
+#include "memory-alloc.h"
+#include "permassert.h"
+
+#include "admin-state.h"
+#include "completion.h"
+#include "io-submitter.h"
+#include "logical-zone.h"
+#include "slab-depot.h"
+#include "types.h"
+#include "vdo.h"
+
+struct flusher {
+	struct vdo_completion completion;
+	/** The vdo to which this flusher belongs */
+	struct vdo *vdo;
+	/** The administrative state of the flusher */
+	struct admin_state state;
+	/** The current flush generation of the vdo */
+	sequence_number_t flush_generation;
+	/** The first unacknowledged flush generation */
+	sequence_number_t first_unacknowledged_generation;
+	/** The queue of flush requests waiting to notify other threads */
+	struct wait_queue notifiers;
+	/** The queue of flush requests waiting for VIOs to complete */
+	struct wait_queue pending_flushes;
+	/** The flush generation for which notifications are being sent */
+	sequence_number_t notify_generation;
+	/** The logical zone to notify next */
+	struct logical_zone *logical_zone_to_notify;
+	/** The ID of the thread on which flush requests should be made */
+	thread_id_t thread_id;
+	/** The pool of flush requests */
+	mempool_t *flush_pool;
+	/** Bios waiting for a flush request to become available */
+	struct bio_list waiting_flush_bios;
+	/** The lock to protect the previous fields */
+	spinlock_t lock;
+	/** The rotor for selecting the bio queue for submitting flush bios */
+	zone_count_t bio_queue_rotor;
+	/** The number of flushes submitted to the current bio queue */
+	int flush_count;
+};
+
+/**
+ * assert_on_flusher_thread() - Check that we are on the flusher thread.
+ * @flusher: The flusher.
+ * @caller: The function which is asserting.
+ */
+static inline void assert_on_flusher_thread(struct flusher *flusher, const char *caller)
+{
+	ASSERT_LOG_ONLY((vdo_get_callback_thread_id() == flusher->thread_id),
+			"%s() called from flusher thread",
+			caller);
+}
+
+/**
+ * as_flusher() - Convert a generic vdo_completion to a flusher.
+ * @completion: The completion to convert.
+ *
+ * Return: The completion as a flusher.
+ */
+static struct flusher *as_flusher(struct vdo_completion *completion)
+{
+	vdo_assert_completion_type(completion, VDO_FLUSH_NOTIFICATION_COMPLETION);
+	return container_of(completion, struct flusher, completion);
+}
+
+/**
+ * completion_as_vdo_flush() - Convert a generic vdo_completion to a vdo_flush.
+ * @completion: The completion to convert.
+ *
+ * Return: The completion as a vdo_flush.
+ */
+static inline struct vdo_flush *completion_as_vdo_flush(struct vdo_completion *completion)
+{
+	vdo_assert_completion_type(completion, VDO_FLUSH_COMPLETION);
+	return container_of(completion, struct vdo_flush, completion);
+}
+
+/**
+ * waiter_as_flush() - Convert a vdo_flush's generic wait queue entry back to the vdo_flush.
+ * @waiter: The wait queue entry to convert.
+ *
+ * Return: The wait queue entry as a vdo_flush.
+ */
+static struct vdo_flush *waiter_as_flush(struct waiter *waiter)
+{
+	return container_of(waiter, struct vdo_flush, waiter);
+}
+
+static void *allocate_flush(gfp_t gfp_mask, void *pool_data)
+{
+	struct vdo_flush *flush;
+
+	if ((gfp_mask & GFP_NOWAIT) == GFP_NOWAIT) {
+		flush = UDS_ALLOCATE_NOWAIT(struct vdo_flush, __func__);
+	} else {
+		int result = UDS_ALLOCATE(1, struct vdo_flush, __func__, &flush);
+
+		if (result != VDO_SUCCESS)
+			uds_log_error_strerror(result, "failed to allocate spare flush");
+	}
+
+	if (flush != NULL) {
+		struct flusher *flusher = pool_data;
+
+		vdo_initialize_completion(&flush->completion, flusher->vdo, VDO_FLUSH_COMPLETION);
+	}
+
+	return flush;
+}
+
+static void free_flush(void *element, void *pool_data __always_unused)
+{
+	UDS_FREE(element);
+}
+
+/**
+ * vdo_make_flusher() - Make a flusher for a vdo.
+ * @vdo: The vdo which owns the flusher.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+int vdo_make_flusher(struct vdo *vdo)
+{
+	int result = UDS_ALLOCATE(1, struct flusher, __func__, &vdo->flusher);
+
+	if (result != VDO_SUCCESS)
+		return result;
+
+	vdo->flusher->vdo = vdo;
+	vdo->flusher->thread_id = vdo->thread_config.packer_thread;
+	vdo_set_admin_state_code(&vdo->flusher->state, VDO_ADMIN_STATE_NORMAL_OPERATION);
+	vdo_initialize_completion(&vdo->flusher->completion, vdo,
+				  VDO_FLUSH_NOTIFICATION_COMPLETION);
+
+	spin_lock_init(&vdo->flusher->lock);
+	bio_list_init(&vdo->flusher->waiting_flush_bios);
+	vdo->flusher->flush_pool = mempool_create(1, allocate_flush, free_flush, vdo->flusher);
+	return ((vdo->flusher->flush_pool == NULL) ? -ENOMEM : VDO_SUCCESS);
+}
+
+/**
+ * vdo_free_flusher() - Free a flusher.
+ * @flusher: The flusher to free.
+ */
+void vdo_free_flusher(struct flusher *flusher)
+{
+	if (flusher == NULL)
+		return;
+
+	if (flusher->flush_pool != NULL)
+		mempool_destroy(UDS_FORGET(flusher->flush_pool));
+	UDS_FREE(flusher);
+}
+
+/**
+ * vdo_get_flusher_thread_id() - Get the ID of the thread on which flusher functions should be
+ *                               called.
+ * @flusher: The flusher to query.
+ *
+ * Return: The ID of the thread which handles the flusher.
+ */
+thread_id_t vdo_get_flusher_thread_id(struct flusher *flusher)
+{
+	return flusher->thread_id;
+}
+
+static void notify_flush(struct flusher *flusher);
+static void vdo_complete_flush(struct vdo_flush *flush);
+
+/**
+ * finish_notification() - Finish the notification process.
+ * @completion: The flusher completion.
+ *
+ * Finishes the notification process by checking if any flushes have completed and then starting
+ * the notification of the next flush request if one came in while the current notification was in
+ * progress. This callback is registered in flush_packer_callback().
+ */
+static void finish_notification(struct vdo_completion *completion)
+{
+	struct flusher *flusher = as_flusher(completion);
+
+	assert_on_flusher_thread(flusher, __func__);
+
+	vdo_enqueue_waiter(&flusher->pending_flushes,
+			   vdo_dequeue_next_waiter(&flusher->notifiers));
+	vdo_complete_flushes(flusher);
+	if (vdo_has_waiters(&flusher->notifiers))
+		notify_flush(flusher);
+}
+
+/**
+ * flush_packer_callback() - Flush the packer.
+ * @completion: The flusher completion.
+ *
+ * Flushes the packer now that all of the logical and physical zones have been notified of the new
+ * flush request. This callback is registered in increment_generation().
+ */
+static void flush_packer_callback(struct vdo_completion *completion)
+{
+	struct flusher *flusher = as_flusher(completion);
+
+	vdo_increment_packer_flush_generation(flusher->vdo->packer);
+	vdo_launch_completion_callback(completion, finish_notification, flusher->thread_id);
+}
+
+/**
+ * increment_generation() - Increment the flush generation in a logical zone.
+ * @completion: The flusher as a completion.
+ *
+ * If there are more logical zones, go on to the next one, otherwise, prepare the physical zones.
+ * This callback is registered both in notify_flush() and in itself.
+ */
+static void increment_generation(struct vdo_completion *completion)
+{
+	struct flusher *flusher = as_flusher(completion);
+	struct logical_zone *zone = flusher->logical_zone_to_notify;
+
+	vdo_increment_logical_zone_flush_generation(zone, flusher->notify_generation);
+	if (zone->next == NULL) {
+		vdo_launch_completion_callback(completion,
+					       flush_packer_callback,
+					       flusher->thread_id);
+		return;
+	}
+
+	flusher->logical_zone_to_notify = zone->next;
+	vdo_launch_completion_callback(completion,
+				       increment_generation,
+				       flusher->logical_zone_to_notify->thread_id);
+}
+
+/**
+ * notify_flush() - Launch a flush notification.
+ * @flusher: The flusher doing the notification.
+ */
+static void notify_flush(struct flusher *flusher)
+{
+	struct vdo_flush *flush = waiter_as_flush(vdo_get_first_waiter(&flusher->notifiers));
+
+	flusher->notify_generation = flush->flush_generation;
+	flusher->logical_zone_to_notify = &flusher->vdo->logical_zones->zones[0];
+	flusher->completion.requeue = true;
+	vdo_launch_completion_callback(&flusher->completion,
+				       increment_generation,
+				       flusher->logical_zone_to_notify->thread_id);
+}
+
+/**
+ * flush_vdo() - Start processing a flush request.
+ * @completion: A flush request (as a vdo_completion)
+ *
+ * This callback is registered in launch_flush().
+ */
+static void flush_vdo(struct vdo_completion *completion)
+{
+	struct vdo_flush *flush = completion_as_vdo_flush(completion);
+	struct flusher *flusher = completion->vdo->flusher;
+	bool may_notify;
+	int result;
+
+	assert_on_flusher_thread(flusher, __func__);
+	result = ASSERT(vdo_is_state_normal(&flusher->state), "flusher is in normal operation");
+	if (result != VDO_SUCCESS) {
+		vdo_enter_read_only_mode(flusher->vdo, result);
+		vdo_complete_flush(flush);
+		return;
+	}
+
+	flush->flush_generation = flusher->flush_generation++;
+	may_notify = !vdo_has_waiters(&flusher->notifiers);
+	vdo_enqueue_waiter(&flusher->notifiers, &flush->waiter);
+	if (may_notify)
+		notify_flush(flusher);
+}
+
+/**
+ * check_for_drain_complete() - Check whether the flusher has drained.
+ * @flusher: The flusher.
+ */
+static void check_for_drain_complete(struct flusher *flusher)
+{
+	bool drained;
+
+	if (!vdo_is_state_draining(&flusher->state) || vdo_has_waiters(&flusher->pending_flushes))
+		return;
+
+	spin_lock(&flusher->lock);
+	drained = bio_list_empty(&flusher->waiting_flush_bios);
+	spin_unlock(&flusher->lock);
+
+	if (drained)
+		vdo_finish_draining(&flusher->state);
+}
+
+/**
+ * vdo_complete_flushes() - Attempt to complete any flushes which might have finished.
+ * @flusher: The flusher.
+ */
+void vdo_complete_flushes(struct flusher *flusher)
+{
+	sequence_number_t oldest_active_generation = U64_MAX;
+	struct logical_zone *zone;
+
+	assert_on_flusher_thread(flusher, __func__);
+
+	for (zone = &flusher->vdo->logical_zones->zones[0]; zone != NULL; zone = zone->next)
+		oldest_active_generation =
+			min(oldest_active_generation, READ_ONCE(zone->oldest_active_generation));
+
+	while (vdo_has_waiters(&flusher->pending_flushes)) {
+		struct vdo_flush *flush =
+			waiter_as_flush(vdo_get_first_waiter(&flusher->pending_flushes));
+
+		if (flush->flush_generation >= oldest_active_generation)
+			return;
+
+		ASSERT_LOG_ONLY((flush->flush_generation ==
+				 flusher->first_unacknowledged_generation),
+				"acknowledged next expected flush, %llu, was: %llu",
+				(unsigned long long) flusher->first_unacknowledged_generation,
+				(unsigned long long) flush->flush_generation);
+		vdo_dequeue_next_waiter(&flusher->pending_flushes);
+		vdo_complete_flush(flush);
+		flusher->first_unacknowledged_generation++;
+	}
+
+	check_for_drain_complete(flusher);
+}
+
+/**
+ * vdo_dump_flusher() - Dump the flusher, in a thread-unsafe fashion.
+ * @flusher: The flusher.
+ */
+void vdo_dump_flusher(const struct flusher *flusher)
+{
+	uds_log_info("struct flusher");
+	uds_log_info("  flush_generation=%llu first_unacknowledged_generation=%llu",
+		     (unsigned long long) flusher->flush_generation,
+		     (unsigned long long) flusher->first_unacknowledged_generation);
+	uds_log_info("  notifiers queue is %s; pending_flushes queue is %s",
+		     (vdo_has_waiters(&flusher->notifiers) ? "not empty" : "empty"),
+		     (vdo_has_waiters(&flusher->pending_flushes) ? "not empty" : "empty"));
+}
+
+/**
+ * initialize_flush() - Initialize a vdo_flush structure.
+ * @flush: The flush to initialize.
+ * @vdo: The vdo being flushed.
+ *
+ * Initializes a vdo_flush structure, transferring all the bios in the flusher's waiting_flush_bios
+ * list to it. The caller MUST already hold the lock.
+ */
+static void initialize_flush(struct vdo_flush *flush, struct vdo *vdo)
+{
+	bio_list_init(&flush->bios);
+	bio_list_merge(&flush->bios, &vdo->flusher->waiting_flush_bios);
+	bio_list_init(&vdo->flusher->waiting_flush_bios);
+}
+
+static void launch_flush(struct vdo_flush *flush)
+{
+	struct vdo_completion *completion = &flush->completion;
+
+	vdo_prepare_completion(completion,
+			       flush_vdo,
+			       flush_vdo,
+			       completion->vdo->thread_config.packer_thread,
+			       NULL);
+	vdo_enqueue_completion(completion, VDO_DEFAULT_Q_FLUSH_PRIORITY);
+}
+
+/**
+ * vdo_launch_flush() - Function called to start processing a flush request.
+ * @vdo: The vdo.
+ * @bio: The bio containing an empty flush request.
+ *
+ * This is called when we receive an empty flush bio from the block layer, and before acknowledging
+ * a non-empty bio with the FUA flag set.
+ */
+void vdo_launch_flush(struct vdo *vdo, struct bio *bio)
+{
+	/*
+	 * Try to allocate a vdo_flush to represent the flush request. If the allocation fails,
+	 * we'll deal with it later.
+	 */
+	struct vdo_flush *flush = mempool_alloc(vdo->flusher->flush_pool, GFP_NOWAIT);
+	struct flusher *flusher = vdo->flusher;
+	const struct admin_state_code *code = vdo_get_admin_state_code(&flusher->state);
+
+	ASSERT_LOG_ONLY(!code->quiescent, "Flushing not allowed in state %s", code->name);
+
+	spin_lock(&flusher->lock);
+
+	/* We have a new bio to start. Add it to the list. */
+	bio_list_add(&flusher->waiting_flush_bios, bio);
+
+	if (flush == NULL) {
+		spin_unlock(&flusher->lock);
+		return;
+	}
+
+	/* We have flushes to start. Capture them in the vdo_flush structure. */
+	initialize_flush(flush, vdo);
+	spin_unlock(&flusher->lock);
+
+	/* Finish launching the flushes. */
+	launch_flush(flush);
+}
+
+/**
+ * release_flush() - Release a vdo_flush structure that has completed its work.
+ * @flush: The completed flush structure to re-use or free.
+ *
+ * If there are any pending flush requests whose vdo_flush allocation failed, they will be launched
+ * by immediately re-using the released vdo_flush. If there is no spare vdo_flush, the released
+ * structure will become the spare. Otherwise, the vdo_flush will be freed.
+ */
+static void release_flush(struct vdo_flush *flush)
+{
+	bool relaunch_flush;
+	struct flusher *flusher = flush->completion.vdo->flusher;
+
+	spin_lock(&flusher->lock);
+	if (bio_list_empty(&flusher->waiting_flush_bios)) {
+		relaunch_flush = false;
+	} else {
+		/* We have flushes to start. Capture them in a flush request. */
+		initialize_flush(flush, flusher->vdo);
+		relaunch_flush = true;
+	}
+	spin_unlock(&flusher->lock);
+
+	if (relaunch_flush) {
+		/* Finish launching the flushes. */
+		launch_flush(flush);
+		return;
+	}
+
+	mempool_free(flush, flusher->flush_pool);
+}
+
+/**
+ * vdo_complete_flush_callback() - Function called to complete and free a flush request, registered
+ *                                 in vdo_complete_flush().
+ * @completion: The flush request.
+ */
+static void vdo_complete_flush_callback(struct vdo_completion *completion)
+{
+	struct vdo_flush *flush = completion_as_vdo_flush(completion);
+	struct vdo *vdo = completion->vdo;
+	struct bio *bio;
+
+	while ((bio = bio_list_pop(&flush->bios)) != NULL) {
+		/*
+		 * We're not acknowledging this bio now, but we'll never touch it again, so this is
+		 * the last chance to account for it.
+		 */
+		vdo_count_bios(&vdo->stats.bios_acknowledged, bio);
+
+		/* Update the device, and send it on down... */
+		bio_set_dev(bio, vdo_get_backing_device(vdo));
+		atomic64_inc(&vdo->stats.flush_out);
+		submit_bio_noacct(bio);
+	}
+
+
+	/*
+	 * Release the flush structure, freeing it, re-using it as the spare, or using it to launch
+	 * any flushes that had to wait when allocations failed.
+	 */
+	release_flush(flush);
+}
+
+/**
+ * select_bio_queue() - Select the bio queue on which to finish a flush request.
+ * @flusher: The flusher finishing the request.
+ */
+static thread_id_t select_bio_queue(struct flusher *flusher)
+{
+	struct vdo *vdo = flusher->vdo;
+	zone_count_t bio_threads = flusher->vdo->thread_config.bio_thread_count;
+	int interval;
+
+	if (bio_threads == 1)
+		return vdo->thread_config.bio_threads[0];
+
+	interval = vdo->device_config->thread_counts.bio_rotation_interval;
+	if (flusher->flush_count == interval) {
+		flusher->flush_count = 1;
+		flusher->bio_queue_rotor = ((flusher->bio_queue_rotor + 1) % bio_threads);
+	} else {
+		flusher->flush_count++;
+	}
+
+	return vdo->thread_config.bio_threads[flusher->bio_queue_rotor];
+}
+
+/**
+ * vdo_complete_flush() - Complete and free a vdo flush request.
+ * @flush: The flush request.
+ */
+static void vdo_complete_flush(struct vdo_flush *flush)
+{
+	struct vdo_completion *completion = &flush->completion;
+
+	vdo_prepare_completion(completion,
+			       vdo_complete_flush_callback,
+			       vdo_complete_flush_callback,
+			       select_bio_queue(completion->vdo->flusher),
+			       NULL);
+	vdo_enqueue_completion(completion, BIO_Q_FLUSH_PRIORITY);
+}
+
+/**
+ * initiate_drain() - Initiate a drain.
+ *
+ * Implements vdo_admin_initiator.
+ */
+static void initiate_drain(struct admin_state *state)
+{
+	check_for_drain_complete(container_of(state, struct flusher, state));
+}
+
+/**
+ * vdo_drain_flusher() - Drain the flusher.
+ * @flusher: The flusher to drain.
+ * @completion: The completion to finish when the flusher has drained.
+ *
+ * Drains the flusher by preventing any more VIOs from entering the flusher and then flushing. The
+ * flusher will be left in the suspended state.
+ */
+void vdo_drain_flusher(struct flusher *flusher, struct vdo_completion *completion)
+{
+	assert_on_flusher_thread(flusher, __func__);
+	vdo_start_draining(&flusher->state,
+			   VDO_ADMIN_STATE_SUSPENDING,
+			   completion,
+			   initiate_drain);
+}
+
+/**
+ * vdo_resume_flusher() - Resume a flusher which has been suspended.
+ * @flusher: The flusher to resume.
+ * @parent: The completion to finish when the flusher has resumed.
+ */
+void vdo_resume_flusher(struct flusher *flusher, struct vdo_completion *parent)
+{
+	assert_on_flusher_thread(flusher, __func__);
+	vdo_continue_completion(parent, vdo_resume_if_quiescent(&flusher->state));
+}
diff --git a/drivers/md/dm-vdo/flush.h b/drivers/md/dm-vdo/flush.h
new file mode 100644
index 00000000000..2e66a477d5d
--- /dev/null
+++ b/drivers/md/dm-vdo/flush.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Red Hat
+ */
+
+#ifndef VDO_FLUSH_H
+#define VDO_FLUSH_H
+
+#include "types.h"
+#include "vio.h"
+#include "wait-queue.h"
+#include "work-queue.h"
+
+/* A marker for tracking which journal entries are affected by a flush request. */
+struct vdo_flush {
+	/* The completion for enqueueing this flush request. */
+	struct vdo_completion completion;
+	/* The flush bios covered by this request */
+	struct bio_list bios;
+	/* The wait queue entry for this flush */
+	struct waiter waiter;
+	/* Which flush this struct represents */
+	sequence_number_t flush_generation;
+};
+
+struct flusher;
+
+int __must_check vdo_make_flusher(struct vdo *vdo);
+
+void vdo_free_flusher(struct flusher *flusher);
+
+thread_id_t __must_check vdo_get_flusher_thread_id(struct flusher *flusher);
+
+void vdo_complete_flushes(struct flusher *flusher);
+
+void vdo_dump_flusher(const struct flusher *flusher);
+
+void vdo_launch_flush(struct vdo *vdo, struct bio *bio);
+
+void vdo_drain_flusher(struct flusher *flusher, struct vdo_completion *completion);
+
+void vdo_resume_flusher(struct flusher *flusher, struct vdo_completion *parent);
+
+#endif /* VDO_FLUSH_H */
diff --git a/drivers/md/dm-vdo/logical-zone.c b/drivers/md/dm-vdo/logical-zone.c
new file mode 100644
index 00000000000..6fffac8169a
--- /dev/null
+++ b/drivers/md/dm-vdo/logical-zone.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright Red Hat
+ */
+
+#include "logical-zone.h"
+
+#include "logger.h"
+#include "memory-alloc.h"
+#include "permassert.h"
+#include "string-utils.h"
+
+#include "action-manager.h"
+#include "admin-state.h"
+#include "block-map.h"
+#include "completion.h"
+#include "constants.h"
+#include "data-vio.h"
+#include "flush.h"
+#include "int-map.h"
+#include "physical-zone.h"
+#include "vdo.h"
+
+enum {
+	ALLOCATIONS_PER_ZONE = 128,
+};
+
+/**
+ * as_logical_zone() - Convert a generic vdo_completion to a logical_zone.
+ * @completion: The completion to convert.
+ *
+ * Return: The completion as a logical_zone.
+ */
+static struct logical_zone *as_logical_zone(struct vdo_completion *completion)
+{
+	vdo_assert_completion_type(completion, VDO_GENERATION_FLUSHED_COMPLETION);
+	return container_of(completion, struct logical_zone, completion);
+}
+
+/* get_thread_id_for_zone() - Implements vdo_zone_thread_getter. */
+static thread_id_t get_thread_id_for_zone(void *context, zone_count_t zone_number)
+{
+	struct logical_zones *zones = context;
+
+	return zones->zones[zone_number].thread_id;
+}
+
+/**
+ * initialize_zone() - Initialize a logical zone.
+ * @zones: The logical_zones to which this zone belongs.
+ * @zone_number: The logical_zone's index.
+ */
+static int initialize_zone(struct logical_zones *zones, zone_count_t zone_number)
+{
+	int result;
+	struct vdo *vdo = zones->vdo;
+	struct logical_zone *zone = &zones->zones[zone_number];
+	zone_count_t allocation_zone_number;
+
+	result = vdo_make_int_map(VDO_LOCK_MAP_CAPACITY, 0, &zone->lbn_operations);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	if (zone_number < vdo->thread_config.logical_zone_count - 1)
+		zone->next = &zones->zones[zone_number + 1];
+
+	vdo_initialize_completion(&zone->completion, vdo, VDO_GENERATION_FLUSHED_COMPLETION);
+	zone->zones = zones;
+	zone->zone_number = zone_number;
+	zone->thread_id = vdo->thread_config.logical_threads[zone_number];
+	zone->block_map_zone = &vdo->block_map->zones[zone_number];
+	INIT_LIST_HEAD(&zone->write_vios);
+	vdo_set_admin_state_code(&zone->state, VDO_ADMIN_STATE_NORMAL_OPERATION);
+
+	allocation_zone_number = zone->thread_id % vdo->thread_config.physical_zone_count;
+	zone->allocation_zone = &vdo->physical_zones->zones[allocation_zone_number];
+
+	return vdo_make_default_thread(vdo, zone->thread_id);
+}
+
+/**
+ * vdo_make_logical_zones() - Create a set of logical zones.
+ * @vdo: The vdo to which the zones will belong.
+ * @zones_ptr: A pointer to hold the new zones.
+ *
+ * Return: VDO_SUCCESS or an error code.
+ */
+int vdo_make_logical_zones(struct vdo *vdo, struct logical_zones **zones_ptr)
+{
+	struct logical_zones *zones;
+	int result;
+	zone_count_t zone;
+	zone_count_t zone_count = vdo->thread_config.logical_zone_count;
+
+	if (zone_count == 0)
+		return VDO_SUCCESS;
+
+	result = UDS_ALLOCATE_EXTENDED(struct logical_zones, zone_count,
+				       struct logical_zone, __func__, &zones);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	zones->vdo = vdo;
+	zones->zone_count = zone_count;
+	for (zone = 0; zone < zone_count; zone++) {
+		result = initialize_zone(zones, zone);
+		if (result != VDO_SUCCESS) {
+			vdo_free_logical_zones(zones);
+			return result;
+		}
+	}
+
+	result = vdo_make_action_manager(zones->zone_count,
+					 get_thread_id_for_zone,
+					 vdo->thread_config.admin_thread,
+					 zones,
+					 NULL,
+					 vdo,
+					 &zones->manager);
+	if (result != VDO_SUCCESS) {
+		vdo_free_logical_zones(zones);
+		return result;
+	}
+
+	*zones_ptr = zones;
+	return VDO_SUCCESS;
+}
+
+/**
+ * vdo_free_logical_zones() - Free a set of logical zones.
+ * @zones: The set of zones to free.
+ */
+void vdo_free_logical_zones(struct logical_zones *zones)
+{
+	zone_count_t index;
+
+	if (zones == NULL)
+		return;
+
+	UDS_FREE(UDS_FORGET(zones->manager));
+
+	for (index = 0; index < zones->zone_count; index++)
+		vdo_free_int_map(UDS_FORGET(zones->zones[index].lbn_operations));
+
+	UDS_FREE(zones);
+}
+
+static inline void assert_on_zone_thread(struct logical_zone *zone, const char *what)
+{
+	ASSERT_LOG_ONLY((vdo_get_callback_thread_id() == zone->thread_id),
+			"%s() called on correct thread", what);
+}
+
+/**
+ * check_for_drain_complete() - Check whether this zone has drained.
+ * @zone: The zone to check.
+ */
+static void check_for_drain_complete(struct logical_zone *zone)
+{
+	if (!vdo_is_state_draining(&zone->state) || zone->notifying ||
+	    !list_empty(&zone->write_vios))
+		return;
+
+	vdo_finish_draining(&zone->state);
+}
+
+/**
+ * initiate_drain() - Initiate a drain.
+ *
+ * Implements vdo_admin_initiator.
+ */
+static void initiate_drain(struct admin_state *state)
+{
+	check_for_drain_complete(container_of(state, struct logical_zone, state));
+}
+
+/**
+ * drain_logical_zone() - Drain a logical zone.
+ *
+ * Implements vdo_zone_action.
+ */
+static void
+drain_logical_zone(void *context, zone_count_t zone_number, struct vdo_completion *parent)
+{
+	struct logical_zones *zones = context;
+
+	vdo_start_draining(&zones->zones[zone_number].state,
+			   vdo_get_current_manager_operation(zones->manager),
+			   parent,
+			   initiate_drain);
+}
+
+void vdo_drain_logical_zones(struct logical_zones *zones,
+			     const struct admin_state_code *operation,
+			     struct vdo_completion *parent)
+{
+	vdo_schedule_operation(zones->manager, operation, NULL, drain_logical_zone, NULL, parent);
+}
+
+/**
+ * resume_logical_zone() - Resume a logical zone.
+ *
+ * Implements vdo_zone_action.
+ */
+static void
+resume_logical_zone(void *context, zone_count_t zone_number, struct vdo_completion *parent)
+{
+	struct logical_zone *zone = &(((struct logical_zones *) context)->zones[zone_number]);
+
+	vdo_fail_completion(parent, vdo_resume_if_quiescent(&zone->state));
+}
+
+/**
+ * vdo_resume_logical_zones() - Resume a set of logical zones.
+ * @zones: The logical zones to resume.
+ * @parent: The object to notify when the zones have resumed.
+ */
+void vdo_resume_logical_zones(struct logical_zones *zones, struct vdo_completion *parent)
+{
+	vdo_schedule_operation(zones->manager, VDO_ADMIN_STATE_RESUMING, NULL,
+			       resume_logical_zone, NULL, parent);
+}
+
+/**
+ * update_oldest_active_generation() - Update the oldest active generation.
+ * @zone: The zone.
+ *
+ * Return: true if the oldest active generation has changed.
+ */
+static bool update_oldest_active_generation(struct logical_zone *zone)
+{
+	struct data_vio *data_vio =
+		list_first_entry_or_null(&zone->write_vios, struct data_vio, write_entry);
+	sequence_number_t oldest =
+		(data_vio == NULL) ? zone->flush_generation : data_vio->flush_generation;
+
+	if (oldest == zone->oldest_active_generation)
+		return false;
+
+	WRITE_ONCE(zone->oldest_active_generation, oldest);
+	return true;
+}
+
+/**
+ * vdo_increment_logical_zone_flush_generation() - Increment the flush generation in a logical
+ *                                                 zone.
+ * @zone: The logical zone.
+ * @expected_generation: The expected value of the flush generation before the increment.
+ */
+void vdo_increment_logical_zone_flush_generation(struct logical_zone *zone,
+						 sequence_number_t expected_generation)
+{
+	assert_on_zone_thread(zone, __func__);
+	ASSERT_LOG_ONLY((zone->flush_generation == expected_generation),
+			"logical zone %u flush generation %llu should be %llu before increment",
+			zone->zone_number,
+			(unsigned long long) zone->flush_generation,
+			(unsigned long long) expected_generation);
+
+	zone->flush_generation++;
+	zone->ios_in_flush_generation = 0;
+	update_oldest_active_generation(zone);
+}
+
+/**
+ * vdo_acquire_flush_generation_lock() - Acquire the shared lock on a flush generation by a write
+ *                                       data_vio.
+ * @data_vio: The data_vio.
+ */
+void vdo_acquire_flush_generation_lock(struct data_vio *data_vio)
+{
+	struct logical_zone *zone = data_vio->logical.zone;
+
+	assert_on_zone_thread(zone, __func__);
+	ASSERT_LOG_ONLY(vdo_is_state_normal(&zone->state), "vdo state is normal");
+
+	data_vio->flush_generation = zone->flush_generation;
+	list_add_tail(&data_vio->write_entry, &zone->write_vios);
+	zone->ios_in_flush_generation++;
+}
+
+static void attempt_generation_complete_notification(struct vdo_completion *completion);
+
+/**
+ * notify_flusher() - Notify the flush that at least one generation no longer has active VIOs.
+ * @completion: The zone completion.
+ *
+ * This callback is registered in attempt_generation_complete_notification().
+ */
+static void notify_flusher(struct vdo_completion *completion)
+{
+	struct logical_zone *zone = as_logical_zone(completion);
+
+	vdo_complete_flushes(zone->zones->vdo->flusher);
+	vdo_launch_completion_callback(completion,
+				       attempt_generation_complete_notification,
+				       zone->thread_id);
+}
+
+/**
+ * void attempt_generation_complete_notification() - Notify the flusher if some generation no
+ *                                                   longer has active VIOs.
+ * @completion: The zone completion.
+ */
+static void attempt_generation_complete_notification(struct vdo_completion *completion)
+{
+	struct logical_zone *zone = as_logical_zone(completion);
+
+	assert_on_zone_thread(zone, __func__);
+	if (zone->oldest_active_generation <= zone->notification_generation) {
+		zone->notifying = false;
+		check_for_drain_complete(zone);
+		return;
+	}
+
+	zone->notifying = true;
+	zone->notification_generation = zone->oldest_active_generation;
+	vdo_launch_completion_callback(&zone->completion, notify_flusher,
+				       vdo_get_flusher_thread_id(zone->zones->vdo->flusher));
+}
+
+/**
+ * vdo_release_flush_generation_lock() - Release the shared lock on a flush generation held by a
+ *                                       write data_vio.
+ * @data_vio: The data_vio whose lock is to be released.
+ *
+ * If there are pending flushes, and this data_vio completes the oldest generation active in this
+ * zone, an attempt will be made to finish any flushes which may now be complete.
+ */
+void vdo_release_flush_generation_lock(struct data_vio *data_vio)
+{
+	struct logical_zone *zone = data_vio->logical.zone;
+
+	assert_on_zone_thread(zone, __func__);
+
+	if (!data_vio_has_flush_generation_lock(data_vio))
+		return;
+
+	list_del_init(&data_vio->write_entry);
+	ASSERT_LOG_ONLY((zone->oldest_active_generation <= data_vio->flush_generation),
+			"data_vio releasing lock on generation %llu is not older than oldest active generation %llu",
+			(unsigned long long) data_vio->flush_generation,
+			(unsigned long long) zone->oldest_active_generation);
+
+	if (!update_oldest_active_generation(zone) || zone->notifying)
+		return;
+
+	attempt_generation_complete_notification(&zone->completion);
+}
+
+struct physical_zone *vdo_get_next_allocation_zone(struct logical_zone *zone)
+{
+	if (zone->allocation_count == ALLOCATIONS_PER_ZONE) {
+		zone->allocation_count = 0;
+		zone->allocation_zone = zone->allocation_zone->next;
+	}
+
+	zone->allocation_count++;
+	return zone->allocation_zone;
+}
+
+/**
+ * vdo_dump_logical_zone() - Dump information about a logical zone to the log for debugging.
+ * @zone: The zone to dump
+ *
+ * Context: the information is dumped in a thread-unsafe fashion.
+ *
+ */
+void vdo_dump_logical_zone(const struct logical_zone *zone)
+{
+	uds_log_info("logical_zone %u", zone->zone_number);
+	uds_log_info("  flush_generation=%llu oldest_active_generation=%llu notification_generation=%llu notifying=%s ios_in_flush_generation=%llu",
+		     (unsigned long long) READ_ONCE(zone->flush_generation),
+		     (unsigned long long) READ_ONCE(zone->oldest_active_generation),
+		     (unsigned long long) READ_ONCE(zone->notification_generation),
+		     uds_bool_to_string(READ_ONCE(zone->notifying)),
+		     (unsigned long long) READ_ONCE(zone->ios_in_flush_generation));
+}
diff --git a/drivers/md/dm-vdo/logical-zone.h b/drivers/md/dm-vdo/logical-zone.h
new file mode 100644
index 00000000000..3da788b0c2f
--- /dev/null
+++ b/drivers/md/dm-vdo/logical-zone.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Red Hat
+ */
+
+#ifndef VDO_LOGICAL_ZONE_H
+#define VDO_LOGICAL_ZONE_H
+
+#include <linux/list.h>
+
+#include "admin-state.h"
+#include "int-map.h"
+#include "types.h"
+
+struct physical_zone;
+
+struct logical_zone {
+	/* The completion for flush notifications */
+	struct vdo_completion completion;
+	/* The owner of this zone */
+	struct logical_zones *zones;
+	/* Which logical zone this is */
+	zone_count_t zone_number;
+	/* The thread id for this zone */
+	thread_id_t thread_id;
+	/* In progress operations keyed by LBN */
+	struct int_map *lbn_operations;
+	/* The logical to physical map */
+	struct block_map_zone *block_map_zone;
+	/* The current flush generation */
+	sequence_number_t flush_generation;
+	/*
+	 * The oldest active generation in this zone. This is mutated only on the logical zone
+	 * thread but is queried from the flusher thread.
+	 */
+	sequence_number_t oldest_active_generation;
+	/* The number of IOs in the current flush generation */
+	block_count_t ios_in_flush_generation;
+	/* The youngest generation of the current notification */
+	sequence_number_t notification_generation;
+	/* Whether a notification is in progress */
+	bool notifying;
+	/* The queue of active data write VIOs */
+	struct list_head write_vios;
+	/* The administrative state of the zone */
+	struct admin_state state;
+	/* The physical zone from which to allocate */
+	struct physical_zone *allocation_zone;
+	/* The number of allocations done from the current allocation_zone */
+	block_count_t allocation_count;
+	/* The next zone */
+	struct logical_zone *next;
+};
+
+struct logical_zones {
+	/* The vdo whose zones these are */
+	struct vdo *vdo;
+	/* The manager for administrative actions */
+	struct action_manager *manager;
+	/* The number of zones */
+	zone_count_t zone_count;
+	/* The logical zones themselves */
+	struct logical_zone zones[];
+};
+
+int __must_check vdo_make_logical_zones(struct vdo *vdo, struct logical_zones **zones_ptr);
+
+void vdo_free_logical_zones(struct logical_zones *zones);
+
+void vdo_drain_logical_zones(struct logical_zones *zones,
+			     const struct admin_state_code *operation,
+			     struct vdo_completion *completion);
+
+void vdo_resume_logical_zones(struct logical_zones *zones, struct vdo_completion *parent);
+
+void vdo_increment_logical_zone_flush_generation(struct logical_zone *zone,
+						 sequence_number_t expected_generation);
+
+void vdo_acquire_flush_generation_lock(struct data_vio *data_vio);
+
+void vdo_release_flush_generation_lock(struct data_vio *data_vio);
+
+struct physical_zone * __must_check vdo_get_next_allocation_zone(struct logical_zone *zone);
+
+void vdo_dump_logical_zone(const struct logical_zone *zone);
+
+#endif /* VDO_LOGICAL_ZONE_H */
-- 
2.40.1

