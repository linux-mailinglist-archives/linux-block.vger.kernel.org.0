Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E3024269F
	for <lists+linux-block@lfdr.de>; Wed, 12 Aug 2020 10:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHLITJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Aug 2020 04:19:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9261 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbgHLITH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 04:19:07 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4B2E89D126F018B1108E;
        Wed, 12 Aug 2020 16:19:05 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 12 Aug 2020
 16:18:55 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <lengchao@huawei.com>
Subject: [PATCH 3/3] nvme-core: delete the dependency on REQ_FAILFAST_TRANSPORT
Date:   Wed, 12 Aug 2020 16:18:55 +0800
Message-ID: <20200812081855.22277-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

REQ_FAILFAST_TRANSPORT may be designed for scsi, because scsi protocol
do not difine the local retry mechanism. SCSI implements a fuzzy local
retry mechanism, so need the REQ_FAILFAST_TRANSPORT for multipath
software, if work with multipath software, ultraPath determines
whether to retry and how to retry.

Nvme is different with scsi about this. It define local retry mechanism
and path error code, so nvme should retry local for non path error.
If path related error, whether to retry and how to retry is still
determined by ultraPath. REQ_FAILFAST_TRANSPORT just for non nvme
multipath software(like dm-multipath), but we do not need return an
error for REQ_FAILFAST_TRANSPORT first, because we need retry local
for non path error first.

In this way, the mechanism of nvme multipath or other multipath will be
same. The mechanism is: non path related error will be retry local,
path related error treated by multipath.

If work with dm-multipath, The patch can also fix io interrupt when io
return NVME_SC_CMD_INTERRUPTED or NVME_SC_NS_NOT_READY. Because
NVME_SC_CMD_INTERRUPTED or NVME_SC_NS_NOT_READY will be translated to
BLK_STS_TARGET. blk_path_error will treat BLK_STS_TARGET as retrying
failover path will not help, will cause io interrupt.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 246988091c05..07471bd37f60 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -243,7 +243,7 @@ static blk_status_t nvme_error_status(u16 status)
 
 static inline bool nvme_req_needs_retry(struct request *req)
 {
-	if (blk_noretry_request(req))
+	if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_FAILFAST_DRIVER))
 		return false;
 	if (nvme_req(req)->status & NVME_SC_DNR)
 		return false;
-- 
2.16.4

