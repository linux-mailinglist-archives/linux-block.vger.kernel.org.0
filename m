Return-Path: <linux-block+bounces-6419-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146548AC400
	for <lists+linux-block@lfdr.de>; Mon, 22 Apr 2024 08:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF7A2828BE
	for <lists+linux-block@lfdr.de>; Mon, 22 Apr 2024 06:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C8B182DF;
	Mon, 22 Apr 2024 06:07:09 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAF51BC2A
	for <linux-block@vger.kernel.org>; Mon, 22 Apr 2024 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713766029; cv=none; b=YMeURjrgUVqkHIyxrjDgiX/D6U1itaftqtjJPSpjeDS6ighrUGSC7Z8l306iiDpSGdGjT176YhK9MQk7ofT7nUL7x2jgCFi3SEKdFqFn18vEi/CVLAeBtVqJ2WCi/P3sOJikRjV2gNt4ilb7kknCYdbD7T5Au1dGjkTDKJOmYxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713766029; c=relaxed/simple;
	bh=62mpytka2afKyO5XcFdsGyLPzPjfnlQu9eKZSfYDYx0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u8R5WBWI0t0qxh9lOLIBCKD5dJpJfyRi/iOnDjxpwkgwu2B1yx3gmotUKkXEM4ubIWH00I1k+OMjSkZ8qL2Vz2cb0cHvZXSTIekor7/0GIr74XqoY+WlYFmxcLjS5y6cIpEak2mz5gV3915No4w4QVqNLT5KUvHY/Ym3Uv+bc7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 43M5jF8K091140
	for <linux-block@vger.kernel.org>; Mon, 22 Apr 2024 13:45:15 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 43M5isUp089400;
	Mon, 22 Apr 2024 13:44:54 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VNDfN3lJFz2NK302;
	Mon, 22 Apr 2024 13:42:20 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 22 Apr 2024 13:44:51 +0800
From: Dongliang Cui <dongliang.cui@unisoc.com>
To: <axboe@kernel.dk>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <ebiggers@kernel.org>
CC: <ke.wang@unisoc.com>, <hongyu.jin.cn@gmail.com>, <niuzhiguo84@gmail.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cuidongliang390@gmail.com>, Dongliang Cui <dongliang.cui@unisoc.com>
Subject: [PATCH v2] block: Add ioprio to block_rq tracepoint
Date: Mon, 22 Apr 2024 13:43:17 +0800
Message-ID: <20240422054317.1779168-1-dongliang.cui@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 43M5isUp089400

Sometimes we need to track the processing order of requests with
ioprio set. So the ioprio of request can be useful information.

Example：

block_rq_insert: 8,0 WS 4096 () 16573296 + 8 rt,4 [highpool[1]]
block_rq_issue: 8,0 WS 4096 () 16573296 + 8 rt,4 [kworker/7:0H]
block_rq_complete: 8,0 WS () 16573296 + 8 rt,4 [0]

Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>

Changes history
Changes in v2:
Update the printing method of ioprio_class.
---
 include/trace/events/block.h | 36 ++++++++++++++++++++++++++----------
 include/uapi/linux/ioprio.h  |  7 +++++++
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 0e128ad51460..8aa0116077ee 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/tracepoint.h>
+#include <uapi/linux/ioprio.h>
 
 #define RWBS_LEN	8
 
@@ -82,6 +83,8 @@ TRACE_EVENT(block_rq_requeue,
 		__field(  dev_t,	dev			)
 		__field(  sector_t,	sector			)
 		__field(  unsigned int,	nr_sector		)
+		__field(  unsigned int,	ioprio_class		)
+		__field(  unsigned int, ioprio_value		)
 		__array(  char,		rwbs,	RWBS_LEN	)
 		__dynamic_array( char,	cmd,	1		)
 	),
@@ -90,16 +93,19 @@ TRACE_EVENT(block_rq_requeue,
 		__entry->dev	   = rq->q->disk ? disk_devt(rq->q->disk) : 0;
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
+		__entry->ioprio_class = rq->ioprio >> IOPRIO_CLASS_SHIFT & 0x3;
+		__entry->ioprio_value = rq->ioprio & 0xff;
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 	),
 
-	TP_printk("%d,%d %s (%s) %llu + %u [%d]",
+	TP_printk("%d,%d %s (%s) %llu + %u %s,%u [%d]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __get_str(cmd),
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, 0)
+		  (unsigned long long)__entry->sector, __entry->nr_sector,
+		  __print_symbolic(__entry->ioprio_class, IOPRIO_CLASS_STRINGS),
+		  __entry->ioprio_value, 0)
 );
 
 DECLARE_EVENT_CLASS(block_rq_completion,
@@ -113,6 +119,8 @@ DECLARE_EVENT_CLASS(block_rq_completion,
 		__field(  sector_t,	sector			)
 		__field(  unsigned int,	nr_sector		)
 		__field(  int	,	error			)
+		__field(  unsigned int,	ioprio_class		)
+		__field(  unsigned int, ioprio_value		)
 		__array(  char,		rwbs,	RWBS_LEN	)
 		__dynamic_array( char,	cmd,	1		)
 	),
@@ -122,16 +130,19 @@ DECLARE_EVENT_CLASS(block_rq_completion,
 		__entry->sector    = blk_rq_pos(rq);
 		__entry->nr_sector = nr_bytes >> 9;
 		__entry->error     = blk_status_to_errno(error);
+		__entry->ioprio_class = rq->ioprio >> IOPRIO_CLASS_SHIFT & 0x3;
+		__entry->ioprio_value = rq->ioprio & 0xff;
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 	),
 
-	TP_printk("%d,%d %s (%s) %llu + %u [%d]",
+	TP_printk("%d,%d %s (%s) %llu + %u %s,%u [%d]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __get_str(cmd),
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->error)
+		  (unsigned long long)__entry->sector, __entry->nr_sector,
+		  __print_symbolic(__entry->ioprio_class, IOPRIO_CLASS_STRINGS),
+		  __entry->ioprio_value, __entry->error)
 );
 
 /**
@@ -180,8 +191,10 @@ DECLARE_EVENT_CLASS(block_rq,
 		__field(  sector_t,	sector			)
 		__field(  unsigned int,	nr_sector		)
 		__field(  unsigned int,	bytes			)
+		__field(  unsigned int,	ioprio_class		)
+		__field(  unsigned int, ioprio_value		)
 		__array(  char,		rwbs,	RWBS_LEN	)
-		__array(  char,         comm,   TASK_COMM_LEN   )
+		__array(  char,		comm,   TASK_COMM_LEN	)
 		__dynamic_array( char,	cmd,	1		)
 	),
 
@@ -190,17 +203,20 @@ DECLARE_EVENT_CLASS(block_rq,
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
 		__entry->bytes     = blk_rq_bytes(rq);
+		__entry->ioprio_class = rq->ioprio >> IOPRIO_CLASS_SHIFT & 0x3;
+		__entry->ioprio_value = rq->ioprio & 0xff;
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
-	TP_printk("%d,%d %s %u (%s) %llu + %u [%s]",
+	TP_printk("%d,%d %s %u (%s) %llu + %u %s,%u [%s]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __entry->bytes, __get_str(cmd),
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->comm)
+		  (unsigned long long)__entry->sector, __entry->nr_sector,
+		  __print_symbolic(__entry->ioprio_class, IOPRIO_CLASS_STRINGS),
+		  __entry->ioprio_value, __entry->comm)
 );
 
 /**
diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index bee2bdb0eedb..9a43ad3a65ab 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -35,6 +35,13 @@ enum {
 	IOPRIO_CLASS_INVALID	= 7,
 };
 
+#define IOPRIO_CLASS_STRINGS \
+	{ IOPRIO_CLASS_NONE,	"none" }, \
+	{ IOPRIO_CLASS_RT,	"rt" }, \
+	{ IOPRIO_CLASS_BE,	"be" }, \
+	{ IOPRIO_CLASS_IDLE,	"idle" }, \
+	{ IOPRIO_CLASS_INVALID,	"invalid" }
+
 /*
  * The RT and BE priority classes both support up to 8 priority levels that
  * can be specified using the lower 3-bits of the priority data.
-- 
2.25.1


