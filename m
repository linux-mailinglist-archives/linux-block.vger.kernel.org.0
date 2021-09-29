Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396E641BDE2
	for <lists+linux-block@lfdr.de>; Wed, 29 Sep 2021 06:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhI2ETG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Sep 2021 00:19:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232353AbhI2ETF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 00:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632889044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KrY+IS0jZG6xj97OVcmzVVUHAeJrr7PBDGZWgu5Io0k=;
        b=iJZx3SrcFEa9DI9Syv/L7hKZa+oXFe6dbBdCQexkBKanuTLq6VFuFmyYc8IsxQHoDnhuOt
        U6DBESRxJVzcknWu9AlihyBvXN8mlKGnsLbkX84GPynF9dretkvsuOcHvX/CFSMhxwUmDD
        5PlIt0eEYbH9Tc7miu8D9CDh/la6+5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-TXdVKvJuNLu7Y0fl6E3Atw-1; Wed, 29 Sep 2021 00:17:20 -0400
X-MC-Unique: TXdVKvJuNLu7Y0fl6E3Atw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDB9C801B3D;
        Wed, 29 Sep 2021 04:17:18 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8D2519C79;
        Wed, 29 Sep 2021 04:17:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/5] blk-mq: support nested blk_mq_quiesce_queue()
Date:   Wed, 29 Sep 2021 12:15:59 +0800
Message-Id: <20210929041559.701102-6-ming.lei@redhat.com>
In-Reply-To: <20210929041559.701102-1-ming.lei@redhat.com>
References: <20210929041559.701102-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Turns out that blk_mq_freeze_queue() isn't stronger[1] than
blk_mq_quiesce_queue() because dispatch may still be in-progress after
queue is frozen, and in several cases, such as switching io scheduler,
updating nr_requests & wbt latency, we still need to quiesce queue as a
supplement of freezing queue.

As we need to extend uses of blk_mq_quiesce_queue(), it is inevitable
for us to need support nested quiesce, especailly we can't let
unquiesce happen when there is quiesce originated from other contexts.

This patch introduces q->mq_quiesce_depth to deal concurrent quiesce,
and we only unquiesce queue when it is the last one from all contexts.

One kernel panic issue has been reported[2] when running stress test on
dm-mpath's updating nr_requests and suspending queue, and the similar
issue should exist on almost all drivers which use quiesce/unquiesce.

[1] https://marc.info/?l=linux-block&m=150993988115872&w=2
[2] https://listman.redhat.com/archives/dm-devel/2021-September/msg00189.html

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 20 +++++++++++++++++---
 include/linux/blkdev.h |  2 ++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 21bf4c3f0825..10f8a3d4e3a1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -209,7 +209,12 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
  */
 void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 {
-	blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->queue_lock, flags);
+	if (!q->quiesce_depth++)
+		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
+	spin_unlock_irqrestore(&q->queue_lock, flags);
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
@@ -250,10 +255,19 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
-	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
+	unsigned long flags;
+	bool run_queue = false;
+
+	spin_lock_irqsave(&q->queue_lock, flags);
+	if (q->quiesce_depth > 0 && !--q->quiesce_depth) {
+		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
+		run_queue = true;
+	}
+	spin_unlock_irqrestore(&q->queue_lock, flags);
 
 	/* dispatch requests which are inserted during quiescing */
-	blk_mq_run_hw_queues(q, true);
+	if (run_queue)
+		blk_mq_run_hw_queues(q, true);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0e960d74615e..74c60e2d61f9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -315,6 +315,8 @@ struct request_queue {
 	 */
 	struct mutex		mq_freeze_lock;
 
+	int			quiesce_depth;
+
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
 	struct bio_set		bio_split;
-- 
2.31.1

