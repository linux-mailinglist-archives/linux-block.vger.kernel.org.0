Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0162A1D618A
	for <lists+linux-block@lfdr.de>; Sat, 16 May 2020 16:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgEPOKY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 16 May 2020 10:10:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:47090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgEPOKY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 10:10:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20274ACB1;
        Sat, 16 May 2020 14:10:25 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 1/3] bcache-tools: set zoned size aligned data_offset on backing device for zoned devive
Date:   Sat, 16 May 2020 22:09:38 +0800
Message-Id: <20200516140940.101190-2-colyli@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200516140940.101190-1-colyli@suse.de>
References: <20200516140940.101190-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the backing device is a zoned device, e.g. host managed SMR hard
drive, the data_offset of the backing device should be set to a zone
size aligned value, this is necessary for the zoned device I/O LBA
and length requirement.

This patch set the data_offset for zoned backing device by following
rules,
- If no manually inputed data_offset specified, set it to default
  value:
  - If BDEV_DATA_START_DEFAULT >= zone size and aligned to zone size,
    keep data_offset as BDEV_DATA_START_DEFAULT.
  - If BDEV_DATA_START_DEFAULT < zone size, set data_offset to zone
    size.
  - If data_offset is manually set, it must be a non-zero value aligned
    to zone size. Of cause it can be multiple zones size, but must be
    aligned to zone size.

This patch also creates a new zone.c and zone.h and places all the
above zoned device related code there.

Signed-off-by: Coly Li <colyli@suse.de>
---
 Makefile |  4 +--
 make.c   |  7 ++++-
 zoned.c  | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 zoned.h  | 13 +++++++++
 4 files changed, 110 insertions(+), 3 deletions(-)
 create mode 100644 zoned.c
 create mode 100644 zoned.h

diff --git a/Makefile b/Makefile
index 4359866..2c326cf 100644
--- a/Makefile
+++ b/Makefile
@@ -24,7 +24,7 @@ bcache-test: LDLIBS += `pkg-config --libs openssl` -lm
 
 make-bcache: LDLIBS += `pkg-config --libs uuid blkid smartcols`
 make-bcache: CFLAGS += `pkg-config --cflags uuid blkid smartcols`
-make-bcache: make.o crc64.o lib.o
+make-bcache: make.o crc64.o lib.o zoned.o
 
 probe-bcache: LDLIBS += `pkg-config --libs uuid blkid`
 probe-bcache: CFLAGS += `pkg-config --cflags uuid blkid`
@@ -38,4 +38,4 @@ bcache-register: bcache-register.o
 bcache: CFLAGS += `pkg-config --cflags blkid uuid smartcols`
 bcache: LDLIBS += `pkg-config --libs blkid uuid smartcols`
 bcache: CFLAGS += -std=gnu99
-bcache: crc64.o lib.o make.o
+bcache: crc64.o lib.o make.o zoned.o
diff --git a/make.c b/make.c
index d46d925..c1090a6 100644
--- a/make.c
+++ b/make.c
@@ -35,6 +35,7 @@
 #include "bcache.h"
 #include "lib.h"
 #include "bitwise.h"
+#include "zoned.h"
 
 #define max(x, y) ({				\
 	typeof(x) _max1 = (x);			\
@@ -636,11 +637,15 @@ int make_bcache(int argc, char **argv)
 			 cache_replacement_policy,
 			 data_offset, set_uuid, false, force, label);
 
-	for (i = 0; i < nbacking_devices; i++)
+	for (i = 0; i < nbacking_devices; i++) {
+		check_data_offset_for_zoned_device(backing_devices[i],
+						   &data_offset);
+
 		write_sb(backing_devices[i], block_size, bucket_size,
 			 writeback, discard, wipe_bcache,
 			 cache_replacement_policy,
 			 data_offset, set_uuid, true, force, label);
+	}
 
 	return 0;
 }
diff --git a/zoned.c b/zoned.c
new file mode 100644
index 0000000..31c9136
--- /dev/null
+++ b/zoned.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file is part of bcache tools.
+ * Copyright (c) 2020 SUSE Software Solutions
+ *
+ * Authors: Coly Li <colyli@suse.de>
+ */
+
+#include <errno.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <libgen.h>
+
+#include "bcache.h"
+
+/*
+ * copied and modified from zonefs_get_dev_capacity() of
+ * zonefs-tools.
+ * returns   0: zone size 0 indicates a non-zoned device
+ *         > 0: actual zone size of the zoned device
+ */
+static size_t get_zone_size(char *devname)
+{
+	char str[128];
+	FILE *file;
+	int res;
+	size_t zone_size = 0;
+
+	snprintf(str, sizeof(str),
+		"/sys/block/%s/queue/chunk_sectors",
+		basename(devname));
+	file = fopen(str, "r");
+	if (!file)
+		goto out;
+
+	memset(str, 0, sizeof(str));
+	res = fscanf(file, "%s", str);
+	fclose(file);
+
+	if (res != 1)
+		goto out;
+
+	zone_size = atol(str);
+
+out:
+	return zone_size;
+}
+
+/*
+ * Update data_offset for zoned device, if the backing
+ * device is a zoned device,
+ * - just leave whole zone 0 to bcache super block on
+ *   backing device.
+ * - if data_offset is specified and larger than
+ *   BDEV_DATA_START_DEFAULT, then it should be a zone
+ *   size aligned value.
+ */
+void check_data_offset_for_zoned_device(char *devname,
+				       uint64_t *data_offset)
+{
+	uint64_t _data_offset = *data_offset;
+	size_t zone_size = get_zone_size(devname);
+
+	if (!zone_size)
+		return;
+
+	if (!_data_offset ||
+	    (_data_offset == BDEV_DATA_START_DEFAULT &&
+	     zone_size > BDEV_DATA_START_DEFAULT))
+		_data_offset = zone_size;
+
+	if (_data_offset < zone_size) {
+		fprintf(stderr,
+			"data_offset %lu should be larger than zone_size %lu for zoned device %s\n",
+			_data_offset, zone_size, devname);
+		exit(EXIT_FAILURE);
+	}
+
+	if (_data_offset & (zone_size - 1)) {
+		fprintf(stderr,
+			"data_offset %lu is not aligned to zone size %lu for zoned device %s\n",
+			_data_offset, zone_size, devname);
+	}
+
+	*data_offset = _data_offset;
+}
diff --git a/zoned.h b/zoned.h
new file mode 100644
index 0000000..1c5cce8
--- /dev/null
+++ b/zoned.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file is part of bcache tools.
+ * Copyright (c) 2020 SUSE Software Solutions
+ *
+ * Authors: Coly Li <colyli@suse.de>
+ */
+#ifndef __ZONED_H
+#define __ZONED_H
+
+void check_data_offset_for_zoned_device(char *devname, uint64_t *data_offset);
+
+#endif
-- 
2.25.0

