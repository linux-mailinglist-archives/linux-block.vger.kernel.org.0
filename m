Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E02F093F
	for <lists+linux-block@lfdr.de>; Tue,  5 Nov 2019 23:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbfKEWXO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 Nov 2019 17:23:14 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:41337 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbfKEWXN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Nov 2019 17:23:13 -0500
Received: by mail-pf1-f178.google.com with SMTP id p26so17076805pfq.8
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2019 14:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=TVLm4ruVrX8m9Bhwx5HW6bMmrVvPWmbb8Gqhs5MfeNs=;
        b=Bgi11lEuEOS+w9rsnGfF77p4I75nfBpRYsFnZnrqL6sqHdBID1krIKgFOu/TgrCI24
         tcwQId6MCv69QykHqZmtGi5fX1HTVlDjGccoU7SLJQnP7+exjgfJjM5jgIgdJDgC/8gp
         xE8HqgBWLgjfISvOtJPXLUY1Je9X+zRM6d34ifBhkfH+is2B/a1CPs+p5RN3/lUKUudw
         RIG5QqyacodeChrPtIrSDwhEabduk83M6cdxExq74X7Y3yjOTIbJk367YH1pxsAtS+BD
         Jto2RZayMj9c+wk4/kNptWuaLhRYgETDoNchRRcNKg7LWdD4QbjiM+4nFZ6IHq6nHgWT
         topQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=TVLm4ruVrX8m9Bhwx5HW6bMmrVvPWmbb8Gqhs5MfeNs=;
        b=So+cJ7r3NypQZtMxdhI4RP+KiwT943Vk3QES7oEdJ8g1dem87XgbJZOUcpRjYteTxZ
         oaF1IgdQ4RNOuo3HJbZWaBxUuqLahnlIkXTo9J6Vs8ijn2bJ9kR9kvZQkdqwxtgtYWYJ
         t91brGrKOFY6dwBIoyWmMA48H6QT5k7SwdoeLFGOXE48ZUJ9ym2cgYNLdU6unkhI//OJ
         vMz2Sxp0P6+sqeqaO0Y9cnEUsiBp4P3oDWtKWOAiw//Ig076+KlZwIkfiWFOJ2448D3K
         rCHI5hJx7Aek64nzz43LUBkzzfwuArb2/rFti54AFQiGlbKTdCu5wO9Anu0vbH9Rx6IV
         no1w==
X-Gm-Message-State: APjAAAXfrUy7UsRoK0kesyTgDQDeNk8ziAOPCpM7i32P2hIYDXceWRHg
        3wHjzFih2hoV/vFsBm4vpUpbJw==
X-Google-Smtp-Source: APXvYqyx8Op2DRbHgtWfoPFe/S38sygF+vsfA/uCiFpgEbnFBFeC7Ee9Y8l96iMMyBn8UzL9XAqBIQ==
X-Received: by 2002:a62:2942:: with SMTP id p63mr33610614pfp.110.1572992592827;
        Tue, 05 Nov 2019 14:23:12 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id z23sm20163625pgu.16.2019.11.05.14.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 14:23:11 -0800 (PST)
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: enable optimized link handling for
 IORING_OP_POLL_ADD
Message-ID: <615f6b1e-a8a3-1a9d-16b6-a3145a767b51@kernel.dk>
Date:   Tue, 5 Nov 2019 15:23:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As introduced by commit:

ba816ad61fdf ("io_uring: run dependent links inline if possible")

enable inline dependent link running for poll commands.
io_poll_complete_work() is the most important change, as it allows a
linked sequence of { POLL, READ } (for example) to proceed inline
instead of needing to get punted to another async context. The
submission side only potentially matters for sqthread, but may as well
include that bit.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d4ff3e49a78c..d074f3f04a63 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1862,6 +1862,7 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 	struct io_poll_iocb *poll = &req->poll;
 	struct poll_table_struct pt = { ._key = poll->events };
 	struct io_ring_ctx *ctx = req->ctx;
+	struct io_kiocb *nxt = NULL;
 	__poll_t mask = 0;
 
 	if (work->flags & IO_WQ_WORK_CANCEL)
@@ -1888,7 +1889,10 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 	spin_unlock_irq(&ctx->completion_lock);
 
 	io_cqring_ev_posted(ctx);
-	io_put_req(req, NULL);
+
+	io_put_req(req, &nxt);
+	if (nxt)
+		*workptr = &nxt->work;
 }
 
 static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
@@ -1942,7 +1946,8 @@ static void io_poll_queue_proc(struct file *file, struct wait_queue_head *head,
 	add_wait_queue(head, &pt->req->poll.wait);
 }
 
-static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		       struct io_kiocb **nxt)
 {
 	struct io_poll_iocb *poll = &req->poll;
 	struct io_ring_ctx *ctx = req->ctx;
@@ -2005,7 +2010,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 	if (mask) {
 		io_cqring_ev_posted(ctx);
-		io_put_req(req, NULL);
+		io_put_req(req, nxt);
 	}
 	return ipt.error;
 }
@@ -2303,7 +2308,7 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		ret = io_fsync(req, s->sqe, nxt, force_nonblock);
 		break;
 	case IORING_OP_POLL_ADD:
-		ret = io_poll_add(req, s->sqe);
+		ret = io_poll_add(req, s->sqe, nxt);
 		break;
 	case IORING_OP_POLL_REMOVE:
 		ret = io_poll_remove(req, s->sqe);

-- 
Jens Axboe

