Return-Path: <linux-block+bounces-269-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B757F0B0B
	for <lists+linux-block@lfdr.de>; Mon, 20 Nov 2023 04:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C632B207C9
	for <lists+linux-block@lfdr.de>; Mon, 20 Nov 2023 03:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7828D1FB4;
	Mon, 20 Nov 2023 03:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pvG4sWih"
X-Original-To: linux-block@vger.kernel.org
X-Greylist: delayed 326 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Nov 2023 19:31:32 PST
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [IPv6:2001:41d0:203:375::af])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C3DD4F
	for <linux-block@vger.kernel.org>; Sun, 19 Nov 2023 19:31:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700450765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+VymdBzRpvTEsF3r3W4saDJpuCxv1e2XIK11MThN86Y=;
	b=pvG4sWihLLOWQMeNrUGbVMCed1GK0wWLXgmev8oACdRLvYJ9DrEtcOasNYh/uvpz30av7j
	SiJkIS6g1AogyFxYNF7I/CeOikgUGuenfDgWlW3eAkihvSm7YZzVkmULdjNBHHGv51t20q
	5HtQQxdyGLQggrjxxvz+42ayVBPy3fA=
From: chengming.zhou@linux.dev
To: axboe@kernel.dk,
	bvanassche@acm.org
Cc: kch@nvidia.com,
	damien.lemoal@opensource.wdc.com,
	ming.lei@redhat.com,
	zhouchengming@bytedance.com,
	justinstitt@google.com,
	shinichiro.kawasaki@wdc.com,
	akinobu.mita@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev,
	syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com
Subject: [PATCH] block/null_blk: Fix double blk_mq_start_request() warning
Date: Mon, 20 Nov 2023 03:25:21 +0000
Message-Id: <20231120032521.1012037-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

When CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is enabled, null_queue_rq()
would return BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE for the request,
which has been marked as MQ_RQ_IN_FLIGHT by blk_mq_start_request().

Then null_queue_rqs() put these requests in the rqlist, return back to
the block layer core, which would try to queue them individually again,
so the warning in blk_mq_start_request() triggered.

Fix it by splitting the null_queue_rq() into two parts: the first is the
preparation of request, the second is the handling of request. We put
the blk_mq_start_request() after the preparation part, which may fail
and return back to the block layer core.

The throttling also belongs to the preparation part, so move it before
blk_mq_start_request(). And change the return type of null_handle_cmd()
to void, since it always return BLK_STS_OK now.

Reported-by: syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000000e6aac06098aee0c@google.com/
Fixes: d78bfa1346ab ("block/null_blk: add queue_rqs() support")
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 drivers/block/null_blk/main.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 22a3cf7f32e2..3021d58ca51c 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1464,19 +1464,13 @@ blk_status_t null_process_cmd(struct nullb_cmd *cmd, enum req_op op,
 	return BLK_STS_OK;
 }
 
-static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
-				    sector_t nr_sectors, enum req_op op)
+static void null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
+			    sector_t nr_sectors, enum req_op op)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	struct nullb *nullb = dev->nullb;
 	blk_status_t sts;
 
-	if (test_bit(NULLB_DEV_FL_THROTTLED, &dev->flags)) {
-		sts = null_handle_throttled(cmd);
-		if (sts != BLK_STS_OK)
-			return sts;
-	}
-
 	if (op == REQ_OP_FLUSH) {
 		cmd->error = errno_to_blk_status(null_handle_flush(nullb));
 		goto out;
@@ -1493,7 +1487,6 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 
 out:
 	nullb_complete_cmd(cmd);
-	return BLK_STS_OK;
 }
 
 static enum hrtimer_restart nullb_bwtimer_fn(struct hrtimer *timer)
@@ -1724,8 +1717,6 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	cmd->fake_timeout = should_timeout_request(rq) ||
 		blk_should_fake_timeout(rq->q);
 
-	blk_mq_start_request(rq);
-
 	if (should_requeue_request(rq)) {
 		/*
 		 * Alternate between hitting the core BUSY path, and the
@@ -1738,6 +1729,15 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return BLK_STS_OK;
 	}
 
+	if (test_bit(NULLB_DEV_FL_THROTTLED, &nq->dev->flags)) {
+		blk_status_t sts = null_handle_throttled(cmd);
+
+		if (sts != BLK_STS_OK)
+			return sts;
+	}
+
+	blk_mq_start_request(rq);
+
 	if (is_poll) {
 		spin_lock(&nq->poll_lock);
 		list_add_tail(&rq->queuelist, &nq->poll_list);
@@ -1747,7 +1747,8 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (cmd->fake_timeout)
 		return BLK_STS_OK;
 
-	return null_handle_cmd(cmd, sector, nr_sectors, req_op(rq));
+	null_handle_cmd(cmd, sector, nr_sectors, req_op(rq));
+	return BLK_STS_OK;
 }
 
 static void null_queue_rqs(struct request **rqlist)
-- 
2.40.1


