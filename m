Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD663053F4
	for <lists+linux-block@lfdr.de>; Wed, 27 Jan 2021 08:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhA0HIp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 Jan 2021 02:08:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11513 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhA0HGn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 02:06:43 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DQZNc2NMXzjDyw;
        Wed, 27 Jan 2021 15:04:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 27 Jan 2021 15:05:57 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <mb@lightnvm.io>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH] lightnvm: pblk: fix NULL check before some freeing functions is not needed
Date:   Wed, 27 Jan 2021 15:05:40 +0800
Message-ID: <1611731140-49528-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

fixed the below warning:
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

