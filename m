Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4832830B4CB
	for <lists+linux-block@lfdr.de>; Tue,  2 Feb 2021 02:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhBBBmz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 1 Feb 2021 20:42:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12001 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhBBBmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 20:42:55 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DV6w41fFKzjHjF;
        Tue,  2 Feb 2021 09:40:52 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 09:42:05 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <mb@lightnvm.io>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH] lightnvm: fix unnecessary NULL check warnings
Date:   Tue, 2 Feb 2021 09:41:45 +0800
Message-ID: <1612230105-31365-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove NULL checks before vfree() to fix these warnings:
./drivers/lightnvm/pblk-gc.c:27:2-7: WARNING: NULL check before some
freeing functions is not needed.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/lightnvm/pblk-gc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 2581eeb..b31658b 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -23,8 +23,7 @@
 
 static void pblk_gc_free_gc_rq(struct pblk_gc_rq *gc_rq)
 {
-	if (gc_rq->data)
-		vfree(gc_rq->data);
+	vfree(gc_rq->data);
 	kfree(gc_rq);
 }
 
-- 
2.7.4

