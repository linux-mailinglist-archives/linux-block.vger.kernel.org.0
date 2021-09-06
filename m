Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE85640152C
	for <lists+linux-block@lfdr.de>; Mon,  6 Sep 2021 05:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbhIFDLS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 5 Sep 2021 23:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239244AbhIFDLR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 5 Sep 2021 23:11:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 921A060F22;
        Mon,  6 Sep 2021 03:10:11 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] mq-deadline: Fix build error for !BLK_DEBUG_FS
Date:   Mon,  6 Sep 2021 11:09:18 +0800
Message-Id: <20210906030918.3901521-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Function dd_queued() is only used in dd_queued_show(), but dd_queued_
show() is only defined for BLK_DEBUG_FS enabled. However, in the commit
3fe617ccafd6f5bb3 ("Enable '-Werror' by default for all kernel builds")
Werror is enabled by default, which cause a build error if DEBUG_FS is
not enabled.

So we move dd_queued() in the CONFIG_BLK_DEBUG_FS block to fix it.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 block/mq-deadline.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3c3693c34f06..7f3c3932b723 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -270,12 +270,6 @@ deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	deadline_remove_request(rq->q, per_prio, rq);
 }
 
-/* Number of requests queued for a given priority level. */
-static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
-{
-	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
-}
-
 /*
  * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
  * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
@@ -953,6 +947,12 @@ static int dd_async_depth_show(void *data, struct seq_file *m)
 	return 0;
 }
 
+/* Number of requests queued for a given priority level. */
+static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
+{
+	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
+}
+
 static int dd_queued_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q = data;
-- 
2.27.0

