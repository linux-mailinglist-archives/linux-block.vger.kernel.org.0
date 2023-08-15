Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C681777CC03
	for <lists+linux-block@lfdr.de>; Tue, 15 Aug 2023 13:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbjHOLtD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Aug 2023 07:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbjHOLsw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2023 07:48:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFDF10CF
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2023 04:48:51 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQ8ch6KsVzVjr6;
        Tue, 15 Aug 2023 19:46:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 19:48:48 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] ublk: Switch to memdup_user_nul() helper
Date:   Tue, 15 Aug 2023 19:48:14 +0800
Message-ID: <20230815114815.1551171-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use memdup_user_nul() helper instead of open-coding
to simplify the code.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/block/ublk_drv.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 85a81ee556d5..fa7e6955eb3b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2743,14 +2743,9 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	if (header->len < header->dev_path_len)
 		return -EINVAL;
 
-	dev_path = kmalloc(header->dev_path_len + 1, GFP_KERNEL);
-	if (!dev_path)
-		return -ENOMEM;
-
-	ret = -EFAULT;
-	if (copy_from_user(dev_path, argp, header->dev_path_len))
-		goto exit;
-	dev_path[header->dev_path_len] = 0;
+	dev_path = memdup_user_nul(argp, header->dev_path_len);
+	if (IS_ERR(dev_path))
+		return PTR_ERR(dev_path);
 
 	ret = -EINVAL;
 	switch (_IOC_NR(cmd->cmd_op)) {
-- 
2.34.1

