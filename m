Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102EC2E86AC
	for <lists+linux-block@lfdr.de>; Sat,  2 Jan 2021 08:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbhABHN5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 2 Jan 2021 02:13:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:47734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbhABHN4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 2 Jan 2021 02:13:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3752ADD9;
        Sat,  2 Jan 2021 07:13:00 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 5/6] bcache-tools: introduce BCH_FEATURE_INCOMPAT_LOG_LARGE_BUCKET_SIZE for large bucket
Date:   Sat,  2 Jan 2021 15:12:43 +0800
Message-Id: <20210102071244.58353-6-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210102071244.58353-1-colyli@suse.de>
References: <20210102071244.58353-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When large bucket feature was added, BCH_FEATURE_INCOMPAT_LARGE_BUCKET
was introduced into incompat feature set. It indicates bucket_size_hi is
added at the tail of struct cache_sb_disk, to extend current 16bit
bucket size to 32bit with existing bucket_size in struct cache_sb_disk.

This is not a good idea, there are two obvious problems,
- Bucket size is always value power of 2, if store log2(bucket size) in
  existing bucket_size of struct cache_sb_disk, it is unnecessary to add
  bucket_size_hi.
- Macro csum_set() assumes d[SB_JOURNAL_BUCKETS] is the last member in
  struct cache_sb_disk, bucket_size_hi was added after d[] which makes
  csum_set calculate an unexpected super block checksum.

To fix the above problems, this patch introduces a new incompat feature
bit BCH_FEATURE_INCOMPAT_LOG_LARGE_BUCKET_SIZE, when this bit is set, it
means bucket_size in struct cache_sb_disk stores the order of power of
2 bucket size value. When user specifies a bucket size larger than 32768
sectors, BCH_FEATURE_INCOMPAT_LOG_LARGE_BUCKET_SIZE will be set to
incompat feature set, and bucket_size stores log2(bucket size) more
than store the real bucket size value.

The obsoleted BCH_FEATURE_INCOMPAT_LARGE_BUCKET won't be used anymore,
bcache-tools only display "obso_large_bucket" for cache device created
with BCH_FEATURE_INCOMPAT_LARGE_BUCKET, kernel driver will make bcache
device as read-only if BCH_FEATURE_INCOMPAT_LARGE_BUCKET is set.

With this change, the unnecessary extra space extend of bcache on-disk
super block can be avoided, and csum_set() may generate expected check
sum as well.

Fixes: 8c063851990a ("bcache-tools: add large_bucket incompat feature")
Signed-off-by: Coly Li <colyli@suse.de>
---
 bcache.h   | 13 +++++++++----
 features.c |  4 +++-
 lib.c      | 17 +++++++++++++++--
 lib.h      |  2 +-
 4 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/bcache.h b/bcache.h
index 58e973c..6dcdbb7 100644
--- a/bcache.h
+++ b/bcache.h
@@ -100,7 +100,7 @@ struct cache_sb_disk {
 		__le16		keys;
 	};
 	__le64			d[SB_JOURNAL_BUCKETS];	/* journal buckets */
-	__le16			bucket_size_hi;
+	__le16			obso_bucket_size_hi;	/* obsoleted */
 };
 
 /*
@@ -202,7 +202,8 @@ uint64_t crc64(const void *data, size_t len);
 
 #define BCH_FEATURE_COMPAT_SUPP		0
 #define BCH_FEATURE_RO_COMPAT_SUPP	0
-#define BCH_FEATURE_INCOMPAT_SUPP	BCH_FEATURE_INCOMPAT_LARGE_BUCKET
+#define BCH_FEATURE_INCOMPAT_SUPP	(BCH_FEATURE_INCOMPAT_OBSO_LARGE_BUCKET| \
+					 BCH_FEATURE_INCOMPAT_LOG_LARGE_BUCKET_SIZE)
 
 #define BCH_HAS_COMPAT_FEATURE(sb, mask) \
 		((sb)->feature_compat & (mask))
@@ -214,7 +215,10 @@ uint64_t crc64(const void *data, size_t len);
 /* Feature set definition */
 
 /* Incompat feature set */
-#define BCH_FEATURE_INCOMPAT_LARGE_BUCKET	0x0001 /* 32bit bucket size */
+/* 32bit bucket size, obsoleted */
+#define BCH_FEATURE_INCOMPAT_OBSO_LARGE_BUCKET		0x0001
+/* real bucket size is (1 << bucket_size) */
+#define BCH_FEATURE_INCOMPAT_LOG_LARGE_BUCKET_SIZE	0x0002
 
 #define BCH_FEATURE_COMPAT_FUNCS(name, flagname) \
 static inline int bch_has_feature_##name(struct cache_sb *sb) \
@@ -267,6 +271,7 @@ static inline void bch_clear_feature_##name(struct cache_sb *sb) \
 		~BCH##_FEATURE_INCOMPAT_##flagname; \
 }
 
-BCH_FEATURE_INCOMPAT_FUNCS(large_bucket, LARGE_BUCKET);
+BCH_FEATURE_INCOMPAT_FUNCS(obso_large_bucket, OBSO_LARGE_BUCKET);
+BCH_FEATURE_INCOMPAT_FUNCS(large_bucket, LOG_LARGE_BUCKET_SIZE);
 
 #endif
diff --git a/features.c b/features.c
index 181e348..f7f6224 100644
--- a/features.c
+++ b/features.c
@@ -20,7 +20,9 @@ struct feature {
 };
 
 static struct feature feature_list[] = {
-	{BCH_FEATURE_INCOMPAT, BCH_FEATURE_INCOMPAT_LARGE_BUCKET,
+	{BCH_FEATURE_INCOMPAT, BCH_FEATURE_INCOMPAT_OBSO_LARGE_BUCKET,
+		"obso_large_bucket"},
+	{BCH_FEATURE_INCOMPAT, BCH_FEATURE_INCOMPAT_LOG_LARGE_BUCKET_SIZE,
 		"large_bucket"},
 	{0, 0, 0 },
 };
diff --git a/lib.c b/lib.c
index a529ad3..e5624c7 100644
--- a/lib.c
+++ b/lib.c
@@ -21,6 +21,19 @@
  * utils function
  */
 
+static unsigned int log2_u32(uint32_t n)
+{
+	int r = 0;
+
+	n = n >> 1;
+	while (n) {
+		n = n >> 1;
+		r++;
+	}
+
+	return r;
+}
+
 static void trim_prefix(char *dest, char *src, int num)
 {
 	strcpy(dest, src + num);
@@ -772,7 +785,7 @@ struct cache_sb *to_cache_sb(struct cache_sb *sb,
 
 	if (sb->version >= BCACHE_SB_VERSION_CDEV_WITH_FEATURES &&
 	    bch_has_feature_large_bucket(sb))
-		sb->bucket_size += le16_to_cpu(sb_disk->bucket_size_hi) << 16;
+		sb->bucket_size = 1 << le16_to_cpu(sb_disk->bucket_size);
 
 	return sb;
 }
@@ -824,7 +837,7 @@ struct cache_sb_disk *to_cache_sb_disk(struct cache_sb_disk *sb_disk,
 
 	if (sb->version >= BCACHE_SB_VERSION_CDEV_WITH_FEATURES &&
 	    bch_has_feature_large_bucket(sb))
-		sb_disk->bucket_size_hi = cpu_to_le16(sb->bucket_size >> 16);
+		sb_disk->bucket_size = cpu_to_le16(log2_u32(sb->bucket_size));
 
 	return sb_disk;
 }
diff --git a/lib.h b/lib.h
index 9b5ed02..0357a11 100644
--- a/lib.h
+++ b/lib.h
@@ -13,7 +13,7 @@ struct dev {
 	char		label[SB_LABEL_SIZE + 1];
 	char		uuid[40];
 	uint16_t	sectors_per_block;
-	uint16_t	sectors_per_bucket;
+	uint32_t	sectors_per_bucket;
 	char		cset[40];
 	char		state[40];
 	char		bname[40];
-- 
2.26.2

