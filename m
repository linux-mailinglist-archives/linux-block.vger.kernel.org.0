Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EC73D872D
	for <lists+linux-block@lfdr.de>; Wed, 28 Jul 2021 07:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhG1Fit (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Jul 2021 01:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhG1Fit (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 01:38:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2F9C061757
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 22:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3jsQ99HpN4RJuS5/TNvKGH62p8hS2SViysXZECY6cb8=; b=lakJYL+D+d6wOWPL23vcPrZODX
        LgfwnxqR3sR8gfJ8I5D257TuW/KhpbArhsqB5SRorERYqct84Qm9vnZohq/Uuz+RmrEKTGaX4zGTW
        GZghtgxpb8JqtFGkN0ub5XwqQlIzaH26KjMwvUIRI3tvucLyPxR27BZvawoeglFuppm9FRmgsHm+N
        tjREt4hoc0HEIXc0qAR0Q7mp6V32eiCT7ZvTBlDyNxK1CElCr7QD8Ftliqmj23x++gT44Cdr846kZ
        C8DFpA96RZo4SEj/DIVawhvnl/4GTYkiug5GedvycQLJjtdRSzhP3CdOOksmlBxQEhBDNlm8Q2/28
        q2/Id71w==;
Received: from [2001:4bb8:184:87c5:bb62:2cac:f51c:2ae7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8cGT-00Fjx3-JW; Wed, 28 Jul 2021 05:38:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     caizhiyong@huawei.com, linux-block@vger.kernel.org
Subject: [PATCH] block: remove cmdline-parser.c
Date:   Wed, 28 Jul 2021 07:37:56 +0200
Message-Id: <20210728053756.409654-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

cmdline-parser.c is only used by the cmdline faux partition format,
so merge the code into that and avoid an indirect call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/configs/stmark2_defconfig |   1 -
 block/Kconfig                       |  10 --
 block/Makefile                      |   1 -
 block/cmdline-parser.c              | 255 --------------------------
 block/partitions/Kconfig            |   1 -
 block/partitions/cmdline.c          | 267 +++++++++++++++++++++++++++-
 include/linux/cmdline-parser.h      |  46 -----
 7 files changed, 262 insertions(+), 319 deletions(-)
 delete mode 100644 block/cmdline-parser.c
 delete mode 100644 include/linux/cmdline-parser.h

diff --git a/arch/m68k/configs/stmark2_defconfig b/arch/m68k/configs/stmark2_defconfig
index d92306472fce..8898ae321779 100644
--- a/arch/m68k/configs/stmark2_defconfig
+++ b/arch/m68k/configs/stmark2_defconfig
@@ -22,7 +22,6 @@ CONFIG_RAMSIZE=0x8000000
 CONFIG_VECTORBASE=0x40000000
 CONFIG_KERNELBASE=0x40001000
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_BLK_CMDLINE_PARSER=y
 CONFIG_BINFMT_FLAT=y
 CONFIG_BINFMT_ZFLAT=y
 CONFIG_BINFMT_MISC=y
diff --git a/block/Kconfig b/block/Kconfig
index fd732aede922..15dfb7660645 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -114,16 +114,6 @@ config BLK_DEV_THROTTLING_LOW
 
 	Note, this is an experimental interface and could be changed someday.
 
-config BLK_CMDLINE_PARSER
-	bool "Block device command line partition parser"
-	help
-	Enabling this option allows you to specify the partition layout from
-	the kernel boot args.  This is typically of use for embedded devices
-	which don't otherwise have any standardized method for listing the
-	partitions on a block device.
-
-	See Documentation/block/cmdline-partition.rst for more information.
-
 config BLK_WBT
 	bool "Enable support for block device writeback throttling"
 	help
diff --git a/block/Makefile b/block/Makefile
index bfbe4e13ca1e..c72592b4cf31 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -28,7 +28,6 @@ obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
 bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
 obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
 
-obj-$(CONFIG_BLK_CMDLINE_PARSER)	+= cmdline-parser.o
 obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o
 obj-$(CONFIG_BLK_DEV_INTEGRITY_T10)	+= t10-pi.o
 obj-$(CONFIG_BLK_MQ_PCI)	+= blk-mq-pci.o
diff --git a/block/cmdline-parser.c b/block/cmdline-parser.c
deleted file mode 100644
index f2a14571882b..000000000000
--- a/block/cmdline-parser.c
+++ /dev/null
@@ -1,255 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Parse command line, get partition information
- *
- * Written by Cai Zhiyong <caizhiyong@huawei.com>
- *
- */
-#include <linux/export.h>
-#include <linux/cmdline-parser.h>
-
-static int parse_subpart(struct cmdline_subpart **subpart, char *partdef)
-{
-	int ret = 0;
-	struct cmdline_subpart *new_subpart;
-
-	*subpart = NULL;
-
-	new_subpart = kzalloc(sizeof(struct cmdline_subpart), GFP_KERNEL);
-	if (!new_subpart)
-		return -ENOMEM;
-
-	if (*partdef == '-') {
-		new_subpart->size = (sector_t)(~0ULL);
-		partdef++;
-	} else {
-		new_subpart->size = (sector_t)memparse(partdef, &partdef);
-		if (new_subpart->size < (sector_t)PAGE_SIZE) {
-			pr_warn("cmdline partition size is invalid.");
-			ret = -EINVAL;
-			goto fail;
-		}
-	}
-
-	if (*partdef == '@') {
-		partdef++;
-		new_subpart->from = (sector_t)memparse(partdef, &partdef);
-	} else {
-		new_subpart->from = (sector_t)(~0ULL);
-	}
-
-	if (*partdef == '(') {
-		int length;
-		char *next = strchr(++partdef, ')');
-
-		if (!next) {
-			pr_warn("cmdline partition format is invalid.");
-			ret = -EINVAL;
-			goto fail;
-		}
-
-		length = min_t(int, next - partdef,
-			       sizeof(new_subpart->name) - 1);
-		strncpy(new_subpart->name, partdef, length);
-		new_subpart->name[length] = '\0';
-
-		partdef = ++next;
-	} else
-		new_subpart->name[0] = '\0';
-
-	new_subpart->flags = 0;
-
-	if (!strncmp(partdef, "ro", 2)) {
-		new_subpart->flags |= PF_RDONLY;
-		partdef += 2;
-	}
-
-	if (!strncmp(partdef, "lk", 2)) {
-		new_subpart->flags |= PF_POWERUP_LOCK;
-		partdef += 2;
-	}
-
-	*subpart = new_subpart;
-	return 0;
-fail:
-	kfree(new_subpart);
-	return ret;
-}
-
-static void free_subpart(struct cmdline_parts *parts)
-{
-	struct cmdline_subpart *subpart;
-
-	while (parts->subpart) {
-		subpart = parts->subpart;
-		parts->subpart = subpart->next_subpart;
-		kfree(subpart);
-	}
-}
-
-static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
-{
-	int ret = -EINVAL;
-	char *next;
-	int length;
-	struct cmdline_subpart **next_subpart;
-	struct cmdline_parts *newparts;
-	char buf[BDEVNAME_SIZE + 32 + 4];
-
-	*parts = NULL;
-
-	newparts = kzalloc(sizeof(struct cmdline_parts), GFP_KERNEL);
-	if (!newparts)
-		return -ENOMEM;
-
-	next = strchr(bdevdef, ':');
-	if (!next) {
-		pr_warn("cmdline partition has no block device.");
-		goto fail;
-	}
-
-	length = min_t(int, next - bdevdef, sizeof(newparts->name) - 1);
-	strncpy(newparts->name, bdevdef, length);
-	newparts->name[length] = '\0';
-	newparts->nr_subparts = 0;
-
-	next_subpart = &newparts->subpart;
-
-	while (next && *(++next)) {
-		bdevdef = next;
-		next = strchr(bdevdef, ',');
-
-		length = (!next) ? (sizeof(buf) - 1) :
-			min_t(int, next - bdevdef, sizeof(buf) - 1);
-
-		strncpy(buf, bdevdef, length);
-		buf[length] = '\0';
-
-		ret = parse_subpart(next_subpart, buf);
-		if (ret)
-			goto fail;
-
-		newparts->nr_subparts++;
-		next_subpart = &(*next_subpart)->next_subpart;
-	}
-
-	if (!newparts->subpart) {
-		pr_warn("cmdline partition has no valid partition.");
-		ret = -EINVAL;
-		goto fail;
-	}
-
-	*parts = newparts;
-
-	return 0;
-fail:
-	free_subpart(newparts);
-	kfree(newparts);
-	return ret;
-}
-
-void cmdline_parts_free(struct cmdline_parts **parts)
-{
-	struct cmdline_parts *next_parts;
-
-	while (*parts) {
-		next_parts = (*parts)->next_parts;
-		free_subpart(*parts);
-		kfree(*parts);
-		*parts = next_parts;
-	}
-}
-EXPORT_SYMBOL(cmdline_parts_free);
-
-int cmdline_parts_parse(struct cmdline_parts **parts, const char *cmdline)
-{
-	int ret;
-	char *buf;
-	char *pbuf;
-	char *next;
-	struct cmdline_parts **next_parts;
-
-	*parts = NULL;
-
-	next = pbuf = buf = kstrdup(cmdline, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	next_parts = parts;
-
-	while (next && *pbuf) {
-		next = strchr(pbuf, ';');
-		if (next)
-			*next = '\0';
-
-		ret = parse_parts(next_parts, pbuf);
-		if (ret)
-			goto fail;
-
-		if (next)
-			pbuf = ++next;
-
-		next_parts = &(*next_parts)->next_parts;
-	}
-
-	if (!*parts) {
-		pr_warn("cmdline partition has no valid partition.");
-		ret = -EINVAL;
-		goto fail;
-	}
-
-	ret = 0;
-done:
-	kfree(buf);
-	return ret;
-
-fail:
-	cmdline_parts_free(parts);
-	goto done;
-}
-EXPORT_SYMBOL(cmdline_parts_parse);
-
-struct cmdline_parts *cmdline_parts_find(struct cmdline_parts *parts,
-					 const char *bdev)
-{
-	while (parts && strncmp(bdev, parts->name, sizeof(parts->name)))
-		parts = parts->next_parts;
-	return parts;
-}
-EXPORT_SYMBOL(cmdline_parts_find);
-
-/*
- *  add_part()
- *    0 success.
- *    1 can not add so many partitions.
- */
-int cmdline_parts_set(struct cmdline_parts *parts, sector_t disk_size,
-		      int slot,
-		      int (*add_part)(int, struct cmdline_subpart *, void *),
-		      void *param)
-{
-	sector_t from = 0;
-	struct cmdline_subpart *subpart;
-
-	for (subpart = parts->subpart; subpart;
-	     subpart = subpart->next_subpart, slot++) {
-		if (subpart->from == (sector_t)(~0ULL))
-			subpart->from = from;
-		else
-			from = subpart->from;
-
-		if (from >= disk_size)
-			break;
-
-		if (subpart->size > (disk_size - from))
-			subpart->size = disk_size - from;
-
-		from += subpart->size;
-
-		if (add_part(slot, subpart, param))
-			break;
-	}
-
-	return slot;
-}
-EXPORT_SYMBOL(cmdline_parts_set);
diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
index 6e2a649669e5..278593b8e4e9 100644
--- a/block/partitions/Kconfig
+++ b/block/partitions/Kconfig
@@ -264,7 +264,6 @@ config SYSV68_PARTITION
 
 config CMDLINE_PARTITION
 	bool "Command line partition support" if PARTITION_ADVANCED
-	select BLK_CMDLINE_PARSER
 	help
 	  Say Y here if you want to read the partition table from bootargs.
 	  The format for the command line is just like mtdparts.
diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index 8f545c36cde4..482a29e95dbd 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -14,20 +14,248 @@
  * For further information, see "Documentation/block/cmdline-partition.rst"
  *
  */
+#include <linux/blkdev.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include "check.h"
 
-#include <linux/cmdline-parser.h>
 
-#include "check.h"
+/* partition flags */
+#define PF_RDONLY                   0x01 /* Device is read only */
+#define PF_POWERUP_LOCK             0x02 /* Always locked after reset */
+
+struct cmdline_subpart {
+	char name[BDEVNAME_SIZE]; /* partition name, such as 'rootfs' */
+	sector_t from;
+	sector_t size;
+	int flags;
+	struct cmdline_subpart *next_subpart;
+};
+
+struct cmdline_parts {
+	char name[BDEVNAME_SIZE]; /* block device, such as 'mmcblk0' */
+	unsigned int nr_subparts;
+	struct cmdline_subpart *subpart;
+	struct cmdline_parts *next_parts;
+};
+
+static int parse_subpart(struct cmdline_subpart **subpart, char *partdef)
+{
+	int ret = 0;
+	struct cmdline_subpart *new_subpart;
+
+	*subpart = NULL;
+
+	new_subpart = kzalloc(sizeof(struct cmdline_subpart), GFP_KERNEL);
+	if (!new_subpart)
+		return -ENOMEM;
+
+	if (*partdef == '-') {
+		new_subpart->size = (sector_t)(~0ULL);
+		partdef++;
+	} else {
+		new_subpart->size = (sector_t)memparse(partdef, &partdef);
+		if (new_subpart->size < (sector_t)PAGE_SIZE) {
+			pr_warn("cmdline partition size is invalid.");
+			ret = -EINVAL;
+			goto fail;
+		}
+	}
+
+	if (*partdef == '@') {
+		partdef++;
+		new_subpart->from = (sector_t)memparse(partdef, &partdef);
+	} else {
+		new_subpart->from = (sector_t)(~0ULL);
+	}
+
+	if (*partdef == '(') {
+		int length;
+		char *next = strchr(++partdef, ')');
+
+		if (!next) {
+			pr_warn("cmdline partition format is invalid.");
+			ret = -EINVAL;
+			goto fail;
+		}
+
+		length = min_t(int, next - partdef,
+			       sizeof(new_subpart->name) - 1);
+		strncpy(new_subpart->name, partdef, length);
+		new_subpart->name[length] = '\0';
+
+		partdef = ++next;
+	} else
+		new_subpart->name[0] = '\0';
+
+	new_subpart->flags = 0;
+
+	if (!strncmp(partdef, "ro", 2)) {
+		new_subpart->flags |= PF_RDONLY;
+		partdef += 2;
+	}
+
+	if (!strncmp(partdef, "lk", 2)) {
+		new_subpart->flags |= PF_POWERUP_LOCK;
+		partdef += 2;
+	}
+
+	*subpart = new_subpart;
+	return 0;
+fail:
+	kfree(new_subpart);
+	return ret;
+}
+
+static void free_subpart(struct cmdline_parts *parts)
+{
+	struct cmdline_subpart *subpart;
+
+	while (parts->subpart) {
+		subpart = parts->subpart;
+		parts->subpart = subpart->next_subpart;
+		kfree(subpart);
+	}
+}
+
+static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
+{
+	int ret = -EINVAL;
+	char *next;
+	int length;
+	struct cmdline_subpart **next_subpart;
+	struct cmdline_parts *newparts;
+	char buf[BDEVNAME_SIZE + 32 + 4];
+
+	*parts = NULL;
+
+	newparts = kzalloc(sizeof(struct cmdline_parts), GFP_KERNEL);
+	if (!newparts)
+		return -ENOMEM;
+
+	next = strchr(bdevdef, ':');
+	if (!next) {
+		pr_warn("cmdline partition has no block device.");
+		goto fail;
+	}
+
+	length = min_t(int, next - bdevdef, sizeof(newparts->name) - 1);
+	strncpy(newparts->name, bdevdef, length);
+	newparts->name[length] = '\0';
+	newparts->nr_subparts = 0;
+
+	next_subpart = &newparts->subpart;
+
+	while (next && *(++next)) {
+		bdevdef = next;
+		next = strchr(bdevdef, ',');
+
+		length = (!next) ? (sizeof(buf) - 1) :
+			min_t(int, next - bdevdef, sizeof(buf) - 1);
+
+		strncpy(buf, bdevdef, length);
+		buf[length] = '\0';
+
+		ret = parse_subpart(next_subpart, buf);
+		if (ret)
+			goto fail;
+
+		newparts->nr_subparts++;
+		next_subpart = &(*next_subpart)->next_subpart;
+	}
+
+	if (!newparts->subpart) {
+		pr_warn("cmdline partition has no valid partition.");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	*parts = newparts;
+
+	return 0;
+fail:
+	free_subpart(newparts);
+	kfree(newparts);
+	return ret;
+}
+
+static void cmdline_parts_free(struct cmdline_parts **parts)
+{
+	struct cmdline_parts *next_parts;
+
+	while (*parts) {
+		next_parts = (*parts)->next_parts;
+		free_subpart(*parts);
+		kfree(*parts);
+		*parts = next_parts;
+	}
+}
+
+static int cmdline_parts_parse(struct cmdline_parts **parts,
+		const char *cmdline)
+{
+	int ret;
+	char *buf;
+	char *pbuf;
+	char *next;
+	struct cmdline_parts **next_parts;
+
+	*parts = NULL;
+
+	next = pbuf = buf = kstrdup(cmdline, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	next_parts = parts;
+
+	while (next && *pbuf) {
+		next = strchr(pbuf, ';');
+		if (next)
+			*next = '\0';
+
+		ret = parse_parts(next_parts, pbuf);
+		if (ret)
+			goto fail;
+
+		if (next)
+			pbuf = ++next;
+
+		next_parts = &(*next_parts)->next_parts;
+	}
+
+	if (!*parts) {
+		pr_warn("cmdline partition has no valid partition.");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	ret = 0;
+done:
+	kfree(buf);
+	return ret;
+
+fail:
+	cmdline_parts_free(parts);
+	goto done;
+}
+
+static struct cmdline_parts *cmdline_parts_find(struct cmdline_parts *parts,
+					 const char *bdev)
+{
+	while (parts && strncmp(bdev, parts->name, sizeof(parts->name)))
+		parts = parts->next_parts;
+	return parts;
+}
 
 static char *cmdline;
 static struct cmdline_parts *bdev_parts;
 
-static int add_part(int slot, struct cmdline_subpart *subpart, void *param)
+static int add_part(int slot, struct cmdline_subpart *subpart,
+		struct parsed_partitions *state)
 {
 	int label_min;
 	struct partition_meta_info *info;
 	char tmp[sizeof(info->volname) + 4];
-	struct parsed_partitions *state = (struct parsed_partitions *)param;
 
 	if (slot >= state->limit)
 		return 1;
@@ -50,6 +278,35 @@ static int add_part(int slot, struct cmdline_subpart *subpart, void *param)
 	return 0;
 }
 
+static int cmdline_parts_set(struct cmdline_parts *parts, sector_t disk_size,
+		struct parsed_partitions *state)
+{
+	sector_t from = 0;
+	struct cmdline_subpart *subpart;
+	int slot = 1;
+
+	for (subpart = parts->subpart; subpart;
+	     subpart = subpart->next_subpart, slot++) {
+		if (subpart->from == (sector_t)(~0ULL))
+			subpart->from = from;
+		else
+			from = subpart->from;
+
+		if (from >= disk_size)
+			break;
+
+		if (subpart->size > (disk_size - from))
+			subpart->size = disk_size - from;
+
+		from += subpart->size;
+
+		if (add_part(slot, subpart, state))
+			break;
+	}
+
+	return slot;
+}
+
 static int __init cmdline_parts_setup(char *s)
 {
 	cmdline = s;
@@ -147,7 +404,7 @@ int cmdline_partition(struct parsed_partitions *state)
 
 	disk_size = get_capacity(state->bdev->bd_disk) << 9;
 
-	cmdline_parts_set(parts, disk_size, 1, add_part, (void *)state);
+	cmdline_parts_set(parts, disk_size, state);
 	cmdline_parts_verifier(1, state);
 
 	strlcat(state->pp_buf, "\n", PAGE_SIZE);
diff --git a/include/linux/cmdline-parser.h b/include/linux/cmdline-parser.h
deleted file mode 100644
index 68a541807bdf..000000000000
--- a/include/linux/cmdline-parser.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Parsing command line, get the partitions information.
- *
- * Written by Cai Zhiyong <caizhiyong@huawei.com>
- *
- */
-#ifndef CMDLINEPARSEH
-#define CMDLINEPARSEH
-
-#include <linux/blkdev.h>
-#include <linux/fs.h>
-#include <linux/slab.h>
-
-/* partition flags */
-#define PF_RDONLY                   0x01 /* Device is read only */
-#define PF_POWERUP_LOCK             0x02 /* Always locked after reset */
-
-struct cmdline_subpart {
-	char name[BDEVNAME_SIZE]; /* partition name, such as 'rootfs' */
-	sector_t from;
-	sector_t size;
-	int flags;
-	struct cmdline_subpart *next_subpart;
-};
-
-struct cmdline_parts {
-	char name[BDEVNAME_SIZE]; /* block device, such as 'mmcblk0' */
-	unsigned int nr_subparts;
-	struct cmdline_subpart *subpart;
-	struct cmdline_parts *next_parts;
-};
-
-void cmdline_parts_free(struct cmdline_parts **parts);
-
-int cmdline_parts_parse(struct cmdline_parts **parts, const char *cmdline);
-
-struct cmdline_parts *cmdline_parts_find(struct cmdline_parts *parts,
-					 const char *bdev);
-
-int cmdline_parts_set(struct cmdline_parts *parts, sector_t disk_size,
-		      int slot,
-		      int (*add_part)(int, struct cmdline_subpart *, void *),
-		      void *param);
-
-#endif /* CMDLINEPARSEH */
-- 
2.30.2

