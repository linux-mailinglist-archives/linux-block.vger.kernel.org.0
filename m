Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58C32E914C
	for <lists+linux-block@lfdr.de>; Mon,  4 Jan 2021 08:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbhADHmP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 Jan 2021 02:42:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:41098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbhADHmP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Jan 2021 02:42:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11456B285;
        Mon,  4 Jan 2021 07:41:34 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>, stable@vger.kernel.org
Subject: [PATCH 3/5] bcache: check unsupported feature sets for bcache register
Date:   Mon,  4 Jan 2021 15:41:20 +0800
Message-Id: <20210104074122.19759-4-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210104074122.19759-1-colyli@suse.de>
References: <20210104074122.19759-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds the check for features which is incompatible for
current supported feature sets.

Now if the bcache device created by bcache-tools has features that
current kernel doesn't support, read_super() will fail with error
messoage. E.g. if an unsupported incompatible feature detected,
bcache register will fail with dmesg "bcache: register_bcache() error :
Unsupported incompatible feature found".

Fixes: d721a43ff69c ("bcache: increase super block version for cache device and backing device")
Fixes: ffa470327572 ("bcache: add bucket_size_hi into struct cache_sb_disk for large bucket")
Signed-off-by: Coly Li <colyli@suse.de>
Cc: stable@vger.kernel.org # 5.9+
---
 drivers/md/bcache/features.h | 15 +++++++++++++++
 drivers/md/bcache/super.c    | 14 ++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/md/bcache/features.h b/drivers/md/bcache/features.h
index 32c5bbda2f0d..e73724c2b49b 100644
--- a/drivers/md/bcache/features.h
+++ b/drivers/md/bcache/features.h
@@ -79,6 +79,21 @@ static inline void bch_clear_feature_##name(struct cache_sb *sb) \
 
 BCH_FEATURE_INCOMPAT_FUNCS(large_bucket, LARGE_BUCKET);
 
+static inline bool bch_has_unknown_compat_features(struct cache_sb *sb)
+{
+	return ((sb->feature_compat & ~BCH_FEATURE_COMPAT_SUPP) != 0);
+}
+
+static inline bool bch_has_unknown_ro_compat_features(struct cache_sb *sb)
+{
+	return ((sb->feature_ro_compat & ~BCH_FEATURE_RO_COMPAT_SUPP) != 0);
+}
+
+static inline bool bch_has_unknown_incompat_features(struct cache_sb *sb)
+{
+	return ((sb->feature_incompat & ~BCH_FEATURE_INCOMPAT_SUPP) != 0);
+}
+
 int bch_print_cache_set_feature_compat(struct cache_set *c, char *buf, int size);
 int bch_print_cache_set_feature_ro_compat(struct cache_set *c, char *buf, int size);
 int bch_print_cache_set_feature_incompat(struct cache_set *c, char *buf, int size);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 6aa23a6fb394..f4674a3298af 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -228,6 +228,20 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 		sb->feature_compat = le64_to_cpu(s->feature_compat);
 		sb->feature_incompat = le64_to_cpu(s->feature_incompat);
 		sb->feature_ro_compat = le64_to_cpu(s->feature_ro_compat);
+
+		/* Check incompatible features */
+		err = "Unsupported compatible feature found";
+		if (bch_has_unknown_compat_features(sb))
+			goto err;
+
+		err = "Unsupported read-only compatible feature found";
+		if (bch_has_unknown_ro_compat_features(sb))
+			goto err;
+
+		err = "Unsupported incompatible feature found";
+		if (bch_has_unknown_incompat_features(sb))
+			goto err;
+
 		err = read_super_common(sb, bdev, s);
 		if (err)
 			goto err;
-- 
2.26.2

