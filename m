Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC281F7249
	for <lists+linux-block@lfdr.de>; Fri, 12 Jun 2020 04:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFLCoO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 11 Jun 2020 22:44:14 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:55741 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726321AbgFLCoO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 22:44:14 -0400
X-IronPort-AV: E=Sophos;i="5.73,501,1583164800"; 
   d="scan'208";a="94344459"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Jun 2020 10:44:01 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id DE41F4CE2E89;
        Fri, 12 Jun 2020 10:43:59 +0800 (CST)
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 12 Jun 2020 10:44:01 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <linux-block@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
        Martijn Coenen <maco@android.com>
Subject: [PATCH] loop: Remove redundant status flag operation
Date:   Fri, 12 Jun 2020 10:43:51 +0800
Message-ID: <1591929831-2397-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: DE41F4CE2E89.A0C97
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since ~LOOP_SET_STATUS_SETTABLE_FLAG is always a subset of ~LOOP_SET_STATUS_CLEARABLE_FLAGS
,remove this redundant flags operation.

Cc: Martijn Coenen <maco@android.com>
Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 drivers/block/loop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c33bbbf..2a61079 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1391,8 +1391,6 @@ static int loop_clr_fd(struct loop_device *lo)
 
 	/* Mask out flags that can't be set using LOOP_SET_STATUS. */
 	lo->lo_flags &= LOOP_SET_STATUS_SETTABLE_FLAGS;
-	/* For those flags, use the previous values instead */
-	lo->lo_flags |= prev_lo_flags & ~LOOP_SET_STATUS_SETTABLE_FLAGS;
 	/* For flags that can't be cleared, use previous values too */
 	lo->lo_flags |= prev_lo_flags & ~LOOP_SET_STATUS_CLEARABLE_FLAGS;
 
-- 
1.8.3.1



