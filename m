Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D93D214A
	for <lists+linux-block@lfdr.de>; Thu, 22 Jul 2021 11:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhGVJMw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 22 Jul 2021 05:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231377AbhGVJMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 05:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626947606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yh8JAV9b4Gs+HXXKwuFvPYfl2BOt5pM1NoQvPrO91f0=;
        b=U3gFu6V7TFSC2sMtyMcjvnInPw/FMVo9fugGNqgUz+lYR0s4jQddIk/eNMCXbFPzHPmWpT
        Kn5+H3I4B5mfchtRmFYSDpY7b8ZEwdFtLSPFBJo/UlUwRv64/d4zdgE+a4kA3BivWAtFNY
        /rXw9qbckmD+jLHpofPxDXz0jvTh4mU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-9ekWXI7hMX20HFAViHTNSw-1; Thu, 22 Jul 2021 05:53:22 -0400
X-MC-Unique: 9ekWXI7hMX20HFAViHTNSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CA1A802C80;
        Thu, 22 Jul 2021 09:53:21 +0000 (UTC)
Received: from localhost (ovpn-13-219.pek2.redhat.com [10.72.13.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AC375DAA5;
        Thu, 22 Jul 2021 09:53:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 3/3] blk-mq: don't deactivate hctx if managed irq isn't used
Date:   Thu, 22 Jul 2021 17:52:46 +0800
Message-Id: <20210722095246.1240526-4-ming.lei@redhat.com>
In-Reply-To: <20210722095246.1240526-1-ming.lei@redhat.com>
References: <20210722095246.1240526-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk-mq deactivates one hctx when the last CPU in hctx->cpumask become
offline by draining all requests originated from this hctx and moving new
allocation to other active hctx. This way is for avoiding inflight IO in
case of managed irq because managed irq is shutdown when the last CPU in
the irq's affinity becomes offline.

However, lots of drivers(nvme fc, rdma, tcp, loop, ...) don't use managed
irq, so they needn't to deactivate hctx when the last CPU becomes offline.
Also, some of them are the only user of blk_mq_alloc_request_hctx() which
is used for connecting io queue. And their requirement is that the connect
request needs to be submitted successfully via one specified hctx even though
all CPUs in this hctx->cpumask have become offline.

Addressing the requirement for nvme fc/rdma/loop by allowing to
allocate request from one hctx when all CPUs in this hctx are offline,
since these drivers don't use managed irq.

Finally don't deactivate one hctx when it doesn't use managed irq.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 27 +++++++++++++++++----------
 block/blk-mq.h |  8 ++++++++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c4ac51e54eb..591ab07c64d8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -427,6 +427,15 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 }
 EXPORT_SYMBOL(blk_mq_alloc_request);
 
+static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
+{
+	int cpu = cpumask_first_and(hctx->cpumask, cpu_online_mask);
+
+	if (cpu >= nr_cpu_ids)
+		cpu = cpumask_first(hctx->cpumask);
+	return cpu;
+}
+
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	unsigned int op, blk_mq_req_flags_t flags, unsigned int hctx_idx)
 {
@@ -468,7 +477,10 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	data.hctx = q->queue_hw_ctx[hctx_idx];
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
-	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
+
+	WARN_ON_ONCE(blk_mq_hctx_use_managed_irq(data.hctx));
+
+	cpu = blk_mq_first_mapped_cpu(data.hctx);
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	if (!q->elevator)
@@ -1501,15 +1513,6 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	hctx_unlock(hctx, srcu_idx);
 }
 
-static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
-{
-	int cpu = cpumask_first_and(hctx->cpumask, cpu_online_mask);
-
-	if (cpu >= nr_cpu_ids)
-		cpu = cpumask_first(hctx->cpumask);
-	return cpu;
-}
-
 /*
  * It'd be great if the workqueue API had a way to pass
  * in a mask and had some smarts for more clever placement.
@@ -2556,6 +2559,10 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
 			struct blk_mq_hw_ctx, cpuhp_online);
 
+	/* hctx needn't to be deactivated in case managed irq isn't used */
+	if (!blk_mq_hctx_use_managed_irq(hctx))
+		return 0;
+
 	if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
 	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
 		return 0;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d08779f77a26..7333b659d8f5 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -119,6 +119,14 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 	return ctx->hctxs[type];
 }
 
+static inline bool blk_mq_hctx_use_managed_irq(struct blk_mq_hw_ctx *hctx)
+{
+	if (hctx->type == HCTX_TYPE_POLL)
+		return false;
+
+	return hctx->queue->tag_set->map[hctx->type].use_managed_irq;
+}
+
 /*
  * sysfs helpers
  */
-- 
2.31.1

