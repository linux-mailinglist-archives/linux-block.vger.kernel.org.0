Return-Path: <linux-block+bounces-15624-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264239F7476
	for <lists+linux-block@lfdr.de>; Thu, 19 Dec 2024 07:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD9618850A2
	for <lists+linux-block@lfdr.de>; Thu, 19 Dec 2024 06:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927F213AD22;
	Thu, 19 Dec 2024 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pZi2SAe3"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3584C78F2D
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734588140; cv=none; b=FHvwkQC/WXN/G4OU2i5fV1fA/q7dunowu09UbaH+TmWW/4+GTWvbOBPgbOouFQKXpfMzbFSQ/19SaOhiLIsUj5LNO2kcvyGXwLAXqkpRAeanULOVHddXU5W8O+vQddEi1SDctyZP4K59ks5huKjJVAJfn2yQpOaAnwmLuw1Neno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734588140; c=relaxed/simple;
	bh=gLIUlV2zVuxMMgb6XqK9BZD6tuKWQbpc4hBfZoJ71Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GryPzpx/4+is+nsoyW9DZlUm5GblKWLVYUhVfiou54CUa5bJTv+JJHw/gdrHD4W1Rodpo1F0AChNbxQfwKQaHntn6ja9FITXYAJnnCScli9SePz0dwk92occxyf5aesWYx2PJvjdvI+SkRp7n906iuq8CdMsYhgWIB4NOzSlIms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pZi2SAe3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=pP7Sq33PYs0JLPULEtQABURAWFpJe92lc4u9FX53XtM=; b=pZi2SAe3y3nZWXtRE0g9j/mqEA
	X5BZtSoZROs0XSkT1q85n15oinyD4i8IuR4XlhTBylZZMR9pgkF6N9XGpyDBpF1bZqryy8NxpIuAE
	9ZnHf5utVdQMGXtl58tRvvYC3ybzn9FmaVyULAK1Uu/983od0vvRDGDBX9MjRnbSrH896RWqzkOCT
	ZH2POJC+qjzvgNh30k1A7QRppjpBsr0vrSAsAqFFZuQIEBNSPQITkijqmM0wv48rrvCrzoNeEAteL
	+UkxlB9ZwPFkKnHPHIxFIa/js4pFnkWVocjTwwpTyYQXmNiKrSQFtJJN5B2l1HyYfBxGkqneH5NBn
	xNb6iy8A==;
Received: from hotelhilton-2.munich-airport.com ([91.228.175.37] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tO9c1-00000000w3z-1G5r;
	Thu, 19 Dec 2024 06:02:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: remove BLK_MQ_F_SHOULD_MERGE
Date: Thu, 19 Dec 2024 07:01:59 +0100
Message-ID: <20241219060214.1928848-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

BLK_MQ_F_SHOULD_MERGE is set for all tag_sets except those that purely
process passthrough commands (bsg-lib, ufs tmf, various nvme admin
queues) and thus don't even check the flag.  Remove it to simplify the
driver interface.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c          | 1 -
 block/blk-mq-debugfs.c              | 1 -
 block/blk-mq-sched.c                | 3 +--
 drivers/block/amiflop.c             | 1 -
 drivers/block/aoe/aoeblk.c          | 1 -
 drivers/block/ataflop.c             | 1 -
 drivers/block/floppy.c              | 1 -
 drivers/block/loop.c                | 3 +--
 drivers/block/mtip32xx/mtip32xx.c   | 1 -
 drivers/block/nbd.c                 | 3 +--
 drivers/block/null_blk/main.c       | 2 --
 drivers/block/ps3disk.c             | 3 +--
 drivers/block/rbd.c                 | 1 -
 drivers/block/rnbd/rnbd-clt.c       | 3 +--
 drivers/block/sunvdc.c              | 2 +-
 drivers/block/swim.c                | 2 +-
 drivers/block/swim3.c               | 3 +--
 drivers/block/ublk_drv.c            | 1 -
 drivers/block/virtio_blk.c          | 1 -
 drivers/block/xen-blkfront.c        | 1 -
 drivers/block/z2ram.c               | 1 -
 drivers/cdrom/gdrom.c               | 2 +-
 drivers/md/dm-rq.c                  | 2 +-
 drivers/memstick/core/ms_block.c    | 3 +--
 drivers/memstick/core/mspro_block.c | 3 +--
 drivers/mmc/core/queue.c            | 2 +-
 drivers/mtd/mtd_blkdevs.c           | 2 +-
 drivers/mtd/ubi/block.c             | 2 +-
 drivers/nvme/host/apple.c           | 1 -
 drivers/nvme/host/core.c            | 1 -
 drivers/s390/block/dasd_genhd.c     | 1 -
 drivers/s390/block/scm_blk.c        | 1 -
 drivers/scsi/scsi_lib.c             | 1 -
 include/linux/blk-mq.h              | 1 -
 34 files changed, 15 insertions(+), 43 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 66c1a8835e36..0b1e61f72fb3 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -865,7 +865,6 @@ static int ubd_add(int n, char **error_out)
 	ubd_dev->tag_set.ops = &ubd_mq_ops;
 	ubd_dev->tag_set.queue_depth = 64;
 	ubd_dev->tag_set.numa_node = NUMA_NO_NODE;
-	ubd_dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ubd_dev->tag_set.driver_data = ubd_dev;
 	ubd_dev->tag_set.nr_hw_queues = 1;
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 5463697a8442..4b6b20ccdb53 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -181,7 +181,6 @@ static const char *const alloc_policy_name[] = {
 
 #define HCTX_FLAG_NAME(name) [ilog2(BLK_MQ_F_##name)] = #name
 static const char *const hctx_flag_name[] = {
-	HCTX_FLAG_NAME(SHOULD_MERGE),
 	HCTX_FLAG_NAME(TAG_QUEUE_SHARED),
 	HCTX_FLAG_NAME(STACKING),
 	HCTX_FLAG_NAME(TAG_HCTX_SHARED),
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 451a2c1f1f32..7442ca27c2bf 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -351,8 +351,7 @@ bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 	ctx = blk_mq_get_ctx(q);
 	hctx = blk_mq_map_queue(q, bio->bi_opf, ctx);
 	type = hctx->type;
-	if (!(hctx->flags & BLK_MQ_F_SHOULD_MERGE) ||
-	    list_empty_careful(&ctx->rq_lists[type]))
+	if (list_empty_careful(&ctx->rq_lists[type]))
 		goto out_put;
 
 	/* default per sw-queue merge */
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 49ced65bef4c..9edd4468f755 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1819,7 +1819,6 @@ static int fd_alloc_drive(int drive)
 	unit[drive].tag_set.nr_maps = 1;
 	unit[drive].tag_set.queue_depth = 2;
 	unit[drive].tag_set.numa_node = NUMA_NO_NODE;
-	unit[drive].tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	if (blk_mq_alloc_tag_set(&unit[drive].tag_set))
 		goto out_cleanup_trackbuf;
 
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 2028795ec61c..00b74a845328 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -368,7 +368,6 @@ aoeblk_gdalloc(void *vp)
 	set->nr_hw_queues = 1;
 	set->queue_depth = 128;
 	set->numa_node = NUMA_NO_NODE;
-	set->flags = BLK_MQ_F_SHOULD_MERGE;
 	err = blk_mq_alloc_tag_set(set);
 	if (err) {
 		pr_err("aoe: cannot allocate tag set for %ld.%d\n",
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 4ba98c6654be..110f9aca2667 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2088,7 +2088,6 @@ static int __init atari_floppy_init (void)
 		unit[i].tag_set.nr_maps = 1;
 		unit[i].tag_set.queue_depth = 2;
 		unit[i].tag_set.numa_node = NUMA_NO_NODE;
-		unit[i].tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 		ret = blk_mq_alloc_tag_set(&unit[i].tag_set);
 		if (ret)
 			goto err;
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 3affb538b989..abf0486f0d4f 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4596,7 +4596,6 @@ static int __init do_floppy_init(void)
 		tag_sets[drive].nr_maps = 1;
 		tag_sets[drive].queue_depth = 2;
 		tag_sets[drive].numa_node = NUMA_NO_NODE;
-		tag_sets[drive].flags = BLK_MQ_F_SHOULD_MERGE;
 		err = blk_mq_alloc_tag_set(&tag_sets[drive]);
 		if (err)
 			goto out_put_disk;
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8f6761c27c68..836a53eef4b4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2023,8 +2023,7 @@ static int loop_add(int i)
 	lo->tag_set.queue_depth = hw_queue_depth;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
-	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
-		BLK_MQ_F_NO_SCHED_BY_DEFAULT;
+	lo->tag_set.flags = BLK_MQ_F_STACKING | BLK_MQ_F_NO_SCHED_BY_DEFAULT;
 	lo->tag_set.driver_data = lo;
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 43701b7b10a7..95361099a2dc 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3416,7 +3416,6 @@ static int mtip_block_initialize(struct driver_data *dd)
 	dd->tags.reserved_tags = 1;
 	dd->tags.cmd_size = sizeof(struct mtip_cmd);
 	dd->tags.numa_node = dd->numa_node;
-	dd->tags.flags = BLK_MQ_F_SHOULD_MERGE;
 	dd->tags.driver_data = dd;
 	dd->tags.timeout = MTIP_NCQ_CMD_TIMEOUT_MS;
 
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b852050d8a96..b1a5af69a66d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1841,8 +1841,7 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	nbd->tag_set.queue_depth = 128;
 	nbd->tag_set.numa_node = NUMA_NO_NODE;
 	nbd->tag_set.cmd_size = sizeof(struct nbd_cmd);
-	nbd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
-		BLK_MQ_F_BLOCKING;
+	nbd->tag_set.flags = BLK_MQ_F_BLOCKING;
 	nbd->tag_set.driver_data = nbd;
 	INIT_WORK(&nbd->remove_work, nbd_dev_remove_work);
 	nbd->backend = NULL;
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 7b674187c096..178e62cd9a9f 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1791,7 +1791,6 @@ static int null_init_global_tag_set(void)
 	tag_set.nr_hw_queues = g_submit_queues;
 	tag_set.queue_depth = g_hw_queue_depth;
 	tag_set.numa_node = g_home_node;
-	tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	if (g_no_sched)
 		tag_set.flags |= BLK_MQ_F_NO_SCHED;
 	if (g_shared_tag_bitmap)
@@ -1817,7 +1816,6 @@ static int null_setup_tagset(struct nullb *nullb)
 	nullb->tag_set->nr_hw_queues = nullb->dev->submit_queues;
 	nullb->tag_set->queue_depth = nullb->dev->hw_queue_depth;
 	nullb->tag_set->numa_node = nullb->dev->home_node;
-	nullb->tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
 	if (nullb->dev->no_sched)
 		nullb->tag_set->flags |= BLK_MQ_F_NO_SCHED;
 	if (nullb->dev->shared_tag_bitmap)
diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index ff45ed766469..68fed46c463e 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -434,8 +434,7 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 
 	ps3disk_identify(dev);
 
-	error = blk_mq_alloc_sq_tag_set(&priv->tag_set, &ps3disk_mq_ops, 1,
-					BLK_MQ_F_SHOULD_MERGE);
+	error = blk_mq_alloc_sq_tag_set(&priv->tag_set, &ps3disk_mq_ops, 1, 0);
 	if (error)
 		goto fail_teardown;
 
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ac421dbeeb11..5b393e4a1ddf 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4964,7 +4964,6 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	rbd_dev->tag_set.ops = &rbd_mq_ops;
 	rbd_dev->tag_set.queue_depth = rbd_dev->opts->queue_depth;
 	rbd_dev->tag_set.numa_node = NUMA_NO_NODE;
-	rbd_dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	rbd_dev->tag_set.nr_hw_queues = num_present_cpus();
 	rbd_dev->tag_set.cmd_size = sizeof(struct rbd_img_request);
 
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index c34695d2eea7..82467ecde7ec 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1209,8 +1209,7 @@ static int setup_mq_tags(struct rnbd_clt_session *sess)
 	tag_set->ops		= &rnbd_mq_ops;
 	tag_set->queue_depth	= sess->queue_depth;
 	tag_set->numa_node		= NUMA_NO_NODE;
-	tag_set->flags		= BLK_MQ_F_SHOULD_MERGE |
-				  BLK_MQ_F_TAG_QUEUE_SHARED;
+	tag_set->flags		= BLK_MQ_F_TAG_QUEUE_SHARED;
 	tag_set->cmd_size	= sizeof(struct rnbd_iu) + RNBD_RDMA_SGL_SIZE;
 
 	/* for HCTX_TYPE_DEFAULT, HCTX_TYPE_READ, HCTX_TYPE_POLL */
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 2d38331ee667..88dcae6ec575 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -829,7 +829,7 @@ static int probe_disk(struct vdc_port *port)
 	}
 
 	err = blk_mq_alloc_sq_tag_set(&port->tag_set, &vdc_mq_ops,
-			VDC_TX_RING_SIZE, BLK_MQ_F_SHOULD_MERGE);
+			VDC_TX_RING_SIZE, 0);
 	if (err)
 		return err;
 
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index be4ac58afe41..eda33c5eb5e2 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -818,7 +818,7 @@ static int swim_floppy_init(struct swim_priv *swd)
 
 	for (drive = 0; drive < swd->floppy_count; drive++) {
 		err = blk_mq_alloc_sq_tag_set(&swd->unit[drive].tag_set,
-				&swim_mq_ops, 2, BLK_MQ_F_SHOULD_MERGE);
+				&swim_mq_ops, 2, 0);
 		if (err)
 			goto exit_put_disks;
 
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 90be1017f7bf..9914153b365b 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1208,8 +1208,7 @@ static int swim3_attach(struct macio_dev *mdev,
 	fs = &floppy_states[floppy_count];
 	memset(fs, 0, sizeof(*fs));
 
-	rc = blk_mq_alloc_sq_tag_set(&fs->tag_set, &swim3_mq_ops, 2,
-			BLK_MQ_F_SHOULD_MERGE);
+	rc = blk_mq_alloc_sq_tag_set(&fs->tag_set, &swim3_mq_ops, 2, 0);
 	if (rc)
 		goto out_unregister;
 
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d4aed12dd436..6c16cb798fdd 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2205,7 +2205,6 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 	ub->tag_set.queue_depth = ub->dev_info.queue_depth;
 	ub->tag_set.numa_node = NUMA_NO_NODE;
 	ub->tag_set.cmd_size = sizeof(struct ublk_rq_data);
-	ub->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ub->tag_set.driver_data = ub;
 	return blk_mq_alloc_tag_set(&ub->tag_set);
 }
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 3efe378f1386..ae0cd0828841 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1481,7 +1481,6 @@ static int virtblk_probe(struct virtio_device *vdev)
 	vblk->tag_set.ops = &virtio_mq_ops;
 	vblk->tag_set.queue_depth = queue_depth;
 	vblk->tag_set.numa_node = NUMA_NO_NODE;
-	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	vblk->tag_set.cmd_size =
 		sizeof(struct virtblk_req) +
 		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 59ce113b882a..edcd08a9dcef 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1131,7 +1131,6 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 	} else
 		info->tag_set.queue_depth = BLK_RING_SIZE(info);
 	info->tag_set.numa_node = NUMA_NO_NODE;
-	info->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	info->tag_set.cmd_size = sizeof(struct blkif_req);
 	info->tag_set.driver_data = info;
 
diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 4b7219be1bb8..8c1c7f4211eb 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -354,7 +354,6 @@ static int __init z2_init(void)
 	tag_set.nr_maps = 1;
 	tag_set.queue_depth = 16;
 	tag_set.numa_node = NUMA_NO_NODE;
-	tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ret = blk_mq_alloc_tag_set(&tag_set);
 	if (ret)
 		goto out_unregister_blkdev;
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 64b097e830d4..85aceab5eac6 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -777,7 +777,7 @@ static int probe_gdrom(struct platform_device *devptr)
 	probe_gdrom_setupcd();
 
 	err = blk_mq_alloc_sq_tag_set(&gd.tag_set, &gdrom_mq_ops, 1,
-				BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING);
+				BLK_MQ_F_BLOCKING);
 	if (err)
 		goto probe_fail_free_cd_info;
 
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 499f8cc8a39f..e23076f7ece2 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -547,7 +547,7 @@ int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
 	md->tag_set->ops = &dm_mq_ops;
 	md->tag_set->queue_depth = dm_get_blk_mq_queue_depth();
 	md->tag_set->numa_node = md->numa_node_id;
-	md->tag_set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;
+	md->tag_set->flags = BLK_MQ_F_STACKING;
 	md->tag_set->nr_hw_queues = dm_get_blk_mq_nr_hw_queues();
 	md->tag_set->driver_data = md;
 
diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 20a2466bec23..5b617c1f6789 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2094,8 +2094,7 @@ static int msb_init_disk(struct memstick_dev *card)
 	if (msb->disk_id  < 0)
 		return msb->disk_id;
 
-	rc = blk_mq_alloc_sq_tag_set(&msb->tag_set, &msb_mq_ops, 2,
-				     BLK_MQ_F_SHOULD_MERGE);
+	rc = blk_mq_alloc_sq_tag_set(&msb->tag_set, &msb_mq_ops, 2, 0);
 	if (rc)
 		goto out_release_id;
 
diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index 13b317c56069..634d343b6bdb 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -1139,8 +1139,7 @@ static int mspro_block_init_disk(struct memstick_dev *card)
 	if (disk_id < 0)
 		return disk_id;
 
-	rc = blk_mq_alloc_sq_tag_set(&msb->tag_set, &mspro_mq_ops, 2,
-				     BLK_MQ_F_SHOULD_MERGE);
+	rc = blk_mq_alloc_sq_tag_set(&msb->tag_set, &mspro_mq_ops, 2, 0);
 	if (rc)
 		goto out_release_id;
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 4d6844261912..ab662f502fe7 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -441,7 +441,7 @@ struct gendisk *mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	else
 		mq->tag_set.queue_depth = MMC_QUEUE_DEPTH;
 	mq->tag_set.numa_node = NUMA_NO_NODE;
-	mq->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
+	mq->tag_set.flags = BLK_MQ_F_BLOCKING;
 	mq->tag_set.nr_hw_queues = 1;
 	mq->tag_set.cmd_size = sizeof(struct mmc_queue_req);
 	mq->tag_set.driver_data = mq;
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 47ead84407cd..ee7e1d908986 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -329,7 +329,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 		goto out_list_del;
 
 	ret = blk_mq_alloc_sq_tag_set(new->tag_set, &mtd_mq_ops, 2,
-			BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING);
+			BLK_MQ_F_BLOCKING);
 	if (ret)
 		goto out_kfree_tag_set;
 	
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 60d0155be869..2836905f0152 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -383,7 +383,7 @@ int ubiblock_create(struct ubi_volume_info *vi)
 	dev->tag_set.ops = &ubiblock_mq_ops;
 	dev->tag_set.queue_depth = 64;
 	dev->tag_set.numa_node = NUMA_NO_NODE;
-	dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
+	dev->tag_set.flags = BLK_MQ_F_BLOCKING;
 	dev->tag_set.cmd_size = sizeof(struct ubiblock_pdu);
 	dev->tag_set.driver_data = dev;
 	dev->tag_set.nr_hw_queues = 1;
diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 4319ab50c10d..83c60468542c 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1275,7 +1275,6 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
 	anv->tagset.timeout = NVME_IO_TIMEOUT;
 	anv->tagset.numa_node = NUMA_NO_NODE;
 	anv->tagset.cmd_size = sizeof(struct apple_nvme_iod);
-	anv->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
 	anv->tagset.driver_data = &anv->ioq;
 
 	ret = blk_mq_alloc_tag_set(&anv->tagset);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d169a30eb935..6c98a1eb7978 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4639,7 +4639,6 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		/* Reserved for fabric connect */
 		set->reserved_tags = 1;
 	set->numa_node = ctrl->numa_node;
-	set->flags = BLK_MQ_F_SHOULD_MERGE;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
 		set->flags |= BLK_MQ_F_BLOCKING;
 	set->cmd_size = cmd_size;
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 6da47a65af61..28e92fad0ca1 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -56,7 +56,6 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 	block->tag_set.cmd_size = sizeof(struct dasd_ccw_req);
 	block->tag_set.nr_hw_queues = nr_hw_queues;
 	block->tag_set.queue_depth = queue_depth;
-	block->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	block->tag_set.numa_node = NUMA_NO_NODE;
 	rc = blk_mq_alloc_tag_set(&block->tag_set);
 	if (rc)
diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 3fcfe029db1b..91bbe9d2e5ac 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -461,7 +461,6 @@ int scm_blk_dev_setup(struct scm_blk_dev *bdev, struct scm_device *scmdev)
 	bdev->tag_set.cmd_size = sizeof(blk_status_t);
 	bdev->tag_set.nr_hw_queues = nr_requests;
 	bdev->tag_set.queue_depth = nr_requests_per_io * nr_requests;
-	bdev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	bdev->tag_set.numa_node = NUMA_NO_NODE;
 
 	ret = blk_mq_alloc_tag_set(&bdev->tag_set);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index adee6f60c966..5cf124e13097 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2065,7 +2065,6 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 	tag_set->queue_depth = shost->can_queue;
 	tag_set->cmd_size = cmd_size;
 	tag_set->numa_node = dev_to_node(shost->dma_dev);
-	tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
 	tag_set->flags |=
 		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
 	if (shost->queuecommand_may_block)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index c596e0e4cb75..4096d4456582 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -668,7 +668,6 @@ struct blk_mq_ops {
 
 /* Keep hctx_flag_name[] in sync with the definitions below */
 enum {
-	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_QUEUE_SHARED = 1 << 1,
 	/*
 	 * Set when this device requires underlying blk-mq device for
-- 
2.45.2


