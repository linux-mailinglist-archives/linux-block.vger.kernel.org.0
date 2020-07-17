Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB62223A6D
	for <lists+linux-block@lfdr.de>; Fri, 17 Jul 2020 13:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGQLXU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 17 Jul 2020 07:23:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:60668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgGQLXU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 07:23:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0885AE56;
        Fri, 17 Jul 2020 11:23:22 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, hare@suse.de, Coly Li <colyli@suse.de>
Subject: [PATCH v4 14/16] bcache: add sysfs file to display feature sets information of cache set
Date:   Fri, 17 Jul 2020 19:22:34 +0800
Message-Id: <20200717112236.44761-15-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717112236.44761-1-colyli@suse.de>
References: <20200717112236.44761-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following three sysfs files are created to display according feature
set information of bcache:
	/sys/fs/bcache/<cache set UUID>/internal/feature_compat
	/sys/fs/bcache/<cache set UUID>/internal/feature_ro_compat
	/sys/fs/bcache/<cache set UUID>/internal/feature_incompat
is added by this patch, to display feature sets information of the cache
set.

Now only an incompat feature 'large_bucket' added in bcache, the sysfs
file content is:
        [large_bucket]
string large_bucket means the running bcache drive supports incompat
feature 'large_bucket', the wrapping [] means the 'large_bucket' feature
is currently enabled on this cache set.

This patch is ready to display compat and ro_compat features, in future
once bcache code implements such feature sets, the according feature
strings will be displayed in their sysfs files too.

Signed-off-by: Coly Li <colyli@suse.de>
---
Changlog:
v2: create single sysfs file for each feature set, suggested by Hannes.
v1: initial version.

 drivers/md/bcache/Makefile   |  2 +-
 drivers/md/bcache/features.c | 53 ++++++++++++++++++++++++++++++++++++
 drivers/md/bcache/features.h |  5 ++++
 drivers/md/bcache/sysfs.c    | 14 ++++++++++
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/Makefile b/drivers/md/bcache/Makefile
index fd714628da6a..5b87e59676b8 100644
--- a/drivers/md/bcache/Makefile
+++ b/drivers/md/bcache/Makefile
@@ -4,4 +4,4 @@ obj-$(CONFIG_BCACHE)	+= bcache.o
 
 bcache-y		:= alloc.o bset.o btree.o closure.o debug.o extents.o\
 	io.o journal.o movinggc.o request.o stats.o super.o sysfs.o trace.o\
-	util.o writeback.o
+	util.o writeback.o features.o
diff --git a/drivers/md/bcache/features.c b/drivers/md/bcache/features.c
index ba53944bb390..4442df48d28c 100644
--- a/drivers/md/bcache/features.c
+++ b/drivers/md/bcache/features.c
@@ -8,6 +8,7 @@
  */
 #include <linux/bcache.h>
 #include "bcache.h"
+#include "features.h"
 
 struct feature {
 	int		compat;
@@ -20,3 +21,55 @@ static struct feature feature_list[] = {
 		"large_bucket"},
 	{0, 0, 0 },
 };
+
+#define compose_feature_string(type)				\
+({									\
+	struct feature *f;						\
+	bool first = true;						\
+									\
+	for (f = &feature_list[0]; f->compat != 0; f++) {		\
+		if (f->compat != BCH_FEATURE_ ## type)			\
+			continue;					\
+		if (BCH_HAS_ ## type ## _FEATURE(&c->sb, f->mask)) {	\
+			if (first) {					\
+				out += snprintf(out, buf + size - out,	\
+						"[");	\
+			} else {					\
+				out += snprintf(out, buf + size - out,	\
+						" [");			\
+			}						\
+		} else if (!first) {					\
+			out += snprintf(out, buf + size - out, " ");	\
+		}							\
+									\
+		out += snprintf(out, buf + size - out, "%s", f->string);\
+									\
+		if (BCH_HAS_ ## type ## _FEATURE(&c->sb, f->mask))	\
+			out += snprintf(out, buf + size - out, "]");	\
+									\
+		first = false;						\
+	}								\
+	if (!first)							\
+		out += snprintf(out, buf + size - out, "\n");		\
+})
+
+int bch_print_cache_set_feature_compat(struct cache_set *c, char *buf, int size)
+{
+	char *out = buf;
+	compose_feature_string(COMPAT);
+	return out - buf;
+}
+
+int bch_print_cache_set_feature_ro_compat(struct cache_set *c, char *buf, int size)
+{
+	char *out = buf;
+	compose_feature_string(RO_COMPAT);
+	return out - buf;
+}
+
+int bch_print_cache_set_feature_incompat(struct cache_set *c, char *buf, int size)
+{
+	char *out = buf;
+	compose_feature_string(INCOMPAT);
+	return out - buf;
+}
diff --git a/drivers/md/bcache/features.h b/drivers/md/bcache/features.h
index dca052cf5203..a1653c478041 100644
--- a/drivers/md/bcache/features.h
+++ b/drivers/md/bcache/features.h
@@ -78,4 +78,9 @@ static inline void bch_clear_feature_##name(struct cache_sb *sb) \
 }
 
 BCH_FEATURE_INCOMPAT_FUNCS(large_bucket, LARGE_BUCKET);
+
+int bch_print_cache_set_feature_compat(struct cache_set *c, char *buf, int size);
+int bch_print_cache_set_feature_ro_compat(struct cache_set *c, char *buf, int size);
+int bch_print_cache_set_feature_incompat(struct cache_set *c, char *buf, int size);
+
 #endif
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 0dadec5a78f6..ac06c0bc3c0a 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -11,6 +11,7 @@
 #include "btree.h"
 #include "request.h"
 #include "writeback.h"
+#include "features.h"
 
 #include <linux/blkdev.h>
 #include <linux/sort.h>
@@ -88,6 +89,9 @@ read_attribute(btree_used_percent);
 read_attribute(average_key_size);
 read_attribute(dirty_data);
 read_attribute(bset_tree_stats);
+read_attribute(feature_compat);
+read_attribute(feature_ro_compat);
+read_attribute(feature_incompat);
 
 read_attribute(state);
 read_attribute(cache_read_races);
@@ -779,6 +783,13 @@ SHOW(__bch_cache_set)
 	if (attr == &sysfs_bset_tree_stats)
 		return bch_bset_print_stats(c, buf);
 
+	if (attr == &sysfs_feature_compat)
+		return bch_print_cache_set_feature_compat(c, buf, PAGE_SIZE);
+	if (attr == &sysfs_feature_ro_compat)
+		return bch_print_cache_set_feature_ro_compat(c, buf, PAGE_SIZE);
+	if (attr == &sysfs_feature_incompat)
+		return bch_print_cache_set_feature_incompat(c, buf, PAGE_SIZE);
+
 	return 0;
 }
 SHOW_LOCKED(bch_cache_set)
@@ -987,6 +998,9 @@ static struct attribute *bch_cache_set_internal_files[] = {
 	&sysfs_io_disable,
 	&sysfs_cutoff_writeback,
 	&sysfs_cutoff_writeback_sync,
+	&sysfs_feature_compat,
+	&sysfs_feature_ro_compat,
+	&sysfs_feature_incompat,
 	NULL
 };
 KTYPE(bch_cache_set_internal);
-- 
2.26.2

