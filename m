Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017EB223A5B
	for <lists+linux-block@lfdr.de>; Fri, 17 Jul 2020 13:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGQLXB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 17 Jul 2020 07:23:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:60568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgGQLXB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 07:23:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7ECEAE3C;
        Fri, 17 Jul 2020 11:23:02 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, hare@suse.de, Coly Li <colyli@suse.de>
Subject: [PATCH v4 05/16] bcache: increase super block version for cache device and backing device
Date:   Fri, 17 Jul 2020 19:22:25 +0800
Message-Id: <20200717112236.44761-6-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717112236.44761-1-colyli@suse.de>
References: <20200717112236.44761-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The new added super block version BCACHE_SB_VERSION_BDEV_WITH_FEATURES
(5) BCACHE_SB_VERSION_CDEV_WITH_FEATURES value (6), is for the feature
set bits.

Devices have super block version equal to the new version will have
three new members for feature set bits in the on-disk super block,
        __le64                  feature_compat;
        __le64                  feature_incompat;
        __le64                  feature_ro_compat;

They are used for further new features which may introduce on-disk
format change, and avoid unncessary super block version increase.

The very basic features handling code skeleton is also initialized in
this patch.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/bcache/features.h | 78 ++++++++++++++++++++++++++++++++++++
 drivers/md/bcache/super.c    | 32 +++++++++++++--
 include/uapi/linux/bcache.h  | 29 ++++++++++----
 3 files changed, 128 insertions(+), 11 deletions(-)
 create mode 100644 drivers/md/bcache/features.h

diff --git a/drivers/md/bcache/features.h b/drivers/md/bcache/features.h
new file mode 100644
index 000000000000..ae7df37b9862
--- /dev/null
+++ b/drivers/md/bcache/features.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _BCACHE_FEATURES_H
+#define _BCACHE_FEATURES_H
+
+#include <linux/bcache.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#define BCH_FEATURE_COMPAT		0
+#define BCH_FEATURE_RO_COMPAT		1
+#define BCH_FEATURE_INCOMPAT		2
+#define BCH_FEATURE_TYPE_MASK		0x03
+
+#define BCH_FEATURE_COMPAT_SUUP		0
+#define BCH_FEATURE_RO_COMPAT_SUUP	0
+#define BCH_FEATURE_INCOMPAT_SUUP	0
+
+#define BCH_HAS_COMPAT_FEATURE(sb, mask) \
+		((sb)->feature_compat & (mask))
+#define BCH_HAS_RO_COMPAT_FEATURE(sb, mask) \
+		((sb)->feature_ro_compat & (mask))
+#define BCH_HAS_INCOMPAT_FEATURE(sb, mask) \
+		((sb)->feature_incompat & (mask))
+
+/* Feature set definition */
+
+#define BCH_FEATURE_COMPAT_FUNCS(name, flagname) \
+static inline int bch_has_feature_##name(struct cache_sb *sb) \
+{ \
+	return (((sb)->feature_compat & \
+		BCH##_FEATURE_COMPAT_##flagname) != 0); \
+} \
+static inline void bch_set_feature_##name(struct cache_sb *sb) \
+{ \
+	(sb)->feature_compat |= \
+		BCH##_FEATURE_COMPAT_##flagname; \
+} \
+static inline void bch_clear_feature_##name(struct cache_sb *sb) \
+{ \
+	(sb)->feature_compat &= \
+		~BCH##_FEATURE_COMPAT_##flagname; \
+}
+
+#define BCH_FEATURE_RO_COMPAT_FUNCS(name, flagname) \
+static inline int bch_has_feature_##name(struct cache_sb *sb) \
+{ \
+	return (((sb)->feature_ro_compat & \
+		BCH##_FEATURE_RO_COMPAT_##flagname) != 0); \
+} \
+static inline void bch_set_feature_##name(struct cache_sb *sb) \
+{ \
+	(sb)->feature_ro_compat |= \
+		BCH##_FEATURE_RO_COMPAT_##flagname; \
+} \
+static inline void bch_clear_feature_##name(struct cache_sb *sb) \
+{ \
+	(sb)->feature_ro_compat &= \
+		~BCH##_FEATURE_RO_COMPAT_##flagname; \
+}
+
+#define BCH_FEATURE_INCOMPAT_FUNCS(name, flagname) \
+static inline int bch_has_feature_##name(struct cache_sb *sb) \
+{ \
+	return (((sb)->feature_incompat & \
+		BCH##_FEATURE_INCOMPAT_##flagname) != 0); \
+} \
+static inline void bch_set_feature_##name(struct cache_sb *sb) \
+{ \
+	(sb)->feature_incompat |= \
+		BCH##_FEATURE_INCOMPAT_##flagname; \
+} \
+static inline void bch_clear_feature_##name(struct cache_sb *sb) \
+{ \
+	(sb)->feature_incompat &= \
+		~BCH##_FEATURE_INCOMPAT_##flagname; \
+}
+
+#endif
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index d5ed8f31e123..62534f44c6dc 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -13,6 +13,7 @@
 #include "extents.h"
 #include "request.h"
 #include "writeback.h"
+#include "features.h"
 
 #include <linux/blkdev.h>
 #include <linux/debugfs.h>
@@ -194,6 +195,7 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 		sb->data_offset	= BDEV_DATA_START_DEFAULT;
 		break;
 	case BCACHE_SB_VERSION_BDEV_WITH_OFFSET:
+	case BCACHE_SB_VERSION_BDEV_WITH_FEATURES:
 		sb->data_offset	= le64_to_cpu(s->data_offset);
 
 		err = "Bad data offset";
@@ -207,6 +209,14 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 		if (err)
 			goto err;
 		break;
+	case BCACHE_SB_VERSION_CDEV_WITH_FEATURES:
+		err = read_super_common(sb, bdev, s);
+		if (err)
+			goto err;
+		sb->feature_compat = le64_to_cpu(s->feature_compat);
+		sb->feature_incompat = le64_to_cpu(s->feature_incompat);
+		sb->feature_ro_compat = le64_to_cpu(s->feature_ro_compat);
+		break;
 	default:
 		err = "Unsupported superblock version";
 		goto err;
@@ -241,7 +251,6 @@ static void __write_super(struct cache_sb *sb, struct cache_sb_disk *out,
 			offset_in_page(out));
 
 	out->offset		= cpu_to_le64(sb->offset);
-	out->version		= cpu_to_le64(sb->version);
 
 	memcpy(out->uuid,	sb->uuid, 16);
 	memcpy(out->set_uuid,	sb->set_uuid, 16);
@@ -257,6 +266,13 @@ static void __write_super(struct cache_sb *sb, struct cache_sb_disk *out,
 	for (i = 0; i < sb->keys; i++)
 		out->d[i] = cpu_to_le64(sb->d[i]);
 
+	if (sb->version >= BCACHE_SB_VERSION_CDEV_WITH_FEATURES) {
+		out->feature_compat    = cpu_to_le64(sb->feature_compat);
+		out->feature_incompat  = cpu_to_le64(sb->feature_incompat);
+		out->feature_ro_compat = cpu_to_le64(sb->feature_ro_compat);
+	}
+
+	out->version		= cpu_to_le64(sb->version);
 	out->csum = csum_set(out);
 
 	pr_debug("ver %llu, flags %llu, seq %llu\n",
@@ -313,17 +329,20 @@ void bcache_write_super(struct cache_set *c)
 {
 	struct closure *cl = &c->sb_write;
 	struct cache *ca;
-	unsigned int i;
+	unsigned int i, version = BCACHE_SB_VERSION_CDEV_WITH_UUID;
 
 	down(&c->sb_write_mutex);
 	closure_init(cl, &c->cl);
 
 	c->sb.seq++;
 
+	if (c->sb.version > version)
+		version = c->sb.version;
+
 	for_each_cache(ca, c, i) {
 		struct bio *bio = &ca->sb_bio;
 
-		ca->sb.version		= BCACHE_SB_VERSION_CDEV_WITH_UUID;
+		ca->sb.version		= version;
 		ca->sb.seq		= c->sb.seq;
 		ca->sb.last_mount	= c->sb.last_mount;
 
@@ -1831,6 +1850,13 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 	c->sb.bucket_size	= sb->bucket_size;
 	c->sb.nr_in_set		= sb->nr_in_set;
 	c->sb.last_mount	= sb->last_mount;
+	c->sb.version		= sb->version;
+	if (c->sb.version >= BCACHE_SB_VERSION_CDEV_WITH_FEATURES) {
+		c->sb.feature_compat = sb->feature_compat;
+		c->sb.feature_ro_compat = sb->feature_ro_compat;
+		c->sb.feature_incompat = sb->feature_incompat;
+	}
+
 	c->bucket_bits		= ilog2(sb->bucket_size);
 	c->block_bits		= ilog2(sb->block_size);
 	c->nr_uuids		= bucket_bytes(c) / sizeof(struct uuid_entry);
diff --git a/include/uapi/linux/bcache.h b/include/uapi/linux/bcache.h
index 9a1965c6c3d0..47df2db2e727 100644
--- a/include/uapi/linux/bcache.h
+++ b/include/uapi/linux/bcache.h
@@ -141,11 +141,13 @@ static inline struct bkey *bkey_idx(const struct bkey *k, unsigned int nr_keys)
  * Version 3: Cache device with new UUID format
  * Version 4: Backing device with data offset
  */
-#define BCACHE_SB_VERSION_CDEV		0
-#define BCACHE_SB_VERSION_BDEV		1
-#define BCACHE_SB_VERSION_CDEV_WITH_UUID 3
-#define BCACHE_SB_VERSION_BDEV_WITH_OFFSET 4
-#define BCACHE_SB_MAX_VERSION		4
+#define BCACHE_SB_VERSION_CDEV			0
+#define BCACHE_SB_VERSION_BDEV			1
+#define BCACHE_SB_VERSION_CDEV_WITH_UUID	3
+#define BCACHE_SB_VERSION_BDEV_WITH_OFFSET	4
+#define BCACHE_SB_VERSION_CDEV_WITH_FEATURES	5
+#define BCACHE_SB_VERSION_BDEV_WITH_FEATURES	6
+#define BCACHE_SB_MAX_VERSION			6
 
 #define SB_SECTOR			8
 #define SB_OFFSET			(SB_SECTOR << SECTOR_SHIFT)
@@ -173,7 +175,12 @@ struct cache_sb_disk {
 
 	__le64			flags;
 	__le64			seq;
-	__le64			pad[8];
+
+	__le64			feature_compat;
+	__le64			feature_incompat;
+	__le64			feature_ro_compat;
+
+	__le64			pad[5];
 
 	union {
 	struct {
@@ -224,7 +231,12 @@ struct cache_sb {
 
 	__u64			flags;
 	__u64			seq;
-	__u64			pad[8];
+
+	__u64			feature_compat;
+	__u64			feature_incompat;
+	__u64			feature_ro_compat;
+
+	__u64			pad[5];
 
 	union {
 	struct {
@@ -262,7 +274,8 @@ struct cache_sb {
 static inline _Bool SB_IS_BDEV(const struct cache_sb *sb)
 {
 	return sb->version == BCACHE_SB_VERSION_BDEV
-		|| sb->version == BCACHE_SB_VERSION_BDEV_WITH_OFFSET;
+		|| sb->version == BCACHE_SB_VERSION_BDEV_WITH_OFFSET
+		|| sb->version == BCACHE_SB_VERSION_BDEV_WITH_FEATURES;
 }
 
 BITMASK(CACHE_SYNC,			struct cache_sb, flags, 0, 1);
-- 
2.26.2

