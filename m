Return-Path: <linux-block+bounces-23553-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04134AF09A1
	for <lists+linux-block@lfdr.de>; Wed,  2 Jul 2025 06:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381CC4E24A5
	for <lists+linux-block@lfdr.de>; Wed,  2 Jul 2025 04:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9244C7F;
	Wed,  2 Jul 2025 04:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U28Rkha2"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5923A184
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 04:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751429101; cv=none; b=C/27mq3s7ztoLWFvDtQiFoiqo8k9XKCBB4ijcuxo4OzCKdrA26WcbmAFPDmKd8gD9no6Axxx+XMigqGhwESRDnEnfcwXuNKmScQ+OXu0ma4IKq0gLC5IjJq86faC3L4DwrfHS9ZU2mCBJtgibXrdlEVIUQuXYySO1KL2wnoQL+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751429101; c=relaxed/simple;
	bh=egboAkoP9dQKbEW6VQPeA8cVmfRG5fzjj5jrLO+lnUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNlhknfyfS1oWLEu/dLcVwXr6+mhHNNfUbYh82QL9tTTtdU8Y+Oki+4hkLqSmk3iirknDb368ie1NP0VMKb5GGi0nCGTmC0uk7S6e8HAvu/hRqA3WoGkWR7buwjksKkL9kMdj9u5n0IElEfZrLPbiyldGzz4JBE5fTfFYxYO2Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U28Rkha2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751429098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nuu79NNjHW1jIGlTOI/X6UlqkUmozhY6OUCW9xZDIq4=;
	b=U28Rkha2P6sg8OWNNoeWkBxUci/tQt2k9ksCnNadyz499QCV4IG18xa+5SAsh5QU47dCbz
	UhUNGZET2geD+w93izzxZ2lJLWbUDsTT4nkWeOrt7g2YpmLo4R+9UQoIyQlCkDz8X4vDAg
	hh0xQ1SlxHj6N7WtboiYLBQWddIaA5w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-hkKfDChZPWOZv6MoIo1MFA-1; Wed,
 02 Jul 2025 00:04:54 -0400
X-MC-Unique: hkKfDChZPWOZv6MoIo1MFA-1
X-Mimecast-MFC-AGG-ID: hkKfDChZPWOZv6MoIo1MFA_1751429093
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 693E51800287;
	Wed,  2 Jul 2025 04:04:53 +0000 (UTC)
Received: from localhost (unknown [10.72.116.27])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F9261956087;
	Wed,  2 Jul 2025 04:04:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 14/16] selftests: ublk: improve flags naming
Date: Wed,  2 Jul 2025 12:03:38 +0800
Message-ID: <20250702040344.1544077-15-ming.lei@redhat.com>
In-Reply-To: <20250702040344.1544077-1-ming.lei@redhat.com>
References: <20250702040344.1544077-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Improve all kinds of flags naming by adding its host structure suffix for
making code more readable.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 38 ++++++++++++++--------------
 tools/testing/selftests/ublk/kublk.h | 23 ++++++++---------
 2 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index e90260468652..84307bc12f37 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -459,7 +459,7 @@ static int ublk_queue_init(struct ublk_queue *q, unsigned extra_flags)
 	io_buf_size = dev->dev_info.max_io_buf_bytes;
 	for (i = 0; i < q->q_depth; i++) {
 		q->ios[i].buf_addr = NULL;
-		q->ios[i].flags = UBLKSRV_NEED_FETCH_RQ | UBLKSRV_IO_FREE;
+		q->ios[i].flags = UBLKS_IO_NEED_FETCH_RQ | UBLKS_IO_FREE;
 		q->ios[i].tag = i;
 
 		if (ublk_queue_no_buf(q))
@@ -591,7 +591,7 @@ int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io)
 	__u64 user_data;
 
 	/* only freed io can be issued */
-	if (!(io->flags & UBLKSRV_IO_FREE))
+	if (!(io->flags & UBLKS_IO_FREE))
 		return 0;
 
 	/*
@@ -599,14 +599,14 @@ int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io)
 	 * getting data
 	 */
 	if (!(io->flags &
-		(UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP | UBLKSRV_NEED_GET_DATA)))
+		(UBLKS_IO_NEED_FETCH_RQ | UBLKS_IO_NEED_COMMIT_RQ_COMP | UBLKS_IO_NEED_GET_DATA)))
 		return 0;
 
-	if (io->flags & UBLKSRV_NEED_GET_DATA)
+	if (io->flags & UBLKS_IO_NEED_GET_DATA)
 		cmd_op = UBLK_U_IO_NEED_GET_DATA;
-	else if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
+	else if (io->flags & UBLKS_IO_NEED_COMMIT_RQ_COMP)
 		cmd_op = UBLK_U_IO_COMMIT_AND_FETCH_REQ;
-	else if (io->flags & UBLKSRV_NEED_FETCH_RQ)
+	else if (io->flags & UBLKS_IO_NEED_FETCH_RQ)
 		cmd_op = UBLK_U_IO_FETCH_REQ;
 
 	if (io_uring_sq_space_left(&t->ring) < 1)
@@ -649,7 +649,7 @@ int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io)
 
 	ublk_dbg(UBLK_DBG_IO_CMD, "%s: (thread %u qid %d tag %u cmd_op %u) iof %x stopping %d\n",
 			__func__, t->idx, q->q_id, io->tag, cmd_op,
-			io->flags, !!(t->state & UBLKSRV_THREAD_STOPPING));
+			io->flags, !!(t->state & UBLKS_T_STOPPING));
 	return 1;
 }
 
@@ -701,7 +701,7 @@ static int ublk_thread_is_idle(struct ublk_thread *t)
 
 static int ublk_thread_is_done(struct ublk_thread *t)
 {
-	return (t->state & UBLKSRV_THREAD_STOPPING) && ublk_thread_is_idle(t);
+	return (t->state & UBLKS_T_STOPPING) && ublk_thread_is_idle(t);
 }
 
 static inline void ublksrv_handle_tgt_cqe(struct ublk_thread *t,
@@ -727,7 +727,7 @@ static void ublk_handle_cqe(struct ublk_thread *t,
 	unsigned tag = user_data_to_tag(cqe->user_data);
 	unsigned cmd_op = user_data_to_op(cqe->user_data);
 	int fetch = (cqe->res != UBLK_IO_RES_ABORT) &&
-		!(t->state & UBLKSRV_THREAD_STOPPING);
+		!(t->state & UBLKS_T_STOPPING);
 	struct ublk_io *io;
 
 	if (cqe->res < 0 && cqe->res != -ENODEV)
@@ -738,7 +738,7 @@ static void ublk_handle_cqe(struct ublk_thread *t,
 			__func__, cqe->res, q->q_id, tag, cmd_op,
 			is_target_io(cqe->user_data),
 			user_data_to_tgt_data(cqe->user_data),
-			(t->state & UBLKSRV_THREAD_STOPPING));
+			(t->state & UBLKS_T_STOPPING));
 
 	/* Don't retrieve io in case of target io */
 	if (is_target_io(cqe->user_data)) {
@@ -750,8 +750,8 @@ static void ublk_handle_cqe(struct ublk_thread *t,
 	t->cmd_inflight--;
 
 	if (!fetch) {
-		t->state |= UBLKSRV_THREAD_STOPPING;
-		io->flags &= ~UBLKSRV_NEED_FETCH_RQ;
+		t->state |= UBLKS_T_STOPPING;
+		io->flags &= ~UBLKS_IO_NEED_FETCH_RQ;
 	}
 
 	if (cqe->res == UBLK_IO_RES_OK) {
@@ -759,7 +759,7 @@ static void ublk_handle_cqe(struct ublk_thread *t,
 		if (q->tgt_ops->queue_io)
 			q->tgt_ops->queue_io(t, q, tag);
 	} else if (cqe->res == UBLK_IO_RES_NEED_GET_DATA) {
-		io->flags |= UBLKSRV_NEED_GET_DATA | UBLKSRV_IO_FREE;
+		io->flags |= UBLKS_IO_NEED_GET_DATA | UBLKS_IO_FREE;
 		ublk_queue_io_cmd(t, io);
 	} else {
 		/*
@@ -767,10 +767,10 @@ static void ublk_handle_cqe(struct ublk_thread *t,
 		 * piggyback is required.
 		 *
 		 * Marking IO_FREE only, then this io won't be issued since
-		 * we only issue io with (UBLKSRV_IO_FREE | UBLKSRV_NEED_*)
+		 * we only issue io with (UBLKS_IO_FREE | UBLKSRV_NEED_*)
 		 *
 		 * */
-		io->flags = UBLKSRV_IO_FREE;
+		io->flags = UBLKS_IO_FREE;
 	}
 }
 
@@ -797,7 +797,7 @@ static int ublk_process_io(struct ublk_thread *t)
 				t->dev->dev_info.dev_id,
 				t->idx, io_uring_sq_ready(&t->ring),
 				t->cmd_inflight,
-				(t->state & UBLKSRV_THREAD_STOPPING));
+				(t->state & UBLKS_T_STOPPING));
 
 	if (ublk_thread_is_done(t))
 		return -ENODEV;
@@ -806,8 +806,8 @@ static int ublk_process_io(struct ublk_thread *t)
 	reapped = ublk_reap_events_uring(t);
 
 	ublk_dbg(UBLK_DBG_THREAD, "submit result %d, reapped %d stop %d idle %d\n",
-			ret, reapped, (t->state & UBLKSRV_THREAD_STOPPING),
-			(t->state & UBLKSRV_THREAD_IDLE));
+			ret, reapped, (t->state & UBLKS_T_STOPPING),
+			(t->state & UBLKS_T_IDLE));
 
 	return reapped;
 }
@@ -926,7 +926,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		return ret;
 
 	if (ctx->auto_zc_fallback)
-		extra_flags = UBLKSRV_AUTO_BUF_REG_FALLBACK;
+		extra_flags = UBLKS_Q_AUTO_BUF_REG_FALLBACK;
 
 	for (i = 0; i < dinfo->nr_hw_queues; i++) {
 		dev->q[i].dev = dev;
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 9ecb63bc930e..c668472097ff 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -45,9 +45,6 @@
 #define UBLK_CTRL_RING_DEPTH            32
 #define ERROR_EVTFD_DEVID 	-2
 
-/* queue idle timeout */
-#define UBLKSRV_IO_IDLE_SECS		20
-
 #define UBLK_IO_MAX_BYTES               (1 << 20)
 #define UBLK_MAX_QUEUES_SHIFT		5
 #define UBLK_MAX_QUEUES                 (1 << UBLK_MAX_QUEUES_SHIFT)
@@ -121,11 +118,11 @@ struct ublk_ctrl_cmd_data {
 struct ublk_io {
 	char *buf_addr;
 
-#define UBLKSRV_NEED_FETCH_RQ		(1UL << 0)
-#define UBLKSRV_NEED_COMMIT_RQ_COMP	(1UL << 1)
-#define UBLKSRV_IO_FREE			(1UL << 2)
-#define UBLKSRV_NEED_GET_DATA           (1UL << 3)
-#define UBLKSRV_NEED_REG_BUF            (1UL << 4)
+#define UBLKS_IO_NEED_FETCH_RQ		(1UL << 0)
+#define UBLKS_IO_NEED_COMMIT_RQ_COMP	(1UL << 1)
+#define UBLKS_IO_FREE			(1UL << 2)
+#define UBLKS_IO_NEED_GET_DATA           (1UL << 3)
+#define UBLKS_IO_NEED_REG_BUF            (1UL << 4)
 	unsigned short flags;
 	unsigned short refs;		/* used by target code only */
 
@@ -179,7 +176,7 @@ struct ublk_queue {
 	struct ublksrv_io_desc *io_cmd_buf;
 
 /* borrow one bit of ublk uapi flags, which may never be used */
-#define UBLKSRV_AUTO_BUF_REG_FALLBACK	(1ULL << 63)
+#define UBLKS_Q_AUTO_BUF_REG_FALLBACK	(1ULL << 63)
 	__u64 flags;
 	struct ublk_io ios[UBLK_QUEUE_DEPTH];
 };
@@ -193,8 +190,8 @@ struct ublk_thread {
 	pthread_t thread;
 	unsigned idx;
 
-#define UBLKSRV_THREAD_STOPPING	(1U << 0)
-#define UBLKSRV_THREAD_IDLE	(1U << 1)
+#define UBLKS_T_STOPPING	(1U << 0)
+#define UBLKS_T_IDLE	(1U << 1)
 	unsigned state;
 };
 
@@ -377,7 +374,7 @@ static inline int ublk_get_io_res(const struct ublk_queue *q, unsigned tag)
 
 static inline void ublk_mark_io_done(struct ublk_io *io, int res)
 {
-	io->flags |= (UBLKSRV_NEED_COMMIT_RQ_COMP | UBLKSRV_IO_FREE);
+	io->flags |= (UBLKS_IO_NEED_COMMIT_RQ_COMP | UBLKS_IO_FREE);
 	io->result = res;
 }
 
@@ -445,7 +442,7 @@ static inline int ublk_queue_use_auto_zc(const struct ublk_queue *q)
 
 static inline int ublk_queue_auto_zc_fallback(const struct ublk_queue *q)
 {
-	return q->flags & UBLKSRV_AUTO_BUF_REG_FALLBACK;
+	return q->flags & UBLKS_Q_AUTO_BUF_REG_FALLBACK;
 }
 
 static inline int ublk_queue_no_buf(const struct ublk_queue *q)
-- 
2.47.0


