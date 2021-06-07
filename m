Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EB239DCF7
	for <lists+linux-block@lfdr.de>; Mon,  7 Jun 2021 14:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFGMxb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 7 Jun 2021 08:53:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44216 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhFGMxa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jun 2021 08:53:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6F74521A83;
        Mon,  7 Jun 2021 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623070298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4B0rwQhk1T40VRlNtZlNy2eaGCPKSfwNrr48+/T0pEY=;
        b=SzGdyyomdt2rWP9wECHrvAPlmk4/ZVSZX4fGElgeDgTtdL7IaxgWeGl8cGRNSjp8Ugp/Mg
        CpJ3Jz44NAgSqzJkfhn2qleCEGZfZmn3FhOohtri3mkpJFyATPk66qGt1zxCqLiSnjytE0
        toj1qn11WRAxY/5ePrYrAduCTh2s8nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623070298;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4B0rwQhk1T40VRlNtZlNy2eaGCPKSfwNrr48+/T0pEY=;
        b=tS28N4tD5grABFPUNRXpxSby2EgyUhlW9IUEjiKSDy+zHII6WfmY7eYPa/e/DlPN+3rekQ
        jJ2wTurWWe5nH7DQ==
Received: from localhost.localdomain (unknown [10.163.16.22])
        by relay2.suse.de (Postfix) with ESMTP id 893E2A3B83;
        Mon,  7 Jun 2021 12:51:21 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, Coly Li <colyli@suse.de>,
        Alexander Ullrich <ealex1979@gmail.com>,
        Diego Ercolani <diego.ercolani@gmail.com>,
        Jan Szubiak <jan.szubiak@linuxpolska.pl>,
        Marco Rebhan <me@dblsaiko.net>,
        Matthias Ferdinand <bcache@mfedv.net>,
        Victor Westerhuis <victor@westerhu.is>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Rolf Fokkens <rolf@rolffokkens.nl>,
        Thorsten Knabe <linux@thorsten-knabe.de>,
        stable@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Nix <nix@esperi.org.uk>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 1/2] bcache: remove bcache device self-defined readahead
Date:   Mon,  7 Jun 2021 20:50:51 +0800
Message-Id: <20210607125052.21277-2-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210607125052.21277-1-colyli@suse.de>
References: <20210607125052.21277-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For read cache missing, bcache defines a readahead size for the read I/O
request to the backing device for the missing data. This readahead size
is initialized to 0, and almost no one uses it to avoid unnecessary read
amplifying onto backing device and write amplifying onto cache device.
Considering upper layer file system code has readahead logic allready
and works fine with readahead_cache_policy sysfile interface, we don't
have to keep bcache self-defined readahead anymore.

This patch removes the bcache self-defined readahead for cache missing
request for backing device, and the readahead sysfs file interfaces are
removed as well.

This is the preparation for next patch to fix potential kernel panic due
to oversized request in a simpler method.

Reported-by: Alexander Ullrich <ealex1979@gmail.com>
Reported-by: Diego Ercolani <diego.ercolani@gmail.com>
Reported-by: Jan Szubiak <jan.szubiak@linuxpolska.pl>
Reported-by: Marco Rebhan <me@dblsaiko.net>
Reported-by: Matthias Ferdinand <bcache@mfedv.net>
Reported-by: Victor Westerhuis <victor@westerhu.is>
Reported-by: Vojtech Pavlik <vojtech@suse.cz>
Reported-and-tested-by: Rolf Fokkens <rolf@rolffokkens.nl>
Reported-and-tested-by: Thorsten Knabe <linux@thorsten-knabe.de>
Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Nix <nix@esperi.org.uk>
Cc: Takashi Iwai <tiwai@suse.com>
---
Changlog,
v1, the initial version by hint from  Christoph Hellwig.

 drivers/md/bcache/bcache.h  |  1 -
 drivers/md/bcache/request.c | 13 +------------
 drivers/md/bcache/stats.c   | 14 --------------
 drivers/md/bcache/stats.h   |  1 -
 drivers/md/bcache/sysfs.c   |  4 ----
 5 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 0a4551e165ab..5fc989a6d452 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -364,7 +364,6 @@ struct cached_dev {
 
 	/* The rest of this all shows up in sysfs */
 	unsigned int		sequential_cutoff;
-	unsigned int		readahead;
 
 	unsigned int		io_disable:1;
 	unsigned int		verify:1;
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 29c231758293..ab8ff18df32a 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -880,7 +880,6 @@ static int cached_dev_cache_miss(struct btree *b, struct search *s,
 				 struct bio *bio, unsigned int sectors)
 {
 	int ret = MAP_CONTINUE;
-	unsigned int reada = 0;
 	struct cached_dev *dc = container_of(s->d, struct cached_dev, disk);
 	struct bio *miss, *cache_bio;
 
@@ -892,14 +891,7 @@ static int cached_dev_cache_miss(struct btree *b, struct search *s,
 		goto out_submit;
 	}
 
-	if (!(bio->bi_opf & REQ_RAHEAD) &&
-	    !(bio->bi_opf & (REQ_META|REQ_PRIO)) &&
-	    s->iop.c->gc_stats.in_use < CUTOFF_CACHE_READA)
-		reada = min_t(sector_t, dc->readahead >> 9,
-			      get_capacity(bio->bi_bdev->bd_disk) -
-			      bio_end_sector(bio));
-
-	s->insert_bio_sectors = min(sectors, bio_sectors(bio) + reada);
+	s->insert_bio_sectors = min(sectors, bio_sectors(bio));
 
 	s->iop.replace_key = KEY(s->iop.inode,
 				 bio->bi_iter.bi_sector + s->insert_bio_sectors,
@@ -933,9 +925,6 @@ static int cached_dev_cache_miss(struct btree *b, struct search *s,
 	if (bch_bio_alloc_pages(cache_bio, __GFP_NOWARN|GFP_NOIO))
 		goto out_put;
 
-	if (reada)
-		bch_mark_cache_readahead(s->iop.c, s->d);
-
 	s->cache_miss	= miss;
 	s->iop.bio	= cache_bio;
 	bio_get(cache_bio);
diff --git a/drivers/md/bcache/stats.c b/drivers/md/bcache/stats.c
index 503aafe188dc..4c7ee5fedb9d 100644
--- a/drivers/md/bcache/stats.c
+++ b/drivers/md/bcache/stats.c
@@ -46,7 +46,6 @@ read_attribute(cache_misses);
 read_attribute(cache_bypass_hits);
 read_attribute(cache_bypass_misses);
 read_attribute(cache_hit_ratio);
-read_attribute(cache_readaheads);
 read_attribute(cache_miss_collisions);
 read_attribute(bypassed);
 
@@ -64,7 +63,6 @@ SHOW(bch_stats)
 		    DIV_SAFE(var(cache_hits) * 100,
 			     var(cache_hits) + var(cache_misses)));
 
-	var_print(cache_readaheads);
 	var_print(cache_miss_collisions);
 	sysfs_hprint(bypassed,	var(sectors_bypassed) << 9);
 #undef var
@@ -86,7 +84,6 @@ static struct attribute *bch_stats_files[] = {
 	&sysfs_cache_bypass_hits,
 	&sysfs_cache_bypass_misses,
 	&sysfs_cache_hit_ratio,
-	&sysfs_cache_readaheads,
 	&sysfs_cache_miss_collisions,
 	&sysfs_bypassed,
 	NULL
@@ -113,7 +110,6 @@ void bch_cache_accounting_clear(struct cache_accounting *acc)
 	acc->total.cache_misses = 0;
 	acc->total.cache_bypass_hits = 0;
 	acc->total.cache_bypass_misses = 0;
-	acc->total.cache_readaheads = 0;
 	acc->total.cache_miss_collisions = 0;
 	acc->total.sectors_bypassed = 0;
 }
@@ -145,7 +141,6 @@ static void scale_stats(struct cache_stats *stats, unsigned long rescale_at)
 		scale_stat(&stats->cache_misses);
 		scale_stat(&stats->cache_bypass_hits);
 		scale_stat(&stats->cache_bypass_misses);
-		scale_stat(&stats->cache_readaheads);
 		scale_stat(&stats->cache_miss_collisions);
 		scale_stat(&stats->sectors_bypassed);
 	}
@@ -168,7 +163,6 @@ static void scale_accounting(struct timer_list *t)
 	move_stat(cache_misses);
 	move_stat(cache_bypass_hits);
 	move_stat(cache_bypass_misses);
-	move_stat(cache_readaheads);
 	move_stat(cache_miss_collisions);
 	move_stat(sectors_bypassed);
 
@@ -209,14 +203,6 @@ void bch_mark_cache_accounting(struct cache_set *c, struct bcache_device *d,
 	mark_cache_stats(&c->accounting.collector, hit, bypass);
 }
 
-void bch_mark_cache_readahead(struct cache_set *c, struct bcache_device *d)
-{
-	struct cached_dev *dc = container_of(d, struct cached_dev, disk);
-
-	atomic_inc(&dc->accounting.collector.cache_readaheads);
-	atomic_inc(&c->accounting.collector.cache_readaheads);
-}
-
 void bch_mark_cache_miss_collision(struct cache_set *c, struct bcache_device *d)
 {
 	struct cached_dev *dc = container_of(d, struct cached_dev, disk);
diff --git a/drivers/md/bcache/stats.h b/drivers/md/bcache/stats.h
index abfaabf7e7fc..ca4f435f7216 100644
--- a/drivers/md/bcache/stats.h
+++ b/drivers/md/bcache/stats.h
@@ -7,7 +7,6 @@ struct cache_stat_collector {
 	atomic_t cache_misses;
 	atomic_t cache_bypass_hits;
 	atomic_t cache_bypass_misses;
-	atomic_t cache_readaheads;
 	atomic_t cache_miss_collisions;
 	atomic_t sectors_bypassed;
 };
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index cc89f3156d1a..05ac1d6fbbf3 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -137,7 +137,6 @@ rw_attribute(io_disable);
 rw_attribute(discard);
 rw_attribute(running);
 rw_attribute(label);
-rw_attribute(readahead);
 rw_attribute(errors);
 rw_attribute(io_error_limit);
 rw_attribute(io_error_halflife);
@@ -260,7 +259,6 @@ SHOW(__bch_cached_dev)
 	var_printf(partial_stripes_expensive,	"%u");
 
 	var_hprint(sequential_cutoff);
-	var_hprint(readahead);
 
 	sysfs_print(running,		atomic_read(&dc->running));
 	sysfs_print(state,		states[BDEV_STATE(&dc->sb)]);
@@ -365,7 +363,6 @@ STORE(__cached_dev)
 	sysfs_strtoul_clamp(sequential_cutoff,
 			    dc->sequential_cutoff,
 			    0, UINT_MAX);
-	d_strtoi_h(readahead);
 
 	if (attr == &sysfs_clear_stats)
 		bch_cache_accounting_clear(&dc->accounting);
@@ -538,7 +535,6 @@ static struct attribute *bch_cached_dev_files[] = {
 	&sysfs_running,
 	&sysfs_state,
 	&sysfs_label,
-	&sysfs_readahead,
 #ifdef CONFIG_BCACHE_DEBUG
 	&sysfs_verify,
 	&sysfs_bypass_torture_test,
-- 
2.26.2

