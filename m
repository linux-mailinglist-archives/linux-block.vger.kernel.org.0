Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA2D2EA5D4
	for <lists+linux-block@lfdr.de>; Tue,  5 Jan 2021 08:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbhAEHUr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 Jan 2021 02:20:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9672 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbhAEHUr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 02:20:47 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D93l34T5hz15pCL;
        Tue,  5 Jan 2021 15:18:55 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Tue, 5 Jan 2021
 15:19:40 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <lengchao@huawei.com>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
Subject: [PATCH 6/6] nvme-fc: avoid IO error and repeated request completion
Date:   Tue, 5 Jan 2021 15:19:36 +0800
Message-ID: <20210105071936.25097-7-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210105071936.25097-1-lengchao@huawei.com>
References: <20210105071936.25097-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When a request is queued failed, blk_status_t is directly returned
to the blk-mq. If blk_status_t is not BLK_STS_RESOURCE,
BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE, blk-mq call
blk_mq_end_request to complete the request with BLK_STS_IOERR.
In two scenarios, the request should be retried and may succeed.
First, if work with nvme multipath, the request may be retried
successfully in another path, because the error is probably related to
the path. Second, if work without multipath software, the request may
be retried successfully after error recovery.
If the request is completed with BLK_STS_IOERR in blk_mq_dispatch_rq_list.
The state of request may be changed to MQ_RQ_IN_FLIGHT. If free the
request asynchronously such as in nvme_submit_user_cmd, in extreme
scenario the request will be repeated freed in tear down.
If a non-resource error occurs when queue_rq, should directly call
nvme_complete_rq to complete request and set the state of request to
MQ_RQ_COMPLETE. nvme_complete_rq will decide to retry, fail over or end
the request.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/fc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 38373a0e86ef..f6a5758ef1ea 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2761,7 +2761,7 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	ret = nvme_setup_cmd(ns, rq, sqe);
 	if (ret)
-		return ret;
+		goto fail;
 
 	/*
 	 * nvme core doesn't quite treat the rq opaquely. Commands such
@@ -2781,7 +2781,9 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 
-	return nvme_fc_start_fcp_op(ctrl, queue, op, data_len, io_dir);
+	ret = nvme_fc_start_fcp_op(ctrl, queue, op, data_len, io_dir);
+fail:
+	return nvme_try_complete_failed_req(rq, ret);
 }
 
 static void
-- 
2.16.4

