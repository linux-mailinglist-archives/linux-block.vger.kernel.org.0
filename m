Return-Path: <linux-block+bounces-28933-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14034C0225A
	for <lists+linux-block@lfdr.de>; Thu, 23 Oct 2025 17:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D76A750460D
	for <lists+linux-block@lfdr.de>; Thu, 23 Oct 2025 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707D3148D9;
	Thu, 23 Oct 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzG3DaPv"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB332F764
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233630; cv=none; b=HmmqBdhCfCgQArrLW9m2GsXRO1nUkV+6iHIRhSiGckucomKwUMW/YlAcaszHYY+sWNlqcie3Ty5Mf4KRzgDZVwwOfhy9TxJfQVW4Xkpu22JiDnB89HQL3TSl2/mDo+3Jw45HYhZryz7Zg44fHlQ5t8t4un841o7ri6Ff133LU84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233630; c=relaxed/simple;
	bh=0jgDNQzG57CCrXHRgBdUbdUkZAccQbGnDwFqsxIKIxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fI5AuvvbMdACYtgVioxnoB4f9LJKBWLAXryccMGmFFPD0HpzqsUJhTg1XT+4B411AQJ20ciKw4Tw53qRhBLKM95V/e6Gj/qlnzSz5MTVr8r4RFbhBjW1/4O/OWLmcamBnEeNhqljOCT/iwXkHhbS16tV2p2yyhzsLe3iXKjO9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzG3DaPv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761233625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Vv/dzTJFEnYRUGQ73AYWqfRaTzgoPhPYTAm4OGlnwQ=;
	b=hzG3DaPviiGx9EHdnKPQmgzhp9l17jTNm+AyGc4GSsV6HOU2DUUnA9xmsMC0Mr7LvbxF7U
	HEWY9VmBGDvto/yazfnQrV9ox8NAZzPqLrfPFYR3cXvG/Xe079JUaFg9QHDKoxN76seunZ
	jrdhPk4HChzt/vaoNSogxRnUfp5MO1E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-zw5Hk7oFN2WscLIoRy0RUQ-1; Thu,
 23 Oct 2025 11:33:44 -0400
X-MC-Unique: zw5Hk7oFN2WscLIoRy0RUQ-1
X-Mimecast-MFC-AGG-ID: zw5Hk7oFN2WscLIoRy0RUQ_1761233623
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6614518002C1;
	Thu, 23 Oct 2025 15:33:43 +0000 (UTC)
Received: from localhost (unknown [10.72.120.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 585F119540EB;
	Thu, 23 Oct 2025 15:33:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 13/25] ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing
Date: Thu, 23 Oct 2025 23:32:18 +0800
Message-ID: <20251023153234.2548062-14-ming.lei@redhat.com>
In-Reply-To: <20251023153234.2548062-1-ming.lei@redhat.com>
References: <20251023153234.2548062-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add UBLK_U_IO_FETCH_IO_CMDS command to enable efficient batch processing
of I/O requests. This multishot uring_cmd allows the ublk server to fetch
multiple I/O commands in a single operation, significantly reducing
submission overhead compared to individual FETCH_REQ* commands.

Key Design Features:

1. Multishot Operation: One UBLK_U_IO_FETCH_IO_CMDS can fetch many I/O
   commands, with the batch size limited by the provided buffer length.

2. Dynamic Load Balancing: Multiple fetch commands can be submitted
   simultaneously, but only one is active at any time. This enables
   efficient load distribution across multiple server task contexts.

3. Implicit State Management: The implementation uses three key variables
   to track state:
   - evts_fifo: Queue of request tags awaiting processing
   - fcmd_head: List of available fetch commands
   - active_fcmd: Currently active fetch command (NULL = none active)

   States are derived implicitly:
   - IDLE: No fetch commands available
   - READY: Fetch commands available, none active
   - ACTIVE: One fetch command processing events

4. Lockless Reader Optimization: The active fetch command can read from
   evts_fifo without locking (single reader guarantee), while writers
   (ublk_queue_rq/ublk_queue_rqs) use evts_lock protection.

Implementation Details:

- ublk_queue_rq() and ublk_queue_rqs() save request tags to evts_fifo
- __ublk_pick_active_fcmd() selects an available fetch command when
  events arrive and no command is currently active
- ublk_batch_dispatch() moves tags from evts_fifo to the fetch command's
  buffer and posts completion via io_uring_mshot_cmd_post_cqe()
- State transitions are coordinated via evts_lock to maintain consistency

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 394 +++++++++++++++++++++++++++++++---
 include/uapi/linux/ublk_cmd.h |   7 +
 2 files changed, 370 insertions(+), 31 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 412cf1f6ecbc..6b9b47b1b4ca 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -93,6 +93,7 @@
 
 /* ublk batch fetch uring_cmd */
 struct ublk_batch_fcmd {
+	struct list_head node;
 	struct io_uring_cmd *cmd;
 	unsigned short buf_group;
 };
@@ -117,7 +118,10 @@ struct ublk_uring_cmd_pdu {
 	 */
 	struct ublk_queue *ubq;
 
-	u16 tag;
+	union {
+		u16 tag;
+		struct ublk_batch_fcmd *fcmd; /* batch io only */
+	};
 };
 
 struct ublk_batch_io_data {
@@ -226,18 +230,36 @@ struct ublk_queue {
 	struct ublk_device *dev;
 
 	/*
-	 * Inflight ublk request tag is saved in this fifo
+	 * Batch I/O State Management:
+	 *
+	 * The batch I/O system uses implicit state management based on the
+	 * combination of three key variables below.
+	 *
+	 * - IDLE: list_empty(&fcmd_head) && !active_fcmd
+	 *   No fetch commands available, events queue in evts_fifo
+	 *
+	 * - READY: !list_empty(&fcmd_head) && !active_fcmd
+	 *   Fetch commands available but none processing events
 	 *
-	 * There are multiple writer from ublk_queue_rq() or ublk_queue_rqs(),
-	 * so lock is required for storing request tag to fifo
+	 * - ACTIVE: active_fcmd
+	 *   One fetch command actively processing events from evts_fifo
 	 *
-	 * Make sure just one reader for fetching request from task work
-	 * function to ublk server, so no need to grab the lock in reader
-	 * side.
+	 * Key Invariants:
+	 * - At most one active_fcmd at any time (single reader)
+	 * - active_fcmd is always from fcmd_head list when non-NULL
+	 * - evts_fifo can be read locklessly by the single active reader
+	 * - All state transitions require evts_lock protection
+	 * - Multiple writers to evts_fifo require lock protection
 	 */
 	struct {
 		DECLARE_KFIFO_PTR(evts_fifo, unsigned short);
 		spinlock_t evts_lock;
+
+		/* List of fetch commands available to process events */
+		struct list_head fcmd_head;
+
+		/* Currently active fetch command (NULL = none active) */
+		struct ublk_batch_fcmd  *active_fcmd;
 	}____cacheline_aligned_in_smp;
 
 	struct ublk_io ios[];
@@ -290,12 +312,22 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
+static void ublk_batch_dispatch(struct ublk_queue *ubq,
+				struct ublk_batch_io_data *data,
+				struct ublk_batch_fcmd *fcmd);
+static struct ublk_batch_fcmd *__ublk_pick_active_fcmd(
+		struct ublk_queue *ubq);
 
 static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
 {
 	return false;
 }
 
+static inline bool ublk_support_batch_io(const struct ublk_queue *ubq)
+{
+	return false;
+}
+
 static inline void ublk_io_lock(struct ublk_io *io)
 {
 	spin_lock(&io->lock);
@@ -621,13 +653,40 @@ static wait_queue_head_t ublk_idr_wq;	/* wait until one idr is freed */
 
 static DEFINE_MUTEX(ublk_ctl_mutex);
 
+static struct ublk_batch_fcmd *
+ublk_batch_alloc_fcmd(struct io_uring_cmd *cmd)
+{
+	struct ublk_batch_fcmd *fcmd = kzalloc(sizeof(*fcmd), GFP_NOIO);
+
+	if (fcmd) {
+		fcmd->cmd = cmd;
+		fcmd->buf_group = READ_ONCE(cmd->sqe->buf_index);
+	}
+	return fcmd;
+}
 
-static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_io_data *data,
+static void ublk_batch_free_fcmd(struct ublk_batch_fcmd *fcmd)
+{
+	kfree(fcmd);
+}
+
+/*
+ * Nothing can move on, so clear ->active_fcmd, and the caller should stop
+ * dispatching
+ */
+static void ublk_batch_deinit_fetch_buf(struct ublk_queue *ubq,
+					const struct ublk_batch_io_data *data,
 					struct ublk_batch_fcmd *fcmd,
 					int res)
 {
+	spin_lock(&ubq->evts_lock);
+	list_del(&fcmd->node);
+	WARN_ON_ONCE(fcmd != ubq->active_fcmd);
+	ubq->active_fcmd = NULL;
+	spin_unlock(&ubq->evts_lock);
+
 	io_uring_cmd_done(fcmd->cmd, res, data->issue_flags);
-	fcmd->cmd = NULL;
+	ublk_batch_free_fcmd(fcmd);
 }
 
 static int ublk_batch_fetch_post_cqe(struct ublk_batch_fcmd *fcmd,
@@ -1524,6 +1583,8 @@ static int __ublk_batch_dispatch(struct ublk_queue *ubq,
 	size_t len = 0;
 	int ret;
 
+	WARN_ON_ONCE(data->cmd != fcmd->cmd);
+
 	sel = io_uring_cmd_buffer_select(fcmd->cmd, fcmd->buf_group, &len,
 					 data->issue_flags);
 	if (sel.val < 0)
@@ -1550,23 +1611,79 @@ static int __ublk_batch_dispatch(struct ublk_queue *ubq,
 	return ret;
 }
 
-static __maybe_unused int
-ublk_batch_dispatch(struct ublk_queue *ubq,
-		    const struct ublk_batch_io_data *data,
-		    struct ublk_batch_fcmd *fcmd)
+static struct ublk_batch_fcmd *__ublk_pick_active_fcmd(
+		struct ublk_queue *ubq)
 {
+	struct ublk_batch_fcmd *fcmd;
+
+	lockdep_assert_held(&ubq->evts_lock);
+
+	if (!ublk_io_evts_empty(ubq) && !ubq->active_fcmd) {
+		smp_mb();
+		fcmd = ubq->active_fcmd = list_first_entry_or_null(
+				&ubq->fcmd_head, struct ublk_batch_fcmd, node);
+	} else {
+		fcmd = NULL;
+	}
+	return fcmd;
+}
+
+static void ublk_batch_tw_cb(struct io_uring_cmd *cmd,
+			   unsigned int issue_flags)
+{
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	struct ublk_batch_fcmd *fcmd = pdu->fcmd;
+	struct ublk_batch_io_data data = {
+		.ub = pdu->ubq->dev,
+		.cmd = fcmd->cmd,
+		.issue_flags = issue_flags,
+	};
+
+	WARN_ON_ONCE(pdu->ubq->active_fcmd != fcmd);
+
+	ublk_batch_dispatch(pdu->ubq, &data, fcmd);
+}
+
+static void ublk_batch_dispatch(struct ublk_queue *ubq,
+				struct ublk_batch_io_data *data,
+				struct ublk_batch_fcmd *fcmd)
+{
+	struct ublk_batch_fcmd *new_fcmd;
+	void *handle;
+	bool empty;
 	int ret = 0;
 
+again:
 	while (!ublk_io_evts_empty(ubq)) {
 		ret = __ublk_batch_dispatch(ubq, data, fcmd);
 		if (ret <= 0)
 			break;
 	}
 
-	if (ret < 0)
-		ublk_batch_deinit_fetch_buf(data, fcmd, ret);
+	if (ret < 0) {
+		ublk_batch_deinit_fetch_buf(ubq, data, fcmd, ret);
+		return;
+	}
 
-	return ret;
+	handle = io_uring_cmd_ctx_handle(fcmd->cmd);
+	ubq->active_fcmd = NULL;
+	smp_mb();
+	empty = ublk_io_evts_empty(ubq);
+	if (likely(empty))
+		return;
+
+	spin_lock(&ubq->evts_lock);
+	new_fcmd = __ublk_pick_active_fcmd(ubq);
+	spin_unlock(&ubq->evts_lock);
+
+	if (!new_fcmd)
+		return;
+	if (handle == io_uring_cmd_ctx_handle(new_fcmd->cmd)) {
+		data->cmd = new_fcmd->cmd;
+		fcmd = new_fcmd;
+		goto again;
+	}
+	io_uring_cmd_complete_in_task(new_fcmd->cmd, ublk_batch_tw_cb);
 }
 
 static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
@@ -1578,13 +1695,27 @@ static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
 	ublk_dispatch_req(ubq, pdu->req, issue_flags);
 }
 
-static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
+static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq, bool last)
 {
-	struct io_uring_cmd *cmd = ubq->ios[rq->tag].cmd;
-	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	if (ublk_support_batch_io(ubq)) {
+		unsigned short tag = rq->tag;
+		struct ublk_batch_fcmd *fcmd = NULL;
+
+		spin_lock(&ubq->evts_lock);
+		kfifo_put(&ubq->evts_fifo, tag);
+		if (last)
+			fcmd = __ublk_pick_active_fcmd(ubq);
+		spin_unlock(&ubq->evts_lock);
+
+		if (fcmd)
+			io_uring_cmd_complete_in_task(fcmd->cmd, ublk_batch_tw_cb);
+	} else {
+		struct io_uring_cmd *cmd = ubq->ios[rq->tag].cmd;
+		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 
-	pdu->req = rq;
-	io_uring_cmd_complete_in_task(cmd, ublk_cmd_tw_cb);
+		pdu->req = rq;
+		io_uring_cmd_complete_in_task(cmd, ublk_cmd_tw_cb);
+	}
 }
 
 static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
@@ -1602,14 +1733,44 @@ static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
 	} while (rq);
 }
 
-static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
+static void ublk_batch_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
 {
-	struct io_uring_cmd *cmd = io->cmd;
-	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	unsigned short tags[MAX_NR_TAG];
+	struct ublk_batch_fcmd *fcmd;
+	struct request *rq;
+	unsigned cnt = 0;
+
+	spin_lock(&ubq->evts_lock);
+	rq_list_for_each(l, rq) {
+		tags[cnt++] = (unsigned short)rq->tag;
+		if (cnt >= MAX_NR_TAG) {
+			kfifo_in(&ubq->evts_fifo, tags, cnt);
+			cnt = 0;
+		}
+	}
+	if (cnt)
+		kfifo_in(&ubq->evts_fifo, tags, cnt);
+	fcmd = __ublk_pick_active_fcmd(ubq);
+	spin_unlock(&ubq->evts_lock);
 
-	pdu->req_list = rq_list_peek(l);
 	rq_list_init(l);
-	io_uring_cmd_complete_in_task(cmd, ublk_cmd_list_tw_cb);
+	if (fcmd)
+		io_uring_cmd_complete_in_task(fcmd->cmd, ublk_batch_tw_cb);
+}
+
+static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct ublk_io *io,
+				struct rq_list *l, bool batch)
+{
+	if (batch) {
+		ublk_batch_queue_cmd_list(ubq, l);
+	} else {
+		struct io_uring_cmd *cmd = io->cmd;
+		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+
+		pdu->req_list = rq_list_peek(l);
+		rq_list_init(l);
+		io_uring_cmd_complete_in_task(cmd, ublk_cmd_list_tw_cb);
+	}
 }
 
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
@@ -1688,7 +1849,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return BLK_STS_OK;
 	}
 
-	ublk_queue_cmd(ubq, rq);
+	ublk_queue_cmd(ubq, rq, bd->last);
 	return BLK_STS_OK;
 }
 
@@ -1700,11 +1861,25 @@ static inline bool ublk_belong_to_same_batch(const struct ublk_io *io,
 		(io->task == io2->task);
 }
 
-static void ublk_queue_rqs(struct rq_list *rqlist)
+static void ublk_commit_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	struct ublk_queue *ubq = hctx->driver_data;
+	struct ublk_batch_fcmd *fcmd;
+
+	spin_lock(&ubq->evts_lock);
+	fcmd = __ublk_pick_active_fcmd(ubq);
+	spin_unlock(&ubq->evts_lock);
+
+	if (fcmd)
+		io_uring_cmd_complete_in_task(fcmd->cmd, ublk_batch_tw_cb);
+}
+
+static void __ublk_queue_rqs(struct rq_list *rqlist, bool batch)
 {
 	struct rq_list requeue_list = { };
 	struct rq_list submit_list = { };
 	struct ublk_io *io = NULL;
+	struct ublk_queue *ubq = NULL;
 	struct request *req;
 
 	while ((req = rq_list_pop(rqlist))) {
@@ -1718,16 +1893,27 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
 
 		if (io && !ublk_belong_to_same_batch(io, this_io) &&
 				!rq_list_empty(&submit_list))
-			ublk_queue_cmd_list(io, &submit_list);
+			ublk_queue_cmd_list(ubq, io, &submit_list, batch);
 		io = this_io;
+		ubq = this_q;
 		rq_list_add_tail(&submit_list, req);
 	}
 
 	if (!rq_list_empty(&submit_list))
-		ublk_queue_cmd_list(io, &submit_list);
+		ublk_queue_cmd_list(ubq, io, &submit_list, batch);
 	*rqlist = requeue_list;
 }
 
+static void ublk_queue_rqs(struct rq_list *rqlist)
+{
+	__ublk_queue_rqs(rqlist, false);
+}
+
+static void ublk_batch_queue_rqs(struct rq_list *rqlist)
+{
+	__ublk_queue_rqs(rqlist, true);
+}
+
 static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
 		unsigned int hctx_idx)
 {
@@ -1745,6 +1931,14 @@ static const struct blk_mq_ops ublk_mq_ops = {
 	.timeout	= ublk_timeout,
 };
 
+static const struct blk_mq_ops ublk_batch_mq_ops = {
+	.commit_rqs	= ublk_commit_rqs,
+	.queue_rq       = ublk_queue_rq,
+	.queue_rqs      = ublk_batch_queue_rqs,
+	.init_hctx	= ublk_init_hctx,
+	.timeout	= ublk_timeout,
+};
+
 static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 {
 	int i;
@@ -2122,6 +2316,56 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
 		io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, issue_flags);
 }
 
+static void ublk_batch_cancel_cmd(struct ublk_queue *ubq,
+				  struct ublk_batch_fcmd *fcmd,
+				  unsigned int issue_flags)
+{
+	bool done;
+
+	spin_lock(&ubq->evts_lock);
+	done = (ubq->active_fcmd != fcmd);
+	if (done)
+		list_del(&fcmd->node);
+	spin_unlock(&ubq->evts_lock);
+
+	if (done) {
+		io_uring_cmd_done(fcmd->cmd, UBLK_IO_RES_ABORT, issue_flags);
+		ublk_batch_free_fcmd(fcmd);
+	}
+}
+
+static void ublk_batch_cancel_queue(struct ublk_queue *ubq)
+{
+	LIST_HEAD(fcmd_list);
+
+	spin_lock(&ubq->evts_lock);
+	ubq->force_abort = true;
+	list_splice_init(&ubq->fcmd_head, &fcmd_list);
+	if (ubq->active_fcmd)
+		list_move(&ubq->active_fcmd->node, &ubq->fcmd_head);
+	spin_unlock(&ubq->evts_lock);
+
+	while (!list_empty(&fcmd_list)) {
+		struct ublk_batch_fcmd *fcmd = list_first_entry(&fcmd_list,
+				struct ublk_batch_fcmd, node);
+
+		ublk_batch_cancel_cmd(ubq, fcmd, IO_URING_F_UNLOCKED);
+	}
+}
+
+static void ublk_batch_cancel_fn(struct io_uring_cmd *cmd,
+				 unsigned int issue_flags)
+{
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	struct ublk_batch_fcmd *fcmd = pdu->fcmd;
+	struct ublk_queue *ubq = pdu->ubq;
+
+	if (!ubq->canceling)
+		ublk_start_cancel(ubq->dev);
+
+	ublk_batch_cancel_cmd(ubq, fcmd, issue_flags);
+}
+
 /*
  * The ublk char device won't be closed when calling cancel fn, so both
  * ublk device and queue are guaranteed to be live
@@ -2173,6 +2417,11 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
 {
 	int i;
 
+	if (ublk_support_batch_io(ubq)) {
+		ublk_batch_cancel_queue(ubq);
+		return;
+	}
+
 	for (i = 0; i < ubq->q_depth; i++)
 		ublk_cancel_cmd(ubq, i, IO_URING_F_UNLOCKED);
 }
@@ -3131,6 +3380,74 @@ static int ublk_check_batch_cmd(const struct ublk_batch_io_data *data)
 	return ublk_check_batch_cmd_flags(uc);
 }
 
+static int ublk_batch_attach(struct ublk_queue *ubq,
+			     struct ublk_batch_io_data *data,
+			     struct ublk_batch_fcmd *fcmd)
+{
+	struct ublk_batch_fcmd *new_fcmd = NULL;
+	bool free = false;
+
+	spin_lock(&ubq->evts_lock);
+	if (unlikely(ubq->force_abort || ubq->canceling)) {
+		free = true;
+	} else {
+		list_add_tail(&fcmd->node, &ubq->fcmd_head);
+		new_fcmd = __ublk_pick_active_fcmd(ubq);
+	}
+	spin_unlock(&ubq->evts_lock);
+
+	/*
+	 * If the two fetch commands are originated from same io_ring_ctx,
+	 * run batch dispatch directly. Otherwise, schedule task work for
+	 * doing it.
+	 */
+	if (new_fcmd && io_uring_cmd_ctx_handle(new_fcmd->cmd) ==
+			io_uring_cmd_ctx_handle(fcmd->cmd)) {
+		data->cmd = new_fcmd->cmd;
+		ublk_batch_dispatch(ubq, data, new_fcmd);
+	} else if (new_fcmd) {
+		io_uring_cmd_complete_in_task(new_fcmd->cmd,
+				ublk_batch_tw_cb);
+	}
+
+	if (free) {
+		ublk_batch_free_fcmd(fcmd);
+		return -ENODEV;
+	}
+	return -EIOCBQUEUED;
+}
+
+static int ublk_handle_batch_fetch_cmd(struct ublk_batch_io_data *data)
+{
+	struct ublk_queue *ubq = ublk_get_queue(data->ub, data->header.q_id);
+	struct ublk_batch_fcmd *fcmd = ublk_batch_alloc_fcmd(data->cmd);
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(data->cmd);
+
+	if (!fcmd)
+		return -ENOMEM;
+
+	pdu->ubq = ubq;
+	pdu->fcmd = fcmd;
+	io_uring_cmd_mark_cancelable(data->cmd, data->issue_flags);
+
+	return ublk_batch_attach(ubq, data, fcmd);
+}
+
+static int ublk_validate_batch_fetch_cmd(struct ublk_batch_io_data *data,
+					 const struct ublk_batch_io *uc)
+{
+	if (!(data->cmd->flags & IORING_URING_CMD_MULTISHOT))
+		return -EINVAL;
+
+	if (uc->elem_bytes != sizeof(__u16))
+		return -EINVAL;
+
+	if (uc->flags != 0)
+		return -E2BIG;
+
+	return 0;
+}
+
 static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 				       unsigned int issue_flags)
 {
@@ -3153,6 +3470,11 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 	if (data.header.q_id >= ub->dev_info.nr_hw_queues)
 		goto out;
 
+	if (unlikely(issue_flags & IO_URING_F_CANCEL)) {
+		ublk_batch_cancel_fn(cmd, issue_flags);
+		return 0;
+	}
+
 	switch (cmd_op) {
 	case UBLK_U_IO_PREP_IO_CMDS:
 		ret = ublk_check_batch_cmd(&data);
@@ -3166,6 +3488,12 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 			goto out;
 		ret = ublk_handle_batch_commit_cmd(&data);
 		break;
+	case UBLK_U_IO_FETCH_IO_CMDS:
+		ret = ublk_validate_batch_fetch_cmd(&data, uc);
+		if (ret)
+			goto out;
+		ret = ublk_handle_batch_fetch_cmd(&data);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 	}
@@ -3342,6 +3670,7 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 		ret = ublk_io_evts_init(ubq, ubq->q_depth);
 		if (ret)
 			goto fail;
+		INIT_LIST_HEAD(&ubq->fcmd_head);
 	}
 	return 0;
 fail:
@@ -3473,7 +3802,10 @@ static void ublk_align_max_io_size(struct ublk_device *ub)
 
 static int ublk_add_tag_set(struct ublk_device *ub)
 {
-	ub->tag_set.ops = &ublk_mq_ops;
+	if (ublk_dev_support_batch_io(ub))
+		ub->tag_set.ops = &ublk_batch_mq_ops;
+	else
+		ub->tag_set.ops = &ublk_mq_ops;
 	ub->tag_set.nr_hw_queues = ub->dev_info.nr_hw_queues;
 	ub->tag_set.queue_depth = ub->dev_info.queue_depth;
 	ub->tag_set.numa_node = NUMA_NO_NODE;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index a56a50bbb00a..8a06eebdedaf 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -120,6 +120,13 @@
 #define	UBLK_U_IO_COMMIT_IO_CMDS	\
 	_IOWR('u', 0x26, struct ublk_batch_io)
 
+/*
+ * Fetch io commands to provided buffer in multishot style,
+ * `IORING_URING_CMD_MULTISHOT` is required for this command.
+ */
+#define	UBLK_U_IO_FETCH_IO_CMDS 	\
+	_IOWR('u', 0x27, struct ublk_batch_io)
+
 /* only ABORT means that no re-fetch */
 #define UBLK_IO_RES_OK			0
 #define UBLK_IO_RES_NEED_GET_DATA	1
-- 
2.47.0


