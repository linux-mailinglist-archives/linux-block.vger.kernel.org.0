Return-Path: <linux-block+bounces-23209-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04F9AE819B
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 13:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC6B3B4540
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 11:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B855F50F;
	Wed, 25 Jun 2025 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ps81Njvt"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70125C717
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851355; cv=none; b=tEAufElIzm9mrVFoPidGxhZISaQtYVz9fgs6V5k92peYqAjKj5/2u096KmO/tDI+oiCNAH+9XyzWQ6RuOVLmeURONXJNqBAg596y3pZ4XrmBwYlIs5v/e1JCMGVAQc/ZYYtR9QfdpV6htjxSO98i/wAYlw1QDLXcZajlMHYOozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851355; c=relaxed/simple;
	bh=IQxByG+eo8fvqSf1MhCz4uXEr2V2BSdfS68wWPoGQG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrTIpwHoijn7tqI+xT/SMnAu9IgdXLPZl2Qu75QkduxszQlg1AQ09L5L/1eoVdo6VKNue6s+WR5ZSD3kqZ067wTuCJecXHs1ySFZeaC0RQEy2PRUhSGjd04rkcxpyhv7FWszufFu34ACi2wyMMKKhEmDbnW6UOW824CAhR+1NGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ps81Njvt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Dk5PB1CTg3qObvq4C0OgODvQXZedYjTVRSwI7ZhdCuw=; b=ps81NjvtKqBgHameufOroU0WNZ
	/mN3HjX9Lii29W7kau/ozUv4wFuzmdpWE3VwbAnpiBymIxyIKiYX4v81+gSun+oA4+SL+N8xYi/SU
	nwaJCY9x7NEnkgD11LsCYnrWwxYZFNKJX/K/e2PQbqc3mdq2BtLNNIZSbltxjrLiuykhf1g0R593A
	hPlw4WSSu8YVk6OFabUOCVjpOrT5UENvLCD8rgUpojNkeX2wgbi4Lvt7Vi4UH9SxJ1WxnxP8TvzpG
	r3STr6FjAvn8Aq6TYOyk0Q/6H7zWzKrdlBOMXYYWOhqWDeO157+LLnXdOw7mSNnFGqVRWwF9+kQBw
	a3jISm7w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOPt-00000008V18-3BO7;
	Wed, 25 Jun 2025 11:35:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH 6/8] nvme-pci: convert the data mapping to blk_rq_dma_map
Date: Wed, 25 Jun 2025 13:35:03 +0200
Message-ID: <20250625113531.522027-7-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250625113531.522027-1-hch@lst.de>
References: <20250625113531.522027-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use the blk_rq_dma_map API to DMA map requests instead of scatterlists.
This removes the need to allocate a scatterlist covering every segment,
and thus the overall transfer length limit based on the scatterlist
allocation.

Instead the DMA mapping is done by iterating the bio_vec chain in the
request directly.  The unmap is handled differently depending on how
we mapped:

 - when using an IOMMU only a single IOVA is used, and it is stored in
   iova_state
 - for direct mappings that don't use swiotlb and are cache coherent,
   unmap is not needed at all
 - for direct mappings that are not cache coherent or use swiotlb, the
   physical addresses are rebuild from the PRPs or SGL segments

The latter unfortunately adds a fair amount of code to the driver, but
it is code not used in the fast path.

The conversion only covers the data mapping path, and still uses a
scatterlist for the multi-segment metadata case.  I plan to convert that
as soon as we have good test coverage for the multi-segment metadata
path.

Thanks to Chaitanya Kulkarni for an initial attempt at a new DMA API
conversion for nvme-pci, Kanchan Joshi for bringing back the single
segment optimization, Leon Romanovsky for shepherding this through a
gazillion rebases and Nitesh Shetty for various improvements.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/nvme/host/pci.c | 387 +++++++++++++++++++++++++---------------
 1 file changed, 241 insertions(+), 146 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6a2e708f13b..e8688840818a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -7,7 +7,7 @@
 #include <linux/acpi.h>
 #include <linux/async.h>
 #include <linux/blkdev.h>
-#include <linux/blk-mq.h>
+#include <linux/blk-mq-dma.h>
 #include <linux/blk-integrity.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
@@ -27,7 +27,6 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/sed-opal.h>
-#include <linux/pci-p2pdma.h>
 
 #include "trace.h"
 #include "nvme.h"
@@ -46,13 +45,11 @@
 #define NVME_MAX_NR_DESCRIPTORS	5
 
 /*
- * For data SGLs we support a single descriptors worth of SGL entries, but for
- * now we also limit it to avoid an allocation larger than PAGE_SIZE for the
- * scatterlist.
+ * For data SGLs we support a single descriptors worth of SGL entries.
+ * For PRPs, segments don't matter at all.
  */
 #define NVME_MAX_SEGS \
-	min(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc), \
-	    (PAGE_SIZE / sizeof(struct scatterlist)))
+	(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc))
 
 /*
  * For metadata SGLs, only the small descriptor is supported, and the first
@@ -162,7 +159,6 @@ struct nvme_dev {
 	bool hmb;
 	struct sg_table *hmb_sgt;
 
-	mempool_t *iod_mempool;
 	mempool_t *iod_meta_mempool;
 
 	/* shadow doorbell buffer support: */
@@ -246,7 +242,10 @@ enum nvme_iod_flags {
 	IOD_ABORTED		= 1U << 0,
 
 	/* uses the small descriptor pool */
-	IOD_SMALL_DESCRIPTOR		= 1U << 1,
+	IOD_SMALL_DESCRIPTOR	= 1U << 1,
+
+	/* single segment dma mapping */
+	IOD_SINGLE_SEGMENT	= 1U << 2,
 };
 
 /*
@@ -257,13 +256,14 @@ struct nvme_iod {
 	struct nvme_command cmd;
 	u8 flags;
 	u8 nr_descriptors;
-	unsigned int dma_len;	/* length of single DMA segment mapping */
-	dma_addr_t first_dma;
+
+	unsigned int total_len;
+	struct dma_iova_state dma_state;
+	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
+
 	dma_addr_t meta_dma;
-	struct sg_table sgt;
 	struct sg_table meta_sgt;
 	struct nvme_sgl_desc *meta_descriptor;
-	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
 };
 
 static inline unsigned int nvme_dbbuf_size(struct nvme_dev *dev)
@@ -614,8 +614,13 @@ static inline enum nvme_use_sgl nvme_pci_use_sgls(struct nvme_dev *dev,
 static unsigned int nvme_pci_avg_seg_size(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	unsigned int nseg;
 
-	return DIV_ROUND_UP(blk_rq_payload_bytes(req), iod->sgt.nents);
+	if (blk_rq_dma_map_coalesce(&iod->dma_state))
+		nseg = 1;
+	else
+		nseg = blk_rq_nr_phys_segments(req);
+	return DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
 }
 
 static inline struct dma_pool *nvme_dma_pool(struct nvme_queue *nvmeq,
@@ -626,12 +631,25 @@ static inline struct dma_pool *nvme_dma_pool(struct nvme_queue *nvmeq,
 	return nvmeq->descriptor_pools.large;
 }
 
+static inline bool nvme_pci_cmd_use_sgl(struct nvme_command *cmd)
+{
+	return cmd->common.flags &
+		(NVME_CMD_SGL_METABUF | NVME_CMD_SGL_METASEG);
+}
+
+static inline dma_addr_t nvme_pci_first_desc_dma_addr(struct nvme_command *cmd)
+{
+	if (nvme_pci_cmd_use_sgl(cmd))
+		return le64_to_cpu(cmd->common.dptr.sgl.addr);
+	return le64_to_cpu(cmd->common.dptr.prp2);
+}
+
 static void nvme_free_descriptors(struct request *req)
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	dma_addr_t dma_addr = iod->first_dma;
+	dma_addr_t dma_addr = nvme_pci_first_desc_dma_addr(&iod->cmd);
 	int i;
 
 	if (iod->nr_descriptors == 1) {
@@ -650,68 +668,138 @@ static void nvme_free_descriptors(struct request *req)
 	}
 }
 
-static void nvme_unmap_data(struct request *req)
+static void nvme_free_prps(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	struct device *dma_dev = nvmeq->dev->dev;
+	enum dma_data_direction dir = rq_dma_dir(req);
+	int length = iod->total_len;
+	dma_addr_t dma_addr;
+	int i, desc;
+	__le64 *prp_list;
+	u32 dma_len;
+
+	dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp1);
+	dma_len = min_t(u32, length,
+		NVME_CTRL_PAGE_SIZE - (dma_addr & (NVME_CTRL_PAGE_SIZE - 1)));
+	length -= dma_len;
+	if (!length) {
+		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
+		return;
+	}
 
-	if (iod->dma_len) {
-		dma_unmap_page(nvmeq->dev->dev, iod->first_dma, iod->dma_len,
-			       rq_dma_dir(req));
+	if (length <= NVME_CTRL_PAGE_SIZE) {
+		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
+		dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp2);
+		dma_unmap_page(dma_dev, dma_addr, length, dir);
 		return;
 	}
 
-	WARN_ON_ONCE(!iod->sgt.nents);
+	i = 0;
+	desc = 0;
+	prp_list = iod->descriptors[desc];
+	do {
+		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
+		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
+			prp_list = iod->descriptors[++desc];
+			i = 0;
+		}
 
-	dma_unmap_sgtable(nvmeq->dev->dev, &iod->sgt, rq_dma_dir(req), 0);
-	nvme_free_descriptors(req);
-	mempool_free(iod->sgt.sgl, nvmeq->dev->iod_mempool);
+		dma_addr = le64_to_cpu(prp_list[i++]);
+		dma_len = min(length, NVME_CTRL_PAGE_SIZE);
+		length -= dma_len;
+	} while (length);
 }
 
-static void nvme_print_sgl(struct scatterlist *sgl, int nents)
+static void nvme_free_sgls(struct request *req)
 {
-	int i;
-	struct scatterlist *sg;
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	struct device *dma_dev = nvmeq->dev->dev;
+	dma_addr_t sqe_dma_addr = le64_to_cpu(iod->cmd.common.dptr.sgl.addr);
+	unsigned int sqe_dma_len = le32_to_cpu(iod->cmd.common.dptr.sgl.length);
+	struct nvme_sgl_desc *sg_list = iod->descriptors[0];
+	enum dma_data_direction dir = rq_dma_dir(req);
+
+	if (iod->nr_descriptors) {
+		unsigned int nr_entries = sqe_dma_len / sizeof(*sg_list), i;
+
+		for (i = 0; i < nr_entries; i++)
+			dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
+				le32_to_cpu(sg_list[i].length), dir);
+	} else {
+		dma_unmap_page(dma_dev, sqe_dma_addr, sqe_dma_len, dir);
+	}
+}
+
+static void nvme_unmap_data(struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	struct device *dma_dev = nvmeq->dev->dev;
+
+	if (iod->flags & IOD_SINGLE_SEGMENT) {
+		static_assert(offsetof(union nvme_data_ptr, prp1) ==
+				offsetof(union nvme_data_ptr, sgl.addr));
+		dma_unmap_page(dma_dev, le64_to_cpu(iod->cmd.common.dptr.prp1),
+				iod->total_len, rq_dma_dir(req));
+		return;
+	}
 
-	for_each_sg(sgl, sg, nents, i) {
-		dma_addr_t phys = sg_phys(sg);
-		pr_warn("sg[%d] phys_addr:%pad offset:%d length:%d "
-			"dma_address:%pad dma_length:%d\n",
-			i, &phys, sg->offset, sg->length, &sg_dma_address(sg),
-			sg_dma_len(sg));
+	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
+		if (nvme_pci_cmd_use_sgl(&iod->cmd))
+			nvme_free_sgls(req);
+		else
+			nvme_free_prps(req);
 	}
+
+	if (iod->nr_descriptors)
+		nvme_free_descriptors(req);
 }
 
-static blk_status_t nvme_pci_setup_prps(struct request *req)
+static blk_status_t nvme_pci_setup_data_prp(struct request *req,
+		struct blk_dma_iter *iter)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
-	int length = blk_rq_payload_bytes(req);
-	struct scatterlist *sg = iod->sgt.sgl;
-	int dma_len = sg_dma_len(sg);
-	u64 dma_addr = sg_dma_address(sg);
-	int offset = dma_addr & (NVME_CTRL_PAGE_SIZE - 1);
+	unsigned int length = blk_rq_payload_bytes(req);
+	dma_addr_t prp1_dma, prp2_dma = 0;
+	unsigned int prp_len, i;
 	__le64 *prp_list;
-	dma_addr_t prp_dma;
-	int i;
 
-	length -= (NVME_CTRL_PAGE_SIZE - offset);
-	if (length <= 0) {
-		iod->first_dma = 0;
+	/*
+	 * PRP1 always points to the start of the DMA transfers.
+	 *
+	 * This is the only PRP (except for the list entries) that could be
+	 * non-aligned.
+	 */
+	prp1_dma = iter->addr;
+	prp_len = min(length, NVME_CTRL_PAGE_SIZE -
+			(iter->addr & (NVME_CTRL_PAGE_SIZE - 1)));
+	iod->total_len += prp_len;
+	iter->addr += prp_len;
+	iter->len -= prp_len;
+	length -= prp_len;
+	if (!length)
 		goto done;
-	}
 
-	dma_len -= (NVME_CTRL_PAGE_SIZE - offset);
-	if (dma_len) {
-		dma_addr += (NVME_CTRL_PAGE_SIZE - offset);
-	} else {
-		sg = sg_next(sg);
-		dma_addr = sg_dma_address(sg);
-		dma_len = sg_dma_len(sg);
+	if (!iter->len) {
+		if (!blk_rq_dma_map_iter_next(req, nvmeq->dev->dev,
+				&iod->dma_state, iter)) {
+			if (WARN_ON_ONCE(!iter->status))
+				goto bad_sgl;
+			goto done;
+		}
 	}
 
+	/*
+	 * PRP2 is usually a list, but can point to data if all data to be
+	 * transferred fits into PRP1 + PRP2:
+	 */
 	if (length <= NVME_CTRL_PAGE_SIZE) {
-		iod->first_dma = dma_addr;
+		prp2_dma = iter->addr;
+		iod->total_len += length;
 		goto done;
 	}
 
@@ -720,58 +808,83 @@ static blk_status_t nvme_pci_setup_prps(struct request *req)
 		iod->flags |= IOD_SMALL_DESCRIPTOR;
 
 	prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
-			&prp_dma);
-	if (!prp_list)
-		return BLK_STS_RESOURCE;
+			&prp2_dma);
+	if (!prp_list) {
+		iter->status = BLK_STS_RESOURCE;
+		goto done;
+	}
 	iod->descriptors[iod->nr_descriptors++] = prp_list;
-	iod->first_dma = prp_dma;
+
 	i = 0;
 	for (;;) {
+		prp_list[i++] = cpu_to_le64(iter->addr);
+		prp_len = min(length, NVME_CTRL_PAGE_SIZE);
+		if (WARN_ON_ONCE(iter->len < prp_len))
+			goto bad_sgl;
+
+		iod->total_len += prp_len;
+		iter->addr += prp_len;
+		iter->len -= prp_len;
+		length -= prp_len;
+		if (!length)
+			break;
+
+		if (iter->len == 0) {
+			if (!blk_rq_dma_map_iter_next(req, nvmeq->dev->dev,
+					&iod->dma_state, iter)) {
+				if (WARN_ON_ONCE(!iter->status))
+					goto bad_sgl;
+				goto done;
+			}
+		}
+
+		/*
+		 * If we've filled the entire descriptor, allocate a new that is
+		 * pointed to be the last entry in the previous PRP list.  To
+		 * accommodate for that move the last actual entry to the new
+		 * descriptor.
+		 */
 		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
 			__le64 *old_prp_list = prp_list;
+			dma_addr_t prp_list_dma;
 
 			prp_list = dma_pool_alloc(nvmeq->descriptor_pools.large,
-					GFP_ATOMIC, &prp_dma);
-			if (!prp_list)
-				goto free_prps;
+					GFP_ATOMIC, &prp_list_dma);
+			if (!prp_list) {
+				iter->status = BLK_STS_RESOURCE;
+				goto done;
+			}
 			iod->descriptors[iod->nr_descriptors++] = prp_list;
+
 			prp_list[0] = old_prp_list[i - 1];
-			old_prp_list[i - 1] = cpu_to_le64(prp_dma);
+			old_prp_list[i - 1] = cpu_to_le64(prp_list_dma);
 			i = 1;
 		}
-		prp_list[i++] = cpu_to_le64(dma_addr);
-		dma_len -= NVME_CTRL_PAGE_SIZE;
-		dma_addr += NVME_CTRL_PAGE_SIZE;
-		length -= NVME_CTRL_PAGE_SIZE;
-		if (length <= 0)
-			break;
-		if (dma_len > 0)
-			continue;
-		if (unlikely(dma_len < 0))
-			goto bad_sgl;
-		sg = sg_next(sg);
-		dma_addr = sg_dma_address(sg);
-		dma_len = sg_dma_len(sg);
 	}
+
 done:
-	iod->cmd.common.dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sgt.sgl));
-	iod->cmd.common.dptr.prp2 = cpu_to_le64(iod->first_dma);
-	return BLK_STS_OK;
-free_prps:
-	nvme_free_descriptors(req);
-	return BLK_STS_RESOURCE;
+	/*
+	 * nvme_unmap_data uses the DPT field in the SQE to tear down the
+	 * mapping, so initialize it even for failures.
+	 */
+	iod->cmd.common.dptr.prp1 = cpu_to_le64(prp1_dma);
+	iod->cmd.common.dptr.prp2 = cpu_to_le64(prp2_dma);
+	if (unlikely(iter->status))
+		nvme_unmap_data(req);
+	return iter->status;
+
 bad_sgl:
-	WARN(DO_ONCE(nvme_print_sgl, iod->sgt.sgl, iod->sgt.nents),
-			"Invalid SGL for payload:%d nents:%d\n",
-			blk_rq_payload_bytes(req), iod->sgt.nents);
+	dev_err_once(nvmeq->dev->dev,
+		"Incorrectly formed request for payload:%d nents:%d\n",
+		blk_rq_payload_bytes(req), blk_rq_nr_phys_segments(req));
 	return BLK_STS_IOERR;
 }
 
 static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
-		struct scatterlist *sg)
+		struct blk_dma_iter *iter)
 {
-	sge->addr = cpu_to_le64(sg_dma_address(sg));
-	sge->length = cpu_to_le32(sg_dma_len(sg));
+	sge->addr = cpu_to_le64(iter->addr);
+	sge->length = cpu_to_le32(iter->len);
 	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
 }
 
@@ -783,21 +896,22 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
 	sge->type = NVME_SGL_FMT_LAST_SEG_DESC << 4;
 }
 
-static blk_status_t nvme_pci_setup_sgls(struct request *req)
+static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
+		struct blk_dma_iter *iter)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	unsigned int entries = blk_rq_nr_phys_segments(req);
 	struct nvme_sgl_desc *sg_list;
-	struct scatterlist *sg = iod->sgt.sgl;
-	unsigned int entries = iod->sgt.nents;
 	dma_addr_t sgl_dma;
-	int i = 0;
+	unsigned int mapped = 0;
 
-	/* setting the transfer type as SGL */
+	/* set the transfer type as SGL */
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
-	if (entries == 1) {
-		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, sg);
+	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
+		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, iter);
+		iod->total_len += iter->len;
 		return BLK_STS_OK;
 	}
 
@@ -809,15 +923,21 @@ static blk_status_t nvme_pci_setup_sgls(struct request *req)
 	if (!sg_list)
 		return BLK_STS_RESOURCE;
 	iod->descriptors[iod->nr_descriptors++] = sg_list;
-	iod->first_dma = sgl_dma;
 
-	nvme_pci_sgl_set_seg(&iod->cmd.common.dptr.sgl, sgl_dma, entries);
 	do {
-		nvme_pci_sgl_set_data(&sg_list[i++], sg);
-		sg = sg_next(sg);
-	} while (--entries > 0);
+		if (WARN_ON_ONCE(mapped == entries)) {
+			iter->status = BLK_STS_IOERR;
+			break;
+		}
+		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
+		iod->total_len += iter->len;
+	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, &iod->dma_state,
+				iter));
 
-	return BLK_STS_OK;
+	nvme_pci_sgl_set_seg(&iod->cmd.common.dptr.sgl, sgl_dma, mapped);
+	if (unlikely(iter->status))
+		nvme_free_sgls(req);
+	return iter->status;
 }
 
 static blk_status_t nvme_pci_setup_data_simple(struct request *req,
@@ -838,7 +958,8 @@ static blk_status_t nvme_pci_setup_data_simple(struct request *req,
 	dma_addr = dma_map_bvec(nvmeq->dev->dev, &bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(nvmeq->dev->dev, dma_addr))
 		return BLK_STS_RESOURCE;
-	iod->dma_len = bv.bv_len;
+	iod->total_len = bv.bv_len;
+	iod->flags |= IOD_SINGLE_SEGMENT;
 
 	if (use_sgl == SGL_FORCED || !prp_possible) {
 		iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
@@ -864,47 +985,35 @@ static blk_status_t nvme_map_data(struct request *req)
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct nvme_dev *dev = nvmeq->dev;
 	enum nvme_use_sgl use_sgl = nvme_pci_use_sgls(dev, req);
-	blk_status_t ret = BLK_STS_RESOURCE;
-	int rc;
+	struct blk_dma_iter iter;
+	blk_status_t ret;
 
+	/*
+	 * Try to skip the DMA iterator for single segment requests, as that
+	 * significantly improves performances for small I/O sizes.
+	 */
 	if (blk_rq_nr_phys_segments(req) == 1) {
 		ret = nvme_pci_setup_data_simple(req, use_sgl);
 		if (ret != BLK_STS_AGAIN)
 			return ret;
 	}
 
-	iod->dma_len = 0;
-	iod->sgt.sgl = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
-	if (!iod->sgt.sgl)
-		return BLK_STS_RESOURCE;
-	sg_init_table(iod->sgt.sgl, blk_rq_nr_phys_segments(req));
-	iod->sgt.orig_nents = blk_rq_map_sg(req, iod->sgt.sgl);
-	if (!iod->sgt.orig_nents)
-		goto out_free_sg;
-
-	rc = dma_map_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req),
-			     DMA_ATTR_NO_WARN);
-	if (rc) {
-		if (rc == -EREMOTEIO)
-			ret = BLK_STS_TARGET;
-		goto out_free_sg;
-	}
+	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
+		return iter.status;
 
 	if (use_sgl == SGL_FORCED ||
 	    (use_sgl == SGL_SUPPORTED &&
 	     (sgl_threshold && nvme_pci_avg_seg_size(req) >= sgl_threshold)))
-		ret = nvme_pci_setup_sgls(req);
-	else
-		ret = nvme_pci_setup_prps(req);
-	if (ret != BLK_STS_OK)
-		goto out_unmap_sg;
-	return BLK_STS_OK;
+		return nvme_pci_setup_data_sgl(req, &iter);
+	return nvme_pci_setup_data_prp(req, &iter);
+}
 
-out_unmap_sg:
-	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
-out_free_sg:
-	mempool_free(iod->sgt.sgl, dev->iod_mempool);
-	return ret;
+static void nvme_pci_sgl_set_data_sg(struct nvme_sgl_desc *sge,
+		struct scatterlist *sg)
+{
+	sge->addr = cpu_to_le64(sg_dma_address(sg));
+	sge->length = cpu_to_le32(sg_dma_len(sg));
+	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
 }
 
 static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
@@ -947,14 +1056,14 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
 
 	sgl = iod->meta_sgt.sgl;
 	if (entries == 1) {
-		nvme_pci_sgl_set_data(sg_list, sgl);
+		nvme_pci_sgl_set_data_sg(sg_list, sgl);
 		return BLK_STS_OK;
 	}
 
 	sgl_dma += sizeof(*sg_list);
 	nvme_pci_sgl_set_seg(sg_list, sgl_dma, entries);
 	for_each_sg(sgl, sg, entries, i)
-		nvme_pci_sgl_set_data(&sg_list[i + 1], sg);
+		nvme_pci_sgl_set_data_sg(&sg_list[i + 1], sg);
 
 	return BLK_STS_OK;
 
@@ -995,7 +1104,7 @@ static blk_status_t nvme_prep_rq(struct request *req)
 
 	iod->flags = 0;
 	iod->nr_descriptors = 0;
-	iod->sgt.nents = 0;
+	iod->total_len = 0;
 	iod->meta_sgt.nents = 0;
 
 	ret = nvme_setup_cmd(req->q->queuedata, req);
@@ -2913,26 +3022,14 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
 static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
 {
 	size_t meta_size = sizeof(struct scatterlist) * (NVME_MAX_META_SEGS + 1);
-	size_t alloc_size = sizeof(struct scatterlist) * NVME_MAX_SEGS;
-
-	dev->iod_mempool = mempool_create_node(1,
-			mempool_kmalloc, mempool_kfree,
-			(void *)alloc_size, GFP_KERNEL,
-			dev_to_node(dev->dev));
-	if (!dev->iod_mempool)
-		return -ENOMEM;
 
 	dev->iod_meta_mempool = mempool_create_node(1,
 			mempool_kmalloc, mempool_kfree,
 			(void *)meta_size, GFP_KERNEL,
 			dev_to_node(dev->dev));
 	if (!dev->iod_meta_mempool)
-		goto free;
-
+		return -ENOMEM;
 	return 0;
-free:
-	mempool_destroy(dev->iod_mempool);
-	return -ENOMEM;
 }
 
 static void nvme_free_tagset(struct nvme_dev *dev)
@@ -3376,7 +3473,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
 out_release_iod_mempool:
-	mempool_destroy(dev->iod_mempool);
 	mempool_destroy(dev->iod_meta_mempool);
 out_dev_unmap:
 	nvme_dev_unmap(dev);
@@ -3440,7 +3536,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
-	mempool_destroy(dev->iod_mempool);
 	mempool_destroy(dev->iod_meta_mempool);
 	nvme_release_descriptor_pools(dev);
 	nvme_dev_unmap(dev);
-- 
2.47.2


