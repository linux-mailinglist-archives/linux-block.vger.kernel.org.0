Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6DEAF07E6
	for <lists+linux-block@lfdr.de>; Tue,  5 Nov 2019 22:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfKEVNW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 Nov 2019 16:13:22 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35082 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEVNV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Nov 2019 16:13:21 -0500
Received: by mail-io1-f67.google.com with SMTP id x21so8662640iol.2
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2019 13:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qUMS8Qn700vmmSoXXoZh9YE+RW4pg8n+Ecs4VFmGZAc=;
        b=avbqEbl0Yzgb5fANBahGPEfbMrIHtU9rAGSSDtlnVLE/K8ahbObiTCndgxBZ3t+vf8
         nMLa+krvbUqgQCOuswoRSnZHxZHY1fceIC2pKlsBy1G9nMxgjDDCeYanX1JJOk7STucL
         BI1g27AzA5KUz0KO/ZUAPLfwtbb3cBldPrA/T9hfOFaR3oiSl9FMNJlpIUfNBt0pmIIk
         m8QaUYzQdYq6mVBt8ucS169UtFJnCWDttruKYfy73a6ahk3mh//ix8INFHk6JsMUsmFt
         9YMph6m8cjWZYUYJhhJnJc2o/pKL4gh1Hqs0Mkanaym2XqxLUndTQaj6bK/6NhddCvjX
         MCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUMS8Qn700vmmSoXXoZh9YE+RW4pg8n+Ecs4VFmGZAc=;
        b=d9HvdhvlK6wUa3v5u720F3sHL/u/j4v/TmSRSPKKK31r7sZqax3z5WPpAUJlgIVXbw
         e0KtzT4xrTEgq+Tszv06cQd4XTphxil+lJ8tSiUvmW5NMqPF2ARgTHJ9zVy1SheT6vp+
         V7QvVKViugdkOJAWgnCIQ2XBsDbblBEhZJzOY6XmgWgSyUK/9TWkBZORNMPfQaWSHXyh
         1UaiXouGPkALubNOGUL5ylm3AjzC8povEpCxZCvqDJPkQAQmo51pj26osL/Ar1wD7Uc+
         9dydh/T4w6xFL7bdqX0wN4nNPH6kSVH7mB8JoBP6SjCptjxS8UCqOZCpMTzc/xtN33m6
         r61A==
X-Gm-Message-State: APjAAAXHc4jM2HIAQh6krNBMH+uYb6w5iRkhzJv7RMZyaOUfSSDka1d0
        Y8jOIfConYs6j1lkGeVY3y/S+Q==
X-Google-Smtp-Source: APXvYqw90Y7/vscMMf37F8yIV3cUSaJHPGEH+QG7RW1kPc+VbsO9On6RbVSVhPc9/Uwqo9rvbmUm6w==
X-Received: by 2002:a05:6638:68f:: with SMTP id i15mr15588773jab.37.1572988401025;
        Tue, 05 Nov 2019 13:13:21 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q69sm3065721ilb.4.2019.11.05.13.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 13:13:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
Cc:     zeba.hrvoje@gmail.com, asml.silence@gmail.com, liuyun01@kylinos.cn,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] io_uring: abstract out io_async_cancel_one() helper
Date:   Tue,  5 Nov 2019 14:11:30 -0700
Message-Id: <20191105211130.6130-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191105211130.6130-1-axboe@kernel.dk>
References: <20191105211130.6130-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We're going to need this helper in a future patch, so move it out
of io_async_cancel() and into its own separate function.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7813bc7d5b61..a71c84808dd0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2142,21 +2142,11 @@ static bool io_cancel_cb(struct io_wq_work *work, void *data)
 	return req->user_data == (unsigned long) data;
 }
 
-static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-			   struct io_kiocb **nxt)
+static int io_async_cancel_one(struct io_ring_ctx *ctx, void *sqe_addr)
 {
-	struct io_ring_ctx *ctx = req->ctx;
 	enum io_wq_cancel cancel_ret;
-	void *sqe_addr;
 	int ret = 0;
 
-	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
-		return -EINVAL;
-	if (sqe->flags || sqe->ioprio || sqe->off || sqe->len ||
-	    sqe->cancel_flags)
-		return -EINVAL;
-
-	sqe_addr = (void *) (unsigned long) READ_ONCE(sqe->addr);
 	cancel_ret = io_wq_cancel_cb(ctx->io_wq, io_cancel_cb, sqe_addr);
 	switch (cancel_ret) {
 	case IO_WQ_CANCEL_OK:
@@ -2170,6 +2160,25 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		break;
 	}
 
+	return ret;
+}
+
+static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+			   struct io_kiocb **nxt)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	void *sqe_addr;
+	int ret;
+
+	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
+	if (sqe->flags || sqe->ioprio || sqe->off || sqe->len ||
+	    sqe->cancel_flags)
+		return -EINVAL;
+
+	sqe_addr = (void *) (unsigned long) READ_ONCE(sqe->addr);
+	ret = io_async_cancel_one(ctx, sqe_addr);
+
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
-- 
2.24.0

