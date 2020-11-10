Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A032ADED5
	for <lists+linux-block@lfdr.de>; Tue, 10 Nov 2020 19:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgKJSyj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 10 Nov 2020 13:54:39 -0500
Received: from verein.lst.de ([213.95.11.211]:37048 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKJSyj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Nov 2020 13:54:39 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C1AF167373; Tue, 10 Nov 2020 19:54:35 +0100 (CET)
Date:   Tue, 10 Nov 2020 19:54:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH V4 2/6] nvme-core: split nvme_alloc_request()
Message-ID: <20201110185435.GB29983@lst.de>
References: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com> <20201110022405.6707-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110022405.6707-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 09, 2020 at 06:24:01PM -0800, Chaitanya Kulkarni wrote:
> -static inline unsigned int nvme_req_op(struct nvme_command *cmd)
> -{
> -	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
> -}
> -
> -static inline void nvme_init_req_default_timeout(struct request *req)
> +static inline void nvme_init_req_timeout(struct request *req)
>  {
>  	if (req->q->queuedata)
>  		req->timeout = NVME_IO_TIMEOUT;
> @@ -539,28 +534,42 @@ static inline void nvme_init_req_default_timeout(struct request *req)
>  		req->timeout = NVME_ADMIN_TIMEOUT;
>  }
>  
> +static inline unsigned int nvme_req_op(struct nvme_command *cmd)
> +{
> +	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
> +}

This pointlessly moves things around.  I think life would be easier
by merging the previous and this patch into one.  This is what I have
in my local tree at the moment:

---
From 910ac79ef0dcd62bc75e5d57c0d4c57e0cdaaa32 Mon Sep 17 00:00:00 2001
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 9 Nov 2020 18:24:00 -0800
Subject: nvme: split nvme_alloc_request()

Right now nvme_alloc_request() allocates a request from block layer
based on the value of the qid. When qid set to NVME_QID_ANY it used
blk_mq_alloc_request() else blk_mq_alloc_request_hctx().

The function nvme_alloc_request() is called from different context, The
only place where it uses non NVME_QID_ANY value is for fabrics connect
commands :-

nvme_submit_sync_cmd()		NVME_QID_ANY
nvme_features()			NVME_QID_ANY
nvme_sec_submit()		NVME_QID_ANY
nvmf_reg_read32()		NVME_QID_ANY
nvmf_reg_read64()		NVME_QID_ANY
nvmf_reg_write32()		NVME_QID_ANY
nvmf_connect_admin_queue()	NVME_QID_ANY
nvme_submit_user_cmd()		NVME_QID_ANY
	nvme_alloc_request()
nvme_keep_alive()		NVME_QID_ANY
	nvme_alloc_request()
nvme_timeout()			NVME_QID_ANY
	nvme_alloc_request()
nvme_delete_queue()		NVME_QID_ANY
	nvme_alloc_request()
nvmet_passthru_execute_cmd()	NVME_QID_ANY
	nvme_alloc_request()
nvmf_connect_io_queue() 	QID
	__nvme_submit_sync_cmd()
		nvme_alloc_request()

With passthru nvme_alloc_request() now falls into the I/O fast path such
that blk_mq_alloc_request_hctx() is never gets called and that adds
additional branch check in fast path.

Split the nvme_alloc_request() into nvme_alloc_request() and
nvme_alloc_request_qid().

Replace each call of the nvme_alloc_request() with NVME_QID_ANY param
with a call to newly added nvme_alloc_request() without NVME_QID_ANY.

Replace a call to nvme_alloc_request() with QID param with a call to
newly added nvme_alloc_request() and nvme_alloc_request_qid()
based on the qid value set in the __nvme_submit_sync_cmd().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c       | 52 +++++++++++++++++++++++-----------
 drivers/nvme/host/lightnvm.c   |  5 ++--
 drivers/nvme/host/nvme.h       |  2 ++
 drivers/nvme/host/pci.c        |  4 +--
 drivers/nvme/target/passthru.c |  2 +-
 5 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 98bea150e5dc05..fff90200497c8c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -518,21 +518,14 @@ static inline void nvme_clear_nvme_request(struct request *req)
 	}
 }
 
-struct request *nvme_alloc_request(struct request_queue *q,
-		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
+static inline unsigned int nvme_req_op(struct nvme_command *cmd)
 {
-	unsigned op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
-	struct request *req;
-
-	if (qid == NVME_QID_ANY) {
-		req = blk_mq_alloc_request(q, op, flags);
-	} else {
-		req = blk_mq_alloc_request_hctx(q, op, flags,
-				qid ? qid - 1 : 0);
-	}
-	if (IS_ERR(req))
-		return req;
+	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
+}
 
+static inline void nvme_init_request(struct request *req,
+		struct nvme_command *cmd)
+{
 	if (req->q->queuedata)
 		req->timeout = NVME_IO_TIMEOUT;
 	else /* no queuedata implies admin queue */
@@ -541,11 +534,33 @@ struct request *nvme_alloc_request(struct request_queue *q,
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
 	nvme_clear_nvme_request(req);
 	nvme_req(req)->cmd = cmd;
+}
 
+struct request *nvme_alloc_request(struct request_queue *q,
+		struct nvme_command *cmd, blk_mq_req_flags_t flags)
+{
+	struct request *req;
+
+	req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
+	if (!IS_ERR(req))
+		nvme_init_request(req, cmd);
 	return req;
 }
 EXPORT_SYMBOL_GPL(nvme_alloc_request);
 
+struct request *nvme_alloc_request_qid(struct request_queue *q,
+		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
+{
+	struct request *req;
+
+	req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
+			qid ? qid - 1 : 0);
+	if (!IS_ERR(req))
+		nvme_init_request(req, cmd);
+	return req;
+}
+EXPORT_SYMBOL_GPL(nvme_alloc_request_qid);
+
 static int nvme_toggle_streams(struct nvme_ctrl *ctrl, bool enable)
 {
 	struct nvme_command c;
@@ -902,7 +917,10 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	struct request *req;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd, flags, qid);
+	if (qid == NVME_QID_ANY)
+		req = nvme_alloc_request(q, cmd, flags);
+	else
+		req = nvme_alloc_request_qid(q, cmd, flags, qid);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -1073,7 +1091,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	void *meta = NULL;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd, 0, NVME_QID_ANY);
+	req = nvme_alloc_request(q, cmd, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -1148,8 +1166,8 @@ static int nvme_keep_alive(struct nvme_ctrl *ctrl)
 {
 	struct request *rq;
 
-	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd, BLK_MQ_REQ_RESERVED,
-			NVME_QID_ANY);
+	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd,
+			BLK_MQ_REQ_RESERVED);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
 
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 88a7c8eac4556c..470cef3abec3db 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -653,7 +653,7 @@ static struct request *nvme_nvm_alloc_request(struct request_queue *q,
 
 	nvme_nvm_rqtocmd(rqd, ns, cmd);
 
-	rq = nvme_alloc_request(q, (struct nvme_command *)cmd, 0, NVME_QID_ANY);
+	rq = nvme_alloc_request(q, (struct nvme_command *)cmd, 0);
 	if (IS_ERR(rq))
 		return rq;
 
@@ -767,8 +767,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 	DECLARE_COMPLETION_ONSTACK(wait);
 	int ret = 0;
 
-	rq = nvme_alloc_request(q, (struct nvme_command *)vcmd, 0,
-			NVME_QID_ANY);
+	rq = nvme_alloc_request(q, (struct nvme_command *)vcmd, 0);
 	if (IS_ERR(rq)) {
 		ret = -ENOMEM;
 		goto err_cmd;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 824776a8ba13e6..83fb30e317e076 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -611,6 +611,8 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
+		struct nvme_command *cmd, blk_mq_req_flags_t flags);
+struct request *nvme_alloc_request_qid(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid);
 void nvme_cleanup_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6123040ff87204..5e6365dd0c8e9e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1304,7 +1304,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		 req->tag, nvmeq->qid);
 
 	abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
-			BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
+			BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(abort_req)) {
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
@@ -2218,7 +2218,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	cmd.delete_queue.opcode = opcode;
 	cmd.delete_queue.qid = cpu_to_le16(nvmeq->qid);
 
-	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
+	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index a062398305a76d..be8ae59dcb7109 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -248,7 +248,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		timeout = req->sq->ctrl->subsys->admin_timeout;
 	}
 
-	rq = nvme_alloc_request(q, req->cmd, 0, NVME_QID_ANY);
+	rq = nvme_alloc_request(q, req->cmd, 0);
 	if (IS_ERR(rq)) {
 		status = NVME_SC_INTERNAL;
 		goto out_put_ns;
-- 
2.28.0

