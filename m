Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE13B59B8
	for <lists+linux-block@lfdr.de>; Wed, 18 Sep 2019 04:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfIRCiR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Sep 2019 22:38:17 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:55475 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfIRCiR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 22:38:17 -0400
X-QQ-mid: bizesmtp28t1568774274t3j1jc44
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Wed, 18 Sep 2019 10:37:53 +0800 (CST)
X-QQ-SSF: 01400000002000R0YS90000A0000000
X-QQ-FEAT: pNle6v+TNkMA1o6k1aN/rf0K/y7OwEeXrM4rpfe7u8iw8U5hyr1uMOL0ll0jz
        yGjAQtylLjKWTj23JDYAjnbpUuPpzqzP+kEORqp1/IGzefyb2Z0sYZot37JnbSPgM5WumDt
        o0sURkuHBboQq1+t7qdMeb+BfQe5IDot4x6Jp/TQnigriQQqte9ygbsH51U6PsMaj4p7d28
        sR8d5GnlGCkrI96IZO1Z5AmRGVNs/Pa7J0ukr8mPVEmaO6YqXxGKDUcJ8qmzYQZ4N2852Bs
        7JlhnCBhXWKt+/2Tj5ZTDx7HGK1nEhmNzdia2CLrQx/52cfUQXM7CR0ydYiTBTdefffs1Zt
        HVmEHxZrzuF9iWNR5TqpHcBdTRiTw==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH RESEND 1/2] io_uring: use kmemdup instead of kmalloc and memcpy
Date:   Wed, 18 Sep 2019 10:37:52 +0800
Message-Id: <1568774273-19434-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just clean up the code, no function changes.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0dadbdb..42a684e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2098,13 +2098,11 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	if (ret == -EAGAIN && !(req->flags & REQ_F_NOWAIT)) {
 		struct io_uring_sqe *sqe_copy;
 
-		sqe_copy = kmalloc(sizeof(*sqe_copy), GFP_KERNEL);
+		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
 		if (sqe_copy) {
 			struct async_list *list;
 
-			memcpy(sqe_copy, s->sqe, sizeof(*sqe_copy));
 			s->sqe = sqe_copy;
-
 			memcpy(&req->submit, s, sizeof(*s));
 			list = io_async_list_from_sqe(ctx, s->sqe);
 			if (!io_add_to_prev_work(list, req)) {
-- 
2.7.4



