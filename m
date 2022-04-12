Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3D34FDC0B
	for <lists+linux-block@lfdr.de>; Tue, 12 Apr 2022 13:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357559AbiDLKMD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Apr 2022 06:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353059AbiDLJyZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 05:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4092F6949B
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 01:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649753838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=txkq6ZMi+v6/y4Tjo0rpNPId/nLyopTqh3PfrOsBZoY=;
        b=Z4UIBZuCVICfffk6pPAKdt9akAy1kl37vxMOI7EQG11vom1uDbbcdVgCzJZmchBPnkwc48
        V7lLX23tpkPiPai3gNMVzZSF1zGEfQhed/CocVIq6VJRwo3jPTQf6IWRVHKKcYxPklHByN
        aEYLQnueU3X2+9E46G+2UVIwH2GxMIA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290--75nggowPlWR-2Jeew9d8Q-1; Tue, 12 Apr 2022 04:57:16 -0400
X-MC-Unique: -75nggowPlWR-2Jeew9d8Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E01F8101A52C;
        Tue, 12 Apr 2022 08:57:15 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E878040470F2;
        Tue, 12 Apr 2022 08:57:13 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/8] dm: always setup ->orig_bio in alloc_io
Date:   Tue, 12 Apr 2022 16:56:13 +0800
Message-Id: <20220412085616.1409626-6-ming.lei@redhat.com>
In-Reply-To: <20220412085616.1409626-1-ming.lei@redhat.com>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The current DM codes setup ->orig_bio after __map_bio() returns,
and not only cause kernel panic for dm zone, but also a bit ugly
and tricky, especially the waiting until ->orig_bio is set in
dm_submit_bio_remap().

The reason is that one new bio is cloned from original FS bio to
represent the mapped part, which just serves io accounting.

Now we have switched to bdev based io accounting interface, and we
can retrieve sectors/bio_op from both the real original bio and the
added fields of .sector_offset & .sectors easily, so the new cloned
bio isn't necessary any more.

Not only fixes dm-zone's kernel panic, but also cleans up dm io
accounting & split a bit.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm-core.h |  8 ++++++-
 drivers/md/dm.c      | 51 ++++++++++++++++++++++----------------------
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 4277853c7535..aefb080c230d 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -247,7 +247,12 @@ struct dm_io {
 	blk_short_t flags;
 	atomic_t io_count;
 	struct mapped_device *md;
+
+	/* The three fields represent mapped part of original bio */
 	struct bio *orig_bio;
+	unsigned int sector_offset; /* offset to end of orig_bio */
+	unsigned int sectors;
+
 	blk_status_t status;
 	spinlock_t lock;
 	unsigned long start_time;
@@ -264,7 +269,8 @@ struct dm_io {
  */
 enum {
 	DM_IO_START_ACCT,
-	DM_IO_ACCOUNTED
+	DM_IO_ACCOUNTED,
+	DM_IO_SPLITTED
 };
 
 static inline bool dm_io_flagged(struct dm_io *io, unsigned int bit)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 31eacc0e93ed..df1d013fb793 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -509,8 +509,10 @@ static void dm_io_acct(struct dm_io *io, bool end)
 	/* If REQ_PREFLUSH set save any payload but do not account it */
 	if (bio_is_flush_with_data(bio))
 		sectors = 0;
-	else
+	else if (likely(!(dm_io_flagged(io, DM_IO_SPLITTED))))
 		sectors = bio_sectors(bio);
+	else
+		sectors = io->sectors;
 
 	if (!end)
 		bdev_start_io_acct(bio->bi_bdev, sectors, bio_op(bio),
@@ -518,10 +520,21 @@ static void dm_io_acct(struct dm_io *io, bool end)
 	else
 		bdev_end_io_acct(bio->bi_bdev, bio_op(bio), start_time);
 
-	if (unlikely(dm_stats_used(&md->stats)))
+	if (unlikely(dm_stats_used(&md->stats))) {
+		sector_t sector;
+
+		if (likely(!dm_io_flagged(io, DM_IO_SPLITTED))) {
+			sector = bio->bi_iter.bi_sector;
+			sectors = bio_sectors(bio);
+		} else {
+			sector = bio_end_sector(bio) - io->sector_offset;
+			sectors = io->sectors;
+		}
+
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
-				    bio->bi_iter.bi_sector, bio_sectors(bio),
+				    sector, sectors,
 				    end, start_time, stats_aux);
+	}
 }
 
 static void __dm_start_io_acct(struct dm_io *io)
@@ -576,7 +589,7 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	io->status = 0;
 	atomic_set(&io->io_count, 1);
 	this_cpu_inc(*md->pending_io);
-	io->orig_bio = NULL;
+	io->orig_bio = bio;
 	io->md = md;
 	io->map_task = current;
 	spin_lock_init(&io->lock);
@@ -1222,13 +1235,6 @@ void dm_submit_bio_remap(struct bio *clone, struct bio *tgt_clone)
 		/* Still in target's map function */
 		dm_io_set_flag(io, DM_IO_START_ACCT);
 	} else {
-		/*
-		 * Called by another thread, managed by DM target,
-		 * wait for dm_split_and_process_bio() to store
-		 * io->orig_bio
-		 */
-		while (unlikely(!smp_load_acquire(&io->orig_bio)))
-			msleep(1);
 		dm_start_io_acct(io, clone);
 	}
 
@@ -1557,7 +1563,6 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 				     struct dm_table *map, struct bio *bio)
 {
 	struct clone_info ci;
-	struct bio *orig_bio = NULL;
 	int error = 0;
 
 	init_clone_info(&ci, md, map, bio);
@@ -1573,22 +1578,16 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 	if (error || !ci.sector_count)
 		goto out;
 
-	/*
-	 * Remainder must be passed to submit_bio_noacct() so it gets handled
-	 * *after* bios already submitted have been completely processed.
-	 * We take a clone of the original to store in ci.io->orig_bio to be
-	 * used by dm_end_io_acct() and for dm_io_complete() to use for
-	 * completion handling.
-	 */
-	orig_bio = bio_split(bio, bio_sectors(bio) - ci.sector_count,
-			     GFP_NOIO, &md->queue->bio_split);
-	bio_chain(orig_bio, bio);
-	trace_block_split(orig_bio, bio->bi_iter.bi_sector);
+	/* setup the mapped part for accounting */
+	dm_io_set_flag(ci.io, DM_IO_SPLITTED);
+	ci.io->sectors = bio_sectors(bio) - ci.sector_count;
+	ci.io->sector_offset = bio_end_sector(bio) - bio->bi_iter.bi_sector;
+
+	bio_trim(bio, ci.io->sectors, ci.sector_count);
+	trace_block_split(bio, bio->bi_iter.bi_sector);
+	bio_inc_remaining(bio);
 	submit_bio_noacct(bio);
 out:
-	if (!orig_bio)
-		orig_bio = bio;
-	smp_store_release(&ci.io->orig_bio, orig_bio);
 	if (dm_io_flagged(ci.io, DM_IO_START_ACCT))
 		dm_start_io_acct(ci.io, NULL);
 
-- 
2.31.1

