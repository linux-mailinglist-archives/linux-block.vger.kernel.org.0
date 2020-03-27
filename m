Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABDAC195301
	for <lists+linux-block@lfdr.de>; Fri, 27 Mar 2020 09:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgC0Ieq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 27 Mar 2020 04:34:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgC0Ieq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 04:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PEd2RKpUwVnj8g696bgiCIyrbC0gtPivoPHwkjj9cPM=; b=mgK+I1KrkPIgOUbX+6xvFcWdYv
        jR4WIUVpA9nxPL/sfW3ulKlTjXUYFBC4gDODa7bzyLMfaAluL1Z5MVg7CcsjBWbA9qEOlWKwVnugI
        GQbYiW8UJP3TGvbq0ZRaXd2JSjPGyqDlojBqr64bnEYaAhvihBcqXWxnC/5QVnUkHN0VYDxmrYaAv
        kgYN9RCXJTnFR556QaHmCxeMEPpzxZ8CcI0rp0himhjKb5gsl3yUvd0JzFv0UXIGyXBLiWceq6jBZ
        RTa2siLbez+5ZdojGEulcSFapPvzH6+PaVVdiktdMalyekbx2mah9qvtLYn/GKkCe0pmPOo8ZUN20
        HMKdYSIA==;
Received: from [2001:4bb8:18c:2a9e:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHkRx-0007sj-It; Fri, 27 Mar 2020 08:34:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 4/5] block: simplify queue allocation
Date:   Fri, 27 Mar 2020 09:30:11 +0100
Message-Id: <20200327083012.1618778-5-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327083012.1618778-1-hch@lst.de>
References: <20200327083012.1618778-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Current make_request based drivers use either blk_alloc_queue_node or
blk_alloc_queue to allocate a queue, and then set up the make_request_fn
function pointer and a few parameters using the blk_queue_make_request
helper.  Simplify this by passing the make_request pointer to
blk_alloc_queue, and while at it merge the _node variant into the main
helper by always passing a node_id, and remove the superfluous gfp_mask
parameter.  A lower-level __blk_alloc_queue is kept for the blk-mq case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/emu/nfblock.c             |  3 +--
 arch/xtensa/platforms/iss/simdisk.c |  3 +--
 block/blk-cgroup.c                  |  2 +-
 block/blk-core.c                    | 39 +++++++++++++++++------------
 block/blk-mq.c                      |  8 ++----
 block/blk-settings.c                | 36 --------------------------
 block/blk.h                         |  2 ++
 drivers/block/brd.c                 |  4 +--
 drivers/block/drbd/drbd_main.c      |  3 +--
 drivers/block/null_blk_main.c       |  3 +--
 drivers/block/pktcdvd.c             |  3 +--
 drivers/block/ps3vram.c             |  3 +--
 drivers/block/rsxx/dev.c            |  3 +--
 drivers/block/umem.c                |  4 +--
 drivers/block/zram/zram_drv.c       |  4 +--
 drivers/lightnvm/core.c             |  3 +--
 drivers/md/bcache/super.c           |  3 +--
 drivers/md/dm.c                     |  9 +++----
 drivers/md/md.c                     |  3 +--
 drivers/nvdimm/blk.c                |  3 +--
 drivers/nvdimm/btt.c                |  3 +--
 drivers/nvdimm/pmem.c               |  3 +--
 drivers/nvme/host/multipath.c       |  3 +--
 drivers/s390/block/dcssblk.c        |  4 +--
 drivers/s390/block/xpram.c          |  4 +--
 include/linux/blkdev.h              |  4 +--
 26 files changed, 54 insertions(+), 108 deletions(-)

diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index 40712e49381b..c3a630440512 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -118,12 +118,11 @@ static int __init nfhd_init_one(int id, u32 blocks, u32 bsize)
 	dev->bsize = bsize;
 	dev->bshift = ffs(bsize) - 10;
 
-	dev->queue = blk_alloc_queue(GFP_KERNEL);
+	dev->queue = blk_alloc_queue(nfhd_make_request, NUMA_NO_NODE);
 	if (dev->queue == NULL)
 		goto free_dev;
 
 	dev->queue->queuedata = dev;
-	blk_queue_make_request(dev->queue, nfhd_make_request);
 	blk_queue_logical_block_size(dev->queue, bsize);
 
 	dev->disk = alloc_disk(16);
diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 833109880165..49322b66cda9 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -267,13 +267,12 @@ static int __init simdisk_setup(struct simdisk *dev, int which,
 	spin_lock_init(&dev->lock);
 	dev->users = 0;
 
-	dev->queue = blk_alloc_queue(GFP_KERNEL);
+	dev->queue = blk_alloc_queue(simdisk_make_request, NUMA_NO_NODE);
 	if (dev->queue == NULL) {
 		pr_err("blk_alloc_queue failed\n");
 		goto out_alloc_queue;
 	}
 
-	blk_queue_make_request(dev->queue, simdisk_make_request);
 	dev->queue->queuedata = dev;
 
 	dev->gd = alloc_disk(SIMDISK_MINORS);
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index a229b94d5390..c15a26096038 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1010,7 +1010,7 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
  * blkcg_init_queue - initialize blkcg part of request queue
  * @q: request_queue to initialize
  *
- * Called from blk_alloc_queue_node(). Responsible for initializing blkcg
+ * Called from __blk_alloc_queue(). Responsible for initializing blkcg
  * part of new request_queue @q.
  *
  * RETURNS:
diff --git a/block/blk-core.c b/block/blk-core.c
index eaf6cb3887e6..18b8c09d093e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -388,12 +388,6 @@ void blk_cleanup_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_cleanup_queue);
 
-struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
-{
-	return blk_alloc_queue_node(gfp_mask, NUMA_NO_NODE);
-}
-EXPORT_SYMBOL(blk_alloc_queue);
-
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
@@ -470,24 +464,19 @@ static void blk_timeout_work(struct work_struct *work)
 {
 }
 
-/**
- * blk_alloc_queue_node - allocate a request queue
- * @gfp_mask: memory allocation flags
- * @node_id: NUMA node to allocate memory from
- */
-struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
+struct request_queue *__blk_alloc_queue(int node_id)
 {
 	struct request_queue *q;
 	int ret;
 
 	q = kmem_cache_alloc_node(blk_requestq_cachep,
-				gfp_mask | __GFP_ZERO, node_id);
+				GFP_KERNEL | __GFP_ZERO, node_id);
 	if (!q)
 		return NULL;
 
 	q->last_merge = NULL;
 
-	q->id = ida_simple_get(&blk_queue_ida, 0, 0, gfp_mask);
+	q->id = ida_simple_get(&blk_queue_ida, 0, 0, GFP_KERNEL);
 	if (q->id < 0)
 		goto fail_q;
 
@@ -495,7 +484,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	if (ret)
 		goto fail_id;
 
-	q->backing_dev_info = bdi_alloc_node(gfp_mask, node_id);
+	q->backing_dev_info = bdi_alloc_node(GFP_KERNEL, node_id);
 	if (!q->backing_dev_info)
 		goto fail_split;
 
@@ -541,6 +530,9 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	if (blkcg_init_queue(q))
 		goto fail_ref;
 
+	blk_queue_dma_alignment(q, 511);
+	blk_set_default_limits(&q->limits);
+
 	return q;
 
 fail_ref:
@@ -557,7 +549,22 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	kmem_cache_free(blk_requestq_cachep, q);
 	return NULL;
 }
-EXPORT_SYMBOL(blk_alloc_queue_node);
+
+struct request_queue *blk_alloc_queue(make_request_fn make_request, int node_id)
+{
+	struct request_queue *q;
+
+	if (WARN_ON_ONCE(!make_request))
+		return -EINVAL;
+
+	q = __blk_alloc_queue(node_id);
+	if (!q)
+		return NULL;
+	q->make_request_fn = make_request;
+	q->nr_requests = BLKDEV_MAX_RQ;
+	return q;
+}
+EXPORT_SYMBOL(blk_alloc_queue);
 
 bool blk_get_queue(struct request_queue *q)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 216bf62e88b6..f6291ceedee4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2729,7 +2729,7 @@ struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
 {
 	struct request_queue *uninit_q, *q;
 
-	uninit_q = blk_alloc_queue_node(GFP_KERNEL, set->numa_node);
+	uninit_q = __blk_alloc_queue(set->numa_node);
 	if (!uninit_q)
 		return ERR_PTR(-ENOMEM);
 	uninit_q->queuedata = queuedata;
@@ -2939,11 +2939,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	INIT_LIST_HEAD(&q->requeue_list);
 	spin_lock_init(&q->requeue_lock);
 
-	blk_queue_make_request(q, blk_mq_make_request);
-
-	/*
-	 * Do this after blk_queue_make_request() overrides it...
-	 */
+	q->make_request_fn = blk_mq_make_request;
 	q->nr_requests = set->queue_depth;
 
 	/*
diff --git a/block/blk-settings.c b/block/blk-settings.c
index c8eda2e7b91e..126d216a2db6 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -86,42 +86,6 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
-/**
- * blk_queue_make_request - define an alternate make_request function for a device
- * @q:  the request queue for the device to be affected
- * @mfn: the alternate make_request function
- *
- * Description:
- *    The normal way for &struct bios to be passed to a device
- *    driver is for them to be collected into requests on a request
- *    queue, and then to allow the device driver to select requests
- *    off that queue when it is ready.  This works well for many block
- *    devices. However some block devices (typically virtual devices
- *    such as md or lvm) do not benefit from the processing on the
- *    request queue, and are served best by having the requests passed
- *    directly to them.  This can be achieved by providing a function
- *    to blk_queue_make_request().
- *
- * Caveat:
- *    The driver that does this *must* be able to deal appropriately
- *    with buffers in "highmemory". This can be accomplished by either calling
- *    kmap_atomic() to get a temporary kernel mapping, or by calling
- *    blk_queue_bounce() to create a buffer in normal memory.
- **/
-void blk_queue_make_request(struct request_queue *q, make_request_fn *mfn)
-{
-	/*
-	 * set defaults
-	 */
-	q->nr_requests = BLKDEV_MAX_RQ;
-
-	q->make_request_fn = mfn;
-	blk_queue_dma_alignment(q, 511);
-
-	blk_set_default_limits(&q->limits);
-}
-EXPORT_SYMBOL(blk_queue_make_request);
-
 /**
  * blk_queue_bounce_limit - set bounce buffer limit for queue
  * @q: the request queue for the device
diff --git a/block/blk.h b/block/blk.h
index d9673164a145..491e52fc0aa6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -482,4 +482,6 @@ static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 #endif
 }
 
+struct request_queue *__blk_alloc_queue(int node_id);
+
 #endif /* BLK_INTERNAL_H */
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 220c5e18aba0..2fb25c348d53 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -381,12 +381,10 @@ static struct brd_device *brd_alloc(int i)
 	spin_lock_init(&brd->brd_lock);
 	INIT_RADIX_TREE(&brd->brd_pages, GFP_ATOMIC);
 
-	brd->brd_queue = blk_alloc_queue(GFP_KERNEL);
+	brd->brd_queue = blk_alloc_queue(brd_make_request, NUMA_NO_NODE);
 	if (!brd->brd_queue)
 		goto out_free_dev;
 
-	blk_queue_make_request(brd->brd_queue, brd_make_request);
-
 	/* This is so fdisk will align partitions on 4k, because of
 	 * direct_access API needing 4k alignment, returning a PFN
 	 * (This is only a problem on very small devices <= 4M,
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a18155cdce41..72a7c3ea2ce3 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2801,7 +2801,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 	drbd_init_set_defaults(device);
 
-	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
+	q = blk_alloc_queue(drbd_make_request, NUMA_NO_NODE);
 	if (!q)
 		goto out_no_q;
 	device->rq_queue = q;
@@ -2828,7 +2828,6 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	q->backing_dev_info->congested_fn = drbd_congested;
 	q->backing_dev_info->congested_data = device;
 
-	blk_queue_make_request(q, drbd_make_request);
 	blk_queue_write_cache(q, true, true);
 	/* Setting the max_hw_sectors to an odd value of 8kibyte here
 	   This triggers a max_bio_size message upon first attach or connect */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 2f864782550d..5f13793d35ee 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1743,12 +1743,11 @@ static int null_add_dev(struct nullb_device *dev)
 			goto out_cleanup_tags;
 		}
 	} else if (dev->queue_mode == NULL_Q_BIO) {
-		nullb->q = blk_alloc_queue_node(GFP_KERNEL, dev->home_node);
+		nullb->q = blk_alloc_queue(null_queue_bio, dev->home_node);
 		if (!nullb->q) {
 			rv = -ENOMEM;
 			goto out_cleanup_queues;
 		}
-		blk_queue_make_request(nullb->q, null_queue_bio);
 		rv = init_driver_queues(nullb);
 		if (rv)
 			goto out_cleanup_blk_queue;
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 5f970a7d32c0..6af3b2e29c62 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2493,7 +2493,6 @@ static void pkt_init_queue(struct pktcdvd_device *pd)
 {
 	struct request_queue *q = pd->disk->queue;
 
-	blk_queue_make_request(q, pkt_make_request);
 	blk_queue_logical_block_size(q, CD_FRAMESIZE);
 	blk_queue_max_hw_sectors(q, PACKET_MAX_SECTORS);
 	q->queuedata = pd;
@@ -2750,7 +2749,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	strcpy(disk->disk_name, pd->name);
 	disk->devnode = pktcdvd_devnode;
 	disk->private_data = pd;
-	disk->queue = blk_alloc_queue(GFP_KERNEL);
+	disk->queue = blk_alloc_queue(pkt_make_request, NUMA_NO_NODE);
 	if (!disk->queue)
 		goto out_mem2;
 
diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 4628e1a27a2b..821d4d8b1d76 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -737,7 +737,7 @@ static int ps3vram_probe(struct ps3_system_bus_device *dev)
 
 	ps3vram_proc_init(dev);
 
-	queue = blk_alloc_queue(GFP_KERNEL);
+	queue = blk_alloc_queue(ps3vram_make_request, NUMA_NO_NODE);
 	if (!queue) {
 		dev_err(&dev->core, "blk_alloc_queue failed\n");
 		error = -ENOMEM;
@@ -746,7 +746,6 @@ static int ps3vram_probe(struct ps3_system_bus_device *dev)
 
 	priv->queue = queue;
 	queue->queuedata = dev;
-	blk_queue_make_request(queue, ps3vram_make_request);
 	blk_queue_max_segments(queue, BLK_MAX_SEGMENTS);
 	blk_queue_max_segment_size(queue, BLK_MAX_SEGMENT_SIZE);
 	blk_queue_max_hw_sectors(queue, BLK_SAFE_MAX_SECTORS);
diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index c47d28b2ce44..8ffa8260dcaf 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -248,7 +248,7 @@ int rsxx_setup_dev(struct rsxx_cardinfo *card)
 		return -ENOMEM;
 	}
 
-	card->queue = blk_alloc_queue(GFP_KERNEL);
+	card->queue = blk_alloc_queue(rsxx_make_request, NUMA_NO_NODE);
 	if (!card->queue) {
 		dev_err(CARD_TO_DEV(card), "Failed queue alloc\n");
 		unregister_blkdev(card->major, DRIVER_NAME);
@@ -269,7 +269,6 @@ int rsxx_setup_dev(struct rsxx_cardinfo *card)
 		blk_queue_logical_block_size(card->queue, blk_size);
 	}
 
-	blk_queue_make_request(card->queue, rsxx_make_request);
 	blk_queue_max_hw_sectors(card->queue, blkdev_max_hw_sectors);
 	blk_queue_physical_block_size(card->queue, RSXX_HW_BLK_SIZE);
 
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 4eaf97d7a170..d84e8a878df2 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -885,11 +885,9 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	card->biotail = &card->bio;
 	spin_lock_init(&card->lock);
 
-	card->queue = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
+	card->queue = blk_alloc_queue(mm_make_request, NUMA_NO_NODE);
 	if (!card->queue)
 		goto failed_alloc;
-
-	blk_queue_make_request(card->queue, mm_make_request);
 	card->queue->queuedata = card;
 
 	tasklet_init(&card->tasklet, process_page, (unsigned long)card);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 76e75097e9ab..ebb234f36909 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1895,7 +1895,7 @@ static int zram_add(void)
 #ifdef CONFIG_ZRAM_WRITEBACK
 	spin_lock_init(&zram->wb_limit_lock);
 #endif
-	queue = blk_alloc_queue(GFP_KERNEL);
+	queue = blk_alloc_queue(zram_make_request, NUMA_NO_NODE);
 	if (!queue) {
 		pr_err("Error allocating disk queue for device %d\n",
 			device_id);
@@ -1903,8 +1903,6 @@ static int zram_add(void)
 		goto out_free_idr;
 	}
 
-	blk_queue_make_request(queue, zram_make_request);
-
 	/* gendisk structure */
 	zram->disk = alloc_disk(1);
 	if (!zram->disk) {
diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 7543e395a2c6..db38a68abb6c 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -380,12 +380,11 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 		goto err_dev;
 	}
 
-	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
+	tqueue = blk_alloc_queue(tt->make_rq, dev->q->node);
 	if (!tqueue) {
 		ret = -ENOMEM;
 		goto err_disk;
 	}
-	blk_queue_make_request(tqueue, tt->make_rq);
 
 	strlcpy(tdisk->disk_name, create->tgtname, sizeof(tdisk->disk_name));
 	tdisk->flags = GENHD_FL_EXT_DEVT;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 5e38a167c85e..d98354fa28e3 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -866,11 +866,10 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 	d->disk->fops		= &bcache_ops;
 	d->disk->private_data	= d;
 
-	q = blk_alloc_queue(GFP_KERNEL);
+	q = blk_alloc_queue(make_request_fn, NUMA_NO_NODE);
 	if (!q)
 		return -ENOMEM;
 
-	blk_queue_make_request(q, make_request_fn);
 	d->disk->queue			= q;
 	q->queuedata			= d;
 	q->backing_dev_info->congested_data = d;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 0d881cfa160b..753302e83910 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1939,16 +1939,15 @@ static struct mapped_device *alloc_dev(int minor)
 	INIT_LIST_HEAD(&md->table_devices);
 	spin_lock_init(&md->uevent_lock);
 
-	md->queue = blk_alloc_queue_node(GFP_KERNEL, numa_node_id);
-	if (!md->queue)
-		goto bad;
-	md->queue->queuedata = md;
 	/*
 	 * default to bio-based required ->make_request_fn until DM
 	 * table is loaded and md->type established. If request-based
 	 * table is loaded: blk-mq will override accordingly.
 	 */
-	blk_queue_make_request(md->queue, dm_make_request);
+	md->queue = blk_alloc_queue(dm_make_request, numa_node_id);
+	if (!md->queue)
+		goto bad;
+	md->queue->queuedata = md;
 
 	md->disk = alloc_disk_node(1, md->numa_node_id);
 	if (!md->disk)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index f6cf3b53f6c1..cd1210a0d957 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5623,12 +5623,11 @@ static int md_alloc(dev_t dev, char *name)
 		mddev->hold_active = UNTIL_STOP;
 
 	error = -ENOMEM;
-	mddev->queue = blk_alloc_queue(GFP_KERNEL);
+	mddev->queue = blk_alloc_queue(md_make_request, NUMA_NO_NODE);
 	if (!mddev->queue)
 		goto abort;
 	mddev->queue->queuedata = mddev;
 
-	blk_queue_make_request(mddev->queue, md_make_request);
 	blk_set_stacking_limits(&mddev->queue->limits);
 
 	disk = alloc_disk(1 << shift);
diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 677d6f45b5c4..43751fab9d36 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -249,13 +249,12 @@ static int nsblk_attach_disk(struct nd_namespace_blk *nsblk)
 	internal_nlba = div_u64(nsblk->size, nsblk_internal_lbasize(nsblk));
 	available_disk_size = internal_nlba * nsblk_sector_size(nsblk);
 
-	q = blk_alloc_queue(GFP_KERNEL);
+	q = blk_alloc_queue(nd_blk_make_request, NUMA_NO_NODE);
 	if (!q)
 		return -ENOMEM;
 	if (devm_add_action_or_reset(dev, nd_blk_release_queue, q))
 		return -ENOMEM;
 
-	blk_queue_make_request(q, nd_blk_make_request);
 	blk_queue_max_hw_sectors(q, UINT_MAX);
 	blk_queue_logical_block_size(q, nsblk_sector_size(nsblk));
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 0d04ea3d9fd7..3b09419218d6 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1521,7 +1521,7 @@ static int btt_blk_init(struct btt *btt)
 	struct nd_namespace_common *ndns = nd_btt->ndns;
 
 	/* create a new disk and request queue for btt */
-	btt->btt_queue = blk_alloc_queue(GFP_KERNEL);
+	btt->btt_queue = blk_alloc_queue(btt_make_request, NUMA_NO_NODE);
 	if (!btt->btt_queue)
 		return -ENOMEM;
 
@@ -1540,7 +1540,6 @@ static int btt_blk_init(struct btt *btt)
 	btt->btt_disk->queue->backing_dev_info->capabilities |=
 			BDI_CAP_SYNCHRONOUS_IO;
 
-	blk_queue_make_request(btt->btt_queue, btt_make_request);
 	blk_queue_logical_block_size(btt->btt_queue, btt->sector_size);
 	blk_queue_max_hw_sectors(btt->btt_queue, UINT_MAX);
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, btt->btt_queue);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4eae441f86c9..4ffc6f7ca131 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -395,7 +395,7 @@ static int pmem_attach_disk(struct device *dev,
 		return -EBUSY;
 	}
 
-	q = blk_alloc_queue_node(GFP_KERNEL, dev_to_node(dev));
+	q = blk_alloc_queue(pmem_make_request, dev_to_node(dev));
 	if (!q)
 		return -ENOMEM;
 
@@ -433,7 +433,6 @@ static int pmem_attach_disk(struct device *dev,
 	pmem->virt_addr = addr;
 
 	blk_queue_write_cache(q, true, fua);
-	blk_queue_make_request(q, pmem_make_request);
 	blk_queue_physical_block_size(q, PAGE_SIZE);
 	blk_queue_logical_block_size(q, pmem_sector_size(ndns));
 	blk_queue_max_hw_sectors(q, UINT_MAX);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a11900cf3a36..a38d7f196aba 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -377,11 +377,10 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	if (!(ctrl->subsys->cmic & (1 << 1)) || !multipath)
 		return 0;
 
-	q = blk_alloc_queue_node(GFP_KERNEL, ctrl->numa_node);
+	q = blk_alloc_queue(nvme_ns_head_make_request, ctrl->numa_node);
 	if (!q)
 		goto out;
 	q->queuedata = head;
-	blk_queue_make_request(q, nvme_ns_head_make_request);
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 	/* set to a default value for 512 until disk is validated */
 	blk_queue_logical_block_size(q, 512);
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 63502ca537eb..80d22290f268 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -636,10 +636,10 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 	}
 	dev_info->gd->major = dcssblk_major;
 	dev_info->gd->fops = &dcssblk_devops;
-	dev_info->dcssblk_queue = blk_alloc_queue(GFP_KERNEL);
+	dev_info->dcssblk_queue =
+		blk_alloc_queue(dcssblk_make_request, NUMA_NO_NODE);
 	dev_info->gd->queue = dev_info->dcssblk_queue;
 	dev_info->gd->private_data = dev_info;
-	blk_queue_make_request(dev_info->dcssblk_queue, dcssblk_make_request);
 	blk_queue_logical_block_size(dev_info->dcssblk_queue, 4096);
 	blk_queue_flag_set(QUEUE_FLAG_DAX, dev_info->dcssblk_queue);
 
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index 3df5d68d09f0..45a04daec89e 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -343,14 +343,14 @@ static int __init xpram_setup_blkdev(void)
 		xpram_disks[i] = alloc_disk(1);
 		if (!xpram_disks[i])
 			goto out;
-		xpram_queues[i] = blk_alloc_queue(GFP_KERNEL);
+		xpram_queues[i] = blk_alloc_queue(xpram_make_request,
+				NUMA_NO_NODE);
 		if (!xpram_queues[i]) {
 			put_disk(xpram_disks[i]);
 			goto out;
 		}
 		blk_queue_flag_set(QUEUE_FLAG_NONROT, xpram_queues[i]);
 		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, xpram_queues[i]);
-		blk_queue_make_request(xpram_queues[i], xpram_make_request);
 		blk_queue_logical_block_size(xpram_queues[i], 4096);
 	}
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 53a1325efbc3..fdb517c33603 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1063,7 +1063,6 @@ extern void blk_abort_request(struct request *);
  * Access functions for manipulating queue properties
  */
 extern void blk_cleanup_queue(struct request_queue *);
-extern void blk_queue_make_request(struct request_queue *, make_request_fn *);
 extern void blk_queue_bounce_limit(struct request_queue *, u64);
 extern void blk_queue_max_hw_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
@@ -1140,8 +1139,7 @@ extern void blk_dump_rq_flags(struct request *, char *);
 extern long nr_blockdev_pages(void);
 
 bool __must_check blk_get_queue(struct request_queue *);
-struct request_queue *blk_alloc_queue(gfp_t);
-struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id);
+struct request_queue *blk_alloc_queue(make_request_fn make_request, int node_id);
 extern void blk_put_queue(struct request_queue *);
 extern void blk_set_queue_dying(struct request_queue *);
 
-- 
2.25.1

