Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F010C2AA
	for <lists+linux-block@lfdr.de>; Thu, 28 Nov 2019 04:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfK1DCV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 Nov 2019 22:02:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727432AbfK1DCV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 22:02:21 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E4789A428334B6892A0A;
        Thu, 28 Nov 2019 11:02:19 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 28 Nov 2019
 11:02:09 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
        <axboe@kernel.dk>, <drbd-dev@lists.linbit.com>,
        <linux-block@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 1/3] drbd: Remove unneeded semicolon
Date:   Thu, 28 Nov 2019 11:09:30 +0800
Message-ID: <1574910572-42062-2-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574910572-42062-1-git-send-email-zhengbin13@huawei.com>
References: <1574910572-42062-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes coccicheck warning:

drivers/block/drbd/drbd_req.c:887:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/block/drbd/drbd_req.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index f86cea4..840c3ae 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -884,7 +884,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		start_new_tl_epoch(connection);
 		mod_rq_state(req, m, 0, RQ_NET_OK|RQ_NET_DONE);
 		break;
-	};
+	}

 	return rv;
 }
--
2.7.4

