Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5851B599F9
	for <lists+linux-block@lfdr.de>; Fri, 28 Jun 2019 14:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfF1MCl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 28 Jun 2019 08:02:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:55534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727015AbfF1MCl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 08:02:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 09BC7B62D;
        Fri, 28 Jun 2019 12:02:40 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 37/37] bcache: add reclaimed_journal_buckets to struct cache_set
Date:   Fri, 28 Jun 2019 20:00:00 +0800
Message-Id: <20190628120000.40753-38-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190628120000.40753-1-colyli@suse.de>
References: <20190628120000.40753-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now we have counters for how many times jouranl is reclaimed, how many
times cached dirty btree nodes are flushed, but we don't know how many
jouranl buckets are really reclaimed.

This patch adds reclaimed_journal_buckets into struct cache_set, this
is an increasing only counter, to tell how many journal buckets are
reclaimed since cache set runs. From all these three counters (reclaim,
reclaimed_journal_buckets, flush_write), we can have idea how well
current journal space reclaim code works.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bcache.h  | 1 +
 drivers/md/bcache/journal.c | 1 +
 drivers/md/bcache/sysfs.c   | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 35396248a7d5..013e35a9e317 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -705,6 +705,7 @@ struct cache_set {
 	atomic_long_t		writeback_keys_failed;
 
 	atomic_long_t		reclaim;
+	atomic_long_t		reclaimed_journal_buckets;
 	atomic_long_t		flush_write;
 
 	enum			{
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 8bcd8f1bf8cb..be2a2a201603 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -614,6 +614,7 @@ static void journal_reclaim(struct cache_set *c)
 		k->ptr[n++] = MAKE_PTR(0,
 				  bucket_to_sector(c, ca->sb.d[ja->cur_idx]),
 				  ca->sb.nr_this_dev);
+		atomic_long_inc(&c->reclaimed_journal_buckets);
 	}
 
 	if (n) {
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 701a386a954c..9f0826712845 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -82,6 +82,7 @@ read_attribute(bset_tree_stats);
 read_attribute(state);
 read_attribute(cache_read_races);
 read_attribute(reclaim);
+read_attribute(reclaimed_journal_buckets);
 read_attribute(flush_write);
 read_attribute(writeback_keys_done);
 read_attribute(writeback_keys_failed);
@@ -705,6 +706,9 @@ SHOW(__bch_cache_set)
 	sysfs_print(reclaim,
 		    atomic_long_read(&c->reclaim));
 
+	sysfs_print(reclaimed_journal_buckets,
+		    atomic_long_read(&c->reclaimed_journal_buckets));
+
 	sysfs_print(flush_write,
 		    atomic_long_read(&c->flush_write));
 
@@ -931,6 +935,7 @@ static struct attribute *bch_cache_set_internal_files[] = {
 	&sysfs_bset_tree_stats,
 	&sysfs_cache_read_races,
 	&sysfs_reclaim,
+	&sysfs_reclaimed_journal_buckets,
 	&sysfs_flush_write,
 	&sysfs_writeback_keys_done,
 	&sysfs_writeback_keys_failed,
-- 
2.16.4

