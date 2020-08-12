Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD9C24269E
	for <lists+linux-block@lfdr.de>; Wed, 12 Aug 2020 10:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgHLIS4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Aug 2020 04:18:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57586 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbgHLIS4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 04:18:56 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1FB065CA7AF26A86DED2;
        Wed, 12 Aug 2020 16:18:54 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 12 Aug 2020
 16:18:44 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <lengchao@huawei.com>
Subject: [PATCH 2/3] nvme-core: delete the dependency on blk status
Date:   Wed, 12 Aug 2020 16:18:44 +0800
Message-ID: <20200812081844.22224-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nvme should not depend on blk status, just need check nvme status.
Just need do translating nvme status to blk status for returning error.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 52d19a4d3bc8..246988091c05 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -278,7 +278,7 @@ static void nvme_retry_req(struct request *req)
 
 void nvme_complete_rq(struct request *req)
 {
-	blk_status_t status = nvme_error_status(nvme_req(req)->status);
+	blk_status_t status;
 
 	trace_nvme_complete_rq(req);
 
@@ -287,7 +287,8 @@ void nvme_complete_rq(struct request *req)
 	if (nvme_req(req)->ctrl->kas)
 		nvme_req(req)->ctrl->comp_seen = true;
 
-	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
+	if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS &&
+		nvme_req_needs_retry(req))) {
 		if (nvme_req_path_error(req)) {
 			if (req->cmd_flags & REQ_NVME_MPATH) {
 				nvme_failover_req(req);
@@ -299,6 +300,7 @@ void nvme_complete_rq(struct request *req)
 		}
 	}
 
+	status = nvme_error_status(nvme_req(req)->status);
 	nvme_trace_bio_complete(req, status);
 	blk_mq_end_request(req, status);
 }
-- 
2.16.4

