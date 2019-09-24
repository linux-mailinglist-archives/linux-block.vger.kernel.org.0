Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4242BBC7E9
	for <lists+linux-block@lfdr.de>; Tue, 24 Sep 2019 14:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504921AbfIXMdS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Sep 2019 08:33:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731720AbfIXMdS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 08:33:18 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EBC49CED7492E1267D71;
        Tue, 24 Sep 2019 20:33:16 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 24 Sep 2019 20:33:06 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <hristo@venev.name>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <yi.zhang@huawei.com>,
        <houtao1@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH] io_uring: compare cached_cq_tail with cq.head in_io_uring_poll
Date:   Tue, 24 Sep 2019 20:53:34 +0800
Message-ID: <20190924125334.5543-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After 75b28af("io_uring: allocate the two rings together"), we compare
sq.head with cached_cq_tail to determine does there any cq invalid.
Actually, we should use cq.head.

Fixes: 75b28af ("io_uring: allocate the two rings together")
Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0dadbdbead0f..63cbefba1fb5 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3263,7 +3263,7 @@ static __poll_t io_uring_poll(struct file *file, poll_table *wait)
 	if (READ_ONCE(ctx->rings->sq.tail) - ctx->cached_sq_head !=
 	    ctx->rings->sq_ring_entries)
 		mask |= EPOLLOUT | EPOLLWRNORM;
-	if (READ_ONCE(ctx->rings->sq.head) != ctx->cached_cq_tail)
+	if (READ_ONCE(ctx->rings->cq.head) != ctx->cached_cq_tail)
 		mask |= EPOLLIN | EPOLLRDNORM;
 
 	return mask;
-- 
2.17.2

