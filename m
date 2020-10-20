Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7A1293732
	for <lists+linux-block@lfdr.de>; Tue, 20 Oct 2020 10:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389676AbgJTIxu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Oct 2020 04:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389671AbgJTIxt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 04:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603184028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E1oYg59Y7b7fc16uKEqEGgDAvrf1UoV+NOdPA4wpeoQ=;
        b=bofMApWX622pmfTwUAYVjKjCKCyDmYPoA2+0MwXvdL+OBDbG/D6UE/uT9UwcS2/QgWZSmu
        llgxVZVL5ufX6R84kFIQYMVPRuydYEX3YGVddYC00FRlQU/KzX7DN/xM4eP7hhYE3R0d9K
        MnFrdN6PJVtxO/c3JF45wGGOGni3Uo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-abpMBjSpN5C-XmftuRec_Q-1; Tue, 20 Oct 2020 04:53:44 -0400
X-MC-Unique: abpMBjSpN5C-XmftuRec_Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEE15835B49;
        Tue, 20 Oct 2020 08:53:42 +0000 (UTC)
Received: from localhost (ovpn-12-164.pek2.redhat.com [10.72.12.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B7735B4AD;
        Tue, 20 Oct 2020 08:53:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Chao Leng <lengchao@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH V2 3/4] nvme: tcp: complete non-IO requests atomically
Date:   Tue, 20 Oct 2020 16:53:00 +0800
Message-Id: <20201020085301.1553959-4-ming.lei@redhat.com>
In-Reply-To: <20201020085301.1553959-1-ming.lei@redhat.com>
References: <20201020085301.1553959-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

During controller's CONNECTING state, admin/fabric/connect requests
are submitted for recovery controller, and we allow to abort this request
directly in time out handler for not blocking setup procedure.

So timout vs. normal completion race exists on these requests since
admin/fabirc/connect queues won't be shutdown before handling timeout
during CONNECTING state.

Add atomic completion for requests from connect/fabric/admin queue for
avoiding the race.

CC: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/tcp.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d6a3e1487354..7e85bd4a8d1b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -30,6 +30,8 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
 
+#define REQ_STATE_COMPLETE     0
+
 enum nvme_tcp_send_state {
 	NVME_TCP_SEND_CMD_PDU = 0,
 	NVME_TCP_SEND_H2C_PDU,
@@ -56,6 +58,8 @@ struct nvme_tcp_request {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+
+	unsigned long		comp_state;
 };
 
 enum nvme_tcp_queue_flags {
@@ -469,6 +473,33 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+/*
+ * requests originated from admin, fabrics and connect_q have to be
+ * completed atomically because we don't cover the race between timeout
+ * and normal completion for these queues.
+ */
+static inline bool nvme_tcp_need_atomic_complete(struct request *rq)
+{
+	return !rq->rq_disk;
+}
+
+static inline void nvme_tcp_clear_rq_complete(struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (unlikely(nvme_tcp_need_atomic_complete(rq)))
+		clear_bit(REQ_STATE_COMPLETE, &req->comp_state);
+}
+
+static inline bool nvme_tcp_mark_rq_complete(struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (unlikely(nvme_tcp_need_atomic_complete(rq)))
+		return !test_and_set_bit(REQ_STATE_COMPLETE, &req->comp_state);
+	return true;
+}
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -483,7 +514,8 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		return -EINVAL;
 	}
 
-	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
+	if (nvme_tcp_mark_rq_complete(rq) &&
+			!nvme_try_complete_req(rq, cqe->status, cqe->result))
 		nvme_complete_rq(rq);
 	queue->nr_cqe++;
 
@@ -674,7 +706,8 @@ static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 {
 	union nvme_result res = {};
 
-	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
+	if (nvme_tcp_mark_rq_complete(rq) &&
+			!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
 		nvme_complete_rq(rq);
 }
 
@@ -2174,7 +2207,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	/* fence other contexts that may complete the command */
 	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
-	if (!blk_mq_request_completed(rq)) {
+	if (nvme_tcp_mark_rq_complete(rq) && !blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
 		blk_mq_complete_request(rq);
 	}
@@ -2315,6 +2348,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(ret))
 		return ret;
 
+	nvme_tcp_clear_rq_complete(rq);
 	blk_mq_start_request(rq);
 
 	nvme_tcp_queue_request(req, true, bd->last);
-- 
2.25.2

