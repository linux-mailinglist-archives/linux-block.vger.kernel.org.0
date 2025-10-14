Return-Path: <linux-block+bounces-28439-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94418BDA42C
	for <lists+linux-block@lfdr.de>; Tue, 14 Oct 2025 17:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9003B5F29
	for <lists+linux-block@lfdr.de>; Tue, 14 Oct 2025 15:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8265D302178;
	Tue, 14 Oct 2025 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HGZwPazR"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940AD3019D3
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454318; cv=none; b=FS31L1jj5uzv5xGM/IoFwlJSpoqp7OwDsTXriwYSlLQiKYAsajTH0232dF7yQJGU8Y4TPiXvtOvJVrMLUKKY9jL68iK08SzT7oKBvoIcvBaW9q5anDDn1rA9vYvKdRtP7Piwd9bBuevNqlYJMjaz2tSS18+Ya1OHIk2iCEXh65g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454318; c=relaxed/simple;
	bh=zk6kkVVbyV3uW1L0LKqKzil92s4xOnkCHZtT9hBRwu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUk92oyo9gfKlu2VMq830+r2Ittrl3Z1Q1lK/cZAn4jqXLKbowF2FBiRuUtIbdBypb6QWSTs98Fjko/ogSzZazEMobxDu3pk/W3h8Y0U0KXCWHhXjEdOoiKwa27fbduxa2LEct1v2w4/jLHZUnWSx1CcBwitqE/fzcC0KwS7cgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HGZwPazR; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59EEaTC51502539
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 08:05:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GcquJSsF09/IyJ1oxIFVWfsgqOyQof8O7SRMPVZQqEs=; b=HGZwPazRoI+d
	RyAs8r5ITIxaXmgerwsxsF6i6ZanSmebjmkNfUqPLeU7WV5ZhTx0M4HUkAjeeSAe
	sOGdRvB3Goc2uar8X/ddtgn1gOWbuugcNQvxtkAE4vydg4MEDh0at46+2dG+CON8
	lSe1IgnNcStoYV8I+fCCTlYv+tSTvDdlXgxH3E6hmxPpj/dhQtjdsN2pRk1L/YpQ
	kTCPDqTk8eoEgAOY1LAZbKFMfLBgnsTVyMjvRgJgdmT2nsL4sPXXzIK2WjdauSDO
	pItubw+umJeGiAfwN7JWNRUWJXay0Z9PVXDagH+B1R4B0HfvMb83Oyplq+UpVWP1
	CE6mvZh6Sg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49sre987yv-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 08:05:15 -0700 (PDT)
Received: from twshared10560.01.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 14 Oct 2025 15:05:13 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 5DC9F2B305DD; Tue, 14 Oct 2025 08:05:08 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 2/2] nvme: remove virtual boundary for sgl capable devices
Date: Tue, 14 Oct 2025 08:04:56 -0700
Message-ID: <20251014150456.2219261-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014150456.2219261-1-kbusch@meta.com>
References: <20251014150456.2219261-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gRbOiBDsD9198vGvQMeovWLHt8VaY75C
X-Authority-Analysis: v=2.4 cv=K/Ev3iWI c=1 sm=1 tr=0 ts=68ee66ab cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=_T5Z_dxOy44xYOlzZyMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDExNCBTYWx0ZWRfX6CjdMWcP76BO
 38zbfk29gR4wdEfLSprE9ke/BrRIh1ab2zNKADY0q0gLJpAE6JUUU7zJlKIPh3/1GFXIUTz8ihD
 lY2t4Yzmzaqd8cueRCqyuSikO/JpTWK922Lw4rYfP8DXr4OP90T+4A6eKADm/Z0IzeqP8GbEE1O
 ojbPvN9A0+1rmeeX7HmHB8ELnlNSKc+xXjBAZ/crgt2dtaQuhJgGu66tVqHc3lJi5uZf7kqF2bc
 uJdD1ODQl2fDsW3bvtZvim/EFqoGjRCk2K0dzLbQrAZFCg6nxTb8rswg8TOgx5iGlqeQRs1qXfN
 YEaS0966aHaet0eUVRGkizTYDSYsuS0LZZfd30xqjrKxY9iyMZmVcy6SlV6G6qvzJlnTPixaD8C
 Y0KTdhESxoUcFo/Q4yvWFYcK6C1V4g==
X-Proofpoint-GUID: gRbOiBDsD9198vGvQMeovWLHt8VaY75C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The nvme virtual boundary is only required for the PRP format. Devices
that can use SGL for DMA don't need it for IO queues. Drop reporting it
for such devices; rdma fabrics controllers will continue to use the
limit as they currently don't report any boundary requirements, but tcp
and fc never needed it in the first place so they get to report no
virtual boundary.

Applications may continue to align to the same virtual boundaries for
optimization purposes if they want, and the driver will continue to
decide whether to use the PRP format the same as before if the IO allows
it.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/apple.c   |  1 +
 drivers/nvme/host/core.c    | 10 +++++-----
 drivers/nvme/host/fabrics.h |  6 ++++++
 drivers/nvme/host/fc.c      |  1 +
 drivers/nvme/host/nvme.h    |  7 +++++++
 drivers/nvme/host/pci.c     | 28 +++++++++++++++++++++++++---
 drivers/nvme/host/rdma.c    |  1 +
 drivers/nvme/host/tcp.c     |  1 +
 drivers/nvme/target/loop.c  |  1 +
 9 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index f35d3f71d14f3..15b3d07f8ccdd 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1283,6 +1283,7 @@ static const struct nvme_ctrl_ops nvme_ctrl_ops =3D=
 {
 	.reg_read64 =3D apple_nvme_reg_read64,
 	.free_ctrl =3D apple_nvme_free_ctrl,
 	.get_address =3D apple_nvme_get_address,
+	.get_virt_boundary =3D nvme_get_virt_boundary,
 };
=20
 static void apple_nvme_async_probe(void *data, async_cookie_t cookie)
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa4181d7de736..63e15cce3699c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2069,13 +2069,13 @@ static u32 nvme_max_drv_segments(struct nvme_ctrl=
 *ctrl)
 }
=20
 static void nvme_set_ctrl_limits(struct nvme_ctrl *ctrl,
-		struct queue_limits *lim)
+		struct queue_limits *lim, bool is_admin)
 {
 	lim->max_hw_sectors =3D ctrl->max_hw_sectors;
 	lim->max_segments =3D min_t(u32, USHRT_MAX,
 		min_not_zero(nvme_max_drv_segments(ctrl), ctrl->max_segments));
 	lim->max_integrity_segments =3D ctrl->max_integrity_segments;
-	lim->virt_boundary_mask =3D NVME_CTRL_PAGE_SIZE - 1;
+	lim->virt_boundary_mask =3D ctrl->ops->get_virt_boundary(ctrl, is_admin=
);
 	lim->max_segment_size =3D UINT_MAX;
 	lim->dma_alignment =3D 3;
 }
@@ -2177,7 +2177,7 @@ static int nvme_update_ns_info_generic(struct nvme_=
ns *ns,
 	int ret;
=20
 	lim =3D queue_limits_start_update(ns->disk->queue);
-	nvme_set_ctrl_limits(ns->ctrl, &lim);
+	nvme_set_ctrl_limits(ns->ctrl, &lim, false);
=20
 	memflags =3D blk_mq_freeze_queue(ns->disk->queue);
 	ret =3D queue_limits_commit_update(ns->disk->queue, &lim);
@@ -2381,7 +2381,7 @@ static int nvme_update_ns_info_block(struct nvme_ns=
 *ns,
 	ns->head->lba_shift =3D id->lbaf[lbaf].ds;
 	ns->head->nuse =3D le64_to_cpu(id->nuse);
 	capacity =3D nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
-	nvme_set_ctrl_limits(ns->ctrl, &lim);
+	nvme_set_ctrl_limits(ns->ctrl, &lim, false);
 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm, info);
 	nvme_set_chunk_sectors(ns, id, &lim);
 	if (!nvme_update_disk_info(ns, id, &lim))
@@ -3589,7 +3589,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctr=
l)
 		min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
=20
 	lim =3D queue_limits_start_update(ctrl->admin_q);
-	nvme_set_ctrl_limits(ctrl, &lim);
+	nvme_set_ctrl_limits(ctrl, &lim, true);
 	ret =3D queue_limits_commit_update(ctrl->admin_q, &lim);
 	if (ret)
 		goto out_free;
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 1b58ee7d0dcee..caf5503d08332 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -217,6 +217,12 @@ static inline unsigned int nvmf_nr_io_queues(struct =
nvmf_ctrl_options *opts)
 		min(opts->nr_poll_queues, num_online_cpus());
 }
=20
+static inline unsigned long nvmf_get_virt_boundary(struct nvme_ctrl *ctr=
l,
+						   bool is_admin)
+{
+	return 0;
+}
+
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 03987f497a5b5..70c066c2e2d42 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3360,6 +3360,7 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops =
=3D {
 	.submit_async_event	=3D nvme_fc_submit_async_event,
 	.delete_ctrl		=3D nvme_fc_delete_ctrl,
 	.get_address		=3D nvmf_get_address,
+	.get_virt_boundary	=3D nvmf_get_virt_boundary,
 };
=20
 static void
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 102fae6a231c5..7f7cb823d60d8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -558,6 +558,12 @@ static inline bool nvme_ns_has_pi(struct nvme_ns_hea=
d *head)
 	return head->pi_type && head->ms =3D=3D head->pi_size;
 }
=20
+static inline unsigned long nvme_get_virt_boundary(struct nvme_ctrl *ctr=
l,
+						   bool is_admin)
+{
+	return NVME_CTRL_PAGE_SIZE - 1;
+}
+
 struct nvme_ctrl_ops {
 	const char *name;
 	struct module *module;
@@ -578,6 +584,7 @@ struct nvme_ctrl_ops {
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 	void (*print_device_info)(struct nvme_ctrl *ctrl);
 	bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
+	unsigned long (*get_virt_boundary)(struct nvme_ctrl *ctrl, bool is_admi=
n);
 };
=20
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c916176bd9f05..3c1727df1e36f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -613,9 +613,22 @@ static inline enum nvme_use_sgl nvme_pci_use_sgls(st=
ruct nvme_dev *dev,
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
=20
 	if (nvmeq->qid && nvme_ctrl_sgl_supported(&dev->ctrl)) {
-		if (nvme_req(req)->flags & NVME_REQ_USERCMD)
-			return SGL_FORCED;
-		if (req->nr_integrity_segments > 1)
+		/*
+		 * When the controller is capable of using SGL, there are
+		 * several conditions that we force to use it:
+		 *
+		 * 1. A request containing page gaps within the controller's
+		 *    mask can not use the PRP format.
+		 *
+		 * 2. User commands use SGL because that lets the device
+		 *    validate the requested transfer lengths.
+		 *
+		 * 3. Multiple integrity segments must use SGL as that's the
+		 *    only way to describe such a command in NVMe.
+		 */
+		if (req_phys_gap_mask(req) & (NVME_CTRL_PAGE_SIZE - 1) ||
+		    nvme_req(req)->flags & NVME_REQ_USERCMD ||
+		    req->nr_integrity_segments > 1)
 			return SGL_FORCED;
 		return SGL_SUPPORTED;
 	}
@@ -3243,6 +3256,14 @@ static bool nvme_pci_supports_pci_p2pdma(struct nv=
me_ctrl *ctrl)
 	return dma_pci_p2pdma_supported(dev->dev);
 }
=20
+static unsigned long nvme_pci_get_virt_boundary(struct nvme_ctrl *ctrl,
+						bool is_admin)
+{
+	if (!nvme_ctrl_sgl_supported(ctrl) || is_admin)
+		return NVME_CTRL_PAGE_SIZE - 1;
+	return 0;
+}
+
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops =3D {
 	.name			=3D "pcie",
 	.module			=3D THIS_MODULE,
@@ -3257,6 +3278,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops=
 =3D {
 	.get_address		=3D nvme_pci_get_address,
 	.print_device_info	=3D nvme_pci_print_device_info,
 	.supports_pci_p2pdma	=3D nvme_pci_supports_pci_p2pdma,
+	.get_virt_boundary	=3D nvme_pci_get_virt_boundary,
 };
=20
 static int nvme_dev_map(struct nvme_dev *dev)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 190a4cfa8a5ee..35c0822edb2d7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2202,6 +2202,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_op=
s =3D {
 	.delete_ctrl		=3D nvme_rdma_delete_ctrl,
 	.get_address		=3D nvmf_get_address,
 	.stop_ctrl		=3D nvme_rdma_stop_ctrl,
+	.get_virt_boundary	=3D nvme_get_virt_boundary,
 };
=20
 /*
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1413788ca7d52..82875351442a0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2862,6 +2862,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops=
 =3D {
 	.delete_ctrl		=3D nvme_tcp_delete_ctrl,
 	.get_address		=3D nvme_tcp_get_address,
 	.stop_ctrl		=3D nvme_tcp_stop_ctrl,
+	.get_virt_boundary	=3D nvmf_get_virt_boundary,
 };
=20
 static bool
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index f85a8441bcc6e..9fe88a489eb71 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -511,6 +511,7 @@ static const struct nvme_ctrl_ops nvme_loop_ctrl_ops =
=3D {
 	.submit_async_event	=3D nvme_loop_submit_async_event,
 	.delete_ctrl		=3D nvme_loop_delete_ctrl_host,
 	.get_address		=3D nvmf_get_address,
+	.get_virt_boundary	=3D nvme_get_virt_boundary,
 };
=20
 static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
--=20
2.47.3


