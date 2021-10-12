Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C4942A35E
	for <lists+linux-block@lfdr.de>; Tue, 12 Oct 2021 13:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbhJLLfk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Oct 2021 07:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhJLLfj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 07:35:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A0DC061570;
        Tue, 12 Oct 2021 04:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/ApT/0guLKGiOHRtEHz3bwNzVuj7VXX2kOPJm+qVvdM=; b=fEdIEJkZ6DEKbbpy1dWHXEPpPr
        1/WYmOx5jihv7RKzqeZhitCjcD/3Z/C7JD1aXgrXP5svxTU98AYbykOfvqDC4ETe4BRvf16N72YEr
        8F+mnF665IUDjoUWAguQO1QyZRsDspfXkhxWwo+PVH3XdDnHiOt7zq/TFCuc5u5pg+XRHGIUOWuFG
        33KkrTH34NpnVQToH3GGwFM43Gpk3i8WbhRzoM7k+F6wn5axhlSguXu8oPgXp6hxX0a1hwy3SH3/V
        7urWSEcnkl8B91Dgav7HWH0CbXsM/VciTZYlKKlibDm177p5jplLKpnY+89ZJ0tMS65CdU83qOFlU
        6uZv7IKg==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFzd-006SQ5-JT; Tue, 12 Oct 2021 11:31:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 14/16] block: switch polling to be bio based
Date:   Tue, 12 Oct 2021 13:12:24 +0200
Message-Id: <20211012111226.760968-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the blk_poll interface that requires the caller to keep a queue
and cookie from the submissions with polling based on the bio.

Polling for the bio itself leads to a few advantages:

 - the cookie construction can made entirely private in blk-mq.c
 - the caller does not need to remember the request_queue and cookie
   separately and thus sidesteps their lifetime issues
 - keeping the device and the cookie inside the bio allows to trivially
   support polling BIOs remapping by stacking drivers
 - a lot of code to propagate the cookie back up the submission path can
   be removed entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 arch/m68k/emu/nfblock.c             |   3 +-
 arch/xtensa/platforms/iss/simdisk.c |   3 +-
 block/bio.c                         |   1 +
 block/blk-core.c                    | 127 +++++++++++++++++++++-------
 block/blk-exec.c                    |  10 ++-
 block/blk-mq.c                      |  72 +++++-----------
 block/blk-mq.h                      |   2 +
 block/fops.c                        |  25 ++----
 drivers/block/brd.c                 |  12 ++-
 drivers/block/drbd/drbd_int.h       |   2 +-
 drivers/block/drbd/drbd_req.c       |   3 +-
 drivers/block/n64cart.c             |  12 ++-
 drivers/block/null_blk/main.c       |   3 +-
 drivers/block/pktcdvd.c             |   7 +-
 drivers/block/ps3vram.c             |   6 +-
 drivers/block/rsxx/dev.c            |   7 +-
 drivers/block/zram/zram_drv.c       |  10 +--
 drivers/md/bcache/request.c         |  13 ++-
 drivers/md/bcache/request.h         |   4 +-
 drivers/md/dm.c                     |  28 +++---
 drivers/md/md.c                     |  10 +--
 drivers/nvdimm/blk.c                |   5 +-
 drivers/nvdimm/btt.c                |   5 +-
 drivers/nvdimm/pmem.c               |   3 +-
 drivers/nvme/host/multipath.c       |   6 +-
 drivers/s390/block/dcssblk.c        |   7 +-
 fs/btrfs/inode.c                    |   8 +-
 fs/ext4/file.c                      |   2 +-
 fs/gfs2/file.c                      |   4 +-
 fs/iomap/direct-io.c                |  36 +++-----
 fs/xfs/xfs_file.c                   |   2 +-
 fs/zonefs/super.c                   |   2 +-
 include/linux/bio.h                 |   2 +-
 include/linux/blk-mq.h              |  15 +---
 include/linux/blk_types.h           |  12 ++-
 include/linux/blkdev.h              |   8 +-
 include/linux/fs.h                  |   6 +-
 include/linux/iomap.h               |   5 +-
 mm/page_io.c                        |   8 +-
 39 files changed, 233 insertions(+), 263 deletions(-)

diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index 9a8394e96388a..4ef457ba52209 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -58,7 +58,7 @@ struct nfhd_device {
 	struct gendisk *disk;
 };
 
-static blk_qc_t nfhd_submit_bio(struct bio *bio)
+static void nfhd_submit_bio(struct bio *bio)
 {
 	struct nfhd_device *dev = bio->bi_bdev->bd_disk->private_data;
 	struct bio_vec bvec;
@@ -76,7 +76,6 @@ static blk_qc_t nfhd_submit_bio(struct bio *bio)
 		sec += len;
 	}
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
 }
 
 static int nfhd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 3cdfa00738e07..ddd1fe3db4744 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -100,7 +100,7 @@ static void simdisk_transfer(struct simdisk *dev, unsigned long sector,
 	spin_unlock(&dev->lock);
 }
 
-static blk_qc_t simdisk_submit_bio(struct bio *bio)
+static void simdisk_submit_bio(struct bio *bio)
 {
 	struct simdisk *dev = bio->bi_bdev->bd_disk->private_data;
 	struct bio_vec bvec;
@@ -118,7 +118,6 @@ static blk_qc_t simdisk_submit_bio(struct bio *bio)
 	}
 
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
 }
 
 static int simdisk_open(struct block_device *bdev, fmode_t mode)
diff --git a/block/bio.c b/block/bio.c
index a48cf9d04b3c1..7377fc93606a6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -282,6 +282,7 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 
 	atomic_set(&bio->__bi_remaining, 1);
 	atomic_set(&bio->__bi_cnt, 1);
+	bio->bi_cookie = BLK_QC_T_NONE;
 
 	bio->bi_max_vecs = max_vecs;
 	bio->bi_io_vec = table;
diff --git a/block/blk-core.c b/block/blk-core.c
index 14559b23fbe2e..1ad2528680eac 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -897,18 +897,18 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	return false;
 }
 
-static blk_qc_t __submit_bio(struct bio *bio)
+static void __submit_bio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
-	blk_qc_t ret = BLK_QC_T_NONE;
 
 	if (blk_crypto_bio_prep(&bio)) {
-		if (!disk->fops->submit_bio)
-			return blk_mq_submit_bio(bio);
-		ret = disk->fops->submit_bio(bio);
+		if (!disk->fops->submit_bio) {
+			blk_mq_submit_bio(bio);
+			return;
+		}
+		disk->fops->submit_bio(bio);
 	}
 	blk_queue_exit(disk->queue);
-	return ret;
 }
 
 /*
@@ -930,10 +930,9 @@ static blk_qc_t __submit_bio(struct bio *bio)
  * bio_list_on_stack[1] contains bios that were submitted before the current
  *	->submit_bio_bio, but that haven't been processed yet.
  */
-static blk_qc_t __submit_bio_noacct(struct bio *bio)
+static void __submit_bio_noacct(struct bio *bio)
 {
 	struct bio_list bio_list_on_stack[2];
-	blk_qc_t ret = BLK_QC_T_NONE;
 
 	BUG_ON(bio->bi_next);
 
@@ -953,7 +952,7 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
 		bio_list_on_stack[1] = bio_list_on_stack[0];
 		bio_list_init(&bio_list_on_stack[0]);
 
-		ret = __submit_bio(bio);
+		__submit_bio(bio);
 
 		/*
 		 * Sort new bios into those for a lower level and those for the
@@ -976,13 +975,11 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
 	} while ((bio = bio_list_pop(&bio_list_on_stack[0])));
 
 	current->bio_list = NULL;
-	return ret;
 }
 
-static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
+static void __submit_bio_noacct_mq(struct bio *bio)
 {
 	struct bio_list bio_list[2] = { };
-	blk_qc_t ret = BLK_QC_T_NONE;
 
 	current->bio_list = bio_list;
 
@@ -994,15 +991,13 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
 
 		if (!blk_crypto_bio_prep(&bio)) {
 			blk_queue_exit(disk->queue);
-			ret = BLK_QC_T_NONE;
 			continue;
 		}
 
-		ret = blk_mq_submit_bio(bio);
+		blk_mq_submit_bio(bio);
 	} while ((bio = bio_list_pop(&bio_list[0])));
 
 	current->bio_list = NULL;
-	return ret;
 }
 
 /**
@@ -1014,10 +1009,10 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
  * systems and other upper level users of the block layer should use
  * submit_bio() instead.
  */
-blk_qc_t submit_bio_noacct(struct bio *bio)
+void submit_bio_noacct(struct bio *bio)
 {
 	if (!submit_bio_checks(bio))
-		return BLK_QC_T_NONE;
+		return;
 
 	/*
 	 * We only want one ->submit_bio to be active at a time, else stack
@@ -1025,14 +1020,12 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
 	 * to collect a list of requests submited by a ->submit_bio method while
 	 * it is active, and then process them after it returned.
 	 */
-	if (current->bio_list) {
+	if (current->bio_list)
 		bio_list_add(&current->bio_list[0], bio);
-		return BLK_QC_T_NONE;
-	}
-
-	if (!bio->bi_bdev->bd_disk->fops->submit_bio)
-		return __submit_bio_noacct_mq(bio);
-	return __submit_bio_noacct(bio);
+	else if (!bio->bi_bdev->bd_disk->fops->submit_bio)
+		__submit_bio_noacct_mq(bio);
+	else
+		__submit_bio_noacct(bio);
 }
 EXPORT_SYMBOL(submit_bio_noacct);
 
@@ -1049,10 +1042,10 @@ EXPORT_SYMBOL(submit_bio_noacct);
  * in @bio.  The bio must NOT be touched by thecaller until ->bi_end_io() has
  * been called.
  */
-blk_qc_t submit_bio(struct bio *bio)
+void submit_bio(struct bio *bio)
 {
 	if (blkcg_punt_bio_submit(bio))
-		return BLK_QC_T_NONE;
+		return;
 
 	/*
 	 * If it's a regular read/write or a barrier with data attached,
@@ -1084,19 +1077,91 @@ blk_qc_t submit_bio(struct bio *bio)
 	if (unlikely(bio_op(bio) == REQ_OP_READ &&
 	    bio_flagged(bio, BIO_WORKINGSET))) {
 		unsigned long pflags;
-		blk_qc_t ret;
 
 		psi_memstall_enter(&pflags);
-		ret = submit_bio_noacct(bio);
+		submit_bio_noacct(bio);
 		psi_memstall_leave(&pflags);
-
-		return ret;
+		return;
 	}
 
-	return submit_bio_noacct(bio);
+	submit_bio_noacct(bio);
 }
 EXPORT_SYMBOL(submit_bio);
 
+/**
+ * bio_poll - poll for BIO completions
+ * @bio: bio to poll for
+ * @flags: BLK_POLL_* flags that control the behavior
+ *
+ * Poll for completions on queue associated with the bio. Returns number of
+ * completed entries found.
+ *
+ * Note: the caller must either be the context that submitted @bio, or
+ * be in a RCU critical section to prevent freeing of @bio.
+ */
+int bio_poll(struct bio *bio, unsigned int flags)
+{
+	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
+	int ret;
+
+	if (cookie == BLK_QC_T_NONE ||
+	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+		return 0;
+
+	if (current->plug)
+		blk_flush_plug_list(current->plug, false);
+
+	if (blk_queue_enter(q, BLK_MQ_REQ_NOWAIT))
+		return 0;
+	if (WARN_ON_ONCE(!queue_is_mq(q)))
+		ret = 0;	/* not yet implemented, should not happen */
+	else
+		ret = blk_mq_poll(q, cookie, flags);
+	blk_queue_exit(q);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(bio_poll);
+
+/*
+ * Helper to implement file_operations.iopoll.  Requires the bio to be stored
+ * in iocb->private, and cleared before freeing the bio.
+ */
+int iocb_bio_iopoll(struct kiocb *kiocb, unsigned int flags)
+{
+	struct bio *bio;
+	int ret = 0;
+
+	/*
+	 * Note: the bio cache only uses SLAB_TYPESAFE_BY_RCU, so bio can
+	 * point to a freshly allocated bio at this point.  If that happens
+	 * we have a few cases to consider:
+	 *
+	 *  1) the bio is beeing initialized and bi_bdev is NULL.  We can just
+	 *     simply nothing in this case
+	 *  2) the bio points to a not poll enabled device.  bio_poll will catch
+	 *     this and return 0
+	 *  3) the bio points to a poll capable device, including but not
+	 *     limited to the one that the original bio pointed to.  In this
+	 *     case we will call into the actual poll method and poll for I/O,
+	 *     even if we don't need to, but it won't cause harm either.
+	 *
+	 * For cases 2) and 3) above the RCU grace period ensures that bi_bdev
+	 * is still allocated. Because partitions hold a reference to the whole
+	 * device bdev and thus disk, the disk is also still valid.  Grabbing
+	 * a reference to the queue in bio_poll() ensures the hctxs and requests
+	 * are still valid as well.
+	 */
+	rcu_read_lock();
+	bio = READ_ONCE(kiocb->private);
+	if (bio && bio->bi_bdev)
+		ret = bio_poll(bio, flags);
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iocb_bio_iopoll);
+
 /**
  * blk_cloned_rq_check_limits - Helper function to check a cloned request
  *                              for the new queue limits
diff --git a/block/blk-exec.c b/block/blk-exec.c
index 1fa7f25e57262..55f0cd34b37b9 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -65,13 +65,19 @@ EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
 
 static bool blk_rq_is_poll(struct request *rq)
 {
-	return rq->mq_hctx && rq->mq_hctx->type == HCTX_TYPE_POLL;
+	if (!rq->mq_hctx)
+		return false;
+	if (rq->mq_hctx->type != HCTX_TYPE_POLL)
+		return false;
+	if (WARN_ON_ONCE(!rq->bio))
+		return false;
+	return true;
 }
 
 static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
 {
 	do {
-		blk_poll(rq->q, request_to_qc_t(rq->mq_hctx, rq), 0);
+		bio_poll(rq->bio, 0);
 		cond_resched();
 	} while (!completion_done(wait));
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4dfa185f9f5b7..f42cf615c527b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -65,6 +65,9 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
 	return bucket;
 }
 
+#define BLK_QC_T_SHIFT		16
+#define BLK_QC_T_INTERNAL	(1U << 31)
+
 static inline struct blk_mq_hw_ctx *blk_qc_to_hctx(struct request_queue *q,
 		blk_qc_t qc)
 {
@@ -81,6 +84,13 @@ static inline struct request *blk_qc_to_rq(struct blk_mq_hw_ctx *hctx,
 	return blk_mq_tag_to_rq(hctx->tags, tag);
 }
 
+static inline blk_qc_t blk_rq_to_qc(struct request *rq)
+{
+	return (rq->mq_hctx->queue_num << BLK_QC_T_SHIFT) |
+		(rq->tag != -1 ?
+		 rq->tag : (rq->internal_tag | BLK_QC_T_INTERNAL));
+}
+
 /*
  * Check if any of the ctx, dispatch list or elevator
  * have pending work in this hardware queue.
@@ -789,6 +799,8 @@ void blk_mq_start_request(struct request *rq)
 	if (blk_integrity_rq(rq) && req_op(rq) == REQ_OP_WRITE)
 		q->integrity.profile->prepare_fn(rq);
 #endif
+	if (rq->bio && rq->bio->bi_opf & REQ_POLLED)
+	        WRITE_ONCE(rq->bio->bi_cookie, blk_rq_to_qc(rq));
 }
 EXPORT_SYMBOL(blk_mq_start_request);
 
@@ -2015,19 +2027,15 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
 }
 
 static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
-					    struct request *rq,
-					    blk_qc_t *cookie, bool last)
+					    struct request *rq, bool last)
 {
 	struct request_queue *q = rq->q;
 	struct blk_mq_queue_data bd = {
 		.rq = rq,
 		.last = last,
 	};
-	blk_qc_t new_cookie;
 	blk_status_t ret;
 
-	new_cookie = request_to_qc_t(hctx, rq);
-
 	/*
 	 * For OK queue, we are done. For error, caller may kill it.
 	 * Any other error (busy), just add it to our list as we
@@ -2037,7 +2045,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	switch (ret) {
 	case BLK_STS_OK:
 		blk_mq_update_dispatch_busy(hctx, false);
-		*cookie = new_cookie;
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
@@ -2046,7 +2053,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 		break;
 	default:
 		blk_mq_update_dispatch_busy(hctx, false);
-		*cookie = BLK_QC_T_NONE;
 		break;
 	}
 
@@ -2055,7 +2061,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
-						blk_qc_t *cookie,
 						bool bypass_insert, bool last)
 {
 	struct request_queue *q = rq->q;
@@ -2089,7 +2094,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		goto insert;
 	}
 
-	return __blk_mq_issue_directly(hctx, rq, cookie, last);
+	return __blk_mq_issue_directly(hctx, rq, last);
 insert:
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
@@ -2103,7 +2108,6 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
  * blk_mq_try_issue_directly - Try to send a request directly to device driver.
  * @hctx: Pointer of the associated hardware queue.
  * @rq: Pointer to request to be sent.
- * @cookie: Request queue cookie.
  *
  * If the device has enough resources to accept a new request now, send the
  * request directly to device driver. Else, insert at hctx->dispatch queue, so
@@ -2111,7 +2115,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
  * queue have higher priority.
  */
 static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
-		struct request *rq, blk_qc_t *cookie)
+		struct request *rq)
 {
 	blk_status_t ret;
 	int srcu_idx;
@@ -2120,7 +2124,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 	hctx_lock(hctx, &srcu_idx);
 
-	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
+	ret = __blk_mq_try_issue_directly(hctx, rq, false, true);
 	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
 		blk_mq_request_bypass_insert(rq, false, true);
 	else if (ret != BLK_STS_OK)
@@ -2133,11 +2137,10 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 {
 	blk_status_t ret;
 	int srcu_idx;
-	blk_qc_t unused_cookie;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	hctx_lock(hctx, &srcu_idx);
-	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true, last);
+	ret = __blk_mq_try_issue_directly(hctx, rq, true, last);
 	hctx_unlock(hctx, srcu_idx);
 
 	return ret;
@@ -2217,10 +2220,8 @@ static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
  *
  * It will not queue the request if there is an error with the bio, or at the
  * request creation.
- *
- * Returns: Request queue cookie.
  */
-blk_qc_t blk_mq_submit_bio(struct bio *bio)
+void blk_mq_submit_bio(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
 	const int is_sync = op_is_sync(bio->bi_opf);
@@ -2229,9 +2230,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	struct blk_plug *plug;
 	struct request *same_queue_rq = NULL;
 	unsigned int nr_segs;
-	blk_qc_t cookie;
 	blk_status_t ret;
-	bool hipri;
 
 	blk_queue_bounce(q, &bio);
 	__blk_queue_split(&bio, &nr_segs);
@@ -2248,8 +2247,6 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 
 	rq_qos_throttle(q, bio);
 
-	hipri = bio->bi_opf & REQ_POLLED;
-
 	plug = blk_mq_plug(q, bio);
 	if (plug && plug->cached_rq) {
 		rq = plug->cached_rq;
@@ -2280,8 +2277,6 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 
 	rq_qos_track(q, rq, bio);
 
-	cookie = request_to_qc_t(rq->mq_hctx, rq);
-
 	blk_mq_bio_to_request(rq, bio, nr_segs);
 
 	ret = blk_crypto_init_request(rq);
@@ -2289,7 +2284,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		bio->bi_status = ret;
 		bio_endio(bio);
 		blk_mq_free_request(rq);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	if (unlikely(is_flush_fua)) {
@@ -2344,7 +2339,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		if (same_queue_rq) {
 			trace_block_unplug(q, 1, true);
 			blk_mq_try_issue_directly(same_queue_rq->mq_hctx,
-						  same_queue_rq, &cookie);
+						  same_queue_rq);
 		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) ||
 		   !rq->mq_hctx->dispatch_busy) {
@@ -2352,18 +2347,15 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		 * There is no scheduler and we can try to send directly
 		 * to the hardware.
 		 */
-		blk_mq_try_issue_directly(rq->mq_hctx, rq, &cookie);
+		blk_mq_try_issue_directly(rq->mq_hctx, rq);
 	} else {
 		/* Default case. */
 		blk_mq_sched_insert_request(rq, false, true, true);
 	}
 
-	if (!hipri)
-		return BLK_QC_T_NONE;
-	return cookie;
+	return;
 queue_exit:
 	blk_queue_exit(q);
-	return BLK_QC_T_NONE;
 }
 
 static size_t order_to_size(unsigned int order)
@@ -4053,25 +4045,8 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
 	return 0;
 }
 
-/**
- * blk_poll - poll for IO completions
- * @q:  the queue
- * @cookie: cookie passed back at IO submission time
- * @flags: BLK_POLL_* flags that control the behavior
- *
- * Description:
- *    Poll for completions on the passed in queue. Returns number of
- *    completed entries found.
- */
-int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags)
+int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags)
 {
-	if (cookie == BLK_QC_T_NONE ||
-	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
-		return 0;
-
-	if (current->plug)
-		blk_flush_plug_list(current->plug, false);
-
 	if (!(flags & BLK_POLL_NOSLEEP) &&
 	    q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
 		if (blk_mq_poll_hybrid(q, cookie))
@@ -4079,7 +4054,6 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags)
 	}
 	return blk_mq_poll_classic(q, cookie, flags);
 }
-EXPORT_SYMBOL_GPL(blk_poll);
 
 unsigned int blk_mq_rq_cpu(struct request *rq)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index a9fe01e149516..8be447995106c 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -37,6 +37,8 @@ struct blk_mq_ctx {
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
 
+void blk_mq_submit_bio(struct bio *bio);
+int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags);
 void blk_mq_exit_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
diff --git a/block/fops.c b/block/fops.c
index db8f2fe68dd27..ce1255529ba2f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -61,7 +61,6 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	bool should_dirty = false;
 	struct bio bio;
 	ssize_t ret;
-	blk_qc_t qc;
 
 	if ((pos | iov_iter_alignment(iter)) &
 	    (bdev_logical_block_size(bdev) - 1))
@@ -102,13 +101,12 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	if (iocb->ki_flags & IOCB_HIPRI)
 		bio_set_polled(&bio, iocb);
 
-	qc = submit_bio(&bio);
+	submit_bio(&bio);
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!READ_ONCE(bio.bi_private))
 			break;
-		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc, 0))
+		if (!(iocb->ki_flags & IOCB_HIPRI) || !bio_poll(&bio, 0))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -141,14 +139,6 @@ struct blkdev_dio {
 
 static struct bio_set blkdev_dio_pool;
 
-static int blkdev_iopoll(struct kiocb *kiocb, unsigned int flags)
-{
-	struct block_device *bdev = I_BDEV(kiocb->ki_filp->f_mapping->host);
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), flags);
-}
-
 static void blkdev_bio_end_io(struct bio *bio)
 {
 	struct blkdev_dio *dio = bio->bi_private;
@@ -162,6 +152,8 @@ static void blkdev_bio_end_io(struct bio *bio)
 			struct kiocb *iocb = dio->iocb;
 			ssize_t ret;
 
+			WRITE_ONCE(iocb->private, NULL);
+
 			if (likely(!dio->bio.bi_status)) {
 				ret = dio->size;
 				iocb->ki_pos += ret;
@@ -200,7 +192,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	bool do_poll = (iocb->ki_flags & IOCB_HIPRI);
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
-	blk_qc_t qc = BLK_QC_T_NONE;
 	int ret = 0;
 
 	if ((pos | iov_iter_alignment(iter)) &
@@ -262,9 +253,9 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		if (!nr_pages) {
 			if (do_poll)
 				bio_set_polled(bio, iocb);
-			qc = submit_bio(bio);
+			submit_bio(bio);
 			if (do_poll)
-				WRITE_ONCE(iocb->ki_cookie, qc);
+				WRITE_ONCE(iocb->private, bio);
 			break;
 		}
 		if (!dio->multi_bio) {
@@ -297,7 +288,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		if (!READ_ONCE(dio->waiter))
 			break;
 
-		if (!do_poll || !blk_poll(bdev_get_queue(bdev), qc, 0))
+		if (!do_poll || !bio_poll(bio, 0))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -594,7 +585,7 @@ const struct file_operations def_blk_fops = {
 	.llseek		= blkdev_llseek,
 	.read_iter	= blkdev_read_iter,
 	.write_iter	= blkdev_write_iter,
-	.iopoll		= blkdev_iopoll,
+	.iopoll		= iocb_bio_iopoll,
 	.mmap		= generic_file_mmap,
 	.fsync		= blkdev_fsync,
 	.unlocked_ioctl	= blkdev_ioctl,
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 58ec167aa0183..293d7cb3e3a38 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -282,7 +282,7 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 	return err;
 }
 
-static blk_qc_t brd_submit_bio(struct bio *bio)
+static void brd_submit_bio(struct bio *bio)
 {
 	struct brd_device *brd = bio->bi_bdev->bd_disk->private_data;
 	sector_t sector = bio->bi_iter.bi_sector;
@@ -299,16 +299,14 @@ static blk_qc_t brd_submit_bio(struct bio *bio)
 
 		err = brd_do_bvec(brd, bvec.bv_page, len, bvec.bv_offset,
 				  bio_op(bio), sector);
-		if (err)
-			goto io_error;
+		if (err) {
+			bio_io_error(bio);
+			return;
+		}
 		sector += len >> SECTOR_SHIFT;
 	}
 
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
-io_error:
-	bio_io_error(bio);
-	return BLK_QC_T_NONE;
 }
 
 static int brd_rw_page(struct block_device *bdev, sector_t sector,
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 5d9181382ce19..6674a0b883415 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1448,7 +1448,7 @@ extern void conn_free_crypto(struct drbd_connection *connection);
 /* drbd_req */
 extern void do_submit(struct work_struct *ws);
 extern void __drbd_make_request(struct drbd_device *, struct bio *);
-extern blk_qc_t drbd_submit_bio(struct bio *bio);
+void drbd_submit_bio(struct bio *bio);
 extern int drbd_read_remote(struct drbd_device *device, struct drbd_request *req);
 extern int is_valid_ar_handle(struct drbd_request *, sector_t);
 
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 5ca233644d705..3235532ae0778 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1596,7 +1596,7 @@ void do_submit(struct work_struct *ws)
 	}
 }
 
-blk_qc_t drbd_submit_bio(struct bio *bio)
+void drbd_submit_bio(struct bio *bio)
 {
 	struct drbd_device *device = bio->bi_bdev->bd_disk->private_data;
 
@@ -1609,7 +1609,6 @@ blk_qc_t drbd_submit_bio(struct bio *bio)
 
 	inc_ap_bio(device);
 	__drbd_make_request(device, bio);
-	return BLK_QC_T_NONE;
 }
 
 static bool net_timeout_reached(struct drbd_request *net_req,
diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
index 26798da661bd4..b168ca25b6c90 100644
--- a/drivers/block/n64cart.c
+++ b/drivers/block/n64cart.c
@@ -84,7 +84,7 @@ static bool n64cart_do_bvec(struct device *dev, struct bio_vec *bv, u32 pos)
 	return true;
 }
 
-static blk_qc_t n64cart_submit_bio(struct bio *bio)
+static void n64cart_submit_bio(struct bio *bio)
 {
 	struct bio_vec bvec;
 	struct bvec_iter iter;
@@ -92,16 +92,14 @@ static blk_qc_t n64cart_submit_bio(struct bio *bio)
 	u32 pos = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 
 	bio_for_each_segment(bvec, bio, iter) {
-		if (!n64cart_do_bvec(dev, &bvec, pos))
-			goto io_error;
+		if (!n64cart_do_bvec(dev, &bvec, pos)) {
+			bio_io_error(bio);
+			return;
+		}
 		pos += bvec.bv_len;
 	}
 
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
-io_error:
-	bio_io_error(bio);
-	return BLK_QC_T_NONE;
 }
 
 static const struct block_device_operations n64cart_fops = {
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 187d779c8ca08..e5cbcf5822333 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1422,7 +1422,7 @@ static struct nullb_queue *nullb_to_queue(struct nullb *nullb)
 	return &nullb->queues[index];
 }
 
-static blk_qc_t null_submit_bio(struct bio *bio)
+static void null_submit_bio(struct bio *bio)
 {
 	sector_t sector = bio->bi_iter.bi_sector;
 	sector_t nr_sectors = bio_sectors(bio);
@@ -1434,7 +1434,6 @@ static blk_qc_t null_submit_bio(struct bio *bio)
 	cmd->bio = bio;
 
 	null_handle_cmd(cmd, sector, nr_sectors, bio_op(bio));
-	return BLK_QC_T_NONE;
 }
 
 static bool should_timeout_request(struct request *rq)
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 0f26b2510a756..cb52cce6fb039 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2400,7 +2400,7 @@ static void pkt_make_request_write(struct request_queue *q, struct bio *bio)
 	}
 }
 
-static blk_qc_t pkt_submit_bio(struct bio *bio)
+static void pkt_submit_bio(struct bio *bio)
 {
 	struct pktcdvd_device *pd;
 	char b[BDEVNAME_SIZE];
@@ -2423,7 +2423,7 @@ static blk_qc_t pkt_submit_bio(struct bio *bio)
 	 */
 	if (bio_data_dir(bio) == READ) {
 		pkt_make_request_read(pd, bio);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	if (!test_bit(PACKET_WRITABLE, &pd->flags)) {
@@ -2455,10 +2455,9 @@ static blk_qc_t pkt_submit_bio(struct bio *bio)
 		pkt_make_request_write(bio->bi_bdev->bd_disk->queue, split);
 	} while (split != bio);
 
-	return BLK_QC_T_NONE;
+	return;
 end_io:
 	bio_io_error(bio);
-	return BLK_QC_T_NONE;
 }
 
 static void pkt_init_queue(struct pktcdvd_device *pd)
diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index c7b19e128b03c..d1ebf193cb9ab 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -578,7 +578,7 @@ static struct bio *ps3vram_do_bio(struct ps3_system_bus_device *dev,
 	return next;
 }
 
-static blk_qc_t ps3vram_submit_bio(struct bio *bio)
+static void ps3vram_submit_bio(struct bio *bio)
 {
 	struct ps3_system_bus_device *dev = bio->bi_bdev->bd_disk->private_data;
 	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
@@ -594,13 +594,11 @@ static blk_qc_t ps3vram_submit_bio(struct bio *bio)
 	spin_unlock_irq(&priv->lock);
 
 	if (busy)
-		return BLK_QC_T_NONE;
+		return;
 
 	do {
 		bio = ps3vram_do_bio(dev, bio);
 	} while (bio);
-
-	return BLK_QC_T_NONE;
 }
 
 static const struct block_device_operations ps3vram_fops = {
diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index 1cc40b0ea7619..268252380e88f 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -50,7 +50,7 @@ struct rsxx_bio_meta {
 
 static struct kmem_cache *bio_meta_pool;
 
-static blk_qc_t rsxx_submit_bio(struct bio *bio);
+static void rsxx_submit_bio(struct bio *bio);
 
 /*----------------- Block Device Operations -----------------*/
 static int rsxx_blkdev_ioctl(struct block_device *bdev,
@@ -120,7 +120,7 @@ static void bio_dma_done_cb(struct rsxx_cardinfo *card,
 	}
 }
 
-static blk_qc_t rsxx_submit_bio(struct bio *bio)
+static void rsxx_submit_bio(struct bio *bio)
 {
 	struct rsxx_cardinfo *card = bio->bi_bdev->bd_disk->private_data;
 	struct rsxx_bio_meta *bio_meta;
@@ -169,7 +169,7 @@ static blk_qc_t rsxx_submit_bio(struct bio *bio)
 	if (st)
 		goto queue_err;
 
-	return BLK_QC_T_NONE;
+	return;
 
 queue_err:
 	kmem_cache_free(bio_meta_pool, bio_meta);
@@ -177,7 +177,6 @@ static blk_qc_t rsxx_submit_bio(struct bio *bio)
 	if (st)
 		bio->bi_status = st;
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
 }
 
 /*----------------- Device Setup -------------------*/
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fcaf2750f68f7..a68297fb51a2f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1598,22 +1598,18 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
 /*
  * Handler function for all zram I/O requests.
  */
-static blk_qc_t zram_submit_bio(struct bio *bio)
+static void zram_submit_bio(struct bio *bio)
 {
 	struct zram *zram = bio->bi_bdev->bd_disk->private_data;
 
 	if (!valid_io_request(zram, bio->bi_iter.bi_sector,
 					bio->bi_iter.bi_size)) {
 		atomic64_inc(&zram->stats.invalid_io);
-		goto error;
+		bio_io_error(bio);
+		return;
 	}
 
 	__zram_make_request(zram, bio);
-	return BLK_QC_T_NONE;
-
-error:
-	bio_io_error(bio);
-	return BLK_QC_T_NONE;
 }
 
 static void zram_slot_free_notify(struct block_device *bdev,
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 6d1de889baeb1..23b28edae90fd 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1163,7 +1163,7 @@ static void quit_max_writeback_rate(struct cache_set *c,
 
 /* Cached devices - read & write stuff */
 
-blk_qc_t cached_dev_submit_bio(struct bio *bio)
+void cached_dev_submit_bio(struct bio *bio)
 {
 	struct search *s;
 	struct block_device *orig_bdev = bio->bi_bdev;
@@ -1176,7 +1176,7 @@ blk_qc_t cached_dev_submit_bio(struct bio *bio)
 		     dc->io_disable)) {
 		bio->bi_status = BLK_STS_IOERR;
 		bio_endio(bio);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	if (likely(d->c)) {
@@ -1222,8 +1222,6 @@ blk_qc_t cached_dev_submit_bio(struct bio *bio)
 	} else
 		/* I/O request sent to backing device */
 		detached_dev_do_request(d, bio, orig_bdev, start_time);
-
-	return BLK_QC_T_NONE;
 }
 
 static int cached_dev_ioctl(struct bcache_device *d, fmode_t mode,
@@ -1273,7 +1271,7 @@ static void flash_dev_nodata(struct closure *cl)
 	continue_at(cl, search_free, NULL);
 }
 
-blk_qc_t flash_dev_submit_bio(struct bio *bio)
+void flash_dev_submit_bio(struct bio *bio)
 {
 	struct search *s;
 	struct closure *cl;
@@ -1282,7 +1280,7 @@ blk_qc_t flash_dev_submit_bio(struct bio *bio)
 	if (unlikely(d->c && test_bit(CACHE_SET_IO_DISABLE, &d->c->flags))) {
 		bio->bi_status = BLK_STS_IOERR;
 		bio_endio(bio);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	s = search_alloc(bio, d, bio->bi_bdev, bio_start_io_acct(bio));
@@ -1298,7 +1296,7 @@ blk_qc_t flash_dev_submit_bio(struct bio *bio)
 		continue_at_nobarrier(&s->cl,
 				      flash_dev_nodata,
 				      bcache_wq);
-		return BLK_QC_T_NONE;
+		return;
 	} else if (bio_data_dir(bio)) {
 		bch_keybuf_check_overlapping(&s->iop.c->moving_gc_keys,
 					&KEY(d->id, bio->bi_iter.bi_sector, 0),
@@ -1314,7 +1312,6 @@ blk_qc_t flash_dev_submit_bio(struct bio *bio)
 	}
 
 	continue_at(cl, search_free, NULL);
-	return BLK_QC_T_NONE;
 }
 
 static int flash_dev_ioctl(struct bcache_device *d, fmode_t mode,
diff --git a/drivers/md/bcache/request.h b/drivers/md/bcache/request.h
index 82b38366a95de..38ab4856eaab0 100644
--- a/drivers/md/bcache/request.h
+++ b/drivers/md/bcache/request.h
@@ -37,10 +37,10 @@ unsigned int bch_get_congested(const struct cache_set *c);
 void bch_data_insert(struct closure *cl);
 
 void bch_cached_dev_request_init(struct cached_dev *dc);
-blk_qc_t cached_dev_submit_bio(struct bio *bio);
+void cached_dev_submit_bio(struct bio *bio);
 
 void bch_flash_dev_request_init(struct bcache_device *d);
-blk_qc_t flash_dev_submit_bio(struct bio *bio);
+void flash_dev_submit_bio(struct bio *bio);
 
 extern struct kmem_cache *bch_search_cache;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a011d09cb0fac..95e4e35a5c700 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1180,14 +1180,13 @@ static noinline void __set_swap_bios_limit(struct mapped_device *md, int latch)
 	mutex_unlock(&md->swap_bios_lock);
 }
 
-static blk_qc_t __map_bio(struct dm_target_io *tio)
+static void __map_bio(struct dm_target_io *tio)
 {
 	int r;
 	sector_t sector;
 	struct bio *clone = &tio->clone;
 	struct dm_io *io = tio->io;
 	struct dm_target *ti = tio->ti;
-	blk_qc_t ret = BLK_QC_T_NONE;
 
 	clone->bi_end_io = clone_endio;
 
@@ -1223,7 +1222,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 	case DM_MAPIO_REMAPPED:
 		/* the bio has been remapped so dispatch it */
 		trace_block_bio_remap(clone, bio_dev(io->orig_bio), sector);
-		ret = submit_bio_noacct(clone);
+		submit_bio_noacct(clone);
 		break;
 	case DM_MAPIO_KILL:
 		if (unlikely(swap_bios_limit(ti, clone))) {
@@ -1245,8 +1244,6 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 		DMWARN("unimplemented target map return value: %d", r);
 		BUG();
 	}
-
-	return ret;
 }
 
 static void bio_setup_sector(struct bio *bio, sector_t sector, unsigned len)
@@ -1333,7 +1330,7 @@ static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
 	}
 }
 
-static blk_qc_t __clone_and_map_simple_bio(struct clone_info *ci,
+static void __clone_and_map_simple_bio(struct clone_info *ci,
 					   struct dm_target_io *tio, unsigned *len)
 {
 	struct bio *clone = &tio->clone;
@@ -1343,8 +1340,7 @@ static blk_qc_t __clone_and_map_simple_bio(struct clone_info *ci,
 	__bio_clone_fast(clone, ci->bio);
 	if (len)
 		bio_setup_sector(clone, ci->sector, *len);
-
-	return __map_bio(tio);
+	__map_bio(tio);
 }
 
 static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
@@ -1358,7 +1354,7 @@ static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
 
 	while ((bio = bio_list_pop(&blist))) {
 		tio = container_of(bio, struct dm_target_io, clone);
-		(void) __clone_and_map_simple_bio(ci, tio, len);
+		__clone_and_map_simple_bio(ci, tio, len);
 	}
 }
 
@@ -1402,7 +1398,7 @@ static int __clone_and_map_data_bio(struct clone_info *ci, struct dm_target *ti,
 		free_tio(tio);
 		return r;
 	}
-	(void) __map_bio(tio);
+	__map_bio(tio);
 
 	return 0;
 }
@@ -1517,11 +1513,10 @@ static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
 /*
  * Entry point to split a bio into clones and submit them to the targets.
  */
-static blk_qc_t __split_and_process_bio(struct mapped_device *md,
+static void __split_and_process_bio(struct mapped_device *md,
 					struct dm_table *map, struct bio *bio)
 {
 	struct clone_info ci;
-	blk_qc_t ret = BLK_QC_T_NONE;
 	int error = 0;
 
 	init_clone_info(&ci, md, map, bio);
@@ -1564,19 +1559,17 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 
 			bio_chain(b, bio);
 			trace_block_split(b, bio->bi_iter.bi_sector);
-			ret = submit_bio_noacct(bio);
+			submit_bio_noacct(bio);
 		}
 	}
 
 	/* drop the extra reference count */
 	dm_io_dec_pending(ci.io, errno_to_blk_status(error));
-	return ret;
 }
 
-static blk_qc_t dm_submit_bio(struct bio *bio)
+static void dm_submit_bio(struct bio *bio)
 {
 	struct mapped_device *md = bio->bi_bdev->bd_disk->private_data;
-	blk_qc_t ret = BLK_QC_T_NONE;
 	int srcu_idx;
 	struct dm_table *map;
 
@@ -1606,10 +1599,9 @@ static blk_qc_t dm_submit_bio(struct bio *bio)
 	if (is_abnormal_io(bio))
 		blk_queue_split(&bio);
 
-	ret = __split_and_process_bio(md, map, bio);
+	__split_and_process_bio(md, map, bio);
 out:
 	dm_put_live_table(md, srcu_idx);
-	return ret;
 }
 
 /*-----------------------------------------------------------------
diff --git a/drivers/md/md.c b/drivers/md/md.c
index ec09083ff0eff..22310d5d8d418 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -443,19 +443,19 @@ void md_handle_request(struct mddev *mddev, struct bio *bio)
 }
 EXPORT_SYMBOL(md_handle_request);
 
-static blk_qc_t md_submit_bio(struct bio *bio)
+static void md_submit_bio(struct bio *bio)
 {
 	const int rw = bio_data_dir(bio);
 	struct mddev *mddev = bio->bi_bdev->bd_disk->private_data;
 
 	if (mddev == NULL || mddev->pers == NULL) {
 		bio_io_error(bio);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	if (unlikely(test_bit(MD_BROKEN, &mddev->flags)) && (rw == WRITE)) {
 		bio_io_error(bio);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	blk_queue_split(&bio);
@@ -464,15 +464,13 @@ static blk_qc_t md_submit_bio(struct bio *bio)
 		if (bio_sectors(bio) != 0)
 			bio->bi_status = BLK_STS_IOERR;
 		bio_endio(bio);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	/* bio could be mergeable after passing to underlayer */
 	bio->bi_opf &= ~REQ_NOMERGE;
 
 	md_handle_request(mddev, bio);
-
-	return BLK_QC_T_NONE;
 }
 
 /* mddev_suspend makes sure no new requests are submitted
diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 088d3dd6f6fac..b6c6866f92592 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -162,7 +162,7 @@ static int nsblk_do_bvec(struct nd_namespace_blk *nsblk,
 	return err;
 }
 
-static blk_qc_t nd_blk_submit_bio(struct bio *bio)
+static void nd_blk_submit_bio(struct bio *bio)
 {
 	struct bio_integrity_payload *bip;
 	struct nd_namespace_blk *nsblk = bio->bi_bdev->bd_disk->private_data;
@@ -173,7 +173,7 @@ static blk_qc_t nd_blk_submit_bio(struct bio *bio)
 	bool do_acct;
 
 	if (!bio_integrity_prep(bio))
-		return BLK_QC_T_NONE;
+		return;
 
 	bip = bio_integrity(bio);
 	rw = bio_data_dir(bio);
@@ -199,7 +199,6 @@ static blk_qc_t nd_blk_submit_bio(struct bio *bio)
 		bio_end_io_acct(bio, start);
 
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
 }
 
 static int nsblk_rw_bytes(struct nd_namespace_common *ndns,
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 92dec49522972..4295fa8094209 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1440,7 +1440,7 @@ static int btt_do_bvec(struct btt *btt, struct bio_integrity_payload *bip,
 	return ret;
 }
 
-static blk_qc_t btt_submit_bio(struct bio *bio)
+static void btt_submit_bio(struct bio *bio)
 {
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	struct btt *btt = bio->bi_bdev->bd_disk->private_data;
@@ -1451,7 +1451,7 @@ static blk_qc_t btt_submit_bio(struct bio *bio)
 	bool do_acct;
 
 	if (!bio_integrity_prep(bio))
-		return BLK_QC_T_NONE;
+		return;
 
 	do_acct = blk_queue_io_stat(bio->bi_bdev->bd_disk->queue);
 	if (do_acct)
@@ -1483,7 +1483,6 @@ static blk_qc_t btt_submit_bio(struct bio *bio)
 		bio_end_io_acct(bio, start);
 
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
 }
 
 static int btt_rw_page(struct block_device *bdev, sector_t sector,
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 72de88ff0d30d..f48a76c904e48 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -190,7 +190,7 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
 	return rc;
 }
 
-static blk_qc_t pmem_submit_bio(struct bio *bio)
+static void pmem_submit_bio(struct bio *bio)
 {
 	int ret = 0;
 	blk_status_t rc = 0;
@@ -229,7 +229,6 @@ static blk_qc_t pmem_submit_bio(struct bio *bio)
 		bio->bi_status = errno_to_blk_status(ret);
 
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
 }
 
 static int pmem_rw_page(struct block_device *bdev, sector_t sector,
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e8ccdd398f784..4a3252651f69e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -312,12 +312,11 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	return false;
 }
 
-static blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
+static void nvme_ns_head_submit_bio(struct bio *bio)
 {
 	struct nvme_ns_head *head = bio->bi_bdev->bd_disk->private_data;
 	struct device *dev = disk_to_dev(head->disk);
 	struct nvme_ns *ns;
-	blk_qc_t ret = BLK_QC_T_NONE;
 	int srcu_idx;
 
 	/*
@@ -334,7 +333,7 @@ static blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 		bio->bi_opf |= REQ_NVME_MPATH;
 		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
 				      bio->bi_iter.bi_sector);
-		ret = submit_bio_noacct(bio);
+		submit_bio_noacct(bio);
 	} else if (nvme_available_path(head)) {
 		dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");
 
@@ -349,7 +348,6 @@ static blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 	}
 
 	srcu_read_unlock(&head->srcu, srcu_idx);
-	return ret;
 }
 
 static int nvme_ns_head_open(struct block_device *bdev, fmode_t mode)
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 5be3d1c39a78e..59e513d34b0f2 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -30,7 +30,7 @@
 
 static int dcssblk_open(struct block_device *bdev, fmode_t mode);
 static void dcssblk_release(struct gendisk *disk, fmode_t mode);
-static blk_qc_t dcssblk_submit_bio(struct bio *bio);
+static void dcssblk_submit_bio(struct bio *bio);
 static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn);
 
@@ -854,7 +854,7 @@ dcssblk_release(struct gendisk *disk, fmode_t mode)
 	up_write(&dcssblk_devices_sem);
 }
 
-static blk_qc_t
+static void
 dcssblk_submit_bio(struct bio *bio)
 {
 	struct dcssblk_dev_info *dev_info;
@@ -907,10 +907,9 @@ dcssblk_submit_bio(struct bio *bio)
 		bytes_done += bvec.bv_len;
 	}
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
+	return;
 fail:
 	bio_io_error(bio);
-	return BLK_QC_T_NONE;
 }
 
 static long
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4a9077c524448..04090ba0ef737 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8248,7 +8248,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 	return dip;
 }
 
-static blk_qc_t btrfs_submit_direct(const struct iomap_iter *iter,
+static void btrfs_submit_direct(const struct iomap_iter *iter,
 		struct bio *dio_bio, loff_t file_offset)
 {
 	struct inode *inode = iter->inode;
@@ -8278,7 +8278,7 @@ static blk_qc_t btrfs_submit_direct(const struct iomap_iter *iter,
 		}
 		dio_bio->bi_status = BLK_STS_RESOURCE;
 		bio_endio(dio_bio);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	if (!write) {
@@ -8372,15 +8372,13 @@ static blk_qc_t btrfs_submit_direct(const struct iomap_iter *iter,
 
 		free_extent_map(em);
 	} while (submit_len > 0);
-	return BLK_QC_T_NONE;
+	return;
 
 out_err_em:
 	free_extent_map(em);
 out_err:
 	dip->dio_bio->bi_status = status;
 	btrfs_dio_private_put(dip);
-
-	return BLK_QC_T_NONE;
 }
 
 const struct iomap_ops btrfs_dio_iomap_ops = {
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index ac0e11bbb4450..9c5559faacdaa 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -915,7 +915,7 @@ const struct file_operations ext4_file_operations = {
 	.llseek		= ext4_llseek,
 	.read_iter	= ext4_file_read_iter,
 	.write_iter	= ext4_file_write_iter,
-	.iopoll		= iomap_dio_iopoll,
+	.iopoll		= iocb_bio_iopoll,
 	.unlocked_ioctl = ext4_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= ext4_compat_ioctl,
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index c559827cb6f91..635f0e3f10ec7 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1353,7 +1353,7 @@ const struct file_operations gfs2_file_fops = {
 	.llseek		= gfs2_llseek,
 	.read_iter	= gfs2_file_read_iter,
 	.write_iter	= gfs2_file_write_iter,
-	.iopoll		= iomap_dio_iopoll,
+	.iopoll		= iocb_bio_iopoll,
 	.unlocked_ioctl	= gfs2_ioctl,
 	.compat_ioctl	= gfs2_compat_ioctl,
 	.mmap		= gfs2_mmap,
@@ -1386,7 +1386,7 @@ const struct file_operations gfs2_file_fops_nolock = {
 	.llseek		= gfs2_llseek,
 	.read_iter	= gfs2_file_read_iter,
 	.write_iter	= gfs2_file_write_iter,
-	.iopoll		= iomap_dio_iopoll,
+	.iopoll		= iocb_bio_iopoll,
 	.unlocked_ioctl	= gfs2_ioctl,
 	.compat_ioctl	= gfs2_compat_ioctl,
 	.mmap		= gfs2_mmap,
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 236aba256cd17..8efab177011dd 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -38,8 +38,7 @@ struct iomap_dio {
 		struct {
 			struct iov_iter		*iter;
 			struct task_struct	*waiter;
-			struct request_queue	*last_queue;
-			blk_qc_t		cookie;
+			struct bio		*poll_bio;
 		} submit;
 
 		/* used for aio completion: */
@@ -49,29 +48,20 @@ struct iomap_dio {
 	};
 };
 
-int iomap_dio_iopoll(struct kiocb *kiocb, unsigned int flags)
-{
-	struct request_queue *q = READ_ONCE(kiocb->private);
-
-	if (!q)
-		return 0;
-	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), flags);
-}
-EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
-
 static void iomap_dio_submit_bio(const struct iomap_iter *iter,
 		struct iomap_dio *dio, struct bio *bio, loff_t pos)
 {
 	atomic_inc(&dio->ref);
 
-	if (dio->iocb->ki_flags & IOCB_HIPRI)
+	if (dio->iocb->ki_flags & IOCB_HIPRI) {
 		bio_set_polled(bio, dio->iocb);
+		dio->submit.poll_bio = bio;
+	}
 
-	dio->submit.last_queue = bdev_get_queue(iter->iomap.bdev);
 	if (dio->dops && dio->dops->submit_io)
-		dio->submit.cookie = dio->dops->submit_io(iter, bio, pos);
+		dio->dops->submit_io(iter, bio, pos);
 	else
-		dio->submit.cookie = submit_bio(bio);
+		submit_bio(bio);
 }
 
 ssize_t iomap_dio_complete(struct iomap_dio *dio)
@@ -164,9 +154,11 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 		} else if (dio->flags & IOMAP_DIO_WRITE) {
 			struct inode *inode = file_inode(dio->iocb->ki_filp);
 
+			WRITE_ONCE(dio->iocb->private, NULL);
 			INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
 			queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
 		} else {
+			WRITE_ONCE(dio->iocb->private, NULL);
 			iomap_dio_complete_work(&dio->aio.work);
 		}
 	}
@@ -497,8 +489,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 
 	dio->submit.iter = iter;
 	dio->submit.waiter = current;
-	dio->submit.cookie = BLK_QC_T_NONE;
-	dio->submit.last_queue = NULL;
+	dio->submit.poll_bio = NULL;
 
 	if (iov_iter_rw(iter) == READ) {
 		if (iomi.pos >= dio->i_size)
@@ -611,8 +602,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (dio->flags & IOMAP_DIO_WRITE_FUA)
 		dio->flags &= ~IOMAP_DIO_NEED_SYNC;
 
-	WRITE_ONCE(iocb->ki_cookie, dio->submit.cookie);
-	WRITE_ONCE(iocb->private, dio->submit.last_queue);
+	WRITE_ONCE(iocb->private, dio->submit.poll_bio);
 
 	/*
 	 * We are about to drop our additional submission reference, which
@@ -639,10 +629,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			if (!READ_ONCE(dio->submit.waiter))
 				break;
 
-			if (!(iocb->ki_flags & IOCB_HIPRI) ||
-			    !dio->submit.last_queue ||
-			    !blk_poll(dio->submit.last_queue,
-					 dio->submit.cookie, 0))
+			if (!dio->submit.poll_bio ||
+			    !bio_poll(dio->submit.poll_bio, 0))
 				blk_io_schedule();
 		}
 		__set_current_state(TASK_RUNNING);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 7aa943edfc02f..62e7fbe4e54c3 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1452,7 +1452,7 @@ const struct file_operations xfs_file_operations = {
 	.write_iter	= xfs_file_write_iter,
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
-	.iopoll		= iomap_dio_iopoll,
+	.iopoll		= iocb_bio_iopoll,
 	.unlocked_ioctl	= xfs_file_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= xfs_file_compat_ioctl,
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index ddc346a9df9ba..3ce5f47338cb6 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1128,7 +1128,7 @@ static const struct file_operations zonefs_file_operations = {
 	.write_iter	= zonefs_file_write_iter,
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
-	.iopoll		= iomap_dio_iopoll,
+	.iopoll		= iocb_bio_iopoll,
 };
 
 static struct kmem_cache *zonefs_inode_cachep;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 0226a8c8fe810..1c6cac02dfc2e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -424,7 +424,7 @@ static inline struct bio *bio_alloc(gfp_t gfp_mask, unsigned short nr_iovecs)
 	return bio_alloc_bioset(gfp_mask, nr_iovecs, &fs_bio_set);
 }
 
-extern blk_qc_t submit_bio(struct bio *);
+void submit_bio(struct bio *bio);
 
 extern void bio_endio(struct bio *);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0e941f2175784..f86e28828a95f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -359,9 +359,9 @@ struct blk_mq_hw_ctx {
 	/** @kobj: Kernel object for sysfs. */
 	struct kobject		kobj;
 
-	/** @poll_considered: Count times blk_poll() was called. */
+	/** @poll_considered: Count times blk_mq_poll() was called. */
 	unsigned long		poll_considered;
-	/** @poll_invoked: Count how many requests blk_poll() polled. */
+	/** @poll_invoked: Count how many requests blk_mq_poll() polled. */
 	unsigned long		poll_invoked;
 	/** @poll_success: Count how many polled requests were completed. */
 	unsigned long		poll_success;
@@ -815,16 +815,6 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
 	     ({ ctx = (hctx)->ctxs[(i)]; 1; }); (i)++)
 
-static inline blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx,
-		struct request *rq)
-{
-	if (rq->tag != -1)
-		return rq->tag | (hctx->queue_num << BLK_QC_T_SHIFT);
-
-	return rq->internal_tag | (hctx->queue_num << BLK_QC_T_SHIFT) |
-			BLK_QC_T_INTERNAL;
-}
-
 static inline void blk_mq_cleanup_rq(struct request *rq)
 {
 	if (rq->q->mq_ops->cleanup_rq)
@@ -843,7 +833,6 @@ static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
 		rq->rq_disk = bio->bi_bdev->bd_disk;
 }
 
-blk_qc_t blk_mq_submit_bio(struct bio *bio);
 void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
 		struct lock_class_key *key);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index f8b9fce688346..72736b4c057c6 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -208,6 +208,9 @@ static inline void bio_issue_init(struct bio_issue *issue,
 			((u64)size << BIO_ISSUE_SIZE_SHIFT));
 }
 
+typedef unsigned int blk_qc_t;
+#define BLK_QC_T_NONE		-1U
+
 /*
  * main unit of I/O for the block layer and lower layers (ie drivers and
  * stacking drivers)
@@ -227,8 +230,8 @@ struct bio {
 
 	struct bvec_iter	bi_iter;
 
+	blk_qc_t		bi_cookie;
 	bio_end_io_t		*bi_end_io;
-
 	void			*bi_private;
 #ifdef CONFIG_BLK_CGROUP
 	/*
@@ -384,7 +387,7 @@ enum req_flag_bits {
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
-	__REQ_POLLED,		/* caller polls for completion using blk_poll */
+	__REQ_POLLED,		/* caller polls for completion using bio_poll */
 
 	/* for driver use */
 	__REQ_DRV,
@@ -495,11 +498,6 @@ static inline int op_stat_group(unsigned int op)
 	return op_is_write(op);
 }
 
-typedef unsigned int blk_qc_t;
-#define BLK_QC_T_NONE		-1U
-#define BLK_QC_T_SHIFT		16
-#define BLK_QC_T_INTERNAL	(1U << 31)
-
 struct blk_rq_stat {
 	u64 mean;
 	u64 min;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2b80c98fc373e..2a8689e949b4c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -25,6 +25,7 @@ struct request;
 struct sg_io_hdr;
 struct blkcg_gq;
 struct blk_flush_queue;
+struct kiocb;
 struct pr_ops;
 struct rq_qos;
 struct blk_queue_stats;
@@ -550,7 +551,7 @@ static inline unsigned int blk_queue_depth(struct request_queue *q)
 
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
-blk_qc_t submit_bio_noacct(struct bio *bio);
+void submit_bio_noacct(struct bio *bio);
 
 extern int blk_lld_busy(struct request_queue *q);
 extern void blk_queue_split(struct bio **);
@@ -568,7 +569,8 @@ blk_status_t errno_to_blk_status(int errno);
 #define BLK_POLL_ONESHOT		(1 << 0)
 /* do not sleep to wait for the expected completion time */
 #define BLK_POLL_NOSLEEP		(1 << 1)
-int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags);
+int bio_poll(struct bio *bio, unsigned int flags);
+int iocb_bio_iopoll(struct kiocb *kiocb, unsigned int flags);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 {
@@ -1176,7 +1178,7 @@ static inline void blk_ksm_unregister(struct request_queue *q) { }
 
 
 struct block_device_operations {
-	blk_qc_t (*submit_bio) (struct bio *bio);
+	void (*submit_bio)(struct bio *bio);
 	int (*open) (struct block_device *, fmode_t);
 	void (*release) (struct gendisk *, fmode_t);
 	int (*rw_page)(struct block_device *, sector_t, struct page *, unsigned int);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c443cddf414fd..f595f4097cb75 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -334,11 +334,7 @@ struct kiocb {
 	int			ki_flags;
 	u16			ki_hint;
 	u16			ki_ioprio; /* See linux/ioprio.h */
-	union {
-		unsigned int		ki_cookie; /* for ->iopoll */
-		struct wait_page_queue	*ki_waitq; /* for async buffered IO */
-	};
-
+	struct wait_page_queue	*ki_waitq; /* for async buffered IO */
 	randomized_struct_fields_end
 };
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 1e86b65567c21..63f4ea4dac9b1 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -313,8 +313,8 @@ int iomap_writepages(struct address_space *mapping,
 struct iomap_dio_ops {
 	int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
 		      unsigned flags);
-	blk_qc_t (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
-			      loff_t file_offset);
+	void (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
+		          loff_t file_offset);
 };
 
 /*
@@ -337,7 +337,6 @@ struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags);
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
-int iomap_dio_iopoll(struct kiocb *kiocb, unsigned int flags);
 
 #ifdef CONFIG_SWAP
 struct file;
diff --git a/mm/page_io.c b/mm/page_io.c
index ed2eded74f3ad..a68faab5b3105 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -358,8 +358,6 @@ int swap_readpage(struct page *page, bool synchronous)
 	struct bio *bio;
 	int ret = 0;
 	struct swap_info_struct *sis = page_swap_info(page);
-	blk_qc_t qc;
-	struct gendisk *disk;
 	unsigned long pflags;
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page) && !synchronous, page);
@@ -409,8 +407,6 @@ int swap_readpage(struct page *page, bool synchronous)
 	bio->bi_iter.bi_sector = swap_page_sector(page);
 	bio->bi_end_io = end_swap_bio_read;
 	bio_add_page(bio, page, thp_size(page), 0);
-
-	disk = bio->bi_bdev->bd_disk;
 	/*
 	 * Keep this task valid during swap readpage because the oom killer may
 	 * attempt to access it in the page fault retry time check.
@@ -422,13 +418,13 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 	count_vm_event(PSWPIN);
 	bio_get(bio);
-	qc = submit_bio(bio);
+	submit_bio(bio);
 	while (synchronous) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!READ_ONCE(bio->bi_private))
 			break;
 
-		if (!blk_poll(disk->queue, qc, 0))
+		if (!bio_poll(bio, 0))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.30.2

