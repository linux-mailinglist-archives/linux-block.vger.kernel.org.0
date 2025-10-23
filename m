Return-Path: <linux-block+bounces-28939-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B755AC0226F
	for <lists+linux-block@lfdr.de>; Thu, 23 Oct 2025 17:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60D014E633E
	for <lists+linux-block@lfdr.de>; Thu, 23 Oct 2025 15:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971CD2FD1DA;
	Thu, 23 Oct 2025 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANPsYDjh"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB83093AC
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233654; cv=none; b=JhRXuuP+pMEgKvMWy17ROvb/NhZvQ0HwIKHKSIWAqFrnHbO5UAxGwZW7KViLVkJfae2JwkzKj8NJnnpWTt4PNL4ZVqjmk9VmDDsL/dwjCBO8W0RvMfuaZUpTFH6zqvG6rXbE909HJLGbuoYh+B3lf2mkpll3WwZaTvP6VlEitZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233654; c=relaxed/simple;
	bh=qBNzbFNT6+95PadO1UGywCHIFg7ych81/YIEeaDDD+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgbUOCj2Djln77xSY3HohKiPW9LlxABRYy9bsqGaRdBdrI+suDLsVJ798sbA8ZrA8xJsRV7/w6VUCHhErCmODTt7qoZGOxQrWI7bvS0sF8mjQkz4wGsei7cXf9wW6wcwsF3uYfkv/CGZnOUXFGwdjRrO0X08OZhXGfokvAJQMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ANPsYDjh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761233651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkwgsKa/nUfF3Ev8QdD3EC/gY6RXHOlynqK647YhKa8=;
	b=ANPsYDjh9gCGpE8ljeAbPAAAUBT4SR96T0bXQ/KWaydDFnyKQWMQA+jnPRK8t89Wq4aLRB
	KCa5m6UfdRNLRqjnkpz8m42OuN/AD6jD8rGOZzYaEE/vYpJY/pngZglAl7mS4R7oh3LZcL
	oIKiXL+9m8qah4ABtL5Wg+dThwSQY4Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-ria1ehZYMyexNeXLyMzO_g-1; Thu,
 23 Oct 2025 11:34:10 -0400
X-MC-Unique: ria1ehZYMyexNeXLyMzO_g-1
X-Mimecast-MFC-AGG-ID: ria1ehZYMyexNeXLyMzO_g_1761233649
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5FB419560AD;
	Thu, 23 Oct 2025 15:34:08 +0000 (UTC)
Received: from localhost (unknown [10.72.120.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 062A330002D7;
	Thu, 23 Oct 2025 15:34:07 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 19/25] selftests: ublk: add ublk_io_buf_idx() for returning io buffer index
Date: Thu, 23 Oct 2025 23:32:24 +0800
Message-ID: <20251023153234.2548062-20-ming.lei@redhat.com>
In-Reply-To: <20251023153234.2548062-1-ming.lei@redhat.com>
References: <20251023153234.2548062-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Since UBLK_F_PER_IO_DAEMON is added, io buffer index may depend on current
thread because the common way is to use per-pthread io_ring_ctx for issuing
ublk uring_cmd.

Add one helper for returning io buffer index, so we can hide the buffer
index implementation details for target code.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/file_backed.c |  9 +++++----
 tools/testing/selftests/ublk/kublk.c       |  9 +++++----
 tools/testing/selftests/ublk/kublk.h       | 10 +++++++++-
 tools/testing/selftests/ublk/null.c        | 18 ++++++++++--------
 tools/testing/selftests/ublk/stripe.c      |  7 ++++---
 5 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 9e7dd3859ea9..58ac59528b74 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -36,6 +36,7 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	enum io_uring_op op = ublk_to_uring_op(iod, zc | auto_zc);
 	struct io_uring_sqe *sqe[3];
 	void *addr = (zc | auto_zc) ? NULL : (void *)iod->addr;
+	unsigned short buf_idx = ublk_io_buf_idx(t, q, tag);
 
 	if (!zc || auto_zc) {
 		ublk_io_alloc_sqes(t, sqe, 1);
@@ -47,7 +48,7 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 				iod->nr_sectors << 9,
 				iod->start_sector << 9);
 		if (auto_zc)
-			sqe[0]->buf_index = tag;
+			sqe[0]->buf_index = buf_idx;
 		io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
 		/* bit63 marks us as tgt io */
 		sqe[0]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
@@ -56,7 +57,7 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 
 	ublk_io_alloc_sqes(t, sqe, 3);
 
-	io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
+	io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, buf_idx);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 	sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
@@ -64,11 +65,11 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	io_uring_prep_rw(op, sqe[1], ublk_get_registered_fd(q, 1) /*fds[1]*/, 0,
 		iod->nr_sectors << 9,
 		iod->start_sector << 9);
-	sqe[1]->buf_index = tag;
+	sqe[1]->buf_index = buf_idx;
 	sqe[1]->flags |= IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
 	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 
-	io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
+	io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, buf_idx);
 	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
 	return 2;
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index f226d66a6eb2..388e85a8d07e 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -579,16 +579,17 @@ static void ublk_dev_unprep(struct ublk_dev *dev)
 	close(dev->fds[0]);
 }
 
-static void ublk_set_auto_buf_reg(const struct ublk_queue *q,
+static void ublk_set_auto_buf_reg(const struct ublk_thread *t,
+				  const struct ublk_queue *q,
 				  struct io_uring_sqe *sqe,
 				  unsigned short tag)
 {
 	struct ublk_auto_buf_reg buf = {};
 
 	if (q->tgt_ops->buf_index)
-		buf.index = q->tgt_ops->buf_index(q, tag);
+		buf.index = q->tgt_ops->buf_index(t, q, tag);
 	else
-		buf.index = q->ios[tag].buf_index;
+		buf.index = ublk_io_buf_idx(t, q, tag);
 
 	if (ublk_queue_auto_zc_fallback(q))
 		buf.flags = UBLK_AUTO_BUF_REG_FALLBACK;
@@ -655,7 +656,7 @@ int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io)
 		cmd->addr	= 0;
 
 	if (ublk_queue_use_auto_zc(q))
-		ublk_set_auto_buf_reg(q, sqe[0], io->tag);
+		ublk_set_auto_buf_reg(t, q, sqe[0], io->tag);
 
 	user_data = build_user_data(io->tag, _IOC_NR(cmd_op), 0, q->q_id, 0);
 	io_uring_sqe_set_data64(sqe[0], user_data);
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index bfd1d7a890f5..c3da64d3b7b0 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -143,7 +143,8 @@ struct ublk_tgt_ops {
 	void (*usage)(const struct ublk_tgt_ops *ops);
 
 	/* return buffer index for UBLK_F_AUTO_BUF_REG */
-	unsigned short (*buf_index)(const struct ublk_queue *, int tag);
+	unsigned short (*buf_index)(const struct ublk_thread *t,
+			const struct ublk_queue *, int tag);
 };
 
 struct ublk_tgt {
@@ -354,6 +355,13 @@ static inline void ublk_set_sqe_cmd_op(struct io_uring_sqe *sqe, __u32 cmd_op)
 	addr[1] = 0;
 }
 
+static inline unsigned short ublk_io_buf_idx(const struct ublk_thread *t,
+					     const struct ublk_queue *q,
+					     unsigned tag)
+{
+	return q->ios[tag].buf_index;
+}
+
 static inline struct ublk_io *ublk_get_io(struct ublk_queue *q, unsigned tag)
 {
 	return &q->ios[tag];
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index 280043f6b689..819f72ac2da9 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -43,12 +43,12 @@ static int ublk_null_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 }
 
 static void __setup_nop_io(int tag, const struct ublksrv_io_desc *iod,
-		struct io_uring_sqe *sqe, int q_id)
+		struct io_uring_sqe *sqe, int q_id, unsigned buf_idx)
 {
 	unsigned ublk_op = ublksrv_get_op(iod);
 
 	io_uring_prep_nop(sqe);
-	sqe->buf_index = tag;
+	sqe->buf_index = buf_idx;
 	sqe->flags |= IOSQE_FIXED_FILE;
 	sqe->rw_flags = IORING_NOP_FIXED_BUFFER | IORING_NOP_INJECT_RESULT;
 	sqe->len = iod->nr_sectors << 9; 	/* injected result */
@@ -60,18 +60,19 @@ static int null_queue_zc_io(struct ublk_thread *t, struct ublk_queue *q,
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 	struct io_uring_sqe *sqe[3];
+	unsigned short buf_idx = ublk_io_buf_idx(t, q, tag);
 
 	ublk_io_alloc_sqes(t, sqe, 3);
 
-	io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
+	io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, buf_idx);
 	sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 
-	__setup_nop_io(tag, iod, sqe[1], q->q_id);
+	__setup_nop_io(tag, iod, sqe[1], q->q_id, buf_idx);
 	sqe[1]->flags |= IOSQE_IO_HARDLINK;
 
-	io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
+	io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, buf_idx);
 	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
 	// buf register is marked as IOSQE_CQE_SKIP_SUCCESS
@@ -85,7 +86,7 @@ static int null_queue_auto_zc_io(struct ublk_thread *t, struct ublk_queue *q,
 	struct io_uring_sqe *sqe[1];
 
 	ublk_io_alloc_sqes(t, sqe, 1);
-	__setup_nop_io(tag, iod, sqe[0], q->q_id);
+	__setup_nop_io(tag, iod, sqe[0], q->q_id, ublk_io_buf_idx(t, q, tag));
 	return 1;
 }
 
@@ -136,11 +137,12 @@ static int ublk_null_queue_io(struct ublk_thread *t, struct ublk_queue *q,
  * return invalid buffer index for triggering auto buffer register failure,
  * then UBLK_IO_RES_NEED_REG_BUF handling is covered
  */
-static unsigned short ublk_null_buf_index(const struct ublk_queue *q, int tag)
+static unsigned short ublk_null_buf_index(const struct ublk_thread *t,
+		const struct ublk_queue *q, int tag)
 {
 	if (ublk_queue_auto_zc_fallback(q))
 		return (unsigned short)-1;
-	return q->ios[tag].buf_index;
+	return ublk_io_buf_idx(t, q, tag);
 }
 
 const struct ublk_tgt_ops null_tgt_ops = {
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 50874858a829..db281a879877 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -135,6 +135,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	struct ublk_io *io = ublk_get_io(q, tag);
 	int i, extra = zc ? 2 : 0;
 	void *base = (zc | auto_zc) ? NULL : (void *)iod->addr;
+	unsigned short buf_idx = ublk_io_buf_idx(t, q, tag);
 
 	io->private_data = s;
 	calculate_stripe_array(conf, iod, s, base);
@@ -142,7 +143,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	ublk_io_alloc_sqes(t, sqe, s->nr + extra);
 
 	if (zc) {
-		io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, io->buf_index);
+		io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, buf_idx);
 		sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 		sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
@@ -158,7 +159,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 				t->start << 9);
 		io_uring_sqe_set_flags(sqe[i], IOSQE_FIXED_FILE);
 		if (auto_zc || zc) {
-			sqe[i]->buf_index = tag;
+			sqe[i]->buf_index = buf_idx;
 			if (zc)
 				sqe[i]->flags |= IOSQE_IO_HARDLINK;
 		}
@@ -168,7 +169,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	if (zc) {
 		struct io_uring_sqe *unreg = sqe[s->nr + 1];
 
-		io_uring_prep_buf_unregister(unreg, q, tag, q->q_id, io->buf_index);
+		io_uring_prep_buf_unregister(unreg, q, tag, q->q_id, buf_idx);
 		unreg->user_data = build_user_data(
 			tag, ublk_cmd_op_nr(unreg->cmd_op), 0, q->q_id, 1);
 	}
-- 
2.47.0


