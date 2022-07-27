Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECFF582ADC
	for <lists+linux-block@lfdr.de>; Wed, 27 Jul 2022 18:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbiG0QYt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 Jul 2022 12:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiG0QYG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 12:24:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6726A4E60C
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mt63BJNlj/ri4/AeKhGq2mdMPOKH1/zYlxFrvB5PFVk=; b=fAkm+D6kGTYIXjTJ9aT9/+wadE
        vE9o8MVVIkbnd++Ro+Y5lyfsAb3r42X0ArbEyzzaGEUgcuG6pbOlttOKbE0HWRbAT2cw/QMiM1rJk
        NWbui7K5o3b26cSQIYXJgf9evvDOcWwfHDnNn1Tl219cZ41LaT41u8n5YCdSFUuEU86/FsrKvqDdM
        JDTFUPfIKE5GnBceppftcm/ZOEpM7f4tKR1s3XsHcmfxrPgbU9cBO3JNvJGHvbk8ik4Y4fON6ER3K
        4sWmg4s8YEq23E0cTXoOnligUGAVoups7wrc4bGPZNwejosu9ZtOlan5M2d1lrfQ/qTSlr+3oOCfV
        DwlSUe1w==;
Received: from [2607:fb90:18d2:b6be:6d6f:ba8a:ca81:9775] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGjoV-00FUhE-Er; Wed, 27 Jul 2022 16:23:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/6] block: move ->bio_split to the gendisk
Date:   Wed, 27 Jul 2022 12:22:57 -0400
Message-Id: <20220727162300.3089193-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220727162300.3089193-1-hch@lst.de>
References: <20220727162300.3089193-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only non-passthrough requests are split by the block layer and use the
->bio_split bio_set.  Move it from the request_queue to the gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-core.c       | 9 +--------
 block/blk-merge.c      | 7 ++++---
 block/blk-sysfs.c      | 2 --
 block/genhd.c          | 8 +++++++-
 drivers/md/dm.c        | 2 +-
 include/linux/blkdev.h | 3 ++-
 6 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 123468b9d2e43..59f13d011949d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -377,7 +377,6 @@ static void blk_timeout_work(struct work_struct *work)
 struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 {
 	struct request_queue *q;
-	int ret;
 
 	q = kmem_cache_alloc_node(blk_get_queue_kmem_cache(alloc_srcu),
 			GFP_KERNEL | __GFP_ZERO, node_id);
@@ -396,13 +395,9 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 	if (q->id < 0)
 		goto fail_srcu;
 
-	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, 0);
-	if (ret)
-		goto fail_id;
-
 	q->stats = blk_alloc_queue_stats();
 	if (!q->stats)
-		goto fail_split;
+		goto fail_id;
 
 	q->node = node_id;
 
@@ -439,8 +434,6 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 
 fail_stats:
 	blk_free_queue_stats(q->stats);
-fail_split:
-	bioset_exit(&q->bio_split);
 fail_id:
 	ida_free(&blk_queue_ida, q->id);
 fail_srcu:
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 6e29fb28584ef..30872a3537648 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -331,18 +331,19 @@ static struct bio *bio_split_rw(struct bio *bio, struct request_queue *q,
 struct bio *__bio_split_to_limits(struct bio *bio, struct request_queue *q,
 		       unsigned int *nr_segs)
 {
+	struct bio_set *bs = &bio->bi_bdev->bd_disk->bio_split;
 	struct bio *split;
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
-		split = bio_split_discard(bio, q, nr_segs, &q->bio_split);
+		split = bio_split_discard(bio, q, nr_segs, bs);
 		break;
 	case REQ_OP_WRITE_ZEROES:
-		split = bio_split_write_zeroes(bio, q, nr_segs, &q->bio_split);
+		split = bio_split_write_zeroes(bio, q, nr_segs, bs);
 		break;
 	default:
-		split = bio_split_rw(bio, q, nr_segs, &q->bio_split);
+		split = bio_split_rw(bio, q, nr_segs, bs);
 		break;
 	}
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index c0303026752d5..e1f009aba6fd2 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -779,8 +779,6 @@ static void blk_release_queue(struct kobject *kobj)
 	if (queue_is_mq(q))
 		blk_mq_release(q);
 
-	bioset_exit(&q->bio_split);
-
 	if (blk_queue_has_srcu(q))
 		cleanup_srcu_struct(q->srcu);
 
diff --git a/block/genhd.c b/block/genhd.c
index 44dfcf67ed96a..e3daebeaf9ae9 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1139,6 +1139,7 @@ static void disk_release(struct device *dev)
 	WARN_ON_ONCE(disk_live(disk));
 
 	blkcg_exit_queue(disk->queue);
+	bioset_exit(&disk->bio_split);
 
 	disk_release_events(disk);
 	kfree(disk->random);
@@ -1330,9 +1331,12 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	if (!disk)
 		goto out_put_queue;
 
+	if (bioset_init(&disk->bio_split, BIO_POOL_SIZE, 0, 0))
+		goto out_free_disk;
+
 	disk->bdi = bdi_alloc(node_id);
 	if (!disk->bdi)
-		goto out_free_disk;
+		goto out_free_bioset;
 
 	/* bdev_alloc() might need the queue, set before the first call */
 	disk->queue = q;
@@ -1370,6 +1374,8 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	iput(disk->part0->bd_inode);
 out_free_bdi:
 	bdi_put(disk->bdi);
+out_free_bioset:
+	bioset_exit(&disk->bio_split);
 out_free_disk:
 	kfree(disk);
 out_put_queue:
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a014a002298bd..b7458f2dd3e45 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1693,7 +1693,7 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 	 */
 	WARN_ON_ONCE(!dm_io_flagged(io, DM_IO_WAS_SPLIT));
 	io->split_bio = bio_split(bio, io->sectors, GFP_NOIO,
-				  &md->queue->bio_split);
+				  &md->disk->bio_split);
 	bio_chain(io->split_bio, bio);
 	trace_block_split(io->split_bio, bio->bi_iter.bi_sector);
 	submit_bio_noacct(bio);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5eef8d2eddc1c..49dcd31e283e8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -140,6 +140,8 @@ struct gendisk {
 	struct request_queue *queue;
 	void *private_data;
 
+	struct bio_set bio_split;
+
 	int flags;
 	unsigned long state;
 #define GD_NEED_PART_SCAN		0
@@ -531,7 +533,6 @@ struct request_queue {
 
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
-	struct bio_set		bio_split;
 
 	struct dentry		*debugfs_dir;
 	struct dentry		*sched_debugfs_dir;
-- 
2.30.2

