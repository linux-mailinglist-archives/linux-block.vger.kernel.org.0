Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975294905F7
	for <lists+linux-block@lfdr.de>; Mon, 17 Jan 2022 11:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiAQKcg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 17 Jan 2022 05:32:36 -0500
Received: from prt-mail.chinatelecom.cn ([42.123.76.228]:35764 "EHLO
        chinatelecom.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229573AbiAQKcg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 05:32:36 -0500
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jan 2022 05:32:35 EST
HMM_SOURCE_IP: 172.18.0.218:40054.314030182
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-110.86.5.92 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id EA8F928010C;
        Mon, 17 Jan 2022 18:22:39 +0800 (CST)
X-189-SAVE-TO-SEND: +zhenggy@chinatelecom.cn
Received: from  ([172.18.0.218])
        by app0025 with ESMTP id 0a8b46872b874d5ba8d8193b7295806d for axboe@kernel.dk;
        Mon, 17 Jan 2022 18:22:41 CST
X-Transaction-ID: 0a8b46872b874d5ba8d8193b7295806d
X-Real-From: zhenggy@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: zhenggy@chinatelecom.cn
From:   GuoYong Zheng <zhenggy@chinatelecom.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        GuoYong Zheng <zhenggy@chinatelecom.cn>
Subject: [PATCH] block: Remove unnecessary variable assignment
Date:   Mon, 17 Jan 2022 18:22:37 +0800
Message-Id: <1642414957-6785-1-git-send-email-zhenggy@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The parameter "ret" should be zero when running to this line,
no need to set to zero again, remove it.

Signed-off-by: GuoYong Zheng <zhenggy@chinatelecom.cn>
---
 block/blk-sysfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e20eadf..bed4a2f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -887,7 +887,6 @@ int blk_register_queue(struct gendisk *disk)
 		kobject_uevent(&q->elevator->kobj, KOBJ_ADD);
 	mutex_unlock(&q->sysfs_lock);
 
-	ret = 0;
 unlock:
 	mutex_unlock(&q->sysfs_dir_lock);
 
-- 
1.8.3.1

