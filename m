Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58EB340890
	for <lists+linux-block@lfdr.de>; Thu, 18 Mar 2021 16:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhCRPQy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Mar 2021 11:16:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41979 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhCRPQ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 11:16:28 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lMuNv-0001rJ-15; Thu, 18 Mar 2021 15:16:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] loop: Fix missing max_active argument in alloc_workqueue call
Date:   Thu, 18 Mar 2021 15:16:26 +0000
Message-Id: <20210318151626.17442-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The 3rd argument to alloc_workqueue should be the max_active count,
however currently it is the lo->lo_number that is intended for the
loop%d number. Fix this by adding in the missing max_active count.

Addresses-Coverity: ("Missing argument to printf")
Fixes: 08ad7f822739 ("loop: Use worker per cgroup instead of kworker")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f2f9e4127847..ee2a6c1bc093 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1192,7 +1192,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	lo->workqueue = alloc_workqueue("loop%d",
 					WQ_UNBOUND | WQ_FREEZABLE |
 					WQ_MEM_RECLAIM,
-					lo->lo_number);
+					1, lo->lo_number);
 	if (!lo->workqueue) {
 		error = -ENOMEM;
 		goto out_unlock;
-- 
2.30.2

