Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAFAD27AA
	for <lists+linux-block@lfdr.de>; Thu, 10 Oct 2019 13:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJJLEa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 10 Oct 2019 07:04:30 -0400
Received: from verein.lst.de ([213.95.11.211]:57583 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfJJLEa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 07:04:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6886E68C65; Thu, 10 Oct 2019 13:04:25 +0200 (CEST)
Date:   Thu, 10 Oct 2019 13:04:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 07/12] nvmet-core: don't check the data len for
 pt-ctrl
Message-ID: <20191010110425.GA28372@lst.de>
References: <20191009192530.13079-1-logang@deltatee.com> <20191009192530.13079-9-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009192530.13079-9-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 09, 2019 at 01:25:25PM -0600, Logan Gunthorpe wrote:
> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> 
> Right now, data_len is calculated before the transfer len after we
> parse the command, With passthru interface we allow VUCs (Vendor-Unique
> Commands). In order to make the code simple and compact, instead of
> assigning the data len or each VUC in the command parse function
> just use the transfer len as it is. This may result in error if expected
> data_len != transfer_len.

This is a pretty horrible hack.  I think instead we'll need to kill off
the data_len field entirely if we want to go down that route.  Something
like the untested patch below:

---
From a732b65e280823433a2e12c762339fdb121f7729 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 10 Oct 2019 12:19:31 +0200
Subject: nvmet: remove the ->data_len field

Instead check the length inside the commands themselves.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/admin-cmd.c   | 128 +++++++++++++++++-------------
 drivers/nvme/target/core.c        |  12 +--
 drivers/nvme/target/discovery.c   |  63 ++++++++-------
 drivers/nvme/target/fabrics-cmd.c |  15 +++-
 drivers/nvme/target/fc.c          |   4 +-
 drivers/nvme/target/io-cmd-bdev.c |  19 +++--
 drivers/nvme/target/io-cmd-file.c |  21 +++--
 drivers/nvme/target/loop.c        |   2 +-
 drivers/nvme/target/nvmet.h       |  10 ++-
 drivers/nvme/target/rdma.c        |   4 +-
 drivers/nvme/target/tcp.c         |  13 +--
 11 files changed, 169 insertions(+), 122 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 831a062d27cb..05922fa22c66 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -31,7 +31,7 @@ u64 nvmet_get_log_page_offset(struct nvme_command *cmd)
 
 static void nvmet_execute_get_log_page_noop(struct nvmet_req *req)
 {
-	nvmet_req_complete(req, nvmet_zero_sgl(req, 0, req->data_len));
+	nvmet_req_complete(req, nvmet_zero_sgl(req, 0, req->transfer_len));
 }
 
 static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
@@ -134,7 +134,7 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 	u16 status = NVME_SC_INTERNAL;
 	unsigned long flags;
 
-	if (req->data_len != sizeof(*log))
+	if (req->transfer_len != sizeof(*log))
 		goto out;
 
 	log = kzalloc(sizeof(*log), GFP_KERNEL);
@@ -196,7 +196,7 @@ static void nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
 	u16 status = NVME_SC_INTERNAL;
 	size_t len;
 
-	if (req->data_len != NVME_MAX_CHANGED_NAMESPACES * sizeof(__le32))
+	if (req->transfer_len != NVME_MAX_CHANGED_NAMESPACES * sizeof(__le32))
 		goto out;
 
 	mutex_lock(&ctrl->lock);
@@ -206,7 +206,7 @@ static void nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
 		len = ctrl->nr_changed_ns * sizeof(__le32);
 	status = nvmet_copy_to_sgl(req, 0, ctrl->changed_ns_list, len);
 	if (!status)
-		status = nvmet_zero_sgl(req, len, req->data_len - len);
+		status = nvmet_zero_sgl(req, len, req->transfer_len - len);
 	ctrl->nr_changed_ns = 0;
 	nvmet_clear_aen_bit(req, NVME_AEN_BIT_NS_ATTR);
 	mutex_unlock(&ctrl->lock);
@@ -282,6 +282,36 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static void nvmet_execute_get_log_page(struct nvmet_req *req)
+{
+	if (!nvmet_check_data_len(req, nvmet_get_log_page_len(req->cmd)))
+		return;
+
+	switch (req->cmd->get_log_page.lid) {
+	case NVME_LOG_ERROR:
+		return nvmet_execute_get_log_page_error(req);
+	case NVME_LOG_SMART:
+		return nvmet_execute_get_log_page_smart(req);
+	case NVME_LOG_FW_SLOT:
+		/*
+		 * We only support a single firmware slot which always is
+		 * active, so we can zero out the whole firmware slot log and
+		 * still claim to fully implement this mandatory log page.
+		 */
+		return nvmet_execute_get_log_page_noop(req);
+	case NVME_LOG_CHANGED_NS:
+		return nvmet_execute_get_log_changed_ns(req);
+	case NVME_LOG_CMD_EFFECTS:
+		return nvmet_execute_get_log_cmd_effects_ns(req);
+	case NVME_LOG_ANA:
+		return nvmet_execute_get_log_page_ana(req);
+	}
+	pr_err("unhandled lid %d on qid %d\n",
+		req->cmd->get_log_page.lid, req->sq->qid);
+	req->error_loc = offsetof(struct nvme_get_log_page_command, lid);
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+}
+
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -565,6 +595,28 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static void nvmet_execute_identify(struct nvmet_req *req)
+{
+	if (!nvmet_check_data_len(req, NVME_IDENTIFY_DATA_SIZE))
+		return;
+
+	switch (req->cmd->identify.cns) {
+	case NVME_ID_CNS_NS:
+		return nvmet_execute_identify_ns(req);
+	case NVME_ID_CNS_CTRL:
+		return nvmet_execute_identify_ctrl(req);
+	case NVME_ID_CNS_NS_ACTIVE_LIST:
+		return nvmet_execute_identify_nslist(req);
+	case NVME_ID_CNS_NS_DESC_LIST:
+		return nvmet_execute_identify_desclist(req);
+	}
+
+	pr_err("unhandled identify cns %d on qid %d\n",
+		req->cmd->identify.cns, req->sq->qid);
+	req->error_loc = offsetof(struct nvme_identify, cns);
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+}
+
 /*
  * A "minimum viable" abort implementation: the command is mandatory in the
  * spec, but we are not required to do any useful work.  We couldn't really
@@ -574,6 +626,8 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
  */
 static void nvmet_execute_abort(struct nvmet_req *req)
 {
+	if (!nvmet_check_data_len(req, 0))
+		return;
 	nvmet_set_result(req, 1);
 	nvmet_req_complete(req, 0);
 }
@@ -658,6 +712,9 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 status = 0;
 
+	if (!nvmet_check_data_len(req, 0))
+		return;
+
 	switch (cdw10 & 0xff) {
 	case NVME_FEAT_NUM_QUEUES:
 		nvmet_set_result(req,
@@ -721,6 +778,9 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 status = 0;
 
+	if (!nvmet_check_data_len(req, 0))
+		return;
+
 	switch (cdw10 & 0xff) {
 	/*
 	 * These features are mandatory in the spec, but we don't
@@ -785,6 +845,9 @@ void nvmet_execute_async_event(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 
+	if (!nvmet_check_data_len(req, 0))
+		return;
+
 	mutex_lock(&ctrl->lock);
 	if (ctrl->nr_async_event_cmds >= NVMET_ASYNC_EVENTS) {
 		mutex_unlock(&ctrl->lock);
@@ -801,6 +864,9 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 
+	if (!nvmet_check_data_len(req, 0))
+		return;
+
 	pr_debug("ctrl %d update keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
 
@@ -819,71 +885,25 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 
 	switch (cmd->common.opcode) {
 	case nvme_admin_get_log_page:
-		req->data_len = nvmet_get_log_page_len(cmd);
-
-		switch (cmd->get_log_page.lid) {
-		case NVME_LOG_ERROR:
-			req->execute = nvmet_execute_get_log_page_error;
-			return 0;
-		case NVME_LOG_SMART:
-			req->execute = nvmet_execute_get_log_page_smart;
-			return 0;
-		case NVME_LOG_FW_SLOT:
-			/*
-			 * We only support a single firmware slot which always
-			 * is active, so we can zero out the whole firmware slot
-			 * log and still claim to fully implement this mandatory
-			 * log page.
-			 */
-			req->execute = nvmet_execute_get_log_page_noop;
-			return 0;
-		case NVME_LOG_CHANGED_NS:
-			req->execute = nvmet_execute_get_log_changed_ns;
-			return 0;
-		case NVME_LOG_CMD_EFFECTS:
-			req->execute = nvmet_execute_get_log_cmd_effects_ns;
-			return 0;
-		case NVME_LOG_ANA:
-			req->execute = nvmet_execute_get_log_page_ana;
-			return 0;
-		}
-		break;
+		req->execute = nvmet_execute_get_log_page;
+		return 0;;
 	case nvme_admin_identify:
-		req->data_len = NVME_IDENTIFY_DATA_SIZE;
-		switch (cmd->identify.cns) {
-		case NVME_ID_CNS_NS:
-			req->execute = nvmet_execute_identify_ns;
-			return 0;
-		case NVME_ID_CNS_CTRL:
-			req->execute = nvmet_execute_identify_ctrl;
-			return 0;
-		case NVME_ID_CNS_NS_ACTIVE_LIST:
-			req->execute = nvmet_execute_identify_nslist;
-			return 0;
-		case NVME_ID_CNS_NS_DESC_LIST:
-			req->execute = nvmet_execute_identify_desclist;
-			return 0;
-		}
-		break;
+		req->execute = nvmet_execute_identify;
+		return 0;
 	case nvme_admin_abort_cmd:
 		req->execute = nvmet_execute_abort;
-		req->data_len = 0;
 		return 0;
 	case nvme_admin_set_features:
 		req->execute = nvmet_execute_set_features;
-		req->data_len = 0;
 		return 0;
 	case nvme_admin_get_features:
 		req->execute = nvmet_execute_get_features;
-		req->data_len = 0;
 		return 0;
 	case nvme_admin_async_event:
 		req->execute = nvmet_execute_async_event;
-		req->data_len = 0;
 		return 0;
 	case nvme_admin_keep_alive:
 		req->execute = nvmet_execute_keep_alive;
-		req->data_len = 0;
 		return 0;
 	}
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3a67e244e568..f7da0e50beeb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -930,15 +930,17 @@ void nvmet_req_uninit(struct nvmet_req *req)
 }
 EXPORT_SYMBOL_GPL(nvmet_req_uninit);
 
-void nvmet_req_execute(struct nvmet_req *req)
+bool nvmet_check_data_len(struct nvmet_req *req, size_t data_len)
 {
-	if (unlikely(req->data_len != req->transfer_len)) {
+	if (unlikely(data_len != req->transfer_len)) {
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
 		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR);
-	} else
-		req->execute(req);
+		return false;
+	}
+
+	return true;
 }
-EXPORT_SYMBOL_GPL(nvmet_req_execute);
+EXPORT_SYMBOL_GPL(nvmet_check_data_len);
 
 int nvmet_req_alloc_sgl(struct nvmet_req *req)
 {
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 3764a8900850..a1028f26bff6 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -157,7 +157,7 @@ static size_t discovery_log_entries(struct nvmet_req *req)
 	return entries;
 }
 
-static void nvmet_execute_get_disc_log_page(struct nvmet_req *req)
+static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 {
 	const int entry_size = sizeof(struct nvmf_disc_rsp_page_entry);
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -171,6 +171,16 @@ static void nvmet_execute_get_disc_log_page(struct nvmet_req *req)
 	u16 status = 0;
 	void *buffer;
 
+	if (!nvmet_check_data_len(req, data_len))
+		return;
+
+	if (req->cmd->get_log_page.lid != NVME_LOG_DISC) {
+		req->error_loc =
+			offsetof(struct nvme_get_log_page_command, lid);
+		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		goto out;
+	}
+
 	/* Spec requires dword aligned offsets */
 	if (offset & 0x3) {
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
@@ -227,12 +237,21 @@ static void nvmet_execute_get_disc_log_page(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static void nvmet_execute_identify_disc_ctrl(struct nvmet_req *req)
+static void nvmet_execute_disc_identify(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl *id;
 	u16 status = 0;
 
+	if (!nvmet_check_data_len(req, NVME_IDENTIFY_DATA_SIZE))
+		return;
+
+	if (req->cmd->identify.cns != NVME_ID_CNS_CTRL) {
+		req->error_loc = offsetof(struct nvme_identify, cns);
+		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		goto out;
+	}
+
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
 		status = NVME_SC_INTERNAL;
@@ -273,6 +292,9 @@ static void nvmet_execute_disc_set_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 stat;
 
+	if (!nvmet_check_data_len(req, 0))
+		return;
+
 	switch (cdw10 & 0xff) {
 	case NVME_FEAT_KATO:
 		stat = nvmet_set_feat_kato(req);
@@ -296,6 +318,9 @@ static void nvmet_execute_disc_get_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 stat = 0;
 
+	if (!nvmet_check_data_len(req, 0))
+		return;
+
 	switch (cdw10 & 0xff) {
 	case NVME_FEAT_KATO:
 		nvmet_get_feat_kato(req);
@@ -328,53 +353,27 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 	switch (cmd->common.opcode) {
 	case nvme_admin_set_features:
 		req->execute = nvmet_execute_disc_set_features;
-		req->data_len = 0;
 		return 0;
 	case nvme_admin_get_features:
 		req->execute = nvmet_execute_disc_get_features;
-		req->data_len = 0;
 		return 0;
 	case nvme_admin_async_event:
 		req->execute = nvmet_execute_async_event;
-		req->data_len = 0;
 		return 0;
 	case nvme_admin_keep_alive:
 		req->execute = nvmet_execute_keep_alive;
-		req->data_len = 0;
 		return 0;
 	case nvme_admin_get_log_page:
-		req->data_len = nvmet_get_log_page_len(cmd);
-
-		switch (cmd->get_log_page.lid) {
-		case NVME_LOG_DISC:
-			req->execute = nvmet_execute_get_disc_log_page;
-			return 0;
-		default:
-			pr_err("unsupported get_log_page lid %d\n",
-			       cmd->get_log_page.lid);
-			req->error_loc =
-				offsetof(struct nvme_get_log_page_command, lid);
-			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
-		}
+		req->execute = nvmet_execute_disc_get_log_page;
+		return 0;
 	case nvme_admin_identify:
-		req->data_len = NVME_IDENTIFY_DATA_SIZE;
-		switch (cmd->identify.cns) {
-		case NVME_ID_CNS_CTRL:
-			req->execute =
-				nvmet_execute_identify_disc_ctrl;
-			return 0;
-		default:
-			pr_err("unsupported identify cns %d\n",
-			       cmd->identify.cns);
-			req->error_loc = offsetof(struct nvme_identify, cns);
-			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
-		}
+		req->execute = nvmet_execute_disc_identify;
+		return 0;
 	default:
 		pr_err("unhandled cmd %d\n", cmd->common.opcode);
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
-
 }
 
 int __init nvmet_init_discovery(void)
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d16b55ffe79f..f7297473d9eb 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -12,6 +12,9 @@ static void nvmet_execute_prop_set(struct nvmet_req *req)
 	u64 val = le64_to_cpu(req->cmd->prop_set.value);
 	u16 status = 0;
 
+	if (!nvmet_check_data_len(req, 0))
+		return;
+
 	if (req->cmd->prop_set.attrib & 1) {
 		req->error_loc =
 			offsetof(struct nvmf_property_set_command, attrib);
@@ -38,6 +41,9 @@ static void nvmet_execute_prop_get(struct nvmet_req *req)
 	u16 status = 0;
 	u64 val = 0;
 
+	if (!nvmet_check_data_len(req, 0))
+		return;
+
 	if (req->cmd->prop_get.attrib & 1) {
 		switch (le32_to_cpu(req->cmd->prop_get.offset)) {
 		case NVME_REG_CAP:
@@ -82,11 +88,9 @@ u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req)
 
 	switch (cmd->fabrics.fctype) {
 	case nvme_fabrics_type_property_set:
-		req->data_len = 0;
 		req->execute = nvmet_execute_prop_set;
 		break;
 	case nvme_fabrics_type_property_get:
-		req->data_len = 0;
 		req->execute = nvmet_execute_prop_get;
 		break;
 	default:
@@ -147,6 +151,9 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = NULL;
 	u16 status = 0;
 
+	if (!nvmet_check_data_len(req, sizeof(struct nvmf_connect_data)))
+		return;
+
 	d = kmalloc(sizeof(*d), GFP_KERNEL);
 	if (!d) {
 		status = NVME_SC_INTERNAL;
@@ -211,6 +218,9 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	u16 qid = le16_to_cpu(c->qid);
 	u16 status = 0;
 
+	if (!nvmet_check_data_len(req, sizeof(struct nvmf_connect_data)))
+		return;
+
 	d = kmalloc(sizeof(*d), GFP_KERNEL);
 	if (!d) {
 		status = NVME_SC_INTERNAL;
@@ -281,7 +291,6 @@ u16 nvmet_parse_connect_cmd(struct nvmet_req *req)
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 
-	req->data_len = sizeof(struct nvmf_connect_data);
 	if (cmd->connect.qid == 0)
 		req->execute = nvmet_execute_admin_connect;
 	else
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index ce8d819f86cc..7f9c11138b93 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2015,7 +2015,7 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
 		}
 
 		/* data transfer complete, resume with nvmet layer */
-		nvmet_req_execute(&fod->req);
+		fod->req.execute(&fod->req);
 		break;
 
 	case NVMET_FCOP_READDATA:
@@ -2231,7 +2231,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 	 * can invoke the nvmet_layer now. If read data, cmd completion will
 	 * push the data
 	 */
-	nvmet_req_execute(&fod->req);
+	fod->req.execute(&fod->req);
 	return;
 
 transport_error:
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 32008d85172b..2d62347573fa 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -150,6 +150,9 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	sector_t sector;
 	int op, op_flags = 0, i;
 
+	if (!nvmet_check_data_len(req, nvmet_rw_len(req)))
+		return;
+
 	if (!req->sg_cnt) {
 		nvmet_req_complete(req, 0);
 		return;
@@ -170,7 +173,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	sector = le64_to_cpu(req->cmd->rw.slba);
 	sector <<= (req->ns->blksize_shift - 9);
 
-	if (req->data_len <= NVMET_MAX_INLINE_DATA_LEN) {
+	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
 		bio = &req->b.inline_bio;
 		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
 	} else {
@@ -207,6 +210,9 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 {
 	struct bio *bio = &req->b.inline_bio;
 
+	if (!nvmet_check_data_len(req, 0))
+		return;
+
 	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
 	bio_set_dev(bio, req->ns->bdev);
 	bio->bi_private = req;
@@ -274,6 +280,9 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 
 static void nvmet_bdev_execute_dsm(struct nvmet_req *req)
 {
+	if (!nvmet_check_data_len(req, nvmet_dsm_len(req)))
+		return;
+
 	switch (le32_to_cpu(req->cmd->dsm.attributes)) {
 	case NVME_DSMGMT_AD:
 		nvmet_bdev_execute_discard(req);
@@ -295,6 +304,9 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	sector_t nr_sector;
 	int ret;
 
+	if (!nvmet_check_data_len(req, 0))
+		return;
+
 	sector = le64_to_cpu(write_zeroes->slba) <<
 		(req->ns->blksize_shift - 9);
 	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
@@ -319,20 +331,15 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_read:
 	case nvme_cmd_write:
 		req->execute = nvmet_bdev_execute_rw;
-		req->data_len = nvmet_rw_len(req);
 		return 0;
 	case nvme_cmd_flush:
 		req->execute = nvmet_bdev_execute_flush;
-		req->data_len = 0;
 		return 0;
 	case nvme_cmd_dsm:
 		req->execute = nvmet_bdev_execute_dsm;
-		req->data_len = (le32_to_cpu(cmd->dsm.nr) + 1) *
-			sizeof(struct nvme_dsm_range);
 		return 0;
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_bdev_execute_write_zeroes;
-		req->data_len = 0;
 		return 0;
 	default:
 		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 05453f5d1448..07fb6cba59b5 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -126,7 +126,7 @@ static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
 			mempool_free(req->f.bvec, req->ns->bvec_pool);
 	}
 
-	if (unlikely(ret != req->data_len))
+	if (unlikely(ret != req->transfer_len))
 		status = errno_to_nvme_status(req, ret);
 	nvmet_req_complete(req, status);
 }
@@ -146,7 +146,7 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 		is_sync = true;
 
 	pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
-	if (unlikely(pos + req->data_len > req->ns->size)) {
+	if (unlikely(pos + req->transfer_len > req->ns->size)) {
 		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
 		return true;
 	}
@@ -173,7 +173,7 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 		nr_bvec--;
 	}
 
-	if (WARN_ON_ONCE(total_len != req->data_len)) {
+	if (WARN_ON_ONCE(total_len != req->transfer_len)) {
 		ret = -EIO;
 		goto complete;
 	}
@@ -232,6 +232,9 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 {
 	ssize_t nr_bvec = req->sg_cnt;
 
+	if (!nvmet_check_data_len(req, nvmet_rw_len(req)))
+		return;
+
 	if (!req->sg_cnt || !nr_bvec) {
 		nvmet_req_complete(req, 0);
 		return;
@@ -273,6 +276,8 @@ static void nvmet_file_flush_work(struct work_struct *w)
 
 static void nvmet_file_execute_flush(struct nvmet_req *req)
 {
+	if (!nvmet_check_data_len(req, 0))
+		return;
 	INIT_WORK(&req->f.work, nvmet_file_flush_work);
 	schedule_work(&req->f.work);
 }
@@ -331,6 +336,9 @@ static void nvmet_file_dsm_work(struct work_struct *w)
 
 static void nvmet_file_execute_dsm(struct nvmet_req *req)
 {
+	if (!nvmet_check_data_len(req, nvmet_dsm_len(req)))
+		return;
+
 	INIT_WORK(&req->f.work, nvmet_file_dsm_work);
 	schedule_work(&req->f.work);
 }
@@ -359,6 +367,8 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 
 static void nvmet_file_execute_write_zeroes(struct nvmet_req *req)
 {
+	if (!nvmet_check_data_len(req, 0))
+		return;
 	INIT_WORK(&req->f.work, nvmet_file_write_zeroes_work);
 	schedule_work(&req->f.work);
 }
@@ -371,20 +381,15 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_read:
 	case nvme_cmd_write:
 		req->execute = nvmet_file_execute_rw;
-		req->data_len = nvmet_rw_len(req);
 		return 0;
 	case nvme_cmd_flush:
 		req->execute = nvmet_file_execute_flush;
-		req->data_len = 0;
 		return 0;
 	case nvme_cmd_dsm:
 		req->execute = nvmet_file_execute_dsm;
-		req->data_len = (le32_to_cpu(cmd->dsm.nr) + 1) *
-			sizeof(struct nvme_dsm_range);
 		return 0;
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_file_execute_write_zeroes;
-		req->data_len = 0;
 		return 0;
 	default:
 		pr_err("unhandled cmd for file ns %d on qid %d\n",
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 748a39fca771..710db727f110 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -126,7 +126,7 @@ static void nvme_loop_execute_work(struct work_struct *work)
 	struct nvme_loop_iod *iod =
 		container_of(work, struct nvme_loop_iod, work);
 
-	nvmet_req_execute(&iod->req);
+	iod->req.execute(&iod->req);
 }
 
 static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c51f8dd01dc4..46df45e837c9 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -304,8 +304,6 @@ struct nvmet_req {
 		} f;
 	};
 	int			sg_cnt;
-	/* data length as parsed from the command: */
-	size_t			data_len;
 	/* data length as parsed from the SGL descriptor: */
 	size_t			transfer_len;
 
@@ -375,7 +373,7 @@ u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req);
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		struct nvmet_sq *sq, const struct nvmet_fabrics_ops *ops);
 void nvmet_req_uninit(struct nvmet_req *req);
-void nvmet_req_execute(struct nvmet_req *req);
+bool nvmet_check_data_len(struct nvmet_req *req, size_t data_len);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
 int nvmet_req_alloc_sgl(struct nvmet_req *req);
 void nvmet_req_free_sgl(struct nvmet_req *req);
@@ -495,6 +493,12 @@ static inline u32 nvmet_rw_len(struct nvmet_req *req)
 			req->ns->blksize_shift;
 }
 
+static inline u32 nvmet_dsm_len(struct nvmet_req *req)
+{
+	return (le32_to_cpu(req->cmd->dsm.nr) + 1) *
+		sizeof(struct nvme_dsm_range);
+}
+
 u16 errno_to_nvme_status(struct nvmet_req *req, int errno);
 
 /* Convert a 32-bit number to a 16-bit 0's based number */
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 36d906a7f70d..248e68da2e13 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -603,7 +603,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
-	nvmet_req_execute(&rsp->req);
+	rsp->req.execute(&rsp->req);
 }
 
 static void nvmet_rdma_use_inline_sg(struct nvmet_rdma_rsp *rsp, u32 len,
@@ -746,7 +746,7 @@ static bool nvmet_rdma_execute_command(struct nvmet_rdma_rsp *rsp)
 				queue->cm_id->port_num, &rsp->read_cqe, NULL))
 			nvmet_req_complete(&rsp->req, NVME_SC_DATA_XFER_ERROR);
 	} else {
-		nvmet_req_execute(&rsp->req);
+		rsp->req.execute(&rsp->req);
 	}
 
 	return true;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d535080b781f..1c1e743cb628 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -320,7 +320,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	struct nvme_sgl_desc *sgl = &cmd->req.cmd->common.dptr.sgl;
 	u32 len = le32_to_cpu(sgl->length);
 
-	if (!cmd->req.data_len)
+	if (!len)
 		return 0;
 
 	if (sgl->type == ((NVME_SGL_FMT_DATA_DESC << 4) |
@@ -813,13 +813,14 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd, struct nvmet_req *req)
 {
+	size_t data_len;
 	int ret;
 
 	/* recover the expected data transfer length */
-	req->data_len = le32_to_cpu(req->cmd->common.dptr.sgl.length);
+	data_len = le32_to_cpu(req->cmd->common.dptr.sgl.length);
 
 	if (!nvme_is_write(cmd->req.cmd) ||
-	    req->data_len > cmd->req.port->inline_data_size) {
+	    data_len > cmd->req.port->inline_data_size) {
 		nvmet_prepare_receive_pdu(queue);
 		return;
 	}
@@ -932,7 +933,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 		goto out;
 	}
 
-	nvmet_req_execute(&queue->cmd->req);
+	queue->cmd->req.execute(&queue->cmd->req);
 out:
 	nvmet_prepare_receive_pdu(queue);
 	return ret;
@@ -1052,7 +1053,7 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 			nvmet_tcp_prep_recv_ddgst(cmd);
 			return 0;
 		}
-		nvmet_req_execute(&cmd->req);
+		cmd->req.execute(&cmd->req);
 	}
 
 	nvmet_prepare_receive_pdu(queue);
@@ -1092,7 +1093,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 
 	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
 	    cmd->rbytes_done == cmd->req.transfer_len)
-		nvmet_req_execute(&cmd->req);
+		cmd->req.execute(&cmd->req);
 	ret = 0;
 out:
 	nvmet_prepare_receive_pdu(queue);
-- 
2.20.1

