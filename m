Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36A24CDB75
	for <lists+linux-block@lfdr.de>; Fri,  4 Mar 2022 18:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241143AbiCDR46 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 4 Mar 2022 12:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbiCDR45 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 12:56:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E44A1C3D05;
        Fri,  4 Mar 2022 09:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iKVBBXaqFjfIf1d56f9yEQAy3Aw63F/J67aUj/whgvE=; b=gUgE4/4nOquRgV8QdIdl50hjbt
        jxsHNnXo7hOdDkgThrbGpYHy4AXNHwD8OhW6HE40/BfXOc5HMmc4gXm/9rAGMjHZ9tNe9PdEgw5A+
        rPK0ZPnegFDGYSNuIVK2BO+di7Zp9m51LObSibGgJFevlUctHj/GE+d7ybV9p0wLM2Wn+tGu0kdlv
        8OyIyFcNOiQ3abLnYwne506E8BegZBB9qexWm7ZfnU4lS2ExSjHiV9r9BuDAe2unoueOhvWOXcSYV
        S22xT24ZxSm6eNL+EayUoIjzaoWowcGspU4Y73nlnUhosiFUsDDxaYIcT0YhTdUHUkwWvjOReVBM6
        IqVpfhBg==;
Received: from [2001:4bb8:180:5296:cded:8d4b:ace6:f3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQC9p-00BSPb-BE; Fri, 04 Mar 2022 17:56:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     sagi@grimberg.me, kbusch@kernel.org, song@kernel.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] block: remove the per-bio/request write hint
Date:   Fri,  4 Mar 2022 18:55:56 +0100
Message-Id: <20220304175556.407719-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304175556.407719-1-hch@lst.de>
References: <20220304175556.407719-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the NVMe support for this gone, there are no consumers of these hints
left, so remove them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                 |  2 --
 block/blk-crypto-fallback.c |  1 -
 block/blk-merge.c           | 14 --------------
 block/blk-mq-debugfs.c      | 24 ------------------------
 block/blk-mq.c              |  1 -
 block/bounce.c              |  1 -
 block/fops.c                |  3 ---
 drivers/md/raid1.c          |  2 --
 drivers/md/raid5-ppl.c      | 28 +++-------------------------
 drivers/md/raid5.c          |  6 ------
 fs/btrfs/extent_io.c        |  1 -
 fs/buffer.c                 | 13 +++++--------
 fs/direct-io.c              |  3 ---
 fs/ext4/page-io.c           |  5 +----
 fs/f2fs/data.c              |  2 --
 fs/gfs2/lops.c              |  1 -
 fs/iomap/buffered-io.c      |  2 --
 fs/iomap/direct-io.c        |  1 -
 fs/mpage.c                  |  1 -
 fs/zonefs/super.c           |  1 -
 include/linux/blk_types.h   |  1 -
 include/linux/blkdev.h      |  3 ---
 22 files changed, 9 insertions(+), 107 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b15f5466ce084..88e63bb187482 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -257,7 +257,6 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	bio->bi_opf = opf;
 	bio->bi_flags = 0;
 	bio->bi_ioprio = 0;
-	bio->bi_write_hint = 0;
 	bio->bi_status = 0;
 	bio->bi_iter.bi_sector = 0;
 	bio->bi_iter.bi_size = 0;
@@ -737,7 +736,6 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	    bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio = bio_src->bi_ioprio;
-	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_iter = bio_src->bi_iter;
 
 	bio_clone_blkg_association(bio, bio_src);
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 18c8eafe20b94..7c854584b52b5 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -170,7 +170,6 @@ static struct bio *blk_crypto_fallback_clone_bio(struct bio *bio_src)
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_opf		= bio_src->bi_opf;
 	bio->bi_ioprio		= bio_src->bi_ioprio;
-	bio->bi_write_hint	= bio_src->bi_write_hint;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index f5255991b773c..0e871d4e7cb8d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -782,13 +782,6 @@ static struct request *attempt_merge(struct request_queue *q,
 	    !blk_write_same_mergeable(req->bio, next->bio))
 		return NULL;
 
-	/*
-	 * Don't allow merge of different write hints, or for a hint with
-	 * non-hint IO.
-	 */
-	if (req->write_hint != next->write_hint)
-		return NULL;
-
 	if (req->ioprio != next->ioprio)
 		return NULL;
 
@@ -915,13 +908,6 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	    !blk_write_same_mergeable(rq->bio, bio))
 		return false;
 
-	/*
-	 * Don't allow merge of different write hints, or for a hint with
-	 * non-hint IO.
-	 */
-	if (rq->write_hint != bio->bi_write_hint)
-		return false;
-
 	if (rq->ioprio != bio_prio(bio))
 		return false;
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3a790eb4995c6..c2904c75c160f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -183,35 +183,11 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 	return count;
 }
 
-static int queue_write_hint_show(void *data, struct seq_file *m)
-{
-	struct request_queue *q = data;
-	int i;
-
-	for (i = 0; i < BLK_MAX_WRITE_HINTS; i++)
-		seq_printf(m, "hint%d: %llu\n", i, q->write_hints[i]);
-
-	return 0;
-}
-
-static ssize_t queue_write_hint_store(void *data, const char __user *buf,
-				      size_t count, loff_t *ppos)
-{
-	struct request_queue *q = data;
-	int i;
-
-	for (i = 0; i < BLK_MAX_WRITE_HINTS; i++)
-		q->write_hints[i] = 0;
-
-	return count;
-}
-
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
 	{ "poll_stat", 0400, queue_poll_stat_show },
 	{ "requeue_list", 0400, .seq_ops = &queue_requeue_list_seq_ops },
 	{ "pm_only", 0600, queue_pm_only_show, NULL },
 	{ "state", 0600, queue_state_show, queue_state_write },
-	{ "write_hints", 0600, queue_write_hint_show, queue_write_hint_store },
 	{ "zone_wlock", 0400, queue_zone_wlock_show, NULL },
 	{ },
 };
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a05ce77250316..f28023b0a87eb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2402,7 +2402,6 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
 		rq->cmd_flags |= REQ_FAILFAST_MASK;
 
 	rq->__sector = bio->bi_iter.bi_sector;
-	rq->write_hint = bio->bi_write_hint;
 	blk_rq_bio_prep(rq, bio, nr_segs);
 
 	/* This can't fail, since GFP_NOIO includes __GFP_DIRECT_RECLAIM. */
diff --git a/block/bounce.c b/block/bounce.c
index 3d50d19cde72a..9db1256d57d55 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -169,7 +169,6 @@ static struct bio *bounce_clone_bio(struct bio *bio_src)
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio		= bio_src->bi_ioprio;
-	bio->bi_write_hint	= bio_src->bi_write_hint;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
diff --git a/block/fops.c b/block/fops.c
index 3696665e586a8..037f12294c863 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -83,7 +83,6 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 		bio_init(&bio, bdev, vecs, nr_pages, dio_bio_write_op(iocb));
 	}
 	bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
-	bio.bi_write_hint = iocb->ki_hint;
 	bio.bi_private = current;
 	bio.bi_end_io = blkdev_bio_end_io_simple;
 	bio.bi_ioprio = iocb->ki_ioprio;
@@ -225,7 +224,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 	for (;;) {
 		bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
-		bio->bi_write_hint = iocb->ki_hint;
 		bio->bi_private = dio;
 		bio->bi_end_io = blkdev_bio_end_io;
 		bio->bi_ioprio = iocb->ki_ioprio;
@@ -325,7 +323,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	dio->flags = 0;
 	dio->iocb = iocb;
 	bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
-	bio->bi_write_hint = iocb->ki_hint;
 	bio->bi_end_io = blkdev_bio_end_io_async;
 	bio->bi_ioprio = iocb->ki_ioprio;
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index c3288d46948de..c3ce6afd60a71 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1137,8 +1137,6 @@ static void alloc_behind_master_bio(struct r1bio *r1_bio,
 		goto skip_copy;
 	}
 
-	behind_bio->bi_write_hint = bio->bi_write_hint;
-
 	while (i < vcnt && size) {
 		struct page *page;
 		int len = min_t(int, PAGE_SIZE, size);
diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 3446797fa0aca..282ce16ee4e1f 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -469,7 +469,6 @@ static void ppl_submit_iounit(struct ppl_io_unit *io)
 	bio_set_dev(bio, log->rdev->bdev);
 	bio->bi_iter.bi_sector = log->next_io_sector;
 	bio_add_page(bio, io->header_page, PAGE_SIZE, 0);
-	bio->bi_write_hint = ppl_conf->write_hint;
 
 	pr_debug("%s: log->current_io_sector: %llu\n", __func__,
 	    (unsigned long long)log->next_io_sector);
@@ -499,7 +498,6 @@ static void ppl_submit_iounit(struct ppl_io_unit *io)
 			bio = bio_alloc_bioset(prev->bi_bdev, BIO_MAX_VECS,
 					       prev->bi_opf, GFP_NOIO,
 					       &ppl_conf->bs);
-			bio->bi_write_hint = prev->bi_write_hint;
 			bio->bi_iter.bi_sector = bio_end_sector(prev);
 			bio_add_page(bio, sh->ppl_page, PAGE_SIZE, 0);
 
@@ -1402,7 +1400,6 @@ int ppl_init_log(struct r5conf *conf)
 	atomic64_set(&ppl_conf->seq, 0);
 	INIT_LIST_HEAD(&ppl_conf->no_mem_stripes);
 	spin_lock_init(&ppl_conf->no_mem_stripes_lock);
-	ppl_conf->write_hint = RWH_WRITE_LIFE_NOT_SET;
 
 	if (!mddev->external) {
 		ppl_conf->signature = ~crc32c_le(~0, mddev->uuid, sizeof(mddev->uuid));
@@ -1501,25 +1498,13 @@ int ppl_modify_log(struct r5conf *conf, struct md_rdev *rdev, bool add)
 static ssize_t
 ppl_write_hint_show(struct mddev *mddev, char *buf)
 {
-	size_t ret = 0;
-	struct r5conf *conf;
-	struct ppl_conf *ppl_conf = NULL;
-
-	spin_lock(&mddev->lock);
-	conf = mddev->private;
-	if (conf && raid5_has_ppl(conf))
-		ppl_conf = conf->log_private;
-	ret = sprintf(buf, "%d\n", ppl_conf ? ppl_conf->write_hint : 0);
-	spin_unlock(&mddev->lock);
-
-	return ret;
+	return sprintf(buf, "%d\n", 0);
 }
 
 static ssize_t
 ppl_write_hint_store(struct mddev *mddev, const char *page, size_t len)
 {
 	struct r5conf *conf;
-	struct ppl_conf *ppl_conf;
 	int err = 0;
 	unsigned short new;
 
@@ -1533,17 +1518,10 @@ ppl_write_hint_store(struct mddev *mddev, const char *page, size_t len)
 		return err;
 
 	conf = mddev->private;
-	if (!conf) {
+	if (!conf)
 		err = -ENODEV;
-	} else if (raid5_has_ppl(conf)) {
-		ppl_conf = conf->log_private;
-		if (!ppl_conf)
-			err = -EINVAL;
-		else
-			ppl_conf->write_hint = new;
-	} else {
+	else if (!raid5_has_ppl(conf) || !conf->log_private)
 		err = -EINVAL;
-	}
 
 	mddev_unlock(mddev);
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 8891aaba65964..78503db55ca4e 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1210,9 +1210,6 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 			bi->bi_io_vec[0].bv_len = RAID5_STRIPE_SIZE(conf);
 			bi->bi_io_vec[0].bv_offset = sh->dev[i].offset;
 			bi->bi_iter.bi_size = RAID5_STRIPE_SIZE(conf);
-			bi->bi_write_hint = sh->dev[i].write_hint;
-			if (!rrdev)
-				sh->dev[i].write_hint = RWH_WRITE_LIFE_NOT_SET;
 			/*
 			 * If this is discard request, set bi_vcnt 0. We don't
 			 * want to confuse SCSI because SCSI will replace payload
@@ -1264,8 +1261,6 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 			rbi->bi_io_vec[0].bv_len = RAID5_STRIPE_SIZE(conf);
 			rbi->bi_io_vec[0].bv_offset = sh->dev[i].offset;
 			rbi->bi_iter.bi_size = RAID5_STRIPE_SIZE(conf);
-			rbi->bi_write_hint = sh->dev[i].write_hint;
-			sh->dev[i].write_hint = RWH_WRITE_LIFE_NOT_SET;
 			/*
 			 * If this is discard request, set bi_vcnt 0. We don't
 			 * want to confuse SCSI because SCSI will replace payload
@@ -3416,7 +3411,6 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx,
 		(unsigned long long)sh->sector);
 
 	spin_lock_irq(&sh->stripe_lock);
-	sh->dev[dd_idx].write_hint = bi->bi_write_hint;
 	/* Don't allow new IO added to stripes in batch list */
 	if (sh->batch_head)
 		goto overlap;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index dee86911a4bef..1412f09537c73 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3321,7 +3321,6 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	bio_ctrl->bio_flags = bio_flags;
 	bio->bi_end_io = end_io_func;
 	bio->bi_private = &inode->io_tree;
-	bio->bi_write_hint = inode->vfs_inode.i_write_hint;
 	bio->bi_opf = opf;
 	ret = calc_bio_boundaries(bio_ctrl, inode, file_offset);
 	if (ret < 0)
diff --git a/fs/buffer.c b/fs/buffer.c
index a17c386a142c7..29c6c60660f61 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -53,7 +53,7 @@
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
-			 enum rw_hint hint, struct writeback_control *wbc);
+			 struct writeback_control *wbc);
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
@@ -1806,8 +1806,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
-			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh,
-					inode->i_write_hint, wbc);
+			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh, wbc);
 			nr_underway++;
 		}
 		bh = next;
@@ -1861,8 +1860,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
 			clear_buffer_dirty(bh);
-			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh,
-					inode->i_write_hint, wbc);
+			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh, wbc);
 			nr_underway++;
 		}
 		bh = next;
@@ -3008,7 +3006,7 @@ static void end_bio_bh_io_sync(struct bio *bio)
 }
 
 static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
-			 enum rw_hint write_hint, struct writeback_control *wbc)
+			 struct writeback_control *wbc)
 {
 	struct bio *bio;
 
@@ -3034,7 +3032,6 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
-	bio->bi_write_hint = write_hint;
 
 	bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
 	BUG_ON(bio->bi_iter.bi_size != bh->b_size);
@@ -3056,7 +3053,7 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 
 int submit_bh(int op, int op_flags, struct buffer_head *bh)
 {
-	return submit_bh_wbc(op, op_flags, bh, 0, NULL);
+	return submit_bh_wbc(op, op_flags, bh, NULL);
 }
 EXPORT_SYMBOL(submit_bh);
 
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 38bca4980a1ca..aef06e607b405 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -402,9 +402,6 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 		bio->bi_end_io = dio_bio_end_aio;
 	else
 		bio->bi_end_io = dio_bio_end_io;
-
-	bio->bi_write_hint = dio->iocb->ki_hint;
-
 	sdio->bio = bio;
 	sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
 }
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 1253982268730..0c31b61c7628a 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -374,7 +374,6 @@ void ext4_io_submit(struct ext4_io_submit *io)
 	if (bio) {
 		int io_op_flags = io->io_wbc->sync_mode == WB_SYNC_ALL ?
 				  REQ_SYNC : 0;
-		io->io_bio->bi_write_hint = io->io_end->inode->i_write_hint;
 		bio_set_op_attrs(io->io_bio, REQ_OP_WRITE, io_op_flags);
 		submit_bio(io->io_bio);
 	}
@@ -420,10 +419,8 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 submit_and_retry:
 		ext4_io_submit(io);
 	}
-	if (io->io_bio == NULL) {
+	if (io->io_bio == NULL)
 		io_submit_init_bio(io, bh);
-		io->io_bio->bi_write_hint = inode->i_write_hint;
-	}
 	ret = bio_add_page(io->io_bio, page, bh->b_size, bh_offset(bh));
 	if (ret != bh->b_size)
 		goto submit_and_retry;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e71dde8de0db0..20d65aa6243a1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -403,8 +403,6 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	} else {
 		bio->bi_end_io = f2fs_write_end_io;
 		bio->bi_private = sbi;
-		bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi,
-						fio->type, fio->temp);
 	}
 	iostat_alloc_and_bind_ctx(sbi, bio, NULL);
 
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 4ae1eefae616d..6ba51cbb94cf2 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -491,7 +491,6 @@ static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs)
 	new = bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOIO);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
-	new->bi_write_hint = prev->bi_write_hint;
 	bio_chain(new, prev);
 	submit_bio(prev);
 	return new;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 491534e908615..fedca4de5f6b9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1199,7 +1199,6 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = sector;
-	bio->bi_write_hint = inode->i_write_hint;
 	wbc_init_bio(wbc, bio);
 
 	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
@@ -1228,7 +1227,6 @@ iomap_chain_bio(struct bio *prev)
 	new = bio_alloc(prev->bi_bdev, BIO_MAX_VECS, prev->bi_opf, GFP_NOFS);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
-	new->bi_write_hint = prev->bi_write_hint;
 
 	bio_chain(prev, new);
 	bio_get(prev);		/* for iomap_finish_ioend */
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index e2ba13645ef28..a434b1829545d 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -309,7 +309,6 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 
 		bio = bio_alloc(iomap->bdev, nr_pages, bio_opf, GFP_KERNEL);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
-		bio->bi_write_hint = dio->iocb->ki_hint;
 		bio->bi_ioprio = dio->iocb->ki_ioprio;
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
diff --git a/fs/mpage.c b/fs/mpage.c
index dbfc02e23d97f..89eeef275a235 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -590,7 +590,6 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 		bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
 
 		wbc_init_bio(wbc, bio);
-		bio->bi_write_hint = inode->i_write_hint;
 	}
 
 	/*
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index d331b52592a0a..b71a23dd12556 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -695,7 +695,6 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 	bio = bio_alloc(bdev, nr_pages,
 			REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE, GFP_NOFS);
 	bio->bi_iter.bi_sector = zi->i_zsector;
-	bio->bi_write_hint = iocb->ki_hint;
 	bio->bi_ioprio = iocb->ki_ioprio;
 	if (iocb->ki_flags & IOCB_DSYNC)
 		bio->bi_opf |= REQ_FUA;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 5561e58d158ac..ba8cfa57255f3 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -250,7 +250,6 @@ struct bio {
 						 */
 	unsigned short		bi_flags;	/* BIO_* below */
 	unsigned short		bi_ioprio;
-	unsigned short		bi_write_hint;
 	blk_status_t		bi_status;
 	atomic_t		__bi_remaining;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e19947d84f128..bb6d5ee02c070 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -518,9 +518,6 @@ struct request_queue {
 
 	bool			mq_sysfs_init_done;
 
-#define BLK_MAX_WRITE_HINTS	5
-	u64			write_hints[BLK_MAX_WRITE_HINTS];
-
 	/*
 	 * Independent sector access ranges. This is always NULL for
 	 * devices that do not have multiple independent access ranges.
-- 
2.30.2

