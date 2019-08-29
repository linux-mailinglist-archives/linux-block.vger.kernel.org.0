Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB634A2359
	for <lists+linux-block@lfdr.de>; Thu, 29 Aug 2019 20:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfH2SPG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 29 Aug 2019 14:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbfH2SPG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Aug 2019 14:15:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AE3B2189D;
        Thu, 29 Aug 2019 18:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102504;
        bh=XZKfI7GPEXf1VuEVjRMuwNrmQbjMSQI1t/1wy7dJtws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EG/RO7LrTqEtX2vI8SM4WzWeIq1YiDXozI8GnQSPTV8mQhz3NkAvoivYHDeu4mXfJ
         vZwvUBelD6AIsfJ45wMkPjqHeugAnxJbp4tCQrnwmK44nYftOWxwSdixhheRVGgQ28
         ff3a1/t41lb+J4Ng8BsScz4lAEMFI3HZFuPX6gp4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Jeffrey M . Birnbaum" <jmbnyc@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 55/76] io_uring: fix potential hang with polled IO
Date:   Thu, 29 Aug 2019 14:12:50 -0400
Message-Id: <20190829181311.7562-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 500f9fbadef86466a435726192f4ca4df7d94236 ]

If a request issue ends up being punted to async context to avoid
blocking, we can get into a situation where the original application
enters the poll loop for that very request before it has been issued.
This should not be an issue, except that the polling will hold the
io_uring uring_ctx mutex for the duration of the poll. When the async
worker has actually issued the request, it needs to acquire this mutex
to add the request to the poll issued list. Since the application
polling is already holding this mutex, the workqueue sleeps on the
mutex forever, and the application thus never gets a chance to poll for
the very request it was interested in.

Fix this by ensuring that the polling drops the uring_ctx occasionally
if it's not making any progress.

Reported-by: Jeffrey M. Birnbaum <jmbnyc@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 61018559e8fe6..5bb01d84f38d3 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -743,11 +743,34 @@ static void io_iopoll_reap_events(struct io_ring_ctx *ctx)
 static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
 			   long min)
 {
-	int ret = 0;
+	int iters, ret = 0;
+
+	/*
+	 * We disallow the app entering submit/complete with polling, but we
+	 * still need to lock the ring to prevent racing with polled issue
+	 * that got punted to a workqueue.
+	 */
+	mutex_lock(&ctx->uring_lock);
 
+	iters = 0;
 	do {
 		int tmin = 0;
 
+		/*
+		 * If a submit got punted to a workqueue, we can have the
+		 * application entering polling for a command before it gets
+		 * issued. That app will hold the uring_lock for the duration
+		 * of the poll right here, so we need to take a breather every
+		 * now and then to ensure that the issue has a chance to add
+		 * the poll to the issued list. Otherwise we can spin here
+		 * forever, while the workqueue is stuck trying to acquire the
+		 * very same mutex.
+		 */
+		if (!(++iters & 7)) {
+			mutex_unlock(&ctx->uring_lock);
+			mutex_lock(&ctx->uring_lock);
+		}
+
 		if (*nr_events < min)
 			tmin = min - *nr_events;
 
@@ -757,6 +780,7 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
 		ret = 0;
 	} while (min && !*nr_events && !need_resched());
 
+	mutex_unlock(&ctx->uring_lock);
 	return ret;
 }
 
@@ -2073,15 +2097,7 @@ static int io_sq_thread(void *data)
 			unsigned nr_events = 0;
 
 			if (ctx->flags & IORING_SETUP_IOPOLL) {
-				/*
-				 * We disallow the app entering submit/complete
-				 * with polling, but we still need to lock the
-				 * ring to prevent racing with polled issue
-				 * that got punted to a workqueue.
-				 */
-				mutex_lock(&ctx->uring_lock);
 				io_iopoll_check(ctx, &nr_events, 0);
-				mutex_unlock(&ctx->uring_lock);
 			} else {
 				/*
 				 * Normal IO, just pretend everything completed.
@@ -2978,9 +2994,7 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		min_complete = min(min_complete, ctx->cq_entries);
 
 		if (ctx->flags & IORING_SETUP_IOPOLL) {
-			mutex_lock(&ctx->uring_lock);
 			ret = io_iopoll_check(ctx, &nr_events, min_complete);
-			mutex_unlock(&ctx->uring_lock);
 		} else {
 			ret = io_cqring_wait(ctx, min_complete, sig, sigsz);
 		}
-- 
2.20.1

