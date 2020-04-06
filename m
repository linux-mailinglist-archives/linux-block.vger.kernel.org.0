Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB5A19FCC3
	for <lists+linux-block@lfdr.de>; Mon,  6 Apr 2020 20:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDFSOC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 6 Apr 2020 14:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbgDFSOC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Apr 2020 14:14:02 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B80F420672;
        Mon,  6 Apr 2020 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586196842;
        bh=EnCI/RJBPRNCTGb0qiRLmOlB21gTn5l1n73HqaqU9v4=;
        h=From:To:Cc:Subject:Date:From;
        b=Ffn1uX49GOXVZHVIj/ZyoyyTeUGdxd1blz0jG7/MPzS1DDu/qICg0FL8Du2PGZlrj
         QZMXThbMUEwFDxMzvwpkxvkdFn1zXew8y6niX21lSNpwjuYuUvybUqy3YbeOhvOTYq
         ir82RyPEPe3dkguhB1Q82qqaHWzb6mzF/ud7n9f4=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     Keith Busch <kbusch@kernel.org>
Subject: [PATCH] blk-mq: don't commit_rqs() if none were queued
Date:   Tue,  7 Apr 2020 03:13:48 +0900
Message-Id: <20200406181348.1496-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unburden the drivers from checking if a call to commit_rqs() is valid by
not calling it when there are no requests to commit.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6291ceedee4..8e56884fd2e9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1289,7 +1289,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		 * the driver there was more coming, but that turned out to
 		 * be a lie.
 		 */
-		if (q->mq_ops->commit_rqs)
+		if (q->mq_ops->commit_rqs && queued)
 			q->mq_ops->commit_rqs(hctx);
 
 		spin_lock(&hctx->lock);
@@ -1911,6 +1911,8 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
 {
+	int queued = 0;
+
 	while (!list_empty(list)) {
 		blk_status_t ret;
 		struct request *rq = list_first_entry(list, struct request,
@@ -1926,7 +1928,8 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				break;
 			}
 			blk_mq_end_request(rq, ret);
-		}
+		} else
+			queued++;
 	}
 
 	/*
@@ -1934,7 +1937,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 	 * the driver there was more coming, but that turned out to
 	 * be a lie.
 	 */
-	if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs)
+	if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs && queued)
 		hctx->queue->mq_ops->commit_rqs(hctx);
 }
 
-- 
2.21.0

