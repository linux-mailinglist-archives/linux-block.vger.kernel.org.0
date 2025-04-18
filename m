Return-Path: <linux-block+bounces-19939-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F316FA932A9
	for <lists+linux-block@lfdr.de>; Fri, 18 Apr 2025 08:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0834A0729
	for <lists+linux-block@lfdr.de>; Fri, 18 Apr 2025 06:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D841E27C867;
	Fri, 18 Apr 2025 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMFMEvsI"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B4269825;
	Fri, 18 Apr 2025 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744958943; cv=none; b=X8nBu5cWPH6A9Vjvs35xCp8y2N3UCca/ParGGfV+ieI3vxLQqOTHLRupqytUfdY3YfjRBlJbGMaoXh0wB4TWKK4NyTeppfN9a1Et10Fpe/1DKoIlN/vxympjxxlQn6cN67/l+PXVVFPnWrg3N/ZJR4jkMHQnIseZiPyiAbmJdDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744958943; c=relaxed/simple;
	bh=EPzTZDd0eOTamxodfs1rsLFOSVB2yLBpcqi7TuXm9XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIlJUt7hNZfOBjdq3tUp6wXZkyqLonS7Wicj/9IRYoWvbGeb3KyjJQpdOW31i1P5HWYSVLCVPiptFTf/Au5Ym5tHcKSmUE0W70teBe0h6fTNaLCy60Ys5w3D4sbOry8we/hEQsSUWrpmeVMI8mkACLN8u7nU+vmHAipUz4b9T9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMFMEvsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECB5C4CEE7;
	Fri, 18 Apr 2025 06:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744958943;
	bh=EPzTZDd0eOTamxodfs1rsLFOSVB2yLBpcqi7TuXm9XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMFMEvsIfqOXy1o+P6PuvYTgtMoRQdZ6EFAVkM4rAIqRubJnfnWIS7mM0Xmm0+TFO
	 Iy6sgnSkUcVRpNGSfKnSOabmL/Uug8V4G5dyJNXXIW/prEKtEquvhj2r/oAEBTL0jD
	 y6nuDZU0zLrOIzTnvrxFE5t+U8eSeozhSBGlLmt+dN7RINyKxOGZ5FAvZBgtbvP/Kg
	 rrGX6GmY4U1kbEq/Br3XOo11jb/vY429rh+/aMPAL8t/FW1tBBI8Ix1PEjrJcAxNub
	 /7lWv4SOlcpgOpEer1njxXLk5MUUh2DG/akBmJ8G+mE11CIt05Vi/Z0fYh0egD5hLS
	 SCERryux6GXWw==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v8 17/24] vfio/mlx5: Enable the DMA link API
Date: Fri, 18 Apr 2025 09:47:47 +0300
Message-ID: <076a3991e663fe07c1a5395f5805c514b63e4d94.1744825142.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744825142.git.leon@kernel.org>
References: <cover.1744825142.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Remove intermediate scatter-gather table completely and
enable new DMA link API.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/vfio/pci/mlx5/cmd.c  | 298 ++++++++++++++++-------------------
 drivers/vfio/pci/mlx5/cmd.h  |  21 ++-
 drivers/vfio/pci/mlx5/main.c |  31 ----
 3 files changed, 147 insertions(+), 203 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index 84dc3bc128c6..b162e44112fb 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -345,26 +345,82 @@ static u32 *alloc_mkey_in(u32 npages, u32 pdn)
 	return in;
 }
 
-static int create_mkey(struct mlx5_core_dev *mdev, u32 npages,
-		       struct mlx5_vhca_data_buffer *buf, u32 *mkey_in,
+static int create_mkey(struct mlx5_core_dev *mdev, u32 npages, u32 *mkey_in,
 		       u32 *mkey)
 {
+	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in) +
+		sizeof(__be64) * round_up(npages, 2);
+
+	return mlx5_core_create_mkey(mdev, mkey, mkey_in, inlen);
+}
+
+static void unregister_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
+				 u32 *mkey_in, struct dma_iova_state *state,
+				 enum dma_data_direction dir)
+{
+	dma_addr_t addr;
 	__be64 *mtt;
-	int inlen;
+	int i;
 
-	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
-	if (buf) {
-		struct sg_dma_page_iter dma_iter;
+	WARN_ON_ONCE(dir == DMA_NONE);
 
-		for_each_sgtable_dma_page(&buf->table.sgt, &dma_iter, 0)
-			*mtt++ = cpu_to_be64(
-				sg_page_iter_dma_address(&dma_iter));
+	if (dma_use_iova(state)) {
+		dma_iova_destroy(mdev->device, state, npages * PAGE_SIZE, dir,
+				 0);
+	} else {
+		mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in,
+					     klm_pas_mtt);
+		for (i = npages - 1; i >= 0; i--) {
+			addr = be64_to_cpu(mtt[i]);
+			dma_unmap_page(mdev->device, addr, PAGE_SIZE, dir);
+		}
 	}
+}
 
-	inlen = MLX5_ST_SZ_BYTES(create_mkey_in) +
-		sizeof(__be64) * round_up(npages, 2);
+static int register_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
+			      struct page **page_list, u32 *mkey_in,
+			      struct dma_iova_state *state,
+			      enum dma_data_direction dir)
+{
+	dma_addr_t addr;
+	size_t mapped = 0;
+	__be64 *mtt;
+	int i, err;
 
-	return mlx5_core_create_mkey(mdev, mkey, mkey_in, inlen);
+	WARN_ON_ONCE(dir == DMA_NONE);
+
+	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
+
+	if (dma_iova_try_alloc(mdev->device, state, 0, npages * PAGE_SIZE)) {
+		addr = state->addr;
+		for (i = 0; i < npages; i++) {
+			err = dma_iova_link(mdev->device, state,
+					    page_to_phys(page_list[i]), mapped,
+					    PAGE_SIZE, dir, 0);
+			if (err)
+				goto error;
+			*mtt++ = cpu_to_be64(addr);
+			addr += PAGE_SIZE;
+			mapped += PAGE_SIZE;
+		}
+		err = dma_iova_sync(mdev->device, state, 0, mapped);
+		if (err)
+			goto error;
+	} else {
+		for (i = 0; i < npages; i++) {
+			addr = dma_map_page(mdev->device, page_list[i], 0,
+					    PAGE_SIZE, dir);
+			err = dma_mapping_error(mdev->device, addr);
+			if (err)
+				goto error;
+			*mtt++ = cpu_to_be64(addr);
+		}
+	}
+	return 0;
+
+error:
+	unregister_dma_pages(mdev, i, mkey_in, state, dir);
+	return err;
 }
 
 static int mlx5vf_dma_data_buffer(struct mlx5_vhca_data_buffer *buf)
@@ -380,98 +436,90 @@ static int mlx5vf_dma_data_buffer(struct mlx5_vhca_data_buffer *buf)
 	if (buf->mkey_in || !buf->npages)
 		return -EINVAL;
 
-	ret = dma_map_sgtable(mdev->device, &buf->table.sgt, buf->dma_dir, 0);
-	if (ret)
-		return ret;
-
 	buf->mkey_in = alloc_mkey_in(buf->npages, buf->migf->pdn);
-	if (!buf->mkey_in) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!buf->mkey_in)
+		return -ENOMEM;
 
-	ret = create_mkey(mdev, buf->npages, buf, buf->mkey_in, &buf->mkey);
+	ret = register_dma_pages(mdev, buf->npages, buf->page_list,
+				 buf->mkey_in, &buf->state, buf->dma_dir);
+	if (ret)
+		goto err_register_dma;
+
+	ret = create_mkey(mdev, buf->npages, buf->mkey_in, &buf->mkey);
 	if (ret)
 		goto err_create_mkey;
 
 	return 0;
 
 err_create_mkey:
+	unregister_dma_pages(mdev, buf->npages, buf->mkey_in, &buf->state,
+			     buf->dma_dir);
+err_register_dma:
 	kvfree(buf->mkey_in);
 	buf->mkey_in = NULL;
-err:
-	dma_unmap_sgtable(mdev->device, &buf->table.sgt, buf->dma_dir, 0);
 	return ret;
 }
 
+static void free_page_list(u32 npages, struct page **page_list)
+{
+	int i;
+
+	/* Undo alloc_pages_bulk() */
+	for (i = npages - 1; i >= 0; i--)
+		__free_page(page_list[i]);
+
+	kvfree(page_list);
+}
+
 void mlx5vf_free_data_buffer(struct mlx5_vhca_data_buffer *buf)
 {
-	struct mlx5_vf_migration_file *migf = buf->migf;
-	struct sg_page_iter sg_iter;
+	struct mlx5vf_pci_core_device *mvdev = buf->migf->mvdev;
+	struct mlx5_core_dev *mdev = mvdev->mdev;
 
-	lockdep_assert_held(&migf->mvdev->state_mutex);
-	WARN_ON(migf->mvdev->mdev_detach);
+	lockdep_assert_held(&mvdev->state_mutex);
+	WARN_ON(mvdev->mdev_detach);
 
 	if (buf->mkey_in) {
-		mlx5_core_destroy_mkey(migf->mvdev->mdev, buf->mkey);
+		mlx5_core_destroy_mkey(mdev, buf->mkey);
+		unregister_dma_pages(mdev, buf->npages, buf->mkey_in,
+				     &buf->state, buf->dma_dir);
 		kvfree(buf->mkey_in);
-		dma_unmap_sgtable(migf->mvdev->mdev->device, &buf->table.sgt,
-				  buf->dma_dir, 0);
 	}
 
-	/* Undo alloc_pages_bulk() */
-	for_each_sgtable_page(&buf->table.sgt, &sg_iter, 0)
-		__free_page(sg_page_iter_page(&sg_iter));
-	sg_free_append_table(&buf->table);
+	free_page_list(buf->npages, buf->page_list);
 	kfree(buf);
 }
 
-static int mlx5vf_add_migration_pages(struct mlx5_vhca_data_buffer *buf,
-				      unsigned int npages)
+static int mlx5vf_add_pages(struct page ***page_list, unsigned int npages)
 {
-	unsigned int to_alloc = npages;
-	struct page **page_list;
-	unsigned long filled;
-	unsigned int to_fill;
-	int ret;
+	unsigned int filled, done = 0;
 	int i;
 
-	to_fill = min_t(unsigned int, npages, PAGE_SIZE / sizeof(*page_list));
-	page_list = kvzalloc(to_fill * sizeof(*page_list), GFP_KERNEL_ACCOUNT);
-	if (!page_list)
+	*page_list =
+		kvcalloc(npages, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
+	if (!*page_list)
 		return -ENOMEM;
 
-	do {
-		filled = alloc_pages_bulk(GFP_KERNEL_ACCOUNT, to_fill,
-					  page_list);
-		if (!filled) {
-			ret = -ENOMEM;
+	for (;;) {
+		filled = alloc_pages_bulk(GFP_KERNEL_ACCOUNT, npages - done,
+					  *page_list + done);
+		if (!filled)
 			goto err;
-		}
-		to_alloc -= filled;
-		ret = sg_alloc_append_table_from_pages(
-			&buf->table, page_list, filled, 0,
-			filled << PAGE_SHIFT, UINT_MAX, SG_MAX_SINGLE_ALLOC,
-			GFP_KERNEL_ACCOUNT);
 
-		if (ret)
-			goto err_append;
-		buf->npages += filled;
-		/* clean input for another bulk allocation */
-		memset(page_list, 0, filled * sizeof(*page_list));
-		to_fill = min_t(unsigned int, to_alloc,
-				PAGE_SIZE / sizeof(*page_list));
-	} while (to_alloc > 0);
+		done += filled;
+		if (done == npages)
+			break;
+	}
 
-	kvfree(page_list);
 	return 0;
 
-err_append:
-	for (i = filled - 1; i >= 0; i--)
-		__free_page(page_list[i]);
 err:
-	kvfree(page_list);
-	return ret;
+	for (i = 0; i < done; i++)
+		__free_page(*page_list[i]);
+
+	kvfree(*page_list);
+	*page_list = NULL;
+	return -ENOMEM;
 }
 
 struct mlx5_vhca_data_buffer *
@@ -488,10 +536,12 @@ mlx5vf_alloc_data_buffer(struct mlx5_vf_migration_file *migf, u32 npages,
 	buf->dma_dir = dma_dir;
 	buf->migf = migf;
 	if (npages) {
-		ret = mlx5vf_add_migration_pages(buf, npages);
+		ret = mlx5vf_add_pages(&buf->page_list, npages);
 		if (ret)
 			goto end;
 
+		buf->npages = npages;
+
 		if (dma_dir != DMA_NONE) {
 			ret = mlx5vf_dma_data_buffer(buf);
 			if (ret)
@@ -1350,101 +1400,16 @@ static void mlx5vf_destroy_qp(struct mlx5_core_dev *mdev,
 	kfree(qp);
 }
 
-static void free_recv_pages(struct mlx5_vhca_recv_buf *recv_buf)
-{
-	int i;
-
-	/* Undo alloc_pages_bulk() */
-	for (i = 0; i < recv_buf->npages; i++)
-		__free_page(recv_buf->page_list[i]);
-
-	kvfree(recv_buf->page_list);
-}
-
-static int alloc_recv_pages(struct mlx5_vhca_recv_buf *recv_buf,
-			    unsigned int npages)
-{
-	unsigned int filled = 0, done = 0;
-	int i;
-
-	recv_buf->page_list = kvcalloc(npages, sizeof(*recv_buf->page_list),
-				       GFP_KERNEL_ACCOUNT);
-	if (!recv_buf->page_list)
-		return -ENOMEM;
-
-	for (;;) {
-		filled = alloc_pages_bulk(GFP_KERNEL_ACCOUNT,
-					  npages - done,
-					  recv_buf->page_list + done);
-		if (!filled)
-			goto err;
-
-		done += filled;
-		if (done == npages)
-			break;
-	}
-
-	recv_buf->npages = npages;
-	return 0;
-
-err:
-	for (i = 0; i < npages; i++) {
-		if (recv_buf->page_list[i])
-			__free_page(recv_buf->page_list[i]);
-	}
-
-	kvfree(recv_buf->page_list);
-	return -ENOMEM;
-}
-static void unregister_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
-				 u32 *mkey_in)
-{
-	dma_addr_t addr;
-	__be64 *mtt;
-	int i;
-
-	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
-	for (i = npages - 1; i >= 0; i--) {
-		addr = be64_to_cpu(mtt[i]);
-		dma_unmap_single(mdev->device, addr, PAGE_SIZE,
-				DMA_FROM_DEVICE);
-	}
-}
-
-static int register_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
-			      struct page **page_list, u32 *mkey_in)
-{
-	dma_addr_t addr;
-	__be64 *mtt;
-	int i;
-
-	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
-
-	for (i = 0; i < npages; i++) {
-		addr = dma_map_page(mdev->device, page_list[i], 0, PAGE_SIZE,
-				    DMA_FROM_DEVICE);
-		if (dma_mapping_error(mdev->device, addr))
-			goto error;
-
-		*mtt++ = cpu_to_be64(addr);
-	}
-
-	return 0;
-
-error:
-	unregister_dma_pages(mdev, i, mkey_in);
-	return -ENOMEM;
-}
-
 static void mlx5vf_free_qp_recv_resources(struct mlx5_core_dev *mdev,
 					  struct mlx5_vhca_qp *qp)
 {
 	struct mlx5_vhca_recv_buf *recv_buf = &qp->recv_buf;
 
 	mlx5_core_destroy_mkey(mdev, recv_buf->mkey);
-	unregister_dma_pages(mdev, recv_buf->npages, recv_buf->mkey_in);
+	unregister_dma_pages(mdev, recv_buf->npages, recv_buf->mkey_in,
+			     &recv_buf->state, DMA_FROM_DEVICE);
 	kvfree(recv_buf->mkey_in);
-	free_recv_pages(&qp->recv_buf);
+	free_page_list(recv_buf->npages, recv_buf->page_list);
 }
 
 static int mlx5vf_alloc_qp_recv_resources(struct mlx5_core_dev *mdev,
@@ -1455,10 +1420,12 @@ static int mlx5vf_alloc_qp_recv_resources(struct mlx5_core_dev *mdev,
 	struct mlx5_vhca_recv_buf *recv_buf = &qp->recv_buf;
 	int err;
 
-	err = alloc_recv_pages(recv_buf, npages);
-	if (err < 0)
+	err = mlx5vf_add_pages(&recv_buf->page_list, npages);
+	if (err)
 		return err;
 
+	recv_buf->npages = npages;
+
 	recv_buf->mkey_in = alloc_mkey_in(npages, pdn);
 	if (!recv_buf->mkey_in) {
 		err = -ENOMEM;
@@ -1466,24 +1433,25 @@ static int mlx5vf_alloc_qp_recv_resources(struct mlx5_core_dev *mdev,
 	}
 
 	err = register_dma_pages(mdev, npages, recv_buf->page_list,
-				 recv_buf->mkey_in);
+				 recv_buf->mkey_in, &recv_buf->state,
+				 DMA_FROM_DEVICE);
 	if (err)
 		goto err_register_dma;
 
-	err = create_mkey(mdev, npages, NULL, recv_buf->mkey_in,
-			  &recv_buf->mkey);
+	err = create_mkey(mdev, npages, recv_buf->mkey_in, &recv_buf->mkey);
 	if (err)
 		goto err_create_mkey;
 
 	return 0;
 
 err_create_mkey:
-	unregister_dma_pages(mdev, npages, recv_buf->mkey_in);
+	unregister_dma_pages(mdev, npages, recv_buf->mkey_in, &recv_buf->state,
+			     DMA_FROM_DEVICE);
 err_register_dma:
 	kvfree(recv_buf->mkey_in);
 	recv_buf->mkey_in = NULL;
 end:
-	free_recv_pages(recv_buf);
+	free_page_list(npages, recv_buf->page_list);
 	return err;
 }
 
diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index 25dd6ff54591..d7821b5ca772 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -53,7 +53,8 @@ struct mlx5_vf_migration_header {
 };
 
 struct mlx5_vhca_data_buffer {
-	struct sg_append_table table;
+	struct page **page_list;
+	struct dma_iova_state state;
 	loff_t start_pos;
 	u64 length;
 	u32 npages;
@@ -63,10 +64,6 @@ struct mlx5_vhca_data_buffer {
 	u8 stop_copy_chunk_num;
 	struct list_head buf_elm;
 	struct mlx5_vf_migration_file *migf;
-	/* Optimize mlx5vf_get_migration_page() for sequential access */
-	struct scatterlist *last_offset_sg;
-	unsigned int sg_last_entry;
-	unsigned long last_offset;
 };
 
 struct mlx5vf_async_data {
@@ -133,6 +130,7 @@ struct mlx5_vhca_cq {
 struct mlx5_vhca_recv_buf {
 	u32 npages;
 	struct page **page_list;
+	struct dma_iova_state state;
 	u32 next_rq_offset;
 	u32 *mkey_in;
 	u32 mkey;
@@ -224,8 +222,17 @@ struct mlx5_vhca_data_buffer *
 mlx5vf_get_data_buffer(struct mlx5_vf_migration_file *migf, u32 npages,
 		       enum dma_data_direction dma_dir);
 void mlx5vf_put_data_buffer(struct mlx5_vhca_data_buffer *buf);
-struct page *mlx5vf_get_migration_page(struct mlx5_vhca_data_buffer *buf,
-				       unsigned long offset);
+static inline struct page *
+mlx5vf_get_migration_page(struct mlx5_vhca_data_buffer *buf,
+			  unsigned long offset)
+{
+	int page_entry = offset / PAGE_SIZE;
+
+	if (page_entry >= buf->npages)
+		return NULL;
+
+	return buf->page_list[page_entry];
+}
 void mlx5vf_state_mutex_unlock(struct mlx5vf_pci_core_device *mvdev);
 void mlx5vf_disable_fds(struct mlx5vf_pci_core_device *mvdev,
 			enum mlx5_vf_migf_state *last_save_state);
diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index bc0f468f741b..93f894fe60d2 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -34,37 +34,6 @@ static struct mlx5vf_pci_core_device *mlx5vf_drvdata(struct pci_dev *pdev)
 			    core_device);
 }
 
-struct page *
-mlx5vf_get_migration_page(struct mlx5_vhca_data_buffer *buf,
-			  unsigned long offset)
-{
-	unsigned long cur_offset = 0;
-	struct scatterlist *sg;
-	unsigned int i;
-
-	/* All accesses are sequential */
-	if (offset < buf->last_offset || !buf->last_offset_sg) {
-		buf->last_offset = 0;
-		buf->last_offset_sg = buf->table.sgt.sgl;
-		buf->sg_last_entry = 0;
-	}
-
-	cur_offset = buf->last_offset;
-
-	for_each_sg(buf->last_offset_sg, sg,
-			buf->table.sgt.orig_nents - buf->sg_last_entry, i) {
-		if (offset < sg->length + cur_offset) {
-			buf->last_offset_sg = sg;
-			buf->sg_last_entry += i;
-			buf->last_offset = cur_offset;
-			return nth_page(sg_page(sg),
-					(offset - cur_offset) / PAGE_SIZE);
-		}
-		cur_offset += sg->length;
-	}
-	return NULL;
-}
-
 static void mlx5vf_disable_fd(struct mlx5_vf_migration_file *migf)
 {
 	mutex_lock(&migf->lock);
-- 
2.49.0


