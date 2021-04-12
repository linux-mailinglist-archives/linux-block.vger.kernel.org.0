Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2FE35BAE8
	for <lists+linux-block@lfdr.de>; Mon, 12 Apr 2021 09:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbhDLHi7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 12 Apr 2021 03:38:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16445 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbhDLHi6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 03:38:58 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FJgXS3gbMzqTFX;
        Mon, 12 Apr 2021 15:36:24 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 15:38:31 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <mb@lightnvm.io>
CC:     <linux-block@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] lightnvm: Return the correct return value
Date:   Mon, 12 Apr 2021 15:38:54 +0800
Message-ID: <1618213134-21099-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When memdup_user returns an error, memdup_user has two different return
values, use PTR_ERR to get the correct return value.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/lightnvm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 28ddcaa..42774be 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1257,7 +1257,7 @@ static long nvm_ioctl_info(struct file *file, void __user *arg)
 
 	info = memdup_user(arg, sizeof(struct nvm_ioctl_info));
 	if (IS_ERR(info))
-		return -EFAULT;
+		return PTR_ERR(info);
 
 	info->version[0] = NVM_VERSION_MAJOR;
 	info->version[1] = NVM_VERSION_MINOR;
-- 
2.7.4

