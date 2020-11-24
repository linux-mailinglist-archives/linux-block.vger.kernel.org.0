Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DCC2C1C12
	for <lists+linux-block@lfdr.de>; Tue, 24 Nov 2020 04:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgKXDdw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Nov 2020 22:33:52 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:41461 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgKXDdw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 22:33:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UGNj0Wa_1606188829;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UGNj0Wa_1606188829)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Nov 2020 11:33:49 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] blk-iocost: Fix some typos in comments
Date:   Tue, 24 Nov 2020 11:33:30 +0800
Message-Id: <54cf5f249bf91a6d1a0ea18a1024ba1af861f9c5.1606186717.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix some typos in comments.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-iocost.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index bbe86d1..4ffde36 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -39,7 +39,7 @@
  * On top of that, a size cost proportional to the length of the IO is
  * added.  While simple, this model captures the operational
  * characteristics of a wide varienty of devices well enough.  Default
- * paramters for several different classes of devices are provided and the
+ * parameters for several different classes of devices are provided and the
  * parameters can be configured from userspace via
  * /sys/fs/cgroup/io.cost.model.
  *
@@ -77,7 +77,7 @@
  *
  * This constitutes the basis of IO capacity distribution.  Each cgroup's
  * vtime is running at a rate determined by its hweight.  A cgroup tracks
- * the vtime consumed by past IOs and can issue a new IO iff doing so
+ * the vtime consumed by past IOs and can issue a new IO if doing so
  * wouldn't outrun the current device vtime.  Otherwise, the IO is
  * suspended until the vtime has progressed enough to cover it.
  *
@@ -155,7 +155,7 @@
  * Instead of debugfs or other clumsy monitoring mechanisms, this
  * controller uses a drgn based monitoring script -
  * tools/cgroup/iocost_monitor.py.  For details on drgn, please see
- * https://github.com/osandov/drgn.  The ouput looks like the following.
+ * https://github.com/osandov/drgn.  The output looks like the following.
  *
  *  sdb RUN   per=300ms cur_per=234.218:v203.695 busy= +1 vrate= 62.12%
  *                 active      weight      hweight% inflt% dbt  delay usages%
@@ -492,7 +492,7 @@ struct ioc_gq {
 	/*
 	 * `vtime` is this iocg's vtime cursor which progresses as IOs are
 	 * issued.  If lagging behind device vtime, the delta represents
-	 * the currently available IO budget.  If runnning ahead, the
+	 * the currently available IO budget.  If running ahead, the
 	 * overage.
 	 *
 	 * `vtime_done` is the same but progressed on completion rather
@@ -1046,7 +1046,7 @@ static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse,
 
 		/*
 		 * The delta between inuse and active sums indicates that
-		 * that much of weight is being given away.  Parent's inuse
+		 * much of weight is being given away.  Parent's inuse
 		 * and active should reflect the ratio.
 		 */
 		if (parent->child_active_sum) {
@@ -2400,7 +2400,7 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
 		return cost;
 
 	/*
-	 * We only increase inuse during period and do so iff the margin has
+	 * We only increase inuse during period and do so if the margin has
 	 * deteriorated since the previous adjustment.
 	 */
 	if (margin >= iocg->saved_margin || margin >= margins->low ||
-- 
1.8.3.1

