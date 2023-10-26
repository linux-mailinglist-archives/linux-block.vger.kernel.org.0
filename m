Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C67F7D8AB3
	for <lists+linux-block@lfdr.de>; Thu, 26 Oct 2023 23:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344764AbjJZVnQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Oct 2023 17:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjJZVnP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Oct 2023 17:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD4D1AD
        for <linux-block@vger.kernel.org>; Thu, 26 Oct 2023 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698356501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HBaEgq/LYZ4zTrjjb/aTnzfT2sK+0iLUYph+Q6Fry+0=;
        b=e3mpgIYvTAMhq8bMbhr4nrri79H4K/ZDfLyFxGVOUoXuPm6r7p72A4+zjk+iEgSg01JmK+
        gh8xTxd0KSm7lTpGIGb3LgjhAMOam/WQKV+JKNJtqL8yLBHZZuXkYWoibx+2QuocIqcsUp
        8d64ZUxITWrNIxUJaUc+KaTGpYHAqj0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-6F94N9rgNOCnKF2uOkwWxQ-1; Thu, 26 Oct 2023 17:41:39 -0400
X-MC-Unique: 6F94N9rgNOCnKF2uOkwWxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F54D185A784;
        Thu, 26 Oct 2023 21:41:39 +0000 (UTC)
Received: from pbitcolo-build-10.permabit.com (pbitcolo-build-10.permabit.lab.eng.bos.redhat.com [10.19.117.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BE1E10751;
        Thu, 26 Oct 2023 21:41:39 +0000 (UTC)
Received: by pbitcolo-build-10.permabit.com (Postfix, from userid 1138)
        id D09FC3003C; Thu, 26 Oct 2023 17:41:38 -0400 (EDT)
From:   Matthew Sakai <msakai@redhat.com>
To:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Cc:     Matthew Sakai <msakai@redhat.com>
Subject: [PATCH v4 12/39] dm vdo: implement the volume index
Date:   Thu, 26 Oct 2023 17:41:09 -0400
Message-Id: <20231026214136.1067410-13-msakai@redhat.com>
In-Reply-To: <20231026214136.1067410-1-msakai@redhat.com>
References: <20231026214136.1067410-1-msakai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The volume index is a large delta index that maps each record name to the
chapter which contains the newest record for that name. The volume index
can contain several million records and is stored entirely in memory while
the index is operating, accounting for the majority of the deduplication
index's memory budget.

The volume index is composed of two subindexes in order to handle sparse
hook names separately from regular names. If sparse indexing is not
enabled, the sparse hook portion of the volume index is not used or
instantiated.

Co-developed-by: J. corwin Coburn <corwin@hurlbutnet.net>
Signed-off-by: J. corwin Coburn <corwin@hurlbutnet.net>
Co-developed-by: Michael Sclafani <vdo-devel@redhat.com>
Signed-off-by: Michael Sclafani <vdo-devel@redhat.com>
Co-developed-by: Thomas Jaskiewicz <tom@jaskiewicz.us>
Signed-off-by: Thomas Jaskiewicz <tom@jaskiewicz.us>
Signed-off-by: Matthew Sakai <msakai@redhat.com>
---
 drivers/md/dm-vdo/volume-index.c | 1277 ++++++++++++++++++++++++++++++
 drivers/md/dm-vdo/volume-index.h |  192 +++++
 2 files changed, 1469 insertions(+)
 create mode 100644 drivers/md/dm-vdo/volume-index.c
 create mode 100644 drivers/md/dm-vdo/volume-index.h

diff --git a/drivers/md/dm-vdo/volume-index.c b/drivers/md/dm-vdo/volume-index.c
new file mode 100644
index 000000000000..0c91a2765449
--- /dev/null
+++ b/drivers/md/dm-vdo/volume-index.c
@@ -0,0 +1,1277 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023 Red Hat
+ */
+#include "volume-index.h"
+
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/cache.h>
+#include <linux/compiler.h>
+#include <linux/log2.h>
+
+#include "config.h"
+#include "errors.h"
+#include "geometry.h"
+#include "hash-utils.h"
+#include "logger.h"
+#include "memory-alloc.h"
+#include "numeric.h"
+#include "permassert.h"
+#include "uds.h"
+#include "uds-threads.h"
+
+/*
+ * The volume index is a combination of two separate subindexes, one containing sparse hook entries
+ * (retained for all chapters), and one containing the remaining entries (retained only for the
+ * dense chapters). If there are no sparse chapters, only the non-hook sub index is used, and it
+ * will contain all records for all chapters.
+ *
+ * The volume index is also divided into zones, with one thread operating on each zone. Each
+ * incoming request is dispatched to the appropriate thread, and then to the appropriate subindex.
+ * Each delta list is handled by a single zone. To ensure that the distribution of delta lists to
+ * zones doesn't underflow (leaving some zone with no delta lists), the minimum number of delta
+ * lists must be the square of the maximum zone count for both subindexes.
+ *
+ * Each subindex zone is a delta index where the payload is a chapter number. The volume index can
+ * compute the delta list number, address, and zone number from the record name in order to
+ * dispatch record handling to the correct structures.
+ *
+ * Most operations that use all the zones take place either before request processing is allowed,
+ * or after all requests have been flushed in order to shut down. The only multi-threaded operation
+ * supported during normal operation is the uds_lookup_volume_index_name() method, used to determine
+ * whether a new chapter should be loaded into the sparse index cache. This operation only uses the
+ * sparse hook subindex, and the zone mutexes are used to make this operation safe.
+ *
+ * There are three ways of expressing chapter numbers in the volume index: virtual, index, and
+ * rolling. The interface to the volume index uses virtual chapter numbers, which are 64 bits long.
+ * Internally the subindex stores only the minimal number of bits necessary by masking away the
+ * high-order bits. When the index needs to deal with ordering of index chapter numbers, as when
+ * flushing entries from older chapters, it rolls the index chapter number around so that the
+ * smallest one in use is mapped to 0. See convert_index_to_virtual() or flush_invalid_entries()
+ * for an example of this technique.
+ *
+ * For efficiency, when older chapter numbers become invalid, the index does not immediately remove
+ * the invalidated entries. Instead it lazily removes them from a given delta list the next time it
+ * walks that list during normal operation. Because of this, the index size must be increased
+ * somewhat to accommodate all the invalid entries that have not yet been removed. For the standard
+ * index sizes, this requires about 4 chapters of old entries per 1024 chapters of valid entries in
+ * the index.
+ */
+
+struct sub_index_parameters {
+	/* The number of bits in address mask */
+	u8 address_bits;
+	/* The number of bits in chapter number */
+	u8 chapter_bits;
+	/* The mean delta */
+	u32 mean_delta;
+	/* The number of delta lists */
+	u64 list_count;
+	/* The number of chapters used */
+	u32 chapter_count;
+	/* The number of bits per chapter */
+	size_t chapter_size_in_bits;
+	/* The number of bytes of delta list memory */
+	size_t memory_size;
+	/* The number of bytes the index should keep free at all times */
+	size_t target_free_bytes;
+};
+
+struct split_config {
+	/* The hook subindex configuration */
+	struct configuration hook_config;
+	struct geometry hook_geometry;
+
+	/* The non-hook subindex configuration */
+	struct configuration non_hook_config;
+	struct geometry non_hook_geometry;
+};
+
+struct chapter_range {
+	u32 chapter_start;
+	u32 chapter_count;
+};
+
+enum { MAGIC_SIZE = 8 };
+static const char MAGIC_START_5[] = "MI5-0005";
+
+struct sub_index_data {
+	char magic[MAGIC_SIZE]; /* MAGIC_START_5 */
+	u64 volume_nonce;
+	u64 virtual_chapter_low;
+	u64 virtual_chapter_high;
+	u32 first_list;
+	u32 list_count;
+};
+
+static const char MAGIC_START_6[] = "MI6-0001";
+
+struct volume_index_data {
+	char magic[MAGIC_SIZE]; /* MAGIC_START_6 */
+	u32 sparse_sample_rate;
+};
+
+static inline u32
+extract_address(const struct volume_sub_index *sub_index, const struct uds_record_name *name)
+{
+	return uds_extract_volume_index_bytes(name) & sub_index->address_mask;
+}
+
+static inline u32
+extract_dlist_num(const struct volume_sub_index *sub_index, const struct uds_record_name *name)
+{
+	u64 bits = uds_extract_volume_index_bytes(name);
+
+	return (bits >> sub_index->address_bits) % sub_index->list_count;
+}
+
+static inline const struct volume_sub_index_zone *
+get_zone_for_record(const struct volume_index_record *record)
+{
+	return &record->sub_index->zones[record->zone_number];
+}
+
+static inline u64
+convert_index_to_virtual(const struct volume_index_record *record, u32 index_chapter)
+{
+	const struct volume_sub_index_zone *volume_index_zone = get_zone_for_record(record);
+	u32 rolling_chapter = ((index_chapter - volume_index_zone->virtual_chapter_low) &
+			       record->sub_index->chapter_mask);
+
+	return volume_index_zone->virtual_chapter_low + rolling_chapter;
+}
+
+static inline u32
+convert_virtual_to_index(const struct volume_sub_index *sub_index, u64 virtual_chapter)
+{
+	return virtual_chapter & sub_index->chapter_mask;
+}
+
+static inline bool
+is_virtual_chapter_indexed(const struct volume_index_record *record, u64 virtual_chapter)
+{
+	const struct volume_sub_index_zone *volume_index_zone = get_zone_for_record(record);
+
+	return ((virtual_chapter >= volume_index_zone->virtual_chapter_low) &&
+		(virtual_chapter <= volume_index_zone->virtual_chapter_high));
+}
+
+static inline bool has_sparse(const struct volume_index *volume_index)
+{
+	return volume_index->sparse_sample_rate > 0;
+}
+
+bool uds_is_volume_index_sample(const struct volume_index *volume_index,
+				const struct uds_record_name *name)
+{
+	if (!has_sparse(volume_index))
+		return false;
+
+	return (uds_extract_sampling_bytes(name) % volume_index->sparse_sample_rate) == 0;
+}
+
+static inline const struct volume_sub_index *
+get_volume_sub_index(const struct volume_index *volume_index, const struct uds_record_name *name)
+{
+	return (uds_is_volume_index_sample(volume_index, name) ?
+		&volume_index->vi_hook :
+		&volume_index->vi_non_hook);
+}
+
+static unsigned int get_volume_sub_index_zone(const struct volume_sub_index *sub_index,
+					      const struct uds_record_name *name)
+{
+	return extract_dlist_num(sub_index, name) / sub_index->delta_index.lists_per_zone;
+}
+
+unsigned int uds_get_volume_index_zone(const struct volume_index *volume_index,
+				       const struct uds_record_name *name)
+{
+	return get_volume_sub_index_zone(get_volume_sub_index(volume_index, name), name);
+}
+
+static int compute_volume_sub_index_parameters(const struct configuration *config,
+					       struct sub_index_parameters *params)
+{
+	enum { DELTA_LIST_SIZE = 256 };
+	u64 entries_in_volume_index, address_span;
+	u32 chapters_in_volume_index, invalid_chapters;
+	u32 rounded_chapters;
+	u64 delta_list_records;
+	u32 address_count;
+	u64 index_size_in_bits;
+	size_t expected_index_size;
+	u64 min_delta_lists = MAX_ZONES * MAX_ZONES;
+	struct geometry *geometry = config->geometry;
+	u64 records_per_chapter = geometry->records_per_chapter;
+
+	params->chapter_count = geometry->chapters_per_volume;
+	/*
+	 * Make sure that the number of delta list records in the volume index does not change when
+	 * the volume is reduced by one chapter. This preserves the mapping from name to volume
+	 * index delta list.
+	 */
+	rounded_chapters = params->chapter_count;
+	if (uds_is_reduced_geometry(geometry))
+		rounded_chapters += 1;
+	delta_list_records = records_per_chapter * rounded_chapters;
+	address_count = config->volume_index_mean_delta * DELTA_LIST_SIZE;
+	params->list_count = max(delta_list_records / DELTA_LIST_SIZE, min_delta_lists);
+	params->address_bits = bits_per(address_count - 1);
+	params->chapter_bits = bits_per(rounded_chapters - 1);
+	if ((u32) params->list_count != params->list_count)
+		return uds_log_warning_strerror(UDS_INVALID_ARGUMENT,
+						"cannot initialize volume index with %llu delta lists",
+						(unsigned long long) params->list_count);
+	if (params->address_bits > 31)
+		return uds_log_warning_strerror(UDS_INVALID_ARGUMENT,
+						"cannot initialize volume index with %u address bits",
+						params->address_bits);
+
+	/*
+	 * The probability that a given delta list is not touched during the writing of an entire
+	 * chapter is:
+	 *
+	 * double p_not_touched = pow((double) (params->list_count - 1) / params->list_count,
+	 *                            records_per_chapter);
+	 *
+	 * For the standard index sizes, about 78% of the delta lists are not touched, and
+	 * therefore contain old index entries that have not been eliminated by the lazy LRU
+	 * processing. Then the number of old index entries that accumulate over the entire index,
+	 * in terms of full chapters worth of entries, is:
+	 *
+	 * double invalid_chapters = p_not_touched / (1.0 - p_not_touched);
+	 *
+	 * For the standard index sizes, the index needs about 3.5 chapters of space for the old
+	 * entries in a 1024 chapter index, so round this up to use 4 chapters per 1024 chapters in
+	 * the index.
+	 */
+	invalid_chapters = max(rounded_chapters / 256, 2U);
+	chapters_in_volume_index = rounded_chapters + invalid_chapters;
+	entries_in_volume_index = records_per_chapter * chapters_in_volume_index;
+
+	address_span = params->list_count << params->address_bits;
+	params->mean_delta = address_span / entries_in_volume_index;
+
+	/*
+	 * Compute the expected size of a full index, then set the total memory to be 6% larger
+	 * than that expected size. This number should be large enough that there are not many
+	 * rebalances when the index is full.
+	 */
+	params->chapter_size_in_bits = uds_compute_delta_index_size(records_per_chapter,
+								    params->mean_delta,
+								    params->chapter_bits);
+	index_size_in_bits = params->chapter_size_in_bits * chapters_in_volume_index;
+	expected_index_size = index_size_in_bits / BITS_PER_BYTE;
+	params->memory_size = expected_index_size * 106 / 100;
+
+	params->target_free_bytes = expected_index_size / 20;
+	return UDS_SUCCESS;
+}
+
+static void uninitialize_volume_sub_index(struct volume_sub_index *sub_index)
+{
+	UDS_FREE(UDS_FORGET(sub_index->flush_chapters));
+	UDS_FREE(UDS_FORGET(sub_index->zones));
+	uds_uninitialize_delta_index(&sub_index->delta_index);
+}
+
+void uds_free_volume_index(struct volume_index *volume_index)
+{
+	if (volume_index == NULL)
+		return;
+
+	if (volume_index->zones != NULL) {
+		unsigned int zone;
+
+		for (zone = 0; zone < volume_index->zone_count; zone++)
+			uds_destroy_mutex(&volume_index->zones[zone].hook_mutex);
+		UDS_FREE(UDS_FORGET(volume_index->zones));
+	}
+
+	uninitialize_volume_sub_index(&volume_index->vi_non_hook);
+	uninitialize_volume_sub_index(&volume_index->vi_hook);
+	UDS_FREE(volume_index);
+}
+
+
+static int
+compute_volume_sub_index_save_bytes(const struct configuration *config, size_t *bytes)
+{
+	struct sub_index_parameters params = { .address_bits = 0 };
+	int result;
+
+	result = compute_volume_sub_index_parameters(config, &params);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	*bytes = (sizeof(struct sub_index_data) + params.list_count * sizeof(u64) +
+		  uds_compute_delta_index_save_bytes(params.list_count, params.memory_size));
+	return UDS_SUCCESS;
+}
+
+/* This function is only useful if the configuration includes sparse chapters. */
+static void split_configuration(const struct configuration *config, struct split_config *split)
+{
+	u64 sample_rate, sample_records;
+	u64 dense_chapters, sparse_chapters;
+
+	/* Start with copies of the base configuration. */
+	split->hook_config = *config;
+	split->hook_geometry = *config->geometry;
+	split->hook_config.geometry = &split->hook_geometry;
+	split->non_hook_config = *config;
+	split->non_hook_geometry = *config->geometry;
+	split->non_hook_config.geometry = &split->non_hook_geometry;
+
+	sample_rate = config->sparse_sample_rate;
+	sparse_chapters = config->geometry->sparse_chapters_per_volume;
+	dense_chapters = config->geometry->chapters_per_volume - sparse_chapters;
+	sample_records = config->geometry->records_per_chapter / sample_rate;
+
+	/* Adjust the number of records indexed for each chapter. */
+	split->hook_geometry.records_per_chapter = sample_records;
+	split->non_hook_geometry.records_per_chapter -= sample_records;
+
+	/* Adjust the number of chapters indexed. */
+	split->hook_geometry.sparse_chapters_per_volume = 0;
+	split->non_hook_geometry.sparse_chapters_per_volume = 0;
+	split->non_hook_geometry.chapters_per_volume = dense_chapters;
+}
+
+static int compute_volume_index_save_bytes(const struct configuration *config, size_t *bytes)
+{
+	size_t hook_bytes, non_hook_bytes;
+	struct split_config split;
+	int result;
+
+	if (!uds_is_sparse_geometry(config->geometry))
+		return compute_volume_sub_index_save_bytes(config, bytes);
+
+	split_configuration(config, &split);
+	result = compute_volume_sub_index_save_bytes(&split.hook_config, &hook_bytes);
+	if (result != UDS_SUCCESS)
+		return result;
+	result = compute_volume_sub_index_save_bytes(&split.non_hook_config, &non_hook_bytes);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	*bytes = sizeof(struct volume_index_data) + hook_bytes + non_hook_bytes;
+	return UDS_SUCCESS;
+}
+
+int uds_compute_volume_index_save_blocks(const struct configuration *config,
+					 size_t block_size,
+					 u64 *block_count)
+{
+	size_t bytes;
+	int result;
+
+	result = compute_volume_index_save_bytes(config, &bytes);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	bytes += sizeof(struct delta_list_save_info);
+	*block_count = DIV_ROUND_UP(bytes, block_size) + MAX_ZONES;
+	return UDS_SUCCESS;
+}
+
+/* Flush invalid entries while walking the delta list. */
+static inline int flush_invalid_entries(struct volume_index_record *record,
+					struct chapter_range *flush_range,
+					u32 *next_chapter_to_invalidate)
+{
+	int result;
+
+	result = uds_next_delta_index_entry(&record->delta_entry);
+	if (result != UDS_SUCCESS)
+		return result;
+	while (!record->delta_entry.at_end) {
+		u32 index_chapter = uds_get_delta_entry_value(&record->delta_entry);
+		u32 relative_chapter = ((index_chapter - flush_range->chapter_start) &
+					record->sub_index->chapter_mask);
+
+		if (likely(relative_chapter >= flush_range->chapter_count)) {
+			if (relative_chapter < *next_chapter_to_invalidate)
+				*next_chapter_to_invalidate = relative_chapter;
+			break;
+		}
+		result = uds_remove_delta_index_entry(&record->delta_entry);
+		if (result != UDS_SUCCESS)
+			return result;
+	}
+	return UDS_SUCCESS;
+}
+
+/* Find the matching record, or the list offset where the record would go. */
+static int get_volume_index_entry(struct volume_index_record *record,
+				  u32 list_number,
+				  u32 key,
+				  struct chapter_range *flush_range)
+{
+	struct volume_index_record other_record;
+	const struct volume_sub_index *sub_index = record->sub_index;
+	u32 next_chapter_to_invalidate = sub_index->chapter_mask;
+	int result;
+
+	result = uds_start_delta_index_search(&sub_index->delta_index,
+					      list_number,
+					      0,
+					      &record->delta_entry);
+	if (result != UDS_SUCCESS)
+		return result;
+	do {
+		result = flush_invalid_entries(record, flush_range, &next_chapter_to_invalidate);
+		if (result != UDS_SUCCESS)
+			return result;
+	} while (!record->delta_entry.at_end && (key > record->delta_entry.key));
+
+	result = uds_remember_delta_index_offset(&record->delta_entry);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	/* Check any collision records for a more precise match. */
+	other_record = *record;
+	if (!other_record.delta_entry.at_end && (key == other_record.delta_entry.key)) {
+		for (;;) {
+			u8 collision_name[UDS_RECORD_NAME_SIZE];
+
+			result = flush_invalid_entries(&other_record,
+						       flush_range,
+						       &next_chapter_to_invalidate);
+			if (result != UDS_SUCCESS)
+				return result;
+			if (other_record.delta_entry.at_end ||
+			    !other_record.delta_entry.is_collision)
+				break;
+			result = uds_get_delta_entry_collision(&other_record.delta_entry,
+							       collision_name);
+			if (result != UDS_SUCCESS)
+				return result;
+			if (memcmp(collision_name, record->name, UDS_RECORD_NAME_SIZE) == 0) {
+				*record = other_record;
+				break;
+			}
+		}
+	}
+	while (!other_record.delta_entry.at_end) {
+		result = flush_invalid_entries(&other_record,
+					       flush_range,
+					       &next_chapter_to_invalidate);
+		if (result != UDS_SUCCESS)
+			return result;
+	}
+	next_chapter_to_invalidate += flush_range->chapter_start;
+	next_chapter_to_invalidate &= sub_index->chapter_mask;
+	flush_range->chapter_start = next_chapter_to_invalidate;
+	flush_range->chapter_count = 0;
+	return UDS_SUCCESS;
+}
+
+static int get_volume_sub_index_record(struct volume_sub_index *sub_index,
+				       const struct uds_record_name *name,
+				       struct volume_index_record *record)
+{
+	int result;
+	const struct volume_sub_index_zone *volume_index_zone;
+	u32 address = extract_address(sub_index, name);
+	u32 delta_list_number = extract_dlist_num(sub_index, name);
+	u64 flush_chapter = sub_index->flush_chapters[delta_list_number];
+
+	record->sub_index = sub_index;
+	record->mutex = NULL;
+	record->name = name;
+	record->zone_number = delta_list_number / sub_index->delta_index.lists_per_zone;
+	volume_index_zone = get_zone_for_record(record);
+
+	if (flush_chapter < volume_index_zone->virtual_chapter_low) {
+		struct chapter_range range;
+		u64 flush_count = volume_index_zone->virtual_chapter_low - flush_chapter;
+
+		range.chapter_start = convert_virtual_to_index(sub_index, flush_chapter);
+		range.chapter_count = (flush_count > sub_index->chapter_mask ?
+				       sub_index->chapter_mask + 1 :
+				       flush_count);
+		result = get_volume_index_entry(record, delta_list_number, address, &range);
+		flush_chapter = convert_index_to_virtual(record, range.chapter_start);
+		if (flush_chapter > volume_index_zone->virtual_chapter_high)
+			flush_chapter = volume_index_zone->virtual_chapter_high;
+		sub_index->flush_chapters[delta_list_number] = flush_chapter;
+	} else {
+		result = uds_get_delta_index_entry(&sub_index->delta_index,
+						   delta_list_number,
+						   address,
+						   name->name,
+						   &record->delta_entry);
+	}
+	if (result != UDS_SUCCESS)
+		return result;
+	record->is_found = (!record->delta_entry.at_end && (record->delta_entry.key == address));
+	if (record->is_found) {
+		u32 index_chapter = uds_get_delta_entry_value(&record->delta_entry);
+
+		record->virtual_chapter = convert_index_to_virtual(record, index_chapter);
+	}
+	record->is_collision = record->delta_entry.is_collision;
+	return UDS_SUCCESS;
+}
+
+int uds_get_volume_index_record(struct volume_index *volume_index,
+				const struct uds_record_name *name,
+				struct volume_index_record *record)
+{
+	int result;
+
+	if (uds_is_volume_index_sample(volume_index, name)) {
+		/*
+		 * Other threads cannot be allowed to call uds_lookup_volume_index_name() while
+		 * this thread is finding the volume index record. Due to the lazy LRU flushing of
+		 * the volume index, uds_get_volume_index_record() is not a read-only operation.
+		 */
+		unsigned int zone = get_volume_sub_index_zone(&volume_index->vi_hook, name);
+		struct mutex *mutex = &volume_index->zones[zone].hook_mutex;
+
+		uds_lock_mutex(mutex);
+		result = get_volume_sub_index_record(&volume_index->vi_hook, name, record);
+		uds_unlock_mutex(mutex);
+		/* Remember the mutex so that other operations on the index record can use it. */
+		record->mutex = mutex;
+	} else {
+		result = get_volume_sub_index_record(&volume_index->vi_non_hook, name, record);
+	}
+	return result;
+}
+
+int uds_put_volume_index_record(struct volume_index_record *record, u64 virtual_chapter)
+{
+	int result;
+	u32 address;
+	const struct volume_sub_index *sub_index = record->sub_index;
+
+	if (!is_virtual_chapter_indexed(record, virtual_chapter)) {
+		u64 low = get_zone_for_record(record)->virtual_chapter_low;
+		u64 high = get_zone_for_record(record)->virtual_chapter_high;
+
+		return uds_log_warning_strerror(UDS_INVALID_ARGUMENT,
+						"cannot put record into chapter number %llu that is out of the valid range %llu to %llu",
+						(unsigned long long) virtual_chapter,
+						(unsigned long long) low,
+						(unsigned long long) high);
+	}
+	address = extract_address(sub_index, record->name);
+	if (unlikely(record->mutex != NULL))
+		uds_lock_mutex(record->mutex);
+	result = uds_put_delta_index_entry(&record->delta_entry,
+					   address,
+					   convert_virtual_to_index(sub_index, virtual_chapter),
+					   record->is_found ? record->name->name : NULL);
+	if (unlikely(record->mutex != NULL))
+		uds_unlock_mutex(record->mutex);
+	switch (result) {
+	case UDS_SUCCESS:
+		record->virtual_chapter = virtual_chapter;
+		record->is_collision = record->delta_entry.is_collision;
+		record->is_found = true;
+		break;
+	case UDS_OVERFLOW:
+		uds_log_ratelimit(uds_log_warning_strerror,
+				  UDS_OVERFLOW,
+				  "Volume index entry dropped due to overflow condition");
+		uds_log_delta_index_entry(&record->delta_entry);
+		break;
+	default:
+		break;
+	}
+	return result;
+}
+
+int uds_remove_volume_index_record(struct volume_index_record *record)
+{
+	int result;
+
+	if (!record->is_found)
+		return uds_log_warning_strerror(UDS_BAD_STATE, "illegal operation on new record");
+	/* Mark the record so that it cannot be used again */
+	record->is_found = false;
+	if (unlikely(record->mutex != NULL))
+		uds_lock_mutex(record->mutex);
+	result = uds_remove_delta_index_entry(&record->delta_entry);
+	if (unlikely(record->mutex != NULL))
+		uds_unlock_mutex(record->mutex);
+	return result;
+}
+
+static void set_volume_sub_index_zone_open_chapter(struct volume_sub_index *sub_index,
+						   unsigned int zone_number,
+						   u64 virtual_chapter)
+{
+	u64 used_bits = 0;
+	struct volume_sub_index_zone *zone = &sub_index->zones[zone_number];
+	struct delta_zone *delta_zone;
+	u32 i;
+
+	zone->virtual_chapter_low = (virtual_chapter >= sub_index->chapter_count ?
+				     virtual_chapter - sub_index->chapter_count + 1 :
+				     0);
+	zone->virtual_chapter_high = virtual_chapter;
+
+	/* Check to see if the new zone data is too large. */
+	delta_zone = &sub_index->delta_index.delta_zones[zone_number];
+	for (i = 1; i <= delta_zone->list_count; i++)
+		used_bits += delta_zone->delta_lists[i].size;
+
+	if (used_bits > sub_index->max_zone_bits) {
+		/* Expire enough chapters to free the desired space. */
+		u64 expire_count =
+			1 + (used_bits - sub_index->max_zone_bits) / sub_index->chapter_zone_bits;
+
+		if (expire_count == 1) {
+			uds_log_ratelimit(uds_log_info,
+					  "zone %u:  At chapter %llu, expiring chapter %llu early",
+					  zone_number,
+					  (unsigned long long) virtual_chapter,
+					  (unsigned long long) zone->virtual_chapter_low);
+			zone->early_flushes++;
+			zone->virtual_chapter_low++;
+		} else {
+			u64 first_expired = zone->virtual_chapter_low;
+
+			if (first_expired + expire_count < zone->virtual_chapter_high) {
+				zone->early_flushes += expire_count;
+				zone->virtual_chapter_low += expire_count;
+			} else {
+				zone->early_flushes +=
+					zone->virtual_chapter_high - zone->virtual_chapter_low;
+				zone->virtual_chapter_low = zone->virtual_chapter_high;
+			}
+			uds_log_ratelimit(uds_log_info,
+					  "zone %u:  At chapter %llu, expiring chapters %llu to %llu early",
+					  zone_number,
+					  (unsigned long long) virtual_chapter,
+					  (unsigned long long) first_expired,
+					  (unsigned long long) zone->virtual_chapter_low - 1);
+		}
+	}
+}
+
+void uds_set_volume_index_zone_open_chapter(struct volume_index *volume_index,
+					    unsigned int zone_number,
+					    u64 virtual_chapter)
+{
+	struct mutex *mutex = &volume_index->zones[zone_number].hook_mutex;
+
+	set_volume_sub_index_zone_open_chapter(&volume_index->vi_non_hook,
+					       zone_number,
+					       virtual_chapter);
+
+	/*
+	 * Other threads cannot be allowed to call uds_lookup_volume_index_name() while the open
+	 * chapter number is changing.
+	 */
+	if (has_sparse(volume_index)) {
+		uds_lock_mutex(mutex);
+		set_volume_sub_index_zone_open_chapter(&volume_index->vi_hook,
+						       zone_number,
+						       virtual_chapter);
+		uds_unlock_mutex(mutex);
+	}
+}
+
+/*
+ * Set the newest open chapter number for the index, while also advancing the oldest valid chapter
+ * number.
+ */
+void uds_set_volume_index_open_chapter(struct volume_index *volume_index, u64 virtual_chapter)
+{
+	unsigned int zone;
+
+	for (zone = 0; zone < volume_index->zone_count; zone++)
+		uds_set_volume_index_zone_open_chapter(volume_index, zone, virtual_chapter);
+}
+
+int uds_set_volume_index_record_chapter(struct volume_index_record *record, u64 virtual_chapter)
+{
+	const struct volume_sub_index *sub_index = record->sub_index;
+	int result;
+
+	if (!record->is_found)
+		return uds_log_warning_strerror(UDS_BAD_STATE, "illegal operation on new record");
+	if (!is_virtual_chapter_indexed(record, virtual_chapter)) {
+		u64 low = get_zone_for_record(record)->virtual_chapter_low;
+		u64 high = get_zone_for_record(record)->virtual_chapter_high;
+
+		return uds_log_warning_strerror(UDS_INVALID_ARGUMENT,
+						"cannot set chapter number %llu that is out of the valid range %llu to %llu",
+						(unsigned long long) virtual_chapter,
+						(unsigned long long) low,
+						(unsigned long long) high);
+	}
+	if (unlikely(record->mutex != NULL))
+		uds_lock_mutex(record->mutex);
+	result = uds_set_delta_entry_value(&record->delta_entry,
+					   convert_virtual_to_index(sub_index, virtual_chapter));
+	if (unlikely(record->mutex != NULL))
+		uds_unlock_mutex(record->mutex);
+	if (result != UDS_SUCCESS)
+		return result;
+	record->virtual_chapter = virtual_chapter;
+	return UDS_SUCCESS;
+}
+
+static u64 lookup_volume_sub_index_name(const struct volume_sub_index *sub_index,
+					const struct uds_record_name *name)
+{
+	int result;
+	u32 address = extract_address(sub_index, name);
+	u32 delta_list_number = extract_dlist_num(sub_index, name);
+	unsigned int zone_number = get_volume_sub_index_zone(sub_index, name);
+	const struct volume_sub_index_zone *zone = &sub_index->zones[zone_number];
+	u64 virtual_chapter;
+	u32 index_chapter;
+	u32 rolling_chapter;
+	struct delta_index_entry delta_entry;
+
+	result = uds_get_delta_index_entry(&sub_index->delta_index,
+					   delta_list_number,
+					   address,
+					   name->name,
+					   &delta_entry);
+	if (result != UDS_SUCCESS)
+		return NO_CHAPTER;
+
+	if (delta_entry.at_end || (delta_entry.key != address))
+		return NO_CHAPTER;
+
+	index_chapter = uds_get_delta_entry_value(&delta_entry);
+	rolling_chapter = (index_chapter - zone->virtual_chapter_low) & sub_index->chapter_mask;
+
+	virtual_chapter = zone->virtual_chapter_low + rolling_chapter;
+	if (virtual_chapter > zone->virtual_chapter_high)
+		return NO_CHAPTER;
+
+	return virtual_chapter;
+}
+
+/* Do a read-only lookup of the record name for sparse cache management. */
+u64 uds_lookup_volume_index_name(const struct volume_index *volume_index,
+				 const struct uds_record_name *name)
+{
+	unsigned int zone_number = uds_get_volume_index_zone(volume_index, name);
+	struct mutex *mutex = &volume_index->zones[zone_number].hook_mutex;
+	u64 virtual_chapter;
+
+	if (!uds_is_volume_index_sample(volume_index, name))
+		return NO_CHAPTER;
+
+	uds_lock_mutex(mutex);
+	virtual_chapter = lookup_volume_sub_index_name(&volume_index->vi_hook, name);
+	uds_unlock_mutex(mutex);
+
+	return virtual_chapter;
+}
+
+static void abort_restoring_volume_sub_index(struct volume_sub_index *sub_index)
+{
+	uds_reset_delta_index(&sub_index->delta_index);
+}
+
+static void abort_restoring_volume_index(struct volume_index *volume_index)
+{
+	abort_restoring_volume_sub_index(&volume_index->vi_non_hook);
+	if (has_sparse(volume_index))
+		abort_restoring_volume_sub_index(&volume_index->vi_hook);
+}
+
+static int start_restoring_volume_sub_index(struct volume_sub_index *sub_index,
+					    struct buffered_reader **readers,
+					    unsigned int reader_count)
+{
+	unsigned int z;
+	int result;
+	u64 virtual_chapter_low = 0, virtual_chapter_high = 0;
+	unsigned int i;
+
+	for (i = 0; i < reader_count; i++) {
+		struct sub_index_data header;
+		u8 buffer[sizeof(struct sub_index_data)];
+		size_t offset = 0;
+		u32 j;
+
+		result = uds_read_from_buffered_reader(readers[i], buffer, sizeof(buffer));
+		if (result != UDS_SUCCESS)
+			return uds_log_warning_strerror(result,
+							"failed to read volume index header");
+
+		memcpy(&header.magic, buffer, MAGIC_SIZE);
+		offset += MAGIC_SIZE;
+		decode_u64_le(buffer, &offset, &header.volume_nonce);
+		decode_u64_le(buffer, &offset, &header.virtual_chapter_low);
+		decode_u64_le(buffer, &offset, &header.virtual_chapter_high);
+		decode_u32_le(buffer, &offset, &header.first_list);
+		decode_u32_le(buffer, &offset, &header.list_count);
+
+		result = ASSERT(offset = sizeof(buffer),
+				"%zu bytes decoded of %zu expected",
+				offset,
+				sizeof(buffer));
+		if (result != UDS_SUCCESS)
+			result = UDS_CORRUPT_DATA;
+
+		if (memcmp(header.magic, MAGIC_START_5, MAGIC_SIZE) != 0)
+			return uds_log_warning_strerror(UDS_CORRUPT_DATA,
+							"volume index file had bad magic number");
+
+		if (sub_index->volume_nonce == 0)
+			sub_index->volume_nonce = header.volume_nonce;
+		else if (header.volume_nonce != sub_index->volume_nonce)
+			return uds_log_warning_strerror(UDS_CORRUPT_DATA,
+							"volume index volume nonce incorrect");
+
+		if (i == 0) {
+			virtual_chapter_low = header.virtual_chapter_low;
+			virtual_chapter_high = header.virtual_chapter_high;
+		} else if (virtual_chapter_high != header.virtual_chapter_high) {
+			u64 low = header.virtual_chapter_low;
+			u64 high = header.virtual_chapter_high;
+
+			return uds_log_warning_strerror(UDS_CORRUPT_DATA,
+							"Inconsistent volume index zone files: Chapter range is [%llu,%llu], chapter range %d is [%llu,%llu]",
+							(unsigned long long) virtual_chapter_low,
+							(unsigned long long) virtual_chapter_high,
+							i,
+							(unsigned long long) low,
+							(unsigned long long) high);
+		} else if (virtual_chapter_low < header.virtual_chapter_low) {
+			virtual_chapter_low = header.virtual_chapter_low;
+		}
+
+		for (j = 0; j < header.list_count; j++) {
+			u8 decoded[sizeof(u64)];
+
+			result = uds_read_from_buffered_reader(readers[i], decoded, sizeof(u64));
+			if (result != UDS_SUCCESS)
+				return uds_log_warning_strerror(result,
+								"failed to read volume index flush ranges");
+
+			sub_index->flush_chapters[header.first_list + j] =
+				get_unaligned_le64(decoded);
+		}
+	}
+
+	for (z = 0; z < sub_index->zone_count; z++) {
+		memset(&sub_index->zones[z], 0, sizeof(struct volume_sub_index_zone));
+		sub_index->zones[z].virtual_chapter_low = virtual_chapter_low;
+		sub_index->zones[z].virtual_chapter_high = virtual_chapter_high;
+	}
+
+	result = uds_start_restoring_delta_index(&sub_index->delta_index, readers, reader_count);
+	if (result != UDS_SUCCESS)
+		return uds_log_warning_strerror(result, "restoring delta index failed");
+
+	return UDS_SUCCESS;
+}
+
+static int start_restoring_volume_index(struct volume_index *volume_index,
+					struct buffered_reader **buffered_readers,
+					unsigned int reader_count)
+{
+	unsigned int i;
+	int result;
+
+	if (!has_sparse(volume_index))
+		return start_restoring_volume_sub_index(&volume_index->vi_non_hook,
+							buffered_readers,
+							reader_count);
+
+	for (i = 0; i < reader_count; i++) {
+		struct volume_index_data header;
+		u8 buffer[sizeof(struct volume_index_data)];
+		size_t offset = 0;
+
+		result = uds_read_from_buffered_reader(buffered_readers[i], buffer, sizeof(buffer));
+		if (result != UDS_SUCCESS)
+			return uds_log_warning_strerror(result,
+							"failed to read volume index header");
+
+		memcpy(&header.magic, buffer, MAGIC_SIZE);
+		offset += MAGIC_SIZE;
+		decode_u32_le(buffer, &offset, &header.sparse_sample_rate);
+
+		result = ASSERT(offset == sizeof(buffer),
+				"%zu bytes decoded of %zu expected",
+				offset,
+				sizeof(buffer));
+		if (result != UDS_SUCCESS)
+			result = UDS_CORRUPT_DATA;
+
+		if (memcmp(header.magic, MAGIC_START_6, MAGIC_SIZE) != 0)
+			return uds_log_warning_strerror(UDS_CORRUPT_DATA,
+							"volume index file had bad magic number");
+
+		if (i == 0) {
+			volume_index->sparse_sample_rate = header.sparse_sample_rate;
+		} else if (volume_index->sparse_sample_rate != header.sparse_sample_rate) {
+			uds_log_warning_strerror(UDS_CORRUPT_DATA,
+						 "Inconsistent sparse sample rate in delta index zone files: %u vs. %u",
+						 volume_index->sparse_sample_rate,
+						 header.sparse_sample_rate);
+			return UDS_CORRUPT_DATA;
+		}
+	}
+
+	result = start_restoring_volume_sub_index(&volume_index->vi_non_hook,
+						  buffered_readers,
+						  reader_count);
+	if (result != UDS_SUCCESS)
+		return result;
+	return start_restoring_volume_sub_index(&volume_index->vi_hook,
+						buffered_readers,
+						reader_count);
+}
+
+static int finish_restoring_volume_sub_index(struct volume_sub_index *sub_index,
+					     struct buffered_reader **buffered_readers,
+					     unsigned int reader_count)
+{
+	return uds_finish_restoring_delta_index(&sub_index->delta_index,
+						buffered_readers,
+						reader_count);
+}
+
+static int finish_restoring_volume_index(struct volume_index *volume_index,
+					 struct buffered_reader **buffered_readers,
+					 unsigned int reader_count)
+{
+	int result;
+
+	result = finish_restoring_volume_sub_index(&volume_index->vi_non_hook,
+						   buffered_readers,
+						   reader_count);
+	if ((result == UDS_SUCCESS) && has_sparse(volume_index))
+		result = finish_restoring_volume_sub_index(&volume_index->vi_hook,
+							   buffered_readers,
+							   reader_count);
+	return result;
+}
+
+int uds_load_volume_index(struct volume_index *volume_index,
+			  struct buffered_reader **readers,
+			  unsigned int reader_count)
+{
+	int result;
+
+	/* Start by reading the header section of the stream. */
+	result = start_restoring_volume_index(volume_index, readers, reader_count);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = finish_restoring_volume_index(volume_index, readers, reader_count);
+	if (result != UDS_SUCCESS) {
+		abort_restoring_volume_index(volume_index);
+		return result;
+	}
+
+	/* Check the final guard lists to make sure there is no extra data. */
+	result = uds_check_guard_delta_lists(readers, reader_count);
+	if (result != UDS_SUCCESS)
+		abort_restoring_volume_index(volume_index);
+
+	return result;
+}
+
+static int start_saving_volume_sub_index(const struct volume_sub_index *sub_index,
+					 unsigned int zone_number,
+					 struct buffered_writer *buffered_writer)
+{
+	int result;
+	struct volume_sub_index_zone *volume_index_zone = &sub_index->zones[zone_number];
+	u32 first_list = sub_index->delta_index.delta_zones[zone_number].first_list;
+	u32 list_count = sub_index->delta_index.delta_zones[zone_number].list_count;
+	u8 buffer[sizeof(struct sub_index_data)];
+	size_t offset = 0;
+	u32 i;
+
+	memcpy(buffer, MAGIC_START_5, MAGIC_SIZE);
+	offset += MAGIC_SIZE;
+	encode_u64_le(buffer, &offset, sub_index->volume_nonce);
+	encode_u64_le(buffer, &offset, volume_index_zone->virtual_chapter_low);
+	encode_u64_le(buffer, &offset, volume_index_zone->virtual_chapter_high);
+	encode_u32_le(buffer, &offset, first_list);
+	encode_u32_le(buffer, &offset, list_count);
+
+	result =  ASSERT(offset == sizeof(struct sub_index_data),
+			 "%zu bytes of config written, of %zu expected",
+			 offset,
+			 sizeof(struct sub_index_data));
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = uds_write_to_buffered_writer(buffered_writer, buffer, offset);
+	if (result != UDS_SUCCESS)
+		return uds_log_warning_strerror(result, "failed to write volume index header");
+
+	for (i = 0; i < list_count; i++) {
+		u8 encoded[sizeof(u64)];
+
+		put_unaligned_le64(sub_index->flush_chapters[first_list + i], &encoded);
+		result = uds_write_to_buffered_writer(buffered_writer, encoded, sizeof(u64));
+		if (result != UDS_SUCCESS)
+			return uds_log_warning_strerror(result,
+							"failed to write volume index flush ranges");
+	}
+
+	return uds_start_saving_delta_index(&sub_index->delta_index, zone_number, buffered_writer);
+}
+
+static int start_saving_volume_index(const struct volume_index *volume_index,
+				     unsigned int zone_number,
+				     struct buffered_writer *writer)
+{
+	u8 buffer[sizeof(struct volume_index_data)];
+	size_t offset = 0;
+	int result;
+
+	if (!has_sparse(volume_index))
+		return start_saving_volume_sub_index(&volume_index->vi_non_hook,
+						     zone_number,
+						     writer);
+
+	memcpy(buffer, MAGIC_START_6, MAGIC_SIZE);
+	offset += MAGIC_SIZE;
+	encode_u32_le(buffer, &offset, volume_index->sparse_sample_rate);
+	result = ASSERT(offset == sizeof(struct volume_index_data),
+			"%zu bytes of header written, of %zu expected",
+			offset,
+			sizeof(struct volume_index_data));
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = uds_write_to_buffered_writer(writer, buffer, offset);
+	if (result != UDS_SUCCESS) {
+		uds_log_warning_strerror(result, "failed to write volume index header");
+		return result;
+	}
+
+	result = start_saving_volume_sub_index(&volume_index->vi_non_hook, zone_number, writer);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	return start_saving_volume_sub_index(&volume_index->vi_hook, zone_number, writer);
+}
+
+static int
+finish_saving_volume_sub_index(const struct volume_sub_index *sub_index, unsigned int zone_number)
+{
+	return uds_finish_saving_delta_index(&sub_index->delta_index, zone_number);
+}
+
+static int
+finish_saving_volume_index(const struct volume_index *volume_index, unsigned int zone_number)
+{
+	int result;
+
+	result = finish_saving_volume_sub_index(&volume_index->vi_non_hook, zone_number);
+	if ((result == UDS_SUCCESS) && has_sparse(volume_index))
+		result = finish_saving_volume_sub_index(&volume_index->vi_hook, zone_number);
+	return result;
+}
+
+int uds_save_volume_index(struct volume_index *volume_index,
+			  struct buffered_writer **writers,
+			  unsigned int writer_count)
+{
+	int result = UDS_SUCCESS;
+	unsigned int zone;
+
+	for (zone = 0; zone < writer_count; ++zone) {
+		result = start_saving_volume_index(volume_index, zone, writers[zone]);
+		if (result != UDS_SUCCESS)
+			break;
+
+		result = finish_saving_volume_index(volume_index, zone);
+		if (result != UDS_SUCCESS)
+			break;
+
+		result = uds_write_guard_delta_list(writers[zone]);
+		if (result != UDS_SUCCESS)
+			break;
+
+		result = uds_flush_buffered_writer(writers[zone]);
+		if (result != UDS_SUCCESS)
+			break;
+	}
+
+	return result;
+}
+
+static void get_volume_sub_index_stats(const struct volume_sub_index *sub_index,
+				       struct volume_index_stats *stats)
+{
+	struct delta_index_stats dis;
+	unsigned int z;
+
+	uds_get_delta_index_stats(&sub_index->delta_index, &dis);
+	stats->rebalance_time = dis.rebalance_time;
+	stats->rebalance_count = dis.rebalance_count;
+	stats->record_count = dis.record_count;
+	stats->collision_count = dis.collision_count;
+	stats->discard_count = dis.discard_count;
+	stats->overflow_count = dis.overflow_count;
+	stats->delta_lists = dis.list_count;
+	stats->early_flushes = 0;
+	for (z = 0; z < sub_index->zone_count; z++)
+		stats->early_flushes += sub_index->zones[z].early_flushes;
+}
+
+void uds_get_volume_index_stats(const struct volume_index *volume_index,
+				struct volume_index_stats *stats)
+{
+	struct volume_index_stats sparse_stats;
+
+	get_volume_sub_index_stats(&volume_index->vi_non_hook, stats);
+	if (!has_sparse(volume_index))
+		return;
+
+	get_volume_sub_index_stats(&volume_index->vi_hook, &sparse_stats);
+	stats->rebalance_time += sparse_stats.rebalance_time;
+	stats->rebalance_count += sparse_stats.rebalance_count;
+	stats->record_count += sparse_stats.record_count;
+	stats->collision_count += sparse_stats.collision_count;
+	stats->discard_count += sparse_stats.discard_count;
+	stats->overflow_count += sparse_stats.overflow_count;
+	stats->delta_lists += sparse_stats.delta_lists;
+	stats->early_flushes += sparse_stats.early_flushes;
+}
+
+static int initialize_volume_sub_index(const struct configuration *config,
+				       u64 volume_nonce,
+				       u8 tag,
+				       struct volume_sub_index *sub_index)
+{
+	struct sub_index_parameters params = { .address_bits = 0 };
+	unsigned int zone_count = config->zone_count;
+	u64 available_bytes = 0;
+	unsigned int z;
+	int result;
+
+	result = compute_volume_sub_index_parameters(config, &params);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	sub_index->address_bits = params.address_bits;
+	sub_index->address_mask = (1u << params.address_bits) - 1;
+	sub_index->chapter_bits = params.chapter_bits;
+	sub_index->chapter_mask = (1u << params.chapter_bits) - 1;
+	sub_index->chapter_count = params.chapter_count;
+	sub_index->list_count = params.list_count;
+	sub_index->zone_count = zone_count;
+	sub_index->chapter_zone_bits = params.chapter_size_in_bits / zone_count;
+	sub_index->volume_nonce = volume_nonce;
+
+	result = uds_initialize_delta_index(&sub_index->delta_index,
+					    zone_count,
+					    params.list_count,
+					    params.mean_delta,
+					    params.chapter_bits,
+					    params.memory_size,
+					    tag);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	for (z = 0; z < sub_index->delta_index.zone_count; z++)
+		available_bytes += sub_index->delta_index.delta_zones[z].size;
+	available_bytes -= params.target_free_bytes;
+	sub_index->max_zone_bits = (available_bytes * BITS_PER_BYTE) / zone_count;
+	sub_index->memory_size = (sub_index->delta_index.memory_size +
+				  sizeof(struct volume_sub_index) +
+				  (params.list_count * sizeof(u64)) +
+				  (zone_count * sizeof(struct volume_sub_index_zone)));
+
+	/* The following arrays are initialized to all zeros. */
+	result = UDS_ALLOCATE(params.list_count,
+			      u64,
+			      "first chapter to flush",
+			      &sub_index->flush_chapters);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	return UDS_ALLOCATE(zone_count,
+			    struct volume_sub_index_zone,
+			    "volume index zones",
+			    &sub_index->zones);
+}
+
+int uds_make_volume_index(const struct configuration *config,
+			  u64 volume_nonce,
+			  struct volume_index **volume_index_ptr)
+{
+	struct split_config split;
+	unsigned int zone;
+	struct volume_index *volume_index;
+	int result;
+
+	result = UDS_ALLOCATE(1, struct volume_index, "volume index", &volume_index);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	volume_index->zone_count = config->zone_count;
+
+	if (!uds_is_sparse_geometry(config->geometry)) {
+		result = initialize_volume_sub_index(config,
+						     volume_nonce,
+						     'm',
+						     &volume_index->vi_non_hook);
+		if (result != UDS_SUCCESS) {
+			uds_free_volume_index(volume_index);
+			return result;
+		}
+
+		volume_index->memory_size = volume_index->vi_non_hook.memory_size;
+		*volume_index_ptr = volume_index;
+		return UDS_SUCCESS;
+	}
+
+	volume_index->sparse_sample_rate = config->sparse_sample_rate;
+
+	result = UDS_ALLOCATE(config->zone_count,
+			      struct volume_index_zone,
+			      "volume index zones",
+			      &volume_index->zones);
+	if (result != UDS_SUCCESS) {
+		uds_free_volume_index(volume_index);
+		return result;
+	}
+
+	for (zone = 0; zone < config->zone_count; zone++) {
+		result = uds_init_mutex(&volume_index->zones[zone].hook_mutex);
+		if (result != UDS_SUCCESS) {
+			uds_free_volume_index(volume_index);
+			return result;
+		}
+	}
+
+	split_configuration(config, &split);
+	result = initialize_volume_sub_index(&split.non_hook_config,
+					     volume_nonce,
+					     'd',
+					     &volume_index->vi_non_hook);
+	if (result != UDS_SUCCESS) {
+		uds_free_volume_index(volume_index);
+		return uds_log_error_strerror(result, "Error creating non hook volume index");
+	}
+
+	result = initialize_volume_sub_index(&split.hook_config,
+					     volume_nonce,
+					     's',
+					     &volume_index->vi_hook);
+	if (result != UDS_SUCCESS) {
+		uds_free_volume_index(volume_index);
+		return uds_log_error_strerror(result, "Error creating hook volume index");
+	}
+
+	volume_index->memory_size =
+		volume_index->vi_non_hook.memory_size + volume_index->vi_hook.memory_size;
+	*volume_index_ptr = volume_index;
+	return UDS_SUCCESS;
+}
diff --git a/drivers/md/dm-vdo/volume-index.h b/drivers/md/dm-vdo/volume-index.h
new file mode 100644
index 000000000000..248f8ec86957
--- /dev/null
+++ b/drivers/md/dm-vdo/volume-index.h
@@ -0,0 +1,192 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2023 Red Hat
+ */
+
+#ifndef UDS_VOLUME_INDEX_H
+#define UDS_VOLUME_INDEX_H
+
+#include <linux/limits.h>
+
+#include "config.h"
+#include "delta-index.h"
+#include "uds.h"
+#include "uds-threads.h"
+
+/*
+ * The volume index is the primary top-level index for UDS. It contains records which map a record
+ * name to the chapter where a record with that name is stored. This mapping can definitively say
+ * when no record exists. However, because we only use a subset of the name for this index, it
+ * cannot definitively say that a record for the entry does exist. It can only say that if a record
+ * exists, it will be in a particular chapter. The request can then be dispatched to that chapter
+ * for further processing.
+ *
+ * If the volume_index_record does not actually match the record name, the index can store a more
+ * specific collision record to disambiguate the new entry from the existing one. Index entries are
+ * managed with volume_index_record structures.
+ */
+
+static const u64 NO_CHAPTER = U64_MAX;
+
+struct volume_index_stats {
+	/* Nanoseconds spent rebalancing */
+	ktime_t rebalance_time;
+	/* Number of memory rebalances */
+	u32 rebalance_count;
+	/* The number of records in the index */
+	u64 record_count;
+	/* The number of collision records */
+	u64 collision_count;
+	/* The number of records removed */
+	u64 discard_count;
+	/* The number of UDS_OVERFLOWs detected */
+	u64 overflow_count;
+	/* The number of delta lists */
+	u32 delta_lists;
+	/* Number of early flushes */
+	u64 early_flushes;
+};
+
+struct volume_sub_index_zone {
+	u64 virtual_chapter_low;
+	u64 virtual_chapter_high;
+	u64 early_flushes;
+} __aligned(L1_CACHE_BYTES);
+
+struct volume_sub_index {
+	/* The delta index */
+	struct delta_index delta_index;
+	/* The first chapter to be flushed in each zone */
+	u64 *flush_chapters;
+	/* The zones */
+	struct volume_sub_index_zone *zones;
+	/* The volume nonce */
+	u64 volume_nonce;
+	/* Expected size of a chapter (per zone) */
+	u64 chapter_zone_bits;
+	/* Maximum size of the index (per zone) */
+	u64 max_zone_bits;
+	/* The number of bits in address mask */
+	u8 address_bits;
+	/* Mask to get address within delta list */
+	u32 address_mask;
+	/* The number of bits in chapter number */
+	u8 chapter_bits;
+	/* The largest storable chapter number */
+	u32 chapter_mask;
+	/* The number of chapters used */
+	u32 chapter_count;
+	/* The number of delta lists */
+	u32 list_count;
+	/* The number of zones */
+	unsigned int zone_count;
+	/* The amount of memory allocated */
+	u64 memory_size;
+};
+
+struct volume_index_zone {
+	/* Protects the sampled index in this zone */
+	struct mutex hook_mutex;
+} __aligned(L1_CACHE_BYTES);
+
+struct volume_index {
+	u32 sparse_sample_rate;
+	unsigned int zone_count;
+	u64 memory_size;
+	struct volume_sub_index vi_non_hook;
+	struct volume_sub_index vi_hook;
+	struct volume_index_zone *zones;
+};
+
+/*
+ * The volume_index_record structure is used to facilitate processing of a record name. A client
+ * first calls uds_get_volume_index_record() to find the volume index record for a record name. The
+ * fields of the record can then be examined to determine the state of the record.
+ *
+ * If is_found is false, then the index did not find an entry for the record name. Calling
+ * uds_put_volume_index_record() will insert a new entry for that name at the proper place.
+ *
+ * If is_found is true, then we did find an entry for the record name, and the virtual_chapter and
+ * is_collision fields reflect the entry found. Subsequently, a call to
+ * uds_remove_volume_index_record() will remove the entry, a call to
+ * uds_set_volume_index_record_chapter() will update the existing entry, and a call to
+ * uds_put_volume_index_record() will insert a new collision record after the existing entry.
+ */
+struct volume_index_record {
+	/* Public fields */
+
+	/* Chapter where the record info is found */
+	u64 virtual_chapter;
+	/* This record is a collision */
+	bool is_collision;
+	/* This record is the requested record */
+	bool is_found;
+
+	/* Private fields */
+
+	/* Zone that contains this name */
+	unsigned int zone_number;
+	/* The volume index */
+	struct volume_sub_index *sub_index;
+	/* Mutex for accessing this delta index entry in the hook index */
+	struct mutex *mutex;
+	/* The record name to which this record refers */
+	const struct uds_record_name *name;
+	/* The delta index entry for this record */
+	struct delta_index_entry delta_entry;
+};
+
+int __must_check uds_make_volume_index(const struct configuration *config,
+				       u64 volume_nonce,
+				       struct volume_index **volume_index);
+
+void uds_free_volume_index(struct volume_index *volume_index);
+
+int __must_check uds_compute_volume_index_save_blocks(const struct configuration *config,
+						      size_t block_size,
+						      u64 *block_count);
+
+unsigned int __must_check
+uds_get_volume_index_zone(const struct volume_index *volume_index,
+			  const struct uds_record_name *name);
+
+bool __must_check uds_is_volume_index_sample(const struct volume_index *volume_index,
+					     const struct uds_record_name *name);
+
+/*
+ * This function is only used to manage sparse cache membership. Most requests should use
+ * uds_get_volume_index_record() to look up index records instead.
+ */
+u64 __must_check uds_lookup_volume_index_name(const struct volume_index *volume_index,
+					      const struct uds_record_name *name);
+
+int __must_check uds_get_volume_index_record(struct volume_index *volume_index,
+					     const struct uds_record_name *name,
+					     struct volume_index_record *record);
+
+int __must_check
+uds_put_volume_index_record(struct volume_index_record *record, u64 virtual_chapter);
+
+int __must_check uds_remove_volume_index_record(struct volume_index_record *record);
+
+int __must_check
+uds_set_volume_index_record_chapter(struct volume_index_record *record, u64 virtual_chapter);
+
+void uds_set_volume_index_open_chapter(struct volume_index *volume_index, u64 virtual_chapter);
+
+void uds_set_volume_index_zone_open_chapter(struct volume_index *volume_index,
+					    unsigned int zone_number,
+					    u64 virtual_chapter);
+
+int __must_check uds_load_volume_index(struct volume_index *volume_index,
+				       struct buffered_reader **readers,
+				       unsigned int reader_count);
+
+int __must_check uds_save_volume_index(struct volume_index *volume_index,
+				       struct buffered_writer **writers,
+				       unsigned int writer_count);
+
+void uds_get_volume_index_stats(const struct volume_index *volume_index,
+				struct volume_index_stats *stats);
+
+#endif /* UDS_VOLUME_INDEX_H */
-- 
2.40.0

