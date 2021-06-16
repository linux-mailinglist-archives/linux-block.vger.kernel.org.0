Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BB53A9B98
	for <lists+linux-block@lfdr.de>; Wed, 16 Jun 2021 15:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhFPNJW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Jun 2021 09:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233216AbhFPNJO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 09:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623848828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BEhUb1+MSBqGbDrvS0aXPNhm/VOfq1IJXBnWhNckb9Y=;
        b=Svrybgb/+q5lqqUrl2O6LdZEDmZjB09UzU3C0IJSmJaAHvFGPKccWE+BRF5jzJFz8J/jWv
        y4KDqX/+l0Djh2MpgJ7BTiBAZSYRoAQjmlb8qC45hMq9m+go9V3dU1r/MLaSqcAzRnFyu9
        U8IPmdVC+1WYyMBsIxJkvQsZj65Z/pU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-ZwfcfrUQM3iVN1CF2GXPCw-1; Wed, 16 Jun 2021 09:07:06 -0400
X-MC-Unique: ZwfcfrUQM3iVN1CF2GXPCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE0A9100CAAF;
        Wed, 16 Jun 2021 13:07:03 +0000 (UTC)
Received: from localhost (ovpn-12-48.pek2.redhat.com [10.72.12.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E15D60C13;
        Wed, 16 Jun 2021 13:07:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 4/4] dm: support bio polling
Date:   Wed, 16 Jun 2021 21:05:33 +0800
Message-Id: <20210616130533.754248-5-ming.lei@redhat.com>
In-Reply-To: <20210616130533.754248-1-ming.lei@redhat.com>
References: <20210616130533.754248-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Support bio(REQ_POLLED) polling in the following approach:

1) setup one list in instance of 'struct dm_io', adds every 'struct
dm_target_io' instance cloned for current dm bio into this list;
store the list in 1) into bio->bi_bio_drv_data

2) hold one refcnt on io->io_count after submitting this dm bio with
REQ_POLLED

4) implement .poll_bio() callback, and iterate over the list in 1) and
polled on each ->clone of 'dm_target_io' instance; call dec_pending()
if all target ios are done in .poll_bio().

4) enable QUEUE_FLAG_POLL if all underlying queues enable QUEUE_FLAG_POLL,
which is based on Jeffle's previous patch.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm-table.c | 24 ++++++++++++++++++
 drivers/md/dm.c       | 59 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index ee47a332b462..b14b379442d2 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1491,6 +1491,12 @@ struct dm_target *dm_table_find_target(struct dm_table *t, sector_t sector)
 	return &t->targets[(KEYS_PER_NODE * n) + k];
 }
 
+static int device_not_poll_capable(struct dm_target *ti, struct dm_dev *dev,
+				   sector_t start, sector_t len, void *data)
+{
+	return !blk_queue_poll(bdev_get_queue(dev->bdev));
+}
+
 /*
  * type->iterate_devices() should be called when the sanity check needs to
  * iterate and check all underlying data devices. iterate_devices() will
@@ -1541,6 +1547,11 @@ static int count_device(struct dm_target *ti, struct dm_dev *dev,
 	return 0;
 }
 
+static int dm_table_supports_poll(struct dm_table *t)
+{
+	return !dm_table_any_dev_attr(t, device_not_poll_capable, NULL);
+}
+
 /*
  * Check whether a table has no data devices attached using each
  * target's iterate_devices method.
@@ -2078,6 +2089,19 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 
 	dm_update_keyslot_manager(q, t);
 	blk_queue_update_readahead(q);
+
+	/*
+	 * Check for request-based device is remained to
+	 * dm_mq_init_request_queue()->blk_mq_init_allocated_queue().
+	 * For bio-based device, only set QUEUE_FLAG_POLL when all underlying
+	 * devices supporting polling.
+	 */
+	if (__table_type_bio_based(t->type)) {
+		if (dm_table_supports_poll(t))
+			blk_queue_flag_set(QUEUE_FLAG_POLL, q);
+		else
+			blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
+	}
 }
 
 unsigned int dm_table_get_num_targets(struct dm_table *t)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 363f12a285ce..0a0e4a38f435 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -84,6 +84,7 @@ struct dm_target_io {
 	struct dm_target *ti;
 	unsigned target_bio_nr;
 	unsigned *len_ptr;
+	struct list_head list;
 	bool inside_dm_io;
 	struct bio clone;
 };
@@ -99,6 +100,7 @@ struct dm_io {
 	blk_status_t status;
 	atomic_t io_count;
 	struct bio *orig_bio;
+	struct list_head poll_head;
 	unsigned long start_time;
 	spinlock_t endio_lock;
 	struct dm_stats_aux stats_aux;
@@ -655,6 +657,11 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	io->md = md;
 	spin_lock_init(&io->endio_lock);
 
+	if (bio->bi_opf & REQ_POLLED) {
+		bio->bi_bio_drv_data = io;
+		INIT_LIST_HEAD(&io->poll_head);
+	}
+
 	start_io_acct(io);
 
 	return io;
@@ -692,6 +699,8 @@ static struct dm_target_io *alloc_tio(struct clone_info *ci, struct dm_target *t
 
 static void free_tio(struct dm_target_io *tio)
 {
+	list_del_init(&tio->list);
+
 	if (tio->inside_dm_io)
 		return;
 	bio_put(&tio->clone);
@@ -936,10 +945,15 @@ static void dec_pending(struct dm_io *io, blk_status_t error)
 		io_error = io->status;
 		bio = io->orig_bio;
 		end_io_acct(io);
+
 		free_io(md, io);
 
-		if (io_error == BLK_STS_DM_REQUEUE)
+		if (io_error == BLK_STS_DM_REQUEUE) {
+			/* not poll any more in case of requeue */
+			if (bio->bi_opf & REQ_POLLED)
+				bio->bi_opf &= ~REQ_POLLED;
 			return;
+		}
 
 		if ((bio->bi_opf & REQ_PREFLUSH) && bio->bi_iter.bi_size) {
 			/*
@@ -1043,7 +1057,9 @@ static void clone_endio(struct bio *bio)
 		up(&md->swap_bios_semaphore);
 	}
 
-	free_tio(tio);
+	/* Any cloned bio submitted as POLLED, free them all after dm_io is done */
+	if (list_empty(&tio->list))
+		free_tio(tio);
 	dec_pending(io, error);
 }
 
@@ -1300,6 +1316,11 @@ static void __map_bio(struct dm_target_io *tio)
 	struct dm_io *io = tio->io;
 	struct dm_target *ti = tio->ti;
 
+	if (clone->bi_opf & REQ_POLLED)
+		list_add_tail(&tio->list, &io->poll_head);
+	else
+		INIT_LIST_HEAD(&tio->list);
+
 	clone->bi_end_io = clone_endio;
 
 	/*
@@ -1666,8 +1687,9 @@ static void __split_and_process_bio(struct mapped_device *md,
 		}
 	}
 
-	/* drop the extra reference count */
-	dec_pending(ci.io, errno_to_blk_status(error));
+	/* drop the extra reference count for non-POLLED bio */
+	if (!(bio->bi_opf & REQ_POLLED))
+		dec_pending(ci.io, errno_to_blk_status(error));
 }
 
 static void dm_submit_bio(struct bio *bio)
@@ -1707,6 +1729,34 @@ static void dm_submit_bio(struct bio *bio)
 	dm_put_live_table(md, srcu_idx);
 }
 
+static int dm_poll_bio(struct bio *bio, unsigned int flags)
+{
+	struct dm_io *io = bio->bi_bio_drv_data;
+	struct dm_target_io *tio;
+
+	if (!(bio->bi_opf & REQ_POLLED) || !io)
+		return 0;
+
+	list_for_each_entry(tio, &io->poll_head, list)
+		bio_poll(&tio->clone, flags);
+
+	/* bio_poll holds the last reference */
+	if (atomic_read(&io->io_count) == 1) {
+		/* free all target IOs submitted as POLLED */
+		while (!list_empty(&io->poll_head)) {
+			struct dm_target_io *tio =
+				list_entry(io->poll_head.next,
+					struct dm_target_io, list);
+			free_tio(tio);
+		}
+		bio->bi_bio_drv_data = NULL;
+		dec_pending(io, 0);
+		return 1;
+	}
+
+	return 0;
+}
+
 /*-----------------------------------------------------------------
  * An IDR is used to keep track of allocated minor numbers.
  *---------------------------------------------------------------*/
@@ -3121,6 +3171,7 @@ static const struct pr_ops dm_pr_ops = {
 
 static const struct block_device_operations dm_blk_dops = {
 	.submit_bio = dm_submit_bio,
+	.poll_bio = dm_poll_bio,
 	.open = dm_blk_open,
 	.release = dm_blk_close,
 	.ioctl = dm_blk_ioctl,
-- 
2.31.1

