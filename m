Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C6870E7BC
	for <lists+linux-block@lfdr.de>; Tue, 23 May 2023 23:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbjEWVqo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 May 2023 17:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbjEWVqn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 17:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EE4C5
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684878354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B2RItA0rSXvUKr6aa4OhCjfw/A32YGPyfvusFiSy9dc=;
        b=VjlqS++W81uhkeeDoL8zRgfCodcV4SjutpsUvTsyQZAB86sazqCNf3A+/wiWSShn7sZZgG
        Qu03WqNC/gcyVvMVtaUe0jqZm4TFC493Vl53Pk1mtUHQOkdYi+ScKVCv96HpCgP1/mJlCj
        0Z3/NNgVZnXYyZO/pUwTOGxCwT36PpY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-_oqADznrMniYUL3nJbvqZg-1; Tue, 23 May 2023 17:45:52 -0400
X-MC-Unique: _oqADznrMniYUL3nJbvqZg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75b02585128so30916585a.3
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878352; x=1687470352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2RItA0rSXvUKr6aa4OhCjfw/A32YGPyfvusFiSy9dc=;
        b=Osj66yea2sw+I16J+kirmbj/IKxaEvlc9BEy/TlkuK96xqMJUPqeRAkaiPCPVp9jN9
         8bEmSeqhAREud9RCG58xycdFdr5ULsKeMUb1EwXHDtFJRy6w3mxVvKU82Z94mJBeX85+
         WK0soYKcLr0BnyZgZvjD4C75Z4nL1RiQ/bHITY/Gh6Y8dXGLzpRcOHWSlfy15UwxAeE4
         AL6TlAFI5s6hr2g0v1hm9fPHbTV1PspWxo2IcRNAwIJt6bBlgHeFcPLxdIThlR4D/7Em
         SGPxrvPGSfFXE0tmAShWQxPe43BId8FHR261oK2fyLastdJcnmEARyKBEkJf83xAO/l+
         WbEA==
X-Gm-Message-State: AC+VfDy3X3TMnLgUc/GtRSqRwCkguh901RDCBzBlEYcUsnOvSBlXhuJi
        AthEFp7bGUYfpTmyBPhteQ8uJflzmSSmSA7z0EtGHjHo2ay73HhM6/n46K4VI/cP9ICZz5FK9ok
        Yf9WH7u2R8wB7GMWcUWk+/1Q=
X-Received: by 2002:a05:620a:2b4d:b0:75b:23a1:8324 with SMTP id dp13-20020a05620a2b4d00b0075b23a18324mr6822558qkb.31.1684878351741;
        Tue, 23 May 2023 14:45:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5twGK/m4USYVtMmwsAKcIaY/t3nIwgVGwMzbQBf+TE0JBvKgPouo7oA5XmiVAcvsMjtJ08wA==
X-Received: by 2002:a05:620a:2b4d:b0:75b:23a1:8324 with SMTP id dp13-20020a05620a2b4d00b0075b23a18324mr6822516qkb.31.1684878351076;
        Tue, 23 May 2023 14:45:51 -0700 (PDT)
Received: from bf36-1.. (173-166-2-198-newengland.hfc.comcastbusiness.net. [173.166.2.198])
        by smtp.gmail.com with ESMTPSA id s24-20020ae9f718000000b0074fafbea974sm2821592qkg.2.2023.05.23.14.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:45:50 -0700 (PDT)
From:   "J. corwin Coburn" <corwin@redhat.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org
Cc:     vdo-devel@redhat.com, "J. corwin Coburn" <corwin@redhat.com>
Subject: [PATCH v2 05/39] Add vdo type declarations, constants, and simple data structures.
Date:   Tue, 23 May 2023 17:45:05 -0400
Message-Id: <20230523214539.226387-6-corwin@redhat.com>
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

Signed-off-by: J. corwin Coburn <corwin@redhat.com>
---
 drivers/md/dm-vdo/constants.c        |  15 +
 drivers/md/dm-vdo/constants.h        | 102 +++++++
 drivers/md/dm-vdo/release-versions.h |  20 ++
 drivers/md/dm-vdo/status-codes.c     | 126 +++++++++
 drivers/md/dm-vdo/status-codes.h     | 112 ++++++++
 drivers/md/dm-vdo/types.h            | 403 +++++++++++++++++++++++++++
 drivers/md/dm-vdo/wait-queue.c       | 223 +++++++++++++++
 drivers/md/dm-vdo/wait-queue.h       | 129 +++++++++
 8 files changed, 1130 insertions(+)
 create mode 100644 drivers/md/dm-vdo/constants.c
 create mode 100644 drivers/md/dm-vdo/constants.h
 create mode 100644 drivers/md/dm-vdo/release-versions.h
 create mode 100644 drivers/md/dm-vdo/status-codes.c
 create mode 100644 drivers/md/dm-vdo/status-codes.h
 create mode 100644 drivers/md/dm-vdo/types.h
 create mode 100644 drivers/md/dm-vdo/wait-queue.c
 create mode 100644 drivers/md/dm-vdo/wait-queue.h

diff --git a/drivers/md/dm-vdo/constants.c b/drivers/md/dm-vdo/constants.c
new file mode 100644
index 00000000000..8bdfb782b13
--- /dev/null
+++ b/drivers/md/dm-vdo/constants.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright Red Hat
+ */
+
+#include "types.h"
+
+/* The maximum logical space is 4 petabytes, which is 1 terablock. */
+const block_count_t MAXIMUM_VDO_LOGICAL_BLOCKS = 1024ULL * 1024 * 1024 * 1024;
+
+/* The maximum physical space is 256 terabytes, which is 64 gigablocks. */
+const block_count_t MAXIMUM_VDO_PHYSICAL_BLOCKS = 1024ULL * 1024 * 1024 * 64;
+
+/* unit test minimum */
+const block_count_t MINIMUM_VDO_SLAB_JOURNAL_BLOCKS = 2;
diff --git a/drivers/md/dm-vdo/constants.h b/drivers/md/dm-vdo/constants.h
new file mode 100644
index 00000000000..7196e99efe9
--- /dev/null
+++ b/drivers/md/dm-vdo/constants.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Red Hat
+ */
+
+#ifndef VDO_CONSTANTS_H
+#define VDO_CONSTANTS_H
+
+#include <linux/blkdev.h>
+
+#include "types.h"
+
+enum {
+	/*
+	 * The maximum number of contiguous PBNs which will go to a single bio submission queue,
+	 * assuming there is more than one queue.
+	 */
+	VDO_BIO_ROTATION_INTERVAL_LIMIT = 1024,
+
+	/** The number of entries on a block map page */
+	VDO_BLOCK_MAP_ENTRIES_PER_PAGE = 812,
+
+	/** The origin of the flat portion of the block map */
+	VDO_BLOCK_MAP_FLAT_PAGE_ORIGIN = 1,
+
+	/*
+	 * The height of a block map tree. Assuming a root count of 60 and 812 entries per page,
+	 * this is big enough to represent almost 95 PB of logical space.
+	 */
+	VDO_BLOCK_MAP_TREE_HEIGHT = 5,
+
+	/** The default number of bio submission queues. */
+	DEFAULT_VDO_BIO_SUBMIT_QUEUE_COUNT = 4,
+
+	/** The number of contiguous PBNs to be submitted to a single bio queue. */
+	DEFAULT_VDO_BIO_SUBMIT_QUEUE_ROTATE_INTERVAL = 64,
+
+	/** The number of trees in the arboreal block map */
+	DEFAULT_VDO_BLOCK_MAP_TREE_ROOT_COUNT = 60,
+
+	/** The default size of the recovery journal, in blocks */
+	DEFAULT_VDO_RECOVERY_JOURNAL_SIZE = 32 * 1024,
+
+	/** The default size of each slab journal, in blocks */
+	DEFAULT_VDO_SLAB_JOURNAL_SIZE = 224,
+
+	/*
+	 * The initial size of lbn_operations and pbn_operations, which is based upon the expected
+	 * maximum number of outstanding VIOs. This value was chosen to make it highly unlikely
+	 * that the maps would need to be resized.
+	 */
+	VDO_LOCK_MAP_CAPACITY = 10000,
+
+	/** The maximum number of logical zones */
+	MAX_VDO_LOGICAL_ZONES = 60,
+
+	/** The maximum number of physical zones */
+	MAX_VDO_PHYSICAL_ZONES = 16,
+
+	/** The base-2 logarithm of the maximum blocks in one slab */
+	MAX_VDO_SLAB_BITS = 23,
+
+	/** The maximum number of slabs the slab depot supports */
+	MAX_VDO_SLABS = 8192,
+
+	/*
+	 * The maximum number of block map pages to load simultaneously during recovery or rebuild.
+	 */
+	MAXIMUM_SIMULTANEOUS_VDO_BLOCK_MAP_RESTORATION_READS = 1024,
+
+	/** The maximum number of entries in the slab summary */
+	MAXIMUM_VDO_SLAB_SUMMARY_ENTRIES = MAX_VDO_SLABS * MAX_VDO_PHYSICAL_ZONES,
+
+	/** The maximum number of total threads in a VDO thread configuration. */
+	MAXIMUM_VDO_THREADS = 100,
+
+	/** The maximum number of VIOs in the system at once */
+	MAXIMUM_VDO_USER_VIOS = 2048,
+
+	/** The only physical block size supported by VDO */
+	VDO_BLOCK_SIZE = 4096,
+
+	/** The number of sectors per block */
+	VDO_SECTORS_PER_BLOCK = (VDO_BLOCK_SIZE >> SECTOR_SHIFT),
+
+	/** The size of a sector that will not be torn */
+	VDO_SECTOR_SIZE = 512,
+
+	/** The physical block number reserved for storing the zero block */
+	VDO_ZERO_BLOCK = 0,
+};
+
+/** The maximum logical space is 4 petabytes, which is 1 terablock. */
+extern const block_count_t MAXIMUM_VDO_LOGICAL_BLOCKS;
+
+/** The maximum physical space is 256 terabytes, which is 64 gigablocks. */
+extern const block_count_t MAXIMUM_VDO_PHYSICAL_BLOCKS;
+
+/** unit test minimum */
+extern const block_count_t MINIMUM_VDO_SLAB_JOURNAL_BLOCKS;
+
+#endif /* VDO_CONSTANTS_H */
diff --git a/drivers/md/dm-vdo/release-versions.h b/drivers/md/dm-vdo/release-versions.h
new file mode 100644
index 00000000000..0abc13c04b8
--- /dev/null
+++ b/drivers/md/dm-vdo/release-versions.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Red Hat
+ */
+
+#ifndef RELEASE_VERSIONS_H
+#define RELEASE_VERSIONS_H
+
+enum {
+	VDO_OXYGEN_RELEASE_VERSION_NUMBER = 109583,
+	VDO_FLUORINE_RELEASE_VERSION_NUMBER = 115838,
+	VDO_NEON_RELEASE_VERSION_NUMBER = 120965,
+	VDO_SODIUM_RELEASE_VERSION_NUMBER = 127441,
+	VDO_MAGNESIUM_RELEASE_VERSION_NUMBER = 131337,
+	VDO_ALUMINUM_RELEASE_VERSION_NUMBER = 133524,
+	VDO_HEAD_RELEASE_VERSION_NUMBER = 0,
+	VDO_CURRENT_RELEASE_VERSION_NUMBER = VDO_HEAD_RELEASE_VERSION_NUMBER,
+};
+
+#endif /* not RELEASE_VERSIONS_H */
diff --git a/drivers/md/dm-vdo/status-codes.c b/drivers/md/dm-vdo/status-codes.c
new file mode 100644
index 00000000000..4d50229ed51
--- /dev/null
+++ b/drivers/md/dm-vdo/status-codes.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright Red Hat
+ */
+
+#include "status-codes.h"
+
+#include "errors.h"
+#include "logger.h"
+#include "permassert.h"
+#include "uds-threads.h"
+
+const struct error_info vdo_status_list[] = {
+	{ "VDO_NOT_IMPLEMENTED", "Not implemented" },
+	{ "VDO_OUT_OF_RANGE", "Out of range" },
+	{ "VDO_REF_COUNT_INVALID", "Reference count would become invalid" },
+	{ "VDO_NO_SPACE", "Out of space" },
+	{ "VDO_UNEXPECTED_EOF", "Unexpected EOF on block read" },
+	{ "VDO_BAD_CONFIGURATION", "Bad configuration option" },
+	{ "VDO_SOCKET_ERROR", "Socket error" },
+	{ "VDO_BAD_ALIGNMENT", "Mis-aligned block reference" },
+	{ "VDO_COMPONENT_BUSY", "Prior operation still in progress" },
+	{ "VDO_BAD_PAGE", "Corrupt or incorrect page" },
+	{ "VDO_UNSUPPORTED_VERSION", "Unsupported component version" },
+	{ "VDO_INCORRECT_COMPONENT", "Component id mismatch in decoder" },
+	{ "VDO_PARAMETER_MISMATCH", "Parameters have conflicting values" },
+	{ "VDO_BLOCK_SIZE_TOO_SMALL", "The block size is too small" },
+	{ "VDO_UNKNOWN_PARTITION", "No partition exists with a given id" },
+	{ "VDO_PARTITION_EXISTS", "A partition already exists with a given id" },
+	{ "VDO_NOT_READ_ONLY", "The device is not in read-only mode" },
+	{ "VDO_INCREMENT_TOO_SMALL", "Physical block growth of too few blocks" },
+	{ "VDO_CHECKSUM_MISMATCH", "Incorrect checksum" },
+	{ "VDO_RECOVERY_JOURNAL_FULL", "The recovery journal is full" },
+	{ "VDO_LOCK_ERROR", "A lock is held incorrectly" },
+	{ "VDO_READ_ONLY", "The device is in read-only mode" },
+	{ "VDO_SHUTTING_DOWN", "The device is shutting down" },
+	{ "VDO_CORRUPT_JOURNAL", "Recovery journal entries corrupted" },
+	{ "VDO_TOO_MANY_SLABS", "Exceeds maximum number of slabs supported" },
+	{ "VDO_INVALID_FRAGMENT", "Compressed block fragment is invalid" },
+	{ "VDO_RETRY_AFTER_REBUILD", "Retry operation after rebuilding finishes" },
+	{ "VDO_UNKNOWN_COMMAND", "The extended command is not known" },
+	{ "VDO_COMMAND_ERROR", "Bad extended command parameters" },
+	{ "VDO_CANNOT_DETERMINE_SIZE", "Cannot determine config sizes to fit" },
+	{ "VDO_BAD_MAPPING", "Invalid page mapping" },
+	{ "VDO_READ_CACHE_BUSY", "Read cache has no free slots" },
+	{ "VDO_BIO_CREATION_FAILED", "Bio creation failed" },
+	{ "VDO_BAD_MAGIC", "Bad magic number" },
+	{ "VDO_BAD_NONCE", "Bad nonce" },
+	{ "VDO_JOURNAL_OVERFLOW", "Journal sequence number overflow" },
+	{ "VDO_INVALID_ADMIN_STATE", "Invalid operation for current state" },
+	{ "VDO_CANT_ADD_SYSFS_NODE", "Failed to add sysfs node" },
+};
+
+static atomic_t vdo_status_codes_registered = ATOMIC_INIT(0);
+static int status_code_registration_result;
+
+static void do_status_code_registration(void)
+{
+	int result;
+
+	STATIC_ASSERT((VDO_STATUS_CODE_LAST - VDO_STATUS_CODE_BASE) ==
+		      ARRAY_SIZE(vdo_status_list));
+
+	result = uds_register_error_block("VDO Status",
+					  VDO_STATUS_CODE_BASE,
+					  VDO_STATUS_CODE_BLOCK_END,
+					  vdo_status_list,
+					  sizeof(vdo_status_list));
+	/*
+	 * The following test handles cases where libvdo is statically linked against both the test
+	 * modules and the test driver (because multiple instances of this module call their own
+	 * copy of this function once each, resulting in multiple calls to register_error_block
+	 * which is shared in libuds).
+	 */
+	if (result == UDS_DUPLICATE_NAME)
+		result = UDS_SUCCESS;
+
+	status_code_registration_result = (result == UDS_SUCCESS) ? VDO_SUCCESS : result;
+}
+
+/**
+ * vdo_register_status_codes() - Register the VDO status codes if needed.
+ * Return: A success or error code.
+ */
+int vdo_register_status_codes(void)
+{
+	uds_perform_once(&vdo_status_codes_registered, do_status_code_registration);
+	return status_code_registration_result;
+}
+
+/**
+ * vdo_map_to_system_error() - Given an error code, return a value we can return to the OS.
+ * @error: The error code to convert.
+ *
+ * The input error code may be a system-generated value (such as -EIO), an errno macro used in our
+ * code (such as EIO), or a UDS or VDO status code; the result must be something the rest of the OS
+ * can consume (negative errno values such as -EIO, in the case of the kernel).
+ *
+ * Return: A system error code value.
+ */
+int vdo_map_to_system_error(int error)
+{
+	char error_name[UDS_MAX_ERROR_NAME_SIZE];
+	char error_message[UDS_MAX_ERROR_MESSAGE_SIZE];
+
+	/* 0 is success, negative a system error code */
+	if (likely(error <= 0))
+		return error;
+	if (error < 1024)
+		return -error;
+
+	/* VDO or UDS error */
+	switch (error) {
+	case VDO_NO_SPACE:
+		return -ENOSPC;
+	case VDO_READ_ONLY:
+		return -EIO;
+	default:
+		uds_log_info("%s: mapping internal status code %d (%s: %s) to EIO",
+			     __func__,
+			     error,
+			     uds_string_error_name(error, error_name, sizeof(error_name)),
+			     uds_string_error(error, error_message, sizeof(error_message)));
+		return -EIO;
+	}
+}
diff --git a/drivers/md/dm-vdo/status-codes.h b/drivers/md/dm-vdo/status-codes.h
new file mode 100644
index 00000000000..34ad2445419
--- /dev/null
+++ b/drivers/md/dm-vdo/status-codes.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Red Hat
+ */
+
+#ifndef VDO_STATUS_CODES_H
+#define VDO_STATUS_CODES_H
+
+#include "errors.h"
+
+enum {
+	UDS_BLOCK_SIZE = UDS_ERROR_CODE_BLOCK_END - UDS_ERROR_CODE_BASE,
+	VDO_BLOCK_START = UDS_ERROR_CODE_BLOCK_END,
+	VDO_BLOCK_END = VDO_BLOCK_START + UDS_BLOCK_SIZE,
+	PRP_BLOCK_START = VDO_BLOCK_END,
+	PRP_BLOCK_END = PRP_BLOCK_START + UDS_BLOCK_SIZE,
+};
+
+/* VDO-specific status codes. */
+enum vdo_status_codes {
+	/* successful result */
+	VDO_SUCCESS,
+	/* base of all VDO errors */
+	VDO_STATUS_CODE_BASE = VDO_BLOCK_START,
+	/* we haven't written this yet */
+	VDO_NOT_IMPLEMENTED = VDO_STATUS_CODE_BASE,
+	/* input out of range */
+	VDO_OUT_OF_RANGE,
+	/* an invalid reference count would result */
+	VDO_REF_COUNT_INVALID,
+	/* a free block could not be allocated */
+	VDO_NO_SPACE,
+	/* unexpected EOF on block read */
+	VDO_UNEXPECTED_EOF,
+	/* improper or missing configuration option */
+	VDO_BAD_CONFIGURATION,
+	/* socket opening or binding problem */
+	VDO_SOCKET_ERROR,
+	/* read or write on non-aligned offset */
+	VDO_BAD_ALIGNMENT,
+	/* prior operation still in progress */
+	VDO_COMPONENT_BUSY,
+	/* page contents incorrect or corrupt data */
+	VDO_BAD_PAGE,
+	/* unsupported version of some component */
+	VDO_UNSUPPORTED_VERSION,
+	/* component id mismatch in decoder */
+	VDO_INCORRECT_COMPONENT,
+	/* parameters have conflicting values */
+	VDO_PARAMETER_MISMATCH,
+	/* the block size is too small */
+	VDO_BLOCK_SIZE_TOO_SMALL,
+	/* no partition exists with a given id */
+	VDO_UNKNOWN_PARTITION,
+	/* a partition already exists with a given id */
+	VDO_PARTITION_EXISTS,
+	/* the VDO is not in read-only mode */
+	VDO_NOT_READ_ONLY,
+	/* physical block growth of too few blocks */
+	VDO_INCREMENT_TOO_SMALL,
+	/* incorrect checksum */
+	VDO_CHECKSUM_MISMATCH,
+	/* the recovery journal is full */
+	VDO_RECOVERY_JOURNAL_FULL,
+	/* a lock is held incorrectly */
+	VDO_LOCK_ERROR,
+	/* the VDO is in read-only mode */
+	VDO_READ_ONLY,
+	/* the VDO is shutting down */
+	VDO_SHUTTING_DOWN,
+	/* the recovery journal has corrupt entries */
+	VDO_CORRUPT_JOURNAL,
+	/* exceeds maximum number of slabs supported */
+	VDO_TOO_MANY_SLABS,
+	/* a compressed block fragment is invalid */
+	VDO_INVALID_FRAGMENT,
+	/* action is unsupported while rebuilding */
+	VDO_RETRY_AFTER_REBUILD,
+	/* the extended command is not known */
+	VDO_UNKNOWN_COMMAND,
+	/* bad extended command parameters */
+	VDO_COMMAND_ERROR,
+	/* cannot determine sizes to fit */
+	VDO_CANNOT_DETERMINE_SIZE,
+	/* a block map entry is invalid */
+	VDO_BAD_MAPPING,
+	/* read cache has no free slots */
+	VDO_READ_CACHE_BUSY,
+	/* bio_add_page failed */
+	VDO_BIO_CREATION_FAILED,
+	/* bad magic number */
+	VDO_BAD_MAGIC,
+	/* bad nonce */
+	VDO_BAD_NONCE,
+	/* sequence number overflow */
+	VDO_JOURNAL_OVERFLOW,
+	/* the VDO is not in a state to perform an admin operation */
+	VDO_INVALID_ADMIN_STATE,
+	/* failure adding a sysfs node */
+	VDO_CANT_ADD_SYSFS_NODE,
+	/* one more than last error code */
+	VDO_STATUS_CODE_LAST,
+	VDO_STATUS_CODE_BLOCK_END = VDO_BLOCK_END
+};
+
+extern const struct error_info vdo_status_list[];
+
+int vdo_register_status_codes(void);
+
+int vdo_map_to_system_error(int error);
+
+#endif /* VDO_STATUS_CODES_H */
diff --git a/drivers/md/dm-vdo/types.h b/drivers/md/dm-vdo/types.h
new file mode 100644
index 00000000000..a8ab9a83587
--- /dev/null
+++ b/drivers/md/dm-vdo/types.h
@@ -0,0 +1,403 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Red Hat
+ */
+
+#ifndef VDO_TYPES_H
+#define VDO_TYPES_H
+
+#include <linux/bio.h>
+#include <linux/blkdev.h>
+#include <linux/device-mapper.h>
+#include <linux/list.h>
+#include <linux/compiler_attributes.h>
+#include <linux/types.h>
+
+#include "funnel-queue.h"
+
+/* A size type in blocks. */
+typedef u64 block_count_t;
+
+/* The size of a block. */
+typedef u16 block_size_t;
+
+/* A counter for data_vios */
+typedef u16 data_vio_count_t;
+
+/* A height within a tree. */
+typedef u8 height_t;
+
+/* The logical block number as used by the consumer. */
+typedef u64 logical_block_number_t;
+
+/* The type of the nonce used to identify instances of VDO. */
+typedef u64 nonce_t;
+
+/* A size in pages. */
+typedef u32 page_count_t;
+
+/* A page number. */
+typedef u32 page_number_t;
+
+/*
+ * The physical (well, less logical) block number at which the block is found on the underlying
+ * device.
+ */
+typedef u64 physical_block_number_t;
+
+/*
+ * A release version number. These numbers are used to make the numbering space for component
+ * versions independent across release branches.
+ *
+ * Really an enum, but we have to specify the size for encoding; see release_versions.h for the
+ * enumeration values.
+ */
+typedef u32 release_version_number_t;
+
+/* A count of tree roots. */
+typedef u8 root_count_t;
+
+/* A number of sectors. */
+typedef u8 sector_count_t;
+
+/* A sequence number. */
+typedef u64 sequence_number_t;
+
+/* The offset of a block within a slab. */
+typedef u32 slab_block_number;
+
+/* A size type in slabs. */
+typedef u16 slab_count_t;
+
+/* A slot in a bin or block map page. */
+typedef u16 slot_number_t;
+
+/* typedef thread_count_t - A thread counter. */
+typedef u8 thread_count_t;
+
+/* typedef thread_id_t - A thread ID, vdo threads are numbered sequentially from 0. */
+typedef u8 thread_id_t;
+
+/* A zone counter */
+typedef u8 zone_count_t;
+
+/* The following enums are persisted on storage, so the values must be preserved. */
+
+/* The current operating mode of the VDO. */
+enum vdo_state {
+	VDO_DIRTY = 0,
+	VDO_NEW = 1,
+	VDO_CLEAN = 2,
+	VDO_READ_ONLY_MODE = 3,
+	VDO_FORCE_REBUILD = 4,
+	VDO_RECOVERING = 5,
+	VDO_REPLAYING = 6, /* VDO_REPLAYING is never set anymore, but retained for upgrade */
+	VDO_REBUILD_FOR_UPGRADE = 7,
+
+	/* Keep VDO_STATE_COUNT at the bottom. */
+	VDO_STATE_COUNT
+};
+
+/**
+ * vdo_state_requires_read_only_rebuild() - Check whether a vdo_state indicates
+ * that a read-only rebuild is required.
+ * @state: The vdo_state to check.
+ *
+ * Return: true if the state indicates a rebuild is required
+ */
+static inline bool __must_check vdo_state_requires_read_only_rebuild(enum vdo_state state)
+{
+	return ((state == VDO_FORCE_REBUILD) || (state == VDO_REBUILD_FOR_UPGRADE));
+}
+
+/**
+ * vdo_state_requires_recovery() - Check whether a vdo state indicates that recovery is needed.
+ * @state: The state to check.
+ *
+ * Return: true if the state indicates a recovery is required
+ */
+static inline bool __must_check vdo_state_requires_recovery(enum vdo_state state)
+{
+	return ((state == VDO_DIRTY) || (state == VDO_REPLAYING) || (state == VDO_RECOVERING));
+}
+
+/*
+ * The current operation on a physical block (from the point of view of the recovery journal, slab
+ * journals, and reference counts.
+ */
+enum journal_operation {
+	VDO_JOURNAL_DATA_REMAPPING = 0,
+	VDO_JOURNAL_BLOCK_MAP_REMAPPING = 1,
+} __packed;
+
+/* Partition IDs encoded in the volume layout in the super block. */
+enum partition_id {
+	VDO_BLOCK_MAP_PARTITION = 0,
+	VDO_SLAB_DEPOT_PARTITION = 1,
+	VDO_RECOVERY_JOURNAL_PARTITION = 2,
+	VDO_SLAB_SUMMARY_PARTITION = 3,
+} __packed;
+
+/* Metadata types for the vdo. */
+enum vdo_metadata_type {
+	VDO_METADATA_RECOVERY_JOURNAL = 1,
+	VDO_METADATA_SLAB_JOURNAL = 2,
+	VDO_METADATA_RECOVERY_JOURNAL_2 = 3,
+} __packed;
+
+/* A position in the block map where a block map entry is stored. */
+struct block_map_slot {
+	physical_block_number_t pbn;
+	slot_number_t slot;
+};
+
+/*
+ * Four bits of each five-byte block map entry contain a mapping state value used to distinguish
+ * unmapped or trimmed logical blocks (which are treated as mapped to the zero block) from entries
+ * that have been mapped to a physical block, including the zero block.
+ *
+ * FIXME: these should maybe be defines.
+ */
+enum block_mapping_state {
+	VDO_MAPPING_STATE_UNMAPPED = 0, /* Must be zero to be the default value */
+	VDO_MAPPING_STATE_UNCOMPRESSED = 1, /* A normal (uncompressed) block */
+	VDO_MAPPING_STATE_COMPRESSED_BASE = 2, /* Compressed in slot 0 */
+	VDO_MAPPING_STATE_COMPRESSED_MAX = 15, /* Compressed in slot 13 */
+};
+
+enum {
+	VDO_MAX_COMPRESSION_SLOTS =
+		(VDO_MAPPING_STATE_COMPRESSED_MAX - VDO_MAPPING_STATE_COMPRESSED_BASE + 1),
+};
+
+
+struct data_location {
+	physical_block_number_t pbn;
+	enum block_mapping_state state;
+};
+
+/* The configuration of a single slab derived from the configured block size and slab size. */
+struct slab_config {
+	/* total number of blocks in the slab */
+	block_count_t slab_blocks;
+	/* number of blocks available for data */
+	block_count_t data_blocks;
+	/* number of blocks for reference counts */
+	block_count_t reference_count_blocks;
+	/* number of blocks for the slab journal */
+	block_count_t slab_journal_blocks;
+	/*
+	 * Number of blocks after which the slab journal starts pushing out a reference_block for
+	 * each new entry it receives.
+	 */
+	block_count_t slab_journal_flushing_threshold;
+	/*
+	 * Number of blocks after which the slab journal pushes out all reference_blocks and makes
+	 * all vios wait.
+	 */
+	block_count_t slab_journal_blocking_threshold;
+	/* Number of blocks after which the slab must be scrubbed before coming online. */
+	block_count_t slab_journal_scrubbing_threshold;
+} __packed;
+
+/*
+ * This structure is memcmp'd for equality. Keep it packed and don't add any fields that are not
+ * properly set in both extant and parsed configs.
+ */
+struct thread_count_config {
+	unsigned int bio_ack_threads;
+	unsigned int bio_threads;
+	unsigned int bio_rotation_interval;
+	unsigned int cpu_threads;
+	unsigned int logical_zones;
+	unsigned int physical_zones;
+	unsigned int hash_zones;
+} __packed;
+
+struct device_config {
+	struct dm_target *owning_target;
+	struct dm_dev *owned_device;
+	struct vdo *vdo;
+	/* All configs referencing a layer are kept on a list in the layer */
+	struct list_head config_list;
+	char *original_string;
+	unsigned int version;
+	char *parent_device_name;
+	block_count_t physical_blocks;
+	/*
+	 * This is the number of logical blocks from VDO's internal point of view. It is the number
+	 * of 4K blocks regardless of the value of the logical_block_size parameter below.
+	 */
+	block_count_t logical_blocks;
+	unsigned int logical_block_size;
+	unsigned int cache_size;
+	unsigned int block_map_maximum_age;
+	bool deduplication;
+	bool compression;
+	struct thread_count_config thread_counts;
+	block_count_t max_discard_blocks;
+};
+
+enum vdo_completion_type {
+	/* Keep VDO_UNSET_COMPLETION_TYPE at the top. */
+	VDO_UNSET_COMPLETION_TYPE,
+	VDO_ACTION_COMPLETION,
+	VDO_ADMIN_COMPLETION,
+	VDO_BLOCK_ALLOCATOR_COMPLETION,
+	VDO_DATA_VIO_POOL_COMPLETION,
+	VDO_DECREMENT_COMPLETION,
+	VDO_FLUSH_COMPLETION,
+	VDO_FLUSH_NOTIFICATION_COMPLETION,
+	VDO_GENERATION_FLUSHED_COMPLETION,
+	VDO_HASH_ZONE_COMPLETION,
+	VDO_HASH_ZONES_COMPLETION,
+	VDO_LOCK_COUNTER_COMPLETION,
+	VDO_PAGE_COMPLETION,
+	VDO_READ_ONLY_MODE_COMPLETION,
+	VDO_REPAIR_COMPLETION,
+	VDO_SYNC_COMPLETION,
+	VIO_COMPLETION,
+} __packed;
+
+struct vdo_completion;
+
+/**
+ * typedef vdo_action - An asynchronous VDO operation.
+ * @completion: The completion of the operation.
+ */
+typedef void vdo_action(struct vdo_completion *completion);
+
+enum vdo_completion_priority {
+	BIO_ACK_Q_ACK_PRIORITY = 0,
+	BIO_ACK_Q_MAX_PRIORITY = 0,
+	BIO_Q_COMPRESSED_DATA_PRIORITY = 0,
+	BIO_Q_DATA_PRIORITY = 0,
+	BIO_Q_FLUSH_PRIORITY = 2,
+	BIO_Q_HIGH_PRIORITY = 2,
+	BIO_Q_METADATA_PRIORITY = 1,
+	BIO_Q_VERIFY_PRIORITY = 1,
+	BIO_Q_MAX_PRIORITY = 2,
+	CPU_Q_COMPLETE_VIO_PRIORITY = 0,
+	CPU_Q_COMPLETE_READ_PRIORITY = 0,
+	CPU_Q_COMPRESS_BLOCK_PRIORITY = 0,
+	CPU_Q_EVENT_REPORTER_PRIORITY = 0,
+	CPU_Q_HASH_BLOCK_PRIORITY = 0,
+	CPU_Q_MAX_PRIORITY = 0,
+	UDS_Q_PRIORITY = 0,
+	UDS_Q_MAX_PRIORITY = 0,
+	VDO_DEFAULT_Q_COMPLETION_PRIORITY = 1,
+	VDO_DEFAULT_Q_FLUSH_PRIORITY = 2,
+	VDO_DEFAULT_Q_MAP_BIO_PRIORITY = 0,
+	VDO_DEFAULT_Q_SYNC_PRIORITY = 2,
+	VDO_DEFAULT_Q_VIO_CALLBACK_PRIORITY = 1,
+	VDO_DEFAULT_Q_MAX_PRIORITY = 2,
+	/* The maximum allowable priority */
+	VDO_WORK_Q_MAX_PRIORITY = 2,
+	/* A value which must be out of range for a valid priority */
+	VDO_WORK_Q_DEFAULT_PRIORITY = VDO_WORK_Q_MAX_PRIORITY + 1,
+};
+
+struct vdo_completion {
+	/* The type of completion this is */
+	enum vdo_completion_type type;
+
+	/*
+	 * <code>true</code> once the processing of the operation is complete. This flag should not
+	 * be used by waiters external to the VDO base as it is used to gate calling the callback.
+	 */
+	bool complete;
+
+	/*
+	 * If true, queue this completion on the next callback invocation, even if it is already
+	 * running on the correct thread.
+	 */
+	bool requeue;
+
+	/* The ID of the thread which should run the next callback */
+	thread_id_t callback_thread_id;
+
+	/* The result of the operation */
+	int result;
+
+	/* The VDO on which this completion operates */
+	struct vdo *vdo;
+
+	/* The callback which will be called once the operation is complete */
+	vdo_action *callback;
+
+	/* Callback which, if set, will be called if an error result is set */
+	vdo_action *error_handler;
+
+	/* The parent object, if any, that spawned this completion */
+	void *parent;
+
+	/* Entry link for lock-free work queue */
+	struct funnel_queue_entry work_queue_entry_link;
+	enum vdo_completion_priority priority;
+	struct vdo_work_queue *my_queue;
+	u64 enqueue_time;
+};
+
+struct block_allocator;
+struct data_vio;
+struct vdo;
+struct vdo_config;
+
+/* vio types for statistics and instrumentation. */
+enum vio_type {
+	VIO_TYPE_UNINITIALIZED = 0,
+	VIO_TYPE_DATA,
+	VIO_TYPE_BLOCK_ALLOCATOR,
+	VIO_TYPE_BLOCK_MAP,
+	VIO_TYPE_BLOCK_MAP_INTERIOR,
+	VIO_TYPE_GEOMETRY,
+	VIO_TYPE_PARTITION_COPY,
+	VIO_TYPE_RECOVERY_JOURNAL,
+	VIO_TYPE_SLAB_JOURNAL,
+	VIO_TYPE_SLAB_SUMMARY,
+	VIO_TYPE_SUPER_BLOCK,
+} __packed;
+
+/* Priority levels for asynchronous I/O operations performed on a vio. */
+enum vio_priority {
+	VIO_PRIORITY_LOW = 0,
+	VIO_PRIORITY_DATA = VIO_PRIORITY_LOW,
+	VIO_PRIORITY_COMPRESSED_DATA = VIO_PRIORITY_DATA,
+	VIO_PRIORITY_METADATA,
+	VIO_PRIORITY_HIGH,
+} __packed;
+
+/*
+ * A wrapper for a bio. All I/O to the storage below a vdo is conducted via vios.
+ */
+struct vio {
+	/* The completion for this vio */
+	struct vdo_completion completion;
+
+	/* The bio zone in which I/O should be processed */
+	zone_count_t bio_zone;
+
+	/* The queueing priority of the vio operation */
+	enum vio_priority priority;
+
+	/* The vio type is used for statistics and instrumentation. */
+	enum vio_type type;
+
+	/* The size of this vio in blocks */
+	unsigned int block_count;
+
+	/* The data being read or written. */
+	char *data;
+
+	/* The VDO-owned bio to use for all IO for this vio */
+	struct bio *bio;
+
+	/*
+	 * A list of enqueued bios with consecutive block numbers, stored by vdo_submit_bio() under
+	 * the first-enqueued vio. The other vios are found via their bio entries in this list, and
+	 * are not added to the work queue as separate completions.
+	 */
+	struct bio_list bios_merged;
+};
+
+#endif /* VDO_TYPES_H */
diff --git a/drivers/md/dm-vdo/wait-queue.c b/drivers/md/dm-vdo/wait-queue.c
new file mode 100644
index 00000000000..4048c11c3e5
--- /dev/null
+++ b/drivers/md/dm-vdo/wait-queue.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright Red Hat
+ */
+
+#include "wait-queue.h"
+
+#include <linux/device-mapper.h>
+
+#include "permassert.h"
+
+#include "status-codes.h"
+
+/**
+ * vdo_enqueue_waiter() - Add a waiter to the tail end of a wait queue.
+ * @queue: The queue to which to add the waiter.
+ * @waiter: The waiter to add to the queue.
+ *
+ * The waiter must not already be waiting in a queue.
+ *
+ * Return: VDO_SUCCESS or an error code.
+ */
+void vdo_enqueue_waiter(struct wait_queue *queue, struct waiter *waiter)
+{
+	BUG_ON(waiter->next_waiter != NULL);
+
+	if (queue->last_waiter == NULL) {
+		/*
+		 * The queue is empty, so form the initial circular list by self-linking the
+		 * initial waiter.
+		 */
+		waiter->next_waiter = waiter;
+	} else {
+		/* Splice the new waiter in at the end of the queue. */
+		waiter->next_waiter = queue->last_waiter->next_waiter;
+		queue->last_waiter->next_waiter = waiter;
+	}
+
+	/* In both cases, the waiter we added to the ring becomes the last waiter. */
+	queue->last_waiter = waiter;
+	queue->queue_length += 1;
+}
+
+/**
+ * vdo_transfer_all_waiters() - Transfer all waiters from one wait queue to a second queue,
+ *                              emptying the first queue.
+ * @from_queue: The queue containing the waiters to move.
+ * @to_queue: The queue that will receive the waiters from the first queue.
+ */
+void vdo_transfer_all_waiters(struct wait_queue *from_queue, struct wait_queue *to_queue)
+{
+	/* If the source queue is empty, there's nothing to do. */
+	if (!vdo_has_waiters(from_queue))
+		return;
+
+	if (vdo_has_waiters(to_queue)) {
+		/*
+		 * Both queues are non-empty. Splice the two circular lists together by swapping
+		 * the next (head) pointers in the list tails.
+		 */
+		struct waiter *from_head = from_queue->last_waiter->next_waiter;
+		struct waiter *to_head = to_queue->last_waiter->next_waiter;
+
+		to_queue->last_waiter->next_waiter = from_head;
+		from_queue->last_waiter->next_waiter = to_head;
+	}
+
+	to_queue->last_waiter = from_queue->last_waiter;
+	to_queue->queue_length += from_queue->queue_length;
+	vdo_initialize_wait_queue(from_queue);
+}
+
+/**
+ * vdo_notify_all_waiters() - Notify all the entries waiting in a queue.
+ * @queue: The wait queue containing the waiters to notify.
+ * @callback: The function to call to notify each waiter, or NULL to invoke the callback field
+ *            registered in each waiter.
+ * @context: The context to pass to the callback function.
+ *
+ * Notifies all the entries waiting in a queue to continue execution by invoking a callback
+ * function on each of them in turn. The queue is copied and emptied before invoking any callbacks,
+ * and only the waiters that were in the queue at the start of the call will be notified.
+ */
+void vdo_notify_all_waiters(struct wait_queue *queue, waiter_callback *callback, void *context)
+{
+	/*
+	 * Copy and empty the queue first, avoiding the possibility of an infinite loop if entries
+	 * are returned to the queue by the callback function.
+	 */
+	struct wait_queue waiters;
+
+	vdo_initialize_wait_queue(&waiters);
+	vdo_transfer_all_waiters(queue, &waiters);
+
+	/* Drain the copied queue, invoking the callback on every entry. */
+	while (vdo_notify_next_waiter(&waiters, callback, context))
+		/* All the work is done by the loop condition. */
+		;
+}
+
+/**
+ * vdo_get_first_waiter() - Return the waiter that is at the head end of a wait queue.
+ * @queue: The queue from which to get the first waiter.
+ *
+ * Return: The first (oldest) waiter in the queue, or NULL if the queue is empty.
+ */
+struct waiter *vdo_get_first_waiter(const struct wait_queue *queue)
+{
+	struct waiter *last_waiter = queue->last_waiter;
+
+	if (last_waiter == NULL)
+		/* There are no waiters, so we're done. */
+		return NULL;
+
+	/* The queue is circular, so the last entry links to the head of the queue. */
+	return last_waiter->next_waiter;
+}
+
+/**
+ * vdo_dequeue_matching_waiters() - Remove all waiters that match based on the specified matching
+ *                                  method and append them to a wait_queue.
+ * @queue: The wait queue to process.
+ * @match_method: The method to determine matching.
+ * @match_context: Contextual info for the match method.
+ * @matched_queue: A wait_queue to store matches.
+ */
+void vdo_dequeue_matching_waiters(struct wait_queue *queue,
+				  waiter_match *match_method,
+				  void *match_context,
+				  struct wait_queue *matched_queue)
+{
+	struct wait_queue matched_waiters, iteration_queue;
+
+	vdo_initialize_wait_queue(&matched_waiters);
+
+	vdo_initialize_wait_queue(&iteration_queue);
+	vdo_transfer_all_waiters(queue, &iteration_queue);
+	while (vdo_has_waiters(&iteration_queue)) {
+		struct waiter *waiter = vdo_dequeue_next_waiter(&iteration_queue);
+
+		vdo_enqueue_waiter((match_method(waiter, match_context) ?
+				    &matched_waiters :
+				    queue),
+				   waiter);
+	}
+
+	vdo_transfer_all_waiters(&matched_waiters, matched_queue);
+}
+
+/**
+ * vdo_dequeue_next_waiter() - Remove the first waiter from the head end of a wait queue.
+ * @queue: The wait queue from which to remove the first entry.
+ *
+ * The caller will be responsible for waking the waiter by invoking the correct callback function
+ * to resume its execution.
+ *
+ * Return: The first (oldest) waiter in the queue, or NULL if the queue is empty.
+ */
+struct waiter *vdo_dequeue_next_waiter(struct wait_queue *queue)
+{
+	struct waiter *first_waiter = vdo_get_first_waiter(queue);
+	struct waiter *last_waiter = queue->last_waiter;
+
+	if (first_waiter == NULL)
+		return NULL;
+
+	if (first_waiter == last_waiter)
+		/* The queue has a single entry, so just empty it out by nulling the tail. */
+		queue->last_waiter = NULL;
+	else
+		/*
+		 * The queue has more than one entry, so splice the first waiter out of the
+		 * circular queue.
+		 */
+		last_waiter->next_waiter = first_waiter->next_waiter;
+
+	/* The waiter is no longer in a wait queue. */
+	first_waiter->next_waiter = NULL;
+	queue->queue_length -= 1;
+	return first_waiter;
+}
+
+/**
+ * vdo_notify_next_waiter() - Notify the next entry waiting in a queue.
+ * @queue: The wait queue containing the waiter to notify.
+ * @callback: The function to call to notify the waiter, or NULL to invoke the callback field
+ *            registered in the waiter.
+ * @context: The context to pass to the callback function.
+ *
+ * Notifies the next entry waiting in a queue to continue execution by invoking a callback function
+ * on it after removing it from the queue.
+ *
+ * Return: true if there was a waiter in the queue.
+ */
+bool vdo_notify_next_waiter(struct wait_queue *queue, waiter_callback *callback, void *context)
+{
+	struct waiter *waiter = vdo_dequeue_next_waiter(queue);
+
+	if (waiter == NULL)
+		return false;
+
+	if (callback == NULL)
+		callback = waiter->callback;
+	(*callback)(waiter, context);
+	return true;
+}
+
+/**
+ * vdo_get_next_waiter() - Get the waiter after this one, for debug iteration.
+ * @queue: The wait queue.
+ * @waiter: A waiter.
+ *
+ * Return: The next waiter, or NULL.
+ */
+const struct waiter *
+vdo_get_next_waiter(const struct wait_queue *queue, const struct waiter *waiter)
+{
+	struct waiter *first_waiter = vdo_get_first_waiter(queue);
+
+	if (waiter == NULL)
+		return first_waiter;
+	return ((waiter->next_waiter != first_waiter) ? waiter->next_waiter : NULL);
+}
diff --git a/drivers/md/dm-vdo/wait-queue.h b/drivers/md/dm-vdo/wait-queue.h
new file mode 100644
index 00000000000..f73b93bee1f
--- /dev/null
+++ b/drivers/md/dm-vdo/wait-queue.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Red Hat
+ */
+
+#ifndef VDO_WAIT_QUEUE_H
+#define VDO_WAIT_QUEUE_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/**
+ * DOC: Wait queues.
+ *
+ * A wait queue is a circular list of entries waiting to be notified of a change in a condition.
+ * Keeping a circular list allows the queue structure to simply be a pointer to the tail (newest)
+ * entry in the queue, supporting constant-time enqueue and dequeue operations. A null pointer is
+ * an empty queue.
+ *
+ *   An empty queue:
+ *     queue0.last_waiter -> NULL
+ *
+ *   A singleton queue:
+ *     queue1.last_waiter -> entry1 -> entry1 -> [...]
+ *
+ *   A three-element queue:
+ *     queue2.last_waiter -> entry3 -> entry1 -> entry2 -> entry3 -> [...]
+ */
+
+struct waiter;
+
+struct wait_queue {
+	/* The tail of the queue, the last (most recently added) entry */
+	struct waiter *last_waiter;
+	/* The number of waiters currently in the queue */
+	size_t queue_length;
+};
+
+/**
+ * typedef waiter_callback - Callback type for functions which will be called to resume processing
+ *                           of a waiter after it has been removed from its wait queue.
+ */
+typedef void waiter_callback(struct waiter *waiter, void *context);
+
+/**
+ * typedef waiter_match - Method type for waiter matching methods.
+ *
+ * A waiter_match method returns false if the waiter does not match.
+ */
+typedef bool waiter_match(struct waiter *waiter, void *context);
+
+/* The queue entry structure for entries in a wait_queue. */
+struct waiter {
+	/*
+	 * The next waiter in the queue. If this entry is the last waiter, then this is actually a
+	 * pointer back to the head of the queue.
+	 */
+	struct waiter *next_waiter;
+
+	/* Optional waiter-specific callback to invoke when waking this waiter. */
+	waiter_callback *callback;
+};
+
+/**
+ * is_waiting() - Check whether a waiter is waiting.
+ * @waiter: The waiter to check.
+ *
+ * Return: true if the waiter is on some wait_queue.
+ */
+static inline bool vdo_is_waiting(struct waiter *waiter)
+{
+	return (waiter->next_waiter != NULL);
+}
+
+/**
+ * initialize_wait_queue() - Initialize a wait queue.
+ * @queue: The queue to initialize.
+ */
+static inline void vdo_initialize_wait_queue(struct wait_queue *queue)
+{
+	*queue = (struct wait_queue) {
+		.last_waiter = NULL,
+		.queue_length = 0,
+	};
+}
+
+/**
+ * has_waiters() - Check whether a wait queue has any entries waiting in it.
+ * @queue: The queue to query.
+ *
+ * Return: true if there are any waiters in the queue.
+ */
+static inline bool __must_check vdo_has_waiters(const struct wait_queue *queue)
+{
+	return (queue->last_waiter != NULL);
+}
+
+void vdo_enqueue_waiter(struct wait_queue *queue, struct waiter *waiter);
+
+void vdo_notify_all_waiters(struct wait_queue *queue, waiter_callback *callback, void *context);
+
+bool vdo_notify_next_waiter(struct wait_queue *queue, waiter_callback *callback, void *context);
+
+void vdo_transfer_all_waiters(struct wait_queue *from_queue, struct wait_queue *to_queue);
+
+struct waiter *vdo_get_first_waiter(const struct wait_queue *queue);
+
+void vdo_dequeue_matching_waiters(struct wait_queue *queue,
+				  waiter_match *match_method,
+				  void *match_context,
+				  struct wait_queue *matched_queue);
+
+struct waiter *vdo_dequeue_next_waiter(struct wait_queue *queue);
+
+/**
+ * count_waiters() - Count the number of waiters in a wait queue.
+ * @queue: The wait queue to query.
+ *
+ * Return: The number of waiters in the queue.
+ */
+static inline size_t __must_check vdo_count_waiters(const struct wait_queue *queue)
+{
+	return queue->queue_length;
+}
+
+const struct waiter * __must_check
+vdo_get_next_waiter(const struct wait_queue *queue, const struct waiter *waiter);
+
+#endif /* VDO_WAIT_QUEUE_H */
-- 
2.40.1

