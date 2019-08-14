Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A57A8CFC3
	for <lists+linux-block@lfdr.de>; Wed, 14 Aug 2019 11:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfHNJfi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 14 Aug 2019 05:35:38 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:52206 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfHNJfi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Aug 2019 05:35:38 -0400
X-QQ-mid: bizesmtp11t1565775329ta6fjb9d
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 14 Aug 2019 17:35:28 +0800 (CST)
X-QQ-SSF: 01400000002000R0XR80000A0000000
X-QQ-FEAT: Ksu+ipKsD1eURf8Cn4xL39A7iVP7zPVUsYs69SXRf51yiietd/ZtvUl9mZZQe
        XVIRBdAE/O2zBB7dghTak5hufGJ/rrDgJogWeB5DnEXcDDLb/TRvKL7/nWKT0/IMjg7YYz7
        qxrY6BeVWzUIBwnl12Z45H3usEq8d4c933UI06XOWXoKLqQoheysWKTRuyWO+CGc+c9YyY2
        0Al0TJUQWnLWreS3gj1EsaIy9QdBrwOY+/MWCDVVuo7SohirEtq+4mjogKXUpv6bUNrkqvx
        L50+HuTNb6+fn7kGjgC2ZSUQ2OaaYX5xpPOGwTKODzdSDIS9/mDRk0WRY2uRVCRCnJlhwYU
        cfgViaSDLwzhg8pR4eNxLUg7YNg6Q==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH 1/2] io_uring: fix issue when IOSQE_IO_DRAIN pass with IOSQE_IO_LINK
Date:   Wed, 14 Aug 2019 17:35:21 +0800
Message-Id: <1565775322-10296-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Suppose there are three IOs here, and their order is as follows:

Submit:
	[1] IO_LINK
	    |
	    |---  [2] IO_LINK | IO_DRAIN
		      |
		      |- [3] NORMAL_IO

In theory, they all need to be inserted into the Link-list, but flag
IO_DRAIN we have, io[2] and io[3] will be inserted into the defer_list,
and finally, io[3] and io[2] will be processed at the same time.

Now, it is directly forbidden to pass these two flags at the same time.

Fixes: 9e645e1105c ("io_uring: add support for sqe links")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d542f1c..05ee628 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2074,10 +2074,13 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 {
 	struct io_uring_sqe *sqe_copy;
 	struct io_kiocb *req;
+	unsigned int flags;
 	int ret;
 
+	flags = READ_ONCE(s->sqe->flags);
 	/* enforce forwards compatibility on users */
-	if (unlikely(s->sqe->flags & ~SQE_VALID_FLAGS)) {
+	if (unlikely((flags & ~SQE_VALID_FLAGS) ||
+		     (flags & (IOSQE_IO_DRAIN | IOSQE_IO_LINK)))) {
 		ret = -EINVAL;
 		goto err;
 	}
@@ -2093,6 +2096,8 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 err_req:
 		io_free_req(req);
 err:
+		if (*link)
+			io_fail_links(*link);
 		io_cqring_add_event(ctx, s->sqe->user_data, ret);
 		return;
 	}
-- 
2.7.4



