Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9CA30A0B2
	for <lists+linux-block@lfdr.de>; Mon,  1 Feb 2021 04:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhBADud (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 31 Jan 2021 22:50:33 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12057 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhBADu1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jan 2021 22:50:27 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DTYnM47FLzMSmp;
        Mon,  1 Feb 2021 11:48:07 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Feb 2021
 11:49:42 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
Subject: [PATCH v5 1/3] blk-mq: introduce blk_mq_set_request_complete
Date:   Mon, 1 Feb 2021 11:49:38 +0800
Message-ID: <20210201034940.18891-2-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210201034940.18891-1-lengchao@huawei.com>
References: <20210201034940.18891-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nvme drivers need to set the state of request to MQ_RQ_COMPLETE when
directly complete request in queue_rq.
So add blk_mq_set_request_complete.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 include/linux/blk-mq.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 47b021952ac7..38c632ce2270 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -494,6 +494,15 @@ static inline int blk_mq_request_completed(struct request *rq)
 	return blk_mq_rq_state(rq) == MQ_RQ_COMPLETE;
 }
 
+/*
+ * If nvme complete request directly, need to set the state to complete
+ * to avoid canceling the request again.
+ */
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

