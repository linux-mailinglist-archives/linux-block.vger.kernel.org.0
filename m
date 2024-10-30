Return-Path: <linux-block+bounces-13268-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4F79B6752
	for <lists+linux-block@lfdr.de>; Wed, 30 Oct 2024 16:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C3F282A8A
	for <lists+linux-block@lfdr.de>; Wed, 30 Oct 2024 15:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0180C216E17;
	Wed, 30 Oct 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUjbzlfB"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEB2216A1C;
	Wed, 30 Oct 2024 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301230; cv=none; b=WMIoIGhEGUn4dXhlcJdpeASxJa4PJdUSGYY+zo71VNXUTF/RHFFKxY2DfcYVaTuzQnJP/sKs4B+DVH3qbX99hdlszrUpEzozlj7rFd4mXlne1sliIC+voqIuz970BCROZx3GdD/Xl1k8jJnV66R9Sn5o8Lk1WReS9T+G1tj2UeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301230; c=relaxed/simple;
	bh=RhcK3jpx80P74UKqRSLHZKtWTOJGp14TVgQFOHpK5uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjmY+J2XNy40gYJwUJLN26QHK+IAnj38HG8WSeRSamsj1Bm2VK09KiJtDVBeCutfMcvgnI4kWzpTdHiv2XnWt8zpGUQDubw2P0GCtAmhaN0keEmJDd9BGeyZDJIJvad6aMx06QogIMZ4QsFgAqxSYPHLUj9y3OyzG3iwgJodyfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUjbzlfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864EFC4CECF;
	Wed, 30 Oct 2024 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730301230;
	bh=RhcK3jpx80P74UKqRSLHZKtWTOJGp14TVgQFOHpK5uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dUjbzlfB58nam+e/KuKFD86cA5mG8ygjLY9xQ0Z+h8sT3ni+00nHbhRibOA92d2hi
	 8xSFaFNOhS1hi7n1y1TP/+mgcST+mtaxk4HgBka7GNtvh7Mt9RzEEVIg91E8eZ4pX2
	 A/wD3SvwthfhxnGgkwocL11q550gsMwYXoTxqLkRkR/bcMUsXgtpEBnrlQ5MuVmOam
	 3KHo6w/cSCf3BLB2YJgJUjec/9ITBowgjGgsaPk5GvKbINh9JofcCiGOH7ZipyG9gL
	 ZdHwhS8PLH6oDNV6SpMo+XFB1UPff4GK4X5kD5OYHis9J0N5UQL1Uyin1m7/ZYvKdf
	 yHA0I8oajcNSg==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1 03/17] iommu: generalize the batched sync after map interface
Date: Wed, 30 Oct 2024 17:12:49 +0200
Message-ID: <589adb3a4b53121942e9a39051ae49a27f7a074c.1730298502.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730298502.git.leon@kernel.org>
References: <cover.1730298502.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

For the upcoming IOVA-based DMA API we want to use the interface batch the
sync after mapping multiple entries from dma-iommu without having a
scatterlist.

For that move more sanity checks from the callers into __iommu_map and
make that function available outside of iommu.c as iommu_map_nosync.

Add a wrapper for the map_sync as iommu_sync_map so that callers don't
need to poke into the methods directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/iommu.c | 65 +++++++++++++++++++------------------------
 include/linux/iommu.h |  4 +++
 2 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 83c8e617a2c5..6b0943397e1e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2439,8 +2439,8 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
 	return pgsize;
 }
 
-static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
-		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
+		phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	const struct iommu_domain_ops *ops = domain->ops;
 	unsigned long orig_iova = iova;
@@ -2449,12 +2449,19 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	phys_addr_t orig_paddr = paddr;
 	int ret = 0;
 
+	might_sleep_if(gfpflags_allow_blocking(gfp));
+
 	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
 		return -EINVAL;
 
 	if (WARN_ON(!ops->map_pages || domain->pgsize_bitmap == 0UL))
 		return -ENODEV;
 
+	/* Discourage passing strange GFP flags */
+	if (WARN_ON_ONCE(gfp & (__GFP_COMP | __GFP_DMA | __GFP_DMA32 |
+				__GFP_HIGHMEM)))
+		return -EINVAL;
+
 	/* find out the minimum page size supported */
 	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
 
@@ -2502,31 +2509,27 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	return ret;
 }
 
-int iommu_map(struct iommu_domain *domain, unsigned long iova,
-	      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+int iommu_sync_map(struct iommu_domain *domain, unsigned long iova, size_t size)
 {
 	const struct iommu_domain_ops *ops = domain->ops;
-	int ret;
-
-	might_sleep_if(gfpflags_allow_blocking(gfp));
 
-	/* Discourage passing strange GFP flags */
-	if (WARN_ON_ONCE(gfp & (__GFP_COMP | __GFP_DMA | __GFP_DMA32 |
-				__GFP_HIGHMEM)))
-		return -EINVAL;
+	if (!ops->iotlb_sync_map)
+		return 0;
+	return ops->iotlb_sync_map(domain, iova, size);
+}
 
-	ret = __iommu_map(domain, iova, paddr, size, prot, gfp);
-	if (ret == 0 && ops->iotlb_sync_map) {
-		ret = ops->iotlb_sync_map(domain, iova, size);
-		if (ret)
-			goto out_err;
-	}
+int iommu_map(struct iommu_domain *domain, unsigned long iova,
+	      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	int ret;
 
-	return ret;
+	ret = iommu_map_nosync(domain, iova, paddr, size, prot, gfp);
+	if (ret)
+		return ret;
 
-out_err:
-	/* undo mappings already done */
-	iommu_unmap(domain, iova, size);
+	ret = iommu_sync_map(domain, iova, size);
+	if (ret)
+		iommu_unmap(domain, iova, size);
 
 	return ret;
 }
@@ -2612,26 +2615,17 @@ ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 		     struct scatterlist *sg, unsigned int nents, int prot,
 		     gfp_t gfp)
 {
-	const struct iommu_domain_ops *ops = domain->ops;
 	size_t len = 0, mapped = 0;
 	phys_addr_t start;
 	unsigned int i = 0;
 	int ret;
 
-	might_sleep_if(gfpflags_allow_blocking(gfp));
-
-	/* Discourage passing strange GFP flags */
-	if (WARN_ON_ONCE(gfp & (__GFP_COMP | __GFP_DMA | __GFP_DMA32 |
-				__GFP_HIGHMEM)))
-		return -EINVAL;
-
 	while (i <= nents) {
 		phys_addr_t s_phys = sg_phys(sg);
 
 		if (len && s_phys != start + len) {
-			ret = __iommu_map(domain, iova + mapped, start,
+			ret = iommu_map_nosync(domain, iova + mapped, start,
 					len, prot, gfp);
-
 			if (ret)
 				goto out_err;
 
@@ -2654,11 +2648,10 @@ ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			sg = sg_next(sg);
 	}
 
-	if (ops->iotlb_sync_map) {
-		ret = ops->iotlb_sync_map(domain, iova, mapped);
-		if (ret)
-			goto out_err;
-	}
+	ret = iommu_sync_map(domain, iova, mapped);
+	if (ret)
+		goto out_err;
+
 	return mapped;
 
 out_err:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bd722f473635..8927e5f996c2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -799,6 +799,10 @@ extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
+int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
+		phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
+int iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
+		size_t size);
 extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 			  size_t size);
 extern size_t iommu_unmap_fast(struct iommu_domain *domain,
-- 
2.46.2


