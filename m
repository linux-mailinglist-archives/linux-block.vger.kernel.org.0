Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49178223836
	for <lists+linux-block@lfdr.de>; Fri, 17 Jul 2020 11:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgGQJX0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 17 Jul 2020 05:23:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbgGQJX0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 05:23:26 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F3B48A19392907919290;
        Fri, 17 Jul 2020 17:23:24 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Jul 2020 17:23:14 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <linux-block@vger.kernel.org>
CC:     <yangerkun@huawei.com>
Subject: [PATCH] blk-mq: remove unused code exist in blk_mq_dispatch_rq_list
Date:   Fri, 17 Jul 2020 17:23:48 +0800
Message-ID: <20200717092348.36303-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Once .queue_rq return BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE, we will
insert the rq back to list, and will return false since '(!list_empty)'
always be true. The latter check seems unused.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 block/blk-mq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e0d173beaa3..5e561283580f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1361,13 +1361,6 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	} else
 		blk_mq_update_dispatch_busy(hctx, false);
 
-	/*
-	 * If the host/device is unable to accept more work, inform the
-	 * caller of that.
-	 */
-	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
-		return false;
-
 	return (queued + errors) != 0;
 }
 
-- 
2.25.4

