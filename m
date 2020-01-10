Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 584BE13677A
	for <lists+linux-block@lfdr.de>; Fri, 10 Jan 2020 07:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbgAJGhe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 10 Jan 2020 01:37:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41306 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731530AbgAJGhe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jan 2020 01:37:34 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E2D89E2F09D53AEEC3E5;
        Fri, 10 Jan 2020 14:37:32 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 Jan 2020
 14:37:23 +0800
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <dhowells@redhat.com>,
        <akpm@linux-foundation.org>, <torvalds@linux-foundation.org>
CC:     <bywxiaobai@163.com>, Mingfangsen <mingfangsen@huawei.com>,
        Guiyao <guiyao@huawei.com>, zhangsaisai <zhangsaisai@huawei.com>,
        renxudong <renxudong1@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] kdev_t: mask mi with MINORMASK in MKDEV macro
Message-ID: <5d384dcb-5590-60f8-a4e1-efa6b8da151f@huawei.com>
Date:   Fri, 10 Jan 2020 14:37:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


In MKDEV macro, if mi is larger than MINORMASK, the major will be
affected by mi. For example, set dev = MKDEV(2, (1U << MINORBITS)),
then MAJOR(dev) will be equal to 3, incorrectly.

Here, we mask mi with MINORMASK in MKDEV macro.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 include/linux/kdev_t.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kdev_t.h b/include/linux/kdev_t.h
index 85b5151911cf..40a9423720b2 100644
--- a/include/linux/kdev_t.h
+++ b/include/linux/kdev_t.h
@@ -9,7 +9,7 @@

 #define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
 #define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
-#define MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))
+#define MKDEV(ma, mi)	(((ma) << MINORBITS) | ((mi) & MINORMASK))

 #define print_dev_t(buffer, dev)					\
 	sprintf((buffer), "%u:%u\n", MAJOR(dev), MINOR(dev))
-- 
2.19.1

