Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC224D06F3
	for <lists+linux-block@lfdr.de>; Mon,  7 Mar 2022 19:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244853AbiCGSyG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 7 Mar 2022 13:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244855AbiCGSyF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 13:54:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 847E86C937
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 10:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646679189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=/Z2LJrPIpwJYpGqeWhLkh4LVDBRQyZ7SQ90lff9xFYE=;
        b=PRZC6d/DbgUNP7i9XFCLOvfVJSngSTnL/XglXo5yQC7vTTdTxaakaUhU7SGeWbGUCFAQlz
        GfFzYeJgEwL719IXR7MQ6FQRZDLNm2UV7jiCiacJLkDuT1UYOUI4nkunnQB6RlIZiMHVX9
        zDkfZHvpo0Aw3BupFqm0mqRk7CF5ncw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-vmovXmyIOUKY4Ilv5fU0Sg-1; Mon, 07 Mar 2022 13:53:08 -0500
X-MC-Unique: vmovXmyIOUKY4Ilv5fU0Sg-1
Received: by mail-qv1-f70.google.com with SMTP id m19-20020a056214159300b004352bebfd8bso12575333qvw.6
        for <linux-block@vger.kernel.org>; Mon, 07 Mar 2022 10:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Z2LJrPIpwJYpGqeWhLkh4LVDBRQyZ7SQ90lff9xFYE=;
        b=NzVWW912f/oOq7JVlDWJ08GML2QqjcBj3FeIZjjJz7YrigZlHK+wxhG6+QyoO5yTAW
         BPCLJy0yyK/QdQ/ekAUciJeL6bwEPwhlZEFwLR3rNcJ6Ujxggm1qoQsqpIQcdbY/947f
         AdAVy7zfKtyNQuiH7net4V32aheUEKY0naVMSlxkXMBcI8dIDdAGk/lN0W4MKwoPgOdX
         7McGlsWzeiT959R4sFKUu5oPSbQJJWE5/I+c6Rk9OdA6shnMNNVSXWs09Jut+Qy39yAc
         3dhb7NWDB7j1QND5NLmCCCoLyUu2RPoXyVIgwx/D7HkIdnuRhxy55qKegHXKTTyQ5xWJ
         TvgA==
X-Gm-Message-State: AOAM530KlIPOeJrhWg6loyR9l++NdmvSYZqOQKC9V+1llypQtTqiTGiU
        oEzHXzyru6w1OG6yysXHLJ+ua+qxLH7a/jb65cWMmxiGN2GElxMbijFGLzsWlWBojOofZoFS5y4
        34sUeWeZGgVTELzt27aFdJw==
X-Received: by 2002:ac8:5a87:0:b0:2e0:6ddb:e234 with SMTP id c7-20020ac85a87000000b002e06ddbe234mr1521929qtc.537.1646679187630;
        Mon, 07 Mar 2022 10:53:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKRa1Ta5VVzDPEfarqApTkFz20fPYrC8KD/0D9/A/vI5/Kc4fgB/K2KH/pA3ekmrq6hsWmEg==
X-Received: by 2002:ac8:5a87:0:b0:2e0:6ddb:e234 with SMTP id c7-20020ac85a87000000b002e06ddbe234mr1521909qtc.537.1646679187251;
        Mon, 07 Mar 2022 10:53:07 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id az33-20020a05620a172100b00648af7287desm6256355qkb.26.2022.03.07.10.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 10:53:06 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v6 2/2] dm: support bio polling
Date:   Mon,  7 Mar 2022 13:53:03 -0500
Message-Id: <20220307185303.71201-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220307185303.71201-1-snitzer@redhat.com>
References: <20220307185303.71201-1-snitzer@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

Support bio(REQ_POLLED) polling in the following approach:

1) only support io polling on normal READ/WRITE, and other abnormal IOs
still fallback to IRQ mode, so the target io is exactly inside the dm
io.

2) hold one refcnt on io->io_count after submitting this dm bio with
REQ_POLLED

3) support dm native bio splitting, any dm io instance associated with
current bio will be added into one list which head is bio->bi_private
which will be recovered before ending this bio

4) implement .poll_bio() callback, call bio_poll() on the single target
bio inside the dm io which is retrieved via bio->bi_bio_drv_data; call
dm_io_dec_pending() after the target io is done in .poll_bio()

5) enable QUEUE_FLAG_POLL if all underlying queues enable QUEUE_FLAG_POLL,
which is based on Jeffle's previous patch.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-core.h  |   2 +
 drivers/md/dm-table.c |  27 ++++++++++
 drivers/md/dm.c       | 143 ++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 169 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 8078b6c155ef..8cc03c0c262e 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -235,6 +235,8 @@ struct dm_io {
 	bool start_io_acct:1;
 	int was_accounted;
 	unsigned long start_time;
+	void *data;
+	struct hlist_node node;
 	spinlock_t endio_lock;
 	struct dm_stats_aux stats_aux;
 	/* last member of dm_target_io is 'struct bio' */
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index f4ed756ab391..c0be4f60b427 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1481,6 +1481,14 @@ struct dm_target *dm_table_find_target(struct dm_table *t, sector_t sector)
 	return &t->targets[(KEYS_PER_NODE * n) + k];
 }
 
+static int device_not_poll_capable(struct dm_target *ti, struct dm_dev *dev,
+				   sector_t start, sector_t len, void *data)
+{
+	struct request_queue *q = bdev_get_queue(dev->bdev);
+
+	return !test_bit(QUEUE_FLAG_POLL, &q->queue_flags);
+}
+
 /*
  * type->iterate_devices() should be called when the sanity check needs to
  * iterate and check all underlying data devices. iterate_devices() will
@@ -1531,6 +1539,11 @@ static int count_device(struct dm_target *ti, struct dm_dev *dev,
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
@@ -2067,6 +2080,20 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	dm_update_crypto_profile(q, t);
 	disk_update_readahead(t->md->disk);
 
+	/*
+	 * Check for request-based device is left to
+	 * dm_mq_init_request_queue()->blk_mq_init_allocated_queue().
+	 *
+	 * For bio-based device, only set QUEUE_FLAG_POLL when all
+	 * underlying devices supporting polling.
+	 */
+	if (__table_type_bio_based(t->type)) {
+		if (dm_table_supports_poll(t))
+			blk_queue_flag_set(QUEUE_FLAG_POLL, q);
+		else
+			blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 454d39bc7745..d9111e17f0fc 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -40,6 +40,13 @@
 #define DM_COOKIE_ENV_VAR_NAME "DM_COOKIE"
 #define DM_COOKIE_LENGTH 24
 
+/*
+ * For REQ_POLLED fs bio, this flag is set if we link mapped underlying
+ * dm_io into one list, and reuse bio->bi_private as the list head. Before
+ * ending this fs bio, we will recover its ->bi_private.
+ */
+#define REQ_DM_POLL_LIST	REQ_DRV
+
 static const char *_name = DM_NAME;
 
 static unsigned int major = 0;
@@ -73,6 +80,7 @@ struct clone_info {
 	struct dm_io *io;
 	sector_t sector;
 	unsigned sector_count;
+	bool submit_as_polled;
 };
 
 #define DM_TARGET_IO_BIO_OFFSET (offsetof(struct dm_target_io, clone))
@@ -599,6 +607,9 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 		if (!clone)
 			return NULL;
 
+		/* REQ_DM_POLL_LIST shouldn't be inherited */
+		clone->bi_opf &= ~REQ_DM_POLL_LIST;
+
 		tio = clone_to_tio(clone);
 		tio->inside_dm_io = false;
 	}
@@ -888,8 +899,15 @@ void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 		if (unlikely(wq_has_sleeper(&md->wait)))
 			wake_up(&md->wait);
 
-		if (io_error == BLK_STS_DM_REQUEUE)
+		if (io_error == BLK_STS_DM_REQUEUE) {
+			/*
+			 * Upper layer won't help us poll split bio, io->orig_bio
+			 * may only reflect a subset of the pre-split original,
+			 * so clear REQ_POLLED in case of requeue
+			 */
+			bio->bi_opf &= ~REQ_POLLED;
 			return;
+		}
 
 		if (bio_is_flush_with_data(bio)) {
 			/*
@@ -1440,6 +1458,47 @@ static bool __process_abnormal_io(struct clone_info *ci, struct dm_target *ti,
 	return true;
 }
 
+/*
+ * Reuse ->bi_private as hlist head for storing all dm_io instances
+ * associated with this bio, and this bio's bi_private needs to be
+ * stored in dm_io->data before the reuse.
+ *
+ * bio->bi_private is owned by fs or upper layer, so block layer won't
+ * touch it after splitting. Meantime it won't be changed by anyone after
+ * bio is submitted. So this reuse is safe.
+ */
+static inline struct hlist_head *dm_get_bio_hlist_head(struct bio *bio)
+{
+	return (struct hlist_head *)&bio->bi_private;
+}
+
+static void dm_queue_poll_io(struct bio *bio, struct dm_io *io)
+{
+	struct hlist_head *head = dm_get_bio_hlist_head(bio);
+
+	if (!(bio->bi_opf & REQ_DM_POLL_LIST)) {
+		bio->bi_opf |= REQ_DM_POLL_LIST;
+		/*
+		 * Save .bi_private into dm_io, so that we can reuse
+		 * .bi_private as hlist head for storing dm_io list
+		 */
+		io->data = bio->bi_private;
+
+		INIT_HLIST_HEAD(head);
+
+		/* tell block layer to poll for completion */
+		bio->bi_cookie = ~BLK_QC_T_NONE;
+	} else {
+		/*
+		 * bio recursed due to split, reuse original poll list,
+		 * and save bio->bi_private too.
+		 */
+		io->data = hlist_entry(head->first, struct dm_io, node)->data;
+	}
+
+	hlist_add_head(&io->node, head);
+}
+
 /*
  * Select the correct strategy for processing a non-flush bio.
  */
@@ -1457,6 +1516,12 @@ static int __split_and_process_bio(struct clone_info *ci)
 	if (__process_abnormal_io(ci, ti, &r))
 		return r;
 
+	/*
+	 * Only support bio polling for normal IO, and the target io is
+	 * exactly inside the dm_io instance (verified in dm_poll_dm_io)
+	 */
+	ci->submit_as_polled = ci->bio->bi_opf & REQ_POLLED;
+
 	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
 	clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
 	__map_bio(clone);
@@ -1473,6 +1538,7 @@ static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
 	ci->map = map;
 	ci->io = alloc_io(md, bio);
 	ci->bio = bio;
+	ci->submit_as_polled = false;
 	ci->sector = bio->bi_iter.bi_sector;
 	ci->sector_count = bio_sectors(bio);
 
@@ -1522,8 +1588,17 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 	if (ci.io->start_io_acct)
 		dm_start_io_acct(ci.io, NULL);
 
-	/* drop the extra reference count */
-	dm_io_dec_pending(ci.io, errno_to_blk_status(error));
+	/*
+	 * Drop the extra reference count for non-POLLED bio, and hold one
+	 * reference for POLLED bio, which will be released in dm_poll_bio
+	 *
+	 * Add every dm_io instance into the hlist_head which is stored in
+	 * bio->bi_private, so that dm_poll_bio can poll them all.
+	 */
+	if (error || !ci.submit_as_polled)
+		dm_io_dec_pending(ci.io, errno_to_blk_status(error));
+	else
+		dm_queue_poll_io(bio, ci.io);
 }
 
 static void dm_submit_bio(struct bio *bio)
@@ -1558,6 +1633,67 @@ static void dm_submit_bio(struct bio *bio)
 	dm_put_live_table(md, srcu_idx);
 }
 
+static bool dm_poll_dm_io(struct dm_io *io, struct io_comp_batch *iob,
+			  unsigned int flags)
+{
+	WARN_ON_ONCE(!io->tio.inside_dm_io);
+
+	/* don't poll if the mapped io is done */
+	if (atomic_read(&io->io_count) > 1)
+		bio_poll(&io->tio.clone, iob, flags);
+
+	/* bio_poll holds the last reference */
+	return atomic_read(&io->io_count) == 1;
+}
+
+static int dm_poll_bio(struct bio *bio, struct io_comp_batch *iob,
+		       unsigned int flags)
+{
+	struct hlist_head *head = dm_get_bio_hlist_head(bio);
+	struct hlist_head tmp = HLIST_HEAD_INIT;
+	struct hlist_node *next;
+	struct dm_io *io;
+
+	/* Only poll normal bio which was marked as REQ_DM_POLL_LIST */
+	if (!(bio->bi_opf & REQ_DM_POLL_LIST))
+		return 0;
+
+	WARN_ON_ONCE(hlist_empty(head));
+
+	hlist_move_list(head, &tmp);
+
+	/*
+	 * Restore .bi_private before possibly completing dm_io.
+	 *
+	 * bio_poll() is only possible once @bio has been completely
+	 * submitted via submit_bio_noacct()'s depth-first submission.
+	 * So there is no dm_queue_poll_io() race associated with
+	 * clearing REQ_DM_POLL_LIST here.
+	 */
+	bio->bi_opf &= ~REQ_DM_POLL_LIST;
+	bio->bi_private = hlist_entry(tmp.first, struct dm_io, node)->data;
+
+	hlist_for_each_entry_safe(io, next, &tmp, node) {
+		if (dm_poll_dm_io(io, iob, flags)) {
+			hlist_del_init(&io->node);
+			/*
+			 * clone_endio() has already occurred, so passing
+			 * error as 0 here doesn't override io->status
+			 */
+			dm_io_dec_pending(io, 0);
+		}
+	}
+
+	/* Not done? */
+	if (!hlist_empty(&tmp)) {
+		bio->bi_opf |= REQ_DM_POLL_LIST;
+		/* Reset bio->bi_private to dm_io list head */
+		hlist_move_list(&tmp, head);
+		return 0;
+	}
+	return 1;
+}
+
 /*-----------------------------------------------------------------
  * An IDR is used to keep track of allocated minor numbers.
  *---------------------------------------------------------------*/
@@ -2983,6 +3119,7 @@ static const struct pr_ops dm_pr_ops = {
 
 static const struct block_device_operations dm_blk_dops = {
 	.submit_bio = dm_submit_bio,
+	.poll_bio = dm_poll_bio,
 	.open = dm_blk_open,
 	.release = dm_blk_close,
 	.ioctl = dm_blk_ioctl,
-- 
2.15.0

