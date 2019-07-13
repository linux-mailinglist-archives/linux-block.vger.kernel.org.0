Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 221246780F
	for <lists+linux-block@lfdr.de>; Sat, 13 Jul 2019 05:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfGMD7A (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 12 Jul 2019 23:59:00 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:42753 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfGMD7A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jul 2019 23:59:00 -0400
X-QQ-mid: bizesmtp21t1562990331txpxhzya
Received: from localhost.localdomain (unknown [113.240.168.78])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 13 Jul 2019 11:58:50 +0800 (CST)
X-QQ-SSF: 01400000002000H0ZG31B00A0000000
X-QQ-FEAT: vvh+TVF7+rVoEP4+Rm3xc9ceJjlvXatM5gNN8+RBmzlLxAXv6UNttlgp8kO6g
        CGrcef0Qtcv+lwqvZMVYj8NPQHORGA/RuMyi9MWJOTN6tYwtNtaEQ6jw9G8HB1UJgm5zZin
        oDVoir6Hs5/5pEhMpSJdBD5f3eC+3yuE/yOEmCmlDC3KuAHOCi1cqyKXQ/0xDNh1i/ShbQB
        WyS5lUVJdzwKXSmfvOKU2WhK1SqUz5ndTGPBSyyKjuxAtuGTcp5uqQrnUQ78bDavyxtiXJr
        himHEvwt7MZmwWyymne2pCcvhgtRvJvW14ABwRKTcSn/8QOaAYhx50CgkUNYeyI7LyYth6e
        RgHBSA7WRsy7NJh9mE=
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Subject: [PATCH 2/2] io_uring: fix the judging condition in io_sequence_defer
Date:   Sat, 13 Jul 2019 11:58:26 +0800
Message-Id: <20190713035826.2987-2-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190713035826.2987-1-liuzhengyuan@kylinos.cn>
References: <20190713035826.2987-1-liuzhengyuan@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

sq->cached_sq_head and cq->cached_cq_tail are both unsigned int.
if cached_sq_head gets overflowed before cached_cq_tail, then we
may miss a barrier req. As cached_cq_tail moved always following
cached_sq_head, the NQ should be enough.

Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3e48fd7cd08f..55294ef82102 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -429,7 +429,7 @@ static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
 	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
 		return false;
 
-	return req->sequence > ctx->cached_cq_tail + ctx->sq_ring->dropped;
+	return req->sequence != ctx->cached_cq_tail + ctx->sq_ring->dropped;
 }
 
 static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
-- 
2.19.1



