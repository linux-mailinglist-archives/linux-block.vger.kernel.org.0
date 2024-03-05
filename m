Return-Path: <linux-block+bounces-4041-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD99871BB1
	for <lists+linux-block@lfdr.de>; Tue,  5 Mar 2024 11:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921BF1C21CEB
	for <lists+linux-block@lfdr.de>; Tue,  5 Mar 2024 10:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB2C763FC;
	Tue,  5 Mar 2024 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1hZRbEL"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0C763ED;
	Tue,  5 Mar 2024 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634194; cv=none; b=WE3u6Q6/qvPaEvJhsmwizOMAFsjWmDsDBQGFToLTDGVJ8A1/UQeGBooEcrrd62Kg4kdjXdh050aXGqMXfPx8U9e6e8X4iMhdTZzmDrQU+4/orvDBgRfgzEZq1poyF7E53ylbktd4hD5r3+79CNk5TCeAP/ZCHTR7hG4XDj1GxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634194; c=relaxed/simple;
	bh=ktX9dWW2cFJcgdIR5D6ZbOLB18GCIDFrg21/P33AIJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGZRKCdLZtyEF+d5i+Hic981vpJud6jN9a+2KovpRK3tnR+khfInq5HYXdNxYYNnJi8RCfGddnCQCEqUzVfyxgYB8a8lm54xn3oFb/5XYIJ58XlcuxVyJWROR3CKyXblHSxMlpSUmRzSGbQe7j0doxsiLt/Swa6dCH+E0Q3rjS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1hZRbEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EFEC433F1;
	Tue,  5 Mar 2024 10:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709634194;
	bh=ktX9dWW2cFJcgdIR5D6ZbOLB18GCIDFrg21/P33AIJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1hZRbELCE6uiz31Yp/Q5Zt2C1OGv9D0YeIMkimenbdQoNv52+RqBEl1tNgUQ3E9c
	 lQbD8uJwuu3L9TVTeKdXUja5EB59RmD8UKbY435RSB/rf9WawWPtz1LsMvo2xYE6h3
	 Xzkr6T2Stgt/KgCWCQ9IsOGfWCRzkKfO7ARE3vnvJLo/UE0rdFeFUaIDh87aVoZ1kY
	 eQse1YVFV3BKQNT3y0eL5JEtVosqocmoAl6b86PSWTQBNwlklpE7fJIrrDJMRK54Nv
	 X50cWAGYWs3UN22nuwH5f99AT8CuVzkKLMh567grSDoMMTO1bs4NeQFChHTQdKk1VO
	 l2A5aaNGx1wtw==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
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
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [RFC 12/16] vfio/mlx5: Rewrite create mkey flow to allow better code reuse
Date: Tue,  5 Mar 2024 12:22:13 +0200
Message-ID: <9366169430357d953e961cd41ae912c5fbd3f568.1709631413.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709631800.git.leon@kernel.org>
References: <cover.1709631800.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Change the creation of mkey to be performed in multiple steps:
data allocation, DMA setup and actual call to HW to create that mkey.

In this new flow, the whole input to MKEY command is saved to eliminate
the need to keep array of pointers for DMA addresses for receive list
and in the future patches for send list too.

In addition to memory size reduce and elimination of unnecessary data
movements to set MKEY input, the code is prepared for future reuse.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/vfio/pci/mlx5/cmd.c | 149 +++++++++++++++++++++---------------
 drivers/vfio/pci/mlx5/cmd.h |   3 +-
 2 files changed, 88 insertions(+), 64 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index 45104e47b7b2..44762980fcb9 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -300,39 +300,21 @@ static int mlx5vf_cmd_get_vhca_id(struct mlx5_core_dev *mdev, u16 function_id,
 	return ret;
 }
 
-static int _create_mkey(struct mlx5_core_dev *mdev, u32 pdn,
-			struct mlx5_vhca_data_buffer *buf,
-			struct mlx5_vhca_recv_buf *recv_buf,
-			u32 *mkey)
+static u32 *alloc_mkey_in(u32 npages, u32 pdn)
 {
-	size_t npages = buf ? buf->npages : recv_buf->npages;
-	int err = 0, inlen;
-	__be64 *mtt;
+	int inlen;
 	void *mkc;
 	u32 *in;
 
 	inlen = MLX5_ST_SZ_BYTES(create_mkey_in) +
-		sizeof(*mtt) * round_up(npages, 2);
+		sizeof(__be64) * round_up(npages, 2);
 
-	in = kvzalloc(inlen, GFP_KERNEL);
+	in = kvzalloc(inlen, GFP_KERNEL_ACCOUNT);
 	if (!in)
-		return -ENOMEM;
+		return NULL;
 
 	MLX5_SET(create_mkey_in, in, translations_octword_actual_size,
 		 DIV_ROUND_UP(npages, 2));
-	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, in, klm_pas_mtt);
-
-	if (buf) {
-		struct sg_dma_page_iter dma_iter;
-
-		for_each_sgtable_dma_page(&buf->table.sgt, &dma_iter, 0)
-			*mtt++ = cpu_to_be64(sg_page_iter_dma_address(&dma_iter));
-	} else {
-		int i;
-
-		for (i = 0; i < npages; i++)
-			*mtt++ = cpu_to_be64(recv_buf->dma_addrs[i]);
-	}
 
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
 	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_MTT);
@@ -346,9 +328,30 @@ static int _create_mkey(struct mlx5_core_dev *mdev, u32 pdn,
 	MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
 	MLX5_SET(mkc, mkc, translations_octword_size, DIV_ROUND_UP(npages, 2));
 	MLX5_SET64(mkc, mkc, len, npages * PAGE_SIZE);
-	err = mlx5_core_create_mkey(mdev, mkey, in, inlen);
-	kvfree(in);
-	return err;
+
+	return in;
+}
+
+static int create_mkey(struct mlx5_core_dev *mdev, u32 npages,
+		       struct mlx5_vhca_data_buffer *buf, u32 *mkey_in,
+		       u32 *mkey)
+{
+	__be64 *mtt;
+	int inlen;
+
+	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
+
+	if (buf) {
+		struct sg_dma_page_iter dma_iter;
+
+		for_each_sgtable_dma_page(&buf->table.sgt, &dma_iter, 0)
+			*mtt++ = cpu_to_be64(sg_page_iter_dma_address(&dma_iter));
+	}
+
+	inlen = MLX5_ST_SZ_BYTES(create_mkey_in) +
+		sizeof(__be64) * round_up(npages, 2);
+
+	return mlx5_core_create_mkey(mdev, mkey, mkey_in, inlen);
 }
 
 static int mlx5vf_dma_data_buffer(struct mlx5_vhca_data_buffer *buf)
@@ -368,13 +371,22 @@ static int mlx5vf_dma_data_buffer(struct mlx5_vhca_data_buffer *buf)
 	if (ret)
 		return ret;
 
-	ret = _create_mkey(mdev, buf->migf->pdn, buf, NULL, &buf->mkey);
-	if (ret)
+	buf->mkey_in = alloc_mkey_in(buf->npages, buf->migf->pdn);
+	if (!buf->mkey_in) {
+		ret = -ENOMEM;
 		goto err;
+	}
+
+	ret = create_mkey(mdev, buf->npages, buf, buf->mkey_in, &buf->mkey);
+	if (ret)
+		goto err_create_mkey;
 
 	buf->dmaed = true;
 
 	return 0;
+
+err_create_mkey:
+	kvfree(buf->mkey_in);
 err:
 	dma_unmap_sgtable(mdev->device, &buf->table.sgt, buf->dma_dir, 0);
 	return ret;
@@ -390,6 +402,7 @@ void mlx5vf_free_data_buffer(struct mlx5_vhca_data_buffer *buf)
 
 	if (buf->dmaed) {
 		mlx5_core_destroy_mkey(migf->mvdev->mdev, buf->mkey);
+		kvfree(buf->mkey_in);
 		dma_unmap_sgtable(migf->mvdev->mdev->device, &buf->table.sgt,
 				  buf->dma_dir, 0);
 	}
@@ -1286,46 +1299,45 @@ static int alloc_recv_pages(struct mlx5_vhca_recv_buf *recv_buf,
 	return -ENOMEM;
 }
 
-static int register_dma_recv_pages(struct mlx5_core_dev *mdev,
-				   struct mlx5_vhca_recv_buf *recv_buf)
+static void unregister_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
+				 u32 *mkey_in)
 {
-	int i, j;
+	dma_addr_t addr;
+	__be64 *mtt;
+	int i;
 
-	recv_buf->dma_addrs = kvcalloc(recv_buf->npages,
-				       sizeof(*recv_buf->dma_addrs),
-				       GFP_KERNEL_ACCOUNT);
-	if (!recv_buf->dma_addrs)
-		return -ENOMEM;
+	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
 
-	for (i = 0; i < recv_buf->npages; i++) {
-		recv_buf->dma_addrs[i] = dma_map_page(mdev->device,
-						      recv_buf->page_list[i],
-						      0, PAGE_SIZE,
-						      DMA_FROM_DEVICE);
-		if (dma_mapping_error(mdev->device, recv_buf->dma_addrs[i]))
-			goto error;
+	for (i = npages - 1; i >= 0; i--) {
+		addr = be64_to_cpu(mtt[i]);
+		dma_unmap_single(mdev->device, addr, PAGE_SIZE,
+				 DMA_FROM_DEVICE);
 	}
-	return 0;
-
-error:
-	for (j = 0; j < i; j++)
-		dma_unmap_single(mdev->device, recv_buf->dma_addrs[j],
-				 PAGE_SIZE, DMA_FROM_DEVICE);
-
-	kvfree(recv_buf->dma_addrs);
-	return -ENOMEM;
 }
 
-static void unregister_dma_recv_pages(struct mlx5_core_dev *mdev,
-				      struct mlx5_vhca_recv_buf *recv_buf)
+static int register_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
+			      struct page **page_list, u32 *mkey_in)
 {
+	dma_addr_t addr;
+	__be64 *mtt;
 	int i;
 
-	for (i = 0; i < recv_buf->npages; i++)
-		dma_unmap_single(mdev->device, recv_buf->dma_addrs[i],
-				 PAGE_SIZE, DMA_FROM_DEVICE);
+	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
+
+	for (i = 0; i < npages; i++) {
+		addr = dma_map_page(mdev->device, page_list[i], 0, PAGE_SIZE,
+				    DMA_FROM_DEVICE);
+		if (dma_mapping_error(mdev->device, addr))
+			goto error;
+
+		*mtt++ = cpu_to_be64(addr);
+	}
+
+	return 0;
 
-	kvfree(recv_buf->dma_addrs);
+error:
+	unregister_dma_pages(mdev, i, mkey_in);
+	return -ENOMEM;
 }
 
 static void mlx5vf_free_qp_recv_resources(struct mlx5_core_dev *mdev,
@@ -1334,7 +1346,8 @@ static void mlx5vf_free_qp_recv_resources(struct mlx5_core_dev *mdev,
 	struct mlx5_vhca_recv_buf *recv_buf = &qp->recv_buf;
 
 	mlx5_core_destroy_mkey(mdev, recv_buf->mkey);
-	unregister_dma_recv_pages(mdev, recv_buf);
+	unregister_dma_pages(mdev, recv_buf->npages, recv_buf->mkey_in);
+	kvfree(recv_buf->mkey_in);
 	free_recv_pages(&qp->recv_buf);
 }
 
@@ -1350,18 +1363,28 @@ static int mlx5vf_alloc_qp_recv_resources(struct mlx5_core_dev *mdev,
 	if (err < 0)
 		return err;
 
-	err = register_dma_recv_pages(mdev, recv_buf);
-	if (err)
+	recv_buf->mkey_in = alloc_mkey_in(npages, pdn);
+	if (!recv_buf->mkey_in) {
+		err = -ENOMEM;
 		goto end;
+	}
+
+	err = register_dma_pages(mdev, npages, recv_buf->page_list,
+				 recv_buf->mkey_in);
+	if (err)
+		goto err_register_dma;
 
-	err = _create_mkey(mdev, pdn, NULL, recv_buf, &recv_buf->mkey);
+	err = create_mkey(mdev, npages, NULL, recv_buf->mkey_in,
+			  &recv_buf->mkey);
 	if (err)
 		goto err_create_mkey;
 
 	return 0;
 
 err_create_mkey:
-	unregister_dma_recv_pages(mdev, recv_buf);
+	unregister_dma_pages(mdev, npages, recv_buf->mkey_in);
+err_register_dma:
+	kvfree(recv_buf->mkey_in);
 end:
 	free_recv_pages(recv_buf);
 	return err;
diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index 887267ebbd8a..83728c0669e7 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -62,6 +62,7 @@ struct mlx5_vhca_data_buffer {
 	u64 length;
 	u32 npages;
 	u32 mkey;
+	u32 *mkey_in;
 	enum dma_data_direction dma_dir;
 	u8 dmaed:1;
 	u8 stop_copy_chunk_num;
@@ -137,8 +138,8 @@ struct mlx5_vhca_cq {
 struct mlx5_vhca_recv_buf {
 	u32 npages;
 	struct page **page_list;
-	dma_addr_t *dma_addrs;
 	u32 next_rq_offset;
+	u32 *mkey_in;
 	u32 mkey;
 };
 
-- 
2.44.0


