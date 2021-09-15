Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14F340C125
	for <lists+linux-block@lfdr.de>; Wed, 15 Sep 2021 10:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbhIOIHJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Sep 2021 04:07:09 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9873 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbhIOIHI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 04:07:08 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H8XjF1rbzz8yZX;
        Wed, 15 Sep 2021 16:01:21 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 16:05:47 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 15
 Sep 2021 16:05:46 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <ming.lei@redhat.com>,
        <hch@infradead.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v6 4/6] nbd: don't start request if nbd_queue_rq() failed
Date:   Wed, 15 Sep 2021 16:15:35 +0800
Message-ID: <20210915081537.1684327-5-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915081537.1684327-1-yukuai3@huawei.com>
References: <20210915081537.1684327-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, blk_mq_end_request() will be called if nbd_queue_rq()
failed, thus start request in such situation is useless.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c724a5bd7fa4..22c91d8901f6 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -934,7 +934,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Socks array is empty\n");
-		blk_mq_start_request(req);
 		return -EINVAL;
 	}
 	config = nbd->config;
@@ -943,7 +942,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Attempted send on invalid socket\n");
 		nbd_config_put(nbd);
-		blk_mq_start_request(req);
 		return -EINVAL;
 	}
 	cmd->status = BLK_STS_OK;
@@ -967,7 +965,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 			 */
 			sock_shutdown(nbd);
 			nbd_config_put(nbd);
-			blk_mq_start_request(req);
 			return -EIO;
 		}
 		goto again;
-- 
2.31.1

