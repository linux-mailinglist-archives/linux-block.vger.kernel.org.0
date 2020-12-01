Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACBA2C9657
	for <lists+linux-block@lfdr.de>; Tue,  1 Dec 2020 05:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgLAEPn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 Nov 2020 23:15:43 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:49045 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgLAEPn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 23:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606796142; x=1638332142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IbhFgyygJ5NSmgqlsuEUA8KxxUfUDKGG9QcwKU4tpWE=;
  b=VJNb8aM+jmCE35cqV4hZluLy6oC1AsYp7TGSO9kXtzLc3w7TqJRSgKnX
   f5NgSHBVl28QobEEmqOvA1hLw06MJYa90iVVxozPzIsidlIZBiMCoJ/u4
   aOXycTxVqttw26zN2mKni2vYAReMyRa3Eqlsbv6xyX8/SrHYW4Fxy4ZBT
   /Srkh8n7ve9KZ/tT7PQI0gOlleXCIVRdl4DIBZgcB4wJVfmJI1d8dbmII
   KEr4CsR13Nzegq3U86kc9mb8DaJ5OsKuQwFGEKHj8+8hLK8IgC95Vnqn1
   VurfJNV7BBU58U0ctocb+lgxB9SLWjtftvWtNznhIS1y+Zsm07T6M20KG
   A==;
IronPort-SDR: 8sZ9bg4PKcJCQfOSpdrx1C+1LEwUN910C/iX/eRqKi1HKIaFEIAZKe42uveQhnfcvwQXtWwi94
 aUI92dfzt5r8Ajzn+IM6+VrWgph4wrD9gd4c8rAAKVtI8aYtprcaEj7JaPZWmGbXNHb1nApI/B
 wUy4mWaidfdtpRFZoQRq2hYdz67pjcd1zyI9RVb1Z4iGI8bChrQjegMVYqLAzHETHOcs4ZFvlq
 EWaaZS7kX9ZCP25jghIcBymXt6TsNAIL6V93vyD+bSpqLszHYPHTnc2QY1IpT912uwaAzaM3PE
 hg8=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; 
   d="scan'208";a="153948667"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:14:36 +0800
IronPort-SDR: Micm1bsTh5Iezi7o52iZKSHYawHyIZiIhgTjIRWe2u2TVzGAoBIrdyxSUnz/fE7sFkZ3i98y4t
 ladsOfBcVlAOMYB5dnD9uaa/Oe0XqI7I0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 19:58:49 -0800
IronPort-SDR: 7LFTu6WLrrCxENQ1Fh9Ynx4Ti5F/VSoeX7Fw4+wD27LffDAjfBsUXcOBtRwPyF9b9KodeYlb17
 5dEwlhTOZMsQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:14:37 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 2/9] nvmet: add ZNS support for bdev-ns
Date:   Mon, 30 Nov 2020 20:14:09 -0800
Message-Id: <20201201041416.16293-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
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
 drivers/nvme/target/Makefile      |   2 +-
 drivers/nvme/target/admin-cmd.c   |   4 +-
 drivers/nvme/target/io-cmd-file.c |   2 +-
 drivers/nvme/target/nvmet.h       |  19 ++
 drivers/nvme/target/zns.c         | 426 ++++++++++++++++++++++++++++++
 5 files changed, 449 insertions(+), 4 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index ebf91fc4c72e..d050f829b43a 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
 obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
-			discovery.o io-cmd-file.o io-cmd-bdev.o
+		   zns.o discovery.o io-cmd-file.o io-cmd-bdev.o
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
 nvme-loop-y	+= loop.o
 nvmet-rdma-y	+= rdma.o
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
index 592763732065..eee7866ae512 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -81,6 +81,10 @@ struct nvmet_ns {
 	struct pci_dev		*p2p_dev;
 	int			pi_type;
 	int			metadata_size;
+#ifdef CONFIG_BLK_DEV_ZONED
+	struct nvme_id_ns_zns	id_zns;
+	unsigned int		zasl;
+#endif
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
@@ -251,6 +255,10 @@ struct nvmet_subsys {
 	unsigned int		admin_timeout;
 	unsigned int		io_timeout;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
+
+#ifdef CONFIG_BLK_DEV_ZONED
+	struct nvme_id_ctrl_zns	id_ctrl_zns;
+#endif
 };
 
 static inline struct nvmet_subsys *to_subsys(struct config_item *item)
@@ -603,4 +611,15 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
 	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
 }
 
+void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
+void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
+u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off);
+bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
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
index 000000000000..f6927f7ef4d2
--- /dev/null
+++ b/drivers/nvme/target/zns.c
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe ZNS-ZBD command implementation.
+ * Copyright (c) 2020-2021 HGST, a Western Digital Company.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/uio.h>
+#include <linux/nvme.h>
+#include <linux/xarray.h>
+#include <linux/blkdev.h>
+#include <linux/module.h>
+#include "nvmet.h"
+
+#ifdef CONFIG_BLK_DEV_ZONED
+#define NVMET_MPSMIN_SHIFT	12
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
+static inline struct block_device *nvmet_bdev(struct nvmet_req *req)
+{
+	return req->ns->bdev;
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
+ *  ZNS related command implementation and helpers.
+ */
+
+u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
+{
+	u16 nvme_cis_zns = NVME_CSI_ZNS;
+
+	if (!bdev_is_zoned(nvmet_bdev(req)))
+		return NVME_SC_SUCCESS;
+
+	return nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, NVME_NIDT_CSI_LEN,
+					&nvme_cis_zns, off);
+}
+
+void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)
+{
+	log->iocs[nvme_cmd_zone_append]		= cpu_to_le32(1 << 0);
+	log->iocs[nvme_cmd_zone_mgmt_send]	= cpu_to_le32(1 << 0);
+	log->iocs[nvme_cmd_zone_mgmt_recv]	= cpu_to_le32(1 << 0);
+}
+
+static inline bool nvmet_bdev_validate_zns_zones(struct nvmet_ns *ns)
+{
+	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {
+		pr_err("block devices with conventional zones are not supported.");
+		return false;
+	}
+
+	return !(get_capacity(ns->bdev->bd_disk) &
+			(bdev_zone_sectors(ns->bdev) - 1));
+}
+
+static inline u8 nvmet_zasl(unsigned int zone_append_sects)
+{
+	/*
+	 * Zone Append Size Limit is the value experessed in the units
+	 * of minimum memory page size (i.e. 12) and is reported power of 2.
+	 */
+	return ilog2((zone_append_sects << 9) >> NVMET_MPSMIN_SHIFT);
+}
+
+static inline void nvmet_zns_update_zasl(struct nvmet_ns *ns)
+{
+	u8 bio_max_zasl = nvmet_zasl((BIO_MAX_PAGES * PAGE_SIZE) >> 9);
+	struct request_queue *q = ns->bdev->bd_disk->queue;
+	struct nvmet_ns *ins;
+	unsigned long idx;
+	u8 min_zasl;
+
+	/*
+	 * Calculate new ctrl->zasl value when enabling the new ns. This value
+	 * has to be the minimum of the max_zone_append values from available
+	 * namespaces.
+	 */
+	min_zasl = ns->zasl = nvmet_zasl(queue_max_zone_append_sectors(q));
+
+	xa_for_each(&(ns->subsys->namespaces), idx, ins) {
+		struct request_queue *iq = ins->bdev->bd_disk->queue;
+		unsigned int imax_za_sects = queue_max_zone_append_sectors(iq);
+		u8 izasl = nvmet_zasl(imax_za_sects);
+
+		if (!bdev_is_zoned(ins->bdev))
+			continue;
+
+		min_zasl = min_zasl > izasl ? izasl : min_zasl;
+	}
+
+	ns->subsys->id_ctrl_zns.zasl = min_t(u8, min_zasl, bio_max_zasl);
+}
+
+bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
+{
+	if (!nvmet_bdev_validate_zns_zones(ns))
+		return false;
+
+	/*
+	 * For ZBC and ZAC devices, writes into sequential zones must be aligned
+	 * to the device physical block size. So use this value as the logical
+	 * block size to avoid errors.
+	 */
+	ns->blksize_shift = blksize_bits(bdev_physical_block_size(ns->bdev));
+
+	nvmet_zns_update_zasl(ns);
+
+	return true;
+}
+
+/*
+ * ZNS related Admin and I/O command handlers.
+ */
+void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
+{
+	u8 zasl = req->sq->ctrl->subsys->id_ctrl_zns.zasl;
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvme_id_ctrl_zns *id;
+	u16 status;
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	if (ctrl->ops->get_mdts)
+		id->zasl = min_t(u8, ctrl->ops->get_mdts(ctrl), zasl);
+	else
+		id->zasl = zasl;
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
+struct nvmet_report_zone_data {
+	struct nvmet_ns *ns;
+	struct nvme_zone_report *rz;
+};
+
+static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned int idx,
+				     void *data)
+{
+	struct nvmet_report_zone_data *report_zone_data = data;
+	struct nvme_zone_descriptor *entries = report_zone_data->rz->entries;
+	struct nvmet_ns *ns = report_zone_data->ns;
+
+	entries[idx].zcap = cpu_to_le64(nvmet_sect_to_lba(ns, z->capacity));
+	entries[idx].zslba = cpu_to_le64(nvmet_sect_to_lba(ns, z->start));
+	entries[idx].wp = cpu_to_le64(nvmet_sect_to_lba(ns, z->wp));
+	entries[idx].za = z->reset ? 1 << 2 : 0;
+	entries[idx].zt = z->type;
+	entries[idx].zs = z->cond << 4;
+
+	return 0;
+}
+
+void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
+{
+	u64 bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
+	struct nvmet_report_zone_data data = { .ns = req->ns };
+	struct nvme_zone_mgmt_recv_cmd *zmr = &req->cmd->zmr;
+	sector_t sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(zmr->slba));
+	unsigned int nr_zones;
+	int reported_zones;
+	u16 status;
+
+	nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
+			sizeof(struct nvme_zone_descriptor);
+
+	status = nvmet_bdev_zns_checks(req);
+	if (status)
+		goto out;
+
+	data.rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
+	if (!data.rz) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	reported_zones = blkdev_report_zones(nvmet_bdev(req), sect, nr_zones,
+					     nvmet_bdev_report_zone_cb,
+					     &data);
+	if (reported_zones < 0) {
+		status = NVME_SC_INTERNAL;
+		goto out_free_report_zones;
+	}
+
+	data.rz->nr_zones = cpu_to_le64(reported_zones);
+
+	status = nvmet_copy_to_sgl(req, 0, data.rz, bufsize);
+
+out_free_report_zones:
+	kvfree(data.rz);
+out:
+	nvmet_req_complete(req, status);
+}
+
+void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
+{
+	sector_t nr_sect = bdev_zone_sectors(nvmet_bdev(req));
+	struct nvme_zone_mgmt_send_cmd *c = &req->cmd->zms;
+	enum req_opf op = REQ_OP_LAST;
+	u16 status = NVME_SC_SUCCESS;
+	sector_t sect;
+	int ret;
+
+	sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zms.slba));
+
+	if (c->select_all)
+		nr_sect = get_capacity(nvmet_bdev(req)->bd_disk);
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
+		op = REQ_OP_ZONE_RESET;
+		break;
+	default:
+		status = NVME_SC_INVALID_FIELD;
+		goto out;
+	}
+
+	ret = blkdev_zone_mgmt(nvmet_bdev(req), op, sect, nr_sect, GFP_KERNEL);
+	if (ret)
+		status = NVME_SC_INTERNAL;
+
+out:
+	nvmet_req_complete(req, status);
+}
+
+void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
+{
+	unsigned long bv_cnt = req->sg_cnt;
+	u64 slba = le64_to_cpu(req->cmd->rw.slba);
+	sector_t sect = nvmet_lba_to_sect(req->ns, slba);
+	u16 status = NVME_SC_SUCCESS;
+	size_t mapped_data_len = 0;
+	int sg_cnt = req->sg_cnt;
+	struct scatterlist *sg;
+	struct iov_iter from;
+	struct bio_vec *bvec;
+	size_t mapped_cnt;
+	struct bio *bio;
+	int ret;
+
+	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
+		return;
+
+	/*
+	 * When setting the ctrl->zasl we consider the BIO_MAX_PAGES so that we
+	 * don't have to split the bio, i.e. we shouldn't get
+	 * sg_cnt > BIO_MAX_PAGES since zasl on the host will limit the I/Os
+	 * with the size that considers the BIO_MAX_PAGES.
+	 */
+	if (!req->sg_cnt)
+		goto out;
+
+	if (WARN_ON(req->sg_cnt > BIO_MAX_PAGES)) {
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		goto out;
+	}
+
+	bvec = kmalloc_array(bv_cnt, sizeof(*bvec), GFP_KERNEL);
+	if (!bvec) {
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		goto out;
+	}
+
+	for_each_sg(req->sg, sg, req->sg_cnt, mapped_cnt) {
+		nvmet_file_init_bvec(bvec, sg);
+		mapped_data_len += bvec[mapped_cnt].bv_len;
+		sg_cnt--;
+		if (mapped_cnt == bv_cnt)
+			break;
+	}
+
+	if (WARN_ON(sg_cnt)) {
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		goto out;
+	}
+
+	iov_iter_bvec(&from, WRITE, bvec, mapped_cnt, mapped_data_len);
+
+	bio = bio_alloc(GFP_KERNEL, bv_cnt);
+	bio_set_dev(bio, nvmet_bdev(req));
+	bio->bi_iter.bi_sector = sect;
+	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
+
+	ret =  __bio_iov_append_get_pages(bio, &from);
+	if (unlikely(ret)) {
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		bio_io_error(bio);
+		goto bvec_free;
+	}
+
+	ret = submit_bio_wait(bio);
+	status = ret < 0 ? NVME_SC_INTERNAL : status;
+	bio_put(bio);
+
+	sect += (mapped_data_len >> 9);
+	req->cqe->result.u64 = le64_to_cpu(nvmet_sect_to_lba(req->ns, sect));
+
+bvec_free:
+	kfree(bvec);
+
+out:
+	nvmet_req_complete(req, status);
+}
+
+#else  /* CONFIG_BLK_DEV_ZONED */
+void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
+{
+}
+void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
+{
+}
+u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
+{
+	return 0;
+}
+bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
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

