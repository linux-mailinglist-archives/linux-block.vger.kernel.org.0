Return-Path: <linux-block+bounces-3367-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53E285B2C5
	for <lists+linux-block@lfdr.de>; Tue, 20 Feb 2024 07:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D331F252BF
	for <lists+linux-block@lfdr.de>; Tue, 20 Feb 2024 06:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EA057872;
	Tue, 20 Feb 2024 06:16:20 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F8242A82
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 06:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409779; cv=none; b=AKRoAU1ZGd2MItTjnAw+DuFurFSmbaGwd+QymGPdvwKll53N2z0tEAYCznewcpyBfizcEguROWQVmD8WKeQ6GGmCwDQVJF5LXZc3NFL4Wp/xQAbXEoPDpzeZZuCNTCuEMhqKmx1581Tqj/3id47iwH4xTj4t6HtQ/l4GHH9LmBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409779; c=relaxed/simple;
	bh=6PsW9IgtA4lBHrAO4yi8iQHX3lJ8D2d1JDs9TZDmVvw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsOqiJLS5jKK6NwJpN8Z6URU2TcIxMalv5DrpigsyiAn4d5Q/aZQOhOM8oz2Ex+sqFO1eSGAeHr9KoHiQZRD/zn8IZy7azH4eXdLxRpM0qHwlER2HdGBC1JW7/gII6UoKgylyFq7Km3QVI+em+SuBYZoU9i+M8HfCJi14Yd9Geo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41K6FuVp095152;
	Tue, 20 Feb 2024 14:15:57 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Tf8K76bmWz2K25V6;
	Tue, 20 Feb 2024 14:15:23 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 20 Feb 2024 14:15:54 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot
	<vincent.guittot@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH 2/2] block: adjust CFS request expire time
Date: Tue, 20 Feb 2024 14:15:42 +0800
Message-ID: <20240220061542.489922-2-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220061542.489922-1-zhaoyang.huang@unisoc.com>
References: <20240220061542.489922-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 41K6FuVp095152

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

According to current policy, CFS's may suffer involuntary IO-latency by
being preempted by RT/DL tasks or IRQ since they possess the privilege for
both of CPU and IO scheduler. This commit introduce an approximate and
light method to decrease these affection by adjusting the expire time
via the CFS's proportion among the whole cpu active time.
The average utilization of cpu's run queue could reflect the historical
active proportion of different types of task that can be proved valid for
this goal from belowing three perspective,

1. All types of sched class's load(util) are tracked and calculated in the
same way(using a geometric series which known as PELT)
2. Keep the legacy policy by NOT adjusting rq's position in fifo_list
but only make changes over expire_time.
3. The fixed expire time(hundreds of ms) is in the same range of cpu
avg_load's account series(the utilization will be decayed to 0.5 in 32ms)

TaskA
sched in
|
|
|
submit_bio
|
|
|
fifo_time = jiffies + expire
(insert_request)

TaskB
sched in
|
|
vfs_xxx
|
|preempted by RT,DL,IRQ
|\
| This period time is unfair to TaskB's IO request, should be adjust
|/
|
submit_bio
|
|
|
fifo_time = jiffies + expire * CFS_PROPORTION(rq)
(insert_request)

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 block/mq-deadline.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f958e79277b8..1e538cb2783b 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -839,8 +839,15 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 		/*
 		 * set expire time and add to fifo list
+		 * The expire time is adjusted via calculating the proportion of
+		 * CFS's activation among whole cpu time during last several
+		 * dazen's ms.Whearas, this would NOT affect the rq's position in
+		 * fifo_list but only take effect when this rq is checked for its
+		 * expire time when at head.
 		 */
-		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
+		rq->fifo_time = jiffies +
+			cfs_prop_by_util(current, dd->fifo_expire[data_dir]);
+
 		insert_before = &per_prio->fifo_list[data_dir];
 #ifdef CONFIG_BLK_DEV_ZONED
 		/*
-- 
2.25.1


