Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45DC619288F
	for <lists+linux-block@lfdr.de>; Wed, 25 Mar 2020 13:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgCYMkM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Mar 2020 08:40:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12128 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727279AbgCYMkM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 08:40:12 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 603F2F92AFD04B510924;
        Wed, 25 Mar 2020 20:40:09 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 25 Mar 2020
 20:40:08 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>, <gregkh@linuxfoundation.org>, <hch@infradead.org>
Subject: [PATCH v4 5/6] blk-wbt: replace bdi_dev_name() with bdi_get_dev_name()
Date:   Wed, 25 Mar 2020 20:38:42 +0800
Message-ID: <20200325123843.47452-6-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200325123843.47452-1-yuyufen@huawei.com>
References: <20200325123843.47452-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

wb_timer_fn() can be called after bdi unregister. So, we get bdi
device name by bdi_get_dev_name() to avoid use-after-free or null
pointer deference for bdi->dev.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 include/trace/events/wbt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
index 9996420d7ec4..3fbf15565962 100644
--- a/include/trace/events/wbt.h
+++ b/include/trace/events/wbt.h
@@ -33,7 +33,7 @@ TRACE_EVENT(wbt_stat,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, bdi_dev_name(bdi),
+		bdi_get_dev_name(bdi, __entry->name,
 			ARRAY_SIZE(__entry->name));
 		__entry->rmean		= stat[0].mean;
 		__entry->rmin		= stat[0].min;
@@ -68,7 +68,7 @@ TRACE_EVENT(wbt_lat,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, bdi_dev_name(bdi),
+		bdi_get_dev_name(bdi, __entry->name,
 			ARRAY_SIZE(__entry->name));
 		__entry->lat = div_u64(lat, 1000);
 	),
@@ -105,7 +105,7 @@ TRACE_EVENT(wbt_step,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, bdi_dev_name(bdi),
+		bdi_get_dev_name(bdi, __entry->name,
 			ARRAY_SIZE(__entry->name));
 		__entry->msg	= msg;
 		__entry->step	= step;
@@ -141,7 +141,7 @@ TRACE_EVENT(wbt_timer,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, bdi_dev_name(bdi),
+		bdi_get_dev_name(bdi, __entry->name,
 			ARRAY_SIZE(__entry->name));
 		__entry->status		= status;
 		__entry->step		= step;
-- 
2.17.2

