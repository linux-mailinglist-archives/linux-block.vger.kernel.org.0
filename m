Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245FD206F59
	for <lists+linux-block@lfdr.de>; Wed, 24 Jun 2020 10:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389141AbgFXItb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Jun 2020 04:49:31 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:5596 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388830AbgFXItZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 04:49:25 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5ef31384808-51d08; Wed, 24 Jun 2020 16:49:08 +0800 (CST)
X-RM-TRANSID: 2eec5ef31384808-51d08
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.242])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15ef31383538-2ae1e;
        Wed, 24 Jun 2020 16:49:08 +0800 (CST)
X-RM-TRANSID: 2ee15ef31383538-2ae1e
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] loop: fix passing zero to 'PTR_ERR' warning
Date:   Wed, 24 Jun 2020 16:48:42 +0800
Message-Id: <1592988522-4350-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix a static code checker warning:
    drivers/block/loop.c:798 loop_attr_backing_file_show()
    warn: passing zero to 'PTR_ERR'

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 475e1a7..bcada87 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -795,7 +795,7 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 	spin_unlock_irq(&lo->lo_lock);
 
 	if (IS_ERR_OR_NULL(p))
-		ret = PTR_ERR(p);
+		ret = PTR_ERR_OR_ZERO(p);
 	else {
 		ret = strlen(p);
 		memmove(buf, p, ret);
-- 
2.7.4



