Return-Path: <linux-block+bounces-22396-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B52DAD2D0A
	for <lists+linux-block@lfdr.de>; Tue, 10 Jun 2025 07:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29501188C6FF
	for <lists+linux-block@lfdr.de>; Tue, 10 Jun 2025 05:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B054C96;
	Tue, 10 Jun 2025 05:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JrEDk4hv"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300725E47E
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 05:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749532047; cv=none; b=mMd4H3GzAAcdXAEHNydE/yqD+asHrvN+0z3NdD+mY9/WSq01Oyo9CJo8OeOtlkLbeU6dpck8hlv617m6Cg/kgpPx19QHIEd9WBXENmqUBZDCdCfLkmGEWyoAuzXbumlOvBN+DGjSXg+7Ijpcp25fexrrAbGo/Smu6K+wMJJYvRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749532047; c=relaxed/simple;
	bh=ZGwXoeuRH2CrgZGdbO0h/e3H1/UrvfWkmBEjbyWv8x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rP9CkXnzg9ZrE6hMH/B+AWFQbywb8CcFGn18QtOAlw9j1QNcdECMxPtOkXAJa+GObZth46nt+k6VMRMouYYuQCeuYDGI0e5O5RJU/Ob7/wOnUMpsE/6AWpcmSE9igyQUQe7T1DhZWQ9PvfvD2B0w72ESjEzzajSCNelzHpk0DcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JrEDk4hv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/miW15uBJHD1ImB/4vbdqbDcNf/x1PHc4drmC+Ifb5o=; b=JrEDk4hvL7jGhU65SzJYHeC6+N
	WIr9FZqySdnC+KJsvUtWZmvO5lqJC1Ii4BlkEI80784HSALpuNMv2sh8GDwSnhg+0xQz5ksNv6M5o
	/jPWtz/WO9h0hpeGr8/DVVyU+qyLS8cz2jONfEdbRqdVJ30ddMjZoitQkPFXkLvvrtGNwYWELeR+B
	H5OLSvz5KeRPkDPKmAoaPj6JvQ+5eiUunGds6jtzxQGA7hPMtpvGOTZg9LYzUVLEfwgBvc1M6xNAy
	PyuFePK/Pk9+bbZPlzTidQHRnokCfAZQoP6G1BdEj9ZNna+tpPCpDHEGYzQFnty53VneaS5VphbnE
	bVpjHgIQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrCk-00000005ne3-1acV;
	Tue, 10 Jun 2025 05:07:22 +0000
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
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
Date: Tue, 10 Jun 2025 07:06:40 +0200
Message-ID: <20250610050713.2046316-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610050713.2046316-1-hch@lst.de>
References: <20250610050713.2046316-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a new blk_rq_dma_map / blk_rq_dma_unmap pair that does away with
the wasteful scatterlist structure.  Instead it uses the mapping iterator
to either add segments to the IOVA for IOMMU operations, or just maps
them one by one for the direct mapping.  For the IOMMU case instead of
a scatterlist with an entry for each segment, only a single [dma_addr,len]
pair needs to be stored for processing a request, and for the direct
mapping the per-segment allocation shrinks from
[page,offset,len,dma_addr,dma_len] to just [dma_addr,len].

One big difference to the scatterlist API, which could be considered
downside, is that the IOVA collapsing only works when the driver sets
a virt_boundary that matches the IOMMU granule.  For NVMe this is done
already so it works perfectly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-dma.c         | 162 +++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq-dma.h |  63 +++++++++++++++
 2 files changed, 225 insertions(+)
 create mode 100644 include/linux/blk-mq-dma.h

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 82bae475dfa4..37f8fba077e6 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2025 Christoph Hellwig
  */
+#include <linux/blk-mq-dma.h>
 #include "blk.h"
 
 struct phys_vec {
@@ -61,6 +62,167 @@ static bool blk_map_iter_next(struct request *req, struct req_iterator *iter,
 	return true;
 }
 
+/*
+ * The IOVA-based DMA API wants to be able to coalesce at the minimal IOMMU page
+ * size granularity (which is guaranteed to be <= PAGE_SIZE and usually 4k), so
+ * we need to ensure our segments are aligned to this as well.
+ *
+ * Note that there is no point in using the slightly more complicated IOVA based
+ * path for single segment mappings.
+ */
+static inline bool blk_can_dma_map_iova(struct request *req,
+		struct device *dma_dev)
+{
+	return !((queue_virt_boundary(req->q) + 1) &
+		dma_get_merge_boundary(dma_dev));
+}
+
+static bool blk_dma_map_bus(struct request *req, struct device *dma_dev,
+		struct blk_dma_iter *iter, struct phys_vec *vec)
+{
+	iter->addr = pci_p2pdma_bus_addr_map(&iter->p2pdma, vec->paddr);
+	iter->len = vec->len;
+	return true;
+}
+
+static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
+		struct blk_dma_iter *iter, struct phys_vec *vec)
+{
+	iter->addr = dma_map_page(dma_dev, phys_to_page(vec->paddr),
+			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
+	if (dma_mapping_error(dma_dev, iter->addr)) {
+		iter->status = BLK_STS_RESOURCE;
+		return false;
+	}
+	iter->len = vec->len;
+	return true;
+}
+
+static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
+		struct dma_iova_state *state, struct blk_dma_iter *iter,
+		struct phys_vec *vec)
+{
+	enum dma_data_direction dir = rq_dma_dir(req);
+	unsigned int mapped = 0;
+	int error = 0;
+
+	iter->addr = state->addr;
+	iter->len = dma_iova_size(state);
+
+	do {
+		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
+				vec->len, dir, 0);
+		if (error)
+			break;
+		mapped += vec->len;
+	} while (blk_map_iter_next(req, &iter->iter, vec));
+
+	error = dma_iova_sync(dma_dev, state, 0, mapped);
+	if (error) {
+		iter->status = errno_to_blk_status(error);
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * blk_rq_dma_map_iter_start - map the first DMA segment for a request
+ * @req:	request to map
+ * @dma_dev:	device to map to
+ * @state:	DMA IOVA state
+ * @iter:	block layer DMA iterator
+ *
+ * Start DMA mapping @req to @dma_dev.  @state and @iter are provided by the
+ * caller and don't need to be initialized.  @state needs to be stored for use
+ * at unmap time, @iter is only needed at map time.
+ *
+ * Returns %false if there is no segment to map, including due to an error, or
+ * %true ft it did map a segment.
+ *
+ * If a segment was mapped, the DMA address for it is returned in @iter.addr and
+ * the length in @iter.len.  If no segment was mapped the status code is
+ * returned in @iter.status.
+ *
+ * The caller can call blk_rq_dma_map_coalesce() to check if further segments
+ * need to be mapped after this, or go straight to blk_rq_dma_map_iter_next()
+ * to try to map the following segments.
+ */
+bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
+		struct dma_iova_state *state, struct blk_dma_iter *iter)
+{
+	unsigned int total_len = blk_rq_payload_bytes(req);
+	struct phys_vec vec;
+
+	iter->iter.bio = req->bio;
+	iter->iter.iter = req->bio->bi_iter;
+	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
+	iter->status = BLK_STS_OK;
+
+	/*
+	 * Grab the first segment ASAP because we'll need it to check for P2P
+	 * transfers.
+	 */
+	if (!blk_map_iter_next(req, &iter->iter, &vec))
+		return false;
+
+	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && (req->cmd_flags & REQ_P2PDMA)) {
+		switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
+					 phys_to_page(vec.paddr))) {
+		case PCI_P2PDMA_MAP_BUS_ADDR:
+			return blk_dma_map_bus(req, dma_dev, iter, &vec);
+		case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+			/*
+			 * P2P transfers through the host bridge are treated the
+			 * same as non-P2P transfers below and during unmap.
+			 */
+			req->cmd_flags &= ~REQ_P2PDMA;
+			break;
+		default:
+			iter->status = BLK_STS_INVAL;
+			return false;
+		}
+	}
+
+	if (blk_can_dma_map_iova(req, dma_dev) &&
+	    dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
+		return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);
+	return blk_dma_map_direct(req, dma_dev, iter, &vec);
+}
+EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
+
+/**
+ * blk_rq_dma_map_iter_next - map the next DMA segment for a request
+ * @req:	request to map
+ * @dma_dev:	device to map to
+ * @state:	DMA IOVA state
+ * @iter:	block layer DMA iterator
+ *
+ * Iterate to the next mapping after a previous call to
+ * blk_rq_dma_map_iter_start().  See there for a detailed description of the
+ * arguments.
+ *
+ * Returns %false if there is no segment to map, including due to an error, or
+ * %true ft it did map a segment.
+ *
+ * If a segment was mapped, the DMA address for it is returned in @iter.addr and
+ * the length in @iter.len.  If no segment was mapped the status code is
+ * returned in @iter.status.
+ */
+bool blk_rq_dma_map_iter_next(struct request *req, struct device *dma_dev,
+		struct dma_iova_state *state, struct blk_dma_iter *iter)
+{
+	struct phys_vec vec;
+
+	if (!blk_map_iter_next(req, &iter->iter, &vec))
+		return false;
+
+	if (iter->p2pdma.map == PCI_P2PDMA_MAP_BUS_ADDR)
+		return blk_dma_map_bus(req, dma_dev, iter, &vec);
+	return blk_dma_map_direct(req, dma_dev, iter, &vec);
+}
+EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_next);
+
 static inline struct scatterlist *
 blk_next_sg(struct scatterlist **sg, struct scatterlist *sglist)
 {
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
new file mode 100644
index 000000000000..c26a01aeae00
--- /dev/null
+++ b/include/linux/blk-mq-dma.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef BLK_MQ_DMA_H
+#define BLK_MQ_DMA_H
+
+#include <linux/blk-mq.h>
+#include <linux/pci-p2pdma.h>
+
+struct blk_dma_iter {
+	/* Output address range for this iteration */
+	dma_addr_t			addr;
+	u32				len;
+
+	/* Status code. Only valid when blk_rq_dma_map_iter_* returned false */
+	blk_status_t			status;
+
+	/* Internal to blk_rq_dma_map_iter_* */
+	struct req_iterator		iter;
+	struct pci_p2pdma_map_state	p2pdma;
+};
+
+bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
+		struct dma_iova_state *state, struct blk_dma_iter *iter);
+bool blk_rq_dma_map_iter_next(struct request *req, struct device *dma_dev,
+		struct dma_iova_state *state, struct blk_dma_iter *iter);
+
+/**
+ * blk_rq_dma_map_coalesce - were all segments coalesced?
+ * @state: DMA state to check
+ *
+ * Returns true if blk_rq_dma_map_iter_start coalesced all segments into a
+ * single DMA range.
+ */
+static inline bool blk_rq_dma_map_coalesce(struct dma_iova_state *state)
+{
+	return dma_use_iova(state);
+}
+
+/**
+ * blk_rq_dma_unmap - try to DMA unmap a request
+ * @req:	request to unmap
+ * @dma_dev:	device to unmap from
+ * @state:	DMA IOVA state
+ * @mapped_len: number of bytes to unmap
+ *
+ * Returns %false if the callers need to manually unmap every DMA segment
+ * mapped using @iter or %true if no work is left to be done.
+ */
+static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
+		struct dma_iova_state *state, size_t mapped_len)
+{
+	if (req->cmd_flags & REQ_P2PDMA)
+		return true;
+
+	if (dma_use_iova(state)) {
+		dma_iova_destroy(dma_dev, state, mapped_len, rq_dma_dir(req),
+				 0);
+		return true;
+	}
+
+	return !dma_need_unmap(dma_dev);
+}
+
+#endif /* BLK_MQ_DMA_H */
-- 
2.47.2


