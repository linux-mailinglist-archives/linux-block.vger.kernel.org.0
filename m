Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8432CB38D
	for <lists+linux-block@lfdr.de>; Wed,  2 Dec 2020 04:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgLBDji (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Dec 2020 22:39:38 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:46857 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728057AbgLBDji (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Dec 2020 22:39:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UHHIzwn_1606880336;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UHHIzwn_1606880336)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Dec 2020 11:38:56 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     snitzer@redhat.com
Cc:     dm-devel@redhat.com, joseph.qi@linux.alibaba.com,
        linux-block@vger.kernel.org
Subject: [PATCH] dm: use gcd() to fix chunk_sectors limit stacking
Date:   Wed,  2 Dec 2020 11:38:55 +0800
Message-Id: <20201202033855.60882-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201202033855.60882-1-jefflexu@linux.alibaba.com>
References: <20201201160709.31748-1-snitzer@redhat.com>
 <20201202033855.60882-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As it said in commit 7e7986f9d3ba ("block: use gcd() to fix
chunk_sectors limit stacking"), chunk_sectors should reflect the most
limited of all devices in the IO stack.

The previous commit only fixes block/blk-settings.c:blk_stack_limits(),
while leaving dm.c:dm_calculate_queue_limits() unfixed.

Fixes: 882ec4e609c1 ("dm table: stack 'chunk_sectors' limit to account for target-specific splitting")
cc: stable@vger.kernel.org
Reported-by: John Dorminy <jdorminy@redhat.com>
Reported-by: Bruce Johnston <bjohnsto@redhat.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 drivers/md/dm-table.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index ce543b761be7..dcc0a27355d7 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -22,6 +22,7 @@
 #include <linux/blk-mq.h>
 #include <linux/mount.h>
 #include <linux/dax.h>
+#include <linux/gcd.h>
 
 #define DM_MSG_PREFIX "table"
 
@@ -1457,7 +1458,7 @@ int dm_calculate_queue_limits(struct dm_table *table,
 
 		/* Stack chunk_sectors if target-specific splitting is required */
 		if (ti->max_io_len)
-			ti_limits.chunk_sectors = lcm_not_zero(ti->max_io_len,
+			ti_limits.chunk_sectors = gcd(ti->max_io_len,
 							       ti_limits.chunk_sectors);
 		/* Set I/O hints portion of queue limits */
 		if (ti->type->io_hints)
-- 
2.27.0

