Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2310022D74C
	for <lists+linux-block@lfdr.de>; Sat, 25 Jul 2020 14:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgGYMDS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 25 Jul 2020 08:03:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:52462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgGYMDR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jul 2020 08:03:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 94CB2AEAF;
        Sat, 25 Jul 2020 12:03:25 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        Coly Li <colyli@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 15/25] bcache: struct cache_sb is only for in-memory super block now
Date:   Sat, 25 Jul 2020 20:00:29 +0800
Message-Id: <20200725120039.91071-16-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200725120039.91071-1-colyli@suse.de>
References: <20200725120039.91071-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have struct cache_sb_disk for on-disk super block already, it is
unnecessary to keep the in-memory super block format exactly mapping
to the on-disk struct layout.

This patch adds code comments to notice that struct cache_sb is not
exactly mapping to cache_sb_disk, and removes the useless member csum
and pad[5].

Although struct cache_sb does not belong to uapi, but there are still
some on-disk format related macros reference it and it is unncessary to
get rid of such dependency now. So struct cache_sb will continue to stay
in include/uapi/linux/bache.h for now.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 include/uapi/linux/bcache.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bcache.h b/include/uapi/linux/bcache.h
index 47df2db2e727..0ef984ea515a 100644
--- a/include/uapi/linux/bcache.h
+++ b/include/uapi/linux/bcache.h
@@ -215,8 +215,13 @@ struct cache_sb_disk {
 	__le64			d[SB_JOURNAL_BUCKETS];	/* journal buckets */
 };
 
+/*
+ * This is for in-memory bcache super block.
+ * NOTE: cache_sb is NOT exactly mapping to cache_sb_disk, the member
+ *       size, ordering and even whole struct size may be different
+ *       from cache_sb_disk.
+ */
 struct cache_sb {
-	__u64			csum;
 	__u64			offset;	/* sector where this sb was written */
 	__u64			version;
 
@@ -236,8 +241,6 @@ struct cache_sb {
 	__u64			feature_incompat;
 	__u64			feature_ro_compat;
 
-	__u64			pad[5];
-
 	union {
 	struct {
 		/* Cache devices */
@@ -245,7 +248,6 @@ struct cache_sb {
 
 		__u16		block_size;	/* sectors */
 		__u16		bucket_size;	/* sectors */
-
 		__u16		nr_in_set;
 		__u16		nr_this_dev;
 	};
-- 
2.26.2

