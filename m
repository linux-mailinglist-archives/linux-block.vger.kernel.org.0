Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FDB569100
	for <lists+linux-block@lfdr.de>; Wed,  6 Jul 2022 19:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbiGFRo4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Jul 2022 13:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiGFRoi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 13:44:38 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8002BB0C
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 10:44:08 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id he28so19267715qtb.13
        for <linux-block@vger.kernel.org>; Wed, 06 Jul 2022 10:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SQIHCrXZxRbxb4t/6IOmpTMMhkU2VlZ9Pj8HK758FhE=;
        b=60YqH/y42tyFrvByoL124rsTBTMO1ZhrBCwBsYVbI7ff59R3memc+WCPcPsxfkJ+Sc
         8/KntQIeVt15Cpw+zUbPeEiMC5licbJZxKMYoufq+OVPTMclxBmMUPOW+N/xXZrfesjl
         7aLWZesvkmljDZeMUfjMqkeikZe/Vd/mxr4brHkc9eKoHidq3wPt2qRiZ/yz2htzUNqY
         kTHtegnUVcd6VgyQ88lwTtwtrHmPeoO48hrhECJnZy5ir4PlJop7X+8sDEEBinMYmDPC
         OdEoUNEVh+iFUFn9pvpjDbMahMeWIbYLlNejkTqqbOT19+bx982nRCVzC2Y/wgkObXO6
         mFMw==
X-Gm-Message-State: AJIora/UE+eM9i0RyZtNnzZk9uLNsjqhpOsjij//bJF4m/2BhlkSubV8
        FZanrvMxJXkFDL8uQGsWMytuZ2TqqzXm
X-Google-Smtp-Source: AGRyM1um6OSyP/0PZszNyQooJt67NokL9RyZ+4I39ddectX6Ebb4MCnZGfrqGqlr+PRW9cvJVnJg/Q==
X-Received: by 2002:a05:6214:1c87:b0:46b:c547:543d with SMTP id ib7-20020a0562141c8700b0046bc547543dmr37080842qvb.52.1657129447341;
        Wed, 06 Jul 2022 10:44:07 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id j17-20020a05620a289100b006a793bde241sm33577598qkp.63.2022.07.06.10.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:44:06 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [5.20 PATCH v3 2/2] dm: add two stage requeue mechanism
Date:   Wed,  6 Jul 2022 13:44:03 -0400
Message-Id: <20220706174403.79317-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220706174403.79317-1-snitzer@kernel.org>
References: <20220706174403.79317-1-snitzer@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

Commit 61b6e2e5321d ("dm: fix BLK_STS_DM_REQUEUE handling when dm_io
represents split bio") reverted DM core's bio splitting back to using
bio_split()+bio_chain() because it was found that otherwise DM's
BLK_STS_DM_REQUEUE would trigger a live-lock waiting for bio
completion that would never occur.

Restore using bio_trim()+bio_inc_remaining(), like was done in commit
7dd76d1feec7 ("dm: improve bio splitting and associated IO
accounting"), but this time with proper handling for the above
scenario that is covered in more detail in the commit header for
61b6e2e5321d.

Solve this issue by adding a two staged dm_io requeue mechanism that
uses the new bio_rewind() via dm_io_rewind():

1) requeue the dm_io into the requeue_list added to struct
   mapped_device, and schedule it via new added requeue work. This
   workqueue just clones the dm_io->orig_bio (which DM saves and
   ensures its end sector isn't modified). dm_io_rewind() uses the
   sectors and sectors_offset members of the dm_io that are recorded
   relative to the end of orig_bio: bio_rewind()+bio_trim() are then
   used to make that cloned bio reflect the subset of the original bio
   that is represented by the dm_io that is being requeued.

2) the 2nd stage requeue is same with original requeue, but
   io->orig_bio points to new cloned bio (which matches the requeued
   dm_io as described above).

This allows DM core to shift the need for bio cloning from bio-split
time (during IO submission) to the less likely BLK_STS_DM_REQUEUE
handling (after IO completes with that error).

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-core.h      |  13 ++++-
 drivers/md/dm-io-rewind.c |  25 +++++++++-
 drivers/md/dm.c           | 121 +++++++++++++++++++++++++++++++++++-----------
 3 files changed, 129 insertions(+), 30 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 5793a27b2118..5a3fe5897b1e 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -22,6 +22,8 @@
 
 #define DM_RESERVED_MAX_IOS		1024
 
+struct dm_io;
+
 struct dm_kobject_holder {
 	struct kobject kobj;
 	struct completion completion;
@@ -91,6 +93,14 @@ struct mapped_device {
 	spinlock_t deferred_lock;
 	struct bio_list deferred;
 
+	/*
+	 * requeue work context is needed for cloning one new bio
+	 * to represent the dm_io to be requeued, since each
+	 * dm_io may point to the original bio from FS.
+	 */
+	struct work_struct requeue_work;
+	struct dm_io *requeue_list;
+
 	void *interface_ptr;
 
 	/*
@@ -275,7 +285,6 @@ struct dm_io {
 	atomic_t io_count;
 	struct mapped_device *md;
 
-	struct bio *split_bio;
 	/* The three fields represent mapped part of original bio */
 	struct bio *orig_bio;
 	unsigned int sector_offset; /* offset to end of orig_bio */
@@ -319,6 +328,6 @@ extern atomic_t dm_global_event_nr;
 extern wait_queue_head_t dm_global_eventq;
 void dm_issue_global_event(void);
 
-void bio_rewind(struct bio *bio, unsigned bytes);
+void dm_io_rewind(struct dm_io *io, struct bio_set *bs);
 
 #endif
diff --git a/drivers/md/dm-io-rewind.c b/drivers/md/dm-io-rewind.c
index fbeaa8a342ed..3ba7162f85fa 100644
--- a/drivers/md/dm-io-rewind.c
+++ b/drivers/md/dm-io-rewind.c
@@ -131,7 +131,7 @@ static inline void bio_rewind_iter(const struct bio *bio,
  * rewinding from end of bio and restoring its original position.
  * Caller is also responsibile for restoring bio's size.
  */
-void bio_rewind(struct bio *bio, unsigned bytes)
+static void bio_rewind(struct bio *bio, unsigned bytes)
 {
 	if (bio_integrity(bio))
 		bio_integrity_rewind(bio, bytes);
@@ -141,3 +141,26 @@ void bio_rewind(struct bio *bio, unsigned bytes)
 
 	bio_rewind_iter(bio, &bio->bi_iter, bytes);
 }
+
+void dm_io_rewind(struct dm_io *io, struct bio_set *bs)
+{
+	struct bio *orig = io->orig_bio;
+	struct bio *new_orig = bio_alloc_clone(orig->bi_bdev, orig,
+					       GFP_NOIO, bs);
+	/*
+	 * bio_rewind can restore to previous position since the end
+	 * sector is fixed for original bio, but we still need to
+	 * restore bio's size manually (using io->sectors).
+	 */
+	bio_rewind(new_orig, ((io->sector_offset << 9) -
+			      orig->bi_iter.bi_size));
+	bio_trim(new_orig, 0, io->sectors);
+
+	bio_chain(new_orig, orig);
+	/*
+	 * __bi_remaining was increased (by dm_split_and_process_bio),
+	 * so must drop the one added in bio_chain.
+	 */
+	atomic_dec(&orig->__bi_remaining);
+	io->orig_bio = new_orig;
+}
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c987f9ad24a4..fa6839141118 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -590,7 +590,6 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	atomic_set(&io->io_count, 2);
 	this_cpu_inc(*md->pending_io);
 	io->orig_bio = bio;
-	io->split_bio = NULL;
 	io->md = md;
 	spin_lock_init(&io->lock);
 	io->start_time = jiffies;
@@ -880,13 +879,35 @@ static int __noflush_suspending(struct mapped_device *md)
 	return test_bit(DMF_NOFLUSH_SUSPENDING, &md->flags);
 }
 
+static void dm_requeue_add_io(struct dm_io *io, bool first_stage)
+{
+	struct mapped_device *md = io->md;
+
+	if (first_stage) {
+		struct dm_io *next = md->requeue_list;
+
+		md->requeue_list = io;
+		io->next = next;
+	} else {
+		bio_list_add_head(&md->deferred, io->orig_bio);
+	}
+}
+
+static void dm_kick_requeue(struct mapped_device *md, bool first_stage)
+{
+	if (first_stage)
+		queue_work(md->wq, &md->requeue_work);
+	else
+		queue_work(md->wq, &md->work);
+}
+
 /*
  * Return true if the dm_io's original bio is requeued.
  * io->status is updated with error if requeue disallowed.
  */
-static bool dm_handle_requeue(struct dm_io *io)
+static bool dm_handle_requeue(struct dm_io *io, bool first_stage)
 {
-	struct bio *bio = io->split_bio ? io->split_bio : io->orig_bio;
+	struct bio *bio = io->orig_bio;
 	bool handle_requeue = (io->status == BLK_STS_DM_REQUEUE);
 	bool handle_polled_eagain = ((io->status == BLK_STS_AGAIN) &&
 				     (bio->bi_opf & REQ_POLLED));
@@ -912,8 +933,8 @@ static bool dm_handle_requeue(struct dm_io *io)
 		spin_lock_irqsave(&md->deferred_lock, flags);
 		if ((__noflush_suspending(md) &&
 		     !WARN_ON_ONCE(dm_is_zone_write(md, bio))) ||
-		    handle_polled_eagain) {
-			bio_list_add_head(&md->deferred, bio);
+		    handle_polled_eagain || first_stage) {
+			dm_requeue_add_io(io, first_stage);
 			requeued = true;
 		} else {
 			/*
@@ -926,19 +947,21 @@ static bool dm_handle_requeue(struct dm_io *io)
 	}
 
 	if (requeued)
-		queue_work(md->wq, &md->work);
+		dm_kick_requeue(md, first_stage);
 
 	return requeued;
 }
 
-static void dm_io_complete(struct dm_io *io)
+static void __dm_io_complete(struct dm_io *io, bool first_stage)
 {
-	struct bio *bio = io->split_bio ? io->split_bio : io->orig_bio;
+	struct bio *bio = io->orig_bio;
 	struct mapped_device *md = io->md;
 	blk_status_t io_error;
 	bool requeued;
 
-	requeued = dm_handle_requeue(io);
+	requeued = dm_handle_requeue(io, first_stage);
+	if (requeued && first_stage)
+		return;
 
 	io_error = io->status;
 	if (dm_io_flagged(io, DM_IO_ACCOUNTED))
@@ -978,6 +1001,58 @@ static void dm_io_complete(struct dm_io *io)
 	}
 }
 
+static void dm_wq_requeue_work(struct work_struct *work)
+{
+	struct mapped_device *md = container_of(work, struct mapped_device,
+						requeue_work);
+	unsigned long flags;
+	struct dm_io *io;
+
+	/* reuse deferred lock to simplify dm_handle_requeue */
+	spin_lock_irqsave(&md->deferred_lock, flags);
+	io = md->requeue_list;
+	md->requeue_list = NULL;
+	spin_unlock_irqrestore(&md->deferred_lock, flags);
+
+	while (io) {
+		struct dm_io *next = io->next;
+
+		dm_io_rewind(io, &md->queue->bio_split);
+
+		io->next = NULL;
+		__dm_io_complete(io, false);
+		io = next;
+	}
+}
+
+/*
+ * Two staged requeue:
+ *
+ * 1) io->orig_bio points to the real original bio, and the part mapped to
+ *    this io must be requeued, instead of other parts of the original bio.
+ *
+ * 2) io->orig_bio points to new cloned bio which matches the requeued dm_io.
+ */
+static void dm_io_complete(struct dm_io *io)
+{
+	bool first_requeue;
+
+	/*
+	 * Only dm_io that has been split needs two stage requeue, otherwise
+	 * we may run into long bio clone chain during suspend and OOM could
+	 * be triggered.
+	 *
+	 * Also flush data dm_io won't be marked as DM_IO_WAS_SPLIT, so they
+	 * also aren't handled via the first stage requeue.
+	 */
+	if (dm_io_flagged(io, DM_IO_WAS_SPLIT))
+		first_requeue = true;
+	else
+		first_requeue = false;
+
+	__dm_io_complete(io, first_requeue);
+}
+
 /*
  * Decrements the number of outstanding ios that a bio has been
  * cloned into, completing the original io if necc.
@@ -1256,6 +1331,7 @@ static size_t dm_dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
 void dm_accept_partial_bio(struct bio *bio, unsigned n_sectors)
 {
 	struct dm_target_io *tio = clone_to_tio(bio);
+	struct dm_io *io = tio->io;
 	unsigned bio_sectors = bio_sectors(bio);
 
 	BUG_ON(dm_tio_flagged(tio, DM_TIO_IS_DUPLICATE_BIO));
@@ -1271,8 +1347,9 @@ void dm_accept_partial_bio(struct bio *bio, unsigned n_sectors)
 	 * __split_and_process_bio() may have already saved mapped part
 	 * for accounting but it is being reduced so update accordingly.
 	 */
-	dm_io_set_flag(tio->io, DM_IO_WAS_SPLIT);
-	tio->io->sectors = n_sectors;
+	dm_io_set_flag(io, DM_IO_WAS_SPLIT);
+	io->sectors = n_sectors;
+	io->sector_offset = bio_sectors(io->orig_bio);
 }
 EXPORT_SYMBOL_GPL(dm_accept_partial_bio);
 
@@ -1395,17 +1472,7 @@ static void setup_split_accounting(struct clone_info *ci, unsigned len)
 		 */
 		dm_io_set_flag(io, DM_IO_WAS_SPLIT);
 		io->sectors = len;
-	}
-
-	if (static_branch_unlikely(&stats_enabled) &&
-	    unlikely(dm_stats_used(&io->md->stats))) {
-		/*
-		 * Save bi_sector in terms of its offset from end of
-		 * original bio, only needed for DM-stats' benefit.
-		 * - saved regardless of whether split needed so that
-		 *   dm_accept_partial_bio() doesn't need to.
-		 */
-		io->sector_offset = bio_end_sector(ci->bio) - ci->sector;
+		io->sector_offset = bio_sectors(ci->bio);
 	}
 }
 
@@ -1705,11 +1772,9 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 	 * Remainder must be passed to submit_bio_noacct() so it gets handled
 	 * *after* bios already submitted have been completely processed.
 	 */
-	WARN_ON_ONCE(!dm_io_flagged(io, DM_IO_WAS_SPLIT));
-	io->split_bio = bio_split(bio, io->sectors, GFP_NOIO,
-				  &md->queue->bio_split);
-	bio_chain(io->split_bio, bio);
-	trace_block_split(io->split_bio, bio->bi_iter.bi_sector);
+	bio_trim(bio, io->sectors, ci.sector_count);
+	trace_block_split(bio, bio->bi_iter.bi_sector);
+	bio_inc_remaining(bio);
 	submit_bio_noacct(bio);
 out:
 	/*
@@ -1985,9 +2050,11 @@ static struct mapped_device *alloc_dev(int minor)
 
 	init_waitqueue_head(&md->wait);
 	INIT_WORK(&md->work, dm_wq_work);
+	INIT_WORK(&md->requeue_work, dm_wq_requeue_work);
 	init_waitqueue_head(&md->eventq);
 	init_completion(&md->kobj_holder.completion);
 
+	md->requeue_list = NULL;
 	md->swap_bios = get_swap_bios();
 	sema_init(&md->swap_bios_semaphore, md->swap_bios);
 	mutex_init(&md->swap_bios_lock);
-- 
2.15.0

