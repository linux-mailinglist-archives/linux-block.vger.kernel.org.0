Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8C97D8AD4
	for <lists+linux-block@lfdr.de>; Thu, 26 Oct 2023 23:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344913AbjJZVoh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Oct 2023 17:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjJZVoY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Oct 2023 17:44:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78199D58
        for <linux-block@vger.kernel.org>; Thu, 26 Oct 2023 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698356506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BbJB2yij4eneO6j8G/VsGLsB8aznACfTOUh/fqF9zq8=;
        b=FWEYlQiqBOYAsnjqmU3+eJGbM67KW5kRNoPMoEwbXZ1H1s2xaLi2AEKluReBaIr41hfcuo
        NfKVShT8uuk7q2e66FVyKuTnWLV8WKoZ9+xvDCwm+ebaXfWx+drXms5Byp3gYI7y6EL2dv
        e99/fSdIdNoLQwcX9cRbekJkrvoNFNY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-w6a2Z7dyOUS1poTitKVI_A-1; Thu, 26 Oct 2023 17:41:43 -0400
X-MC-Unique: w6a2Z7dyOUS1poTitKVI_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D960E80F922;
        Thu, 26 Oct 2023 21:41:42 +0000 (UTC)
Received: from pbitcolo-build-10.permabit.com (pbitcolo-build-10.permabit.lab.eng.bos.redhat.com [10.19.117.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C54402949;
        Thu, 26 Oct 2023 21:41:42 +0000 (UTC)
Received: by pbitcolo-build-10.permabit.com (Postfix, from userid 1138)
        id 850933003B; Thu, 26 Oct 2023 17:41:42 -0400 (EDT)
From:   Matthew Sakai <msakai@redhat.com>
To:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Cc:     Matthew Sakai <msakai@redhat.com>
Subject: [PATCH v4 33/39] dm vdo: add the primary vdo structure
Date:   Thu, 26 Oct 2023 17:41:30 -0400
Message-Id: <20231026214136.1067410-34-msakai@redhat.com>
In-Reply-To: <20231026214136.1067410-1-msakai@redhat.com>
References: <20231026214136.1067410-1-msakai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add the data and methods that manage the dm-vdo target itself. This
includes the overall state of the target and its threads, the state of
the logical volumes, startup, shutdown, and statistics.

Co-developed-by: J. corwin Coburn <corwin@hurlbutnet.net>
Signed-off-by: J. corwin Coburn <corwin@hurlbutnet.net>
Co-developed-by: Michael Sclafani <vdo-devel@redhat.com>
Signed-off-by: Michael Sclafani <vdo-devel@redhat.com>
Co-developed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Matthew Sakai <msakai@redhat.com>
---
 drivers/md/dm-vdo/vdo.c | 1845 +++++++++++++++++++++++++++++++++++++++
 drivers/md/dm-vdo/vdo.h |  381 ++++++++
 2 files changed, 2226 insertions(+)
 create mode 100644 drivers/md/dm-vdo/vdo.c
 create mode 100644 drivers/md/dm-vdo/vdo.h

diff --git a/drivers/md/dm-vdo/vdo.c b/drivers/md/dm-vdo/vdo.c
new file mode 100644
index 000000000000..72cbe6921893
--- /dev/null
+++ b/drivers/md/dm-vdo/vdo.c
@@ -0,0 +1,1845 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023 Red Hat
+ */
+
+/*
+ * This file contains the main entry points for normal operations on a vdo as well as functions for
+ * constructing and destroying vdo instances (in memory).
+ */
+
+/**
+ * DOC:
+ *
+ * A read_only_notifier has a single completion which is used to perform read-only notifications,
+ * however, vdo_enter_read_only_mode() may be called from any thread. A pair of fields, protected
+ * by a spinlock, are used to control the read-only mode entry process. The first field holds the
+ * read-only error. The second is the state field, which may hold any of the four special values
+ * enumerated here.
+ *
+ * When vdo_enter_read_only_mode() is called from some vdo thread, if the read_only_error field
+ * already contains an error (i.e. its value is not VDO_SUCCESS), then some other error has already
+ * initiated the read-only process, and nothing more is done. Otherwise, the new error is stored in
+ * the read_only_error field, and the state field is consulted. If the state is MAY_NOTIFY, it is
+ * set to NOTIFYING, and the notification process begins. If the state is MAY_NOT_NOTIFY, then
+ * notifications are currently disallowed, generally due to the vdo being suspended. In this case,
+ * the nothing more will be done until the vdo is resumed, at which point the notification will be
+ * performed. In any other case, the vdo is already read-only, and there is nothing more to do.
+ */
+
+#include "vdo.h"
+
+#include <linux/completion.h>
+#include <linux/device-mapper.h>
+#include <linux/kernel.h>
+#include <linux/lz4.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "logger.h"
+#include "memory-alloc.h"
+#include "permassert.h"
+#include "string-utils.h"
+
+#include "block-map.h"
+#include "completion.h"
+#include "data-vio.h"
+#include "dedupe.h"
+#include "encodings.h"
+#include "io-submitter.h"
+#include "logical-zone.h"
+#include "packer.h"
+#include "physical-zone.h"
+#include "pool-sysfs.h"
+#include "recovery-journal.h"
+#include "slab-depot.h"
+#include "statistics.h"
+#include "status-codes.h"
+#include "vio.h"
+#include "work-queue.h"
+
+
+enum { PARANOID_THREAD_CONSISTENCY_CHECKS = 0 };
+
+struct sync_completion {
+	struct vdo_completion vdo_completion;
+	struct completion completion;
+};
+
+/*
+ * We don't expect this set to ever get really large, so a linked list is adequate. We can use a
+ * pointer_map if we need to later.
+ */
+struct device_registry {
+	struct list_head links;
+	/* TODO: Convert to rcu per kernel recommendation. */
+	rwlock_t lock;
+};
+
+static struct device_registry registry;
+
+/**
+ * vdo_initialize_device_registry_once() - Initialize the necessary structures for the device
+ *                                         registry.
+ */
+void vdo_initialize_device_registry_once(void)
+{
+	INIT_LIST_HEAD(&registry.links);
+	rwlock_init(&registry.lock);
+}
+
+/** vdo_is_equal() - Implements vdo_filter_t. */
+static bool vdo_is_equal(struct vdo *vdo, const void *context)
+{
+	return ((void *) vdo == context);
+}
+
+/**
+ * filter_vdos_locked() - Find a vdo in the registry if it exists there.
+ * @filter: The filter function to apply to devices.
+ * @context: A bit of context to provide the filter.
+ *
+ * Context: Must be called holding the lock.
+ *
+ * Return: the vdo object found, if any.
+ */
+static struct vdo * __must_check filter_vdos_locked(vdo_filter_t *filter, const void *context)
+{
+	struct vdo *vdo;
+
+	list_for_each_entry(vdo, &registry.links, registration)
+		if (filter(vdo, context))
+			return vdo;
+
+	return NULL;
+}
+
+/**
+ * vdo_find_matching() - Find and return the first (if any) vdo matching a given filter function.
+ * @filter: The filter function to apply to vdos.
+ * @context: A bit of context to provide the filter.
+ */
+struct vdo *vdo_find_matching(vdo_filter_t *filter, const void *context)
+{
+	struct vdo *vdo;
+
+	read_lock(&registry.lock);
+	vdo = filter_vdos_locked(filter, context);
+	read_unlock(&registry.lock);
+	return vdo;
+}
+
+static void start_vdo_request_queue(void *ptr)
+{
+	struct vdo_thread *thread = vdo_get_work_queue_owner(vdo_get_current_work_queue());
+
+	uds_register_allocating_thread(&thread->allocating_thread,
+				       &thread->vdo->allocations_allowed);
+}
+
+static void finish_vdo_request_queue(void *ptr)
+{
+	uds_unregister_allocating_thread();
+}
+
+#ifdef MODULE
+#define MODULE_NAME THIS_MODULE->name
+#else
+#define MODULE_NAME "dm-vdo"
+#endif  /* MODULE */
+
+static const struct vdo_work_queue_type default_queue_type = {
+	.start = start_vdo_request_queue,
+	.finish = finish_vdo_request_queue,
+	.max_priority = VDO_DEFAULT_Q_MAX_PRIORITY,
+	.default_priority = VDO_DEFAULT_Q_COMPLETION_PRIORITY,
+};
+
+static const struct vdo_work_queue_type bio_ack_q_type = {
+	.start = NULL,
+	.finish = NULL,
+	.max_priority = BIO_ACK_Q_MAX_PRIORITY,
+	.default_priority = BIO_ACK_Q_ACK_PRIORITY,
+};
+
+static const struct vdo_work_queue_type cpu_q_type = {
+	.start = NULL,
+	.finish = NULL,
+	.max_priority = CPU_Q_MAX_PRIORITY,
+	.default_priority = CPU_Q_MAX_PRIORITY,
+};
+
+static void uninitialize_thread_config(struct thread_config *config)
+{
+	UDS_FREE(UDS_FORGET(config->logical_threads));
+	UDS_FREE(UDS_FORGET(config->physical_threads));
+	UDS_FREE(UDS_FORGET(config->hash_zone_threads));
+	UDS_FREE(UDS_FORGET(config->bio_threads));
+	memset(config, 0, sizeof(struct thread_config));
+}
+
+static void
+assign_thread_ids(struct thread_config *config, thread_id_t thread_ids[], zone_count_t count)
+{
+	zone_count_t zone;
+
+	for (zone = 0; zone < count; zone++)
+		thread_ids[zone] = config->thread_count++;
+}
+
+/**
+ * initialize_thread_config() - Initialize the thread mapping
+ *
+ * If the logical, physical, and hash zone counts are all 0, a single thread will be shared by all
+ * three plus the packer and recovery journal. Otherwise, there must be at least one of each type,
+ * and each will have its own thread, as will the packer and recovery journal.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+static int __must_check
+initialize_thread_config(struct thread_count_config counts, struct thread_config *config)
+{
+	int result;
+	bool single = ((counts.logical_zones + counts.physical_zones + counts.hash_zones) == 0);
+
+	config->bio_thread_count = counts.bio_threads;
+	if (single) {
+		config->logical_zone_count = 1;
+		config->physical_zone_count = 1;
+		config->hash_zone_count = 1;
+	} else {
+		config->logical_zone_count = counts.logical_zones;
+		config->physical_zone_count = counts.physical_zones;
+		config->hash_zone_count = counts.hash_zones;
+	}
+
+	result = UDS_ALLOCATE(config->logical_zone_count,
+			      thread_id_t,
+			      "logical thread array",
+			      &config->logical_threads);
+	if (result != VDO_SUCCESS) {
+		uninitialize_thread_config(config);
+		return result;
+	}
+
+	result = UDS_ALLOCATE(config->physical_zone_count,
+			      thread_id_t,
+			      "physical thread array",
+			      &config->physical_threads);
+	if (result != VDO_SUCCESS) {
+		uninitialize_thread_config(config);
+		return result;
+	}
+
+	result = UDS_ALLOCATE(config->hash_zone_count,
+			      thread_id_t,
+			      "hash thread array",
+			      &config->hash_zone_threads);
+	if (result != VDO_SUCCESS) {
+		uninitialize_thread_config(config);
+		return result;
+	}
+
+	result = UDS_ALLOCATE(config->bio_thread_count,
+			      thread_id_t,
+			      "bio thread array",
+			      &config->bio_threads);
+	if (result != VDO_SUCCESS) {
+		uninitialize_thread_config(config);
+		return result;
+	}
+
+	if (single) {
+		config->logical_threads[0] = config->thread_count;
+		config->physical_threads[0] = config->thread_count;
+		config->hash_zone_threads[0] = config->thread_count++;
+	} else {
+		config->admin_thread = config->thread_count;
+		config->journal_thread = config->thread_count++;
+		config->packer_thread = config->thread_count++;
+		assign_thread_ids(config, config->logical_threads, counts.logical_zones);
+		assign_thread_ids(config, config->physical_threads, counts.physical_zones);
+		assign_thread_ids(config, config->hash_zone_threads, counts.hash_zones);
+	}
+
+	config->dedupe_thread = config->thread_count++;
+	config->bio_ack_thread =
+		((counts.bio_ack_threads > 0) ? config->thread_count++ : VDO_INVALID_THREAD_ID);
+	config->cpu_thread = config->thread_count++;
+	assign_thread_ids(config, config->bio_threads, counts.bio_threads);
+	return VDO_SUCCESS;
+}
+
+/**
+ * vdo_read_geometry_block() - Synchronously read the geometry block from a vdo's underlying block
+ *                             device.
+ * @vdo: The vdo whose geometry is to be read.
+ *
+ * Return: VDO_SUCCESS or an error code.
+ */
+static int __must_check read_geometry_block(struct vdo *vdo)
+{
+	struct vio *vio;
+	char *block;
+	int result;
+
+	result = UDS_ALLOCATE(VDO_BLOCK_SIZE, u8, __func__, &block);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	result = create_metadata_vio(vdo, VIO_TYPE_GEOMETRY, VIO_PRIORITY_HIGH, NULL, block, &vio);
+	if (result != VDO_SUCCESS) {
+		UDS_FREE(block);
+		return result;
+	}
+
+	/*
+	 * This is only safe because, having not already loaded the geometry, the vdo's geometry's
+	 * bio_offset field is 0, so the fact that vio_reset_bio() will subtract that offset from
+	 * the supplied pbn is not a problem.
+	 */
+	result = vio_reset_bio(vio, block, NULL, REQ_OP_READ, VDO_GEOMETRY_BLOCK_LOCATION);
+	if (result != VDO_SUCCESS) {
+		free_vio(UDS_FORGET(vio));
+		UDS_FREE(block);
+		return result;
+	}
+
+	bio_set_dev(vio->bio, vdo_get_backing_device(vdo));
+	submit_bio_wait(vio->bio);
+	result = blk_status_to_errno(vio->bio->bi_status);
+	free_vio(UDS_FORGET(vio));
+	if (result != 0) {
+		uds_log_error_strerror(result, "synchronous read failed");
+		UDS_FREE(block);
+		return -EIO;
+	}
+
+	result = vdo_parse_geometry_block((u8 *) block, &vdo->geometry);
+	UDS_FREE(block);
+	return result;
+}
+
+static bool get_zone_thread_name(const thread_id_t thread_ids[],
+				 zone_count_t count,
+				 thread_id_t id,
+				 const char *prefix,
+				 char *buffer,
+				 size_t buffer_length)
+{
+	if (id >= thread_ids[0]) {
+		thread_id_t index = id - thread_ids[0];
+
+		if (index < count) {
+			snprintf(buffer, buffer_length, "%s%d", prefix, index);
+			return true;
+		}
+	}
+	return false;
+}
+
+/**
+ * get_thread_name() - Format the name of the worker thread desired to support a given work queue.
+ * @thread_config: The thread configuration.
+ * @thread_id: The thread id.
+ * @buffer: Where to put the formatted name.
+ * @buffer_length: Size of the output buffer.
+ *
+ * The physical layer may add a prefix identifying the product; the output from this function
+ * should just identify the thread.
+ */
+static void
+get_thread_name(const struct thread_config *thread_config,
+		thread_id_t thread_id,
+		char *buffer,
+		size_t buffer_length)
+{
+	if (thread_id == thread_config->journal_thread) {
+		if (thread_config->packer_thread == thread_id) {
+			/*
+			 * This is the "single thread" config where one thread is used for the
+			 * journal, packer, logical, physical, and hash zones. In that case, it is
+			 * known as the "request queue."
+			 */
+			snprintf(buffer, buffer_length, "reqQ");
+			return;
+		}
+
+		snprintf(buffer, buffer_length, "journalQ");
+		return;
+	} else if (thread_id == thread_config->admin_thread) {
+		/* Theoretically this could be different from the journal thread. */
+		snprintf(buffer, buffer_length, "adminQ");
+		return;
+	} else if (thread_id == thread_config->packer_thread) {
+		snprintf(buffer, buffer_length, "packerQ");
+		return;
+	} else if (thread_id == thread_config->dedupe_thread) {
+		snprintf(buffer, buffer_length, "dedupeQ");
+		return;
+	} else if (thread_id == thread_config->bio_ack_thread) {
+		snprintf(buffer, buffer_length, "ackQ");
+		return;
+	} else if (thread_id == thread_config->cpu_thread) {
+		snprintf(buffer, buffer_length, "cpuQ");
+		return;
+	}
+
+	if (get_zone_thread_name(thread_config->logical_threads,
+				 thread_config->logical_zone_count,
+				 thread_id,
+				 "logQ",
+				 buffer,
+				 buffer_length))
+		return;
+
+	if (get_zone_thread_name(thread_config->physical_threads,
+				 thread_config->physical_zone_count,
+				 thread_id,
+				 "physQ",
+				 buffer,
+				 buffer_length))
+		return;
+
+	if (get_zone_thread_name(thread_config->hash_zone_threads,
+				 thread_config->hash_zone_count,
+				 thread_id,
+				 "hashQ",
+				 buffer,
+				 buffer_length))
+		return;
+
+	if (get_zone_thread_name(thread_config->bio_threads,
+				 thread_config->bio_thread_count,
+				 thread_id,
+				 "bioQ",
+				 buffer,
+				 buffer_length))
+		return;
+
+	/* Some sort of misconfiguration? */
+	snprintf(buffer, buffer_length, "reqQ%d", thread_id);
+}
+
+/**
+ * vdo_make_thread() - Construct a single vdo work_queue and its associated thread (or threads for
+ *                     round-robin queues).
+ * @vdo: The vdo which owns the thread.
+ * @thread_id: The id of the thread to create (as determined by the thread_config).
+ * @type: The description of the work queue for this thread.
+ * @queue_count: The number of actual threads/queues contained in the "thread".
+ * @contexts: An array of queue_count contexts, one for each individual queue; may be NULL.
+ *
+ * Each "thread" constructed by this method is represented by a unique thread id in the thread
+ * config, and completions can be enqueued to the queue and run on the threads comprising this
+ * entity.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+int vdo_make_thread(struct vdo *vdo,
+		    thread_id_t thread_id,
+		    const struct vdo_work_queue_type *type,
+		    unsigned int queue_count,
+		    void *contexts[])
+{
+	struct vdo_thread *thread = &vdo->threads[thread_id];
+	char queue_name[MAX_VDO_WORK_QUEUE_NAME_LEN];
+
+	if (type == NULL)
+		type = &default_queue_type;
+
+	if (thread->queue != NULL)
+		return ASSERT(vdo_work_queue_type_is(thread->queue, type),
+			      "already constructed vdo thread %u is of the correct type",
+			      thread_id);
+
+	thread->vdo = vdo;
+	thread->thread_id = thread_id;
+	get_thread_name(&vdo->thread_config, thread_id, queue_name, sizeof(queue_name));
+	return vdo_make_work_queue(vdo->thread_name_prefix,
+				   queue_name,
+				   thread,
+				   type,
+				   queue_count,
+				   contexts,
+				   &thread->queue);
+}
+
+/**
+ * register_vdo() - Register a VDO; it must not already be registered.
+ * @vdo: The vdo to register.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+static int register_vdo(struct vdo *vdo)
+{
+	int result;
+
+	write_lock(&registry.lock);
+	result = ASSERT(filter_vdos_locked(vdo_is_equal, vdo) == NULL,
+			"VDO not already registered");
+	if (result == VDO_SUCCESS) {
+		INIT_LIST_HEAD(&vdo->registration);
+		list_add_tail(&vdo->registration, &registry.links);
+	}
+	write_unlock(&registry.lock);
+
+	return result;
+}
+
+/**
+ * initialize_vdo() - Do the portion of initializing a vdo which will clean up after itself on
+ *                    error.
+ * @vdo: The vdo being initialized
+ * @config: The configuration of the vdo
+ * @instance: The instance number of the vdo
+ * @reason: The buffer to hold the failure reason on error
+ */
+static int
+initialize_vdo(struct vdo *vdo, struct device_config *config, unsigned int instance, char **reason)
+{
+	int result;
+	zone_count_t i;
+
+	vdo->device_config = config;
+	vdo->starting_sector_offset = config->owning_target->begin;
+	vdo->instance = instance;
+	vdo->allocations_allowed = true;
+	vdo_set_admin_state_code(&vdo->admin.state, VDO_ADMIN_STATE_NEW);
+	INIT_LIST_HEAD(&vdo->device_config_list);
+	vdo_initialize_completion(&vdo->admin.completion, vdo, VDO_ADMIN_COMPLETION);
+	init_completion(&vdo->admin.callback_sync);
+	mutex_init(&vdo->stats_mutex);
+	result = read_geometry_block(vdo);
+	if (result != VDO_SUCCESS) {
+		*reason = "Could not load geometry block";
+		return result;
+	}
+
+	result = initialize_thread_config(config->thread_counts, &vdo->thread_config);
+	if (result != VDO_SUCCESS) {
+		*reason = "Cannot create thread configuration";
+		return result;
+	}
+
+	uds_log_info("zones: %d logical, %d physical, %d hash; total threads: %d",
+		     config->thread_counts.logical_zones,
+		     config->thread_counts.physical_zones,
+		     config->thread_counts.hash_zones,
+		     vdo->thread_config.thread_count);
+
+	/* Compression context storage */
+	result = UDS_ALLOCATE(config->thread_counts.cpu_threads,
+			      char *,
+			      "LZ4 context",
+			      &vdo->compression_context);
+	if (result != VDO_SUCCESS) {
+		*reason = "cannot allocate LZ4 context";
+		return result;
+	}
+
+	for (i = 0; i < config->thread_counts.cpu_threads; i++) {
+		result = UDS_ALLOCATE(LZ4_MEM_COMPRESS,
+				      char,
+				      "LZ4 context",
+				      &vdo->compression_context[i]);
+		if (result != VDO_SUCCESS) {
+			*reason = "cannot allocate LZ4 context";
+			return result;
+		}
+	}
+
+	result = register_vdo(vdo);
+	if (result != VDO_SUCCESS) {
+		*reason = "Cannot add VDO to device registry";
+		return result;
+	}
+
+	vdo_set_admin_state_code(&vdo->admin.state, VDO_ADMIN_STATE_INITIALIZED);
+	return result;
+}
+
+/**
+ * vdo_make() - Allocate and initialize a vdo.
+ * @instance: Device instantiation counter.
+ * @config: The device configuration.
+ * @reason: The reason for any failure during this call.
+ * @vdo_ptr: A pointer to hold the created vdo.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+int vdo_make(unsigned int instance,
+	     struct device_config *config,
+	     char **reason,
+	     struct vdo **vdo_ptr)
+{
+	int result;
+	struct vdo *vdo;
+
+	/* VDO-3769 - Set a generic reason so we don't ever return garbage. */
+	*reason = "Unspecified error";
+
+	result = UDS_ALLOCATE(1, struct vdo, __func__, &vdo);
+	if (result != UDS_SUCCESS) {
+		*reason = "Cannot allocate VDO";
+		return result;
+	}
+
+	result = initialize_vdo(vdo, config, instance, reason);
+	if (result != VDO_SUCCESS) {
+		vdo_destroy(vdo);
+		return result;
+	}
+
+	/* From here on, the caller will clean up if there is an error. */
+	*vdo_ptr = vdo;
+
+	snprintf(vdo->thread_name_prefix,
+		 sizeof(vdo->thread_name_prefix),
+		 "%s%u",
+		 MODULE_NAME,
+		 instance);
+	BUG_ON(vdo->thread_name_prefix[0] == '\0');
+	result = UDS_ALLOCATE(vdo->thread_config.thread_count,
+			      struct vdo_thread,
+			      __func__,
+			      &vdo->threads);
+	if (result != VDO_SUCCESS) {
+		*reason = "Cannot allocate thread structures";
+		return result;
+	}
+
+	result = vdo_make_thread(vdo,
+				 vdo->thread_config.admin_thread,
+				 &default_queue_type,
+				 1,
+				 NULL);
+	if (result != VDO_SUCCESS) {
+		*reason = "Cannot make admin thread";
+		return result;
+	}
+
+	result = vdo_make_flusher(vdo);
+	if (result != VDO_SUCCESS) {
+		*reason = "Cannot make flusher zones";
+		return result;
+	}
+
+	result = vdo_make_packer(vdo, DEFAULT_PACKER_BINS, &vdo->packer);
+	if (result != VDO_SUCCESS) {
+		*reason = "Cannot make packer zones";
+		return result;
+	}
+
+	BUG_ON(vdo->device_config->logical_block_size <= 0);
+	BUG_ON(vdo->device_config->owned_device == NULL);
+	result = make_data_vio_pool(vdo,
+				    MAXIMUM_VDO_USER_VIOS,
+				    MAXIMUM_VDO_USER_VIOS * 3 / 4,
+				    &vdo->data_vio_pool);
+	if (result != VDO_SUCCESS) {
+		*reason = "Cannot allocate data_vio pool";
+		return result;
+	}
+
+	result = vdo_make_io_submitter(config->thread_counts.bio_threads,
+				       config->thread_counts.bio_rotation_interval,
+				       get_data_vio_pool_request_limit(vdo->data_vio_pool),
+				       vdo,
+				       &vdo->io_submitter);
+	if (result != VDO_SUCCESS) {
+		*reason = "bio submission initialization failed";
+		return result;
+	}
+
+	if (vdo_uses_bio_ack_queue(vdo)) {
+		result = vdo_make_thread(vdo,
+					 vdo->thread_config.bio_ack_thread,
+					 &bio_ack_q_type,
+					 config->thread_counts.bio_ack_threads,
+					 NULL);
+		if (result != VDO_SUCCESS) {
+			*reason = "bio ack queue initialization failed";
+			return result;
+		}
+	}
+
+	result = vdo_make_thread(vdo,
+				 vdo->thread_config.cpu_thread,
+				 &cpu_q_type,
+				 config->thread_counts.cpu_threads,
+				 (void **) vdo->compression_context);
+	if (result != VDO_SUCCESS) {
+		*reason = "CPU queue initialization failed";
+		return result;
+	}
+
+	return VDO_SUCCESS;
+}
+
+static void finish_vdo(struct vdo *vdo)
+{
+	int i;
+
+	if (vdo->threads == NULL)
+		return;
+
+	vdo_cleanup_io_submitter(vdo->io_submitter);
+	vdo_finish_dedupe_index(vdo->hash_zones);
+
+	for (i = 0; i < vdo->thread_config.thread_count; i++)
+		vdo_finish_work_queue(vdo->threads[i].queue);
+}
+
+/**
+ * free_listeners() - Free the list of read-only listeners associated with a thread.
+ * @thread_data: The thread holding the list to free.
+ */
+static void free_listeners(struct vdo_thread *thread)
+{
+	struct read_only_listener *listener, *next;
+
+	for (listener = UDS_FORGET(thread->listeners); listener != NULL; listener = next) {
+		next = UDS_FORGET(listener->next);
+		UDS_FREE(listener);
+	}
+}
+
+static void uninitialize_super_block(struct vdo_super_block *super_block)
+{
+	free_vio_components(&super_block->vio);
+	UDS_FREE(super_block->buffer);
+}
+
+/**
+ * unregister_vdo() - Remove a vdo from the device registry.
+ * @vdo: The vdo to remove.
+ */
+static void unregister_vdo(struct vdo *vdo)
+{
+	write_lock(&registry.lock);
+	if (filter_vdos_locked(vdo_is_equal, vdo) == vdo)
+		list_del_init(&vdo->registration);
+
+	write_unlock(&registry.lock);
+}
+
+/**
+ * vdo_destroy() - Destroy a vdo instance.
+ * @vdo: The vdo to destroy (may be NULL).
+ */
+void vdo_destroy(struct vdo *vdo)
+{
+	unsigned int i;
+
+	if (vdo == NULL)
+		return;
+
+	/* A running VDO should never be destroyed without suspending first. */
+	BUG_ON(vdo_get_admin_state(vdo)->normal);
+
+	vdo->allocations_allowed = true;
+
+	/* Stop services that need to gather VDO statistics from the worker threads. */
+	if (vdo->sysfs_added) {
+		init_completion(&vdo->stats_shutdown);
+		kobject_put(&vdo->stats_directory);
+		wait_for_completion(&vdo->stats_shutdown);
+	}
+
+	finish_vdo(vdo);
+	unregister_vdo(vdo);
+	free_data_vio_pool(vdo->data_vio_pool);
+	vdo_free_io_submitter(UDS_FORGET(vdo->io_submitter));
+	vdo_free_flusher(UDS_FORGET(vdo->flusher));
+	vdo_free_packer(UDS_FORGET(vdo->packer));
+	vdo_free_recovery_journal(UDS_FORGET(vdo->recovery_journal));
+	vdo_free_slab_depot(UDS_FORGET(vdo->depot));
+	vdo_uninitialize_layout(&vdo->layout);
+	vdo_uninitialize_layout(&vdo->next_layout);
+	if (vdo->partition_copier)
+		dm_kcopyd_client_destroy(UDS_FORGET(vdo->partition_copier));
+	uninitialize_super_block(&vdo->super_block);
+	vdo_free_block_map(UDS_FORGET(vdo->block_map));
+	vdo_free_hash_zones(UDS_FORGET(vdo->hash_zones));
+	vdo_free_physical_zones(UDS_FORGET(vdo->physical_zones));
+	vdo_free_logical_zones(UDS_FORGET(vdo->logical_zones));
+
+	if (vdo->threads != NULL) {
+		for (i = 0; i < vdo->thread_config.thread_count; i++) {
+			free_listeners(&vdo->threads[i]);
+			vdo_free_work_queue(UDS_FORGET(vdo->threads[i].queue));
+		}
+		UDS_FREE(UDS_FORGET(vdo->threads));
+	}
+
+	uninitialize_thread_config(&vdo->thread_config);
+
+	if (vdo->compression_context != NULL) {
+		for (i = 0; i < vdo->device_config->thread_counts.cpu_threads; i++)
+			UDS_FREE(UDS_FORGET(vdo->compression_context[i]));
+
+		UDS_FREE(UDS_FORGET(vdo->compression_context));
+	}
+
+	/*
+	 * The call to kobject_put on the kobj sysfs node will decrement its reference count; when
+	 * the count goes to zero the VDO object will be freed as a side effect.
+	 */
+	if (!vdo->sysfs_added)
+		UDS_FREE(vdo);
+	else
+		kobject_put(&vdo->vdo_directory);
+}
+
+static int initialize_super_block(struct vdo *vdo, struct vdo_super_block *super_block)
+{
+	int result;
+
+	result = UDS_ALLOCATE(VDO_BLOCK_SIZE,
+			      char,
+			      "encoded super block",
+			      (char **) &vdo->super_block.buffer);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	return allocate_vio_components(vdo,
+				       VIO_TYPE_SUPER_BLOCK,
+				       VIO_PRIORITY_METADATA,
+				       NULL,
+				       1,
+				       (char *) super_block->buffer,
+				       &vdo->super_block.vio);
+}
+
+/**
+ * finish_reading_super_block() - Continue after loading the super block.
+ * @completion: The super block vio.
+ *
+ * This callback is registered in vdo_load_super_block().
+ */
+static void finish_reading_super_block(struct vdo_completion *completion)
+{
+	struct vdo_super_block *super_block =
+		container_of(as_vio(completion), struct vdo_super_block, vio);
+
+	vdo_continue_completion(UDS_FORGET(completion->parent),
+				vdo_decode_super_block(super_block->buffer));
+}
+
+/**
+ * handle_super_block_read_error() - Handle an error reading the super block.
+ * @completion: The super block vio.
+ *
+ * This error handler is registered in vdo_load_super_block().
+ */
+static void handle_super_block_read_error(struct vdo_completion *completion)
+{
+	vio_record_metadata_io_error(as_vio(completion));
+	finish_reading_super_block(completion);
+}
+
+static void read_super_block_endio(struct bio *bio)
+{
+	struct vio *vio = bio->bi_private;
+	struct vdo_completion *parent = vio->completion.parent;
+
+	continue_vio_after_io(vio, finish_reading_super_block, parent->callback_thread_id);
+}
+
+/**
+ * vdo_load_super_block() - Allocate a super block and read its contents from storage.
+ * @vdo: The vdo containing the super block on disk.
+ * @parent: The completion to notify after loading the super block.
+ */
+void vdo_load_super_block(struct vdo *vdo, struct vdo_completion *parent)
+{
+	int result;
+
+	result = initialize_super_block(vdo, &vdo->super_block);
+	if (result != VDO_SUCCESS) {
+		vdo_continue_completion(parent, result);
+		return;
+	}
+
+	vdo->super_block.vio.completion.parent = parent;
+	submit_metadata_vio(&vdo->super_block.vio,
+			    vdo_get_data_region_start(vdo->geometry),
+			    read_super_block_endio,
+			    handle_super_block_read_error,
+			    REQ_OP_READ);
+}
+
+/**
+ * pool_stats_release() - Signal that sysfs stats have been shut down.
+ * @directory: The vdo stats directory.
+ */
+static void pool_stats_release(struct kobject *directory)
+{
+	struct vdo *vdo = container_of(directory, struct vdo, stats_directory);
+
+	complete(&vdo->stats_shutdown);
+}
+
+ATTRIBUTE_GROUPS(vdo_pool_stats);
+static const struct kobj_type stats_directory_type = {
+	.release = pool_stats_release,
+	.sysfs_ops = &vdo_pool_stats_sysfs_ops,
+	.default_groups = vdo_pool_stats_groups,
+};
+
+/**
+ * vdo_add_sysfs_stats_dir() - Add the stats directory to the vdo sysfs directory.
+ * @vdo: The vdo.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+int vdo_add_sysfs_stats_dir(struct vdo *vdo)
+{
+	int result;
+
+	kobject_init(&vdo->stats_directory, &stats_directory_type);
+	result = kobject_add(&vdo->stats_directory, &vdo->vdo_directory, "statistics");
+	if (result != 0)
+		return VDO_CANT_ADD_SYSFS_NODE;
+
+	return VDO_SUCCESS;
+}
+
+/**
+ * vdo_get_backing_device() - Get the block device object underlying a vdo.
+ * @vdo: The vdo.
+ *
+ * Return: The vdo's current block device.
+ */
+struct block_device *vdo_get_backing_device(const struct vdo *vdo)
+{
+	return vdo->device_config->owned_device->bdev;
+}
+
+/**
+ * vdo_get_device_name() - Get the device name associated with the vdo target.
+ * @target: The target device interface.
+ *
+ * Return: The block device name.
+ */
+const char *vdo_get_device_name(const struct dm_target *target)
+{
+	return dm_device_name(dm_table_get_md(target->table));
+}
+
+/**
+ * vdo_synchronous_flush() - Issue a flush request and wait for it to complete.
+ * @vdo: The vdo.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+int vdo_synchronous_flush(struct vdo *vdo)
+{
+	int result;
+	struct bio bio;
+
+	bio_init(&bio, vdo_get_backing_device(vdo), 0, 0,
+		 REQ_OP_WRITE | REQ_PREFLUSH);
+	submit_bio_wait(&bio);
+	result = blk_status_to_errno(bio.bi_status);
+
+	atomic64_inc(&vdo->stats.flush_out);
+	if (result != 0) {
+		uds_log_error_strerror(result, "synchronous flush failed");
+		result = -EIO;
+	}
+
+	bio_uninit(&bio);
+	return result;
+}
+
+/**
+ * vdo_get_state() - Get the current state of the vdo.
+ * @vdo: The vdo.
+
+ * Context: This method may be called from any thread.
+ *
+ * Return: The current state of the vdo.
+ */
+enum vdo_state vdo_get_state(const struct vdo *vdo)
+{
+	enum vdo_state state = atomic_read(&vdo->state);
+
+	/* pairs with barriers where state field is changed */
+	smp_rmb();
+	return state;
+}
+
+/**
+ * vdo_set_state() - Set the current state of the vdo.
+ * @vdo: The vdo whose state is to be set.
+ * @state: The new state of the vdo.
+ *
+ * Context: This method may be called from any thread.
+ */
+void vdo_set_state(struct vdo *vdo, enum vdo_state state)
+{
+	/* pairs with barrier in vdo_get_state */
+	smp_wmb();
+	atomic_set(&vdo->state, state);
+}
+
+/**
+ * vdo_get_admin_state() - Get the admin state of the vdo.
+ * @vdo: The vdo.
+ *
+ * Return: The code for the vdo's current admin state.
+ */
+const struct admin_state_code *vdo_get_admin_state(const struct vdo *vdo)
+{
+	return vdo_get_admin_state_code(&vdo->admin.state);
+}
+
+/**
+ * record_vdo() - Record the state of the VDO for encoding in the super block.
+ */
+static void record_vdo(struct vdo *vdo)
+{
+	/* This is for backwards compatibility. */
+	vdo->states.unused = vdo->geometry.unused;
+	vdo->states.vdo.state = vdo_get_state(vdo);
+	vdo->states.block_map = vdo_record_block_map(vdo->block_map);
+	vdo->states.recovery_journal = vdo_record_recovery_journal(vdo->recovery_journal);
+	vdo->states.slab_depot = vdo_record_slab_depot(vdo->depot);
+	vdo->states.layout = vdo->layout;
+}
+
+/**
+ * continue_super_block_parent() - Continue the parent of a super block save operation.
+ * @completion: The super block vio.
+ *
+ * This callback is registered in vdo_save_components().
+ */
+static void continue_super_block_parent(struct vdo_completion *completion)
+{
+	vdo_continue_completion(UDS_FORGET(completion->parent), completion->result);
+}
+
+/**
+ * handle_save_error() - Log a super block save error.
+ * @completion: The super block vio.
+ *
+ * This error handler is registered in vdo_save_components().
+ */
+static void handle_save_error(struct vdo_completion *completion)
+{
+	struct vdo_super_block *super_block =
+		container_of(as_vio(completion), struct vdo_super_block, vio);
+
+	vio_record_metadata_io_error(&super_block->vio);
+	uds_log_error_strerror(completion->result, "super block save failed");
+	/*
+	 * Mark the super block as unwritable so that we won't attempt to write it again. This
+	 * avoids the case where a growth attempt fails writing the super block with the new size,
+	 * but the subsequent attempt to write out the read-only state succeeds. In this case,
+	 * writes which happened just before the suspend would not be visible if the VDO is
+	 * restarted without rebuilding, but, after a read-only rebuild, the effects of those
+	 * writes would reappear.
+	 */
+	super_block->unwritable = true;
+	completion->callback(completion);
+}
+
+static void super_block_write_endio(struct bio *bio)
+{
+	struct vio *vio = bio->bi_private;
+	struct vdo_completion *parent = vio->completion.parent;
+
+	continue_vio_after_io(vio, continue_super_block_parent, parent->callback_thread_id);
+}
+
+/**
+ * vdo_save_components() - Encode the vdo and save the super block asynchronously.
+ * @vdo: The vdo whose state is being saved.
+ * @parent: The completion to notify when the save is complete.
+ */
+void vdo_save_components(struct vdo *vdo, struct vdo_completion *parent)
+{
+	struct vdo_super_block *super_block = &vdo->super_block;
+
+	if (super_block->unwritable) {
+		vdo_continue_completion(parent, VDO_READ_ONLY);
+		return;
+	}
+
+	if (super_block->vio.completion.parent != NULL) {
+		vdo_continue_completion(parent, VDO_COMPONENT_BUSY);
+		return;
+	}
+
+	record_vdo(vdo);
+
+	vdo_encode_super_block(super_block->buffer, &vdo->states);
+	super_block->vio.completion.parent = parent;
+	super_block->vio.completion.callback_thread_id = parent->callback_thread_id;
+	submit_metadata_vio(&super_block->vio,
+			    vdo_get_data_region_start(vdo->geometry),
+			    super_block_write_endio,
+			    handle_save_error,
+			    REQ_OP_WRITE | REQ_PREFLUSH | REQ_FUA);
+}
+
+/**
+ * vdo_register_read_only_listener() - Register a listener to be notified when the VDO goes
+ *                                     read-only.
+ * @vdo: The vdo to register with.
+ * @listener: The object to notify.
+ * @notification: The function to call to send the notification.
+ * @thread_id: The id of the thread on which to send the notification.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+int vdo_register_read_only_listener(struct vdo *vdo,
+				    void *listener,
+				    vdo_read_only_notification *notification,
+				    thread_id_t thread_id)
+{
+	struct vdo_thread *thread = &vdo->threads[thread_id];
+	struct read_only_listener *read_only_listener;
+	int result;
+
+	result = ASSERT(thread_id != vdo->thread_config.dedupe_thread,
+			"read only listener not registered on dedupe thread");
+	if (result != VDO_SUCCESS)
+		return result;
+
+	result = UDS_ALLOCATE(1, struct read_only_listener, __func__, &read_only_listener);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	*read_only_listener = (struct read_only_listener) {
+		.listener = listener,
+		.notify = notification,
+		.next = thread->listeners,
+	};
+
+	thread->listeners = read_only_listener;
+	return VDO_SUCCESS;
+}
+
+/**
+ * notify_vdo_of_read_only_mode() - Notify a vdo that it is going read-only.
+ * @listener: The vdo.
+ * @parent: The completion to notify in order to acknowledge the notification.
+ *
+ * This will save the read-only state to the super block.
+ *
+ * Implements vdo_read_only_notification.
+ */
+static void notify_vdo_of_read_only_mode(void *listener, struct vdo_completion *parent)
+{
+	struct vdo *vdo = listener;
+
+	if (vdo_in_read_only_mode(vdo))
+		vdo_finish_completion(parent);
+
+	vdo_set_state(vdo, VDO_READ_ONLY_MODE);
+	vdo_save_components(vdo, parent);
+}
+
+/**
+ * vdo_enable_read_only_entry() - Enable a vdo to enter read-only mode on errors.
+ * @vdo: The vdo to enable.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+int vdo_enable_read_only_entry(struct vdo *vdo)
+{
+	thread_id_t id;
+	bool is_read_only = vdo_in_read_only_mode(vdo);
+	struct read_only_notifier *notifier = &vdo->read_only_notifier;
+
+	if (is_read_only) {
+		notifier->read_only_error = VDO_READ_ONLY;
+		notifier->state = NOTIFIED;
+	} else {
+		notifier->state = MAY_NOT_NOTIFY;
+	}
+
+	spin_lock_init(&notifier->lock);
+	vdo_initialize_completion(&notifier->completion, vdo, VDO_READ_ONLY_MODE_COMPLETION);
+
+	for (id = 0; id < vdo->thread_config.thread_count; id++)
+		vdo->threads[id].is_read_only = is_read_only;
+
+	return vdo_register_read_only_listener(vdo,
+					       vdo,
+					       notify_vdo_of_read_only_mode,
+					       vdo->thread_config.admin_thread);
+}
+
+/**
+ * vdo_wait_until_not_entering_read_only_mode() - Wait until no read-only notifications are in
+ *                                                progress and prevent any subsequent
+ *                                                notifications.
+ * @parent: The completion to notify when no threads are entering read-only mode.
+ *
+ * Notifications may be re-enabled by calling vdo_allow_read_only_mode_entry().
+ */
+void vdo_wait_until_not_entering_read_only_mode(struct vdo_completion *parent)
+{
+	struct vdo *vdo = parent->vdo;
+	struct read_only_notifier *notifier = &vdo->read_only_notifier;
+
+	vdo_assert_on_admin_thread(vdo, __func__);
+
+	if (notifier->waiter != NULL) {
+		vdo_continue_completion(parent, VDO_COMPONENT_BUSY);
+		return;
+	}
+
+	spin_lock(&notifier->lock);
+	if (notifier->state == NOTIFYING)
+		notifier->waiter = parent;
+	else if (notifier->state == MAY_NOTIFY)
+		notifier->state = MAY_NOT_NOTIFY;
+	spin_unlock(&notifier->lock);
+
+	if (notifier->waiter == NULL) {
+		/*
+		 * A notification was not in progress, and now they are
+		 * disallowed.
+		 */
+		vdo_launch_completion(parent);
+		return;
+	}
+}
+
+/**
+ * as_notifier() - Convert a generic vdo_completion to a read_only_notifier.
+ * @completion: The completion to convert.
+ *
+ * Return: The completion as a read_only_notifier.
+ */
+static inline struct read_only_notifier *as_notifier(struct vdo_completion *completion)
+{
+	vdo_assert_completion_type(completion, VDO_READ_ONLY_MODE_COMPLETION);
+	return container_of(completion, struct read_only_notifier, completion);
+}
+
+/**
+ * finish_entering_read_only_mode() - Complete the process of entering read only mode.
+ * @completion: The read-only mode completion.
+ */
+static void finish_entering_read_only_mode(struct vdo_completion *completion)
+{
+	struct read_only_notifier *notifier = as_notifier(completion);
+
+	vdo_assert_on_admin_thread(completion->vdo, __func__);
+
+	spin_lock(&notifier->lock);
+	notifier->state = NOTIFIED;
+	spin_unlock(&notifier->lock);
+
+	if (notifier->waiter != NULL)
+		vdo_continue_completion(UDS_FORGET(notifier->waiter), completion->result);
+}
+
+/**
+ * make_thread_read_only() - Inform each thread that the VDO is in read-only mode.
+ * @completion: The read-only mode completion.
+ */
+static void make_thread_read_only(struct vdo_completion *completion)
+{
+	struct vdo *vdo = completion->vdo;
+	thread_id_t thread_id = completion->callback_thread_id;
+	struct read_only_notifier *notifier = as_notifier(completion);
+	struct read_only_listener *listener = completion->parent;
+
+	if (listener == NULL) {
+		/* This is the first call on this thread */
+		struct vdo_thread *thread = &vdo->threads[thread_id];
+
+		thread->is_read_only = true;
+		listener = thread->listeners;
+		if (thread_id == 0)
+			uds_log_error_strerror(READ_ONCE(notifier->read_only_error),
+					       "Unrecoverable error, entering read-only mode");
+	} else {
+		/* We've just finished notifying a listener */
+		listener = listener->next;
+	}
+
+	if (listener != NULL) {
+		/* We have a listener to notify */
+		vdo_prepare_completion(completion,
+				       make_thread_read_only,
+				       make_thread_read_only,
+				       thread_id,
+				       listener);
+		listener->notify(listener->listener, completion);
+		return;
+	}
+
+	/* We're done with this thread */
+	if (++thread_id == vdo->thread_config.dedupe_thread)
+		/*
+		 * We don't want to notify the dedupe thread since it may be
+		 * blocked rebuilding the index.
+		 */
+		++thread_id;
+
+	if (thread_id >= vdo->thread_config.thread_count)
+		/* There are no more threads */
+		vdo_prepare_completion(completion,
+				       finish_entering_read_only_mode,
+				       finish_entering_read_only_mode,
+				       vdo->thread_config.admin_thread,
+				       NULL);
+	else
+		vdo_prepare_completion(completion,
+				       make_thread_read_only,
+				       make_thread_read_only,
+				       thread_id,
+				       NULL);
+
+	vdo_launch_completion(completion);
+}
+
+/**
+ * vdo_allow_read_only_mode_entry() - Allow the notifier to put the VDO into read-only mode,
+ *                                    reversing the effects of
+ *                                    vdo_wait_until_not_entering_read_only_mode().
+ * @parent: The object to notify once the operation is complete.
+ *
+ * If some thread tried to put the vdo into read-only mode while notifications were disallowed, it
+ * will be done when this method is called. If that happens, the parent will not be notified until
+ * the vdo has actually entered read-only mode and attempted to save the super block.
+ *
+ * Context: This method may only be called from the admin thread.
+ */
+void vdo_allow_read_only_mode_entry(struct vdo_completion *parent)
+{
+	struct vdo *vdo = parent->vdo;
+	struct read_only_notifier *notifier = &vdo->read_only_notifier;
+
+	vdo_assert_on_admin_thread(vdo, __func__);
+
+	if (notifier->waiter != NULL) {
+		vdo_continue_completion(parent, VDO_COMPONENT_BUSY);
+		return;
+	}
+
+	spin_lock(&notifier->lock);
+	if (notifier->state == MAY_NOT_NOTIFY) {
+		if (notifier->read_only_error == VDO_SUCCESS) {
+			notifier->state = MAY_NOTIFY;
+		} else {
+			notifier->state = NOTIFYING;
+			notifier->waiter = parent;
+		}
+	}
+	spin_unlock(&notifier->lock);
+
+	if (notifier->waiter == NULL) {
+		/* We're done */
+		vdo_launch_completion(parent);
+		return;
+	}
+
+	/* Do the pending notification. */
+	make_thread_read_only(&notifier->completion);
+}
+
+/**
+ * vdo_enter_read_only_mode() - Put a VDO into read-only mode and save the read-only state in the
+ *                              super block.
+ * @vdo: The vdo.
+ * @error_code: The error which caused the VDO to enter read-only mode.
+ *
+ * This method is a no-op if the VDO is already read-only.
+ */
+void vdo_enter_read_only_mode(struct vdo *vdo, int error_code)
+{
+	bool notify = false;
+	thread_id_t thread_id = vdo_get_callback_thread_id();
+	struct read_only_notifier *notifier = &vdo->read_only_notifier;
+	struct vdo_thread *thread;
+
+	if (thread_id != VDO_INVALID_THREAD_ID) {
+		thread = &vdo->threads[thread_id];
+		if (thread->is_read_only)
+			/* This thread has already gone read-only. */
+			return;
+
+		/* Record for this thread that the VDO is read-only. */
+		thread->is_read_only = true;
+	}
+
+	spin_lock(&notifier->lock);
+	if (notifier->read_only_error == VDO_SUCCESS) {
+		WRITE_ONCE(notifier->read_only_error, error_code);
+		if (notifier->state == MAY_NOTIFY) {
+			notifier->state = NOTIFYING;
+			notify = true;
+		}
+	}
+	spin_unlock(&notifier->lock);
+
+	if (!notify)
+		/* The notifier is already aware of a read-only error */
+		return;
+
+	/* Initiate a notification starting on the lowest numbered thread. */
+	vdo_launch_completion_callback(&notifier->completion, make_thread_read_only, 0);
+}
+
+/**
+ * vdo_is_read_only() - Check whether the VDO is read-only.
+ * @vdo: The vdo.
+ *
+ * Return: true if the vdo is read-only.
+ *
+ * This method may be called from any thread, as opposed to examining the VDO's state field which
+ * is only safe to check from the admin thread.
+ */
+bool vdo_is_read_only(struct vdo *vdo)
+{
+	return vdo->threads[vdo_get_callback_thread_id()].is_read_only;
+}
+
+/**
+ * vdo_in_read_only_mode() - Check whether a vdo is in read-only mode.
+ * @vdo: The vdo to query.
+ *
+ * Return: true if the vdo is in read-only mode.
+ */
+bool vdo_in_read_only_mode(const struct vdo *vdo)
+{
+	return (vdo_get_state(vdo) == VDO_READ_ONLY_MODE);
+}
+
+/**
+ * vdo_in_recovery_mode() - Check whether the vdo is in recovery mode.
+ * @vdo: The vdo to query.
+ *
+ * Return: true if the vdo is in recovery mode.
+ */
+bool vdo_in_recovery_mode(const struct vdo *vdo)
+{
+	return (vdo_get_state(vdo) == VDO_RECOVERING);
+}
+
+/**
+ * vdo_enter_recovery_mode() - Put the vdo into recovery mode.
+ * @vdo: The vdo.
+ */
+void vdo_enter_recovery_mode(struct vdo *vdo)
+{
+	vdo_assert_on_admin_thread(vdo, __func__);
+
+	if (vdo_in_read_only_mode(vdo))
+		return;
+
+	uds_log_info("Entering recovery mode");
+	vdo_set_state(vdo, VDO_RECOVERING);
+}
+
+/**
+ * complete_synchronous_action() - Signal the waiting thread that a synchronous action is complete.
+ * @completion: The sync completion.
+ */
+static void complete_synchronous_action(struct vdo_completion *completion)
+{
+	vdo_assert_completion_type(completion, VDO_SYNC_COMPLETION);
+	complete(&(container_of(completion, struct sync_completion, vdo_completion)->completion));
+}
+
+/**
+ * perform_synchronous_action() - Launch an action on a VDO thread and wait for it to complete.
+ * @vdo: The vdo.
+ * @action: The callback to launch.
+ * @thread_id: The thread on which to run the action.
+ * @parent: The parent of the sync completion (may be NULL).
+ */
+static int perform_synchronous_action(struct vdo *vdo,
+				      vdo_action *action,
+				      thread_id_t thread_id,
+				      void *parent)
+{
+	struct sync_completion sync;
+
+	vdo_initialize_completion(&sync.vdo_completion, vdo, VDO_SYNC_COMPLETION);
+	init_completion(&sync.completion);
+	sync.vdo_completion.parent = parent;
+	vdo_launch_completion_callback(&sync.vdo_completion, action, thread_id);
+	wait_for_completion(&sync.completion);
+	return sync.vdo_completion.result;
+}
+
+/**
+ * set_compression_callback() - Callback to turn compression on or off.
+ * @completion: The completion.
+ */
+static void set_compression_callback(struct vdo_completion *completion)
+{
+	struct vdo *vdo = completion->vdo;
+	bool *enable = completion->parent;
+	bool was_enabled = vdo_get_compressing(vdo);
+
+	if (*enable != was_enabled) {
+		WRITE_ONCE(vdo->compressing, *enable);
+		if (was_enabled)
+			/* Signal the packer to flush since compression has been disabled. */
+			vdo_flush_packer(vdo->packer);
+	}
+
+	uds_log_info("compression is %s", (*enable ? "enabled" : "disabled"));
+	*enable = was_enabled;
+	complete_synchronous_action(completion);
+}
+
+/**
+ * vdo_set_compressing() - Turn compression on or off.
+ * @vdo: The vdo.
+ * @enable: Whether to enable or disable compression.
+ *
+ * Return: Whether compression was previously on or off.
+ */
+bool vdo_set_compressing(struct vdo *vdo, bool enable)
+{
+	perform_synchronous_action(vdo,
+				   set_compression_callback,
+				   vdo->thread_config.packer_thread,
+				   &enable);
+	return enable;
+}
+
+/**
+ * vdo_get_compressing() - Get whether compression is enabled in a vdo.
+ * @vdo: The vdo.
+ *
+ * Return: State of compression.
+ */
+bool vdo_get_compressing(struct vdo *vdo)
+{
+	return READ_ONCE(vdo->compressing);
+}
+
+static size_t get_block_map_cache_size(const struct vdo *vdo)
+{
+	return ((size_t) vdo->device_config->cache_size) * VDO_BLOCK_SIZE;
+}
+
+static struct error_statistics __must_check get_vdo_error_statistics(const struct vdo *vdo)
+{
+	/*
+	 * The error counts can be incremented from arbitrary threads and so must be incremented
+	 * atomically, but they are just statistics with no semantics that could rely on memory
+	 * order, so unfenced reads are sufficient.
+	 */
+	const struct atomic_statistics *atoms = &vdo->stats;
+
+	return (struct error_statistics) {
+		.invalid_advice_pbn_count = atomic64_read(&atoms->invalid_advice_pbn_count),
+		.no_space_error_count = atomic64_read(&atoms->no_space_error_count),
+		.read_only_error_count = atomic64_read(&atoms->read_only_error_count),
+	};
+}
+
+static void copy_bio_stat(struct bio_stats *b, const struct atomic_bio_stats *a)
+{
+	b->read = atomic64_read(&a->read);
+	b->write = atomic64_read(&a->write);
+	b->discard = atomic64_read(&a->discard);
+	b->flush = atomic64_read(&a->flush);
+	b->empty_flush = atomic64_read(&a->empty_flush);
+	b->fua = atomic64_read(&a->fua);
+}
+
+static struct bio_stats subtract_bio_stats(struct bio_stats minuend, struct bio_stats subtrahend)
+{
+	return (struct bio_stats) {
+		.read = minuend.read - subtrahend.read,
+		.write = minuend.write - subtrahend.write,
+		.discard = minuend.discard - subtrahend.discard,
+		.flush = minuend.flush - subtrahend.flush,
+		.empty_flush = minuend.empty_flush - subtrahend.empty_flush,
+		.fua = minuend.fua - subtrahend.fua,
+	};
+}
+
+/**
+ * vdo_get_physical_blocks_allocated() - Get the number of physical blocks in use by user data.
+ * @vdo: The vdo.
+ *
+ * Return: The number of blocks allocated for user data.
+ */
+static block_count_t __must_check vdo_get_physical_blocks_allocated(const struct vdo *vdo)
+{
+	return (vdo_get_slab_depot_allocated_blocks(vdo->depot) -
+		vdo_get_journal_block_map_data_blocks_used(vdo->recovery_journal));
+}
+
+/**
+ * vdo_get_physical_blocks_overhead() - Get the number of physical blocks used by vdo metadata.
+ * @vdo: The vdo.
+ *
+ * Return: The number of overhead blocks.
+ */
+static block_count_t __must_check vdo_get_physical_blocks_overhead(const struct vdo *vdo)
+{
+	/*
+	 * config.physical_blocks is mutated during resize and is in a packed structure,
+	 * but resize runs on admin thread.
+	 * TODO: Verify that this is always safe.
+	 */
+	return (vdo->states.vdo.config.physical_blocks -
+		vdo_get_slab_depot_data_blocks(vdo->depot) +
+		vdo_get_journal_block_map_data_blocks_used(vdo->recovery_journal));
+}
+
+static const char *vdo_describe_state(enum vdo_state state)
+{
+	/* These strings should all fit in the 15 chars of VDOStatistics.mode. */
+	switch (state) {
+	case VDO_RECOVERING:
+		return "recovering";
+
+	case VDO_READ_ONLY_MODE:
+		return "read-only";
+
+	default:
+		return "normal";
+	}
+}
+
+/**
+ * get_vdo_statistics() - Populate a vdo_statistics structure on the admin thread.
+ * @vdo: The vdo.
+ * @stats: The statistics structure to populate.
+ */
+static void get_vdo_statistics(const struct vdo *vdo, struct vdo_statistics *stats)
+{
+	struct recovery_journal *journal = vdo->recovery_journal;
+	enum vdo_state state = vdo_get_state(vdo);
+
+	vdo_assert_on_admin_thread(vdo, __func__);
+
+	/* start with a clean slate */
+	memset(stats, 0, sizeof(struct vdo_statistics));
+
+	/*
+	 * These are immutable properties of the vdo object, so it is safe to query them from any
+	 * thread.
+	 */
+	stats->version = STATISTICS_VERSION;
+	stats->logical_blocks = vdo->states.vdo.config.logical_blocks;
+	/*
+	 * config.physical_blocks is mutated during resize and is in a packed structure, but resize
+	 * runs on the admin thread.
+	 * TODO: verify that this is always safe
+	 */
+	stats->physical_blocks = vdo->states.vdo.config.physical_blocks;
+	stats->block_size = VDO_BLOCK_SIZE;
+	stats->complete_recoveries = vdo->states.vdo.complete_recoveries;
+	stats->read_only_recoveries = vdo->states.vdo.read_only_recoveries;
+	stats->block_map_cache_size = get_block_map_cache_size(vdo);
+
+	/* The callees are responsible for thread-safety. */
+	stats->data_blocks_used = vdo_get_physical_blocks_allocated(vdo);
+	stats->overhead_blocks_used = vdo_get_physical_blocks_overhead(vdo);
+	stats->logical_blocks_used = vdo_get_recovery_journal_logical_blocks_used(journal);
+	vdo_get_slab_depot_statistics(vdo->depot, stats);
+	stats->journal = vdo_get_recovery_journal_statistics(journal);
+	stats->packer = vdo_get_packer_statistics(vdo->packer);
+	stats->block_map = vdo_get_block_map_statistics(vdo->block_map);
+	vdo_get_dedupe_statistics(vdo->hash_zones, stats);
+	stats->errors = get_vdo_error_statistics(vdo);
+	stats->in_recovery_mode = (state == VDO_RECOVERING);
+	snprintf(stats->mode, sizeof(stats->mode), "%s", vdo_describe_state(state));
+
+	stats->instance = vdo->instance;
+	stats->current_vios_in_progress = get_data_vio_pool_active_requests(vdo->data_vio_pool);
+	stats->max_vios = get_data_vio_pool_maximum_requests(vdo->data_vio_pool);
+
+	stats->flush_out = atomic64_read(&vdo->stats.flush_out);
+	stats->logical_block_size = vdo->device_config->logical_block_size;
+	copy_bio_stat(&stats->bios_in, &vdo->stats.bios_in);
+	copy_bio_stat(&stats->bios_in_partial, &vdo->stats.bios_in_partial);
+	copy_bio_stat(&stats->bios_out, &vdo->stats.bios_out);
+	copy_bio_stat(&stats->bios_meta, &vdo->stats.bios_meta);
+	copy_bio_stat(&stats->bios_journal, &vdo->stats.bios_journal);
+	copy_bio_stat(&stats->bios_page_cache, &vdo->stats.bios_page_cache);
+	copy_bio_stat(&stats->bios_out_completed, &vdo->stats.bios_out_completed);
+	copy_bio_stat(&stats->bios_meta_completed, &vdo->stats.bios_meta_completed);
+	copy_bio_stat(&stats->bios_journal_completed, &vdo->stats.bios_journal_completed);
+	copy_bio_stat(&stats->bios_page_cache_completed, &vdo->stats.bios_page_cache_completed);
+	copy_bio_stat(&stats->bios_acknowledged, &vdo->stats.bios_acknowledged);
+	copy_bio_stat(&stats->bios_acknowledged_partial, &vdo->stats.bios_acknowledged_partial);
+	stats->bios_in_progress = subtract_bio_stats(stats->bios_in, stats->bios_acknowledged);
+	uds_get_memory_stats(&stats->memory_usage.bytes_used,
+			     &stats->memory_usage.peak_bytes_used);
+}
+
+/**
+ * vdo_fetch_statistics_callback() - Action to populate a vdo_statistics
+ *                                   structure on the admin thread.
+ * @completion: The completion.
+ *
+ * This callback is registered in vdo_fetch_statistics().
+ */
+static void vdo_fetch_statistics_callback(struct vdo_completion *completion)
+{
+	get_vdo_statistics(completion->vdo, completion->parent);
+	complete_synchronous_action(completion);
+}
+
+/**
+ * vdo_fetch_statistics() - Fetch statistics on the correct thread.
+ * @vdo: The vdo.
+ * @stats: The vdo statistics are returned here.
+ */
+void vdo_fetch_statistics(struct vdo *vdo, struct vdo_statistics *stats)
+{
+	perform_synchronous_action(vdo,
+				   vdo_fetch_statistics_callback,
+				   vdo->thread_config.admin_thread,
+				   stats);
+}
+
+/**
+ * vdo_get_callback_thread_id() - Get the id of the callback thread on which a completion is
+ *                                currently running.
+ *
+ * Return: The current thread ID, or -1 if no such thread.
+ */
+thread_id_t vdo_get_callback_thread_id(void)
+{
+	struct vdo_work_queue *queue = vdo_get_current_work_queue();
+	struct vdo_thread *thread;
+	thread_id_t thread_id;
+
+	if (queue == NULL)
+		return VDO_INVALID_THREAD_ID;
+
+	thread = vdo_get_work_queue_owner(queue);
+	thread_id = thread->thread_id;
+
+	if (PARANOID_THREAD_CONSISTENCY_CHECKS) {
+		BUG_ON(thread_id >= thread->vdo->thread_config.thread_count);
+		BUG_ON(thread != &thread->vdo->threads[thread_id]);
+	}
+
+	return thread_id;
+}
+
+/**
+ * vdo_dump_status() - Dump status information about a vdo to the log for debugging.
+ * @vdo: The vdo to dump.
+ */
+void vdo_dump_status(const struct vdo *vdo)
+{
+	zone_count_t zone;
+
+	vdo_dump_flusher(vdo->flusher);
+	vdo_dump_recovery_journal_statistics(vdo->recovery_journal);
+	vdo_dump_packer(vdo->packer);
+	vdo_dump_slab_depot(vdo->depot);
+
+	for (zone = 0; zone < vdo->thread_config.logical_zone_count; zone++)
+		vdo_dump_logical_zone(&vdo->logical_zones->zones[zone]);
+
+	for (zone = 0; zone < vdo->thread_config.physical_zone_count; zone++)
+		vdo_dump_physical_zone(&vdo->physical_zones->zones[zone]);
+
+	vdo_dump_hash_zones(vdo->hash_zones);
+}
+
+/**
+ * vdo_assert_on_admin_thread() - Assert that we are running on the admin thread.
+ * @vdo: The vdo.
+ * @name: The name of the function which should be running on the admin thread (for logging).
+ */
+void vdo_assert_on_admin_thread(const struct vdo *vdo, const char *name)
+{
+	ASSERT_LOG_ONLY((vdo_get_callback_thread_id() == vdo->thread_config.admin_thread),
+			"%s called on admin thread",
+			name);
+}
+
+/**
+ * vdo_assert_on_logical_zone_thread() - Assert that this function was called on the specified
+ *                                       logical zone thread.
+ * @vdo: The vdo.
+ * @logical_zone: The number of the logical zone.
+ * @name: The name of the calling function.
+ */
+void vdo_assert_on_logical_zone_thread(const struct vdo *vdo,
+				       zone_count_t logical_zone,
+				       const char *name)
+{
+	ASSERT_LOG_ONLY((vdo_get_callback_thread_id() ==
+			 vdo->thread_config.logical_threads[logical_zone]),
+			"%s called on logical thread",
+			name);
+}
+
+/**
+ * vdo_assert_on_physical_zone_thread() - Assert that this function was called on the specified
+ *                                        physical zone thread.
+ * @vdo: The vdo.
+ * @physical_zone: The number of the physical zone.
+ * @name: The name of the calling function.
+ */
+void vdo_assert_on_physical_zone_thread(const struct vdo *vdo,
+					zone_count_t physical_zone,
+					const char *name)
+{
+	ASSERT_LOG_ONLY((vdo_get_callback_thread_id() ==
+			 vdo->thread_config.physical_threads[physical_zone]),
+			"%s called on physical thread",
+			name);
+}
+
+/**
+ * vdo_get_physical_zone() - Get the physical zone responsible for a given physical block number.
+ * @vdo: The vdo containing the physical zones.
+ * @pbn: The PBN of the data block.
+ * @zone_ptr: A pointer to return the physical zone.
+ *
+ * Gets the physical zone responsible for a given physical block number of a data block in this vdo
+ * instance, or of the zero block (for which a NULL zone is returned). For any other block number
+ * that is not in the range of valid data block numbers in any slab, an error will be returned.
+ * This function is safe to call on invalid block numbers; it will not put the vdo into read-only
+ * mode.
+ *
+ * Return: VDO_SUCCESS or VDO_OUT_OF_RANGE if the block number is invalid or an error code for any
+ *         other failure.
+ */
+int vdo_get_physical_zone(const struct vdo *vdo,
+			  physical_block_number_t pbn,
+			  struct physical_zone **zone_ptr)
+{
+	struct vdo_slab *slab;
+	int result;
+
+	if (pbn == VDO_ZERO_BLOCK) {
+		*zone_ptr = NULL;
+		return VDO_SUCCESS;
+	}
+
+	/*
+	 * Used because it does a more restrictive bounds check than vdo_get_slab(), and done first
+	 * because it won't trigger read-only mode on an invalid PBN.
+	 */
+	if (!vdo_is_physical_data_block(vdo->depot, pbn))
+		return VDO_OUT_OF_RANGE;
+
+	/* With the PBN already checked, we should always succeed in finding a slab. */
+	slab = vdo_get_slab(vdo->depot, pbn);
+	result = ASSERT(slab != NULL, "vdo_get_slab must succeed on all valid PBNs");
+	if (result != VDO_SUCCESS)
+		return result;
+
+	*zone_ptr = &vdo->physical_zones->zones[slab->allocator->zone_number];
+	return VDO_SUCCESS;
+}
diff --git a/drivers/md/dm-vdo/vdo.h b/drivers/md/dm-vdo/vdo.h
new file mode 100644
index 000000000000..a2caf54221c8
--- /dev/null
+++ b/drivers/md/dm-vdo/vdo.h
@@ -0,0 +1,381 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2023 Red Hat
+ */
+
+#ifndef VDO_H
+#define VDO_H
+
+#include <linux/atomic.h>
+#include <linux/blk_types.h>
+#include <linux/completion.h>
+#include <linux/dm-kcopyd.h>
+#include <linux/kobject.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
+#include "admin-state.h"
+#include "encodings.h"
+#include "packer.h"
+#include "physical-zone.h"
+#include "statistics.h"
+#include "thread-registry.h"
+#include "types.h"
+#include "uds.h"
+#include "work-queue.h"
+
+enum notifier_state {
+	/** Notifications are allowed but not in progress */
+	MAY_NOTIFY,
+	/** A notification is in progress */
+	NOTIFYING,
+	/** Notifications are not allowed */
+	MAY_NOT_NOTIFY,
+	/** A notification has completed */
+	NOTIFIED,
+};
+
+/**
+ * typedef vdo_read_only_notification - A function to notify a listener that the VDO has gone
+ *                                      read-only.
+ * @listener: The object to notify.
+ * @parent: The completion to notify in order to acknowledge the notification.
+ */
+typedef void vdo_read_only_notification(void *listener, struct vdo_completion *parent);
+
+/*
+ * An object to be notified when the VDO enters read-only mode
+ */
+struct read_only_listener {
+	/* The listener */
+	void *listener;
+	/* The method to call to notify the listener */
+	vdo_read_only_notification *notify;
+	/* A pointer to the next listener */
+	struct read_only_listener *next;
+};
+
+struct vdo_thread {
+	struct vdo *vdo;
+	thread_id_t thread_id;
+	struct vdo_work_queue *queue;
+	/*
+	 * Each thread maintains its own notion of whether the VDO is read-only so that the
+	 * read-only state can be checked from any base thread without worrying about
+	 * synchronization or thread safety. This does mean that knowledge of the VDO going
+	 * read-only does not occur simultaneously across the VDO's threads, but that does not seem
+	 * to cause any problems.
+	 */
+	bool is_read_only;
+	/*
+	 * A list of objects waiting to be notified on this thread that the VDO has entered
+	 * read-only mode.
+	 */
+	struct read_only_listener *listeners;
+	struct registered_thread allocating_thread;
+};
+
+/* Keep struct bio statistics atomically */
+struct atomic_bio_stats {
+	atomic64_t read; /* Number of not REQ_WRITE bios */
+	atomic64_t write; /* Number of REQ_WRITE bios */
+	atomic64_t discard; /* Number of REQ_DISCARD bios */
+	atomic64_t flush; /* Number of REQ_FLUSH bios */
+	atomic64_t empty_flush; /* Number of REQ_PREFLUSH bios without data */
+	atomic64_t fua; /* Number of REQ_FUA bios */
+};
+
+/* Counters are atomic since updates can arrive concurrently from arbitrary threads. */
+struct atomic_statistics {
+	atomic64_t bios_submitted;
+	atomic64_t bios_completed;
+	atomic64_t flush_out;
+	atomic64_t invalid_advice_pbn_count;
+	atomic64_t no_space_error_count;
+	atomic64_t read_only_error_count;
+	struct atomic_bio_stats bios_in;
+	struct atomic_bio_stats bios_in_partial;
+	struct atomic_bio_stats bios_out;
+	struct atomic_bio_stats bios_out_completed;
+	struct atomic_bio_stats bios_acknowledged;
+	struct atomic_bio_stats bios_acknowledged_partial;
+	struct atomic_bio_stats bios_meta;
+	struct atomic_bio_stats bios_meta_completed;
+	struct atomic_bio_stats bios_journal;
+	struct atomic_bio_stats bios_journal_completed;
+	struct atomic_bio_stats bios_page_cache;
+	struct atomic_bio_stats bios_page_cache_completed;
+};
+
+struct read_only_notifier {
+	/* The completion for entering read-only mode */
+	struct vdo_completion completion;
+	/* A completion waiting for notifications to be drained or enabled */
+	struct vdo_completion *waiter;
+	/* Lock to protect the next two fields */
+	spinlock_t lock;
+	/* The code of the error which put the VDO into read-only mode */
+	int read_only_error;
+	/* The current state of the notifier (values described above) */
+	enum notifier_state state;
+};
+
+/*
+ * The thread ID returned when the current thread is not a vdo thread, or can not be determined
+ * (usually due to being at interrupt context).
+ */
+#define VDO_INVALID_THREAD_ID ((thread_id_t) -1)
+
+struct thread_config {
+	zone_count_t logical_zone_count;
+	zone_count_t physical_zone_count;
+	zone_count_t hash_zone_count;
+	thread_count_t bio_thread_count;
+	thread_count_t thread_count;
+	thread_id_t admin_thread;
+	thread_id_t journal_thread;
+	thread_id_t packer_thread;
+	thread_id_t dedupe_thread;
+	thread_id_t bio_ack_thread;
+	thread_id_t cpu_thread;
+	thread_id_t *logical_threads;
+	thread_id_t *physical_threads;
+	thread_id_t *hash_zone_threads;
+	thread_id_t *bio_threads;
+};
+
+struct thread_count_config;
+
+struct vdo_super_block {
+	/* The vio for reading and writing the super block to disk */
+	struct vio vio;
+	/* A buffer to hold the super block */
+	u8 *buffer;
+	/* Whether this super block may not be written */
+	bool unwritable;
+};
+
+struct data_vio_pool;
+
+struct vdo_administrator {
+	struct vdo_completion completion;
+	struct admin_state state;
+	atomic_t busy;
+	u32 phase;
+	struct completion callback_sync;
+};
+
+struct vdo {
+	char thread_name_prefix[MAX_VDO_WORK_QUEUE_NAME_LEN];
+	struct vdo_thread *threads;
+	vdo_action *action;
+	struct vdo_completion *completion;
+	struct vio_tracer *vio_tracer;
+
+	/* The atomic version of the state of this vdo */
+	atomic_t state;
+	/* The full state of all components */
+	struct vdo_component_states states;
+	/*
+	 * A counter value to attach to thread names and log messages to identify the individual
+	 * device.
+	 */
+	unsigned int instance;
+	/* The read-only notifier */
+	struct read_only_notifier read_only_notifier;
+	/* The load-time configuration of this vdo */
+	struct device_config *device_config;
+	/* The thread mapping */
+	struct thread_config thread_config;
+
+	/* The super block */
+	struct vdo_super_block super_block;
+
+	/* The partitioning of the underlying storage */
+	struct layout layout;
+	struct layout next_layout;
+	struct dm_kcopyd_client *partition_copier;
+
+	/* The block map */
+	struct block_map *block_map;
+
+	/* The journal for block map recovery */
+	struct recovery_journal *recovery_journal;
+
+	/* The slab depot */
+	struct slab_depot *depot;
+
+	/* The compressed-block packer */
+	struct packer *packer;
+	/* Whether incoming data should be compressed */
+	bool compressing;
+
+	/* The handler for flush requests */
+	struct flusher *flusher;
+
+	/* The state the vdo was in when loaded (primarily for unit tests) */
+	enum vdo_state load_state;
+
+	/* The logical zones of this vdo */
+	struct logical_zones *logical_zones;
+
+	/* The physical zones of this vdo */
+	struct physical_zones *physical_zones;
+
+	/* The hash lock zones of this vdo */
+	struct hash_zones *hash_zones;
+
+	/* Bio submission manager used for sending bios to the storage device. */
+	struct io_submitter *io_submitter;
+
+	/* The pool of data_vios for servicing incoming bios */
+	struct data_vio_pool *data_vio_pool;
+
+	/* The manager for administrative operations */
+	struct vdo_administrator admin;
+
+	/* Flags controlling administrative operations */
+	const struct admin_state_code *suspend_type;
+	bool allocations_allowed;
+	bool dump_on_shutdown;
+	atomic_t processing_message;
+
+	/*
+	 * Statistics
+	 * Atomic stats counters
+	 */
+	struct atomic_statistics stats;
+	/* Used to gather statistics without allocating memory */
+	struct vdo_statistics stats_buffer;
+	/* Protects the stats_buffer */
+	struct mutex stats_mutex;
+	/* true if sysfs directory is set up */
+	bool sysfs_added;
+	/* Used when shutting down the sysfs statistics */
+	struct completion stats_shutdown;
+
+
+	/* A list of all device_configs referencing this vdo */
+	struct list_head device_config_list;
+
+	/* This VDO's list entry for the device registry */
+	struct list_head registration;
+
+	/* Underlying block device info. */
+	u64 starting_sector_offset;
+	struct volume_geometry geometry;
+
+	/* For sysfs */
+	struct kobject vdo_directory;
+	struct kobject stats_directory;
+
+	/* N blobs of context data for LZ4 code, one per CPU thread. */
+	char **compression_context;
+};
+
+
+/**
+ * vdo_uses_bio_ack_queue() - Indicate whether the vdo is configured to use a separate work queue
+ *                            for acknowledging received and processed bios.
+ * @vdo: The vdo.
+ *
+ * Note that this directly controls the handling of write operations, but the compile-time flag
+ * VDO_USE_BIO_ACK_QUEUE_FOR_READ is also checked for read operations.
+ *
+ * Return: Whether a bio-acknowledgement work queue is in use.
+ */
+static inline bool vdo_uses_bio_ack_queue(struct vdo *vdo)
+{
+	return vdo->device_config->thread_counts.bio_ack_threads > 0;
+}
+
+/**
+ * typedef vdo_filter_t - Method type for vdo matching methods.
+ *
+ * A filter function returns false if the vdo doesn't match.
+ */
+typedef bool vdo_filter_t(struct vdo *vdo, const void *context);
+
+void vdo_initialize_device_registry_once(void);
+struct vdo * __must_check vdo_find_matching(vdo_filter_t *filter, const void *context);
+
+int __must_check vdo_make_thread(struct vdo *vdo,
+				 thread_id_t thread_id,
+				 const struct vdo_work_queue_type *type,
+				 unsigned int queue_count,
+				 void *contexts[]);
+
+static inline int __must_check vdo_make_default_thread(struct vdo *vdo, thread_id_t thread_id)
+{
+	return vdo_make_thread(vdo, thread_id, NULL, 1, NULL);
+}
+
+int __must_check
+vdo_make(unsigned int instance, struct device_config *config, char **reason, struct vdo **vdo_ptr);
+
+void vdo_destroy(struct vdo *vdo);
+
+void vdo_load_super_block(struct vdo *vdo, struct vdo_completion *parent);
+
+int __must_check vdo_add_sysfs_stats_dir(struct vdo *vdo);
+
+struct block_device * __must_check vdo_get_backing_device(const struct vdo *vdo);
+
+const char * __must_check vdo_get_device_name(const struct dm_target *target);
+
+int __must_check vdo_synchronous_flush(struct vdo *vdo);
+
+const struct admin_state_code * __must_check vdo_get_admin_state(const struct vdo *vdo);
+
+bool vdo_set_compressing(struct vdo *vdo, bool enable);
+
+bool vdo_get_compressing(struct vdo *vdo);
+
+void vdo_fetch_statistics(struct vdo *vdo, struct vdo_statistics *stats);
+
+thread_id_t vdo_get_callback_thread_id(void);
+
+enum vdo_state __must_check vdo_get_state(const struct vdo *vdo);
+
+void vdo_set_state(struct vdo *vdo, enum vdo_state state);
+
+void vdo_save_components(struct vdo *vdo, struct vdo_completion *parent);
+
+int vdo_register_read_only_listener(struct vdo *vdo,
+				    void *listener,
+				    vdo_read_only_notification *notification,
+				    thread_id_t thread_id);
+
+int vdo_enable_read_only_entry(struct vdo *vdo);
+
+void vdo_wait_until_not_entering_read_only_mode(struct vdo_completion *parent);
+
+void vdo_allow_read_only_mode_entry(struct vdo_completion *parent);
+
+void vdo_enter_read_only_mode(struct vdo *vdo, int error_code);
+
+bool __must_check vdo_is_read_only(struct vdo *vdo);
+
+bool __must_check vdo_in_read_only_mode(const struct vdo *vdo);
+
+bool __must_check vdo_in_recovery_mode(const struct vdo *vdo);
+
+void vdo_enter_recovery_mode(struct vdo *vdo);
+
+void vdo_assert_on_admin_thread(const struct vdo *vdo, const char *name);
+
+void vdo_assert_on_logical_zone_thread(const struct vdo *vdo,
+				       zone_count_t logical_zone,
+				       const char *name);
+
+void vdo_assert_on_physical_zone_thread(const struct vdo *vdo,
+					zone_count_t physical_zone,
+					const char *name);
+
+int __must_check vdo_get_physical_zone(const struct vdo *vdo,
+				       physical_block_number_t pbn,
+				       struct physical_zone **zone_ptr);
+
+void vdo_dump_status(const struct vdo *vdo);
+
+#endif /* VDO_H */
-- 
2.40.0

