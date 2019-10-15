Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33387D778C
	for <lists+linux-block@lfdr.de>; Tue, 15 Oct 2019 15:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbfJONiH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Oct 2019 09:38:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3769 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728880AbfJONiH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 09:38:07 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 81F8A3659B24A6905F77;
        Tue, 15 Oct 2019 21:38:02 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 15 Oct 2019 21:37:52 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <yangerkun@huawei.com>, <yi.zhang@huawei.com>, <houtao1@huawei.com>
Subject: [PATCH V3] io_uring: consider the overflow of sequence for timeout req
Date:   Tue, 15 Oct 2019 21:59:29 +0800
Message-ID: <20191015135929.30912-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now we recalculate the sequence of timeout with 'req->sequence =
ctx->cached_sq_head + count - 1', judge the right place to insert
for timeout_list by compare the number of request we still expected for
completion. But we have not consider about the situation of overflow:

1. ctx->cached_sq_head + count - 1 may overflow. And a bigger count for
the new timeout req can have a small req->sequence.

2. cached_sq_head of now may overflow compare with before req. And it
will lead the timeout req with small req->sequence.

This overflow will lead to the misorder of timeout_list, which can lead
to the wrong order of the completion of timeout_list. Fix it by reuse
req->submit.sequence to store the count, and change the logic of
inserting sort in io_timeout.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/io_uring.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 76fdbe84aff5..c9512da06973 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1884,7 +1884,7 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 
 static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
-	unsigned count, req_dist, tail_index;
+	unsigned count;
 	struct io_ring_ctx *ctx = req->ctx;
 	struct list_head *entry;
 	struct timespec64 ts;
@@ -1907,21 +1907,36 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		count = 1;
 
 	req->sequence = ctx->cached_sq_head + count - 1;
+	/* reuse it to store the count */
+	req->submit.sequence = count;
 	req->flags |= REQ_F_TIMEOUT;
 
 	/*
 	 * Insertion sort, ensuring the first entry in the list is always
 	 * the one we need first.
 	 */
-	tail_index = ctx->cached_cq_tail - ctx->rings->sq_dropped;
-	req_dist = req->sequence - tail_index;
 	spin_lock_irq(&ctx->completion_lock);
 	list_for_each_prev(entry, &ctx->timeout_list) {
 		struct io_kiocb *nxt = list_entry(entry, struct io_kiocb, list);
-		unsigned dist;
+		unsigned nxt_sq_head;
+		long long tmp, tmp_nxt;
 
-		dist = nxt->sequence - tail_index;
-		if (req_dist >= dist)
+		/*
+		 * Since cached_sq_head + count - 1 can overflow, use type long
+		 * long to store it.
+		 */
+		tmp = (long long)ctx->cached_sq_head + count - 1;
+		nxt_sq_head = nxt->sequence - nxt->submit.sequence + 1;
+		tmp_nxt = (long long)nxt_sq_head + nxt->submit.sequence - 1;
+
+		/*
+		 * cached_sq_head may overflow, and it will never overflow twice
+		 * once there is some timeout req still be valid.
+		 */
+		if (ctx->cached_sq_head < nxt_sq_head)
+			tmp_nxt += UINT_MAX;
+
+		if (tmp >= tmp_nxt)
 			break;
 	}
 	list_add(&req->list, entry);
-- 
2.17.2

