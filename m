Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE02E227568
	for <lists+linux-block@lfdr.de>; Tue, 21 Jul 2020 04:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgGUCK5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Jul 2020 22:10:57 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:58844 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbgGUCK5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 22:10:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U3MH0bB_1595297454;
Received: from localhost(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0U3MH0bB_1595297454)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jul 2020 10:10:54 +0800
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>
Subject: [PATCH v3] block: delete unused config BLK_RQ_IO_DATA_LEN
Date:   Tue, 21 Jul 2020 10:10:52 +0800
Message-Id: <1595297452-38695-1-git-send-email-jiufei.xue@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Config BLK_RQ_IO_DATA_LEN was once used to enable the io_data_len field
in reqeust to remember blk_rq_bytes() at the time the request gets
issued. However io_data_len is replaced by blk_rq_stats_sectors() and
the config is not used now. So delete it.

Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
---
 block/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/Kconfig b/block/Kconfig
index 9357d73..d52c9bc 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -146,7 +146,6 @@ config BLK_CGROUP_IOLATENCY
 config BLK_CGROUP_IOCOST
 	bool "Enable support for cost model based cgroup IO controller"
 	depends on BLK_CGROUP=y
-	select BLK_RQ_IO_DATA_LEN
 	select BLK_RQ_ALLOC_TIME
 	help
 	Enabling this option enables the .weight interface for cost
-- 
1.8.3.1

