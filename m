Return-Path: <linux-block+bounces-5409-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BAB8911BD
	for <lists+linux-block@lfdr.de>; Fri, 29 Mar 2024 03:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2EA289DD7
	for <lists+linux-block@lfdr.de>; Fri, 29 Mar 2024 02:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49903399C;
	Fri, 29 Mar 2024 02:46:16 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E7C33070;
	Fri, 29 Mar 2024 02:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711680376; cv=none; b=vAlaJ7EFWujuY+/pXfCLtfW86vpjSrW4goXdStI6bQSw6sksjC6iSuc28gn/liF9PB1+laltM8rdQ+ZADLwPxaJ174vWF+WlzlxarLXPovDPlJdBMm8VbUZepw0/yeVFBuBT/pdyyMcL6JF7NkR2uk67MEONtLr0c94hWP5cSaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711680376; c=relaxed/simple;
	bh=mO5pDF4ppVBRq6mSFl/EZBnRAtwgeKIJXHKAIeHEMZs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lRVWNffwth5CFzl6guRW4mprjGqiCdnn4UJLf8PmiG3qT2HbkKq80EogLyAgzBTAyyGB+r5qbQZn0KBv7aXBNlUUcAdwpKCkBUNMQDHcNB+1+EpfhBHu1u5jyJt/tb0dc090Jvkm3VHKZEFSDvdkvF2ff5YElIrlojMSGX8hXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42T2iY6c066183;
	Fri, 29 Mar 2024 10:44:34 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4V5PpH2xSzz2L8K10;
	Fri, 29 Mar 2024 10:42:47 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 29 Mar 2024 10:44:31 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <axboe@kernel.dk>
CC: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH] block/mq-deadline: Fix WARN when set async_depth by sysfs
Date: Fri, 29 Mar 2024 10:44:21 +0800
Message-ID: <1711680261-5789-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 42T2iY6c066183

A WARN may occur when async_depth is set from user by sysfs,
the warning log is as following:

[  623.848659] WARNING: CPU: 0 PID: 7798 at lib/sbitmap.c:537 sbitmap_queue_get_shallow+0x2c/0x38
[  623.878550] CPU: 0 PID: 7798 Comm: kworker/u16:2 Tainted: G        W  OE      6.6.0-mainline-g8d9254e6f4a0-dirty-ab000013 #1
[  623.880091] Hardware name: Unisoc UMS9621-base Board (DT)
[  623.880906] Workqueue: writeback wb_workfn (flush-254:48)
[  623.881748] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  623.882763] pc : sbitmap_queue_get_shallow+0x2c/0x38
[  623.883525] lr : __blk_mq_get_tag+0x50/0xd4
[  623.884198] sp : ffffffc08a073230
[  623.884745] x29: ffffffc08a073230 x28: ffffffc0821445e0 x27: 0000000000000000
[  623.885799] x26: ffffff8087de8000 x25: 0000000000000000 x24: 0000000000000002
[  623.886849] x23: ffffffc0820f2008 x22: ffffff8088ac3918 x21: ffffff808c358f10
[  623.887897] x20: ffffff808c358f00 x19: ffffffc08a073360 x18: ffffffc08bde70a8
[  623.888946] x17: 000000007e57c819 x16: 000000007e57c819 x15: fffffffdfe000000
[  623.889993] x14: 0000000000000001 x13: 0000000000000004 x12: 00000003c6c931ed
[  623.891038] x11: ffffff80939a3800 x10: ffffffc0801ac88c x9 : 0000000000000000
[  623.892086] x8 : 0000000000000006 x7 : 0000000000000000 x6 : ffffffc080765204
[  623.893131] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
[  623.894174] x2 : ffffffc080765224 x1 : 0000000000000005 x0 : ffffff808c358f10
[  623.895221] Call trace:
[  623.895660] sbitmap_queue_get_shallow+0x2c/0x38
[  623.896379] blk_mq_get_tag+0xa0/0x350
[  623.896992] __blk_mq_alloc_requests+0x218/0x300
[  623.897715] blk_mq_submit_bio+0x314/0x774
[  623.898369] __submit_bio+0xb4/0xe0
[  623.898950] submit_bio_noacct_nocheck+0x110/0x324
[  623.899692] submit_bio_noacct+0x278/0x3f8
[  623.900344] submit_bio+0xcc/0xe8
[  623.900900] f2fs_submit_write_bio+0x100/0x428
[  623.901605] __submit_merged_bio+0x74/0x1ac
[  623.902269] __submit_merged_write_cond+0x188/0x1f4
[  623.903022] f2fs_write_data_pages+0xb10/0xc2c
[  623.903727] do_writepages+0xf4/0x618
[  623.904332] __writeback_single_inode+0x78/0x60c
[  623.905055] writeback_sb_inodes+0x294/0x520
[  623.905734] __writeback_inodes_wb+0xa0/0xf4
[  623.906413] wb_writeback+0x188/0x4e8
[  623.907014] wb_workfn+0x420/0x608
[  623.907582] process_one_work+0x23c/0x55c
[  623.908227] worker_thread+0x2ac/0x3e4
[  623.908838] kthread+0x108/0x12c
[  623.909389] ret_from_fork+0x10/0x20

The rootcause is user may set async_depth to a value which is less
than its initial value from dd_init_hctx->dd_depth_updated, and this
initial value is set to sbq->min_shallow_depth, when async_depth is
modified by user from sysfs, sbq->min_shallow_depth will not be changed
simultaneously, and it is also not easy to obtain tag sbitmap information
in deadline_async_depth_store.

So a suitable value should be set to min_shallow_depth in dd_depth_updated.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 block/mq-deadline.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 02a916b..89c516e 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -646,10 +646,12 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
 	struct blk_mq_tags *tags = hctx->sched_tags;
+	unsigned int shift = tags->bitmap_tags.sb.shift;
+	unsigned int dd_min_depth = max(1U, 3 * (1U << shift)  / 4);
 
 	dd->async_depth = max(1UL, 3 * q->nr_requests / 4);
 
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_depth);
+	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd_min_depth);
 }
 
 /* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */
-- 
1.9.1


