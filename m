Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8073E70E7D8
	for <lists+linux-block@lfdr.de>; Tue, 23 May 2023 23:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbjEWVrR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 May 2023 17:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbjEWVrQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 17:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF90718B
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684878389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ke1eCwBP0RTdaZa3vgY8qnR5bHXgYqeN6rhMYhqlaCM=;
        b=J6hy77KEokjp8oaNKm1vxPNhwwLX8NqKuLNyaKaz75s3gKV5peafR4ppmPQZir2MiRnC77
        cau8Evu/qicPGQxax37GVgpuCnHBRaQXRfQUaPJHnZGvrMNF7m6BcxHQZpM7/Z5gJ+RXXr
        TAsh6LCdQfLFJ9rYeNuzzrnnWlClzRs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-YaXqlMBJNGG0wUB9BKh1kg-1; Tue, 23 May 2023 17:46:28 -0400
X-MC-Unique: YaXqlMBJNGG0wUB9BKh1kg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6239c7547f7so819636d6.3
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878387; x=1687470387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke1eCwBP0RTdaZa3vgY8qnR5bHXgYqeN6rhMYhqlaCM=;
        b=Zb/McXJj5JOxXrNDQ1ynSpsX3DbChRsM4sWteInToYuDi/bZaah+OxxxVgwZoNi7Ya
         D/eheRMHM3Qts7rP3tX00du6vvFLrGI48eOqvph2JpACtf7NY1Av940DQs6mZMxtTUXV
         4u1XdHuHoIJSWjJMmKPYsLzFm+PscY5cpi3IMTlwlgGWJGRXTRzs355G0IR1HLmTer01
         YaZeG4FW2hoy4dXPdbbuHWxXMVEUUCi0SWqV3SAyPnFFcFrVmL/2lOWhBuzNYPJTrguM
         7++BUGnohltyrdj5whwMuF106AuZ0EzOH3VTJ0VW1R7XaA0/syFLrG362nF59RHCyXe2
         OUHg==
X-Gm-Message-State: AC+VfDxuPy1Qey9bZnqkd1a6164gzBa3AW6MvmIxEtaDxuUIf4awhxBc
        MyaispcMEVIkjziWpJ1TX19C0Z1npfRsZM5c0Es5SjoFO5VWQ9MtgBxX8stR6lkXPOAvR+D6wv7
        km3dT8UO/Bd6mmqe0flYV7EQ=
X-Received: by 2002:ad4:5be3:0:b0:625:976b:c5fb with SMTP id k3-20020ad45be3000000b00625976bc5fbmr4676769qvc.50.1684878387221;
        Tue, 23 May 2023 14:46:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6hjhRhRvDG1I9BNXXjQq9Id8vwU2tHQABecRsqVdXU7OmFzkXe2VkZJlN99U8h7VOrLO2FQw==
X-Received: by 2002:ad4:5be3:0:b0:625:976b:c5fb with SMTP id k3-20020ad45be3000000b00625976bc5fbmr4676738qvc.50.1684878386736;
        Tue, 23 May 2023 14:46:26 -0700 (PDT)
Received: from bf36-1.. (173-166-2-198-newengland.hfc.comcastbusiness.net. [173.166.2.198])
        by smtp.gmail.com with ESMTPSA id el14-20020ad459ce000000b0062119a7a7a3sm3086780qvb.4.2023.05.23.14.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:46:26 -0700 (PDT)
From:   "J. corwin Coburn" <corwin@redhat.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org
Cc:     vdo-devel@redhat.com, "J. corwin Coburn" <corwin@redhat.com>
Subject: [PATCH v2 21/39] Add the vdo io_submitter.
Date:   Tue, 23 May 2023 17:45:21 -0400
Message-Id: <20230523214539.226387-22-corwin@redhat.com>
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

The io_submitter handles bio submission from vdo data store to the storage
below. It will merge bios when possible.

Signed-off-by: J. corwin Coburn <corwin@redhat.com>
---
 drivers/md/dm-vdo/io-submitter.c | 483 +++++++++++++++++++++++++++++++
 drivers/md/dm-vdo/io-submitter.h |  52 ++++
 2 files changed, 535 insertions(+)
 create mode 100644 drivers/md/dm-vdo/io-submitter.c
 create mode 100644 drivers/md/dm-vdo/io-submitter.h

diff --git a/drivers/md/dm-vdo/io-submitter.c b/drivers/md/dm-vdo/io-submitter.c
new file mode 100644
index 00000000000..a77f6c4ec7a
--- /dev/null
+++ b/drivers/md/dm-vdo/io-submitter.c
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright Red Hat
+ */
+
+#include "io-submitter.h"
+
+#include <linux/bio.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+
+#include "memory-alloc.h"
+#include "permassert.h"
+
+#include "data-vio.h"
+#include "logger.h"
+#include "types.h"
+#include "vdo.h"
+#include "vio.h"
+
+/*
+ * Submission of bio operations to the underlying storage device will go through a separate work
+ * queue thread (or more than one) to prevent blocking in other threads if the storage device has a
+ * full queue. The plug structure allows that thread to do better batching of requests to make the
+ * I/O more efficient.
+ *
+ * When multiple worker threads are used, a thread is chosen for a I/O operation submission based
+ * on the PBN, so a given PBN will consistently wind up on the same thread. Flush operations are
+ * assigned round-robin.
+ *
+ * The map (protected by the mutex) collects pending I/O operations so that the worker thread can
+ * reorder them to try to encourage I/O request merging in the request queue underneath.
+ */
+struct bio_queue_data {
+	struct vdo_work_queue *queue;
+	struct blk_plug plug;
+	struct int_map *map;
+	struct mutex lock;
+	unsigned int queue_number;
+};
+
+struct io_submitter {
+	unsigned int num_bio_queues_used;
+	unsigned int bio_queue_rotation_interval;
+	struct bio_queue_data bio_queue_data[];
+};
+
+static void start_bio_queue(void *ptr)
+{
+	struct bio_queue_data *bio_queue_data = (struct bio_queue_data *) ptr;
+
+	blk_start_plug(&bio_queue_data->plug);
+}
+
+static void finish_bio_queue(void *ptr)
+{
+	struct bio_queue_data *bio_queue_data = (struct bio_queue_data *) ptr;
+
+	blk_finish_plug(&bio_queue_data->plug);
+}
+
+static const struct vdo_work_queue_type bio_queue_type = {
+	.start = start_bio_queue,
+	.finish = finish_bio_queue,
+	.max_priority = BIO_Q_MAX_PRIORITY,
+	.default_priority = BIO_Q_DATA_PRIORITY,
+};
+
+/**
+ * count_all_bios() - Determine which bio counter to use.
+ * @vio: The vio associated with the bio.
+ * @bio: The bio to count.
+ */
+static void count_all_bios(struct vio *vio, struct bio *bio)
+{
+	struct atomic_statistics *stats = &vio->completion.vdo->stats;
+
+	if (is_data_vio(vio)) {
+		vdo_count_bios(&stats->bios_out, bio);
+		return;
+	}
+
+	vdo_count_bios(&stats->bios_meta, bio);
+	if (vio->type == VIO_TYPE_RECOVERY_JOURNAL)
+		vdo_count_bios(&stats->bios_journal, bio);
+	else if (vio->type == VIO_TYPE_BLOCK_MAP)
+		vdo_count_bios(&stats->bios_page_cache, bio);
+}
+
+/**
+ * assert_in_bio_zone() - Assert that a vio is in the correct bio zone and not in interrupt
+ *                        context.
+ * @vio: The vio to check.
+ */
+static void assert_in_bio_zone(struct vio *vio)
+{
+	ASSERT_LOG_ONLY(!in_interrupt(), "not in interrupt context");
+	assert_vio_in_bio_zone(vio);
+}
+
+/**
+ * send_bio_to_device() - Update stats and tracing info, then submit the supplied bio to the OS for
+ *                        processing.
+ * @vio: The vio associated with the bio.
+ * @bio: The bio to submit to the OS.
+ */
+static void send_bio_to_device(struct vio *vio, struct bio *bio)
+{
+	struct vdo *vdo = vio->completion.vdo;
+
+	assert_in_bio_zone(vio);
+	atomic64_inc(&vdo->stats.bios_submitted);
+	count_all_bios(vio, bio);
+	bio_set_dev(bio, vdo_get_backing_device(vdo));
+	submit_bio_noacct(bio);
+}
+
+static sector_t get_bio_sector(struct bio *bio)
+{
+	return bio->bi_iter.bi_sector;
+}
+
+/**
+ * process_vio_io() - Submits a vio's bio to the underlying block device. May block if the device
+ *                    is busy. This callback should be used by vios which did not attempt to merge.
+ */
+void process_vio_io(struct vdo_completion *completion)
+{
+	struct vio *vio = as_vio(completion);
+
+	send_bio_to_device(vio, vio->bio);
+}
+
+/**
+ * get_bio_list() - Extract the list of bios to submit from a vio.
+ * @vio: The vio submitting I/O.
+ *
+ * The list will always contain at least one entry (the bio for the vio on which it is called), but
+ * other bios may have been merged with it as well.
+ *
+ * Return: bio  The head of the bio list to submit.
+ */
+static struct bio *get_bio_list(struct vio *vio)
+{
+	struct bio *bio;
+	struct io_submitter *submitter = vio->completion.vdo->io_submitter;
+	struct bio_queue_data *bio_queue_data = &(submitter->bio_queue_data[vio->bio_zone]);
+
+	assert_in_bio_zone(vio);
+
+	mutex_lock(&bio_queue_data->lock);
+	vdo_int_map_remove(bio_queue_data->map, get_bio_sector(vio->bios_merged.head));
+	vdo_int_map_remove(bio_queue_data->map, get_bio_sector(vio->bios_merged.tail));
+	bio = vio->bios_merged.head;
+	bio_list_init(&vio->bios_merged);
+	mutex_unlock(&bio_queue_data->lock);
+
+	return bio;
+}
+
+/**
+ * process_data_vio_io() - Submit a data_vio's bio to the storage below along with any bios that
+ *                         have been merged with it.
+ *
+ * Context: This call may block and so should only be called from a bio thread.
+ */
+static void process_data_vio_io(struct vdo_completion *completion)
+{
+	struct bio *bio, *next;
+	struct vio *vio = as_vio(completion);
+
+	assert_in_bio_zone(vio);
+	for (bio = get_bio_list(vio); bio != NULL; bio = next) {
+		next = bio->bi_next;
+		bio->bi_next = NULL;
+		send_bio_to_device((struct vio *) bio->bi_private, bio);
+	}
+}
+
+/**
+ * get_mergeable_locked() - Attempt to find an already queued bio that the current bio can be
+ *                          merged with.
+ * @map: The bio map to use for merging.
+ * @vio: The vio we want to merge.
+ * @back_merge: Set to true for a back merge, false for a front merge.
+ *
+ * There are two types of merging possible, forward and backward, which are distinguished by a flag
+ * that uses kernel elevator terminology.
+ *
+ * Return: the vio to merge to, NULL if no merging is possible.
+ */
+static struct vio *get_mergeable_locked(struct int_map *map, struct vio *vio, bool back_merge)
+{
+	struct bio *bio = vio->bio;
+	sector_t merge_sector = get_bio_sector(bio);
+	struct vio *vio_merge;
+
+	if (back_merge)
+		merge_sector -= VDO_SECTORS_PER_BLOCK;
+	else
+		merge_sector += VDO_SECTORS_PER_BLOCK;
+
+	vio_merge = vdo_int_map_get(map, merge_sector);
+
+	if (vio_merge == NULL)
+		return NULL;
+
+	if (vio->completion.priority != vio_merge->completion.priority)
+		return NULL;
+
+	if (bio_data_dir(bio) != bio_data_dir(vio_merge->bio))
+		return NULL;
+
+	if (bio_list_empty(&vio_merge->bios_merged))
+		return NULL;
+
+	if (back_merge)
+		return ((get_bio_sector(vio_merge->bios_merged.tail) == merge_sector) ?
+			vio_merge :
+			NULL);
+
+	return ((get_bio_sector(vio_merge->bios_merged.head) == merge_sector) ? vio_merge : NULL);
+}
+
+static int map_merged_vio(struct int_map *bio_map, struct vio *vio)
+{
+	int result;
+
+	result = vdo_int_map_put(bio_map, get_bio_sector(vio->bios_merged.head), vio, true, NULL);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	return vdo_int_map_put(bio_map, get_bio_sector(vio->bios_merged.tail), vio, true, NULL);
+}
+
+static int merge_to_prev_tail(struct int_map *bio_map, struct vio *vio, struct vio *prev_vio)
+{
+	vdo_int_map_remove(bio_map, get_bio_sector(prev_vio->bios_merged.tail));
+	bio_list_merge(&prev_vio->bios_merged, &vio->bios_merged);
+	return map_merged_vio(bio_map, prev_vio);
+}
+
+static int merge_to_next_head(struct int_map *bio_map, struct vio *vio, struct vio *next_vio)
+{
+	/*
+	 * Handle "next merge" and "gap fill" cases the same way so as to reorder bios in a way
+	 * that's compatible with using funnel queues in work queues. This avoids removing an
+	 * existing completion.
+	 */
+	vdo_int_map_remove(bio_map, get_bio_sector(next_vio->bios_merged.head));
+	bio_list_merge_head(&next_vio->bios_merged, &vio->bios_merged);
+	return map_merged_vio(bio_map, next_vio);
+}
+
+/**
+ * try_bio_map_merge() - Attempt to merge a vio's bio with other pending I/Os.
+ * @vio: The vio to merge.
+ *
+ * Currently this is only used for data_vios, but is broken out for future use with metadata vios.
+ *
+ * Return: whether or not the vio was merged.
+ */
+static bool try_bio_map_merge(struct vio *vio)
+{
+	int result;
+	bool merged = true;
+	struct bio *bio = vio->bio;
+	struct vio *prev_vio, *next_vio;
+	struct vdo *vdo = vio->completion.vdo;
+	struct bio_queue_data *bio_queue_data = &vdo->io_submitter->bio_queue_data[vio->bio_zone];
+
+	bio->bi_next = NULL;
+	bio_list_init(&vio->bios_merged);
+	bio_list_add(&vio->bios_merged, bio);
+
+	mutex_lock(&bio_queue_data->lock);
+	prev_vio = get_mergeable_locked(bio_queue_data->map, vio, true);
+	next_vio = get_mergeable_locked(bio_queue_data->map, vio, false);
+	if (prev_vio == next_vio)
+		next_vio = NULL;
+
+	if ((prev_vio == NULL) && (next_vio == NULL)) {
+		/* no merge. just add to bio_queue */
+		merged = false;
+		result = vdo_int_map_put(bio_queue_data->map,
+					 get_bio_sector(bio),
+					 vio,
+					 true,
+					 NULL);
+	} else if (next_vio == NULL) {
+		/* Only prev. merge to prev's tail */
+		result = merge_to_prev_tail(bio_queue_data->map, vio, prev_vio);
+	} else {
+		/* Only next. merge to next's head */
+		result = merge_to_next_head(bio_queue_data->map, vio, next_vio);
+	}
+
+	mutex_unlock(&bio_queue_data->lock);
+
+	/* We don't care about failure of int_map_put in this case. */
+	ASSERT_LOG_ONLY(result == UDS_SUCCESS, "bio map insertion succeeds");
+	return merged;
+}
+
+/**
+ * submit_data_vio_io() - Submit I/O for a data_vio.
+ * @data_vio: the data_vio for which to issue I/O.
+ *
+ * If possible, this I/O will be merged other pending I/Os. Otherwise, the data_vio will be sent to
+ * the appropriate bio zone directly.
+ */
+void submit_data_vio_io(struct data_vio *data_vio)
+{
+	if (try_bio_map_merge(&data_vio->vio))
+		return;
+
+	launch_data_vio_bio_zone_callback(data_vio, process_data_vio_io);
+}
+
+/**
+ * vdo_submit_metadata_io() - Submit I/O for a metadata vio.
+ * @vio: the vio for which to issue I/O
+ * @physical: the physical block number to read or write
+ * @callback: the bio endio function which will be called after the I/O completes
+ * @error_handler: the handler for submission or I/O errors (may be NULL)
+ * @operation: the type of I/O to perform
+ * @data: the buffer to read or write (may be NULL)
+ *
+ * The vio is enqueued on a vdo bio queue so that bio submission (which may block) does not block
+ * other vdo threads.
+ *
+ * That the error handler will run on the correct thread is only true so long as the thread calling
+ * this function, and the thread set in the endio callback are the same, as well as the fact that
+ * no error can occur on the bio queue. Currently this is true for all callers, but additional care
+ * will be needed if this ever changes.
+ */
+void vdo_submit_metadata_io(struct vio *vio,
+			    physical_block_number_t physical,
+			    bio_end_io_t callback,
+			    vdo_action *error_handler,
+			    unsigned int operation,
+			    char *data)
+{
+	struct vdo_completion *completion = &vio->completion;
+	int result;
+	const struct admin_state_code *code = vdo_get_admin_state(completion->vdo);
+
+
+	ASSERT_LOG_ONLY(!code->quiescent, "I/O not allowed in state %s", code->name);
+	ASSERT_LOG_ONLY(vio->bio->bi_next == NULL, "metadata bio has no next bio");
+
+	vdo_reset_completion(completion);
+	completion->error_handler = error_handler;
+	result = vio_reset_bio(vio, data, callback, operation | REQ_META, physical);
+	if (result != VDO_SUCCESS) {
+		continue_vio(vio, result);
+		return;
+	}
+
+	vdo_set_completion_callback(completion, process_vio_io, get_vio_bio_zone_thread_id(vio));
+	vdo_launch_completion_with_priority(completion, get_metadata_priority(vio));
+}
+
+/**
+ * vdo_make_io_submitter() - Create an io_submitter structure.
+ * @thread_count: Number of bio-submission threads to set up.
+ * @rotation_interval: Interval to use when rotating between bio-submission threads when enqueuing
+ *                     completions.
+ * @max_requests_active: Number of bios for merge tracking.
+ * @vdo: The vdo which will use this submitter.
+ * @io_submitter: pointer to the new data structure.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+int vdo_make_io_submitter(unsigned int thread_count,
+			  unsigned int rotation_interval,
+			  unsigned int max_requests_active,
+			  struct vdo *vdo,
+			  struct io_submitter **io_submitter_ptr)
+{
+	unsigned int i;
+	struct io_submitter *io_submitter;
+	int result;
+
+	result = UDS_ALLOCATE_EXTENDED(struct io_submitter,
+				       thread_count,
+				       struct bio_queue_data,
+				       "bio submission data",
+				       &io_submitter);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	io_submitter->bio_queue_rotation_interval = rotation_interval;
+
+	/* Setup for each bio-submission work queue */
+	for (i = 0; i < thread_count; i++) {
+		struct bio_queue_data *bio_queue_data = &io_submitter->bio_queue_data[i];
+
+		mutex_init(&bio_queue_data->lock);
+		/*
+		 * One I/O operation per request, but both first & last sector numbers.
+		 *
+		 * If requests are assigned to threads round-robin, they should be distributed
+		 * quite evenly. But if they're assigned based on PBN, things can sometimes be very
+		 * uneven. So for now, we'll assume that all requests *may* wind up on one thread,
+		 * and thus all in the same map.
+		 */
+		result = vdo_make_int_map(max_requests_active * 2, 0, &bio_queue_data->map);
+		if (result != 0) {
+			/*
+			 * Clean up the partially initialized bio-queue entirely and indicate that
+			 * initialization failed.
+			 */
+			uds_log_error("bio map initialization failed %d", result);
+			vdo_cleanup_io_submitter(io_submitter);
+			vdo_free_io_submitter(io_submitter);
+			return result;
+		}
+
+		bio_queue_data->queue_number = i;
+		result = vdo_make_thread(vdo,
+					 vdo->thread_config.bio_threads[i],
+					 &bio_queue_type,
+					 1,
+					 (void **) &bio_queue_data);
+		if (result != VDO_SUCCESS) {
+			/*
+			 * Clean up the partially initialized bio-queue entirely and indicate that
+			 * initialization failed.
+			 */
+			vdo_free_int_map(UDS_FORGET(bio_queue_data->map));
+			uds_log_error("bio queue initialization failed %d", result);
+			vdo_cleanup_io_submitter(io_submitter);
+			vdo_free_io_submitter(io_submitter);
+			return result;
+		}
+
+		bio_queue_data->queue = vdo->threads[vdo->thread_config.bio_threads[i]].queue;
+		io_submitter->num_bio_queues_used++;
+	}
+
+	*io_submitter_ptr = io_submitter;
+
+	return VDO_SUCCESS;
+}
+
+/**
+ * vdo_cleanup_io_submitter() - Tear down the io_submitter fields as needed for a physical layer.
+ * @io_submitter: The I/O submitter data to tear down (may be NULL).
+ */
+void vdo_cleanup_io_submitter(struct io_submitter *io_submitter)
+{
+	int i;
+
+	if (io_submitter == NULL)
+		return;
+
+	for (i = io_submitter->num_bio_queues_used - 1; i >= 0; i--)
+		vdo_finish_work_queue(io_submitter->bio_queue_data[i].queue);
+}
+
+/**
+ * vdo_free_io_submitter() - Free the io_submitter fields and structure as needed.
+ * @io_submitter: The I/O submitter data to destroy.
+ *
+ * This must be called after vdo_cleanup_io_submitter(). It is used to release resources late in
+ * the shutdown process to avoid or reduce the chance of race conditions.
+ */
+void vdo_free_io_submitter(struct io_submitter *io_submitter)
+{
+	int i;
+
+	if (io_submitter == NULL)
+		return;
+
+	for (i = io_submitter->num_bio_queues_used - 1; i >= 0; i--) {
+		io_submitter->num_bio_queues_used--;
+		/* vdo_destroy() will free the work queue, so just give up our reference to it. */
+		UDS_FORGET(io_submitter->bio_queue_data[i].queue);
+		vdo_free_int_map(UDS_FORGET(io_submitter->bio_queue_data[i].map));
+	}
+	UDS_FREE(io_submitter);
+}
diff --git a/drivers/md/dm-vdo/io-submitter.h b/drivers/md/dm-vdo/io-submitter.h
new file mode 100644
index 00000000000..5bd05090f67
--- /dev/null
+++ b/drivers/md/dm-vdo/io-submitter.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Red Hat
+ */
+
+#ifndef VDO_IO_SUBMITTER_H
+#define VDO_IO_SUBMITTER_H
+
+#include <linux/bio.h>
+
+#include "types.h"
+
+struct io_submitter;
+
+int vdo_make_io_submitter(unsigned int thread_count,
+			  unsigned int rotation_interval,
+			  unsigned int max_requests_active,
+			  struct vdo *vdo,
+			  struct io_submitter **io_submitter);
+
+void vdo_cleanup_io_submitter(struct io_submitter *io_submitter);
+
+void vdo_free_io_submitter(struct io_submitter *io_submitter);
+
+void process_vio_io(struct vdo_completion *completion);
+
+void submit_data_vio_io(struct data_vio *data_vio);
+
+void vdo_submit_metadata_io(struct vio *vio,
+			    physical_block_number_t physical,
+			    bio_end_io_t callback,
+			    vdo_action *error_handler,
+			    unsigned int operation,
+			    char *data);
+
+static inline void submit_metadata_vio(struct vio *vio,
+				       physical_block_number_t physical,
+				       bio_end_io_t callback,
+				       vdo_action *error_handler,
+				       unsigned int operation)
+{
+	vdo_submit_metadata_io(vio, physical, callback, error_handler, operation, vio->data);
+}
+
+static inline void
+submit_flush_vio(struct vio *vio, bio_end_io_t callback, vdo_action *error_handler)
+{
+	/* FIXME: Can we just use REQ_OP_FLUSH? */
+	vdo_submit_metadata_io(vio, 0, callback, error_handler, REQ_OP_WRITE | REQ_PREFLUSH, NULL);
+}
+
+#endif /* VDO_IO_SUBMITTER_H */
-- 
2.40.1

