Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364FB2EA5D2
	for <lists+linux-block@lfdr.de>; Tue,  5 Jan 2021 08:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbhAEHUd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 Jan 2021 02:20:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10387 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbhAEHU2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 02:20:28 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D93kz0fwpz7PQx;
        Tue,  5 Jan 2021 15:18:51 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Tue, 5 Jan 2021
 15:19:37 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <lengchao@huawei.com>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
Subject: [PATCH 1/6] blk-mq: introduce blk_mq_set_request_complete
Date:   Tue, 5 Jan 2021 15:19:31 +0800
Message-ID: <20210105071936.25097-2-lengchao@huawei.com>
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

In some scenarios, nvme need setting the state of request to
MQ_RQ_COMPLETE. So add an inline function blk_mq_set_request_complete.
For details, see the subsequent patches.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 include/linux/blk-mq.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e7482e6ad3ec..cee72d31054d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -493,6 +493,11 @@ static inline int blk_mq_request_completed(struct request *rq)
 	return blk_mq_rq_state(rq) == MQ_RQ_COMPLETE;
 }
 
+static inline void blk_mq_set_request_complete(struct request *rq)
+{
+	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+}
+
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
-- 
2.16.4

