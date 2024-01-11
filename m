Return-Path: <linux-block+bounces-1728-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C3E82B234
	for <lists+linux-block@lfdr.de>; Thu, 11 Jan 2024 16:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967A828BB53
	for <lists+linux-block@lfdr.de>; Thu, 11 Jan 2024 15:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BD54F89C;
	Thu, 11 Jan 2024 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFuKJNg8"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8532E4F898
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704988500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N2zkMhK+45qG/GcFjunTZZrztvgu3syuF871fW0x/3Y=;
	b=MFuKJNg85wraKXFTkfsE7kv1ZuckhuB+rXxXOEEnp7fbPtW4orZWrNQ5yQ8U48Cqa6lxrd
	VC7MIHTpe6NVXQbm3kKexJ/JXeAaAKZeJMsDqO+6RgJR7Mzu35DnHE7JBzprRdNQXL1uAp
	7fwC/T/D8F0CQPfgo3TXoPgxDQ0g3Ok=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-S5zCa7FkNraoVV9QC4WrkQ-1; Thu,
 11 Jan 2024 10:54:59 -0500
X-MC-Unique: S5zCa7FkNraoVV9QC4WrkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 950671C106A3;
	Thu, 11 Jan 2024 15:54:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0A2015012;
	Thu, 11 Jan 2024 15:54:56 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: David Jeffery <djeffery@redhat.com>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Jan Kara <jack@suse.cz>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Ming Lei <ming.lei@redhat.com>,
	Changhui Zhong <czhong@redhat.com>
Subject: [PATCH] blk-mq: fix IO hang from sbitmap wakeup race
Date: Thu, 11 Jan 2024 23:54:48 +0800
Message-ID: <20240111155448.4097173-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

In blk_mq_mark_tag_wait(), __add_wait_queue() may be re-ordered
with the following blk_mq_get_driver_tag() in case of getting driver
tag failure.

Then in __sbitmap_queue_wake_up(), waitqueue_active() may not observe
the added waiter in blk_mq_mark_tag_wait() and wake up nothing, meantime
blk_mq_mark_tag_wait() can't get driver tag successfully.

This issue can be reproduced by running the following test in loop, and
fio hang can be observed in < 30min when running it on my test VM
in laptop.

	modprobe -r scsi_debug
	modprobe scsi_debug delay=0 dev_size_mb=4096 max_queue=1 host_max_queue=1 submit_queues=4
	dev=`ls -d /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/* | head -1 | xargs basename`
	fio --filename=/dev/"$dev" --direct=1 --rw=randrw --bs=4k --iodepth=1 \
       		--runtime=100 --numjobs=40 --time_based --name=test \
        	--ioengine=libaio

Fix the issue by adding one explicit barrier in blk_mq_mark_tag_wait(), which
is just fine in case of running out of tag.

Apply the same pattern in blk_mq_get_tag() which should have same risk.

Reported-by: Changhui Zhong <czhong@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
BTW, Changhui is planning to upstream the test case to blktests.

 block/blk-mq-tag.c | 19 +++++++++++++++++++
 block/blk-mq.c     | 16 ++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index cc57e2dd9a0b..29f77cae8eb2 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -179,6 +179,25 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 
 		sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIBLE);
 
+		/*
+		 * Add one explicit barrier since __blk_mq_get_tag() may not
+		 * imply barrier in case of failure.
+		 *
+		 * Order adding us to wait queue and the following allocating
+		 * tag in  __blk_mq_get_tag().
+		 *
+		 * The pair is the one implied in sbitmap_queue_wake_up()
+		 * which orders clearing sbitmap tag bits and
+		 * waitqueue_active() in __sbitmap_queue_wake_up(), since
+		 * waitqueue_active() is lockless
+		 *
+		 * Otherwise, re-order of adding wait queue and getting tag
+		 * may cause __sbitmap_queue_wake_up() to wake up nothing
+		 * because the waitqueue_active() may not observe us in wait
+		 * queue.
+		 */
+		smp_mb();
+
 		tag = __blk_mq_get_tag(data, bt);
 		if (tag != BLK_MQ_NO_TAG)
 			break;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index fb29ff5cc281..54545a4792bf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1847,6 +1847,22 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
 	__add_wait_queue(wq, wait);
 
+	/*
+	 * Add one explicit barrier since blk_mq_get_driver_tag() may
+	 * not imply barrier in case of failure.
+	 *
+	 * Order adding us to wait queue and allocating driver tag.
+	 *
+	 * The pair is the one implied in sbitmap_queue_wake_up() which
+	 * orders clearing sbitmap tag bits and waitqueue_active() in
+	 * __sbitmap_queue_wake_up(), since waitqueue_active() is lockless
+	 *
+	 * Otherwise, re-order of adding wait queue and getting driver tag
+	 * may cause __sbitmap_queue_wake_up() to wake up nothing because
+	 * the waitqueue_active() may not observe us in wait queue.
+	 */
+	smp_mb();
+
 	/*
 	 * It's possible that a tag was freed in the window between the
 	 * allocation failure and adding the hardware queue to the wait
-- 
2.42.0


