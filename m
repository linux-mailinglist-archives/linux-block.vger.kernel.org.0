Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF68B70E7E2
	for <lists+linux-block@lfdr.de>; Tue, 23 May 2023 23:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbjEWVrc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 May 2023 17:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238706AbjEWVra (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 17:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6C2CD
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684878398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAiOY4E+4ToZvlssD/00KF8EFrO/qIsk9XpzTYKsuxU=;
        b=HbMkvwLaVqOqYP4+AiyKlWJ/Vc4GzoN7KNFuX2a4ePWjnD6h/h2gmY/ybjIkeIWOJcx9G2
        GuyJ8O0I/2JKB/CoyTgYf4WEPs2QZ7xasdcCWt6gNTXl9nlU31tMGJ5l5sxWU/gFcGnavb
        Ng7AHPFevxlEEkBchW4c3GhA6a6+8is=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-gqg-xzr6OSiSa6XekeT5VQ-1; Tue, 23 May 2023 17:46:37 -0400
X-MC-Unique: gqg-xzr6OSiSa6XekeT5VQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75aff18ebcbso32200385a.0
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878396; x=1687470396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAiOY4E+4ToZvlssD/00KF8EFrO/qIsk9XpzTYKsuxU=;
        b=ULarIGG+YTD6YTPObAn/sPDvKd5ASDcBv8DO2MRHuesQZewp5qPZlRGZ+/rI6D+/mb
         o0EAzAGveh0PuObe+I1fJDjoJgdqckLoHw35Ky8ATdnW2hFwSM3/L1w7vFukSywbeif6
         mKqOH3sHH0VRUReEFoCP8oxnDjApQ7ER/xbujoLhjGTvIJ0X14DqXw+KobFi5C5NaVjA
         dD0qNhOfkOmH3JcOhL6A0lszx/rbee8HuO/dXj+Qt/BcktY9EnaGu1gfLQeHhHEkm9BQ
         Yky6YRxIMcuXXMMPqtGQJU71KH6Z7nHtbPTgFmO6SMZACXHk6x06kU3exQwuaKIh7LvJ
         LCRA==
X-Gm-Message-State: AC+VfDzRVh9CVTjRok5gbBiqlznXnir4DVslwRIdKMlZkAPa2wa5FbWn
        Yk0kI8W3wJrk9AYkdlfWKOlPs2XZ+T/CWfmwKx0nYFZPsGW6wDWFVgKbBQg+RMh065ZgG+AZvAR
        5toEU6uAqKQH6HRCH4QX/LyQ=
X-Received: by 2002:a05:620a:8ecc:b0:75b:23a1:d847 with SMTP id rg12-20020a05620a8ecc00b0075b23a1d847mr5856999qkn.9.1684878395420;
        Tue, 23 May 2023 14:46:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63BhzDFGrHWHwAlbzhpxvRoI5h+p24k0yvWz4JVp1h641LuXMy0lxTFMX03bmPWQcGgrtGmg==
X-Received: by 2002:a05:620a:8ecc:b0:75b:23a1:d847 with SMTP id rg12-20020a05620a8ecc00b0075b23a1d847mr5856945qkn.9.1684878394366;
        Tue, 23 May 2023 14:46:34 -0700 (PDT)
Received: from bf36-1.. (173-166-2-198-newengland.hfc.comcastbusiness.net. [173.166.2.198])
        by smtp.gmail.com with ESMTPSA id el14-20020ad459ce000000b0062119a7a7a3sm3086780qvb.4.2023.05.23.14.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:46:34 -0700 (PDT)
From:   "J. corwin Coburn" <corwin@redhat.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org
Cc:     vdo-devel@redhat.com, "J. corwin Coburn" <corwin@redhat.com>
Subject: [PATCH v2 29/39] Add the vdo block map.
Date:   Tue, 23 May 2023 17:45:29 -0400
Message-Id: <20230523214539.226387-30-corwin@redhat.com>
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

The block map contains the logical to physical mapping. It can be thought
of as an array with one entry per logical address. Each entry is 5 bytes:
36 bits contain the physical block number which holds the data for the
given logical address, and the remaining 4 bits are used to indicate the
nature of the mapping. Of the 16 possible states, one represents a logical
address which is unmapped (i.e. it has never been written, or has been
discarded), one represents an uncompressed block, and the other 14 states
are used to indicate that the mapped data is compressed, and which of the
compression slots in the compressed block this logical address maps to.

Signed-off-by: J. corwin Coburn <corwin@redhat.com>
---
 drivers/md/dm-vdo/block-map.c | 2151 +++++++++++++++++++++++++++++++++
 drivers/md/dm-vdo/block-map.h |  232 ++++
 2 files changed, 2383 insertions(+)
 create mode 100644 drivers/md/dm-vdo/block-map.c
 create mode 100644 drivers/md/dm-vdo/block-map.h

diff --git a/drivers/md/dm-vdo/block-map.c b/drivers/md/dm-vdo/block-map.c
new file mode 100644
index 00000000000..d10cf45cad5
--- /dev/null
+++ b/drivers/md/dm-vdo/block-map.c
@@ -0,0 +1,2151 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright Red Hat
+ */
+
+#include "block-map.h"
+
+#include <linux/bio.h>
+#include <linux/ratelimit.h>
+
+#include "errors.h"
+#include "logger.h"
+#include "memory-alloc.h"
+#include "permassert.h"
+
+#include "action-manager.h"
+#include "admin-state.h"
+#include "completion.h"
+#include "constants.h"
+#include "data-vio.h"
+#include "encodings.h"
+#include "io-submitter.h"
+#include "physical-zone.h"
+#include "recovery-journal.h"
+#include "slab-depot.h"
+#include "status-codes.h"
+#include "types.h"
+#include "vdo.h"
+#include "vio.h"
+#include "wait-queue.h"
+
+/**
+ * DOC: Block map eras
+ *
+ * The block map era, or maximum age, is used as follows:
+ *
+ * Each block map page, when dirty, records the earliest recovery journal block sequence number of
+ * the changes reflected in that dirty block. Sequence numbers are classified into eras: every
+ * @maximum_age sequence numbers, we switch to a new era. Block map pages are assigned to eras
+ * according to the sequence number they record.
+ *
+ * In the current (newest) era, block map pages are not written unless there is cache pressure. In
+ * the next oldest era, each time a new journal block is written 1/@maximum_age of the pages in
+ * this era are issued for write. In all older eras, pages are issued for write immediately.
+ */
+
+struct page_descriptor {
+	root_count_t root_index;
+	height_t height;
+	page_number_t page_index;
+	slot_number_t slot;
+} __packed;
+
+union page_key {
+	struct page_descriptor descriptor;
+	u64 key;
+};
+
+struct write_if_not_dirtied_context {
+	struct block_map_zone *zone;
+	u8 generation;
+};
+
+struct block_map_tree_segment {
+	struct tree_page *levels[VDO_BLOCK_MAP_TREE_HEIGHT];
+};
+
+struct block_map_tree {
+	struct block_map_tree_segment *segments;
+} block_map_tree;
+
+struct forest {
+	struct block_map *map;
+	size_t segments;
+	struct boundary *boundaries;
+	struct tree_page **pages;
+	struct block_map_tree trees[];
+};
+
+struct cursor_level {
+	page_number_t page_index;
+	slot_number_t slot;
+};
+
+struct cursors;
+
+struct cursor {
+	struct waiter waiter;
+	struct block_map_tree *tree;
+	height_t height;
+	struct cursors *parent;
+	struct boundary boundary;
+	struct cursor_level levels[VDO_BLOCK_MAP_TREE_HEIGHT];
+	struct pooled_vio *vio;
+};
+
+struct cursors {
+	struct block_map_zone *zone;
+	struct vio_pool *pool;
+	vdo_entry_callback *entry_callback;
+	struct vdo_completion *parent;
+	root_count_t active_roots;
+	struct cursor cursors[];
+};
+
+/* Used to indicate that the page holding the location of a tree root has been "loaded". */
+const physical_block_number_t VDO_INVALID_PBN = 0xFFFFFFFFFFFFFFFF;
+
+/**
+ * get_tree_page_by_index() - Get the tree page for a given height and page index.
+ *
+ * Return: The requested page.
+ */
+static struct tree_page * __must_check
+get_tree_page_by_index(struct forest *forest,
+		       root_count_t root_index,
+		       height_t height,
+		       page_number_t page_index)
+{
+	page_number_t offset = 0;
+	size_t segment;
+
+	for (segment = 0; segment < forest->segments; segment++) {
+		page_number_t border = forest->boundaries[segment].levels[height - 1];
+
+		if (page_index < border) {
+			struct block_map_tree *tree = &forest->trees[root_index];
+
+			return &(tree->segments[segment].levels[height - 1][page_index - offset]);
+		}
+		offset = border;
+	}
+
+	return NULL;
+}
+
+/* Get the page referred to by the lock's tree slot at its current height. */
+static inline struct tree_page *
+get_tree_page(const struct block_map_zone *zone, const struct tree_lock *lock)
+{
+	return get_tree_page_by_index(zone->block_map->forest,
+				      lock->root_index,
+				      lock->height,
+				      lock->tree_slots[lock->height].page_index);
+}
+
+/** vdo_copy_valid_page() - Validate and copy a buffer to a page. */
+bool vdo_copy_valid_page(char *buffer,
+			 nonce_t nonce,
+			 physical_block_number_t pbn,
+			 struct block_map_page *page)
+{
+	struct block_map_page *loaded = (struct block_map_page *) buffer;
+	enum block_map_page_validity validity = vdo_validate_block_map_page(loaded, nonce, pbn);
+
+	if (validity == VDO_BLOCK_MAP_PAGE_VALID) {
+		memcpy(page, loaded, VDO_BLOCK_SIZE);
+		return true;
+	}
+
+	if (validity == VDO_BLOCK_MAP_PAGE_BAD)
+		uds_log_error_strerror(VDO_BAD_PAGE,
+				       "Expected page %llu but got page %llu instead",
+				       (unsigned long long) pbn,
+				       (unsigned long long) vdo_get_block_map_page_pbn(loaded));
+
+	return false;
+}
+
+/**
+ * in_cyclic_range() - Check whether the given value is between the lower and upper bounds, within
+ *                     a cyclic range of values from 0 to (modulus - 1).
+ * @lower: The lowest value to accept.
+ * @value: The value to check.
+ * @upper: The highest value to accept.
+ * @modulus: The size of the cyclic space, no more than 2^15.
+ *
+ * The value and both bounds must be smaller than the modulus.
+ *
+ * Return: true if the value is in range.
+ */
+static bool in_cyclic_range(u16 lower, u16 value, u16 upper, u16 modulus)
+{
+	if (value < lower)
+		value += modulus;
+	if (upper < lower)
+		upper += modulus;
+	return (value <= upper);
+}
+
+/**
+ * is_not_older() - Check whether a generation is strictly older than some other generation in the
+ *                  context of a zone's current generation range.
+ * @zone: The zone in which to do the comparison.
+ * @a: The generation in question.
+ * @b: The generation to compare to.
+ *
+ * Return: true if generation @a is not strictly older than generation @b in the context of @zone
+ */
+static bool __must_check is_not_older(struct block_map_zone *zone, u8 a, u8 b)
+{
+	int result;
+
+	result = ASSERT((in_cyclic_range(zone->oldest_generation, a, zone->generation, 1 << 8) &&
+			 in_cyclic_range(zone->oldest_generation, b, zone->generation, 1 << 8)),
+			"generation(s) %u, %u are out of range [%u, %u]",
+			a, b, zone->oldest_generation, zone->generation);
+	if (result != VDO_SUCCESS) {
+		enter_zone_read_only_mode(zone, result);
+		return true;
+	}
+
+	return in_cyclic_range(b, a, zone->generation, 1 << 8);
+}
+
+static void release_generation(struct block_map_zone *zone, u8 generation)
+{
+	int result;
+
+	result = ASSERT((zone->dirty_page_counts[generation] > 0),
+			"dirty page count underflow for generation %u",
+			generation);
+	if (result != VDO_SUCCESS) {
+		enter_zone_read_only_mode(zone, result);
+		return;
+	}
+
+	zone->dirty_page_counts[generation]--;
+	while ((zone->dirty_page_counts[zone->oldest_generation] == 0) &&
+	       (zone->oldest_generation != zone->generation))
+		zone->oldest_generation++;
+}
+
+static void
+set_generation(struct block_map_zone *zone, struct tree_page *page, u8 new_generation)
+{
+	u32 new_count;
+	int result;
+	bool decrement_old = vdo_is_waiting(&page->waiter);
+	u8 old_generation = page->generation;
+
+	if (decrement_old && (old_generation == new_generation))
+		return;
+
+	page->generation = new_generation;
+	new_count = ++zone->dirty_page_counts[new_generation];
+	result = ASSERT((new_count != 0),
+			"dirty page count overflow for generation %u",
+			new_generation);
+	if (result != VDO_SUCCESS) {
+		enter_zone_read_only_mode(zone, result);
+		return;
+	}
+
+	if (decrement_old)
+		release_generation(zone, old_generation);
+}
+
+static void write_page(struct tree_page *tree_page, struct pooled_vio *vio);
+
+/* Implements waiter_callback */
+static void write_page_callback(struct waiter *waiter, void *context)
+{
+	write_page(container_of(waiter, struct tree_page, waiter), (struct pooled_vio *) context);
+}
+
+static void acquire_vio(struct waiter *waiter, struct block_map_zone *zone)
+{
+	waiter->callback = write_page_callback;
+	acquire_vio_from_pool(zone->vio_pool, waiter);
+}
+
+/* Return: true if all possible generations were not already active */
+static bool attempt_increment(struct block_map_zone *zone)
+{
+	u8 generation = zone->generation + 1;
+
+	if (zone->oldest_generation == generation)
+		return false;
+
+	zone->generation = generation;
+	return true;
+}
+
+/* Launches a flush if one is not already in progress. */
+static void enqueue_page(struct tree_page *page, struct block_map_zone *zone)
+{
+	if ((zone->flusher == NULL) && attempt_increment(zone)) {
+		zone->flusher = page;
+		acquire_vio(&page->waiter, zone);
+		return;
+	}
+
+	vdo_enqueue_waiter(&zone->flush_waiters, &page->waiter);
+}
+
+static void write_page_if_not_dirtied(struct waiter *waiter, void *context)
+{
+	struct tree_page *page = container_of(waiter, struct tree_page, waiter);
+	struct write_if_not_dirtied_context *write_context = context;
+
+	if (page->generation == write_context->generation) {
+		acquire_vio(waiter, write_context->zone);
+		return;
+	}
+
+	enqueue_page(page, write_context->zone);
+}
+
+static void return_to_pool(struct block_map_zone *zone, struct pooled_vio *vio)
+{
+	return_vio_to_pool(zone->vio_pool, vio);
+	check_for_drain_complete(zone);
+}
+
+/* This callback is registered in write_initialized_page(). */
+static void finish_page_write(struct vdo_completion *completion)
+{
+	bool dirty;
+	struct vio *vio = as_vio(completion);
+	struct pooled_vio *pooled = container_of(vio, struct pooled_vio, vio);
+	struct tree_page *page = completion->parent;
+	struct block_map_zone *zone = pooled->context;
+
+	vdo_release_recovery_journal_block_reference(zone->block_map->journal,
+						     page->writing_recovery_lock,
+						     VDO_ZONE_TYPE_LOGICAL,
+						     zone->zone_number);
+
+	dirty = (page->writing_generation != page->generation);
+	release_generation(zone, page->writing_generation);
+	page->writing = false;
+
+	if (zone->flusher == page) {
+		struct write_if_not_dirtied_context context = {
+			.zone = zone,
+			.generation = page->writing_generation,
+		};
+
+		vdo_notify_all_waiters(&zone->flush_waiters, write_page_if_not_dirtied, &context);
+		if (dirty && attempt_increment(zone)) {
+			write_page(page, pooled);
+			return;
+		}
+
+		zone->flusher = NULL;
+	}
+
+	if (dirty) {
+		enqueue_page(page, zone);
+	} else if ((zone->flusher == NULL) &&
+		   vdo_has_waiters(&zone->flush_waiters) &&
+		   attempt_increment(zone)) {
+		zone->flusher = container_of(vdo_dequeue_next_waiter(&zone->flush_waiters),
+					     struct tree_page,
+					     waiter);
+		write_page(zone->flusher, pooled);
+		return;
+	}
+
+	return_to_pool(zone, pooled);
+}
+
+static void handle_write_error(struct vdo_completion *completion)
+{
+	int result = completion->result;
+	struct vio *vio = as_vio(completion);
+	struct pooled_vio *pooled = container_of(vio, struct pooled_vio, vio);
+	struct block_map_zone *zone = pooled->context;
+
+	vio_record_metadata_io_error(vio);
+	enter_zone_read_only_mode(zone, result);
+	return_to_pool(zone, pooled);
+}
+
+static void write_page_endio(struct bio *bio);
+
+static void write_initialized_page(struct vdo_completion *completion)
+{
+	struct vio *vio = as_vio(completion);
+	struct pooled_vio *pooled = container_of(vio, struct pooled_vio, vio);
+	struct block_map_zone *zone = pooled->context;
+	struct tree_page *tree_page = completion->parent;
+	struct block_map_page *page = (struct block_map_page *) vio->data;
+	unsigned int operation = REQ_OP_WRITE | REQ_PRIO;
+
+	/*
+	 * Now that we know the page has been written at least once, mark the copy we are writing
+	 * as initialized.
+	 */
+	page->header.initialized = true;
+
+	if (zone->flusher == tree_page)
+		operation |= REQ_PREFLUSH;
+
+	submit_metadata_vio(vio,
+			    vdo_get_block_map_page_pbn(page),
+			    write_page_endio,
+			    handle_write_error,
+			    operation);
+}
+
+static void write_page_endio(struct bio *bio)
+{
+	struct pooled_vio *vio = bio->bi_private;
+	struct block_map_zone *zone = vio->context;
+	struct block_map_page *page = (struct block_map_page *) vio->vio.data;
+
+	continue_vio_after_io(&vio->vio,
+			      (page->header.initialized ?
+			       finish_page_write :
+			       write_initialized_page),
+			      zone->thread_id);
+}
+
+static void write_page(struct tree_page *tree_page, struct pooled_vio *vio)
+{
+	struct vdo_completion *completion = &vio->vio.completion;
+	struct block_map_zone *zone = vio->context;
+	struct block_map_page *page = vdo_as_block_map_page(tree_page);
+
+	if ((zone->flusher != tree_page) &&
+	    is_not_older(zone, tree_page->generation, zone->generation)) {
+		/*
+		 * This page was re-dirtied after the last flush was issued, hence we need to do
+		 * another flush.
+		 */
+		enqueue_page(tree_page, zone);
+		return_to_pool(zone, vio);
+		return;
+	}
+
+	completion->parent = tree_page;
+	memcpy(vio->vio.data, tree_page->page_buffer, VDO_BLOCK_SIZE);
+	completion->callback_thread_id = zone->thread_id;
+
+	tree_page->writing = true;
+	tree_page->writing_generation = tree_page->generation;
+	tree_page->writing_recovery_lock = tree_page->recovery_lock;
+
+	/* Clear this now so that we know this page is not on any dirty list. */
+	tree_page->recovery_lock = 0;
+
+	/*
+	 * We've already copied the page into the vio which will write it, so if it was not yet
+	 * initialized, the first write will indicate that (for torn write protection). It is now
+	 * safe to mark it as initialized in memory since if the write fails, the in memory state
+	 * will become irrelevant.
+	 */
+	if (page->header.initialized) {
+		write_initialized_page(completion);
+		return;
+	}
+
+	page->header.initialized = true;
+	submit_metadata_vio(&vio->vio,
+			    vdo_get_block_map_page_pbn(page),
+			    write_page_endio,
+			    handle_write_error,
+			    REQ_OP_WRITE | REQ_PRIO);
+}
+
+/* Release a lock on a page which was being loaded or allocated. */
+static void release_page_lock(struct data_vio *data_vio, char *what)
+{
+	struct block_map_zone *zone;
+	struct tree_lock *lock_holder;
+	struct tree_lock *lock = &data_vio->tree_lock;
+
+	ASSERT_LOG_ONLY(lock->locked,
+			"release of unlocked block map page %s for key %llu in tree %u",
+			what, (unsigned long long) lock->key,
+			lock->root_index);
+
+	zone = data_vio->logical.zone->block_map_zone;
+	lock_holder = vdo_int_map_remove(zone->loading_pages, lock->key);
+	ASSERT_LOG_ONLY((lock_holder == lock),
+			"block map page %s mismatch for key %llu in tree %u",
+			what,
+			(unsigned long long) lock->key,
+			lock->root_index);
+	lock->locked = false;
+}
+
+static void finish_lookup(struct data_vio *data_vio, int result)
+{
+	data_vio->tree_lock.height = 0;
+
+	--data_vio->logical.zone->block_map_zone->active_lookups;
+
+	set_data_vio_logical_callback(data_vio, continue_data_vio_with_block_map_slot);
+	data_vio->vio.completion.error_handler = handle_data_vio_error;
+	continue_data_vio_with_error(data_vio, result);
+}
+
+static void abort_lookup_for_waiter(struct waiter *waiter, void *context)
+{
+	struct data_vio *data_vio = waiter_as_data_vio(waiter);
+	int result = *((int *) context);
+
+	if (!data_vio->write) {
+		if (result == VDO_NO_SPACE)
+			result = VDO_SUCCESS;
+	} else if (result != VDO_NO_SPACE) {
+		result = VDO_READ_ONLY;
+	}
+
+	finish_lookup(data_vio, result);
+}
+
+static void abort_lookup(struct data_vio *data_vio, int result, char *what)
+{
+	if (result != VDO_NO_SPACE)
+		enter_zone_read_only_mode(data_vio->logical.zone->block_map_zone, result);
+
+	if (data_vio->tree_lock.locked) {
+		release_page_lock(data_vio, what);
+		vdo_notify_all_waiters(&data_vio->tree_lock.waiters,
+				       abort_lookup_for_waiter,
+				       &result);
+	}
+
+	finish_lookup(data_vio, result);
+}
+
+static void abort_load(struct data_vio *data_vio, int result)
+{
+	abort_lookup(data_vio, result, "load");
+}
+
+static bool __must_check
+is_invalid_tree_entry(const struct vdo *vdo, const struct data_location *mapping, height_t height)
+{
+	if (!vdo_is_valid_location(mapping) ||
+	    vdo_is_state_compressed(mapping->state) ||
+	    (vdo_is_mapped_location(mapping) && (mapping->pbn == VDO_ZERO_BLOCK)))
+		return true;
+
+	/* Roots aren't physical data blocks, so we can't check their PBNs. */
+	if (height == VDO_BLOCK_MAP_TREE_HEIGHT)
+		return false;
+
+	return !vdo_is_physical_data_block(vdo->depot, mapping->pbn);
+}
+
+static void load_block_map_page(struct block_map_zone *zone, struct data_vio *data_vio);
+static void allocate_block_map_page(struct block_map_zone *zone, struct data_vio *data_vio);
+
+static void continue_with_loaded_page(struct data_vio *data_vio, struct block_map_page *page)
+{
+	struct tree_lock *lock = &data_vio->tree_lock;
+	struct block_map_tree_slot slot = lock->tree_slots[lock->height];
+	struct data_location mapping =
+		vdo_unpack_block_map_entry(&page->entries[slot.block_map_slot.slot]);
+
+	if (is_invalid_tree_entry(vdo_from_data_vio(data_vio), &mapping, lock->height)) {
+		uds_log_error_strerror(VDO_BAD_MAPPING,
+				       "Invalid block map tree PBN: %llu with state %u for page index %u at height %u",
+				       (unsigned long long) mapping.pbn,
+				       mapping.state,
+				       lock->tree_slots[lock->height - 1].page_index,
+				       lock->height - 1);
+		abort_load(data_vio, VDO_BAD_MAPPING);
+		return;
+	}
+
+	if (!vdo_is_mapped_location(&mapping)) {
+		/* The page we need is unallocated */
+		allocate_block_map_page(data_vio->logical.zone->block_map_zone, data_vio);
+		return;
+	}
+
+	lock->tree_slots[lock->height - 1].block_map_slot.pbn = mapping.pbn;
+	if (lock->height == 1) {
+		finish_lookup(data_vio, VDO_SUCCESS);
+		return;
+	}
+
+	/* We know what page we need to load next */
+	load_block_map_page(data_vio->logical.zone->block_map_zone, data_vio);
+}
+
+static void continue_load_for_waiter(struct waiter *waiter, void *context)
+{
+	struct data_vio *data_vio = waiter_as_data_vio(waiter);
+
+	data_vio->tree_lock.height--;
+	continue_with_loaded_page(data_vio, (struct block_map_page *) context);
+}
+
+static void finish_block_map_page_load(struct vdo_completion *completion)
+{
+	physical_block_number_t pbn;
+	struct tree_page *tree_page;
+	struct block_map_page *page;
+	nonce_t nonce;
+	struct vio *vio = as_vio(completion);
+	struct pooled_vio *pooled = vio_as_pooled_vio(vio);
+	struct data_vio *data_vio = completion->parent;
+	struct block_map_zone *zone = pooled->context;
+	struct tree_lock *tree_lock = &data_vio->tree_lock;
+
+	tree_lock->height--;
+	pbn = tree_lock->tree_slots[tree_lock->height].block_map_slot.pbn;
+	tree_page = get_tree_page(zone, tree_lock);
+	page = (struct block_map_page *) tree_page->page_buffer;
+	nonce = zone->block_map->nonce;
+
+	if (!vdo_copy_valid_page(vio->data, nonce, pbn, page))
+		vdo_format_block_map_page(page, nonce, pbn, false);
+	return_vio_to_pool(zone->vio_pool, pooled);
+
+	/* Release our claim to the load and wake any waiters */
+	release_page_lock(data_vio, "load");
+	vdo_notify_all_waiters(&tree_lock->waiters, continue_load_for_waiter, page);
+	continue_with_loaded_page(data_vio, page);
+}
+
+static void handle_io_error(struct vdo_completion *completion)
+{
+	int result = completion->result;
+	struct vio *vio = as_vio(completion);
+	struct pooled_vio *pooled = container_of(vio, struct pooled_vio, vio);
+	struct data_vio *data_vio = completion->parent;
+	struct block_map_zone *zone = pooled->context;
+
+	vio_record_metadata_io_error(vio);
+	return_vio_to_pool(zone->vio_pool, pooled);
+	abort_load(data_vio, result);
+}
+
+static void load_page_endio(struct bio *bio)
+{
+	struct vio *vio = bio->bi_private;
+	struct data_vio *data_vio = vio->completion.parent;
+
+	continue_vio_after_io(vio, finish_block_map_page_load, data_vio->logical.zone->thread_id);
+}
+
+static void load_page(struct waiter *waiter, void *context)
+{
+	struct pooled_vio *pooled = context;
+	struct data_vio *data_vio = waiter_as_data_vio(waiter);
+	struct tree_lock *lock = &data_vio->tree_lock;
+	physical_block_number_t pbn = lock->tree_slots[lock->height - 1].block_map_slot.pbn;
+
+	pooled->vio.completion.parent = data_vio;
+	submit_metadata_vio(&pooled->vio,
+			    pbn,
+			    load_page_endio,
+			    handle_io_error,
+			    REQ_OP_READ | REQ_PRIO);
+}
+
+/*
+ * If the page is already locked, queue up to wait for the lock to be released. If the lock is
+ * acquired, @data_vio->tree_lock.locked will be true.
+ */
+static int attempt_page_lock(struct block_map_zone *zone, struct data_vio *data_vio)
+{
+	int result;
+	struct tree_lock *lock_holder;
+	struct tree_lock *lock = &data_vio->tree_lock;
+	height_t height = lock->height;
+	struct block_map_tree_slot tree_slot = lock->tree_slots[height];
+	union page_key key;
+
+	key.descriptor = (struct page_descriptor) {
+		.root_index = lock->root_index,
+		.height = height,
+		.page_index = tree_slot.page_index,
+		.slot = tree_slot.block_map_slot.slot,
+	};
+	lock->key = key.key;
+
+	result = vdo_int_map_put(zone->loading_pages,
+				 lock->key,
+				 lock,
+				 false,
+				 (void **) &lock_holder);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	if (lock_holder == NULL) {
+		/* We got the lock */
+		data_vio->tree_lock.locked = true;
+		return VDO_SUCCESS;
+	}
+
+	/* Someone else is loading or allocating the page we need */
+	vdo_enqueue_waiter(&lock_holder->waiters, &data_vio->waiter);
+	return VDO_SUCCESS;
+}
+
+/* Load a block map tree page from disk, for the next level in the data vio tree lock. */
+static void load_block_map_page(struct block_map_zone *zone, struct data_vio *data_vio)
+{
+	int result;
+
+	result = attempt_page_lock(zone, data_vio);
+	if (result != VDO_SUCCESS) {
+		abort_load(data_vio, result);
+		return;
+	}
+
+	if (data_vio->tree_lock.locked) {
+		data_vio->waiter.callback = load_page;
+		acquire_vio_from_pool(zone->vio_pool, &data_vio->waiter);
+	}
+}
+
+static void allocation_failure(struct vdo_completion *completion)
+{
+	struct data_vio *data_vio = as_data_vio(completion);
+
+	if (vdo_requeue_completion_if_needed(completion, data_vio->logical.zone->thread_id))
+		return;
+
+	abort_lookup(data_vio, completion->result, "allocation");
+}
+
+static void continue_allocation_for_waiter(struct waiter *waiter, void *context)
+{
+	struct data_vio *data_vio = waiter_as_data_vio(waiter);
+	struct tree_lock *tree_lock = &data_vio->tree_lock;
+	physical_block_number_t pbn = *((physical_block_number_t *) context);
+
+	tree_lock->height--;
+	data_vio->tree_lock.tree_slots[tree_lock->height].block_map_slot.pbn = pbn;
+
+	if (tree_lock->height == 0) {
+		finish_lookup(data_vio, VDO_SUCCESS);
+		return;
+	}
+
+	allocate_block_map_page(data_vio->logical.zone->block_map_zone, data_vio);
+}
+
+/** expire_oldest_list() - Expire the oldest list. */
+static void expire_oldest_list(struct dirty_lists *dirty_lists)
+{
+	block_count_t i = dirty_lists->offset++;
+
+	dirty_lists->oldest_period++;
+	if (!list_empty(&dirty_lists->eras[i][VDO_TREE_PAGE]))
+		list_splice_tail_init(&dirty_lists->eras[i][VDO_TREE_PAGE],
+				      &dirty_lists->expired[VDO_TREE_PAGE]);
+	if (!list_empty(&dirty_lists->eras[i][VDO_CACHE_PAGE]))
+		list_splice_tail_init(&dirty_lists->eras[i][VDO_CACHE_PAGE],
+				      &dirty_lists->expired[VDO_CACHE_PAGE]);
+
+	if (dirty_lists->offset == dirty_lists->maximum_age)
+		dirty_lists->offset = 0;
+}
+
+
+/** update_period() - Update the dirty_lists period if necessary. */
+static void update_period(struct dirty_lists *dirty, sequence_number_t period)
+{
+	while (dirty->next_period <= period) {
+		if ((dirty->next_period - dirty->oldest_period) == dirty->maximum_age)
+			expire_oldest_list(dirty);
+		dirty->next_period++;
+	}
+}
+
+/** write_expired_elements() - Write out the expired list. */
+static void write_expired_elements(struct block_map_zone *zone)
+{
+	struct tree_page *page, *ttmp;
+	struct page_info *info, *ptmp;
+	struct list_head *expired;
+	u8 generation = zone->generation;
+
+	expired = &zone->dirty_lists->expired[VDO_TREE_PAGE];
+	list_for_each_entry_safe(page, ttmp, expired, entry) {
+		int result;
+
+		list_del_init(&page->entry);
+
+		result = ASSERT(!vdo_is_waiting(&page->waiter),
+				"Newly expired page not already waiting to write");
+		if (result != VDO_SUCCESS) {
+			enter_zone_read_only_mode(zone, result);
+			continue;
+		}
+
+		set_generation(zone, page, generation);
+		if (!page->writing)
+			enqueue_page(page, zone);
+	}
+
+	expired = &zone->dirty_lists->expired[VDO_CACHE_PAGE];
+	list_for_each_entry_safe(info, ptmp, expired, state_entry) {
+		list_del_init(&info->state_entry);
+		schedule_page_save(info);
+	}
+
+	save_pages(&zone->page_cache);
+}
+
+/**
+ * add_to_dirty_lists() - Add an element to the dirty lists.
+ * @zone: The zone in which we are operating.
+ * @entry: The list entry of the element to add.
+ * @type: The type of page.
+ * @old_period: The period in which the element was previously dirtied, or 0 if it was not dirty.
+ * @new_period: The period in which the element has now been dirtied, or 0 if it does not hold a
+ *              lock.
+ */
+static void
+add_to_dirty_lists(struct block_map_zone *zone,
+		   struct list_head *entry,
+		   enum block_map_page_type type,
+		   sequence_number_t old_period,
+		   sequence_number_t new_period)
+{
+	struct dirty_lists *dirty_lists = zone->dirty_lists;
+
+	if ((old_period == new_period) || ((old_period != 0) && (old_period < new_period)))
+		return;
+
+	if (new_period < dirty_lists->oldest_period) {
+		list_move_tail(entry, &dirty_lists->expired[type]);
+	} else {
+		update_period(dirty_lists, new_period);
+		list_move_tail(entry,
+			       &dirty_lists->eras[new_period % dirty_lists->maximum_age][type]);
+	}
+
+	write_expired_elements(zone);
+}
+
+/*
+ * Record the allocation in the tree and wake any waiters now that the write lock has been
+ * released.
+ */
+static void finish_block_map_allocation(struct vdo_completion *completion)
+{
+	physical_block_number_t pbn;
+	struct tree_page *tree_page;
+	struct block_map_page *page;
+	sequence_number_t old_lock;
+	struct data_vio *data_vio = as_data_vio(completion);
+	struct block_map_zone *zone = data_vio->logical.zone->block_map_zone;
+	struct tree_lock *tree_lock = &data_vio->tree_lock;
+	height_t height = tree_lock->height;
+
+	assert_data_vio_in_logical_zone(data_vio);
+
+	tree_page = get_tree_page(zone, tree_lock);
+	pbn = tree_lock->tree_slots[height - 1].block_map_slot.pbn;
+
+	/* Record the allocation. */
+	page = (struct block_map_page *) tree_page->page_buffer;
+	old_lock = tree_page->recovery_lock;
+	vdo_update_block_map_page(page,
+				  data_vio,
+				  pbn,
+				  VDO_MAPPING_STATE_UNCOMPRESSED,
+				  &tree_page->recovery_lock);
+
+	if (vdo_is_waiting(&tree_page->waiter)) {
+		/* This page is waiting to be written out. */
+		if (zone->flusher != tree_page)
+			/*
+			 * The outstanding flush won't cover the update we just made, so mark the
+			 * page as needing another flush.
+			 */
+			set_generation(zone, tree_page, zone->generation);
+	} else {
+		/* Put the page on a dirty list */
+		if (old_lock == 0)
+			INIT_LIST_HEAD(&tree_page->entry);
+		add_to_dirty_lists(zone,
+				   &tree_page->entry,
+				   VDO_TREE_PAGE,
+				   old_lock,
+				   tree_page->recovery_lock);
+	}
+
+	tree_lock->height--;
+	if (height > 1) {
+		/* Format the interior node we just allocated (in memory). */
+		tree_page = get_tree_page(zone, tree_lock);
+		vdo_format_block_map_page(tree_page->page_buffer,
+					  zone->block_map->nonce,
+					  pbn,
+					  false);
+	}
+
+	/* Release our claim to the allocation and wake any waiters */
+	release_page_lock(data_vio, "allocation");
+	vdo_notify_all_waiters(&tree_lock->waiters, continue_allocation_for_waiter, &pbn);
+	if (tree_lock->height == 0) {
+		finish_lookup(data_vio, VDO_SUCCESS);
+		return;
+	}
+
+	allocate_block_map_page(zone, data_vio);
+}
+
+static void release_block_map_write_lock(struct vdo_completion *completion)
+{
+	struct data_vio *data_vio = as_data_vio(completion);
+
+	assert_data_vio_in_allocated_zone(data_vio);
+
+	release_data_vio_allocation_lock(data_vio, true);
+	launch_data_vio_logical_callback(data_vio, finish_block_map_allocation);
+}
+
+/*
+ * Newly allocated block map pages are set to have to MAXIMUM_REFERENCES after they are journaled,
+ * to prevent deduplication against the block after we release the write lock on it, but before we
+ * write out the page.
+ */
+static void set_block_map_page_reference_count(struct vdo_completion *completion)
+{
+	struct data_vio *data_vio = as_data_vio(completion);
+
+	assert_data_vio_in_allocated_zone(data_vio);
+
+	completion->callback = release_block_map_write_lock;
+	vdo_modify_reference_count(completion, &data_vio->increment_updater);
+}
+
+static void journal_block_map_allocation(struct vdo_completion *completion)
+{
+	struct data_vio *data_vio = as_data_vio(completion);
+
+	assert_data_vio_in_journal_zone(data_vio);
+
+	set_data_vio_allocated_zone_callback(data_vio, set_block_map_page_reference_count);
+	vdo_add_recovery_journal_entry(completion->vdo->recovery_journal, data_vio);
+}
+
+static void allocate_block(struct vdo_completion *completion)
+{
+	struct data_vio *data_vio = as_data_vio(completion);
+	struct tree_lock *lock = &data_vio->tree_lock;
+	physical_block_number_t pbn;
+
+	assert_data_vio_in_allocated_zone(data_vio);
+
+	if (!vdo_allocate_block_in_zone(data_vio))
+		return;
+
+	pbn = data_vio->allocation.pbn;
+	lock->tree_slots[lock->height - 1].block_map_slot.pbn = pbn;
+	data_vio->increment_updater = (struct reference_updater) {
+		.operation = VDO_JOURNAL_BLOCK_MAP_REMAPPING,
+		.increment = true,
+		.zpbn = {
+			.pbn = pbn,
+			.state = VDO_MAPPING_STATE_UNCOMPRESSED,
+		},
+		.lock = data_vio->allocation.lock,
+	};
+
+	launch_data_vio_journal_callback(data_vio, journal_block_map_allocation);
+}
+
+static void allocate_block_map_page(struct block_map_zone *zone, struct data_vio *data_vio)
+{
+	int result;
+
+	if (!data_vio->write || data_vio->is_trim) {
+		/* This is a pure read or a trim, so there's nothing left to do here. */
+		finish_lookup(data_vio, VDO_SUCCESS);
+		return;
+	}
+
+	result = attempt_page_lock(zone, data_vio);
+	if (result != VDO_SUCCESS) {
+		abort_lookup(data_vio, result, "allocation");
+		return;
+	}
+
+	if (!data_vio->tree_lock.locked)
+		return;
+
+	data_vio_allocate_data_block(data_vio,
+				     VIO_BLOCK_MAP_WRITE_LOCK,
+				     allocate_block,
+				     allocation_failure);
+}
+
+/**
+ * vdo_find_block_map_slot() - Find the block map slot in which the block map entry for a data_vio
+ *                             resides and cache that result in the data_vio.
+ *
+ * All ancestors in the tree will be allocated or loaded, as needed.
+ */
+void vdo_find_block_map_slot(struct data_vio *data_vio)
+{
+	page_number_t page_index;
+	struct block_map_tree_slot tree_slot;
+	struct data_location mapping;
+	struct block_map_page *page = NULL;
+	struct tree_lock *lock = &data_vio->tree_lock;
+	struct block_map_zone *zone = data_vio->logical.zone->block_map_zone;
+
+	zone->active_lookups++;
+	if (vdo_is_state_draining(&zone->state)) {
+		finish_lookup(data_vio, VDO_SHUTTING_DOWN);
+		return;
+	}
+
+	lock->tree_slots[0].block_map_slot.slot =
+		data_vio->logical.lbn % VDO_BLOCK_MAP_ENTRIES_PER_PAGE;
+	page_index = (lock->tree_slots[0].page_index / zone->block_map->root_count);
+	tree_slot = (struct block_map_tree_slot) {
+		.page_index = page_index / VDO_BLOCK_MAP_ENTRIES_PER_PAGE,
+		.block_map_slot = {
+			.pbn = 0,
+			.slot = page_index % VDO_BLOCK_MAP_ENTRIES_PER_PAGE,
+		},
+	};
+
+	for (lock->height = 1; lock->height <= VDO_BLOCK_MAP_TREE_HEIGHT; lock->height++) {
+		physical_block_number_t pbn;
+
+		lock->tree_slots[lock->height] = tree_slot;
+		page = (struct block_map_page *) (get_tree_page(zone, lock)->page_buffer);
+		pbn = vdo_get_block_map_page_pbn(page);
+		if (pbn != VDO_ZERO_BLOCK) {
+			lock->tree_slots[lock->height].block_map_slot.pbn = pbn;
+			break;
+		}
+
+		/* Calculate the index and slot for the next level. */
+		tree_slot.block_map_slot.slot =
+			tree_slot.page_index % VDO_BLOCK_MAP_ENTRIES_PER_PAGE;
+		tree_slot.page_index = tree_slot.page_index / VDO_BLOCK_MAP_ENTRIES_PER_PAGE;
+	}
+
+	/* The page at this height has been allocated and loaded. */
+	mapping = vdo_unpack_block_map_entry(&page->entries[tree_slot.block_map_slot.slot]);
+	if (is_invalid_tree_entry(vdo_from_data_vio(data_vio), &mapping, lock->height)) {
+		uds_log_error_strerror(VDO_BAD_MAPPING,
+				       "Invalid block map tree PBN: %llu with state %u for page index %u at height %u",
+				       (unsigned long long) mapping.pbn,
+				       mapping.state,
+				       lock->tree_slots[lock->height - 1].page_index,
+				       lock->height - 1);
+		abort_load(data_vio, VDO_BAD_MAPPING);
+		return;
+	}
+
+	if (!vdo_is_mapped_location(&mapping)) {
+		/* The page we want one level down has not been allocated, so allocate it. */
+		allocate_block_map_page(zone, data_vio);
+		return;
+	}
+
+	lock->tree_slots[lock->height - 1].block_map_slot.pbn = mapping.pbn;
+	if (lock->height == 1) {
+		/* This is the ultimate block map page, so we're done */
+		finish_lookup(data_vio, VDO_SUCCESS);
+		return;
+	}
+
+	/* We know what page we need to load. */
+	load_block_map_page(zone, data_vio);
+}
+
+/*
+ * Find the PBN of a leaf block map page. This method may only be used after all allocated tree
+ * pages have been loaded, otherwise, it may give the wrong answer (0).
+ */
+physical_block_number_t
+vdo_find_block_map_page_pbn(struct block_map *map, page_number_t page_number)
+{
+	struct data_location mapping;
+	struct tree_page *tree_page;
+	struct block_map_page *page;
+	root_count_t root_index = page_number % map->root_count;
+	page_number_t page_index = page_number / map->root_count;
+	slot_number_t slot = page_index % VDO_BLOCK_MAP_ENTRIES_PER_PAGE;
+
+	page_index /= VDO_BLOCK_MAP_ENTRIES_PER_PAGE;
+
+	tree_page = get_tree_page_by_index(map->forest, root_index, 1, page_index);
+	page = (struct block_map_page *) tree_page->page_buffer;
+	if (!page->header.initialized)
+		return VDO_ZERO_BLOCK;
+
+	mapping = vdo_unpack_block_map_entry(&page->entries[slot]);
+	if (!vdo_is_valid_location(&mapping) || vdo_is_state_compressed(mapping.state))
+		return VDO_ZERO_BLOCK;
+	return mapping.pbn;
+}
+
+/*
+ * Write a tree page or indicate that it has been re-dirtied if it is already being written. This
+ * method is used when correcting errors in the tree during read-only rebuild.
+ */
+void vdo_write_tree_page(struct tree_page *page, struct block_map_zone *zone)
+{
+	bool waiting = vdo_is_waiting(&page->waiter);
+
+	if (waiting && (zone->flusher == page))
+		return;
+
+	set_generation(zone, page, zone->generation);
+	if (waiting || page->writing)
+		return;
+
+	enqueue_page(page, zone);
+}
+
+static int make_segment(struct forest *old_forest,
+			block_count_t new_pages,
+			struct boundary *new_boundary,
+			struct forest *forest)
+{
+	size_t index = (old_forest == NULL) ? 0 : old_forest->segments;
+	struct tree_page *page_ptr;
+	page_count_t segment_sizes[VDO_BLOCK_MAP_TREE_HEIGHT];
+	height_t height;
+	root_count_t root;
+	int result;
+
+	forest->segments = index + 1;
+
+	result = UDS_ALLOCATE(forest->segments, struct boundary,
+			      "forest boundary array", &forest->boundaries);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	result = UDS_ALLOCATE(forest->segments,
+			      struct tree_page *,
+			      "forest page pointers",
+			      &forest->pages);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	result = UDS_ALLOCATE(new_pages,
+			      struct tree_page,
+			      "new forest pages",
+			      &forest->pages[index]);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	if (index > 0) {
+		memcpy(forest->boundaries,
+		       old_forest->boundaries,
+		       index * sizeof(struct boundary));
+		memcpy(forest->pages, old_forest->pages, index * sizeof(struct tree_page *));
+	}
+
+	memcpy(&(forest->boundaries[index]), new_boundary, sizeof(struct boundary));
+
+	for (height = 0; height < VDO_BLOCK_MAP_TREE_HEIGHT; height++) {
+		segment_sizes[height] = new_boundary->levels[height];
+		if (index > 0)
+			segment_sizes[height] -= old_forest->boundaries[index - 1].levels[height];
+	}
+
+	page_ptr = forest->pages[index];
+	for (root = 0; root < forest->map->root_count; root++) {
+		struct block_map_tree_segment *segment;
+		struct block_map_tree *tree = &(forest->trees[root]);
+		height_t height;
+
+		int result = UDS_ALLOCATE(forest->segments,
+					  struct block_map_tree_segment,
+					  "tree root segments",
+					  &tree->segments);
+		if (result != VDO_SUCCESS)
+			return result;
+
+		if (index > 0)
+			memcpy(tree->segments,
+			       old_forest->trees[root].segments,
+			       index * sizeof(struct block_map_tree_segment));
+
+		segment = &(tree->segments[index]);
+		for (height = 0; height < VDO_BLOCK_MAP_TREE_HEIGHT; height++) {
+			if (segment_sizes[height] == 0)
+				continue;
+
+			segment->levels[height] = page_ptr;
+			if (height == (VDO_BLOCK_MAP_TREE_HEIGHT - 1)) {
+				/* Record the root. */
+				struct block_map_page *page =
+					vdo_format_block_map_page(page_ptr->page_buffer,
+								  forest->map->nonce,
+								  VDO_INVALID_PBN,
+								  true);
+				page->entries[0] =
+					vdo_pack_block_map_entry(forest->map->root_origin + root,
+								 VDO_MAPPING_STATE_UNCOMPRESSED);
+			}
+			page_ptr += segment_sizes[height];
+		}
+	}
+
+	return VDO_SUCCESS;
+}
+
+static void deforest(struct forest *forest, size_t first_page_segment)
+{
+	root_count_t root;
+
+	if (forest->pages != NULL) {
+		size_t segment;
+
+		for (segment = first_page_segment; segment < forest->segments; segment++)
+			UDS_FREE(forest->pages[segment]);
+		UDS_FREE(forest->pages);
+	}
+
+	for (root = 0; root < forest->map->root_count; root++)
+		UDS_FREE(forest->trees[root].segments);
+
+	UDS_FREE(forest->boundaries);
+	UDS_FREE(forest);
+}
+
+/**
+ * make_forest() - Make a collection of trees for a block_map, expanding the existing forest if
+ *                 there is one.
+ * @entries: The number of entries the block map will hold.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+static int make_forest(struct block_map *map, block_count_t entries)
+{
+	struct forest *forest, *old_forest = map->forest;
+	struct boundary new_boundary, *old_boundary = NULL;
+	block_count_t new_pages;
+	int result;
+
+	if (old_forest != NULL)
+		old_boundary = &(old_forest->boundaries[old_forest->segments - 1]);
+
+	new_pages = vdo_compute_new_forest_pages(map->root_count, old_boundary,
+						 entries, &new_boundary);
+	if (new_pages == 0) {
+		map->next_entry_count = entries;
+		return VDO_SUCCESS;
+	}
+
+	result = UDS_ALLOCATE_EXTENDED(struct forest, map->root_count,
+				       struct block_map_tree, __func__,
+				       &forest);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	forest->map = map;
+	result = make_segment(old_forest, new_pages, &new_boundary, forest);
+	if (result != VDO_SUCCESS) {
+		deforest(forest, forest->segments - 1);
+		return result;
+	}
+
+	map->next_forest = forest;
+	map->next_entry_count = entries;
+	return VDO_SUCCESS;
+}
+
+/**
+ * replace_forest() - Replace a block_map's forest with the already-prepared larger forest.
+ */
+static void replace_forest(struct block_map *map)
+{
+	if (map->next_forest != NULL) {
+		if (map->forest != NULL)
+			deforest(map->forest, map->forest->segments);
+		map->forest = UDS_FORGET(map->next_forest);
+	}
+
+	map->entry_count = map->next_entry_count;
+	map->next_entry_count = 0;
+}
+
+/**
+ * finish_cursor() - Finish the traversal of a single tree. If it was the last cursor, finish the
+ *                   traversal.
+ */
+static void finish_cursor(struct cursor *cursor)
+{
+	struct cursors *cursors = cursor->parent;
+	struct vdo_completion *parent = cursors->parent;
+
+	return_vio_to_pool(cursors->pool, UDS_FORGET(cursor->vio));
+	if (--cursors->active_roots > 0)
+		return;
+
+	UDS_FREE(cursors);
+
+	vdo_finish_completion(parent);
+}
+
+static void traverse(struct cursor *cursor);
+
+/**
+ * continue_traversal() - Continue traversing a block map tree.
+ * @completion: The VIO doing a read or write.
+ */
+static void continue_traversal(struct vdo_completion *completion)
+{
+	vio_record_metadata_io_error(as_vio(completion));
+	traverse(completion->parent);
+}
+
+/**
+ * finish_traversal_load() - Continue traversing a block map tree now that a page has been loaded.
+ * @completion: The VIO doing the read.
+ */
+static void finish_traversal_load(struct vdo_completion *completion)
+{
+	struct cursor *cursor = completion->parent;
+	height_t height = cursor->height;
+	struct cursor_level *level = &cursor->levels[height];
+	struct tree_page *tree_page =
+		&(cursor->tree->segments[0].levels[height][level->page_index]);
+	struct block_map_page *page = (struct block_map_page *) tree_page->page_buffer;
+
+	vdo_copy_valid_page(cursor->vio->vio.data,
+			    cursor->parent->zone->block_map->nonce,
+			    pbn_from_vio_bio(cursor->vio->vio.bio),
+			    page);
+	traverse(cursor);
+}
+
+static void traversal_endio(struct bio *bio)
+{
+	struct vio *vio = bio->bi_private;
+	struct cursor *cursor = vio->completion.parent;
+
+	continue_vio_after_io(vio, finish_traversal_load, cursor->parent->zone->thread_id);
+}
+
+/**
+ * traverse() - Traverse a single block map tree.
+ *
+ * This is the recursive heart of the traversal process.
+ */
+static void traverse(struct cursor *cursor)
+{
+	for (; cursor->height < VDO_BLOCK_MAP_TREE_HEIGHT; cursor->height++) {
+		height_t height = cursor->height;
+		struct cursor_level *level = &cursor->levels[height];
+		struct tree_page *tree_page =
+			&(cursor->tree->segments[0].levels[height][level->page_index]);
+		struct block_map_page *page = (struct block_map_page *) tree_page->page_buffer;
+
+		if (!page->header.initialized)
+			continue;
+
+		for (; level->slot < VDO_BLOCK_MAP_ENTRIES_PER_PAGE; level->slot++) {
+			struct cursor_level *next_level;
+			page_number_t entry_index =
+				(VDO_BLOCK_MAP_ENTRIES_PER_PAGE * level->page_index) + level->slot;
+			struct data_location location =
+				vdo_unpack_block_map_entry(&page->entries[level->slot]);
+
+			if (!vdo_is_valid_location(&location)) {
+				/* This entry is invalid, so remove it from the page. */
+				page->entries[level->slot] =
+					vdo_pack_block_map_entry(VDO_ZERO_BLOCK,
+								 VDO_MAPPING_STATE_UNMAPPED);
+				vdo_write_tree_page(tree_page, cursor->parent->zone);
+				continue;
+			}
+
+			if (!vdo_is_mapped_location(&location))
+				continue;
+
+			/* Erase mapped entries past the end of the logical space. */
+			if (entry_index >= cursor->boundary.levels[height]) {
+				page->entries[level->slot] =
+					vdo_pack_block_map_entry(VDO_ZERO_BLOCK,
+								 VDO_MAPPING_STATE_UNMAPPED);
+				vdo_write_tree_page(tree_page, cursor->parent->zone);
+				continue;
+			}
+
+			if (cursor->height < VDO_BLOCK_MAP_TREE_HEIGHT - 1) {
+				int result =
+					cursor->parent->entry_callback(location.pbn,
+								       cursor->parent->parent);
+
+				if (result != VDO_SUCCESS) {
+					page->entries[level->slot] =
+						vdo_pack_block_map_entry(VDO_ZERO_BLOCK,
+									 VDO_MAPPING_STATE_UNMAPPED);
+					vdo_write_tree_page(tree_page, cursor->parent->zone);
+					continue;
+				}
+			}
+
+			if (cursor->height == 0)
+				continue;
+
+			cursor->height--;
+			next_level = &cursor->levels[cursor->height];
+			next_level->page_index = entry_index;
+			next_level->slot = 0;
+			level->slot++;
+			submit_metadata_vio(&cursor->vio->vio,
+					    location.pbn,
+					    traversal_endio,
+					    continue_traversal,
+					    REQ_OP_READ | REQ_PRIO);
+			return;
+		}
+	}
+
+	finish_cursor(cursor);
+}
+
+/**
+ * launch_cursor() - Start traversing a single block map tree now that the cursor has a VIO with
+ *                   which to load pages.
+ * @context: The pooled_vio just acquired.
+ *
+ * Implements waiter_callback.
+ */
+static void launch_cursor(struct waiter *waiter, void *context)
+{
+	struct cursor *cursor = container_of(waiter, struct cursor, waiter);
+	struct pooled_vio *pooled = context;
+
+	cursor->vio = pooled;
+	pooled->vio.completion.parent = cursor;
+	pooled->vio.completion.callback_thread_id = cursor->parent->zone->thread_id;
+	traverse(cursor);
+}
+
+/**
+ * compute_boundary() - Compute the number of pages used at each level of the given root's tree.
+ *
+ * Return: The list of page counts as a boundary structure.
+ */
+static struct boundary compute_boundary(struct block_map *map, root_count_t root_index)
+{
+	struct boundary boundary;
+	height_t height;
+	page_count_t leaf_pages = vdo_compute_block_map_page_count(map->entry_count);
+	/*
+	 * Compute the leaf pages for this root. If the number of leaf pages does not distribute
+	 * evenly, we must determine if this root gets an extra page. Extra pages are assigned to
+	 * roots starting from tree 0.
+	 */
+	page_count_t last_tree_root = (leaf_pages - 1) % map->root_count;
+	page_count_t level_pages = leaf_pages / map->root_count;
+
+	if (root_index <= last_tree_root)
+		level_pages++;
+
+	for (height = 0; height < VDO_BLOCK_MAP_TREE_HEIGHT - 1; height++) {
+		boundary.levels[height] = level_pages;
+		level_pages = DIV_ROUND_UP(level_pages, VDO_BLOCK_MAP_ENTRIES_PER_PAGE);
+	}
+
+	/* The root node always exists, even if the root is otherwise unused. */
+	boundary.levels[VDO_BLOCK_MAP_TREE_HEIGHT - 1] = 1;
+
+	return boundary;
+}
+
+/**
+ * vdo_traverse_forest() - Walk the entire forest of a block map.
+ * @callback: A function to call with the pbn of each allocated node in the forest.
+ * @parent: The completion to notify on each traversed PBN, and when the traversal is complete.
+ */
+void vdo_traverse_forest(struct block_map *map,
+			 vdo_entry_callback *callback,
+			 struct vdo_completion *parent)
+{
+	root_count_t root;
+	struct cursors *cursors;
+	int result;
+
+	result = UDS_ALLOCATE_EXTENDED(struct cursors,
+				       map->root_count,
+				       struct cursor,
+				       __func__,
+				       &cursors);
+	if (result != VDO_SUCCESS) {
+		vdo_fail_completion(parent, result);
+		return;
+	}
+
+	cursors->zone = &map->zones[0];
+	cursors->pool = cursors->zone->vio_pool;
+	cursors->entry_callback = callback;
+	cursors->parent = parent;
+	cursors->active_roots = map->root_count;
+	for (root = 0; root < map->root_count; root++) {
+		struct cursor *cursor = &cursors->cursors[root];
+
+		*cursor = (struct cursor) {
+			.tree = &map->forest->trees[root],
+			.height = VDO_BLOCK_MAP_TREE_HEIGHT - 1,
+			.parent = cursors,
+			.boundary = compute_boundary(map, root),
+		};
+
+		cursor->waiter.callback = launch_cursor;
+		acquire_vio_from_pool(cursors->pool, &cursor->waiter);
+	};
+}
+
+/**
+ * initialize_block_map_zone() - Initialize the per-zone portions of the block map.
+ * @maximum_age: The number of journal blocks before a dirtied page is considered old and must be
+ *               written out.
+ */
+static int __must_check initialize_block_map_zone(struct block_map *map,
+						  zone_count_t zone_number,
+						  struct vdo *vdo,
+						  page_count_t cache_size,
+						  block_count_t maximum_age)
+{
+	int result;
+	block_count_t i;
+	struct block_map_zone *zone = &map->zones[zone_number];
+
+	STATIC_ASSERT_SIZEOF(struct page_descriptor, sizeof(u64));
+
+	zone->zone_number = zone_number;
+	zone->thread_id = vdo->thread_config.logical_threads[zone_number];
+	zone->block_map = map;
+
+	result = UDS_ALLOCATE_EXTENDED(struct dirty_lists,
+				       maximum_age,
+				       dirty_era_t,
+				       __func__,
+				       &zone->dirty_lists);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	zone->dirty_lists->maximum_age = maximum_age;
+	INIT_LIST_HEAD(&zone->dirty_lists->expired[VDO_TREE_PAGE]);
+	INIT_LIST_HEAD(&zone->dirty_lists->expired[VDO_CACHE_PAGE]);
+
+	for (i = 0; i < maximum_age; i++) {
+		INIT_LIST_HEAD(&zone->dirty_lists->eras[i][VDO_TREE_PAGE]);
+		INIT_LIST_HEAD(&zone->dirty_lists->eras[i][VDO_CACHE_PAGE]);
+	}
+
+	result = vdo_make_int_map(VDO_LOCK_MAP_CAPACITY, 0, &zone->loading_pages);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	result = make_vio_pool(vdo,
+			       BLOCK_MAP_VIO_POOL_SIZE,
+			       zone->thread_id,
+			       VIO_TYPE_BLOCK_MAP_INTERIOR,
+			       VIO_PRIORITY_METADATA,
+			       zone,
+			       &zone->vio_pool);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	vdo_set_admin_state_code(&zone->state, VDO_ADMIN_STATE_NORMAL_OPERATION);
+
+	zone->page_cache.zone = zone;
+	zone->page_cache.vdo = vdo;
+	zone->page_cache.page_count = cache_size / map->zone_count;
+	zone->page_cache.stats.free_pages = zone->page_cache.page_count;
+
+	result = allocate_cache_components(&zone->page_cache);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	/* initialize empty circular queues */
+	INIT_LIST_HEAD(&zone->page_cache.lru_list);
+	INIT_LIST_HEAD(&zone->page_cache.outgoing_list);
+
+	return VDO_SUCCESS;
+}
+
+/* Implements vdo_zone_thread_getter */
+static thread_id_t get_block_map_zone_thread_id(void *context, zone_count_t zone_number)
+{
+	struct block_map *map = context;
+
+	return map->zones[zone_number].thread_id;
+}
+
+/* Implements vdo_action_preamble */
+static void prepare_for_era_advance(void *context, struct vdo_completion *parent)
+{
+	struct block_map *map = context;
+
+	map->current_era_point = map->pending_era_point;
+	vdo_finish_completion(parent);
+}
+
+/* Implements vdo_zone_action */
+static void advance_block_map_zone_era(void *context,
+				       zone_count_t zone_number,
+				       struct vdo_completion *parent)
+{
+	struct block_map *map = context;
+	struct block_map_zone *zone = &map->zones[zone_number];
+
+	update_period(zone->dirty_lists, map->current_era_point);
+	write_expired_elements(zone);
+	vdo_finish_completion(parent);
+}
+
+/*
+ * Schedule an era advance if necessary. This method should not be called directly. Rather, call
+ * vdo_schedule_default_action() on the block map's action manager.
+ *
+ * Implements vdo_action_scheduler.
+ */
+static bool schedule_era_advance(void *context)
+{
+	struct block_map *map = context;
+
+	if (map->current_era_point == map->pending_era_point)
+		return false;
+
+	return vdo_schedule_action(map->action_manager,
+				   prepare_for_era_advance,
+				   advance_block_map_zone_era,
+				   NULL,
+				   NULL);
+}
+
+static void uninitialize_block_map_zone(struct block_map_zone *zone)
+{
+	struct vdo_page_cache *cache = &zone->page_cache;
+
+	UDS_FREE(UDS_FORGET(zone->dirty_lists));
+	free_vio_pool(UDS_FORGET(zone->vio_pool));
+	vdo_free_int_map(UDS_FORGET(zone->loading_pages));
+	if (cache->infos != NULL) {
+		struct page_info *info;
+
+		for (info = cache->infos; info < cache->infos + cache->page_count; ++info)
+			free_vio(UDS_FORGET(info->vio));
+	}
+
+	vdo_free_int_map(UDS_FORGET(cache->page_map));
+	UDS_FREE(UDS_FORGET(cache->infos));
+	UDS_FREE(UDS_FORGET(cache->pages));
+}
+
+void vdo_free_block_map(struct block_map *map)
+{
+	zone_count_t zone;
+
+	if (map == NULL)
+		return;
+
+	for (zone = 0; zone < map->zone_count; zone++)
+		uninitialize_block_map_zone(&map->zones[zone]);
+
+	vdo_abandon_block_map_growth(map);
+	if (map->forest != NULL)
+		deforest(UDS_FORGET(map->forest), 0);
+	UDS_FREE(UDS_FORGET(map->action_manager));
+	UDS_FREE(map);
+}
+
+/* @journal may be NULL. */
+int vdo_decode_block_map(struct block_map_state_2_0 state,
+			 block_count_t logical_blocks,
+			 struct vdo *vdo,
+			 struct recovery_journal *journal,
+			 nonce_t nonce,
+			 page_count_t cache_size,
+			 block_count_t maximum_age,
+			 struct block_map **map_ptr)
+{
+	struct block_map *map;
+	int result;
+	zone_count_t zone = 0;
+
+	STATIC_ASSERT(VDO_BLOCK_MAP_ENTRIES_PER_PAGE ==
+		      ((VDO_BLOCK_SIZE - sizeof(struct block_map_page)) /
+		       sizeof(struct block_map_entry)));
+	result = ASSERT(cache_size > 0, "block map cache size is specified");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = UDS_ALLOCATE_EXTENDED(struct block_map,
+				       vdo->thread_config.logical_zone_count,
+				       struct block_map_zone,
+				       __func__,
+				       &map);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	map->vdo = vdo;
+	map->root_origin = state.root_origin;
+	map->root_count = state.root_count;
+	map->entry_count = logical_blocks;
+	map->journal = journal;
+	map->nonce = nonce;
+
+	result = make_forest(map, map->entry_count);
+	if (result != VDO_SUCCESS) {
+		vdo_free_block_map(map);
+		return result;
+	}
+
+	replace_forest(map);
+
+	map->zone_count = vdo->thread_config.logical_zone_count;
+	for (zone = 0; zone < map->zone_count; zone++) {
+		result = initialize_block_map_zone(map, zone, vdo, cache_size, maximum_age);
+		if (result != VDO_SUCCESS) {
+			vdo_free_block_map(map);
+			return result;
+		}
+	}
+
+	result = vdo_make_action_manager(map->zone_count,
+					 get_block_map_zone_thread_id,
+					 vdo_get_recovery_journal_thread_id(journal),
+					 map,
+					 schedule_era_advance,
+					 vdo,
+					 &map->action_manager);
+	if (result != VDO_SUCCESS) {
+		vdo_free_block_map(map);
+		return result;
+	}
+
+	*map_ptr = map;
+	return VDO_SUCCESS;
+}
+
+struct block_map_state_2_0 vdo_record_block_map(const struct block_map *map)
+{
+	return (struct block_map_state_2_0) {
+		.flat_page_origin = VDO_BLOCK_MAP_FLAT_PAGE_ORIGIN,
+		/* This is the flat page count, which has turned out to always be 0. */
+		.flat_page_count = 0,
+		.root_origin = map->root_origin,
+		.root_count = map->root_count,
+	};
+}
+
+/* The block map needs to know the journals' sequence number to initialize the eras. */
+void vdo_initialize_block_map_from_journal(struct block_map *map, struct recovery_journal *journal)
+{
+	zone_count_t z = 0;
+
+	map->current_era_point = vdo_get_recovery_journal_current_sequence_number(journal);
+	map->pending_era_point = map->current_era_point;
+
+	for (z = 0; z < map->zone_count; z++) {
+		struct dirty_lists *dirty_lists = map->zones[z].dirty_lists;
+
+		ASSERT_LOG_ONLY(dirty_lists->next_period == 0, "current period not set");
+		dirty_lists->oldest_period = map->current_era_point;
+		dirty_lists->next_period = map->current_era_point + 1;
+		dirty_lists->offset = map->current_era_point % dirty_lists->maximum_age;
+	}
+}
+
+/* Compute the logical zone for the LBN of a data vio. */
+zone_count_t vdo_compute_logical_zone(struct data_vio *data_vio)
+{
+	struct block_map *map = vdo_from_data_vio(data_vio)->block_map;
+	struct tree_lock *tree_lock = &data_vio->tree_lock;
+	page_number_t page_number = data_vio->logical.lbn / VDO_BLOCK_MAP_ENTRIES_PER_PAGE;
+
+	tree_lock->tree_slots[0].page_index = page_number;
+	tree_lock->root_index = page_number % map->root_count;
+	return (tree_lock->root_index % map->zone_count);
+}
+
+void vdo_advance_block_map_era(struct block_map *map, sequence_number_t recovery_block_number)
+{
+	if (map == NULL)
+		return;
+
+	map->pending_era_point = recovery_block_number;
+	vdo_schedule_default_action(map->action_manager);
+}
+
+/* Implements vdo_admin_initiator */
+static void initiate_drain(struct admin_state *state)
+{
+	struct block_map_zone *zone = container_of(state, struct block_map_zone, state);
+
+	ASSERT_LOG_ONLY((zone->active_lookups == 0),
+			"%s() called with no active lookups",
+			__func__);
+
+	if (!vdo_is_state_suspending(state)) {
+		while (zone->dirty_lists->oldest_period < zone->dirty_lists->next_period)
+			expire_oldest_list(zone->dirty_lists);
+		write_expired_elements(zone);
+	}
+
+	check_for_drain_complete(zone);
+}
+
+/* Implements vdo_zone_action. */
+static void drain_zone(void *context, zone_count_t zone_number, struct vdo_completion *parent)
+{
+	struct block_map *map = context;
+	struct block_map_zone *zone = &map->zones[zone_number];
+
+	vdo_start_draining(&zone->state,
+			   vdo_get_current_manager_operation(map->action_manager),
+			   parent,
+			   initiate_drain);
+}
+
+void vdo_drain_block_map(struct block_map *map,
+			 const struct admin_state_code *operation,
+			 struct vdo_completion *parent)
+{
+	vdo_schedule_operation(map->action_manager, operation, NULL, drain_zone, NULL, parent);
+}
+
+/* Implements vdo_zone_action. */
+static void
+resume_block_map_zone(void *context, zone_count_t zone_number, struct vdo_completion *parent)
+{
+	struct block_map *map = context;
+	struct block_map_zone *zone = &map->zones[zone_number];
+
+	vdo_fail_completion(parent, vdo_resume_if_quiescent(&zone->state));
+}
+
+void vdo_resume_block_map(struct block_map *map, struct vdo_completion *parent)
+{
+	vdo_schedule_operation(map->action_manager,
+			       VDO_ADMIN_STATE_RESUMING,
+			       NULL,
+			       resume_block_map_zone,
+			       NULL,
+			       parent);
+}
+
+/* Allocate an expanded collection of trees, for a future growth. */
+int vdo_prepare_to_grow_block_map(struct block_map *map, block_count_t new_logical_blocks)
+{
+	if (map->next_entry_count == new_logical_blocks)
+		return VDO_SUCCESS;
+
+	if (map->next_entry_count > 0)
+		vdo_abandon_block_map_growth(map);
+
+	if (new_logical_blocks < map->entry_count) {
+		map->next_entry_count = map->entry_count;
+		return VDO_SUCCESS;
+	}
+
+	return make_forest(map, new_logical_blocks);
+}
+
+/* Implements vdo_action_preamble */
+static void grow_forest(void *context, struct vdo_completion *completion)
+{
+	replace_forest(context);
+	vdo_finish_completion(completion);
+}
+
+/* Requires vdo_prepare_to_grow_block_map() to have been previously called. */
+void vdo_grow_block_map(struct block_map *map, struct vdo_completion *parent)
+{
+	vdo_schedule_operation(map->action_manager,
+			       VDO_ADMIN_STATE_SUSPENDED_OPERATION,
+			       grow_forest,
+			       NULL,
+			       NULL,
+			       parent);
+}
+
+void vdo_abandon_block_map_growth(struct block_map *map)
+{
+	struct forest *forest = UDS_FORGET(map->next_forest);
+
+	if (forest != NULL)
+		deforest(forest, forest->segments - 1);
+
+	map->next_entry_count = 0;
+}
+
+/* Release the page completion and then continue the requester. */
+static inline void finish_processing_page(struct vdo_completion *completion, int result)
+{
+	struct vdo_completion *parent = completion->parent;
+
+	vdo_release_page_completion(completion);
+	vdo_continue_completion(parent, result);
+}
+
+static void handle_page_error(struct vdo_completion *completion)
+{
+	finish_processing_page(completion, completion->result);
+}
+
+/* Fetch the mapping page for a block map update, and call the provided handler when fetched. */
+static void fetch_mapping_page(struct data_vio *data_vio, bool modifiable, vdo_action *action)
+{
+	struct block_map_zone *zone = data_vio->logical.zone->block_map_zone;
+
+	if (vdo_is_state_draining(&zone->state)) {
+		continue_data_vio_with_error(data_vio, VDO_SHUTTING_DOWN);
+		return;
+	}
+
+	vdo_get_page(&data_vio->page_completion,
+		     zone,
+		     data_vio->tree_lock.tree_slots[0].block_map_slot.pbn,
+		     modifiable,
+		     &data_vio->vio.completion,
+		     action,
+		     handle_page_error,
+		     false);
+}
+
+/**
+ * clear_mapped_location() - Clear a data_vio's mapped block location, setting it to be unmapped.
+ *
+ * This indicates the block map entry for the logical block is either unmapped or corrupted.
+ */
+static void clear_mapped_location(struct data_vio *data_vio)
+{
+	data_vio->mapped = (struct zoned_pbn) {
+		.state = VDO_MAPPING_STATE_UNMAPPED,
+	};
+}
+
+/**
+ * set_mapped_location() - Decode and validate a block map entry, and set the mapped location of a
+ *                         data_vio.
+ *
+ * Return: VDO_SUCCESS or VDO_BAD_MAPPING if the map entry is invalid or an error code for any
+ *         other failure
+ */
+static int __must_check
+set_mapped_location(struct data_vio *data_vio, const struct block_map_entry *entry)
+{
+	/* Unpack the PBN for logging purposes even if the entry is invalid. */
+	struct data_location mapped = vdo_unpack_block_map_entry(entry);
+
+	if (vdo_is_valid_location(&mapped)) {
+		int result;
+
+		result = vdo_get_physical_zone(vdo_from_data_vio(data_vio),
+					       mapped.pbn,
+					       &data_vio->mapped.zone);
+		if (result == VDO_SUCCESS) {
+			data_vio->mapped.pbn = mapped.pbn;
+			data_vio->mapped.state = mapped.state;
+			return VDO_SUCCESS;
+		}
+
+		/*
+		 * Return all errors not specifically known to be errors from validating the
+		 * location.
+		 */
+		if ((result != VDO_OUT_OF_RANGE) && (result != VDO_BAD_MAPPING))
+			return result;
+	}
+
+	/*
+	 * Log the corruption even if we wind up ignoring it for write VIOs, converting all cases
+	 * to VDO_BAD_MAPPING.
+	 */
+	uds_log_error_strerror(VDO_BAD_MAPPING,
+			       "PBN %llu with state %u read from the block map was invalid",
+			       (unsigned long long) mapped.pbn,
+			       mapped.state);
+
+	/*
+	 * A read VIO has no option but to report the bad mapping--reading zeros would be hiding
+	 * known data loss.
+	 */
+	if (!data_vio->write)
+		return VDO_BAD_MAPPING;
+
+	/*
+	 * A write VIO only reads this mapping to decref the old block. Treat this as an unmapped
+	 * entry rather than fail the write.
+	 */
+	clear_mapped_location(data_vio);
+	return VDO_SUCCESS;
+}
+
+/* This callback is registered in vdo_get_mapped_block(). */
+static void get_mapping_from_fetched_page(struct vdo_completion *completion)
+{
+	int result;
+	struct vdo_page_completion *vpc = as_vdo_page_completion(completion);
+	const struct block_map_page *page;
+	const struct block_map_entry *entry;
+	struct data_vio *data_vio = as_data_vio(completion->parent);
+	struct block_map_tree_slot *tree_slot;
+
+	if (completion->result != VDO_SUCCESS) {
+		finish_processing_page(completion, completion->result);
+		return;
+	}
+
+	result = validate_completed_page(vpc, false);
+	if (result != VDO_SUCCESS) {
+		finish_processing_page(completion, result);
+		return;
+	}
+
+	page = (const struct block_map_page *) get_page_buffer(vpc->info);
+	tree_slot = &data_vio->tree_lock.tree_slots[0];
+	entry = &page->entries[tree_slot->block_map_slot.slot];
+
+	result = set_mapped_location(data_vio, entry);
+	finish_processing_page(completion, result);
+}
+
+void vdo_update_block_map_page(struct block_map_page *page,
+			       struct data_vio *data_vio,
+			       physical_block_number_t pbn,
+			       enum block_mapping_state mapping_state,
+			       sequence_number_t *recovery_lock)
+{
+	struct block_map_zone *zone = data_vio->logical.zone->block_map_zone;
+	struct block_map *block_map = zone->block_map;
+	struct recovery_journal *journal = block_map->journal;
+	sequence_number_t old_locked, new_locked;
+	struct tree_lock *tree_lock = &data_vio->tree_lock;
+
+	/* Encode the new mapping. */
+	page->entries[tree_lock->tree_slots[tree_lock->height].block_map_slot.slot] =
+		vdo_pack_block_map_entry(pbn, mapping_state);
+
+	/* Adjust references on the recovery journal blocks. */
+	old_locked = *recovery_lock;
+	new_locked = data_vio->recovery_sequence_number;
+
+	if ((old_locked == 0) || (old_locked > new_locked)) {
+		vdo_acquire_recovery_journal_block_reference(journal,
+							     new_locked,
+							     VDO_ZONE_TYPE_LOGICAL,
+							     zone->zone_number);
+
+		if (old_locked > 0)
+			vdo_release_recovery_journal_block_reference(journal,
+								     old_locked,
+								     VDO_ZONE_TYPE_LOGICAL,
+								     zone->zone_number);
+
+		*recovery_lock = new_locked;
+	}
+
+	/*
+	 * FIXME: explain this more
+	 * Release the transferred lock from the data_vio.
+	 */
+	vdo_release_journal_entry_lock(journal, new_locked);
+	data_vio->recovery_sequence_number = 0;
+}
+
+static void put_mapping_in_fetched_page(struct vdo_completion *completion)
+{
+	struct data_vio *data_vio = as_data_vio(completion->parent);
+	sequence_number_t old_lock;
+	struct vdo_page_completion *vpc;
+	struct page_info *info;
+	int result;
+
+	if (completion->result != VDO_SUCCESS) {
+		finish_processing_page(completion, completion->result);
+		return;
+	}
+
+	vpc = as_vdo_page_completion(completion);
+	result = validate_completed_page(vpc, true);
+	if (result != VDO_SUCCESS) {
+		finish_processing_page(completion, result);
+		return;
+	}
+
+	info = vpc->info;
+	old_lock = info->recovery_lock;
+	vdo_update_block_map_page((struct block_map_page *) get_page_buffer(info),
+				  data_vio,
+				  data_vio->new_mapped.pbn,
+				  data_vio->new_mapped.state,
+				  &info->recovery_lock);
+	set_info_state(info, PS_DIRTY);
+	add_to_dirty_lists(info->cache->zone,
+			   &info->state_entry,
+			   VDO_CACHE_PAGE,
+			   old_lock,
+			   info->recovery_lock);
+	finish_processing_page(completion, VDO_SUCCESS);
+}
+
+/* Read a stored block mapping into a data_vio. */
+void vdo_get_mapped_block(struct data_vio *data_vio)
+{
+	if (data_vio->tree_lock.tree_slots[0].block_map_slot.pbn == VDO_ZERO_BLOCK) {
+		/*
+		 * We know that the block map page for this LBN has not been allocated, so the
+		 * block must be unmapped.
+		 */
+		clear_mapped_location(data_vio);
+		continue_data_vio(data_vio);
+		return;
+	}
+
+	fetch_mapping_page(data_vio, false, get_mapping_from_fetched_page);
+}
+
+/* Update a stored block mapping to reflect a data_vio's new mapping. */
+void vdo_put_mapped_block(struct data_vio *data_vio)
+{
+	fetch_mapping_page(data_vio, true, put_mapping_in_fetched_page);
+}
+
+struct block_map_statistics vdo_get_block_map_statistics(struct block_map *map)
+{
+	zone_count_t zone = 0;
+	struct block_map_statistics totals;
+
+	memset(&totals, 0, sizeof(struct block_map_statistics));
+	for (zone = 0; zone < map->zone_count; zone++) {
+		const struct block_map_statistics *stats = &(map->zones[zone].page_cache.stats);
+
+		totals.dirty_pages += READ_ONCE(stats->dirty_pages);
+		totals.clean_pages += READ_ONCE(stats->clean_pages);
+		totals.free_pages += READ_ONCE(stats->free_pages);
+		totals.failed_pages += READ_ONCE(stats->failed_pages);
+		totals.incoming_pages += READ_ONCE(stats->incoming_pages);
+		totals.outgoing_pages += READ_ONCE(stats->outgoing_pages);
+		totals.cache_pressure += READ_ONCE(stats->cache_pressure);
+		totals.read_count += READ_ONCE(stats->read_count);
+		totals.write_count += READ_ONCE(stats->write_count);
+		totals.failed_reads += READ_ONCE(stats->failed_reads);
+		totals.failed_writes += READ_ONCE(stats->failed_writes);
+		totals.reclaimed += READ_ONCE(stats->reclaimed);
+		totals.read_outgoing += READ_ONCE(stats->read_outgoing);
+		totals.found_in_cache += READ_ONCE(stats->found_in_cache);
+		totals.discard_required += READ_ONCE(stats->discard_required);
+		totals.wait_for_page += READ_ONCE(stats->wait_for_page);
+		totals.fetch_required += READ_ONCE(stats->fetch_required);
+		totals.pages_loaded += READ_ONCE(stats->pages_loaded);
+		totals.pages_saved += READ_ONCE(stats->pages_saved);
+		totals.flush_count += READ_ONCE(stats->flush_count);
+	}
+
+	return totals;
+}
diff --git a/drivers/md/dm-vdo/block-map.h b/drivers/md/dm-vdo/block-map.h
new file mode 100644
index 00000000000..347e7ceac1f
--- /dev/null
+++ b/drivers/md/dm-vdo/block-map.h
@@ -0,0 +1,232 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Red Hat
+ */
+
+#ifndef VDO_BLOCK_MAP_H
+#define VDO_BLOCK_MAP_H
+
+#include <linux/list.h>
+
+#include "numeric.h"
+
+#include "admin-state.h"
+#include "completion.h"
+#include "encodings.h"
+#include "int-map.h"
+#include "statistics.h"
+#include "types.h"
+#include "vio.h"
+#include "wait-queue.h"
+
+enum {
+	BLOCK_MAP_VIO_POOL_SIZE = 64,
+};
+
+/* Used to indicate that the page holding the location of a tree root has been "loaded". */
+extern const physical_block_number_t VDO_INVALID_PBN;
+
+/*
+ * Generation counter for page references.
+ */
+typedef u32 vdo_page_generation;
+
+struct forest;
+
+struct tree_page {
+	struct waiter waiter;
+
+	/* Dirty list entry */
+	struct list_head entry;
+
+	/* If dirty, the tree zone flush generation in which it was last dirtied. */
+	u8 generation;
+
+	/* Whether this page is an interior tree page being written out. */
+	bool writing;
+
+	/* If writing, the tree zone flush generation of the copy being written. */
+	u8 writing_generation;
+
+	/*
+	 * Sequence number of the earliest recovery journal block containing uncommitted updates to
+	 * this page
+	 */
+	sequence_number_t recovery_lock;
+
+	/* The value of recovery_lock when the this page last started writing */
+	sequence_number_t writing_recovery_lock;
+
+	char page_buffer[VDO_BLOCK_SIZE];
+};
+
+enum block_map_page_type {
+	VDO_TREE_PAGE,
+	VDO_CACHE_PAGE,
+};
+
+typedef struct list_head dirty_era_t[2];
+
+struct dirty_lists {
+	/** The number of periods after which an element will be expired */
+	block_count_t maximum_age;
+	/** The oldest period which has unexpired elements */
+	sequence_number_t oldest_period;
+	/** One more than the current period */
+	sequence_number_t next_period;
+	/** The offset in the array of lists of the oldest period */
+	block_count_t offset;
+	/** Expired pages */
+	dirty_era_t expired;
+	/** The lists of dirty pages */
+	dirty_era_t eras[];
+};
+
+struct block_map_zone {
+	zone_count_t zone_number;
+	thread_id_t thread_id;
+	struct admin_state state;
+	struct block_map *block_map;
+	/* Dirty pages, by era*/
+	struct dirty_lists *dirty_lists;
+	struct vdo_page_cache page_cache;
+	data_vio_count_t active_lookups;
+	struct int_map *loading_pages;
+	struct vio_pool *vio_pool;
+	/* The tree page which has issued or will be issuing a flush */
+	struct tree_page *flusher;
+	struct wait_queue flush_waiters;
+	/* The generation after the most recent flush */
+	u8 generation;
+	u8 oldest_generation;
+	/* The counts of dirty pages in each generation */
+	u32 dirty_page_counts[256];
+};
+
+struct block_map {
+	struct vdo *vdo;
+	struct action_manager *action_manager;
+	/* The absolute PBN of the first root of the tree part of the block map */
+	physical_block_number_t root_origin;
+	block_count_t root_count;
+
+	/* The era point we are currently distributing to the zones */
+	sequence_number_t current_era_point;
+	/* The next era point */
+	sequence_number_t pending_era_point;
+
+	/* The number of entries in block map */
+	block_count_t entry_count;
+	nonce_t nonce;
+	struct recovery_journal *journal;
+
+	/* The trees for finding block map pages */
+	struct forest *forest;
+	/* The expanded trees awaiting growth */
+	struct forest *next_forest;
+	/* The number of entries after growth */
+	block_count_t next_entry_count;
+
+	zone_count_t zone_count;
+	struct block_map_zone zones[];
+};
+
+/**
+ * typedef vdo_entry_callback - A function to be called for each allocated PBN when traversing the
+ *                              forest.
+ * @pbn: A PBN of a tree node.
+ * @completion: The parent completion of the traversal.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+typedef int vdo_entry_callback(physical_block_number_t pbn, struct vdo_completion *completion);
+
+static inline struct block_map_page * __must_check
+vdo_as_block_map_page(struct tree_page *tree_page)
+{
+	return (struct block_map_page *) tree_page->page_buffer;
+}
+
+bool vdo_copy_valid_page(char *buffer,
+			 nonce_t nonce,
+			 physical_block_number_t pbn,
+			 struct block_map_page *page);
+
+void vdo_find_block_map_slot(struct data_vio *data_vio);
+
+physical_block_number_t
+vdo_find_block_map_page_pbn(struct block_map *map, page_number_t page_number);
+
+void vdo_write_tree_page(struct tree_page *page, struct block_map_zone *zone);
+
+void vdo_traverse_forest(struct block_map *map,
+			 vdo_entry_callback *callback,
+			 struct vdo_completion *parent);
+
+int __must_check vdo_decode_block_map(struct block_map_state_2_0 state,
+				      block_count_t logical_blocks,
+				      struct vdo *vdo,
+				      struct recovery_journal *journal,
+				      nonce_t nonce,
+				      page_count_t cache_size,
+				      block_count_t maximum_age,
+				      struct block_map **map_ptr);
+
+void vdo_drain_block_map(struct block_map *map,
+			 const struct admin_state_code *operation,
+			 struct vdo_completion *parent);
+
+void vdo_resume_block_map(struct block_map *map, struct vdo_completion *parent);
+
+int __must_check
+vdo_prepare_to_grow_block_map(struct block_map *map, block_count_t new_logical_blocks);
+
+void vdo_grow_block_map(struct block_map *map, struct vdo_completion *parent);
+
+void vdo_abandon_block_map_growth(struct block_map *map);
+
+void vdo_free_block_map(struct block_map *map);
+
+struct block_map_state_2_0 __must_check
+vdo_record_block_map(const struct block_map *map);
+
+void vdo_initialize_block_map_from_journal(struct block_map *map,
+					   struct recovery_journal *journal);
+
+zone_count_t vdo_compute_logical_zone(struct data_vio *data_vio);
+
+void vdo_advance_block_map_era(struct block_map *map, sequence_number_t recovery_block_number);
+
+void vdo_update_block_map_page(struct block_map_page *page,
+			       struct data_vio *data_vio,
+			       physical_block_number_t pbn,
+			       enum block_mapping_state mapping_state,
+			       sequence_number_t *recovery_lock);
+
+void vdo_get_mapped_block(struct data_vio *data_vio);
+
+void vdo_put_mapped_block(struct data_vio *data_vio);
+
+struct block_map_statistics __must_check vdo_get_block_map_statistics(struct block_map *map);
+
+/**
+ * vdo_convert_maximum_age() - Convert the maximum age to reflect the new recovery journal format
+ * @age: The configured maximum age
+ *
+ * Return: The converted age
+ *
+ * In the old recovery journal format, each journal block held 311 entries, and every write bio
+ * made two entries. The old maximum age was half the usable journal length. In the new format,
+ * each block holds only 217 entries, but each bio only makes one entry. We convert the configured
+ * age so that the number of writes in a block map era is the same in the old and new formats. This
+ * keeps the bound on the amount of work required to recover the block map from the recovery
+ * journal the same across the format change. It also keeps the amortization of block map page
+ * writes to write bios the same.
+ */
+static inline block_count_t vdo_convert_maximum_age(block_count_t age)
+{
+	return DIV_ROUND_UP(age * RECOVERY_JOURNAL_1_ENTRIES_PER_BLOCK,
+			    2 * RECOVERY_JOURNAL_ENTRIES_PER_BLOCK);
+}
+
+#endif /* VDO_BLOCK_MAP_H */
-- 
2.40.1

