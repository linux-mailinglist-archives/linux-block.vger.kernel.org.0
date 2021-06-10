Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F2E3A21E1
	for <lists+linux-block@lfdr.de>; Thu, 10 Jun 2021 03:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFJBfi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Jun 2021 21:35:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55838 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJBfi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 21:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623288822; x=1654824822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VIiLzpu1XoCMgkdmdQoLdsnmUvPxPgfjGfGyp4fK9ak=;
  b=hCknM7XlTe5yivz1IHBnbpv8qthR/DQweX16seZHt3KGMoQdv4B/duwS
   5uZ3m1MkUXhbyohu1AsWqTJQhE/YbMRIhVtoFvYnG3Aw8Q7fSTWB4cL3W
   EaX9YdiS7a2fTDlf88qSWhrghFfqzp8JEyZFhNQhxPaKEe3V2WXR52PcM
   SnsYNKFImw9Gr6v4bovjyFE9ofjTpgxowNeVnibjHt1jNpBQVonlh/vSY
   V2x8gQwgS+d/DsB97n0g56pVUQ6tdSFrvsrCbZvXTXiLjDa+7p1v4mxws
   tDkjxamRA0wJq7ArWvodZ9CO8cL/gswURJ43SdK8h2pwqT4PxUNj3lON8
   w==;
IronPort-SDR: ZaERWv2BeRwMUtUE0TDhU5jFkm9l6mIqAMx6KYRIGOo/2Nx7oqodoOa/J8K6ZwpeALQUiBFx3m
 VYt2GUJW9zx9EcuZdulv9fpkuDCn0/pHMsRIZDG/Ut+Dca/jtZ9KGX9n1GEwntnCx2NMtVNHHy
 qTNj7UPAqQ9AxATzLdxukYPmORz6hk61aTPFsB9lpfrWGzJ8opWxh4aM8AzgPB8Z50ra6G35Aq
 9uK+nCzaX+aO/y6gxx3P+wPpYEGF0uNMO4RV7MGtWoMrjp2Fug9R0V+F8piU5Bdo6KUNa+9ywO
 aeU=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="171382314"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 09:33:42 +0800
IronPort-SDR: cCw619L0fAFcVC3C6eWBw6X2v7jMhJuEU8ywvf4+OaVjQcEFq3dpaw1QWIFveIfiKQR+hGzlk/
 j0SXKgGfnCJy8L0Dq5hAky3uDyz0k+ryM9jJleLDegU7YtLwidI0k695gHtatCHj9uCPsB445w
 Wa1XGsGUhRRXuCejzxX8Cg624UAdinXSvwKj0xFH5p7+02EM1/b7YyZn/15qvEuYu2PgRI+Fep
 CeTtI/Hh16GQMTTboAD4WaYLCe01EsNE+RIQ4mr0S3iZ2PqpQ8QH64asDs+XbJgTPFaFAXwGDP
 dWtMa1GLla8aGrMzVDTuhTid
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 18:11:21 -0700
IronPort-SDR: Vc8VAeItGdXKOnJERnspH1iKO1J8qWtcSH0fgxExSw/U3Ww1nAlYZGUf5C4IQTxLv/blOFhWnC
 N4GlS7MPUAEmSalRey6mNADMY5+I9cm7Bs+Ffvze6IXVL2CHo3tkc0ydU3HMM4hpCXtrh7dPkN
 QvfYdgIeR7IkOMxVrJa6H3HGl4Xl15ECzO2idfvtRaqKJPAGs0aAEn2sInJDb843/lXiYv3gQ+
 vlHHaM3AFJOFmB6Wn0mcjGYb14vtDg6j+yx/zokWgxTu9jSN/8cnkwKbK8gta5tAoHoC5ds8Hl
 e6c=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jun 2021 18:33:43 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     axboe@kernel.dk, sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH V15 5/5] nvmet: add ZBD over ZNS backend support
Date:   Wed,  9 Jun 2021 18:32:52 -0700
Message-Id: <20210610013252.53874-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
References: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVMe TP 4053 – Zoned Namespaces (ZNS) allows host software to
communicate with a non-volatile memory subsystem using zones for NVMe
protocol-based controllers. NVMeOF already support the ZNS NVMe
Protocol compliant devices on the target in the passthru mode. There
are generic zoned block devices like  Shingled Magnetic Recording (SMR)
HDDs that are not based on the NVMe protocol.

This patch adds ZNS backend support for non-ZNS zoned block devices as
NVMeOF targets.

This support includes implementing the new command set NVME_CSI_ZNS,
adding different command handlers for ZNS command set such as NVMe
Identify Controller, NVMe Identify Namespace, NVMe Zone Append,
NVMe Zone Management Send and NVMe Zone Management Receive.

With the new command set identifier, we also update the target command
effects logs to reflect the ZNS compliant commands.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/Makefile      |   1 +
 drivers/nvme/target/admin-cmd.c   |  41 ++
 drivers/nvme/target/core.c        |  15 +-
 drivers/nvme/target/io-cmd-bdev.c |  26 +-
 drivers/nvme/target/nvmet.h       |  20 +
 drivers/nvme/target/zns.c         | 622 ++++++++++++++++++++++++++++++
 include/linux/nvme.h              |   7 +
 7 files changed, 721 insertions(+), 11 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index ebf91fc4c72e..9837e580fa7e 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
 			discovery.o io-cmd-file.o io-cmd-bdev.o
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
+nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
 nvme-loop-y	+= loop.o
 nvmet-rdma-y	+= rdma.o
 nvmet-fc-y	+= fc.o
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 93aaa7479e71..363e357d2f20 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -179,6 +179,13 @@ static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
 	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
 }
 
+static void nvmet_get_cmd_effects_zns(struct nvme_effects_log *log)
+{
+	log->iocs[nvme_cmd_zone_append]		= cpu_to_le32(1 << 0);
+	log->iocs[nvme_cmd_zone_mgmt_send]	= cpu_to_le32(1 << 0);
+	log->iocs[nvme_cmd_zone_mgmt_recv]	= cpu_to_le32(1 << 0);
+}
+
 static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 {
 	struct nvme_effects_log *log;
@@ -194,6 +201,14 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	case NVME_CSI_NVM:
 		nvmet_get_cmd_effects_nvm(log);
 		break;
+	case NVME_CSI_ZNS:
+		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+			status = NVME_SC_INVALID_IO_CMD_SET;
+			goto free;
+		}
+		nvmet_get_cmd_effects_nvm(log);
+		nvmet_get_cmd_effects_zns(log);
+		break;
 	default:
 		status = NVME_SC_INVALID_LOG_PAGE;
 		goto free;
@@ -647,6 +662,12 @@ static bool nvmet_handle_identify_desclist(struct nvmet_req *req)
 	case NVME_CSI_NVM:
 		nvmet_execute_identify_desclist(req);
 		return true;
+	case NVME_CSI_ZNS:
+		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+			nvmet_execute_identify_desclist(req);
+			return true;
+		}
+		return false;
 	default:
 		return false;
 	}
@@ -666,12 +687,32 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 			break;
 		}
 		break;
+	case NVME_ID_CNS_CS_NS:
+		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+			switch (req->cmd->identify.csi) {
+			case NVME_CSI_ZNS:
+				return nvmet_execute_identify_cns_cs_ns(req);
+			default:
+				break;
+			}
+		}
+		break;
 	case NVME_ID_CNS_CTRL:
 		switch (req->cmd->identify.csi) {
 		case NVME_CSI_NVM:
 			return nvmet_execute_identify_ctrl(req);
 		}
 		break;
+	case NVME_ID_CNS_CS_CTRL:
+		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+			switch (req->cmd->identify.csi) {
+			case NVME_CSI_ZNS:
+				return nvmet_execute_identify_cns_cs_ctrl(req);
+			default:
+				break;
+			}
+		}
+		break;
 	case NVME_ID_CNS_NS_ACTIVE_LIST:
 		switch (req->cmd->identify.csi) {
 		case NVME_CSI_NVM:
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ac53a1307ce4..d061e9946568 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -16,6 +16,7 @@
 #include "nvmet.h"
 
 struct workqueue_struct *buffered_io_wq;
+struct workqueue_struct *zbd_wq;
 static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
 static DEFINE_IDA(cntlid_ida);
 
@@ -893,6 +894,10 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 		if (req->ns->file)
 			return nvmet_file_parse_io_cmd(req);
 		return nvmet_bdev_parse_io_cmd(req);
+	case NVME_CSI_ZNS:
+		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
+			return nvmet_bdev_zns_parse_io_cmd(req);
+		return NVME_SC_INVALID_IO_CMD_SET;
 	default:
 		return NVME_SC_INVALID_IO_CMD_SET;
 	}
@@ -1602,11 +1607,15 @@ static int __init nvmet_init(void)
 
 	nvmet_ana_group_enabled[NVMET_DEFAULT_ANA_GRPID] = 1;
 
+	zbd_wq = alloc_workqueue("nvmet-zbd-wq", WQ_MEM_RECLAIM, 0);
+	if (!zbd_wq)
+		return -ENOMEM;
+
 	buffered_io_wq = alloc_workqueue("nvmet-buffered-io-wq",
 			WQ_MEM_RECLAIM, 0);
 	if (!buffered_io_wq) {
 		error = -ENOMEM;
-		goto out;
+		goto out_free_zbd_work_queue;
 	}
 
 	error = nvmet_init_discovery();
@@ -1622,7 +1631,8 @@ static int __init nvmet_init(void)
 	nvmet_exit_discovery();
 out_free_work_queue:
 	destroy_workqueue(buffered_io_wq);
-out:
+out_free_zbd_work_queue:
+	destroy_workqueue(zbd_wq);
 	return error;
 }
 
@@ -1632,6 +1642,7 @@ static void __exit nvmet_exit(void)
 	nvmet_exit_discovery();
 	ida_destroy(&cntlid_ida);
 	destroy_workqueue(buffered_io_wq);
+	destroy_workqueue(zbd_wq);
 
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_entry) != 1024);
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_hdr) != 1024);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 40534d9a86d1..57f619aa7cba 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -47,6 +47,14 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	id->nows = to0based(ql->io_opt / ql->logical_block_size);
 }
 
+void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
+{
+	if (ns->bdev) {
+		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
+		ns->bdev = NULL;
+	}
+}
+
 static void nvmet_bdev_ns_enable_integrity(struct nvmet_ns *ns)
 {
 	struct blk_integrity *bi = bdev_get_integrity(ns->bdev);
@@ -86,15 +94,15 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY_T10))
 		nvmet_bdev_ns_enable_integrity(ns);
 
-	return 0;
-}
-
-void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
-{
-	if (ns->bdev) {
-		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
-		ns->bdev = NULL;
+	if (bdev_is_zoned(ns->bdev)) {
+		if (!nvmet_bdev_zns_enable(ns)) {
+			nvmet_bdev_ns_disable(ns);
+			return -EINVAL;
+		}
+		ns->csi = NVME_CSI_ZNS;
 	}
+
+	return 0;
 }
 
 void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
@@ -102,7 +110,7 @@ void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
 	ns->size = i_size_read(ns->bdev->bd_inode);
 }
 
-static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
+u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 {
 	u16 status = NVME_SC_SUCCESS;
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 4ca558b94955..f7fbf9690ce8 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -250,6 +250,10 @@ struct nvmet_subsys {
 	unsigned int		admin_timeout;
 	unsigned int		io_timeout;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
+
+#ifdef CONFIG_BLK_DEV_ZONED
+	u8			zasl;
+#endif /* CONFIG_BLK_DEV_ZONED */
 };
 
 static inline struct nvmet_subsys *to_subsys(struct config_item *item)
@@ -335,6 +339,12 @@ struct nvmet_req {
 			struct work_struct      work;
 			bool			use_workqueue;
 		} p;
+#ifdef CONFIG_BLK_DEV_ZONED
+		struct {
+			struct bio		inline_bio;
+			struct work_struct	zmgmt_work;
+		} z;
+#endif /* CONFIG_BLK_DEV_ZONED */
 	};
 	int			sg_cnt;
 	int			metadata_sg_cnt;
@@ -354,6 +364,7 @@ struct nvmet_req {
 };
 
 extern struct workqueue_struct *buffered_io_wq;
+extern struct workqueue_struct *zbd_wq;
 
 static inline void nvmet_set_result(struct nvmet_req *req, u32 result)
 {
@@ -403,6 +414,7 @@ u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
 void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id);
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_file_parse_io_cmd(struct nvmet_req *req);
+u16 nvmet_bdev_zns_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_parse_admin_cmd(struct nvmet_req *req);
 u16 nvmet_parse_discovery_cmd(struct nvmet_req *req);
 u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req);
@@ -530,6 +542,14 @@ void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
 int nvmet_file_ns_revalidate(struct nvmet_ns *ns);
 void nvmet_ns_revalidate(struct nvmet_ns *ns);
+u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
+
+bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
+void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
+void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
+void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
+void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
+void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
 
 static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
 {
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
new file mode 100644
index 000000000000..b8ff75293e53
--- /dev/null
+++ b/drivers/nvme/target/zns.c
@@ -0,0 +1,622 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe ZNS-ZBD command implementation.
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/nvme.h>
+#include <linux/blkdev.h>
+#include "nvmet.h"
+
+/*
+ * We set the Memory Page Size Minimum (MPSMIN) for target controller to 0
+ * which gets added by 12 in the nvme_enable_ctrl() which results in 2^12 = 4k
+ * as page_shift value. When calculating the ZASL use shift by 12.
+ */
+#define NVMET_MPSMIN_SHIFT	12
+
+static inline u8 nvmet_zasl(unsigned int zone_append_sects)
+{
+	/*
+	 * Zone Append Size Limit (zasl) is expressed as a power of 2 value
+	 * with the minimum memory page size (i.e. 12) as unit.
+	 */
+	return ilog2(zone_append_sects >> (NVMET_MPSMIN_SHIFT - 9));
+}
+
+static int validate_conv_zones_cb(struct blk_zone *z,
+				  unsigned int i, void *data)
+{
+	if (z->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
+{
+	struct request_queue *q = ns->bdev->bd_disk->queue;
+	u8 zasl = nvmet_zasl(queue_max_zone_append_sectors(q));
+	struct gendisk *bd_disk = ns->bdev->bd_disk;
+	int ret;
+
+	if (ns->subsys->zasl) {
+		if (ns->subsys->zasl > zasl)
+			return false;
+	}
+	ns->subsys->zasl = zasl;
+
+	/*
+	 * Generic zoned block devices may have a smaller last zone which is
+	 * not supported by ZNS. Exclude zoned drives that have such smaller
+	 * last zone.
+	 */
+	if (get_capacity(bd_disk) & (bdev_zone_sectors(ns->bdev) - 1))
+		return false;
+	/*
+	 * ZNS does not define a conventional zone type. If the underlying
+	 * device has a bitmap set indicating the existence of conventional
+	 * zones, reject the device. Otherwise, use report zones to detect if
+	 * the device has conventional zones.
+	 */
+	if (ns->bdev->bd_disk->queue->conv_zones_bitmap)
+		return false;
+
+	ret = blkdev_report_zones(ns->bdev, 0, blkdev_nr_zones(bd_disk),
+				  validate_conv_zones_cb, NULL);
+	if (ret < 0)
+		return false;
+
+	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
+
+	return true;
+}
+
+void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
+{
+	u8 zasl = req->sq->ctrl->subsys->zasl;
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
+	u64 zsze;
+	u16 status;
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
+	status = nvmet_req_find_ns(req);
+	if (status) {
+		status = NVME_SC_INTERNAL;
+		goto done;
+	}
+
+	if (!bdev_is_zoned(req->ns->bdev)) {
+		req->error_loc = offsetof(struct nvme_identify, nsid);
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		goto done;
+	}
+
+	nvmet_ns_revalidate(req->ns);
+	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
+					req->ns->blksize_shift;
+	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
+	id_zns->mor = cpu_to_le32(bdev_max_open_zones(req->ns->bdev));
+	id_zns->mar = cpu_to_le32(bdev_max_active_zones(req->ns->bdev));
+
+done:
+	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
+	kfree(id_zns);
+out:
+	nvmet_req_complete(req, status);
+}
+
+static u16 nvmet_bdev_validate_zone_mgmt_recv(struct nvmet_req *req)
+{
+	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
+	u32 out_bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
+
+	if (sect >= get_capacity(req->ns->bdev->bd_disk)) {
+		req->error_loc = offsetof(struct nvme_zone_mgmt_recv_cmd, slba);
+		return NVME_SC_LBA_RANGE | NVME_SC_DNR;
+	}
+
+	if (out_bufsize < sizeof(struct nvme_zone_report)) {
+		req->error_loc = offsetof(struct nvme_zone_mgmt_recv_cmd, numd);
+		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+	}
+
+	if (req->cmd->zmr.zra != NVME_ZRA_ZONE_REPORT) {
+		req->error_loc = offsetof(struct nvme_zone_mgmt_recv_cmd, zra);
+		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+	}
+
+	switch (req->cmd->zmr.pr) {
+	case 0:
+	case 1:
+		break;
+	default:
+		req->error_loc = offsetof(struct nvme_zone_mgmt_recv_cmd, pr);
+		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+	}
+
+	switch (req->cmd->zmr.zrasf) {
+	case NVME_ZRASF_ZONE_REPORT_ALL:
+	case NVME_ZRASF_ZONE_STATE_EMPTY:
+	case NVME_ZRASF_ZONE_STATE_IMP_OPEN:
+	case NVME_ZRASF_ZONE_STATE_EXP_OPEN:
+	case NVME_ZRASF_ZONE_STATE_CLOSED:
+	case NVME_ZRASF_ZONE_STATE_FULL:
+	case NVME_ZRASF_ZONE_STATE_READONLY:
+	case NVME_ZRASF_ZONE_STATE_OFFLINE:
+		break;
+	default:
+		req->error_loc =
+			offsetof(struct nvme_zone_mgmt_recv_cmd, zrasf);
+		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+	}
+
+	return NVME_SC_SUCCESS;
+}
+
+struct nvmet_report_zone_data {
+	struct nvmet_req *req;
+	u64 out_buf_offset;
+	u64 out_nr_zones;
+	u64 nr_zones;
+	u8 zrasf;
+};
+
+static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned i, void *d)
+{
+	static const unsigned int nvme_zrasf_to_blk_zcond[] = {
+		[NVME_ZRASF_ZONE_STATE_EMPTY]	 = BLK_ZONE_COND_EMPTY,
+		[NVME_ZRASF_ZONE_STATE_IMP_OPEN] = BLK_ZONE_COND_IMP_OPEN,
+		[NVME_ZRASF_ZONE_STATE_EXP_OPEN] = BLK_ZONE_COND_EXP_OPEN,
+		[NVME_ZRASF_ZONE_STATE_CLOSED]	 = BLK_ZONE_COND_CLOSED,
+		[NVME_ZRASF_ZONE_STATE_READONLY] = BLK_ZONE_COND_READONLY,
+		[NVME_ZRASF_ZONE_STATE_FULL]	 = BLK_ZONE_COND_FULL,
+		[NVME_ZRASF_ZONE_STATE_OFFLINE]	 = BLK_ZONE_COND_OFFLINE,
+	};
+	struct nvmet_report_zone_data *rz = d;
+
+	if (rz->zrasf != NVME_ZRASF_ZONE_REPORT_ALL &&
+	    z->cond != nvme_zrasf_to_blk_zcond[rz->zrasf])
+		return 0;
+
+	if (rz->nr_zones < rz->out_nr_zones) {
+		struct nvme_zone_descriptor zdesc = { };
+		u16 status;
+
+		zdesc.zcap = nvmet_sect_to_lba(rz->req->ns, z->capacity);
+		zdesc.zslba = nvmet_sect_to_lba(rz->req->ns, z->start);
+		zdesc.wp = nvmet_sect_to_lba(rz->req->ns, z->wp);
+		zdesc.za = z->reset ? 1 << 2 : 0;
+		zdesc.zs = z->cond << 4;
+		zdesc.zt = z->type;
+
+		status = nvmet_copy_to_sgl(rz->req, rz->out_buf_offset, &zdesc,
+					   sizeof(zdesc));
+		if (status)
+			return -EINVAL;
+
+		rz->out_buf_offset += sizeof(zdesc);
+	}
+
+	rz->nr_zones++;
+
+	return 0;
+}
+
+static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
+{
+	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
+
+	return blkdev_nr_zones(req->ns->bdev->bd_disk) -
+		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+}
+
+static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
+{
+	if (bufsize <= sizeof(struct nvme_zone_report))
+		return 0;
+
+	return (bufsize - sizeof(struct nvme_zone_report)) /
+		sizeof(struct nvme_zone_descriptor);
+}
+
+void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, z.zmgmt_work);
+	sector_t start_sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
+	unsigned long req_slba_nr_zones = nvmet_req_nr_zones_from_slba(req);
+	u32 out_bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
+	__le64 nr_zones;
+	u16 status;
+	int ret;
+	struct nvmet_report_zone_data rz_data = {
+		.out_nr_zones = get_nr_zones_from_buf(req, out_bufsize),
+		/* leave the place for report zone header */
+		.out_buf_offset = sizeof(struct nvme_zone_report),
+		.zrasf = req->cmd->zmr.zrasf,
+		.nr_zones = 0,
+		.req = req,
+	};
+
+	status = nvmet_bdev_validate_zone_mgmt_recv(req);
+	if (status)
+		goto out;
+
+	if (!req_slba_nr_zones) {
+		status = NVME_SC_SUCCESS;
+		goto out;
+	}
+
+	ret = blkdev_report_zones(req->ns->bdev, start_sect, req_slba_nr_zones,
+				 nvmet_bdev_report_zone_cb, &rz_data);
+	if (ret < 0) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	/*
+	 * When partial bit is set nr_zones must indicate the number of zone
+	 * descriptors actually transferred.
+	 */
+	if (req->cmd->zmr.pr)
+		rz_data.nr_zones = min(rz_data.nr_zones, rz_data.out_nr_zones);
+
+	nr_zones = cpu_to_le64(rz_data.nr_zones);
+	status = nvmet_copy_to_sgl(req, 0, &nr_zones, sizeof(nr_zones));
+
+out:
+	nvmet_req_complete(req, status);
+}
+
+void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
+{
+	INIT_WORK(&req->z.zmgmt_work, nvmet_bdev_zone_zmgmt_recv_work);
+	queue_work(zbd_wq, &req->z.zmgmt_work);
+}
+
+static inline enum req_opf zsa_req_op(u8 zsa)
+{
+	switch (zsa) {
+	case NVME_ZONE_OPEN:
+		return REQ_OP_ZONE_OPEN;
+	case NVME_ZONE_CLOSE:
+		return REQ_OP_ZONE_CLOSE;
+	case NVME_ZONE_FINISH:
+		return REQ_OP_ZONE_FINISH;
+	case NVME_ZONE_RESET:
+		return REQ_OP_ZONE_RESET;
+	default:
+		return REQ_OP_LAST;
+	}
+}
+
+static u16 blkdev_zone_mgmt_errno_to_nvme_status(int ret)
+{
+	switch (ret) {
+	case 0:
+		return NVME_SC_SUCCESS;
+	case -EINVAL:
+	case -EIO:
+		return NVME_SC_ZONE_INVALID_TRANSITION | NVME_SC_DNR;
+	default:
+		return NVME_SC_INTERNAL;
+	}
+}
+
+struct nvmet_zone_mgmt_send_all_data {
+	unsigned long *zbitmap;
+	struct nvmet_req *req;
+};
+
+static int zmgmt_send_scan_cb(struct blk_zone *z, unsigned i, void *d)
+{
+	struct nvmet_zone_mgmt_send_all_data *data = d;
+
+	switch (zsa_req_op(data->req->cmd->zms.zsa)) {
+	case REQ_OP_ZONE_OPEN:
+		switch (z->cond) {
+		case BLK_ZONE_COND_CLOSED:
+			break;
+		default:
+			return 0;
+		}
+		break;
+	case REQ_OP_ZONE_CLOSE:
+		switch (z->cond) {
+		case BLK_ZONE_COND_IMP_OPEN:
+		case BLK_ZONE_COND_EXP_OPEN:
+			break;
+		default:
+			return 0;
+		}
+		break;
+	case REQ_OP_ZONE_FINISH:
+		switch (z->cond) {
+		case BLK_ZONE_COND_IMP_OPEN:
+		case BLK_ZONE_COND_EXP_OPEN:
+		case BLK_ZONE_COND_CLOSED:
+			break;
+		default:
+			return 0;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	set_bit(i, data->zbitmap);
+
+	return 0;
+}
+
+static u16 nvmet_bdev_zone_mgmt_emulate_all(struct nvmet_req *req)
+{
+	struct block_device *bdev = req->ns->bdev;
+	unsigned int nr_zones = blkdev_nr_zones(bdev->bd_disk);
+	struct request_queue *q = bdev_get_queue(bdev);
+	struct bio *bio = NULL;
+	sector_t sector = 0;
+	int ret;
+	struct nvmet_zone_mgmt_send_all_data d = {
+		.req = req,
+	};
+
+	d.zbitmap = kcalloc_node(BITS_TO_LONGS(nr_zones), sizeof(*(d.zbitmap)),
+				 GFP_NOIO, q->node);
+	if (!d.zbitmap) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Scan and build bitmap of the eligible zones */
+	ret = blkdev_report_zones(bdev, 0, nr_zones, zmgmt_send_scan_cb, &d);
+	if (ret != nr_zones) {
+		if (ret > 0)
+			ret = -EIO;
+		goto out;
+	} else {
+		/* We scanned all the zones */
+		ret = 0;
+	}
+
+	while (sector < get_capacity(bdev->bd_disk)) {
+		if (test_bit(blk_queue_zone_no(q, sector), d.zbitmap)) {
+			bio = blk_next_bio(bio, 0, GFP_KERNEL);
+			bio->bi_opf = zsa_req_op(req->cmd->zms.zsa) | REQ_SYNC;
+			bio->bi_iter.bi_sector = sector;
+			bio_set_dev(bio, bdev);
+			/* This may take a while, so be nice to others */
+			cond_resched();
+		}
+		sector += blk_queue_zone_sectors(q);
+	}
+
+	if (bio) {
+		ret = submit_bio_wait(bio);
+		bio_put(bio);
+	}
+
+out:
+	kfree(d.zbitmap);
+
+	return blkdev_zone_mgmt_errno_to_nvme_status(ret);
+}
+
+static u16 nvmet_bdev_execute_zmgmt_send_all(struct nvmet_req *req)
+{
+	int ret;
+
+	switch (zsa_req_op(req->cmd->zms.zsa)) {
+	case REQ_OP_ZONE_RESET:
+		ret = blkdev_zone_mgmt(req->ns->bdev, REQ_OP_ZONE_RESET, 0,
+				       get_capacity(req->ns->bdev->bd_disk),
+				       GFP_KERNEL);
+		if (ret < 0)
+			return blkdev_zone_mgmt_errno_to_nvme_status(ret);
+		break;
+	case REQ_OP_ZONE_OPEN:
+	case REQ_OP_ZONE_CLOSE:
+	case REQ_OP_ZONE_FINISH:
+		return nvmet_bdev_zone_mgmt_emulate_all(req);
+	default:
+		/* this is needed to quiet compiler warning */
+		req->error_loc = offsetof(struct nvme_zone_mgmt_send_cmd, zsa);
+		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+	}
+
+	return NVME_SC_SUCCESS;
+}
+
+static void nvmet_bdev_zmgmt_send_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, z.zmgmt_work);
+	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
+	enum req_opf op = zsa_req_op(req->cmd->zms.zsa);
+	struct block_device *bdev = req->ns->bdev;
+	sector_t zone_sectors = bdev_zone_sectors(bdev);
+	u16 status = NVME_SC_SUCCESS;
+	int ret;
+
+	if (op == REQ_OP_LAST) {
+		req->error_loc = offsetof(struct nvme_zone_mgmt_send_cmd, zsa);
+		status = NVME_SC_ZONE_INVALID_TRANSITION | NVME_SC_DNR;
+		goto out;
+	}
+
+	/* when select all bit is set slba field is ignored */
+	if (req->cmd->zms.select_all) {
+		status = nvmet_bdev_execute_zmgmt_send_all(req);
+		goto out;
+	}
+
+	if (sect >= get_capacity(bdev->bd_disk)) {
+		req->error_loc = offsetof(struct nvme_zone_mgmt_send_cmd, slba);
+		status = NVME_SC_LBA_RANGE | NVME_SC_DNR;
+		goto out;
+	}
+
+	if (sect & (zone_sectors - 1)) {
+		req->error_loc = offsetof(struct nvme_zone_mgmt_send_cmd, slba);
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto out;
+	}
+
+	ret = blkdev_zone_mgmt(bdev, op, sect, zone_sectors, GFP_KERNEL);
+	if (ret < 0)
+		status = blkdev_zone_mgmt_errno_to_nvme_status(ret);
+
+out:
+	nvmet_req_complete(req, status);
+}
+
+void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
+{
+	INIT_WORK(&req->z.zmgmt_work, nvmet_bdev_zmgmt_send_work);
+	queue_work(zbd_wq, &req->z.zmgmt_work);
+}
+
+static void nvmet_bdev_zone_append_bio_done(struct bio *bio)
+{
+	struct nvmet_req *req = bio->bi_private;
+
+	if (bio->bi_status == BLK_STS_OK) {
+		req->cqe->result.u64 =
+			nvmet_sect_to_lba(req->ns, bio->bi_iter.bi_sector);
+	}
+
+	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
+	nvmet_req_bio_put(req, bio);
+}
+
+void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
+{
+	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
+	u16 nr_sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.length);
+	u16 status = NVME_SC_SUCCESS;
+	unsigned int total_len = 0;
+	struct scatterlist *sg;
+	struct bio *bio;
+	int sg_cnt;
+
+	/* Request is completed on len mismatch in nvmet_check_transter_len() */
+	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
+		return;
+
+	if (!req->sg_cnt) {
+		nvmet_req_complete(req, 0);
+		return;
+	}
+
+	if (sect >= get_capacity(req->ns->bdev->bd_disk)) {
+		req->error_loc = offsetof(struct nvme_rw_command, slba);
+		status = NVME_SC_LBA_RANGE | NVME_SC_DNR;
+		goto out;
+	}
+
+	if ((sect + nr_sect > get_capacity(req->ns->bdev->bd_disk))) {
+		req->error_loc = offsetof(struct nvme_rw_command, length);
+		status = NVME_SC_LBA_RANGE | NVME_SC_DNR;
+		goto out;
+	}
+
+	if (sect & (bdev_zone_sectors(req->ns->bdev) - 1)) {
+		req->error_loc = offsetof(struct nvme_rw_command, slba);
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto out;
+	}
+
+	if (nvmet_use_inline_bvec(req)) {
+		bio = &req->z.inline_bio;
+		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+	} else {
+		bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
+	}
+
+	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
+	bio->bi_end_io = nvmet_bdev_zone_append_bio_done;
+	bio_set_dev(bio, req->ns->bdev);
+	bio->bi_iter.bi_sector = sect;
+	bio->bi_private = req;
+	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
+		bio->bi_opf |= REQ_FUA;
+
+	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {
+		struct page *p = sg_page(sg);
+		unsigned int l = sg->length;
+		unsigned int o = sg->offset;
+		unsigned int ret;
+
+		ret = bio_add_zone_append_page(bio, p, l, o);
+		if (ret != sg->length) {
+			status = NVME_SC_INTERNAL;
+			goto out_put_bio;
+		}
+		total_len += sg->length;
+	}
+
+	if (total_len != nvmet_rw_data_len(req)) {
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		goto out_put_bio;
+	}
+
+	submit_bio(bio);
+	return;
+
+out_put_bio:
+	nvmet_req_bio_put(req, bio);
+out:
+	nvmet_req_complete(req, status);
+}
+
+u16 nvmet_bdev_zns_parse_io_cmd(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+
+	switch (cmd->common.opcode) {
+	case nvme_cmd_zone_append:
+		req->execute = nvmet_bdev_execute_zone_append;
+		return 0;
+	case nvme_cmd_zone_mgmt_recv:
+		req->execute = nvmet_bdev_execute_zone_mgmt_recv;
+		return 0;
+	case nvme_cmd_zone_mgmt_send:
+		req->execute = nvmet_bdev_execute_zone_mgmt_send;
+		return 0;
+	default:
+		return nvmet_bdev_parse_io_cmd(req);
+	}
+}
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c7ba83144d52..cb1197f1cfed 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -944,6 +944,13 @@ struct nvme_zone_mgmt_recv_cmd {
 enum {
 	NVME_ZRA_ZONE_REPORT		= 0,
 	NVME_ZRASF_ZONE_REPORT_ALL	= 0,
+	NVME_ZRASF_ZONE_STATE_EMPTY	= 0x01,
+	NVME_ZRASF_ZONE_STATE_IMP_OPEN	= 0x02,
+	NVME_ZRASF_ZONE_STATE_EXP_OPEN	= 0x03,
+	NVME_ZRASF_ZONE_STATE_CLOSED	= 0x04,
+	NVME_ZRASF_ZONE_STATE_READONLY	= 0x05,
+	NVME_ZRASF_ZONE_STATE_FULL	= 0x06,
+	NVME_ZRASF_ZONE_STATE_OFFLINE	= 0x07,
 	NVME_REPORT_ZONE_PARTIAL	= 1,
 };
 
-- 
2.22.1

