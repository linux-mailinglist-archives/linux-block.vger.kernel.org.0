Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2ADF3405
	for <lists+linux-block@lfdr.de>; Thu,  7 Nov 2019 17:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfKGQAx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 Nov 2019 11:00:53 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39054 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbfKGQAx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Nov 2019 11:00:53 -0500
Received: by mail-io1-f65.google.com with SMTP id k1so2847114ioj.6
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2019 08:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bU0+iqtcSiyBaqJQJPbOCs1gZ3ZQaA7pcubeylIF8oc=;
        b=sYOCla7CfWLQu4BMy3+tt+85xZ4ViVd6lerQtJbVmyQC45UKDS7WUMXrFqOqMuBJ7K
         8xH6LRf7ynccvb+v2LmC17eoChQ1xjGvwgkLnXpK2JfeWQ7MOGuenOqZEz2AKf84SpeW
         cRFmifS9MsxG+qew1DDEdHfYiW5DbXB2TESNLqDRM9/df/pwjdXbRkV5/cu17x5VZxYr
         IxZggOwkAEJD5UtyHnkIri9e2CuAbB8NSlHcFr363kpRUfqA2jW/f0g/Wxsq6YMXbL3Y
         HeBipwuQlTL/OfXrPaQ51fVbBIzzcbCik1rYdB2s5l2tQL7JY7KBmL19BT+sKQwWAWFI
         tAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bU0+iqtcSiyBaqJQJPbOCs1gZ3ZQaA7pcubeylIF8oc=;
        b=Fddf98Xck+gyMlbUEGV7KaQUk8FbK3jrZiKYhBZh6iEvQP8lKDFKEr/og/s7AHVu8F
         lhEXz4LFiSvwpdme5jxkdvxfzPC2zRcMrYCydU+nUf6Z+Mbybnrzqd+J9f28OsULYYnL
         pe3SWADKuOqjjQbTb5pkSCXMwrW65/JG/CfWb2IoILnBPmCDHYTom73DxaxSUYMJULFx
         Xhn2paw/2Y6r9OeBCOXjTwDkRmx5a1dh4hfFpHj43D2OrtG9/odDoOxoVjkieIuVOFGQ
         0gtlXJ3TwB1gMD1DjYaeBZXCZ8AaLx6Vfk5UAmD1aYFPo1TfKk5nQzJ7Qsqyzb7lzeIk
         UYvQ==
X-Gm-Message-State: APjAAAUtUdmOLpYrIxbiB7FOIGhq9+g87BocpTVhEh/2wN/UwUCnj2ZV
        6qC4kvrSBOnpOvoVsVfjyNZPrg==
X-Google-Smtp-Source: APXvYqwfTSvmgKQ7WSrt0AdeSdlKfMn+mwVhCW2TnfYIRAB1qE9KLs68GBdRZ2pHrtYYNW0H1+x+9g==
X-Received: by 2002:a02:a08:: with SMTP id 8mr4848425jaw.98.1573142451458;
        Thu, 07 Nov 2019 08:00:51 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v130sm210438iod.32.2019.11.07.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 08:00:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, asml.silence@gmail.com,
        jannh@google.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] io_uring: add support for backlogged CQ ring
Date:   Thu,  7 Nov 2019 09:00:43 -0700
Message-Id: <20191107160043.31725-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107160043.31725-1-axboe@kernel.dk>
References: <20191107160043.31725-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently we drop completion events, if the CQ ring is full. That's fine
for requests with bounded completion times, but it may make it harder to
use io_uring with networked IO where request completion times are
generally unbounded. Or with POLL, for example, which is also unbounded.

This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a bit
for CQ ring overflows. First of all, it doesn't overflow the ring, it
simply stores a backlog of completions that we weren't able to put into
the CQ ring. To prevent the backlog from growing indefinitely, if the
backlog is non-empty, we apply back pressure on IO submissions. Any
attempt to submit new IO with a non-empty backlog will get an -EBUSY
return from the kernel. This is a signal to the application that it has
backlogged CQ events, and that it must reap those before being allowed
to submit more IO.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 103 ++++++++++++++++++++++++++++------
 include/uapi/linux/io_uring.h |   1 +
 2 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f69d9794ce17..ff0f79a57f7b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -207,6 +207,7 @@ struct io_ring_ctx {
 
 		struct list_head	defer_list;
 		struct list_head	timeout_list;
+		struct list_head	cq_overflow_list;
 
 		wait_queue_head_t	inflight_wait;
 	} ____cacheline_aligned_in_smp;
@@ -414,6 +415,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 
 	ctx->flags = p->flags;
 	init_waitqueue_head(&ctx->cq_wait);
+	INIT_LIST_HEAD(&ctx->cq_overflow_list);
 	init_completion(&ctx->ctx_done);
 	init_completion(&ctx->sqo_thread_started);
 	mutex_init(&ctx->uring_lock);
@@ -588,6 +590,72 @@ static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
 	return &rings->cqes[tail & ctx->cq_mask];
 }
 
+static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
+{
+	if (waitqueue_active(&ctx->wait))
+		wake_up(&ctx->wait);
+	if (waitqueue_active(&ctx->sqo_wait))
+		wake_up(&ctx->sqo_wait);
+	if (ctx->cq_ev_fd)
+		eventfd_signal(ctx->cq_ev_fd, 1);
+}
+
+static void io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
+{
+	struct io_rings *rings = ctx->rings;
+	struct io_uring_cqe *cqe;
+	struct io_kiocb *req;
+	unsigned long flags;
+	LIST_HEAD(list);
+
+	if (list_empty_careful(&ctx->cq_overflow_list))
+		return;
+	if (ctx->cached_cq_tail - READ_ONCE(rings->cq.head) ==
+	    rings->cq_ring_entries)
+		return;
+
+	spin_lock_irqsave(&ctx->completion_lock, flags);
+
+	while (!list_empty(&ctx->cq_overflow_list)) {
+		cqe = io_get_cqring(ctx);
+		if (!cqe && !force)
+			break;
+
+		req = list_first_entry(&ctx->cq_overflow_list, struct io_kiocb,
+						list);
+		list_move(&req->list, &list);
+		if (cqe) {
+			WRITE_ONCE(cqe->user_data, req->user_data);
+			WRITE_ONCE(cqe->res, req->result);
+			WRITE_ONCE(cqe->flags, 0);
+		}
+	}
+
+	io_commit_cqring(ctx);
+	spin_unlock_irqrestore(&ctx->completion_lock, flags);
+	io_cqring_ev_posted(ctx);
+
+	while (!list_empty(&list)) {
+		req = list_first_entry(&list, struct io_kiocb, list);
+		list_del(&req->list);
+		io_put_req(req, NULL);
+	}
+}
+
+static void io_cqring_overflow(struct io_ring_ctx *ctx, struct io_kiocb *req,
+			       long res)
+	__must_hold(&ctx->completion_lock)
+{
+	if (!(ctx->flags & IORING_SETUP_CQ_NODROP)) {
+		WRITE_ONCE(ctx->rings->cq_overflow,
+				atomic_inc_return(&ctx->cached_cq_overflow));
+	} else {
+		refcount_inc(&req->refs);
+		req->result = res;
+		list_add_tail(&req->list, &ctx->cq_overflow_list);
+	}
+}
+
 static void io_cqring_fill_event(struct io_kiocb *req, long res)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -601,26 +669,15 @@ static void io_cqring_fill_event(struct io_kiocb *req, long res)
 	 * the ring.
 	 */
 	cqe = io_get_cqring(ctx);
-	if (cqe) {
+	if (likely(cqe)) {
 		WRITE_ONCE(cqe->user_data, req->user_data);
 		WRITE_ONCE(cqe->res, res);
 		WRITE_ONCE(cqe->flags, 0);
 	} else {
-		WRITE_ONCE(ctx->rings->cq_overflow,
-				atomic_inc_return(&ctx->cached_cq_overflow));
+		io_cqring_overflow(ctx, req, res);
 	}
 }
 
-static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
-{
-	if (waitqueue_active(&ctx->wait))
-		wake_up(&ctx->wait);
-	if (waitqueue_active(&ctx->sqo_wait))
-		wake_up(&ctx->sqo_wait);
-	if (ctx->cq_ev_fd)
-		eventfd_signal(ctx->cq_ev_fd, 1);
-}
-
 static void io_cqring_add_event(struct io_kiocb *req, long res)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -877,6 +934,9 @@ static unsigned io_cqring_events(struct io_ring_ctx *ctx)
 {
 	struct io_rings *rings = ctx->rings;
 
+	if (ctx->flags & IORING_SETUP_CQ_NODROP)
+		io_cqring_overflow_flush(ctx, false);
+
 	/* See comment at the top of this file */
 	smp_rmb();
 	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
@@ -2876,6 +2936,10 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	int i, submitted = 0;
 	bool mm_fault = false;
 
+	if ((ctx->flags & IORING_SETUP_CQ_NODROP) &&
+	    !list_empty(&ctx->cq_overflow_list))
+		return -EBUSY;
+
 	if (nr > IO_PLUG_THRESHOLD) {
 		io_submit_state_start(&state, ctx, nr);
 		statep = &state;
@@ -2967,6 +3031,7 @@ static int io_sq_thread(void *data)
 	timeout = inflight = 0;
 	while (!kthread_should_park()) {
 		unsigned int to_submit;
+		int ret;
 
 		if (inflight) {
 			unsigned nr_events = 0;
@@ -3051,8 +3116,9 @@ static int io_sq_thread(void *data)
 		}
 
 		to_submit = min(to_submit, ctx->sq_entries);
-		inflight += io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm,
-					   true);
+		ret = io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm, true);
+		if (ret > 0)
+			inflight += ret;
 	}
 
 	set_fs(old_fs);
@@ -4116,8 +4182,10 @@ static int io_uring_flush(struct file *file, void *data)
 	struct io_ring_ctx *ctx = file->private_data;
 
 	io_uring_cancel_files(ctx, data);
-	if (fatal_signal_pending(current) || (current->flags & PF_EXITING))
+	if (fatal_signal_pending(current) || (current->flags & PF_EXITING)) {
+		io_cqring_overflow_flush(ctx, true);
 		io_wq_cancel_all(ctx->io_wq);
+	}
 	return 0;
 }
 
@@ -4418,7 +4486,8 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params)
 	}
 
 	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_SQPOLL |
-			IORING_SETUP_SQ_AFF | IORING_SETUP_CQSIZE))
+			IORING_SETUP_SQ_AFF | IORING_SETUP_CQSIZE |
+			IORING_SETUP_CQ_NODROP))
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index f1a118b01d18..3d8517eb376e 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -56,6 +56,7 @@ struct io_uring_sqe {
 #define IORING_SETUP_SQPOLL	(1U << 1)	/* SQ poll thread */
 #define IORING_SETUP_SQ_AFF	(1U << 2)	/* sq_thread_cpu is valid */
 #define IORING_SETUP_CQSIZE	(1U << 3)	/* app defines CQ size */
+#define IORING_SETUP_CQ_NODROP	(1U << 4)	/* no CQ drops */
 
 #define IORING_OP_NOP		0
 #define IORING_OP_READV		1
-- 
2.24.0

