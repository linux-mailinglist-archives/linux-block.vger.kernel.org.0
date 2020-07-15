Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF7C220495
	for <lists+linux-block@lfdr.de>; Wed, 15 Jul 2020 07:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgGOFqx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Jul 2020 01:46:53 -0400
Received: from [195.135.220.15] ([195.135.220.15]:38660 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgGOFqx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 01:46:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EA23CAC79;
        Wed, 15 Jul 2020 05:46:52 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH v2 14/17] bcache: add bucket_size_hi into struct cache_sb_disk for large bucket
Date:   Wed, 15 Jul 2020 13:46:09 +0800
Message-Id: <20200715054612.6349-15-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715054612.6349-1-colyli@suse.de>
References: <20200715054612.6349-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The large bucket feature is to extend bucket_size from 16bit to 32bit.

When create cache device on zoned device (e.g. zoned NVMe SSD), making
a single bucket cover one or more zones of the zoned device is the
simplest way to support zoned device as cache by bcache.

But current maximum bucket size is 16MB and a typical zone size of zoned
device is 256MB, this is the major motiviation to extend bucket size to
a larger bit width.

This patch is the basic and first change to support large bucket size,
the major changes it makes are,
- Add BCH_FEATURE_INCOMPAT_LARGE_BUCKET for the large bucket feature,
  INCOMPAT means it introduces incompatible on-disk format change.
- Add BCH_FEATURE_INCOMPAT_FUNCS(large_bucket, LARGE_BUCKET) routines.
- Adds __le32 bucket_size_hi into struct cache_sb_disk at offset 0x8d0
  for the on-disk super block format.
- For the in-memory super block struct cache_sb, member bucket_size is
  extended from __u16 to __32.
- Add get_bucket_size() to combine the bucket_size and bucket_size_hi
  from struct cache_sb_disk into an unsigned int value.

Since we already have large bucket size helpers meta_bucket_pages(),
meta_bucket_bytes() and alloc_meta_bucket_pages(), they make sure when
bucket size > 8MB, the memory allocation for bcache meta data bucket
won't fail no matter how large the bucket size extended. So these meta
data buckets are handled properly when the bucket size width increase
from 16bit to 32bit, we don't need to worry about them.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/alloc.c    |  2 +-
 drivers/md/bcache/features.c | 22 ++++++++++++++++++++++
 drivers/md/bcache/features.h |  9 ++++++---
 drivers/md/bcache/movinggc.c |  4 ++--
 drivers/md/bcache/super.c    | 23 +++++++++++++++++++----
 include/uapi/linux/bcache.h  |  5 +++--
 6 files changed, 53 insertions(+), 12 deletions(-)
 create mode 100644 drivers/md/bcache/features.c

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index a1df0d95151c..52035a78d836 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -87,7 +87,7 @@ void bch_rescale_priorities(struct cache_set *c, int sectors)
 {
 	struct cache *ca;
 	struct bucket *b;
-	unsigned int next = c->nbuckets * c->sb.bucket_size / 1024;
+	unsigned long next = c->nbuckets * c->sb.bucket_size / 1024;
 	unsigned int i;
 	int r;
 
diff --git a/drivers/md/bcache/features.c b/drivers/md/bcache/features.c
new file mode 100644
index 000000000000..ba53944bb390
--- /dev/null
+++ b/drivers/md/bcache/features.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Feature set bits and string conversion.
+ * Inspired by ext4's features compat/incompat/ro_compat related code.
+ *
+ * Copyright 2020 Coly Li <colyli@suse.de>
+ *
+ */
+#include <linux/bcache.h>
+#include "bcache.h"
+
+struct feature {
+	int		compat;
+	unsigned int	mask;
+	const char	*string;
+};
+
+static struct feature feature_list[] = {
+	{BCH_FEATURE_INCOMPAT, BCH_FEATURE_INCOMPAT_LARGE_BUCKET,
+		"large_bucket"},
+	{0, 0, 0 },
+};
diff --git a/drivers/md/bcache/features.h b/drivers/md/bcache/features.h
index ae7df37b9862..dca052cf5203 100644
--- a/drivers/md/bcache/features.h
+++ b/drivers/md/bcache/features.h
@@ -11,9 +11,13 @@
 #define BCH_FEATURE_INCOMPAT		2
 #define BCH_FEATURE_TYPE_MASK		0x03
 
+/* Feature set definition */
+/* Incompat feature set */
+#define BCH_FEATURE_INCOMPAT_LARGE_BUCKET	0x0001 /* 32bit bucket size */
+
 #define BCH_FEATURE_COMPAT_SUUP		0
 #define BCH_FEATURE_RO_COMPAT_SUUP	0
-#define BCH_FEATURE_INCOMPAT_SUUP	0
+#define BCH_FEATURE_INCOMPAT_SUUP	BCH_FEATURE_INCOMPAT_LARGE_BUCKET
 
 #define BCH_HAS_COMPAT_FEATURE(sb, mask) \
 		((sb)->feature_compat & (mask))
@@ -22,8 +26,6 @@
 #define BCH_HAS_INCOMPAT_FEATURE(sb, mask) \
 		((sb)->feature_incompat & (mask))
 
-/* Feature set definition */
-
 #define BCH_FEATURE_COMPAT_FUNCS(name, flagname) \
 static inline int bch_has_feature_##name(struct cache_sb *sb) \
 { \
@@ -75,4 +77,5 @@ static inline void bch_clear_feature_##name(struct cache_sb *sb) \
 		~BCH##_FEATURE_INCOMPAT_##flagname; \
 }
 
+BCH_FEATURE_INCOMPAT_FUNCS(large_bucket, LARGE_BUCKET);
 #endif
diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
index b7dd2d75f58c..5872d6470470 100644
--- a/drivers/md/bcache/movinggc.c
+++ b/drivers/md/bcache/movinggc.c
@@ -206,8 +206,8 @@ void bch_moving_gc(struct cache_set *c)
 	mutex_lock(&c->bucket_lock);
 
 	for_each_cache(ca, c, i) {
-		unsigned int sectors_to_move = 0;
-		unsigned int reserve_sectors = ca->sb.bucket_size *
+		unsigned long sectors_to_move = 0;
+		unsigned long reserve_sectors = ca->sb.bucket_size *
 			     fifo_used(&ca->free[RESERVE_MOVINGGC]);
 
 		ca->heap.used = 0;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 334596b8d264..30972633c494 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -60,6 +60,17 @@ struct workqueue_struct *bch_journal_wq;
 
 /* Superblock */
 
+static unsigned int get_bucket_size(struct cache_sb *sb, struct cache_sb_disk *s)
+{
+	unsigned int bucket_size = le16_to_cpu(s->bucket_size);
+
+	if (sb->version >= BCACHE_SB_VERSION_CDEV_WITH_FEATURES &&
+	     bch_has_feature_large_bucket(sb))
+		bucket_size |= le32_to_cpu(s->bucket_size_hi) << 16;
+
+	return bucket_size;
+}
+
 static const char *read_super_basic(struct cache_sb *sb,  struct block_device *bdev,
 				     struct cache_sb_disk *s)
 {
@@ -68,7 +79,7 @@ static const char *read_super_basic(struct cache_sb *sb,  struct block_device *b
 
 	sb->first_bucket= le16_to_cpu(s->first_bucket);
 	sb->nbuckets	= le64_to_cpu(s->nbuckets);
-	sb->bucket_size	= le16_to_cpu(s->bucket_size);
+	sb->bucket_size	= get_bucket_size(sb, s);
 
 	sb->nr_in_set	= le16_to_cpu(s->nr_in_set);
 	sb->nr_this_dev	= le16_to_cpu(s->nr_this_dev);
@@ -210,12 +221,16 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 			goto err;
 		break;
 	case BCACHE_SB_VERSION_CDEV_WITH_FEATURES:
-		err = read_super_basic(sb, bdev, s);
-		if (err)
-			goto err;
+		/*
+		 * Feature bits are needed in read_super_basic(),
+		 * convert them firstly.
+		 */
 		sb->feature_compat = le64_to_cpu(s->feature_compat);
 		sb->feature_incompat = le64_to_cpu(s->feature_incompat);
 		sb->feature_ro_compat = le64_to_cpu(s->feature_ro_compat);
+		err = read_super_basic(sb, bdev, s);
+		if (err)
+			goto err;
 		break;
 	default:
 		err = "Unsupported superblock version";
diff --git a/include/uapi/linux/bcache.h b/include/uapi/linux/bcache.h
index f5106c5939b0..5c71c19d6135 100644
--- a/include/uapi/linux/bcache.h
+++ b/include/uapi/linux/bcache.h
@@ -213,7 +213,8 @@ struct cache_sb_disk {
 		__le16		keys;
 	};
 /*0d0*/	__le64			d[SB_JOURNAL_BUCKETS];	/* journal buckets */
-/*8d0*/
+/*8d0*/	__le32			bucket_size_hi;
+/*8d4*/
 };
 
 /*
@@ -248,9 +249,9 @@ struct cache_sb {
 		__u64		nbuckets;	/* device size */
 
 		__u16		block_size;	/* sectors */
-		__u16		bucket_size;	/* sectors */
 		__u16		nr_in_set;
 		__u16		nr_this_dev;
+		__u32		bucket_size;	/* sectors */
 	};
 	struct {
 		/* Backing devices */
-- 
2.26.2

