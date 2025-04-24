Return-Path: <linux-block+bounces-20490-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF159A9B208
	for <lists+linux-block@lfdr.de>; Thu, 24 Apr 2025 17:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35B45A3B60
	for <lists+linux-block@lfdr.de>; Thu, 24 Apr 2025 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2327D1C3C1F;
	Thu, 24 Apr 2025 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJtrdX6W"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357731C5D53
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508131; cv=none; b=hr9AYslIfuggiI3PWktwfDxh85M/U2N8I45tPg3j9TVBzJ+numNQeUJ6zP2JrqfbHeP1rWE5QbMNJSM9uMLo8fUgXIvQIfsSnw6xGxxgAmU/9rMIv1iU79tbPFo8YENcCGaum8ytWniW7nGEp07Sk/dorgcP2jpSX4TLoOuyzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508131; c=relaxed/simple;
	bh=XRPdX90fDf0BmpsXlyXVPVS2esbmPgoePhAkRXrJtSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utbqP1CC4IukTod+4fPRnb8oR9PrrQTYdi+4IQ194BDfNzQz9DK84Cv0VVM8StL2Rl8eJ/tLtN4URF90AY5zPxbYqqUVTP/x5uZykq+RnLvYIYT7gUtoUoBsOXQKBDtHHdmTR1RJzuA/ZwCUyt2wqaW7pO/YiUmhwi2suLgGbDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJtrdX6W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DXRb4EAgKM4F0VrL0L7kM3G1bI4DRTaWvwCZ2ZYw9+g=;
	b=PJtrdX6W0ICMq+pXcf7lrfgGJR8u9OLFssp7EFy6+ij8m0zwPUKNZdhKwxTaudnyUJfUKL
	0Df2xalSYxcvVkRAV0SQdDiFiSUx0PxU1sHhTdi8qf7O4i+sb7wZDYDyaomlzNsruPu+W+
	qQM6Wg7pEh1nqsnweqZj2v0prPthFz4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-vp-zlOibMKi-xavnaJb66A-1; Thu,
 24 Apr 2025 11:22:05 -0400
X-MC-Unique: vp-zlOibMKi-xavnaJb66A-1
X-Mimecast-MFC-AGG-ID: vp-zlOibMKi-xavnaJb66A_1745508123
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BB401801A0D;
	Thu, 24 Apr 2025 15:22:03 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 238C31956095;
	Thu, 24 Apr 2025 15:22:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V3 02/20] block: move ELEVATOR_FLAG_DISABLE_WBT a request queue flag
Date: Thu, 24 Apr 2025 23:21:25 +0800
Message-ID: <20250424152148.1066220-3-ming.lei@redhat.com>
In-Reply-To: <20250424152148.1066220-1-ming.lei@redhat.com>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

ELEVATOR_FLAG_DISABLE_WBT is only used by BFQ to disallow wbt when BFQ is
in use. The flag is set in BFQ's init(), and cleared in BFQ's exit().

Making it as request queue flag, so that we can avoid to deal with elevator
switch race. Also it isn't graceful to checking one scheduler flag in
wbt_enable_default().

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bfq-iosched.c    | 4 ++--
 block/blk-mq-debugfs.c | 1 +
 block/blk-wbt.c        | 3 +--
 block/elevator.h       | 1 -
 include/linux/blkdev.h | 3 +++
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index abd80dc13562..cc6f59836dcd 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7210,7 +7210,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 #endif
 
 	blk_stat_disable_accounting(bfqd->queue);
-	clear_bit(ELEVATOR_FLAG_DISABLE_WBT, &e->flags);
+	blk_queue_flag_clear(QUEUE_FLAG_DISABLE_WBT_DEF, bfqd->queue);
 	wbt_enable_default(bfqd->queue->disk);
 
 	kfree(bfqd);
@@ -7397,7 +7397,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	/* We dispatch from request queue wide instead of hw queue */
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
 
-	set_bit(ELEVATOR_FLAG_DISABLE_WBT, &eq->flags);
+	blk_queue_flag_set(QUEUE_FLAG_DISABLE_WBT_DEF, q);
 	wbt_disable_default(q->disk);
 	blk_stat_enable_accounting(q);
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3421b5521fe2..7710c409e432 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -93,6 +93,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(SQ_SCHED),
+	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index f1754d07f7e0..29cd2e33666f 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -704,8 +704,7 @@ void wbt_enable_default(struct gendisk *disk)
 	struct rq_qos *rqos;
 	bool enable = IS_ENABLED(CONFIG_BLK_WBT_MQ);
 
-	if (q->elevator &&
-	    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags))
+	if (blk_queue_disable_wbt(q))
 		enable = false;
 
 	/* Throttling already enabled? */
diff --git a/block/elevator.h b/block/elevator.h
index e4e44dfac503..e27af5492cdb 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -121,7 +121,6 @@ struct elevator_queue
 };
 
 #define ELEVATOR_FLAG_REGISTERED	0
-#define ELEVATOR_FLAG_DISABLE_WBT	1
 
 /*
  * block elevator interface
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 678dc38442bf..228b2e5ad493 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -644,6 +644,7 @@ enum {
 	QUEUE_FLAG_RQ_ALLOC_TIME,	/* record rq->alloc_time_ns */
 	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
 	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
+	QUEUE_FLAG_DISABLE_WBT_DEF,	/* for sched to disable/enable wbt */
 	QUEUE_FLAG_MAX
 };
 
@@ -679,6 +680,8 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
 #define blk_queue_skip_tagset_quiesce(q) \
 	((q)->limits.features & BLK_FEAT_SKIP_TAGSET_QUIESCE)
+#define blk_queue_disable_wbt(q)	\
+	test_bit(QUEUE_FLAG_DISABLE_WBT_DEF, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.47.0


