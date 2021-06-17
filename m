Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DEA3AB180
	for <lists+linux-block@lfdr.de>; Thu, 17 Jun 2021 12:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFQKje (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 17 Jun 2021 06:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229868AbhFQKjd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 06:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623926246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOSrvjRKd//Vu9Bx9z/mlQSdvDHTax8CfWbHMOwOJKI=;
        b=F0kckFiGu0FLz58T0gkbQfwt8OtG+B8Kv/04dYUEn9uuWQzJgWZ9digD34f29ldI3sjI4r
        GPj5tQaJtD3k+ZAMn0oivBoUOLe5J1HMv91rUx5+m2fekn3XXlF+anDL0hC0QFhqGGj4sR
        vJTlfNEIhcuQ1p+dImNTlEpHtLKofD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-Yoh8ONk6PkujVZNd0N_g7A-1; Thu, 17 Jun 2021 06:37:24 -0400
X-MC-Unique: Yoh8ONk6PkujVZNd0N_g7A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7532803645;
        Thu, 17 Jun 2021 10:37:23 +0000 (UTC)
Received: from localhost (ovpn-12-77.pek2.redhat.com [10.72.12.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0310019D7D;
        Thu, 17 Jun 2021 10:37:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH V2 3/3] dm: support bio polling
Date:   Thu, 17 Jun 2021 18:35:49 +0800
Message-Id: <20210617103549.930311-4-ming.lei@redhat.com>
In-Reply-To: <20210617103549.930311-1-ming.lei@redhat.com>
References: <20210617103549.930311-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Support bio(REQ_POLLED) polling in the following approach:

1) only support io polling on normal READ/WRITE, and other abnormal IOs
still fallback on IRQ mode, so the target io is exactly inside the dm
io.

2) hold one refcnt on io->io_count after submitting this dm bio with
REQ_POLLED

3) support dm native bio splitting, any dm io instance associated with
current bio will be added into one list which head is bio->bi_end_io
which will be recovered before ending this bio

4) implement .poll_bio() callback, call bio_poll() on the single target
bio inside the dm io which is retrieved via bio->bi_bio_drv_data; call
dec_pending() after the target io is done in .poll_bio()

4) enable QUEUE_FLAG_POLL if all underlying queues enable QUEUE_FLAG_POLL,
which is based on Jeffle's previous patch.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm-table.c |  24 +++++++++
 drivers/md/dm.c       | 111 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 132 insertions(+), 3 deletions(-)

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
index 363f12a285ce..9745c3deacc3 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -39,6 +39,8 @@
 #define DM_COOKIE_ENV_VAR_NAME "DM_COOKIE"
 #define DM_COOKIE_LENGTH 24
 
+#define REQ_SAVED_END_IO             REQ_DRV
+
 static const char *_name = DM_NAME;
 
 static unsigned int major = 0;
@@ -97,8 +99,11 @@ struct dm_io {
 	unsigned magic;
 	struct mapped_device *md;
 	blk_status_t status;
+	bool	submit_as_polled;
 	atomic_t io_count;
 	struct bio *orig_bio;
+	void	*saved_bio_end_io;
+	struct hlist_node  node;
 	unsigned long start_time;
 	spinlock_t endio_lock;
 	struct dm_stats_aux stats_aux;
@@ -687,6 +692,8 @@ static struct dm_target_io *alloc_tio(struct clone_info *ci, struct dm_target *t
 	tio->ti = ti;
 	tio->target_bio_nr = target_bio_nr;
 
+	WARN_ON_ONCE(ci->io->submit_as_polled && !tio->inside_dm_io);
+
 	return tio;
 }
 
@@ -938,8 +945,12 @@ static void dec_pending(struct dm_io *io, blk_status_t error)
 		end_io_acct(io);
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
@@ -1590,6 +1601,12 @@ static int __split_and_process_non_flush(struct clone_info *ci)
 	if (__process_abnormal_io(ci, ti, &r))
 		return r;
 
+	/*
+	 * Only support bio polling for normal IO, and the target io is
+	 * exactly inside the dm io instance
+	 */
+	ci->io->submit_as_polled = !!(ci->bio->bi_opf & REQ_POLLED);
+
 	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
 
 	r = __clone_and_map_data_bio(ci, ti, ci->sector, &len);
@@ -1608,6 +1625,22 @@ static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
 	ci->map = map;
 	ci->io = alloc_io(md, bio);
 	ci->sector = bio->bi_iter.bi_sector;
+
+	if (bio->bi_opf & REQ_POLLED) {
+		INIT_HLIST_NODE(&ci->io->node);
+
+		/*
+		 * Save .bi_end_io into dm_io, so that we can reuse .bi_end_io
+		 * for storing dm_io list
+		 */
+		if (bio->bi_opf & REQ_SAVED_END_IO) {
+			ci->io->saved_bio_end_io = NULL;
+		} else {
+			ci->io->saved_bio_end_io = bio->bi_end_io;
+			INIT_HLIST_HEAD((struct hlist_head *)&bio->bi_end_io);
+			bio->bi_opf |= REQ_SAVED_END_IO;
+		}
+	}
 }
 
 #define __dm_part_stat_sub(part, field, subnd)	\
@@ -1666,8 +1699,19 @@ static void __split_and_process_bio(struct mapped_device *md,
 		}
 	}
 
-	/* drop the extra reference count */
-	dec_pending(ci.io, errno_to_blk_status(error));
+	/*
+	 * Drop the extra reference count for non-POLLED bio, and hold one
+	 * reference for POLLED bio, which will be released in dm_poll_bio
+	 *
+	 * Add every dm_io instance into the hlist_head which is stored in
+	 * bio->bi_end_io, so that dm_poll_bio can poll them all.
+	 */
+	if (!ci.io->submit_as_polled)
+		dec_pending(ci.io, errno_to_blk_status(error));
+	else
+		hlist_add_head(&ci.io->node,
+				(struct hlist_head *)&bio->bi_end_io);
+
 }
 
 static void dm_submit_bio(struct bio *bio)
@@ -1707,6 +1751,66 @@ static void dm_submit_bio(struct bio *bio)
 	dm_put_live_table(md, srcu_idx);
 }
 
+static int dm_poll_dm_io(struct dm_io *io, unsigned int flags)
+{
+	if (!io || !io->submit_as_polled)
+		return 0;
+
+	WARN_ON_ONCE(!io->tio.inside_dm_io);
+	bio_poll(&io->tio.clone, flags);
+
+	/* bio_poll holds the last reference */
+	if (atomic_read(&io->io_count) == 1)
+		return 1;
+	return 0;
+}
+
+static int dm_poll_bio(struct bio *bio, unsigned int flags)
+{
+	struct dm_io *io;
+	void *saved_bi_end_io = NULL;
+	struct hlist_head tmp = HLIST_HEAD_INIT;
+	struct hlist_head *head = (struct hlist_head *)&bio->bi_end_io;
+	struct hlist_node *next;
+
+	/*
+	 * This bio can be submitted from FS as POLLED so that FS may keep
+	 * polling even though the flag is cleared by bio splitting or
+	 * requeue, so return immediately.
+	 */
+	if (!(bio->bi_opf & REQ_POLLED))
+		return 0;
+
+	hlist_move_list(head, &tmp);
+
+	hlist_for_each_entry(io, &tmp, node) {
+		if (io->saved_bio_end_io && !saved_bi_end_io) {
+			saved_bi_end_io = io->saved_bio_end_io;
+			break;
+		}
+	}
+
+	/* restore .bi_end_io before completing dm io */
+	WARN_ON_ONCE(!saved_bi_end_io);
+	bio->bi_end_io = saved_bi_end_io;
+
+	hlist_for_each_entry_safe(io, next, &tmp, node) {
+		if (dm_poll_dm_io(io, flags)) {
+			hlist_del_init(&io->node);
+			dec_pending(io, 0);
+		}
+	}
+
+	/* Not done, make sure at least one dm_io stores the .bi_end_io*/
+	if (!hlist_empty(&tmp)) {
+		io = hlist_entry(tmp.first, struct dm_io, node);
+		io->saved_bio_end_io = saved_bi_end_io;
+		hlist_move_list(&tmp, head);
+		return 0;
+	}
+	return 1;
+}
+
 /*-----------------------------------------------------------------
  * An IDR is used to keep track of allocated minor numbers.
  *---------------------------------------------------------------*/
@@ -3121,6 +3225,7 @@ static const struct pr_ops dm_pr_ops = {
 
 static const struct block_device_operations dm_blk_dops = {
 	.submit_bio = dm_submit_bio,
+	.poll_bio = dm_poll_bio,
 	.open = dm_blk_open,
 	.release = dm_blk_close,
 	.ioctl = dm_blk_ioctl,
-- 
2.31.1

