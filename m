Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6079A7D8AD1
	for <lists+linux-block@lfdr.de>; Thu, 26 Oct 2023 23:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344830AbjJZVoe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Oct 2023 17:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbjJZVoX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Oct 2023 17:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5864D5A
        for <linux-block@vger.kernel.org>; Thu, 26 Oct 2023 14:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698356508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=voNjYh+XCHZBSQn3Cd55J1ZDlYEQhHPpLgFtmB0aszM=;
        b=UA/hnJ9mcg8c3Ctt9gXpJmxBAmrlw+18KL9CQS1XH4q5T+Jzo2xLVifZmJAVR/UKaCYdxk
        CFj8myVMg38gcwQQCFWmwqn2I1WVSyWfat/Vsb5m0MqJAjctCUUFRiQLKWfGPXnoqSAhzA
        NrEfhLjrr2BIZwrVCY1yPosNd3BUO2M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-Gb3BrOKiOeOl1_qi0lPuOA-1; Thu, 26 Oct 2023 17:41:43 -0400
X-MC-Unique: Gb3BrOKiOeOl1_qi0lPuOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60524857F8C;
        Thu, 26 Oct 2023 21:41:43 +0000 (UTC)
Received: from pbitcolo-build-10.permabit.com (pbitcolo-build-10.permabit.lab.eng.bos.redhat.com [10.19.117.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05AD81C060B0;
        Thu, 26 Oct 2023 21:41:43 +0000 (UTC)
Received: by pbitcolo-build-10.permabit.com (Postfix, from userid 1138)
        id AFBDC3003D; Thu, 26 Oct 2023 17:41:42 -0400 (EDT)
From:   Matthew Sakai <msakai@redhat.com>
To:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Cc:     Matthew Sakai <msakai@redhat.com>
Subject: [PATCH v4 34/39] dm vdo: add the on-disk formats and marshalling of vdo structures
Date:   Thu, 26 Oct 2023 17:41:31 -0400
Message-Id: <20231026214136.1067410-35-msakai@redhat.com>
In-Reply-To: <20231026214136.1067410-1-msakai@redhat.com>
References: <20231026214136.1067410-1-msakai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add data and methods for marshalling and unmarshalling the persistent
metadata.

Co-developed-by: J. corwin Coburn <corwin@hurlbutnet.net>
Signed-off-by: J. corwin Coburn <corwin@hurlbutnet.net>
Co-developed-by: Michael Sclafani <vdo-devel@redhat.com>
Signed-off-by: Michael Sclafani <vdo-devel@redhat.com>
Co-developed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Matthew Sakai <msakai@redhat.com>
---
 drivers/md/dm-vdo/encodings.c | 1488 +++++++++++++++++++++++++++++++++
 drivers/md/dm-vdo/encodings.h | 1307 +++++++++++++++++++++++++++++
 2 files changed, 2795 insertions(+)
 create mode 100644 drivers/md/dm-vdo/encodings.c
 create mode 100644 drivers/md/dm-vdo/encodings.h

diff --git a/drivers/md/dm-vdo/encodings.c b/drivers/md/dm-vdo/encodings.c
new file mode 100644
index 000000000000..00ed1e70b647
--- /dev/null
+++ b/drivers/md/dm-vdo/encodings.c
@@ -0,0 +1,1488 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023 Red Hat
+ */
+
+#include "encodings.h"
+
+#include <linux/log2.h>
+
+#include "logger.h"
+#include "memory-alloc.h"
+#include "permassert.h"
+
+#include "constants.h"
+#include "status-codes.h"
+#include "types.h"
+
+struct geometry_block {
+	char magic_number[VDO_GEOMETRY_MAGIC_NUMBER_SIZE];
+	struct packed_header header;
+	u32 checksum;
+} __packed;
+
+static const struct header GEOMETRY_BLOCK_HEADER_5_0 = {
+	.id = VDO_GEOMETRY_BLOCK,
+	.version = {
+		.major_version = 5,
+		.minor_version = 0,
+	},
+	/*
+	 * Note: this size isn't just the payload size following the header, like it is everywhere
+	 * else in VDO.
+	 */
+	.size = sizeof(struct geometry_block) + sizeof(struct volume_geometry),
+};
+
+static const struct header GEOMETRY_BLOCK_HEADER_4_0 = {
+	.id = VDO_GEOMETRY_BLOCK,
+	.version = {
+		.major_version = 4,
+		.minor_version = 0,
+	},
+	/*
+	 * Note: this size isn't just the payload size following the header, like it is everywhere
+	 * else in VDO.
+	 */
+	.size = sizeof(struct geometry_block) + sizeof(struct volume_geometry_4_0),
+};
+
+const u8 VDO_GEOMETRY_MAGIC_NUMBER[VDO_GEOMETRY_MAGIC_NUMBER_SIZE + 1] = "dmvdo001";
+
+enum {
+	PAGE_HEADER_4_1_SIZE = 8 + 8 + 8 + 1 + 1 + 1 + 1,
+};
+
+static const struct version_number BLOCK_MAP_4_1 = {
+	.major_version = 4,
+	.minor_version = 1,
+};
+
+const struct header VDO_BLOCK_MAP_HEADER_2_0 = {
+	.id = VDO_BLOCK_MAP,
+	.version = {
+		.major_version = 2,
+		.minor_version = 0,
+	},
+	.size = sizeof(struct block_map_state_2_0),
+};
+
+const struct header VDO_RECOVERY_JOURNAL_HEADER_7_0 = {
+	.id = VDO_RECOVERY_JOURNAL,
+	.version = {
+			.major_version = 7,
+			.minor_version = 0,
+		},
+	.size = sizeof(struct recovery_journal_state_7_0),
+};
+
+const struct header VDO_SLAB_DEPOT_HEADER_2_0 = {
+	.id = VDO_SLAB_DEPOT,
+	.version = {
+		.major_version = 2,
+		.minor_version = 0,
+	},
+	.size = sizeof(struct slab_depot_state_2_0),
+};
+
+const struct header VDO_LAYOUT_HEADER_3_0 = {
+	.id = VDO_LAYOUT,
+	.version = {
+		.major_version = 3,
+		.minor_version = 0,
+	},
+	.size = sizeof(struct layout_3_0) + (sizeof(struct partition_3_0) * VDO_PARTITION_COUNT),
+};
+
+static const enum partition_id REQUIRED_PARTITIONS[] = {
+	VDO_BLOCK_MAP_PARTITION,
+	VDO_SLAB_DEPOT_PARTITION,
+	VDO_RECOVERY_JOURNAL_PARTITION,
+	VDO_SLAB_SUMMARY_PARTITION,
+};
+
+/*
+ * The current version for the data encoded in the super block. This must be changed any time there
+ * is a change to encoding of the component data of any VDO component.
+ */
+static const struct version_number VDO_COMPONENT_DATA_41_0 = {
+	.major_version = 41,
+	.minor_version = 0,
+};
+
+const struct version_number VDO_VOLUME_VERSION_67_0 = {
+	.major_version = 67,
+	.minor_version = 0,
+};
+
+static const struct header SUPER_BLOCK_HEADER_12_0 = {
+	.id = VDO_SUPER_BLOCK,
+	.version = {
+			.major_version = 12,
+			.minor_version = 0,
+		},
+
+	/* This is the minimum size, if the super block contains no components. */
+	.size = VDO_SUPER_BLOCK_FIXED_SIZE - VDO_ENCODED_HEADER_SIZE,
+};
+
+/**
+ * validate_version() - Check whether a version matches an expected version.
+ * @expected_version: The expected version.
+ * @actual_version: The version being validated.
+ * @component_name: The name of the component or the calling function (for error logging).
+ *
+ * Logs an error describing a mismatch.
+ *
+ * Return: VDO_SUCCESS             if the versions are the same,
+ *         VDO_UNSUPPORTED_VERSION if the versions don't match.
+ */
+static int __must_check validate_version(struct version_number expected_version,
+					 struct version_number actual_version,
+					 const char *component_name)
+{
+	if (!vdo_are_same_version(expected_version, actual_version))
+		return uds_log_error_strerror(VDO_UNSUPPORTED_VERSION,
+					      "%s version mismatch, expected %d.%d, got %d.%d",
+					      component_name,
+					      expected_version.major_version,
+					      expected_version.minor_version,
+					      actual_version.major_version,
+					      actual_version.minor_version);
+	return VDO_SUCCESS;
+}
+
+/**
+ * vdo_validate_header() - Check whether a header matches expectations.
+ * @expected_header: The expected header.
+ * @actual_header: The header being validated.
+ * @exact_size: If true, the size fields of the two headers must be the same, otherwise it is
+ *              required that actual_header.size >= expected_header.size.
+ * @name: The name of the component or the calling function (for error logging).
+ *
+ * Logs an error describing the first mismatch found.
+ *
+ * Return: VDO_SUCCESS             if the header meets expectations,
+ *         VDO_INCORRECT_COMPONENT if the component ids don't match,
+ *         VDO_UNSUPPORTED_VERSION if the versions or sizes don't match.
+ */
+int vdo_validate_header(const struct header *expected_header,
+			const struct header *actual_header,
+			bool exact_size,
+			const char *name)
+{
+	int result;
+
+	if (expected_header->id != actual_header->id)
+		return uds_log_error_strerror(VDO_INCORRECT_COMPONENT,
+					      "%s ID mismatch, expected %d, got %d",
+					      name,
+					      expected_header->id,
+					      actual_header->id);
+
+	result = validate_version(expected_header->version, actual_header->version, name);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	if ((expected_header->size > actual_header->size) ||
+	    (exact_size && (expected_header->size < actual_header->size)))
+		return uds_log_error_strerror(VDO_UNSUPPORTED_VERSION,
+					      "%s size mismatch, expected %zu, got %zu",
+					      name,
+					      expected_header->size,
+					      actual_header->size);
+
+	return VDO_SUCCESS;
+}
+
+static void encode_version_number(u8 *buffer, size_t *offset, struct version_number version)
+{
+	struct packed_version_number packed = vdo_pack_version_number(version);
+
+	memcpy(buffer + *offset, &packed, sizeof(packed));
+	*offset += sizeof(packed);
+}
+
+void vdo_encode_header(u8 *buffer, size_t *offset, const struct header *header)
+{
+	struct packed_header packed = vdo_pack_header(header);
+
+	memcpy(buffer + *offset, &packed, sizeof(packed));
+	*offset += sizeof(packed);
+}
+
+static void decode_version_number(u8 *buffer, size_t *offset, struct version_number *version)
+{
+	struct packed_version_number packed;
+
+	memcpy(&packed, buffer + *offset, sizeof(packed));
+	*offset += sizeof(packed);
+	*version = vdo_unpack_version_number(packed);
+}
+
+void vdo_decode_header(u8 *buffer, size_t *offset, struct header *header)
+{
+	struct packed_header packed;
+
+	memcpy(&packed, buffer + *offset, sizeof(packed));
+	*offset += sizeof(packed);
+
+	*header = vdo_unpack_header(&packed);
+}
+
+/**
+ * decode_volume_geometry() - Decode the on-disk representation of a volume geometry from a buffer.
+ * @buffer: A buffer to decode from.
+ * @offset: The offset in the buffer at which to decode.
+ * @geometry: The structure to receive the decoded fields.
+ * @version: The geometry block version to decode.
+ */
+static void
+decode_volume_geometry(u8 *buffer, size_t *offset, struct volume_geometry *geometry, u32 version)
+{
+	u32 unused, mem;
+	enum volume_region_id id;
+	nonce_t nonce;
+	block_count_t bio_offset = 0;
+	bool sparse;
+
+	/* This is for backwards compatibility. */
+	decode_u32_le(buffer, offset, &unused);
+	geometry->unused = unused;
+
+	decode_u64_le(buffer, offset, &nonce);
+	geometry->nonce = nonce;
+
+	memcpy((unsigned char *) &geometry->uuid, buffer + *offset, sizeof(uuid_t));
+	*offset += sizeof(uuid_t);
+
+	if (version > 4)
+		decode_u64_le(buffer, offset, &bio_offset);
+	geometry->bio_offset = bio_offset;
+
+	for (id = 0; id < VDO_VOLUME_REGION_COUNT; id++) {
+		physical_block_number_t start_block;
+		enum volume_region_id saved_id;
+
+		decode_u32_le(buffer, offset, &saved_id);
+		decode_u64_le(buffer, offset, &start_block);
+
+		geometry->regions[id] = (struct volume_region) {
+			.id = saved_id,
+			.start_block = start_block,
+		};
+	}
+
+	decode_u32_le(buffer, offset, &mem);
+	*offset += sizeof(u32);
+	sparse = buffer[(*offset)++];
+
+	geometry->index_config = (struct index_config) {
+		.mem = mem,
+		.sparse = sparse,
+	};
+}
+
+/**
+ * vdo_parse_geometry_block() - Decode and validate an encoded geometry block.
+ * @block: The encoded geometry block.
+ * @geometry: The structure to receive the decoded fields.
+ */
+int __must_check vdo_parse_geometry_block(u8 *block, struct volume_geometry *geometry)
+{
+	u32 checksum, saved_checksum;
+	struct header header;
+	size_t offset = 0;
+	int result;
+
+	if (memcmp(block, VDO_GEOMETRY_MAGIC_NUMBER, VDO_GEOMETRY_MAGIC_NUMBER_SIZE) != 0)
+		return VDO_BAD_MAGIC;
+	offset += VDO_GEOMETRY_MAGIC_NUMBER_SIZE;
+
+	vdo_decode_header(block, &offset, &header);
+	if (header.version.major_version <= 4)
+		result = vdo_validate_header(&GEOMETRY_BLOCK_HEADER_4_0, &header, true, __func__);
+	else
+		result = vdo_validate_header(&GEOMETRY_BLOCK_HEADER_5_0, &header, true, __func__);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	decode_volume_geometry(block, &offset, geometry, header.version.major_version);
+
+	result = ASSERT(header.size == offset + sizeof(u32),
+			"should have decoded up to the geometry checksum");
+	if (result != VDO_SUCCESS)
+		return result;
+
+	/* Decode and verify the checksum. */
+	checksum = vdo_crc32(block, offset);
+	decode_u32_le(block, &offset, &saved_checksum);
+
+	return ((checksum == saved_checksum) ? VDO_SUCCESS : VDO_CHECKSUM_MISMATCH);
+}
+
+struct block_map_page *vdo_format_block_map_page(void *buffer,
+						 nonce_t nonce,
+						 physical_block_number_t pbn,
+						 bool initialized)
+{
+	struct block_map_page *page = (struct block_map_page *) buffer;
+
+	memset(buffer, 0, VDO_BLOCK_SIZE);
+	page->version = vdo_pack_version_number(BLOCK_MAP_4_1);
+	page->header.nonce = __cpu_to_le64(nonce);
+	page->header.pbn = __cpu_to_le64(pbn);
+	page->header.initialized = initialized;
+	return page;
+}
+
+enum block_map_page_validity
+vdo_validate_block_map_page(struct block_map_page *page,
+			    nonce_t nonce,
+			    physical_block_number_t pbn)
+{
+	STATIC_ASSERT_SIZEOF(struct block_map_page_header, PAGE_HEADER_4_1_SIZE);
+
+	if (!vdo_are_same_version(BLOCK_MAP_4_1, vdo_unpack_version_number(page->version)) ||
+	    !page->header.initialized ||
+	    (nonce != __le64_to_cpu(page->header.nonce)))
+		return VDO_BLOCK_MAP_PAGE_INVALID;
+
+	if (pbn != vdo_get_block_map_page_pbn(page))
+		return VDO_BLOCK_MAP_PAGE_BAD;
+
+	return VDO_BLOCK_MAP_PAGE_VALID;
+}
+
+static int
+decode_block_map_state_2_0(u8 *buffer, size_t *offset, struct block_map_state_2_0 *state)
+{
+	size_t initial_offset;
+	block_count_t flat_page_count, root_count;
+	physical_block_number_t flat_page_origin, root_origin;
+	struct header header;
+	int result;
+
+	vdo_decode_header(buffer, offset, &header);
+	result = vdo_validate_header(&VDO_BLOCK_MAP_HEADER_2_0, &header, true, __func__);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	initial_offset = *offset;
+
+	decode_u64_le(buffer, offset, &flat_page_origin);
+	result = ASSERT(flat_page_origin == VDO_BLOCK_MAP_FLAT_PAGE_ORIGIN,
+			"Flat page origin must be %u (recorded as %llu)",
+			VDO_BLOCK_MAP_FLAT_PAGE_ORIGIN,
+			(unsigned long long) state->flat_page_origin);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	decode_u64_le(buffer, offset, &flat_page_count);
+	result = ASSERT(flat_page_count == 0,
+			"Flat page count must be 0 (recorded as %llu)",
+			(unsigned long long) state->flat_page_count);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	decode_u64_le(buffer, offset, &root_origin);
+	decode_u64_le(buffer, offset, &root_count);
+
+	result = ASSERT(VDO_BLOCK_MAP_HEADER_2_0.size == *offset - initial_offset,
+			"decoded block map component size must match header size");
+	if (result != VDO_SUCCESS)
+		return result;
+
+	*state = (struct block_map_state_2_0) {
+		.flat_page_origin = flat_page_origin,
+		.flat_page_count = flat_page_count,
+		.root_origin = root_origin,
+		.root_count = root_count,
+	};
+
+	return VDO_SUCCESS;
+}
+
+static void
+encode_block_map_state_2_0(u8 *buffer, size_t *offset, struct block_map_state_2_0 state)
+{
+	size_t initial_offset;
+
+	vdo_encode_header(buffer, offset, &VDO_BLOCK_MAP_HEADER_2_0);
+
+	initial_offset = *offset;
+	encode_u64_le(buffer, offset, state.flat_page_origin);
+	encode_u64_le(buffer, offset, state.flat_page_count);
+	encode_u64_le(buffer, offset, state.root_origin);
+	encode_u64_le(buffer, offset, state.root_count);
+
+	ASSERT_LOG_ONLY(VDO_BLOCK_MAP_HEADER_2_0.size == *offset - initial_offset,
+			"encoded block map component size must match header size");
+}
+
+/**
+ * vdo_compute_new_forest_pages() - Compute the number of pages which must be allocated at each
+ *                                  level in order to grow the forest to a new number of entries.
+ * @entries: The new number of entries the block map must address.
+ *
+ * Return: The total number of non-leaf pages required.
+ */
+block_count_t vdo_compute_new_forest_pages(root_count_t root_count,
+					   struct boundary *old_sizes,
+					   block_count_t entries,
+					   struct boundary *new_sizes)
+{
+	page_count_t leaf_pages = max(vdo_compute_block_map_page_count(entries), 1U);
+	page_count_t level_size = DIV_ROUND_UP(leaf_pages, root_count);
+	block_count_t total_pages = 0;
+	height_t height;
+
+	for (height = 0; height < VDO_BLOCK_MAP_TREE_HEIGHT; height++) {
+		block_count_t new_pages;
+
+		level_size = DIV_ROUND_UP(level_size, VDO_BLOCK_MAP_ENTRIES_PER_PAGE);
+		new_sizes->levels[height] = level_size;
+		new_pages = level_size;
+		if (old_sizes != NULL)
+			new_pages -= old_sizes->levels[height];
+		total_pages += (new_pages * root_count);
+	}
+
+	return total_pages;
+}
+
+/**
+ * encode_recovery_journal_state_7_0() - Encode the state of a recovery journal.
+ *
+ * Return: VDO_SUCCESS or an error code.
+ */
+static void
+encode_recovery_journal_state_7_0(u8 *buffer,
+				  size_t *offset,
+				  struct recovery_journal_state_7_0 state)
+{
+	size_t initial_offset;
+
+	vdo_encode_header(buffer, offset, &VDO_RECOVERY_JOURNAL_HEADER_7_0);
+
+	initial_offset = *offset;
+	encode_u64_le(buffer, offset, state.journal_start);
+	encode_u64_le(buffer, offset, state.logical_blocks_used);
+	encode_u64_le(buffer, offset, state.block_map_data_blocks);
+
+	ASSERT_LOG_ONLY(VDO_RECOVERY_JOURNAL_HEADER_7_0.size == *offset - initial_offset,
+			"encoded recovery journal component size must match header size");
+}
+
+/**
+ * decode_recovery_journal_state_7_0() - Decode the state of a recovery journal saved in a buffer.
+ * @buffer: The buffer containing the saved state.
+ * @state: A pointer to a recovery journal state to hold the result of a successful decode.
+ *
+ * Return: VDO_SUCCESS or an error code.
+ */
+static int __must_check
+decode_recovery_journal_state_7_0(u8 *buffer,
+				  size_t *offset,
+				  struct recovery_journal_state_7_0 *state)
+{
+	struct header header;
+	int result;
+	size_t initial_offset;
+	sequence_number_t journal_start;
+	block_count_t logical_blocks_used, block_map_data_blocks;
+
+	vdo_decode_header(buffer, offset, &header);
+	result = vdo_validate_header(&VDO_RECOVERY_JOURNAL_HEADER_7_0, &header, true, __func__);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	initial_offset = *offset;
+	decode_u64_le(buffer, offset, &journal_start);
+	decode_u64_le(buffer, offset, &logical_blocks_used);
+	decode_u64_le(buffer, offset, &block_map_data_blocks);
+
+	result = ASSERT(VDO_RECOVERY_JOURNAL_HEADER_7_0.size == *offset - initial_offset,
+			"decoded recovery journal component size must match header size");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	*state = (struct recovery_journal_state_7_0) {
+		.journal_start = journal_start,
+		.logical_blocks_used = logical_blocks_used,
+		.block_map_data_blocks = block_map_data_blocks,
+	};
+
+	return VDO_SUCCESS;
+}
+
+/**
+ * vdo_get_journal_operation_name() - Get the name of a journal operation.
+ * @operation: The operation to name.
+ *
+ * Return: The name of the operation.
+ */
+const char *vdo_get_journal_operation_name(enum journal_operation operation)
+{
+	switch (operation) {
+	case VDO_JOURNAL_DATA_REMAPPING:
+		return "data remapping";
+
+	case VDO_JOURNAL_BLOCK_MAP_REMAPPING:
+		return "block map remapping";
+
+	default:
+		return "unknown journal operation";
+	}
+}
+
+/**
+ * encode_slab_depot_state_2_0() - Encode the state of a slab depot into a buffer.
+ *
+ * Return: UDS_SUCCESS or an error.
+ */
+static void
+encode_slab_depot_state_2_0(u8 *buffer, size_t *offset, struct slab_depot_state_2_0 state)
+{
+	size_t initial_offset;
+
+	vdo_encode_header(buffer, offset, &VDO_SLAB_DEPOT_HEADER_2_0);
+
+	initial_offset = *offset;
+	encode_u64_le(buffer, offset, state.slab_config.slab_blocks);
+	encode_u64_le(buffer, offset, state.slab_config.data_blocks);
+	encode_u64_le(buffer, offset, state.slab_config.reference_count_blocks);
+	encode_u64_le(buffer, offset, state.slab_config.slab_journal_blocks);
+	encode_u64_le(buffer, offset, state.slab_config.slab_journal_flushing_threshold);
+	encode_u64_le(buffer, offset, state.slab_config.slab_journal_blocking_threshold);
+	encode_u64_le(buffer, offset, state.slab_config.slab_journal_scrubbing_threshold);
+	encode_u64_le(buffer, offset, state.first_block);
+	encode_u64_le(buffer, offset, state.last_block);
+	buffer[(*offset)++] = state.zone_count;
+
+	ASSERT_LOG_ONLY(VDO_SLAB_DEPOT_HEADER_2_0.size == *offset - initial_offset,
+			"encoded block map component size must match header size");
+}
+
+/**
+ * decode_slab_depot_state_2_0() - Decode slab depot component state version 2.0 from a buffer.
+ *
+ * Return: UDS_SUCCESS or an error code.
+ */
+static int
+decode_slab_depot_state_2_0(u8 *buffer, size_t *offset, struct slab_depot_state_2_0 *state)
+{
+	struct header header;
+	int result;
+	size_t initial_offset;
+	struct slab_config slab_config;
+	block_count_t count;
+	physical_block_number_t first_block, last_block;
+	zone_count_t zone_count;
+
+	vdo_decode_header(buffer, offset, &header);
+	result = vdo_validate_header(&VDO_SLAB_DEPOT_HEADER_2_0, &header, true, __func__);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	initial_offset = *offset;
+	decode_u64_le(buffer, offset, &count);
+	slab_config.slab_blocks = count;
+
+	decode_u64_le(buffer, offset, &count);
+	slab_config.data_blocks = count;
+
+	decode_u64_le(buffer, offset, &count);
+	slab_config.reference_count_blocks = count;
+
+	decode_u64_le(buffer, offset, &count);
+	slab_config.slab_journal_blocks = count;
+
+	decode_u64_le(buffer, offset, &count);
+	slab_config.slab_journal_flushing_threshold = count;
+
+	decode_u64_le(buffer, offset, &count);
+	slab_config.slab_journal_blocking_threshold = count;
+
+	decode_u64_le(buffer, offset, &count);
+	slab_config.slab_journal_scrubbing_threshold = count;
+
+	decode_u64_le(buffer, offset, &first_block);
+	decode_u64_le(buffer, offset, &last_block);
+	zone_count = buffer[(*offset)++];
+
+	result = ASSERT(VDO_SLAB_DEPOT_HEADER_2_0.size == *offset - initial_offset,
+			"decoded slab depot component size must match header size");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	*state = (struct slab_depot_state_2_0) {
+		.slab_config = slab_config,
+		.first_block = first_block,
+		.last_block = last_block,
+		.zone_count = zone_count,
+	};
+
+	return VDO_SUCCESS;
+}
+
+/**
+ * vdo_configure_slab_depot() - Configure the slab depot.
+ * @partition: The slab depot partition
+ * @slab_config: The configuration of a single slab.
+ * @zone_count: The number of zones the depot will use.
+ * @state: The state structure to be configured.
+ *
+ * Configures the slab_depot for the specified storage capacity, finding the number of data blocks
+ * that will fit and still leave room for the depot metadata, then return the saved state for that
+ * configuration.
+ *
+ * Return: VDO_SUCCESS or an error code.
+ */
+int vdo_configure_slab_depot(const struct partition *partition,
+			     struct slab_config slab_config,
+			     zone_count_t zone_count,
+			     struct slab_depot_state_2_0 *state)
+{
+	block_count_t total_slab_blocks, total_data_blocks;
+	size_t slab_count;
+	physical_block_number_t last_block;
+	block_count_t slab_size = slab_config.slab_blocks;
+
+	uds_log_debug("slabDepot %s(block_count=%llu, first_block=%llu, slab_size=%llu, zone_count=%u)",
+		      __func__,
+		      (unsigned long long) partition->count,
+		      (unsigned long long) partition->offset,
+		      (unsigned long long) slab_size,
+		      zone_count);
+
+	/* We do not allow runt slabs, so we waste up to a slab's worth. */
+	slab_count = (partition->count / slab_size);
+	if (slab_count == 0)
+		return VDO_NO_SPACE;
+
+	if (slab_count > MAX_VDO_SLABS)
+		return VDO_TOO_MANY_SLABS;
+
+	total_slab_blocks = slab_count * slab_config.slab_blocks;
+	total_data_blocks = slab_count * slab_config.data_blocks;
+	last_block = partition->offset + total_slab_blocks;
+
+	*state = (struct slab_depot_state_2_0) {
+		.slab_config = slab_config,
+		.first_block = partition->offset,
+		.last_block = last_block,
+		.zone_count = zone_count,
+	};
+
+	uds_log_debug("slab_depot last_block=%llu, total_data_blocks=%llu, slab_count=%zu, left_over=%llu",
+		      (unsigned long long) last_block,
+		      (unsigned long long) total_data_blocks,
+		      slab_count,
+		      (unsigned long long) (partition->count - (last_block - partition->offset)));
+
+	return VDO_SUCCESS;
+}
+
+/**
+ * vdo_configure_slab() - Measure and initialize the configuration to use for each slab.
+ * @slab_size: The number of blocks per slab.
+ * @slab_journal_blocks: The number of blocks for the slab journal.
+ * @slab_config: The slab configuration to initialize.
+ *
+ * Return: VDO_SUCCESS or an error code.
+ */
+int vdo_configure_slab(block_count_t slab_size,
+		       block_count_t slab_journal_blocks,
+		       struct slab_config *slab_config)
+{
+	block_count_t ref_blocks, meta_blocks, data_blocks;
+	block_count_t flushing_threshold, remaining, blocking_threshold;
+	block_count_t minimal_extra_space, scrubbing_threshold;
+
+	if (slab_journal_blocks >= slab_size)
+		return VDO_BAD_CONFIGURATION;
+
+	/*
+	 * This calculation should technically be a recurrence, but the total number of metadata
+	 * blocks is currently less than a single block of ref_counts, so we'd gain at most one
+	 * data block in each slab with more iteration.
+	 */
+	ref_blocks = vdo_get_saved_reference_count_size(slab_size - slab_journal_blocks);
+	meta_blocks = (ref_blocks + slab_journal_blocks);
+
+	/* Make sure test code hasn't configured slabs to be too small. */
+	if (meta_blocks >= slab_size)
+		return VDO_BAD_CONFIGURATION;
+
+	/*
+	 * If the slab size is very small, assume this must be a unit test and override the number
+	 * of data blocks to be a power of two (wasting blocks in the slab). Many tests need their
+	 * data_blocks fields to be the exact capacity of the configured volume, and that used to
+	 * fall out since they use a power of two for the number of data blocks, the slab size was
+	 * a power of two, and every block in a slab was a data block.
+	 *
+	 * TODO: Try to figure out some way of structuring testParameters and unit tests so this
+	 * hack isn't needed without having to edit several unit tests every time the metadata size
+	 * changes by one block.
+	 */
+	data_blocks = slab_size - meta_blocks;
+	if ((slab_size < 1024) && !is_power_of_2(data_blocks))
+		data_blocks = ((block_count_t) 1 << ilog2(data_blocks));
+
+	/*
+	 * Configure the slab journal thresholds. The flush threshold is 168 of 224 blocks in
+	 * production, or 3/4ths, so we use this ratio for all sizes.
+	 */
+	flushing_threshold = ((slab_journal_blocks * 3) + 3) / 4;
+	/*
+	 * The blocking threshold should be far enough from the flushing threshold to not produce
+	 * delays, but far enough from the end of the journal to allow multiple successive recovery
+	 * failures.
+	 */
+	remaining = slab_journal_blocks - flushing_threshold;
+	blocking_threshold = flushing_threshold + ((remaining * 5) / 7);
+	/* The scrubbing threshold should be at least 2048 entries before the end of the journal. */
+	minimal_extra_space = 1 + (MAXIMUM_VDO_USER_VIOS / VDO_SLAB_JOURNAL_FULL_ENTRIES_PER_BLOCK);
+	scrubbing_threshold = blocking_threshold;
+	if (slab_journal_blocks > minimal_extra_space)
+		scrubbing_threshold = slab_journal_blocks - minimal_extra_space;
+	if (blocking_threshold > scrubbing_threshold)
+		blocking_threshold = scrubbing_threshold;
+
+	*slab_config = (struct slab_config) {
+		.slab_blocks = slab_size,
+		.data_blocks = data_blocks,
+		.reference_count_blocks = ref_blocks,
+		.slab_journal_blocks = slab_journal_blocks,
+		.slab_journal_flushing_threshold = flushing_threshold,
+		.slab_journal_blocking_threshold = blocking_threshold,
+		.slab_journal_scrubbing_threshold = scrubbing_threshold};
+	return VDO_SUCCESS;
+}
+
+/**
+ * vdo_decode_slab_journal_entry() - Decode a slab journal entry.
+ * @block: The journal block holding the entry.
+ * @entry_count: The number of the entry.
+ *
+ * Return: The decoded entry.
+ */
+struct slab_journal_entry
+vdo_decode_slab_journal_entry(struct packed_slab_journal_block *block,
+			      journal_entry_count_t entry_count)
+{
+	struct slab_journal_entry entry =
+		vdo_unpack_slab_journal_entry(&block->payload.entries[entry_count]);
+
+	if (block->header.has_block_map_increments &&
+	    ((block->payload.full_entries.entry_types[entry_count / 8] &
+	      ((u8)1 << (entry_count % 8))) != 0))
+		entry.operation = VDO_JOURNAL_BLOCK_MAP_REMAPPING;
+
+	return entry;
+}
+
+/**
+ * allocate_partition() - Allocate a partition and add it to a layout.
+ * @layout: The layout containing the partition.
+ * @id: The id of the partition.
+ * @offset: The offset into the layout at which the partition begins.
+ * @size: The size of the partition in blocks.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+static int allocate_partition(struct layout *layout,
+			      u8 id,
+			      physical_block_number_t offset,
+			      block_count_t size)
+{
+	struct partition *partition;
+	int result;
+
+	result = UDS_ALLOCATE(1, struct partition, __func__, &partition);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	partition->id = id;
+	partition->offset = offset;
+	partition->count = size;
+	partition->next = layout->head;
+	layout->head = partition;
+
+	return VDO_SUCCESS;
+}
+
+/**
+ * make_partition() - Create a new partition from the beginning or end of the unused space in a
+ *                    layout.
+ * @layout: The layout.
+ * @id: The id of the partition to make.
+ * @size: The number of blocks to carve out; if 0, all remaining space will be used.
+ * @beginning: True if the partition should start at the beginning of the unused space.
+ *
+ * Return: A success or error code, particularly VDO_NO_SPACE if there are fewer than size blocks
+ *         remaining.
+ */
+static int __must_check
+make_partition(struct layout *layout,
+	       enum partition_id id,
+	       block_count_t size,
+	       bool beginning)
+{
+	int result;
+	physical_block_number_t offset;
+	block_count_t free_blocks = layout->last_free - layout->first_free;
+
+	if (size == 0) {
+		if (free_blocks == 0)
+			return VDO_NO_SPACE;
+		size = free_blocks;
+	} else if (size > free_blocks) {
+		return VDO_NO_SPACE;
+	}
+
+	result = vdo_get_partition(layout, id, NULL);
+	if (result != VDO_UNKNOWN_PARTITION)
+		return VDO_PARTITION_EXISTS;
+
+	offset = beginning ? layout->first_free : (layout->last_free - size);
+
+	result = allocate_partition(layout, id, offset, size);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	layout->num_partitions++;
+	if (beginning)
+		layout->first_free += size;
+	else
+		layout->last_free = layout->last_free - size;
+
+	return VDO_SUCCESS;
+}
+
+/**
+ * vdo_initialize_layout() - Lay out the partitions of a vdo.
+ * @size: The entire size of the vdo.
+ * @origin: The start of the layout on the underlying storage in blocks.
+ * @block_map_blocks: The size of the block map partition.
+ * @journal_blocks: The size of the journal partition.
+ * @summary_blocks: The size of the slab summary partition.
+ * @layout: The layout to initialize.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+int vdo_initialize_layout(block_count_t size,
+			  physical_block_number_t offset,
+			  block_count_t block_map_blocks,
+			  block_count_t journal_blocks,
+			  block_count_t summary_blocks,
+			  struct layout *layout)
+{
+	int result;
+	block_count_t necessary_size =
+		(offset + block_map_blocks + journal_blocks + summary_blocks);
+
+	if (necessary_size > size)
+		return uds_log_error_strerror(VDO_NO_SPACE, "Not enough space to make a VDO");
+
+	*layout = (struct layout) {
+		.start = offset,
+		.size = size,
+		.first_free = offset,
+		.last_free = size,
+		.num_partitions = 0,
+		.head = NULL,
+	};
+
+	result = make_partition(layout, VDO_BLOCK_MAP_PARTITION, block_map_blocks, true);
+	if (result != VDO_SUCCESS) {
+		vdo_uninitialize_layout(layout);
+		return result;
+	}
+
+	result = make_partition(layout, VDO_SLAB_SUMMARY_PARTITION, summary_blocks, false);
+	if (result != VDO_SUCCESS) {
+		vdo_uninitialize_layout(layout);
+		return result;
+	}
+
+	result = make_partition(layout, VDO_RECOVERY_JOURNAL_PARTITION, journal_blocks, false);
+	if (result != VDO_SUCCESS) {
+		vdo_uninitialize_layout(layout);
+		return result;
+	}
+
+	result = make_partition(layout, VDO_SLAB_DEPOT_PARTITION, 0, true);
+	if (result != VDO_SUCCESS)
+		vdo_uninitialize_layout(layout);
+
+	return result;
+}
+
+/**
+ * vdo_uninitialize_layout() - Clean up a layout.
+ * @layout: The layout to clean up.
+ *
+ * All partitions created by this layout become invalid pointers.
+ */
+void vdo_uninitialize_layout(struct layout *layout)
+{
+	while (layout->head != NULL) {
+		struct partition *part = layout->head;
+
+		layout->head = part->next;
+		UDS_FREE(part);
+	}
+
+	memset(layout, 0, sizeof(struct layout));
+}
+
+/**
+ * vdo_get_partition() - Get a partition by id.
+ * @layout: The layout from which to get a partition.
+ * @id: The id of the partition.
+ * @partition_ptr: A pointer to hold the partition.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+int vdo_get_partition(struct layout *layout,
+		      enum partition_id id,
+		      struct partition **partition_ptr)
+{
+	struct partition *partition;
+
+	for (partition = layout->head; partition != NULL; partition = partition->next) {
+		if (partition->id == id) {
+			if (partition_ptr != NULL)
+				*partition_ptr = partition;
+			return VDO_SUCCESS;
+		}
+	}
+
+	return VDO_UNKNOWN_PARTITION;
+}
+
+/**
+ * vdo_get_known_partition() - Get a partition by id from a validated layout.
+ * @layout: The layout from which to get a partition.
+ * @id: The id of the partition.
+ *
+ * Return: the partition
+ */
+struct partition *vdo_get_known_partition(struct layout *layout, enum partition_id id)
+{
+	struct partition *partition;
+	int result = vdo_get_partition(layout, id, &partition);
+
+	ASSERT_LOG_ONLY(result == VDO_SUCCESS, "layout has expected partition: %u", id);
+
+	return partition;
+}
+
+static void encode_layout(u8 *buffer, size_t *offset, const struct layout *layout)
+{
+	const struct partition *partition;
+	size_t initial_offset;
+	struct header header = VDO_LAYOUT_HEADER_3_0;
+
+	STATIC_ASSERT_SIZEOF(enum partition_id, sizeof(u8));
+	ASSERT_LOG_ONLY(layout->num_partitions <= U8_MAX,
+			"layout partition count must fit in a byte");
+
+	vdo_encode_header(buffer, offset, &header);
+
+	initial_offset = *offset;
+	encode_u64_le(buffer, offset, layout->first_free);
+	encode_u64_le(buffer, offset, layout->last_free);
+	buffer[(*offset)++] = layout->num_partitions;
+
+	ASSERT_LOG_ONLY(sizeof(struct layout_3_0) == *offset - initial_offset,
+			"encoded size of a layout header must match structure");
+
+	for (partition = layout->head; partition != NULL; partition = partition->next) {
+		buffer[(*offset)++] = partition->id;
+		encode_u64_le(buffer, offset, partition->offset);
+		/* This field only exists for backwards compatibility */
+		encode_u64_le(buffer, offset, 0);
+		encode_u64_le(buffer, offset, partition->count);
+	}
+
+	ASSERT_LOG_ONLY(header.size == *offset - initial_offset,
+			"encoded size of a layout must match header size");
+}
+
+static int
+decode_layout(u8 *buffer,
+	      size_t *offset,
+	      physical_block_number_t start,
+	      block_count_t size,
+	      struct layout *layout)
+{
+	struct header header;
+	struct layout_3_0 layout_header;
+	struct partition *partition;
+	size_t initial_offset;
+	physical_block_number_t first_free, last_free;
+	u8 partition_count;
+	u8 i;
+	int result;
+
+	vdo_decode_header(buffer, offset, &header);
+	/* Layout is variable size, so only do a minimum size check here. */
+	result = vdo_validate_header(&VDO_LAYOUT_HEADER_3_0, &header, false, __func__);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	initial_offset = *offset;
+	decode_u64_le(buffer, offset, &first_free);
+	decode_u64_le(buffer, offset, &last_free);
+	partition_count = buffer[(*offset)++];
+	layout_header = (struct layout_3_0) {
+		.first_free = first_free,
+		.last_free = last_free,
+		.partition_count = partition_count,
+	};
+
+	result = ASSERT(sizeof(struct layout_3_0) == *offset - initial_offset,
+			"decoded size of a layout header must match structure");
+	if (result != VDO_SUCCESS)
+		return result;
+
+	layout->start = start;
+	layout->size = size;
+	layout->first_free = layout_header.first_free;
+	layout->last_free = layout_header.last_free;
+	layout->num_partitions = layout_header.partition_count;
+
+	if (layout->num_partitions > VDO_PARTITION_COUNT)
+		return uds_log_error_strerror(VDO_UNKNOWN_PARTITION,
+					      "layout has extra partitions");
+
+	for (i = 0; i < layout->num_partitions; i++) {
+		u8 id;
+		u64 partition_offset, count;
+
+		id = buffer[(*offset)++];
+		decode_u64_le(buffer, offset, &partition_offset);
+		*offset += sizeof(u64);
+		decode_u64_le(buffer, offset, &count);
+
+		result = allocate_partition(layout, id, partition_offset, count);
+		if (result != VDO_SUCCESS) {
+			vdo_uninitialize_layout(layout);
+			return result;
+		}
+	}
+
+	/* Validate that the layout has all (and only) the required partitions */
+	for (i = 0; i < VDO_PARTITION_COUNT; i++) {
+		result = vdo_get_partition(layout, REQUIRED_PARTITIONS[i], &partition);
+		if (result != VDO_SUCCESS) {
+			vdo_uninitialize_layout(layout);
+			return uds_log_error_strerror(result,
+						      "layout is missing required partition %u",
+						      REQUIRED_PARTITIONS[i]);
+		}
+
+		start += partition->count;
+	}
+
+	if (start != size) {
+		vdo_uninitialize_layout(layout);
+		return uds_log_error_strerror(UDS_BAD_STATE, "partitions do not cover the layout");
+	}
+
+	return VDO_SUCCESS;
+}
+
+/**
+ * pack_vdo_config() - Convert a vdo_config to its packed on-disk representation.
+ * @config: The vdo config to convert.
+ *
+ * Return: The platform-independent representation of the config.
+ */
+static struct packed_vdo_config pack_vdo_config(struct vdo_config config)
+{
+	return (struct packed_vdo_config) {
+		.logical_blocks = __cpu_to_le64(config.logical_blocks),
+		.physical_blocks = __cpu_to_le64(config.physical_blocks),
+		.slab_size = __cpu_to_le64(config.slab_size),
+		.recovery_journal_size = __cpu_to_le64(config.recovery_journal_size),
+		.slab_journal_blocks = __cpu_to_le64(config.slab_journal_blocks),
+	};
+}
+
+/**
+ * pack_vdo_component() - Convert a vdo_component to its packed on-disk representation.
+ * @component: The VDO component data to convert.
+ *
+ * Return: The platform-independent representation of the component.
+ */
+static struct packed_vdo_component_41_0 pack_vdo_component(const struct vdo_component component)
+{
+	return (struct packed_vdo_component_41_0) {
+		.state = __cpu_to_le32(component.state),
+		.complete_recoveries = __cpu_to_le64(component.complete_recoveries),
+		.read_only_recoveries = __cpu_to_le64(component.read_only_recoveries),
+		.config = pack_vdo_config(component.config),
+		.nonce = __cpu_to_le64(component.nonce),
+	};
+}
+
+static void encode_vdo_component(u8 *buffer, size_t *offset, struct vdo_component component)
+{
+	struct packed_vdo_component_41_0 packed;
+
+	encode_version_number(buffer, offset, VDO_COMPONENT_DATA_41_0);
+	packed = pack_vdo_component(component);
+	memcpy(buffer + *offset, &packed, sizeof(packed));
+	*offset += sizeof(packed);
+}
+
+/**
+ * unpack_vdo_config() - Convert a packed_vdo_config to its native in-memory representation.
+ * @config: The packed vdo config to convert.
+ *
+ * Return: The native in-memory representation of the vdo config.
+ */
+static struct vdo_config unpack_vdo_config(struct packed_vdo_config config)
+{
+	return (struct vdo_config) {
+		.logical_blocks = __le64_to_cpu(config.logical_blocks),
+		.physical_blocks = __le64_to_cpu(config.physical_blocks),
+		.slab_size = __le64_to_cpu(config.slab_size),
+		.recovery_journal_size = __le64_to_cpu(config.recovery_journal_size),
+		.slab_journal_blocks = __le64_to_cpu(config.slab_journal_blocks),
+	};
+}
+
+/**
+ * unpack_vdo_component_41_0() - Convert a packed_vdo_component_41_0 to its native in-memory
+ *				 representation.
+ * @component: The packed vdo component data to convert.
+ *
+ * Return: The native in-memory representation of the component.
+ */
+static struct vdo_component
+unpack_vdo_component_41_0(struct packed_vdo_component_41_0 component)
+{
+	return (struct vdo_component) {
+		.state = __le32_to_cpu(component.state),
+		.complete_recoveries = __le64_to_cpu(component.complete_recoveries),
+		.read_only_recoveries = __le64_to_cpu(component.read_only_recoveries),
+		.config = unpack_vdo_config(component.config),
+		.nonce = __le64_to_cpu(component.nonce),
+	};
+}
+
+/**
+ * vdo_decode_component() - Decode the component data for the vdo itself out of the super block.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+static int decode_vdo_component(u8 *buffer, size_t *offset, struct vdo_component *component)
+{
+	struct version_number version;
+	struct packed_vdo_component_41_0 packed;
+	int result;
+
+	decode_version_number(buffer, offset, &version);
+	result = validate_version(version, VDO_COMPONENT_DATA_41_0, "VDO component data");
+	if (result != VDO_SUCCESS)
+		return result;
+
+	memcpy(&packed, buffer + *offset, sizeof(packed));
+	*offset += sizeof(packed);
+	*component = unpack_vdo_component_41_0(packed);
+	return VDO_SUCCESS;
+}
+
+/**
+ * vdo_validate_config() - Validate constraints on a VDO config.
+ * @config: The VDO config.
+ * @physical_block_count: The minimum block count of the underlying storage.
+ * @logical_block_count: The expected logical size of the VDO, or 0 if the logical size may be
+ *			 unspecified.
+ *
+ * Return: A success or error code.
+ */
+int vdo_validate_config(const struct vdo_config *config,
+			block_count_t physical_block_count,
+			block_count_t logical_block_count)
+{
+	struct slab_config slab_config;
+	int result;
+
+	result = ASSERT(config->slab_size > 0, "slab size unspecified");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = ASSERT(is_power_of_2(config->slab_size), "slab size must be a power of two");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = ASSERT(config->slab_size <= (1 << MAX_VDO_SLAB_BITS),
+			"slab size must be less than or equal to 2^%d",
+			MAX_VDO_SLAB_BITS);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	result = ASSERT(config->slab_journal_blocks >= MINIMUM_VDO_SLAB_JOURNAL_BLOCKS,
+			"slab journal size meets minimum size");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = ASSERT(config->slab_journal_blocks <= config->slab_size,
+			"slab journal size is within expected bound");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = vdo_configure_slab(config->slab_size, config->slab_journal_blocks, &slab_config);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	result = ASSERT((slab_config.data_blocks >= 1),
+			"slab must be able to hold at least one block");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = ASSERT(config->physical_blocks > 0, "physical blocks unspecified");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = ASSERT(config->physical_blocks <= MAXIMUM_VDO_PHYSICAL_BLOCKS,
+			"physical block count %llu exceeds maximum %llu",
+			(unsigned long long) config->physical_blocks,
+			(unsigned long long) MAXIMUM_VDO_PHYSICAL_BLOCKS);
+	if (result != UDS_SUCCESS)
+		return VDO_OUT_OF_RANGE;
+
+	if (physical_block_count != config->physical_blocks) {
+		uds_log_error("A physical size of %llu blocks was specified, not the %llu blocks configured in the vdo super block",
+			      (unsigned long long) physical_block_count,
+			      (unsigned long long) config->physical_blocks);
+		return VDO_PARAMETER_MISMATCH;
+	}
+
+	if (logical_block_count > 0) {
+		result = ASSERT((config->logical_blocks > 0), "logical blocks unspecified");
+		if (result != UDS_SUCCESS)
+			return result;
+
+		if (logical_block_count != config->logical_blocks) {
+			uds_log_error("A logical size of %llu blocks was specified, but that differs from the %llu blocks configured in the vdo super block",
+				      (unsigned long long) logical_block_count,
+				      (unsigned long long) config->logical_blocks);
+			return VDO_PARAMETER_MISMATCH;
+		}
+	}
+
+	result = ASSERT(config->logical_blocks <= MAXIMUM_VDO_LOGICAL_BLOCKS,
+			"logical blocks too large");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = ASSERT(config->recovery_journal_size > 0, "recovery journal size unspecified");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = ASSERT(is_power_of_2(config->recovery_journal_size),
+			"recovery journal size must be a power of two");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	return result;
+}
+
+/**
+ * vdo_destroy_component_states() - Clean up any allocations in a vdo_component_states.
+ * @states: The component states to destroy.
+ */
+void vdo_destroy_component_states(struct vdo_component_states *states)
+{
+	if (states == NULL)
+		return;
+
+	vdo_uninitialize_layout(&states->layout);
+}
+
+/**
+ * decode_components() - Decode the components now that we know the component data is a version we
+ *                       understand.
+ * @buffer: The buffer being decoded.
+ * @offset: The offset to start decoding from.
+ * @geometry: The vdo geometry
+ * @states: An object to hold the successfully decoded state.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+static int __must_check decode_components(u8 *buffer,
+					  size_t *offset,
+					  struct volume_geometry *geometry,
+					  struct vdo_component_states *states)
+{
+	int result;
+
+	decode_vdo_component(buffer, offset, &states->vdo);
+
+	result = decode_layout(buffer,
+			       offset,
+			       vdo_get_data_region_start(*geometry) + 1,
+			       states->vdo.config.physical_blocks,
+			       &states->layout);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	result = decode_recovery_journal_state_7_0(buffer, offset, &states->recovery_journal);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	result = decode_slab_depot_state_2_0(buffer, offset, &states->slab_depot);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	result = decode_block_map_state_2_0(buffer, offset, &states->block_map);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	ASSERT_LOG_ONLY(*offset == VDO_COMPONENT_DATA_OFFSET + VDO_COMPONENT_DATA_SIZE,
+			"All decoded component data was used");
+	return VDO_SUCCESS;
+}
+
+/**
+ * vdo_decode_component_states() - Decode the payload of a super block.
+ * @buffer: The buffer containing the encoded super block contents.
+ * @geometry: The vdo geometry
+ * @states: A pointer to hold the decoded states.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+int vdo_decode_component_states(u8 *buffer,
+				struct volume_geometry *geometry,
+				struct vdo_component_states *states)
+{
+	int result;
+	size_t offset = VDO_COMPONENT_DATA_OFFSET;
+
+	/* This is for backwards compatibility. */
+	decode_u32_le(buffer, &offset, &states->unused);
+
+	/* Check the VDO volume version */
+	decode_version_number(buffer, &offset, &states->volume_version);
+	result = validate_version(VDO_VOLUME_VERSION_67_0, states->volume_version, "volume");
+	if (result != VDO_SUCCESS)
+		return result;
+
+	result = decode_components(buffer, &offset, geometry, states);
+	if (result != VDO_SUCCESS)
+		vdo_uninitialize_layout(&states->layout);
+
+	return result;
+}
+
+/**
+ * vdo_validate_component_states() - Validate the decoded super block configuration.
+ * @states: The state decoded from the super block.
+ * @geometry_nonce: The nonce from the geometry block.
+ * @physical_size: The minimum block count of the underlying storage.
+ * @logical_size: The expected logical size of the VDO, or 0 if the logical size may be
+ *                unspecified.
+ *
+ * Return: VDO_SUCCESS or an error if the configuration is invalid.
+ */
+int vdo_validate_component_states(struct vdo_component_states *states,
+				  nonce_t geometry_nonce,
+				  block_count_t physical_size,
+				  block_count_t logical_size)
+{
+	if (geometry_nonce != states->vdo.nonce)
+		return uds_log_error_strerror(VDO_BAD_NONCE,
+					      "Geometry nonce %llu does not match superblock nonce %llu",
+					      (unsigned long long) geometry_nonce,
+					      (unsigned long long) states->vdo.nonce);
+
+	return vdo_validate_config(&states->vdo.config, physical_size, logical_size);
+}
+
+/**
+ * vdo_encode_component_states() - Encode the state of all vdo components in the super block.
+ */
+static void
+vdo_encode_component_states(u8 *buffer, size_t *offset, const struct vdo_component_states *states)
+{
+	/* This is for backwards compatibility. */
+	encode_u32_le(buffer, offset, states->unused);
+	encode_version_number(buffer, offset, states->volume_version);
+	encode_vdo_component(buffer, offset, states->vdo);
+	encode_layout(buffer, offset, &states->layout);
+	encode_recovery_journal_state_7_0(buffer, offset, states->recovery_journal);
+	encode_slab_depot_state_2_0(buffer, offset, states->slab_depot);
+	encode_block_map_state_2_0(buffer, offset, states->block_map);
+
+	ASSERT_LOG_ONLY(*offset == VDO_COMPONENT_DATA_OFFSET + VDO_COMPONENT_DATA_SIZE,
+			"All super block component data was encoded");
+}
+
+/**
+ * vdo_encode_super_block() - Encode a super block into its on-disk representation.
+ */
+void vdo_encode_super_block(u8 *buffer, struct vdo_component_states *states)
+{
+	u32 checksum;
+	struct header header = SUPER_BLOCK_HEADER_12_0;
+	size_t offset = 0;
+
+	header.size += VDO_COMPONENT_DATA_SIZE;
+	vdo_encode_header(buffer, &offset, &header);
+	vdo_encode_component_states(buffer, &offset, states);
+
+	checksum = vdo_crc32(buffer, offset);
+	encode_u32_le(buffer, &offset, checksum);
+
+	/*
+	 * Even though the buffer is a full block, to avoid the potential corruption from a torn
+	 * write, the entire encoding must fit in the first sector.
+	 */
+	ASSERT_LOG_ONLY(offset <= VDO_SECTOR_SIZE, "entire superblock must fit in one sector");
+}
+
+/**
+ * vdo_decode_super_block() - Decode a super block from its on-disk representation.
+ */
+int vdo_decode_super_block(u8 *buffer)
+{
+	struct header header;
+	int result;
+	u32 checksum, saved_checksum;
+	size_t offset = 0;
+
+	/* Decode and validate the header. */
+	vdo_decode_header(buffer, &offset, &header);
+	result = vdo_validate_header(&SUPER_BLOCK_HEADER_12_0, &header, false, __func__);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	if (header.size > VDO_COMPONENT_DATA_SIZE + sizeof(u32))
+		/*
+		 * We can't check release version or checksum until we know the content size, so we
+		 * have to assume a version mismatch on unexpected values.
+		 */
+		return uds_log_error_strerror(VDO_UNSUPPORTED_VERSION,
+					      "super block contents too large: %zu",
+					      header.size);
+
+	/* Skip past the component data for now, to verify the checksum. */
+	offset += VDO_COMPONENT_DATA_SIZE;
+
+	checksum = vdo_crc32(buffer, offset);
+	decode_u32_le(buffer, &offset, &saved_checksum);
+
+	result = ASSERT(offset == VDO_SUPER_BLOCK_FIXED_SIZE + VDO_COMPONENT_DATA_SIZE,
+			"must have decoded entire superblock payload");
+	if (result != VDO_SUCCESS)
+		return result;
+
+	return ((checksum != saved_checksum) ? VDO_CHECKSUM_MISMATCH : VDO_SUCCESS);
+}
diff --git a/drivers/md/dm-vdo/encodings.h b/drivers/md/dm-vdo/encodings.h
new file mode 100644
index 000000000000..49b849a087d3
--- /dev/null
+++ b/drivers/md/dm-vdo/encodings.h
@@ -0,0 +1,1307 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2023 Red Hat
+ */
+
+#ifndef VDO_ENCODINGS_H
+#define VDO_ENCODINGS_H
+
+#include <linux/blk_types.h>
+#include <linux/crc32.h>
+#include <linux/limits.h>
+#include <linux/uuid.h>
+
+#include "numeric.h"
+#include "uds.h"
+
+#include "constants.h"
+#include "types.h"
+
+/*
+ * An in-memory representation of a version number for versioned structures on disk.
+ *
+ * A version number consists of two portions, a major version and a minor version. Any format
+ * change which does not require an explicit upgrade step from the previous version should
+ * increment the minor version. Any format change which either requires an explicit upgrade step,
+ * or is wholly incompatible (i.e. can not be upgraded to), should increment the major version, and
+ * set the minor version to 0.
+ */
+struct version_number {
+	u32 major_version;
+	u32 minor_version;
+};
+
+/*
+ * A packed, machine-independent, on-disk representation of a version_number. Both fields are
+ * stored in little-endian byte order.
+ */
+struct packed_version_number {
+	__le32 major_version;
+	__le32 minor_version;
+} __packed;
+
+/* The registry of component ids for use in headers */
+#define VDO_SUPER_BLOCK 0
+#define VDO_LAYOUT 1
+#define VDO_RECOVERY_JOURNAL 2
+#define VDO_SLAB_DEPOT 3
+#define VDO_BLOCK_MAP 4
+#define VDO_GEOMETRY_BLOCK 5
+
+/* The header for versioned data stored on disk. */
+struct header {
+	u32 id; /* The component this is a header for */
+	struct version_number version; /* The version of the data format */
+	size_t size; /* The size of the data following this header */
+};
+
+/* A packed, machine-independent, on-disk representation of a component header. */
+struct packed_header {
+	__le32 id;
+	struct packed_version_number version;
+	__le64 size;
+} __packed;
+
+enum {
+	VDO_GEOMETRY_BLOCK_LOCATION = 0,
+	VDO_GEOMETRY_MAGIC_NUMBER_SIZE = 8,
+	VDO_DEFAULT_GEOMETRY_BLOCK_VERSION = 5,
+};
+
+struct index_config {
+	u32 mem;
+	u32 unused;
+	bool sparse;
+} __packed;
+
+enum volume_region_id {
+	VDO_INDEX_REGION = 0,
+	VDO_DATA_REGION = 1,
+	VDO_VOLUME_REGION_COUNT,
+};
+
+struct volume_region {
+	/* The ID of the region */
+	enum volume_region_id id;
+	/*
+	 * The absolute starting offset on the device. The region continues until the next region
+	 * begins.
+	 */
+	physical_block_number_t start_block;
+} __packed;
+
+struct volume_geometry {
+	/* For backwards compatibility */
+	u32 unused;
+	/* The nonce of this volume */
+	nonce_t nonce;
+	/* The uuid of this volume */
+	uuid_t uuid;
+	/* The block offset to be applied to bios */
+	block_count_t bio_offset;
+	/* The regions in ID order */
+	struct volume_region regions[VDO_VOLUME_REGION_COUNT];
+	/* The index config */
+	struct index_config index_config;
+} __packed;
+
+/* This volume geometry struct is used for sizing only */
+struct volume_geometry_4_0 {
+	/* For backwards compatibility */
+	u32 unused;
+	/* The nonce of this volume */
+	nonce_t nonce;
+	/* The uuid of this volume */
+	uuid_t uuid;
+	/* The regions in ID order */
+	struct volume_region regions[VDO_VOLUME_REGION_COUNT];
+	/* The index config */
+	struct index_config index_config;
+} __packed;
+
+extern const u8 VDO_GEOMETRY_MAGIC_NUMBER[VDO_GEOMETRY_MAGIC_NUMBER_SIZE + 1];
+
+/**
+ * DOC: Block map entries
+ *
+ * The entry for each logical block in the block map is encoded into five bytes, which saves space
+ * in both the on-disk and in-memory layouts. It consists of the 36 low-order bits of a
+ * physical_block_number_t (addressing 256 terabytes with a 4KB block size) and a 4-bit encoding of
+ * a block_mapping_state.
+ *
+ * Of the 8 high bits of the 5-byte structure:
+ *
+ * Bits 7..4: The four highest bits of the 36-bit physical block number
+ * Bits 3..0: The 4-bit block_mapping_state
+ *
+ * The following 4 bytes are the low order bytes of the physical block number, in little-endian
+ * order.
+ *
+ * Conversion functions to and from a data location are provided.
+ */
+struct block_map_entry {
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	unsigned mapping_state : 4;
+	unsigned pbn_high_nibble : 4;
+#else
+	unsigned pbn_high_nibble : 4;
+	unsigned mapping_state : 4;
+#endif
+
+	__le32 pbn_low_word;
+} __packed;
+
+struct block_map_page_header {
+	__le64 nonce;
+	__le64 pbn;
+
+	/** May be non-zero on disk */
+	u8 unused_long_word[8];
+
+	/* Whether this page has been written twice to disk */
+	bool initialized;
+
+	/* Always zero on disk */
+	u8 unused_byte1;
+
+	/* May be non-zero on disk */
+	u8 unused_byte2;
+	u8 unused_byte3;
+} __packed;
+
+struct block_map_page {
+	struct packed_version_number version;
+	struct block_map_page_header header;
+	struct block_map_entry entries[];
+} __packed;
+
+enum block_map_page_validity {
+	VDO_BLOCK_MAP_PAGE_VALID,
+	VDO_BLOCK_MAP_PAGE_INVALID,
+	/* Valid page found in the wrong location on disk */
+	VDO_BLOCK_MAP_PAGE_BAD,
+};
+
+struct block_map_state_2_0 {
+	physical_block_number_t flat_page_origin;
+	block_count_t flat_page_count;
+	physical_block_number_t root_origin;
+	block_count_t root_count;
+} __packed;
+
+struct boundary {
+	page_number_t levels[VDO_BLOCK_MAP_TREE_HEIGHT];
+};
+
+extern const struct header VDO_BLOCK_MAP_HEADER_2_0;
+
+/* The state of the recovery journal as encoded in the VDO super block. */
+struct recovery_journal_state_7_0 {
+	/** Sequence number to start the journal */
+	sequence_number_t journal_start;
+	/** Number of logical blocks used by VDO */
+	block_count_t logical_blocks_used;
+	/** Number of block map pages allocated */
+	block_count_t block_map_data_blocks;
+} __packed;
+
+extern const struct header VDO_RECOVERY_JOURNAL_HEADER_7_0;
+
+typedef u16 journal_entry_count_t;
+
+/*
+ * A recovery journal entry stores three physical locations: a data location that is the value of a
+ * single mapping in the block map tree, and the two locations of the block map pages and slots
+ * that are acquiring and releasing a reference to the location. The journal entry also stores an
+ * operation code that says whether the mapping is for a logical block or for the block map tree
+ * itself.
+ */
+struct recovery_journal_entry {
+	struct block_map_slot slot;
+	struct data_location mapping;
+	struct data_location unmapping;
+	enum journal_operation operation;
+};
+
+/* The packed, on-disk representation of a recovery journal entry. */
+struct packed_recovery_journal_entry {
+	/*
+	 * In little-endian bit order:
+	 * Bits 15..12: The four highest bits of the 36-bit physical block number of the block map
+	 * tree page
+	 * Bits 11..2: The 10-bit block map page slot number
+	 * Bit 1..0: The journal_operation of the entry (this actually only requires 1 bit, but
+	 *           it is convenient to keep the extra bit as part of this field.
+	 */
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	unsigned operation : 2;
+	unsigned slot_low : 6;
+	unsigned slot_high : 4;
+	unsigned pbn_high_nibble : 4;
+#else
+	unsigned slot_low : 6;
+	unsigned operation : 2;
+	unsigned pbn_high_nibble : 4;
+	unsigned slot_high : 4;
+#endif
+
+	/*
+	 * Bits 47..16: The 32 low-order bits of the block map page PBN, in little-endian byte
+	 * order
+	 */
+	__le32 pbn_low_word;
+
+	/*
+	 * Bits 87..48: The five-byte block map entry encoding the location that will be stored in
+	 * the block map page slot
+	 */
+	struct block_map_entry mapping;
+
+	/*
+	 * Bits 127..88: The five-byte block map entry encoding the location that was stored in the
+	 * block map page slot
+	 */
+	struct block_map_entry unmapping;
+} __packed;
+
+/* The packed, on-disk representation of an old format recovery journal entry. */
+struct packed_recovery_journal_entry_1 {
+	/*
+	 * In little-endian bit order:
+	 * Bits 15..12: The four highest bits of the 36-bit physical block number of the block map
+	 *              tree page
+	 * Bits 11..2: The 10-bit block map page slot number
+	 * Bits 1..0: The 2-bit journal_operation of the entry
+	 *
+	 */
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	unsigned operation : 2;
+	unsigned slot_low : 6;
+	unsigned slot_high : 4;
+	unsigned pbn_high_nibble : 4;
+#else
+	unsigned slot_low : 6;
+	unsigned operation : 2;
+	unsigned pbn_high_nibble : 4;
+	unsigned slot_high : 4;
+#endif
+
+	/*
+	 * Bits 47..16: The 32 low-order bits of the block map page PBN, in little-endian byte
+	 * order
+	 */
+	__le32 pbn_low_word;
+
+	/*
+	 * Bits 87..48: The five-byte block map entry encoding the location that was or will be
+	 * stored in the block map page slot
+	 */
+	struct block_map_entry block_map_entry;
+} __packed;
+
+enum journal_operation_1 {
+	VDO_JOURNAL_DATA_DECREMENT = 0,
+	VDO_JOURNAL_DATA_INCREMENT = 1,
+	VDO_JOURNAL_BLOCK_MAP_DECREMENT = 2,
+	VDO_JOURNAL_BLOCK_MAP_INCREMENT = 3,
+} __packed;
+
+struct recovery_block_header {
+	sequence_number_t block_map_head; /* Block map head sequence number */
+	sequence_number_t slab_journal_head; /* Slab journal head seq. number */
+	sequence_number_t sequence_number; /* Sequence number for this block */
+	nonce_t nonce; /* A given VDO instance's nonce */
+	block_count_t logical_blocks_used; /* Logical blocks in use */
+	block_count_t block_map_data_blocks; /* Allocated block map pages */
+	journal_entry_count_t entry_count; /* Number of entries written */
+	u8 check_byte; /* The protection check byte */
+	u8 recovery_count; /* Number of recoveries completed */
+	enum vdo_metadata_type metadata_type; /* Metadata type */
+};
+
+/*
+ * The packed, on-disk representation of a recovery journal block header. All fields are kept in
+ * little-endian byte order.
+ */
+struct packed_journal_header {
+	/* Block map head 64-bit sequence number */
+	__le64 block_map_head;
+
+	/* Slab journal head 64-bit sequence number */
+	__le64 slab_journal_head;
+
+	/* The 64-bit sequence number for this block */
+	__le64 sequence_number;
+
+	/* A given VDO instance's 64-bit nonce */
+	__le64 nonce;
+
+	/* 8-bit metadata type (should always be one for the recovery journal) */
+	u8 metadata_type;
+
+	/* 16-bit count of the entries encoded in the block */
+	__le16 entry_count;
+
+	/* 64-bit count of the logical blocks used when this block was opened */
+	__le64 logical_blocks_used;
+
+	/* 64-bit count of the block map blocks used when this block was opened */
+	__le64 block_map_data_blocks;
+
+	/* The protection check byte */
+	u8 check_byte;
+
+	/* The number of recoveries completed */
+	u8 recovery_count;
+} __packed;
+
+struct packed_journal_sector {
+	/* The protection check byte */
+	u8 check_byte;
+
+	/* The number of recoveries completed */
+	u8 recovery_count;
+
+	/* The number of entries in this sector */
+	u8 entry_count;
+
+	/* Journal entries for this sector */
+	struct packed_recovery_journal_entry entries[];
+} __packed;
+
+enum {
+	/* The number of entries in each sector (except the last) when filled */
+	RECOVERY_JOURNAL_ENTRIES_PER_SECTOR =
+		((VDO_SECTOR_SIZE - sizeof(struct packed_journal_sector)) /
+		 sizeof(struct packed_recovery_journal_entry)),
+	RECOVERY_JOURNAL_ENTRIES_PER_BLOCK = RECOVERY_JOURNAL_ENTRIES_PER_SECTOR * 7,
+	/* The number of entries in a v1 recovery journal block. */
+	RECOVERY_JOURNAL_1_ENTRIES_PER_BLOCK = 311,
+	/* The number of entries in each v1 sector (except the last) when filled */
+	RECOVERY_JOURNAL_1_ENTRIES_PER_SECTOR =
+		((VDO_SECTOR_SIZE - sizeof(struct packed_journal_sector)) /
+		 sizeof(struct packed_recovery_journal_entry_1)),
+	/* The number of entries in the last sector when a block is full */
+	RECOVERY_JOURNAL_1_ENTRIES_IN_LAST_SECTOR =
+		(RECOVERY_JOURNAL_1_ENTRIES_PER_BLOCK % RECOVERY_JOURNAL_1_ENTRIES_PER_SECTOR),
+};
+
+/* A type representing a reference count of a block. */
+typedef u8 vdo_refcount_t;
+
+/* The absolute position of an entry in a recovery journal or slab journal. */
+struct journal_point {
+	sequence_number_t sequence_number;
+	journal_entry_count_t entry_count;
+};
+
+/* A packed, platform-independent encoding of a struct journal_point. */
+struct packed_journal_point {
+	/*
+	 * The packed representation is the little-endian 64-bit representation of the low-order 48
+	 * bits of the sequence number, shifted up 16 bits, or'ed with the 16-bit entry count.
+	 *
+	 * Very long-term, the top 16 bits of the sequence number may not always be zero, as this
+	 * encoding assumes--see BZ 1523240.
+	 */
+	__le64 encoded_point;
+} __packed;
+
+/* Special vdo_refcount_t values. */
+#define EMPTY_REFERENCE_COUNT 0
+enum {
+	MAXIMUM_REFERENCE_COUNT = 254,
+	PROVISIONAL_REFERENCE_COUNT = 255,
+};
+
+enum {
+	COUNTS_PER_SECTOR =
+		((VDO_SECTOR_SIZE - sizeof(struct packed_journal_point)) / sizeof(vdo_refcount_t)),
+	COUNTS_PER_BLOCK = COUNTS_PER_SECTOR * VDO_SECTORS_PER_BLOCK,
+};
+
+/* The format of each sector of a reference_block on disk. */
+struct packed_reference_sector {
+	struct packed_journal_point commit_point;
+	vdo_refcount_t counts[COUNTS_PER_SECTOR];
+} __packed;
+
+struct packed_reference_block {
+	struct packed_reference_sector sectors[VDO_SECTORS_PER_BLOCK];
+};
+
+struct slab_depot_state_2_0 {
+	struct slab_config slab_config;
+	physical_block_number_t first_block;
+	physical_block_number_t last_block;
+	zone_count_t zone_count;
+} __packed;
+
+extern const struct header VDO_SLAB_DEPOT_HEADER_2_0;
+
+/*
+ * vdo_slab journal blocks may have one of two formats, depending upon whether or not any of the
+ * entries in the block are block map increments. Since the steady state for a VDO is that all of
+ * the necessary block map pages will be allocated, most slab journal blocks will have only data
+ * entries. Such blocks can hold more entries, hence the two formats.
+ */
+
+/* A single slab journal entry */
+struct slab_journal_entry {
+	slab_block_number sbn;
+	enum journal_operation operation;
+	bool increment;
+};
+
+/* A single slab journal entry in its on-disk form */
+typedef struct {
+	u8 offset_low8;
+	u8 offset_mid8;
+
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	unsigned offset_high7 : 7;
+	unsigned increment : 1;
+#else
+	unsigned increment : 1;
+	unsigned offset_high7 : 7;
+#endif
+} __packed packed_slab_journal_entry;
+
+/* The unpacked representation of the header of a slab journal block */
+struct slab_journal_block_header {
+	/* Sequence number for head of journal */
+	sequence_number_t head;
+	/* Sequence number for this block */
+	sequence_number_t sequence_number;
+	/* The nonce for a given VDO instance */
+	nonce_t nonce;
+	/* Recovery journal point for last entry */
+	struct journal_point recovery_point;
+	/* Metadata type */
+	enum vdo_metadata_type metadata_type;
+	/* Whether this block contains block map increments */
+	bool has_block_map_increments;
+	/* The number of entries in the block */
+	journal_entry_count_t entry_count;
+};
+
+/*
+ * The packed, on-disk representation of a slab journal block header. All fields are kept in
+ * little-endian byte order.
+ */
+struct packed_slab_journal_block_header {
+	/* 64-bit sequence number for head of journal */
+	__le64 head;
+	/* 64-bit sequence number for this block */
+	__le64 sequence_number;
+	/* Recovery journal point for the last entry, packed into 64 bits */
+	struct packed_journal_point recovery_point;
+	/* The 64-bit nonce for a given VDO instance */
+	__le64 nonce;
+	/* 8-bit metadata type (should always be two, for the slab journal) */
+	u8 metadata_type;
+	/* Whether this block contains block map increments */
+	bool has_block_map_increments;
+	/* 16-bit count of the entries encoded in the block */
+	__le16 entry_count;
+} __packed;
+
+enum {
+	VDO_SLAB_JOURNAL_PAYLOAD_SIZE =
+		VDO_BLOCK_SIZE - sizeof(struct packed_slab_journal_block_header),
+	VDO_SLAB_JOURNAL_FULL_ENTRIES_PER_BLOCK = (VDO_SLAB_JOURNAL_PAYLOAD_SIZE * 8) / 25,
+	VDO_SLAB_JOURNAL_ENTRY_TYPES_SIZE =
+		((VDO_SLAB_JOURNAL_FULL_ENTRIES_PER_BLOCK - 1) / 8) + 1,
+	VDO_SLAB_JOURNAL_ENTRIES_PER_BLOCK =
+		(VDO_SLAB_JOURNAL_PAYLOAD_SIZE / sizeof(packed_slab_journal_entry)),
+};
+
+/* The payload of a slab journal block which has block map increments */
+struct full_slab_journal_entries {
+	/* The entries themselves */
+	packed_slab_journal_entry entries[VDO_SLAB_JOURNAL_FULL_ENTRIES_PER_BLOCK];
+	/* The bit map indicating which entries are block map increments */
+	u8 entry_types[VDO_SLAB_JOURNAL_ENTRY_TYPES_SIZE];
+} __packed;
+
+typedef union {
+	/* Entries which include block map increments */
+	struct full_slab_journal_entries full_entries;
+	/* Entries which are only data updates */
+	packed_slab_journal_entry entries[VDO_SLAB_JOURNAL_ENTRIES_PER_BLOCK];
+	/* Ensure the payload fills to the end of the block */
+	u8 space[VDO_SLAB_JOURNAL_PAYLOAD_SIZE];
+} __packed slab_journal_payload;
+
+struct packed_slab_journal_block {
+	struct packed_slab_journal_block_header header;
+	slab_journal_payload payload;
+} __packed;
+
+/* The offset of a slab journal tail block. */
+typedef u8 tail_block_offset_t;
+
+struct slab_summary_entry {
+	/* Bits 7..0: The offset of the tail block within the slab journal */
+	tail_block_offset_t tail_block_offset;
+
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	/* Bits 13..8: A hint about the fullness of the slab */
+	unsigned int fullness_hint : 6;
+	/* Bit 14: Whether the ref_counts must be loaded from the layer */
+	unsigned int load_ref_counts : 1;
+	/* Bit 15: The believed cleanliness of this slab */
+	unsigned int is_dirty : 1;
+#else
+	/* Bit 15: The believed cleanliness of this slab */
+	unsigned int is_dirty : 1;
+	/* Bit 14: Whether the ref_counts must be loaded from the layer */
+	unsigned int load_ref_counts : 1;
+	/* Bits 13..8: A hint about the fullness of the slab */
+	unsigned int fullness_hint : 6;
+#endif
+} __packed;
+
+enum {
+	VDO_SLAB_SUMMARY_FULLNESS_HINT_BITS = 6,
+	VDO_SLAB_SUMMARY_ENTRIES_PER_BLOCK = VDO_BLOCK_SIZE / sizeof(struct slab_summary_entry),
+	VDO_SLAB_SUMMARY_BLOCKS_PER_ZONE = MAX_VDO_SLABS / VDO_SLAB_SUMMARY_ENTRIES_PER_BLOCK,
+	VDO_SLAB_SUMMARY_BLOCKS = VDO_SLAB_SUMMARY_BLOCKS_PER_ZONE * MAX_VDO_PHYSICAL_ZONES,
+};
+
+struct layout {
+	physical_block_number_t start;
+	block_count_t size;
+	physical_block_number_t first_free;
+	physical_block_number_t last_free;
+	size_t num_partitions;
+	struct partition *head;
+};
+
+struct partition {
+	enum partition_id id; /* The id of this partition */
+	physical_block_number_t offset; /* The offset into the layout of this partition */
+	block_count_t count; /* The number of blocks in the partition */
+	struct partition *next; /* A pointer to the next partition in the layout */
+};
+
+struct layout_3_0 {
+	physical_block_number_t first_free;
+	physical_block_number_t last_free;
+	u8 partition_count;
+} __packed;
+
+struct partition_3_0 {
+	enum partition_id id;
+	physical_block_number_t offset;
+	physical_block_number_t base; /* unused but retained for backwards compatibility */
+	block_count_t count;
+} __packed;
+
+/*
+ * The configuration of the VDO service.
+ */
+struct vdo_config {
+	block_count_t logical_blocks; /* number of logical blocks */
+	block_count_t physical_blocks; /* number of physical blocks */
+	block_count_t slab_size; /* number of blocks in a slab */
+	block_count_t recovery_journal_size; /* number of recovery journal blocks */
+	block_count_t slab_journal_blocks; /* number of slab journal blocks */
+};
+
+/* This is the structure that captures the vdo fields saved as a super block component. */
+struct vdo_component {
+	enum vdo_state state;
+	u64 complete_recoveries;
+	u64 read_only_recoveries;
+	struct vdo_config config;
+	nonce_t nonce;
+};
+
+/*
+ * A packed, machine-independent, on-disk representation of the vdo_config in the VDO component
+ * data in the super block.
+ */
+struct packed_vdo_config {
+	__le64 logical_blocks;
+	__le64 physical_blocks;
+	__le64 slab_size;
+	__le64 recovery_journal_size;
+	__le64 slab_journal_blocks;
+} __packed;
+
+/*
+ * A packed, machine-independent, on-disk representation of version 41.0 of the VDO component data
+ * in the super block.
+ */
+struct packed_vdo_component_41_0 {
+	__le32 state;
+	__le64 complete_recoveries;
+	__le64 read_only_recoveries;
+	struct packed_vdo_config config;
+	__le64 nonce;
+} __packed;
+
+/*
+ * The version of the on-disk format of a VDO volume. This should be incremented any time the
+ * on-disk representation of any VDO structure changes. Changes which require only online upgrade
+ * steps should increment the minor version. Changes which require an offline upgrade or which can
+ * not be upgraded to at all should increment the major version and set the minor version to 0.
+ */
+extern const struct version_number VDO_VOLUME_VERSION_67_0;
+
+enum {
+	VDO_ENCODED_HEADER_SIZE = sizeof(struct packed_header),
+	BLOCK_MAP_COMPONENT_ENCODED_SIZE =
+		VDO_ENCODED_HEADER_SIZE + sizeof(struct block_map_state_2_0),
+	RECOVERY_JOURNAL_COMPONENT_ENCODED_SIZE =
+		VDO_ENCODED_HEADER_SIZE + sizeof(struct recovery_journal_state_7_0),
+	SLAB_DEPOT_COMPONENT_ENCODED_SIZE =
+		VDO_ENCODED_HEADER_SIZE + sizeof(struct slab_depot_state_2_0),
+	VDO_PARTITION_COUNT = 4,
+	VDO_LAYOUT_ENCODED_SIZE = (VDO_ENCODED_HEADER_SIZE +
+				   sizeof(struct layout_3_0) +
+				   (sizeof(struct partition_3_0) * VDO_PARTITION_COUNT)),
+	VDO_SUPER_BLOCK_FIXED_SIZE = VDO_ENCODED_HEADER_SIZE + sizeof(u32),
+	VDO_MAX_COMPONENT_DATA_SIZE = VDO_SECTOR_SIZE - VDO_SUPER_BLOCK_FIXED_SIZE,
+	VDO_COMPONENT_ENCODED_SIZE =
+		(sizeof(struct packed_version_number) + sizeof(struct packed_vdo_component_41_0)),
+	VDO_COMPONENT_DATA_OFFSET = VDO_ENCODED_HEADER_SIZE,
+	VDO_COMPONENT_DATA_SIZE = (sizeof(u32) +
+				   sizeof(struct packed_version_number) +
+				   VDO_COMPONENT_ENCODED_SIZE +
+				   VDO_LAYOUT_ENCODED_SIZE +
+				   RECOVERY_JOURNAL_COMPONENT_ENCODED_SIZE +
+				   SLAB_DEPOT_COMPONENT_ENCODED_SIZE +
+				   BLOCK_MAP_COMPONENT_ENCODED_SIZE),
+};
+
+/* The entirety of the component data encoded in the VDO super block. */
+struct vdo_component_states {
+	/* For backwards compatibility */
+	u32 unused;
+
+	/* The VDO volume version */
+	struct version_number volume_version;
+
+	/* Components */
+	struct vdo_component vdo;
+	struct block_map_state_2_0 block_map;
+	struct recovery_journal_state_7_0 recovery_journal;
+	struct slab_depot_state_2_0 slab_depot;
+
+	/* Our partitioning of the underlying storage */
+	struct layout layout;
+};
+
+/**
+ * vdo_are_same_version() - Check whether two version numbers are the same.
+ * @version_a: The first version.
+ * @version_b: The second version.
+ *
+ * Return: true if the two versions are the same.
+ */
+static inline bool
+vdo_are_same_version(struct version_number version_a, struct version_number version_b)
+{
+	return ((version_a.major_version == version_b.major_version) &&
+		(version_a.minor_version == version_b.minor_version));
+}
+
+/**
+ * vdo_is_upgradable_version() - Check whether an actual version is upgradable to an expected
+ *                               version.
+ * @expected_version: The expected version.
+ * @actual_version: The version being validated.
+ *
+ * An actual version is upgradable if its major number is expected but its minor number differs,
+ * and the expected version's minor number is greater than the actual version's minor number.
+ *
+ * Return: true if the actual version is upgradable.
+ */
+static inline bool vdo_is_upgradable_version(struct version_number expected_version,
+					     struct version_number actual_version)
+{
+	return ((expected_version.major_version == actual_version.major_version) &&
+		(expected_version.minor_version > actual_version.minor_version));
+}
+
+int __must_check vdo_validate_header(const struct header *expected_header,
+				     const struct header *actual_header,
+				     bool exact_size,
+				     const char *component_name);
+
+void vdo_encode_header(u8 *buffer, size_t *offset, const struct header *header);
+void vdo_decode_header(u8 *buffer, size_t *offset, struct header *header);
+
+/**
+ * vdo_pack_version_number() - Convert a version_number to its packed on-disk representation.
+ * @version: The version number to convert.
+ *
+ * Return: the platform-independent representation of the version
+ */
+static inline struct packed_version_number vdo_pack_version_number(struct version_number version)
+{
+	return (struct packed_version_number) {
+		.major_version = __cpu_to_le32(version.major_version),
+		.minor_version = __cpu_to_le32(version.minor_version),
+	};
+}
+
+/**
+ * vdo_unpack_version_number() - Convert a packed_version_number to its native in-memory
+ *                               representation.
+ * @version: The version number to convert.
+ *
+ * Return: The platform-independent representation of the version.
+ */
+static inline struct version_number vdo_unpack_version_number(struct packed_version_number version)
+{
+	return (struct version_number) {
+		.major_version = __le32_to_cpu(version.major_version),
+		.minor_version = __le32_to_cpu(version.minor_version),
+	};
+}
+
+/**
+ * vdo_pack_header() - Convert a component header to its packed on-disk representation.
+ * @header: The header to convert.
+ *
+ * Return: the platform-independent representation of the header
+ */
+static inline struct packed_header vdo_pack_header(const struct header *header)
+{
+	return (struct packed_header) {
+		.id = __cpu_to_le32(header->id),
+		.version = vdo_pack_version_number(header->version),
+		.size = __cpu_to_le64(header->size),
+	};
+}
+
+/**
+ * vdo_unpack_header() - Convert a packed_header to its native in-memory representation.
+ * @header: The header to convert.
+ *
+ * Return: The platform-independent representation of the version.
+ */
+static inline struct header vdo_unpack_header(const struct packed_header *header)
+{
+	return (struct header) {
+		.id = __le32_to_cpu(header->id),
+		.version = vdo_unpack_version_number(header->version),
+		.size = __le64_to_cpu(header->size),
+	};
+}
+
+/**
+ * vdo_get_index_region_start() - Get the start of the index region from a geometry.
+ * @geometry: The geometry.
+ *
+ * Return: The start of the index region.
+ */
+static inline physical_block_number_t __must_check
+vdo_get_index_region_start(struct volume_geometry geometry)
+{
+	return geometry.regions[VDO_INDEX_REGION].start_block;
+}
+
+/**
+ * vdo_get_data_region_start() - Get the start of the data region from a geometry.
+ * @geometry: The geometry.
+ *
+ * Return: The start of the data region.
+ */
+static inline physical_block_number_t __must_check
+vdo_get_data_region_start(struct volume_geometry geometry)
+{
+	return geometry.regions[VDO_DATA_REGION].start_block;
+}
+
+/**
+ * vdo_get_index_region_size() - Get the size of the index region from a geometry.
+ * @geometry: The geometry.
+ *
+ * Return: The size of the index region.
+ */
+static inline physical_block_number_t __must_check
+vdo_get_index_region_size(struct volume_geometry geometry)
+{
+	return vdo_get_data_region_start(geometry) -
+		vdo_get_index_region_start(geometry);
+}
+
+int __must_check vdo_parse_geometry_block(unsigned char *block, struct volume_geometry *geometry);
+
+static inline bool vdo_is_state_compressed(const enum block_mapping_state mapping_state)
+{
+	return (mapping_state > VDO_MAPPING_STATE_UNCOMPRESSED);
+}
+
+static inline struct block_map_entry
+vdo_pack_block_map_entry(physical_block_number_t pbn, enum block_mapping_state mapping_state)
+{
+	return (struct block_map_entry) {
+		.mapping_state = (mapping_state & 0x0F),
+		.pbn_high_nibble = ((pbn >> 32) & 0x0F),
+		.pbn_low_word = __cpu_to_le32(pbn & UINT_MAX),
+	};
+}
+
+static inline struct data_location vdo_unpack_block_map_entry(const struct block_map_entry *entry)
+{
+	physical_block_number_t low32 = __le32_to_cpu(entry->pbn_low_word);
+	physical_block_number_t high4 = entry->pbn_high_nibble;
+
+	return (struct data_location) {
+		.pbn = ((high4 << 32) | low32),
+		.state = entry->mapping_state,
+	};
+}
+
+static inline bool vdo_is_mapped_location(const struct data_location *location)
+{
+	return (location->state != VDO_MAPPING_STATE_UNMAPPED);
+}
+
+static inline bool vdo_is_valid_location(const struct data_location *location)
+{
+	if (location->pbn == VDO_ZERO_BLOCK)
+		return !vdo_is_state_compressed(location->state);
+	else
+		return vdo_is_mapped_location(location);
+}
+
+static inline physical_block_number_t __must_check
+vdo_get_block_map_page_pbn(const struct block_map_page *page)
+{
+	return __le64_to_cpu(page->header.pbn);
+}
+
+struct block_map_page *vdo_format_block_map_page(void *buffer,
+						 nonce_t nonce,
+						 physical_block_number_t pbn,
+						 bool initialized);
+
+enum block_map_page_validity __must_check
+vdo_validate_block_map_page(struct block_map_page *page,
+			    nonce_t nonce,
+			    physical_block_number_t pbn);
+
+static inline page_count_t vdo_compute_block_map_page_count(block_count_t entries)
+{
+	return DIV_ROUND_UP(entries, VDO_BLOCK_MAP_ENTRIES_PER_PAGE);
+}
+
+block_count_t __must_check
+vdo_compute_new_forest_pages(root_count_t root_count,
+			     struct boundary *old_sizes,
+			     block_count_t entries,
+			     struct boundary *new_sizes);
+
+/**
+ * vdo_pack_recovery_journal_entry() - Return the packed, on-disk representation of a recovery
+ *                                     journal entry.
+ * @entry: The journal entry to pack.
+ *
+ * Return: The packed representation of the journal entry.
+ */
+static inline struct packed_recovery_journal_entry
+vdo_pack_recovery_journal_entry(const struct recovery_journal_entry *entry)
+{
+	return (struct packed_recovery_journal_entry) {
+		.operation = entry->operation,
+		.slot_low = entry->slot.slot & 0x3F,
+		.slot_high = (entry->slot.slot >> 6) & 0x0F,
+		.pbn_high_nibble = (entry->slot.pbn >> 32) & 0x0F,
+		.pbn_low_word = __cpu_to_le32(entry->slot.pbn & UINT_MAX),
+		.mapping = vdo_pack_block_map_entry(entry->mapping.pbn, entry->mapping.state),
+		.unmapping = vdo_pack_block_map_entry(entry->unmapping.pbn,
+						      entry->unmapping.state),
+	};
+}
+
+/**
+ * vdo_unpack_recovery_journal_entry() - Unpack the on-disk representation of a recovery journal
+ *                                       entry.
+ * @entry: The recovery journal entry to unpack.
+ *
+ * Return: The unpacked entry.
+ */
+static inline struct recovery_journal_entry
+vdo_unpack_recovery_journal_entry(const struct packed_recovery_journal_entry *entry)
+{
+	physical_block_number_t low32 = __le32_to_cpu(entry->pbn_low_word);
+	physical_block_number_t high4 = entry->pbn_high_nibble;
+
+	return (struct recovery_journal_entry) {
+		.operation = entry->operation,
+		.slot = {
+			.pbn = ((high4 << 32) | low32),
+			.slot = (entry->slot_low | (entry->slot_high << 6)),
+		},
+		.mapping = vdo_unpack_block_map_entry(&entry->mapping),
+		.unmapping = vdo_unpack_block_map_entry(&entry->unmapping),
+	};
+}
+
+const char * __must_check vdo_get_journal_operation_name(enum journal_operation operation);
+
+/**
+ * vdo_is_valid_recovery_journal_sector() - Determine whether the header of the given sector could
+ *                                          describe a valid sector for the given journal block
+ *                                          header.
+ * @header: The unpacked block header to compare against.
+ * @sector: The packed sector to check.
+ * @sector_number: The number of the sector being checked.
+ *
+ * Return: true if the sector matches the block header.
+ */
+static inline bool __must_check
+vdo_is_valid_recovery_journal_sector(const struct recovery_block_header *header,
+				     const struct packed_journal_sector *sector,
+				     u8 sector_number)
+{
+	if ((header->check_byte != sector->check_byte) ||
+	    (header->recovery_count != sector->recovery_count))
+		return false;
+
+	if (header->metadata_type == VDO_METADATA_RECOVERY_JOURNAL_2)
+		return sector->entry_count <= RECOVERY_JOURNAL_ENTRIES_PER_SECTOR;
+
+	if (sector_number == 7)
+		return sector->entry_count <= RECOVERY_JOURNAL_1_ENTRIES_IN_LAST_SECTOR;
+
+	return sector->entry_count <= RECOVERY_JOURNAL_1_ENTRIES_PER_SECTOR;
+}
+
+/**
+ * vdo_compute_recovery_journal_block_number() - Compute the physical block number of the recovery
+ *                                               journal block which would have a given sequence
+ *                                               number.
+ * @journal_size: The size of the journal.
+ * @sequence_number: The sequence number.
+ *
+ * Return: The pbn of the journal block which would the specified sequence number.
+ */
+static inline physical_block_number_t __must_check
+vdo_compute_recovery_journal_block_number(block_count_t journal_size,
+					  sequence_number_t sequence_number)
+{
+	/*
+	 * Since journal size is a power of two, the block number modulus can just be extracted
+	 * from the low-order bits of the sequence.
+	 */
+	return (sequence_number & (journal_size - 1));
+}
+
+/**
+ * vdo_get_journal_block_sector() - Find the recovery journal sector from the block header and
+ *                                  sector number.
+ * @header: The header of the recovery journal block.
+ * @sector_number: The index of the sector (1-based).
+ *
+ * Return: A packed recovery journal sector.
+ */
+static inline struct packed_journal_sector * __must_check
+vdo_get_journal_block_sector(struct packed_journal_header *header, int sector_number)
+{
+	char *sector_data = ((char *) header) + (VDO_SECTOR_SIZE * sector_number);
+
+	return (struct packed_journal_sector *) sector_data;
+}
+
+/**
+ * vdo_pack_recovery_block_header() - Generate the packed representation of a recovery block
+ *                                    header.
+ * @header: The header containing the values to encode.
+ * @packed: The header into which to pack the values.
+ */
+static inline void vdo_pack_recovery_block_header(const struct recovery_block_header *header,
+						  struct packed_journal_header *packed)
+{
+	*packed = (struct packed_journal_header) {
+		.block_map_head = __cpu_to_le64(header->block_map_head),
+		.slab_journal_head = __cpu_to_le64(header->slab_journal_head),
+		.sequence_number = __cpu_to_le64(header->sequence_number),
+		.nonce = __cpu_to_le64(header->nonce),
+		.logical_blocks_used = __cpu_to_le64(header->logical_blocks_used),
+		.block_map_data_blocks = __cpu_to_le64(header->block_map_data_blocks),
+		.entry_count = __cpu_to_le16(header->entry_count),
+		.check_byte = header->check_byte,
+		.recovery_count = header->recovery_count,
+		.metadata_type = header->metadata_type,
+	};
+}
+
+/**
+ * vdo_unpack_recovery_block_header() - Decode the packed representation of a recovery block
+ *                                      header.
+ * @packed: The packed header to decode.
+ *
+ * Return: The unpacked header.
+ */
+static inline struct recovery_block_header
+vdo_unpack_recovery_block_header(const struct packed_journal_header *packed)
+{
+	return (struct recovery_block_header) {
+		.block_map_head = __le64_to_cpu(packed->block_map_head),
+		.slab_journal_head = __le64_to_cpu(packed->slab_journal_head),
+		.sequence_number = __le64_to_cpu(packed->sequence_number),
+		.nonce = __le64_to_cpu(packed->nonce),
+		.logical_blocks_used = __le64_to_cpu(packed->logical_blocks_used),
+		.block_map_data_blocks = __le64_to_cpu(packed->block_map_data_blocks),
+		.entry_count = __le16_to_cpu(packed->entry_count),
+		.check_byte = packed->check_byte,
+		.recovery_count = packed->recovery_count,
+		.metadata_type = packed->metadata_type,
+	};
+}
+
+/**
+ * vdo_compute_slab_count() - Compute the number of slabs a depot with given parameters would have.
+ * @first_block: PBN of the first data block.
+ * @last_block: PBN of the last data block.
+ * @slab_size_shift: Exponent for the number of blocks per slab.
+ *
+ * Return: The number of slabs.
+ */
+static inline slab_count_t
+vdo_compute_slab_count(physical_block_number_t first_block,
+		       physical_block_number_t last_block,
+		       unsigned int slab_size_shift)
+{
+	return (slab_count_t) ((last_block - first_block) >> slab_size_shift);
+}
+
+int __must_check vdo_configure_slab_depot(const struct partition *partition,
+					  struct slab_config slab_config,
+					  zone_count_t zone_count,
+					  struct slab_depot_state_2_0 *state);
+
+int __must_check vdo_configure_slab(block_count_t slab_size,
+				    block_count_t slab_journal_blocks,
+				    struct slab_config *slab_config);
+
+/**
+ * vdo_get_saved_reference_count_size() - Get the number of blocks required to save a reference
+ *                                        counts state covering the specified number of data
+ *                                        blocks.
+ * @block_count: The number of physical data blocks that can be referenced.
+ *
+ * Return: The number of blocks required to save reference counts with the given block count.
+ */
+static inline block_count_t
+vdo_get_saved_reference_count_size(block_count_t block_count)
+{
+	return DIV_ROUND_UP(block_count, COUNTS_PER_BLOCK);
+}
+
+/**
+ * vdo_get_slab_journal_start_block() - Get the physical block number of the start of the slab
+ *                                      journal relative to the start block allocator partition.
+ * @slab_config: The slab configuration of the VDO.
+ * @origin: The first block of the slab.
+ */
+static inline physical_block_number_t __must_check
+vdo_get_slab_journal_start_block(const struct slab_config *slab_config,
+				 physical_block_number_t origin)
+{
+	return origin + slab_config->data_blocks + slab_config->reference_count_blocks;
+}
+
+/**
+ * vdo_advance_journal_point() - Move the given journal point forward by one entry.
+ * @point: The journal point to adjust.
+ * @entries_per_block: The number of entries in one full block.
+ */
+static inline void
+vdo_advance_journal_point(struct journal_point *point, journal_entry_count_t entries_per_block)
+{
+	point->entry_count++;
+	if (point->entry_count == entries_per_block) {
+		point->sequence_number++;
+		point->entry_count = 0;
+	}
+}
+
+/**
+ * vdo_before_journal_point() - Check whether the first point precedes the second point.
+ * @first: The first journal point.
+ * @second: The second journal point.
+ *
+ * Return: true if the first point precedes the second point.
+ */
+static inline bool
+vdo_before_journal_point(const struct journal_point *first, const struct journal_point *second)
+{
+	return ((first->sequence_number < second->sequence_number) ||
+		((first->sequence_number == second->sequence_number) &&
+		 (first->entry_count < second->entry_count)));
+}
+
+/**
+ * vdo_pack_journal_point() - Encode the journal location represented by a
+ *                            journal_point into a packed_journal_point.
+ * @unpacked: The unpacked input point.
+ * @packed: The packed output point.
+ */
+static inline void
+vdo_pack_journal_point(const struct journal_point *unpacked, struct packed_journal_point *packed)
+{
+	packed->encoded_point =
+		__cpu_to_le64((unpacked->sequence_number << 16) | unpacked->entry_count);
+}
+
+/**
+ * vdo_unpack_journal_point() - Decode the journal location represented by a packed_journal_point
+ *                              into a journal_point.
+ * @packed: The packed input point.
+ * @unpacked: The unpacked output point.
+ */
+static inline void
+vdo_unpack_journal_point(const struct packed_journal_point *packed, struct journal_point *unpacked)
+{
+	u64 native = __le64_to_cpu(packed->encoded_point);
+
+	unpacked->sequence_number = (native >> 16);
+	unpacked->entry_count = (native & 0xffff);
+}
+
+/**
+ * vdo_pack_slab_journal_block_header() - Generate the packed representation of a slab block
+ *                                        header.
+ * @header: The header containing the values to encode.
+ * @packed: The header into which to pack the values.
+ */
+static inline void
+vdo_pack_slab_journal_block_header(const struct slab_journal_block_header *header,
+				   struct packed_slab_journal_block_header *packed)
+{
+	packed->head = __cpu_to_le64(header->head);
+	packed->sequence_number = __cpu_to_le64(header->sequence_number);
+	packed->nonce = __cpu_to_le64(header->nonce);
+	packed->entry_count = __cpu_to_le16(header->entry_count);
+	packed->metadata_type = header->metadata_type;
+	packed->has_block_map_increments = header->has_block_map_increments;
+
+	vdo_pack_journal_point(&header->recovery_point, &packed->recovery_point);
+}
+
+/**
+ * vdo_unpack_slab_journal_block_header() - Decode the packed representation of a slab block
+ *                                          header.
+ * @packed: The packed header to decode.
+ * @header: The header into which to unpack the values.
+ */
+static inline void
+vdo_unpack_slab_journal_block_header(const struct packed_slab_journal_block_header *packed,
+				     struct slab_journal_block_header *header)
+{
+	*header = (struct slab_journal_block_header) {
+		.head = __le64_to_cpu(packed->head),
+		.sequence_number = __le64_to_cpu(packed->sequence_number),
+		.nonce = __le64_to_cpu(packed->nonce),
+		.entry_count = __le16_to_cpu(packed->entry_count),
+		.metadata_type = packed->metadata_type,
+		.has_block_map_increments = packed->has_block_map_increments,
+	};
+	vdo_unpack_journal_point(&packed->recovery_point, &header->recovery_point);
+}
+
+/**
+ * vdo_pack_slab_journal_entry() - Generate the packed encoding of a slab journal entry.
+ * @packed: The entry into which to pack the values.
+ * @sbn: The slab block number of the entry to encode.
+ * @is_increment: The increment flag.
+ */
+static inline void vdo_pack_slab_journal_entry(packed_slab_journal_entry *packed,
+					       slab_block_number sbn,
+					       bool is_increment)
+{
+	packed->offset_low8 = (sbn & 0x0000FF);
+	packed->offset_mid8 = (sbn & 0x00FF00) >> 8;
+	packed->offset_high7 = (sbn & 0x7F0000) >> 16;
+	packed->increment = is_increment ? 1 : 0;
+}
+
+/**
+ * vdo_unpack_slab_journal_entry() - Decode the packed representation of a slab journal entry.
+ * @packed: The packed entry to decode.
+ *
+ * Return: The decoded slab journal entry.
+ */
+static inline struct slab_journal_entry __must_check
+vdo_unpack_slab_journal_entry(const packed_slab_journal_entry *packed)
+{
+	struct slab_journal_entry entry;
+
+	entry.sbn = packed->offset_high7;
+	entry.sbn <<= 8;
+	entry.sbn |= packed->offset_mid8;
+	entry.sbn <<= 8;
+	entry.sbn |= packed->offset_low8;
+	entry.operation = VDO_JOURNAL_DATA_REMAPPING;
+	entry.increment = packed->increment;
+	return entry;
+}
+
+struct slab_journal_entry __must_check
+vdo_decode_slab_journal_entry(struct packed_slab_journal_block *block,
+			      journal_entry_count_t entry_count);
+
+/**
+ * vdo_get_slab_summary_hint_shift() - Compute the shift for slab summary hints.
+ * @slab_size_shift: Exponent for the number of blocks per slab.
+ *
+ * Return: The hint shift.
+ */
+static inline u8 __must_check vdo_get_slab_summary_hint_shift(unsigned int slab_size_shift)
+{
+	return ((slab_size_shift > VDO_SLAB_SUMMARY_FULLNESS_HINT_BITS) ?
+		(slab_size_shift - VDO_SLAB_SUMMARY_FULLNESS_HINT_BITS) :
+		0);
+}
+
+int __must_check vdo_initialize_layout(block_count_t size,
+				       physical_block_number_t offset,
+				       block_count_t block_map_blocks,
+				       block_count_t journal_blocks,
+				       block_count_t summary_blocks,
+				       struct layout *layout);
+
+void vdo_uninitialize_layout(struct layout *layout);
+
+int __must_check vdo_get_partition(struct layout *layout,
+				   enum partition_id id,
+				   struct partition **partition_ptr);
+
+struct partition * __must_check
+vdo_get_known_partition(struct layout *layout, enum partition_id id);
+
+int vdo_validate_config(const struct vdo_config *config,
+			block_count_t physical_block_count,
+			block_count_t logical_block_count);
+
+void vdo_destroy_component_states(struct vdo_component_states *states);
+
+int __must_check
+vdo_decode_component_states(u8 *buffer,
+			    struct volume_geometry *geometry,
+			    struct vdo_component_states *states);
+
+int __must_check
+vdo_validate_component_states(struct vdo_component_states *states,
+			      nonce_t geometry_nonce,
+			      block_count_t physical_size,
+			      block_count_t logical_size);
+
+void vdo_encode_super_block(u8 *buffer, struct vdo_component_states *states);
+int __must_check vdo_decode_super_block(u8 *buffer);
+
+/* We start with 0L and postcondition with ~0L to match our historical usage in userspace. */
+static inline u32 vdo_crc32(const void *buf, unsigned long len)
+{
+	return (crc32(0L, buf, len) ^ ~0L);
+}
+
+#endif /* VDO_ENCODINGS_H */
-- 
2.40.0

