Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B09559B37
	for <lists+linux-block@lfdr.de>; Fri, 24 Jun 2022 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiFXOPW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Jun 2022 10:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiFXOPH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 10:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF39052E58
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 07:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656080101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hgwhcoi/dzrRDuO1jDKP+XfzUCm7P5OuXWnkS/1K0Fk=;
        b=UsNC72Yqc6BRmZuk6IPu4WDbXj9b343yT1IbhseIAUVJyA4RrHeI3sglH55C6elJdiXxuJ
        qH5cuoANYZYFDarMEezXk8ihTcEimwxsnFql/FXGSPvmND5EL2ixMsDHheli3QLeczTpA7
        weBT9cSN5lL161B0170M+GFrXpoWQtw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-QTr2voMxOFm1tDNNWBSo7A-1; Fri, 24 Jun 2022 10:14:53 -0400
X-MC-Unique: QTr2voMxOFm1tDNNWBSo7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 383048032F4;
        Fri, 24 Jun 2022 14:14:47 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C30C2166B26;
        Fri, 24 Jun 2022 14:14:45 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5.20 4/4] dm: add two stage requeue
Date:   Fri, 24 Jun 2022 22:12:55 +0800
Message-Id: <20220624141255.2461148-5-ming.lei@redhat.com>
In-Reply-To: <20220624141255.2461148-1-ming.lei@redhat.com>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 7dd76d1feec7 ("dm: improve bio splitting and associated IO accounting")
makes dm io's original bio points to same original bio from upper layer,
so more than one dm io can share one same original bio in case of
splitting. This way is fine if all dm io is completed successfully. But
if BLK_STS_DM_REQUEUE is returned from clone bio, the current code will
requeue the shared original bio, and cause the following issue:

1) the shared original bio has been trimmed and mapped to the last dm
   io, so it becomes not matched if requeuing this original bio

2) more than one dm io completion may touch the single shared original
   bio, such as the bio may have been submitted in one code path, but
   another code path may be ending it, so this way is very fragile.

Patch 'dm: fix BLK_STS_DM_REQUEUE handling when dm_io' can fix the
issue, but still need to clone one backing bio in case of split. We can
solve the issue by two stages requeue with help of new added bio_rewind,
then the bio clone can only be needed after BLK_STS_DM_REQUEUE happens:

1) requeue the dm io into the added requeue list, and schedule it via
new added requeue work, it is just for clone/allocate a mapped original
bio for requeue, and we recover the original bio by bio_rewind().

2) the 2nd stage requeue is same with original requeue, but io->orig_bio
points to new cloned bio which matches with the requeued dm io.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm-core.h |  11 +++-
 drivers/md/dm.c      | 131 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 116 insertions(+), 26 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index c954ff91870e..0545ce441427 100644
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
+	 * requeue work context is nedded for cloning one new bio
+	 * for representing the dm_io to be requeued since each
+	 * dm_io may point to the original bio from FS.
+	 */
+	struct work_struct requeue_work;
+	struct dm_io *requeue_list;
+
 	void *interface_ptr;
 
 	/*
@@ -272,7 +282,6 @@ struct dm_io {
 	atomic_t io_count;
 	struct mapped_device *md;
 
-	struct bio *split_bio;
 	/* The three fields represent mapped part of original bio */
 	struct bio *orig_bio;
 	unsigned int sector_offset; /* offset to end of orig_bio */
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ee22c763873f..c2b95b931c31 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -594,7 +594,6 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	atomic_set(&io->io_count, 2);
 	this_cpu_inc(*md->pending_io);
 	io->orig_bio = bio;
-	io->split_bio = NULL;
 	io->md = md;
 	spin_lock_init(&io->lock);
 	io->start_time = jiffies;
@@ -884,10 +883,32 @@ static int __noflush_suspending(struct mapped_device *md)
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
+static void dm_requeue_schedule(struct mapped_device *md, bool first_stage)
+{
+	if (first_stage)
+		queue_work(md->wq, &md->requeue_work);
+	else
+		queue_work(md->wq, &md->work);
+}
+
 /* Return true if the original bio is requeued */
-static bool dm_handle_requeue(struct dm_io *io)
+static bool dm_handle_requeue(struct dm_io *io, bool first_stage)
 {
-	struct bio *bio = io->split_bio ? io->split_bio : io->orig_bio;
+	struct bio *bio = io->orig_bio;
 	bool need_requeue = (io->status == BLK_STS_DM_REQUEUE);
 	bool handle_eagain = (io->status == BLK_STS_AGAIN) &&
 		(bio->bi_opf & REQ_POLLED);
@@ -913,9 +934,9 @@ static bool dm_handle_requeue(struct dm_io *io)
 		spin_lock_irqsave(&md->deferred_lock, flags);
 		if ((__noflush_suspending(md) &&
 		    !WARN_ON_ONCE(dm_is_zone_write(md, bio))) ||
-				handle_eagain) {
+				handle_eagain || first_stage) {
 			/* NOTE early return due to BLK_STS_DM_REQUEUE below */
-			bio_list_add_head(&md->deferred, bio);
+			dm_requeue_add_io(io, first_stage);
 			requeued = true;
 		} else {
 			/*
@@ -928,18 +949,20 @@ static bool dm_handle_requeue(struct dm_io *io)
 	}
 
 	if (requeued)
-		queue_work(md->wq, &md->work);
+		dm_requeue_schedule(md, first_stage);
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
@@ -979,6 +1002,74 @@ static void dm_io_complete(struct dm_io *io)
 	}
 }
 
+static void dm_wq_requeue_work(struct work_struct *work)
+{
+	struct mapped_device *md = container_of(work, struct mapped_device,
+			requeue_work);
+	unsigned long flags;
+	struct dm_io *io;
+
+	/* reuse deferred lock to simplify dm_handle_requeue  */
+	spin_lock_irqsave(&md->deferred_lock, flags);
+	io = md->requeue_list;
+	md->requeue_list = NULL;
+	spin_unlock_irqrestore(&md->deferred_lock, flags);
+
+	while (io) {
+		struct dm_io *next = io->next;
+		struct bio *orig = io->orig_bio;
+		struct bio *new_orig = bio_alloc_clone(orig->bi_bdev,
+				orig, GFP_NOIO, &md->queue->bio_split);
+
+		/*
+		 * bio_rewind can restore to previous position since the end
+		 * sector is fixed for original bio, but we still need to
+		 * recover sectors manually
+		 */
+		bio_rewind(new_orig, (io->sector_offset << 9) -
+				orig->bi_iter.bi_size);
+		bio_trim(new_orig, 0, io->sectors);
+
+		bio_chain(new_orig, orig);
+		/*
+		 * __bi_remaining has been increased during split, so has to
+		 * drop the one added in bio_chain
+		 */
+		atomic_dec(&orig->__bi_remaining);
+		io->orig_bio = new_orig;
+
+		io->next = NULL;
+		__dm_io_complete(io, false);
+		io = next;
+	}
+}
+
+/*
+ * Two stages requeue:
+ *
+ * 1) io->orig_bio points to the real original bio, and we should requeue
+ * the part mapped to this io, instead of other parts of the original bio
+ */
+static void dm_io_complete(struct dm_io *io)
+{
+	bool first_requeue;
+
+	/*
+	 * only split io needs two stage requeue, otherwise we may run
+	 * into bio clone chain in long suspend, and OOM could be triggered,
+	 * pointed out by Mike.
+	 *
+	 * Also flush data io won't be marked as DM_IO_WAS_SPLIT, so they
+	 * needn't to be handled via the first stage requeue.
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
@@ -1401,17 +1492,7 @@ static void setup_split_accounting(struct clone_info *ci, unsigned len)
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
 
@@ -1711,11 +1792,9 @@ static void dm_split_and_process_bio(struct mapped_device *md,
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
@@ -1991,9 +2070,11 @@ static struct mapped_device *alloc_dev(int minor)
 
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
2.31.1

