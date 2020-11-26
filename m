Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26342C4D7F
	for <lists+linux-block@lfdr.de>; Thu, 26 Nov 2020 03:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbgKZClQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Nov 2020 21:41:16 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45495 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbgKZClQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 21:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606358474; x=1637894474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bj+OLadrv7uucl7Q6fHZQHG1Z7SFerHgqVQw5Hdo1u8=;
  b=KJbRFEixaJEb67vJcEI+7N62cLtxDscyuN6txVhaFqfcBlANQE1pMsyP
   xBNBBY9DQSMo8+fZmvSvAoSRvtsvijm3AFDowxUtovrIwlEYbOrw8t+99
   QNvWGesPyvvd79KihVp6eAhpeo6Mf9ZiTdBq8HXvd1c+FIgeMC6nMjMCw
   pty/vBxqCBhLSyiN26pdfN9alsHLCpkMUp8fXZaHqC/MYSZ6RV2nVimby
   /qtX5P8NoaSV0eEyFRGXYo8INwdeQKvVLqw7jJzSyIKcSzQput+ZVnwc1
   kxI8NY2SolpUTCpGoPlf8D9+WQAswg0KaS5cfw7oWPOMfFYWhTKFayvTM
   w==;
IronPort-SDR: 7NRx/MNbLAWbDiX1rPRS41i3x2kRQSH+kzRVeur9jJ9uqG3sNUp2e665cvd2aQOpIkej0hyfid
 1npKVDSxfsMSwE5BGx8j40LgnwRXJx7vZozsZmS/JeiQLQMKlfHb5eR0758igi4CkKY6M60Ktr
 mWBfa5rhQV3Zobq5t1cnw8E9wkSUFGdTLHvkcVvvthACM1ugQg6MaBOXEv7gs+c+BqFA0vw3tb
 9GtTKouPtOIbzxp2+vDCNUaMyzbWxLWLf4fcg/upcgpq2H4T5wUnLUJ69QQbuyJCsYvnrz8oeJ
 aDg=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; 
   d="scan'208";a="153586884"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:41:14 +0800
IronPort-SDR: OsoEuUFYjXnzC5BUj89iajDnuSrJk1tzqB7kAU8T9Bjwam1ckxhWmH7MSKfpQvTkJr0xknvu3D
 4TxUkM3Q3mev1CmaRPOnw258SfLjOfA60=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 18:25:36 -0800
IronPort-SDR: Lsdo+gCqBB7U8I7HbmK58L0aKroRVMB9b/khpdUBm0RQn8ry35SK1L1gyV7JGOeK/J04fas6lB
 DGHJ+vfigRyQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:41:14 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Date:   Wed, 25 Nov 2020 18:40:36 -0800
Message-Id: <20201126024043.3392-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add zns-bdev-config, id-ctrl, id-ns, zns-cmd-effects, zone-mgmt-send,
zone-mgmt-recv and zone-append handlers for NVMeOF target to enable ZNS
support for bdev.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/Makefile      |   2 +
 drivers/nvme/target/admin-cmd.c   |   4 +-
 drivers/nvme/target/io-cmd-file.c |   2 +-
 drivers/nvme/target/nvmet.h       |  18 ++
 drivers/nvme/target/zns.c         | 390 ++++++++++++++++++++++++++++++
 5 files changed, 413 insertions(+), 3 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index ebf91fc4c72e..bc147ff2df5d 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -12,6 +12,8 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
 			discovery.o io-cmd-file.o io-cmd-bdev.o
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
+nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
+
 nvme-loop-y	+= loop.o
 nvmet-rdma-y	+= rdma.o
 nvmet-fc-y	+= fc.o
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index dca34489a1dc..509fd8dcca0c 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -579,8 +579,8 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
-				    void *id, off_t *off)
+u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
+			     void *id, off_t *off)
 {
 	struct nvme_ns_id_desc desc = {
 		.nidt = type,
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0abbefd9925e..2bd10960fa50 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -89,7 +89,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	return ret;
 }
 
-static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
+void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
 {
 	bv->bv_page = sg_page(sg);
 	bv->bv_offset = sg->offset;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 592763732065..0542ba672a31 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -81,6 +81,9 @@ struct nvmet_ns {
 	struct pci_dev		*p2p_dev;
 	int			pi_type;
 	int			metadata_size;
+#ifdef CONFIG_BLK_DEV_ZONED
+	struct nvme_id_ns_zns	id_zns;
+#endif
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
@@ -251,6 +254,10 @@ struct nvmet_subsys {
 	unsigned int		admin_timeout;
 	unsigned int		io_timeout;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
+
+#ifdef CONFIG_BLK_DEV_ZONED
+	struct nvme_id_ctrl_zns	id_ctrl_zns;
+#endif
 };
 
 static inline struct nvmet_subsys *to_subsys(struct config_item *item)
@@ -603,4 +610,15 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
 	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
 }
 
+void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
+void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
+u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off);
+bool nvmet_bdev_zns_config(struct nvmet_ns *ns);
+void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
+void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
+void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
+void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log);
+u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
+			     void *id, off_t *off);
+void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg);
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
new file mode 100644
index 000000000000..8ea6641a55e3
--- /dev/null
+++ b/drivers/nvme/target/zns.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe ZNS-ZBD command implementation.
+ * Copyright (c) 2020-2021 HGST, a Western Digital Company.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/uio.h>
+#include <linux/nvme.h>
+#include <linux/blkdev.h>
+#include <linux/module.h>
+#include "nvmet.h"
+
+#ifdef CONFIG_BLK_DEV_ZONED
+
+static u16 nvmet_bdev_zns_checks(struct nvmet_req *req)
+{
+	u16 status = 0;
+
+	if (!bdev_is_zoned(req->ns->bdev)) {
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		goto out;
+	}
+
+	if (req->cmd->zmr.zra != NVME_ZRA_ZONE_REPORT) {
+		status = NVME_SC_INVALID_FIELD;
+		goto out;
+	}
+
+	if (req->cmd->zmr.zrasf != NVME_ZRASF_ZONE_REPORT_ALL) {
+		status = NVME_SC_INVALID_FIELD;
+		goto out;
+	}
+
+	if (req->cmd->zmr.pr != NVME_REPORT_ZONE_PARTIAL)
+		status = NVME_SC_INVALID_FIELD;
+out:
+	return status;
+}
+
+static struct block_device *nvmet_bdev(struct nvmet_req *req)
+{
+	return req->ns->bdev;
+}
+
+static u64 nvmet_zones_to_descsize(unsigned int nr_zones)
+{
+	return sizeof(struct nvme_zone_report) +
+		(sizeof(struct nvme_zone_descriptor) * nr_zones);
+}
+
+static inline u64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)
+{
+	return sect >> (ns->blksize_shift - SECTOR_SHIFT);
+}
+
+static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
+{
+	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
+}
+
+/*
+ *  ZNS related command implementation and helprs.
+ */
+
+u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
+{
+	u16 nvme_cis_zns = NVME_CSI_ZNS;
+
+	if (bdev_is_zoned(nvmet_bdev(req))) {
+		return nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
+						 NVME_NIDT_CSI_LEN,
+						 &nvme_cis_zns, off);
+	}
+
+	return NVME_SC_SUCCESS;
+}
+
+void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)
+{
+	log->iocs[nvme_cmd_zone_append]		= cpu_to_le32(1 << 0);
+	log->iocs[nvme_cmd_zone_mgmt_send]	= cpu_to_le32(1 << 0);
+	log->iocs[nvme_cmd_zone_mgmt_recv]	= cpu_to_le32(1 << 0);
+}
+
+bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
+{
+	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {
+		pr_err("block device with conventional zones not supported.");
+		return false;
+	}
+	/*
+	 * SMR drives will results in error if writes are not aligned to the
+	 * physical block size just override.
+	 */
+	ns->blksize_shift = blksize_bits(bdev_physical_block_size(ns->bdev));
+	return true;
+}
+
+static int nvmet_bdev_report_zone_cb(struct blk_zone *zone, unsigned int idx,
+				     void *data)
+{
+	struct blk_zone *zones = data;
+
+	memcpy(&zones[idx], zone, sizeof(struct blk_zone));
+
+	return 0;
+}
+
+static void nvmet_get_zone_desc(struct nvmet_ns *ns, struct blk_zone *z,
+				struct nvme_zone_descriptor *rz)
+{
+	rz->zcap = cpu_to_le64(nvmet_sect_to_lba(ns, z->capacity));
+	rz->zslba = cpu_to_le64(nvmet_sect_to_lba(ns, z->start));
+	rz->wp = cpu_to_le64(nvmet_sect_to_lba(ns, z->wp));
+	rz->za = z->reset ? 1 << 2 : 0;
+	rz->zt = z->type;
+	rz->zs = z->cond << 4;
+}
+
+/*
+ * ZNS related Admin and I/O command handlers.
+ */
+void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
+{
+	struct nvme_id_ctrl_zns *id;
+	u16 status = 0;
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	/*
+	 * Even though this function sets Zone Append Size Limit to 0,
+	 * the 0 value here indicates that the maximum data transfer size for
+	 * the Zone Append command is indicated by the ctrl
+	 * Maximum Data Transfer Size (MDTS).
+	 */
+	id->zasl = 0;
+
+	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+
+	kfree(id);
+out:
+	nvmet_req_complete(req, status);
+}
+
+void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
+{
+	struct nvme_id_ns_zns *id_zns;
+	u16 status = 0;
+	u64 zsze;
+
+	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
+		req->error_loc = offsetof(struct nvme_identify, nsid);
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		goto out;
+	}
+
+	id_zns = kzalloc(sizeof(*id_zns), GFP_KERNEL);
+	if (!id_zns) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
+	if (!req->ns) {
+		status = NVME_SC_INTERNAL;
+		goto done;
+	}
+
+	if (!bdev_is_zoned(nvmet_bdev(req))) {
+		req->error_loc = offsetof(struct nvme_identify, nsid);
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		goto done;
+	}
+
+	nvmet_ns_revalidate(req->ns);
+	zsze = (bdev_zone_sectors(nvmet_bdev(req)) << 9) >>
+					req->ns->blksize_shift;
+	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
+	id_zns->mor = cpu_to_le32(bdev_max_open_zones(nvmet_bdev(req)));
+	id_zns->mar = cpu_to_le32(bdev_max_active_zones(nvmet_bdev(req)));
+
+done:
+	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
+	kfree(id_zns);
+out:
+	nvmet_req_complete(req, status);
+}
+
+void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
+{
+	struct request_queue *q = nvmet_bdev(req)->bd_disk->queue;
+	struct nvme_zone_mgmt_recv_cmd *zmr = &req->cmd->zmr;
+	unsigned int nz = blk_queue_nr_zones(q);
+	u64 bufsize = (zmr->numd << 2) + 1;
+	struct nvme_zone_report *rz;
+	struct blk_zone *zones;
+	int reported_zones;
+	sector_t sect;
+	u64 desc_size;
+	u16 status;
+	int i;
+
+	desc_size = nvmet_zones_to_descsize(blk_queue_nr_zones(q));
+	status = nvmet_bdev_zns_checks(req);
+	if (status)
+		goto out;
+
+	zones = kvcalloc(blkdev_nr_zones(nvmet_bdev(req)->bd_disk),
+			      sizeof(struct blk_zone), GFP_KERNEL);
+	if (!zones) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
+	if (!rz) {
+		status = NVME_SC_INTERNAL;
+		goto out_free_zones;
+	}
+
+	sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zmr.slba));
+
+	for (nz = blk_queue_nr_zones(q); desc_size >= bufsize; nz--)
+		desc_size = nvmet_zones_to_descsize(nz);
+
+	reported_zones = blkdev_report_zones(nvmet_bdev(req), sect, nz,
+					     nvmet_bdev_report_zone_cb,
+					     zones);
+	if (reported_zones < 0) {
+		status = NVME_SC_INTERNAL;
+		goto out_free_report_zones;
+	}
+
+	rz->nr_zones = cpu_to_le64(reported_zones);
+	for (i = 0; i < reported_zones; i++)
+		nvmet_get_zone_desc(req->ns, &zones[i], &rz->entries[i]);
+
+	status = nvmet_copy_to_sgl(req, 0, rz, bufsize);
+
+out_free_report_zones:
+	kvfree(rz);
+out_free_zones:
+	kvfree(zones);
+out:
+	nvmet_req_complete(req, status);
+}
+
+void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
+{
+	sector_t nr_sect = bdev_zone_sectors(nvmet_bdev(req));
+	struct nvme_zone_mgmt_send_cmd *c = &req->cmd->zms;
+	u16 status = NVME_SC_SUCCESS;
+	enum req_opf op;
+	sector_t sect;
+	int ret;
+
+	sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zms.slba));
+
+	switch (c->zsa) {
+	case NVME_ZONE_OPEN:
+		op = REQ_OP_ZONE_OPEN;
+		break;
+	case NVME_ZONE_CLOSE:
+		op = REQ_OP_ZONE_CLOSE;
+		break;
+	case NVME_ZONE_FINISH:
+		op = REQ_OP_ZONE_FINISH;
+		break;
+	case NVME_ZONE_RESET:
+		if (c->select_all)
+			nr_sect = get_capacity(nvmet_bdev(req)->bd_disk);
+		op = REQ_OP_ZONE_RESET;
+		break;
+	default:
+		status = NVME_SC_INVALID_FIELD;
+		break;
+	}
+
+	ret = blkdev_zone_mgmt(nvmet_bdev(req), op, sect, nr_sect, GFP_KERNEL);
+	if (ret)
+		status = NVME_SC_INTERNAL;
+
+	nvmet_req_complete(req, status);
+}
+
+void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
+{
+	unsigned long bv_cnt = min(req->sg_cnt, BIO_MAX_PAGES);
+	int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
+	u64 slba = le64_to_cpu(req->cmd->rw.slba);
+	sector_t sect = nvmet_lba_to_sect(req->ns, slba);
+	u16 status = NVME_SC_SUCCESS;
+	int sg_cnt = req->sg_cnt;
+	struct scatterlist *sg;
+	size_t mapped_data_len;
+	struct iov_iter from;
+	struct bio_vec *bvec;
+	size_t mapped_cnt;
+	size_t io_len = 0;
+	struct bio *bio;
+	int ret;
+
+	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
+		return;
+
+	if (!req->sg_cnt) {
+		nvmet_req_complete(req, 0);
+		return;
+	}
+
+	bvec = kmalloc_array(bv_cnt, sizeof(*bvec), GFP_KERNEL);
+	if (!bvec) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	while (sg_cnt) {
+		mapped_data_len = 0;
+		for_each_sg(req->sg, sg, req->sg_cnt, mapped_cnt) {
+			nvmet_file_init_bvec(bvec, sg);
+			mapped_data_len += bvec[mapped_cnt].bv_len;
+			sg_cnt--;
+			if (mapped_cnt == bv_cnt)
+				break;
+		}
+		iov_iter_bvec(&from, WRITE, bvec, mapped_cnt, mapped_data_len);
+
+		bio = bio_alloc(GFP_KERNEL, bv_cnt);
+		bio_set_dev(bio, nvmet_bdev(req));
+		bio->bi_iter.bi_sector = sect;
+		bio->bi_opf = op;
+
+		ret =  __bio_iov_append_get_pages(bio, &from);
+		if (unlikely(ret)) {
+			status = NVME_SC_INTERNAL;
+			bio_io_error(bio);
+			kfree(bvec);
+			goto out;
+		}
+
+		ret = submit_bio_wait(bio);
+		bio_put(bio);
+		if (ret < 0) {
+			status = NVME_SC_INTERNAL;
+			break;
+		}
+
+		io_len += mapped_data_len;
+	}
+
+	sect += (io_len >> 9);
+	req->cqe->result.u64 = le64_to_cpu(nvmet_sect_to_lba(req->ns, sect));
+	kfree(bvec);
+
+out:
+	nvmet_req_complete(req, status);
+}
+
+#else  /* CONFIG_BLK_DEV_ZONED */
+static void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
+{
+}
+static void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
+{
+}
+u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
+{
+	return 0;
+}
+static bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
+{
+	return false;
+}
+void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
+{
+}
+void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
+{
+}
+void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
+{
+}
+void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)
+{
+}
+#endif /* CONFIG_BLK_DEV_ZONED */
-- 
2.22.1

