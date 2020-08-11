Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EAF2414E6
	for <lists+linux-block@lfdr.de>; Tue, 11 Aug 2020 04:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgHKCVG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 10 Aug 2020 22:21:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726841AbgHKCVG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Aug 2020 22:21:06 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9D4983CEEE5A7781FF26;
        Tue, 11 Aug 2020 10:21:03 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 11 Aug 2020
 10:21:00 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <jbacik@fb.com>, <tj@kernel.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v2] blkcg: fix memleak for iolatency
Date:   Mon, 10 Aug 2020 22:21:16 -0400
Message-ID: <20200811022116.1824539-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Normally, blkcg_iolatency_exit() will free related memory in iolatency
when cleanup queue. But if blk_throtl_init() return error and queue init
fail, blkcg_iolatency_exit() will not do that for us. Then it cause
memory leak.

Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-cgroup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 619a79b51068..c195365c9817 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1152,13 +1152,15 @@ int blkcg_init_queue(struct request_queue *q)
 	if (preloaded)
 		radix_tree_preload_end();
 
-	ret = blk_iolatency_init(q);
+	ret = blk_throtl_init(q);
 	if (ret)
 		goto err_destroy_all;
 
-	ret = blk_throtl_init(q);
-	if (ret)
+	ret = blk_iolatency_init(q);
+	if (ret) {
+		blk_throtl_exit(q);
 		goto err_destroy_all;
+	}
 	return 0;
 
 err_destroy_all:
-- 
2.25.4

