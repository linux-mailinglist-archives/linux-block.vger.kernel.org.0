Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E014126BC93
	for <lists+linux-block@lfdr.de>; Wed, 16 Sep 2020 08:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgIPGTf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Sep 2020 02:19:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12719 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbgIPGTc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Sep 2020 02:19:32 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 06CD341825A39B09443C;
        Wed, 16 Sep 2020 14:19:30 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 14:19:20 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] aoe: remove unnecessary mutex_init()
Date:   Wed, 16 Sep 2020 14:20:02 +0800
Message-ID: <20200916062002.190132-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The mutex ktio_spawn_lock is initialized statically. It is
unnecessary to initialize by mutex_init().

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/block/aoe/aoecmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 313f0b946..d5d4a8460 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1708,8 +1708,6 @@ aoecmd_init(void)
 		goto ktiowq_fail;
 	}
 
-	mutex_init(&ktio_spawn_lock);
-
 	for (i = 0; i < ncpus; i++) {
 		INIT_LIST_HEAD(&iocq[i].head);
 		spin_lock_init(&iocq[i].lock);
-- 
2.23.0

