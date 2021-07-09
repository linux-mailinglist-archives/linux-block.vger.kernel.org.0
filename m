Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB163C2092
	for <lists+linux-block@lfdr.de>; Fri,  9 Jul 2021 10:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhGIIO0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 9 Jul 2021 04:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231405AbhGIIO0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Jul 2021 04:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625818303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iT5qAbZzpLMpsoq75G/ZOQir94LXNCD21dvckqRvoz8=;
        b=NwQUx4CwZzfp4lnpPsi0/JJFVJuNWsLnQtWubFx6uTIE1ifQlW+woV3+qFnIYqPgLTiija
        lCzzlqHNsHOEU0Rca/FNoQ5dSYuhS5Isi/Eu1qT6Dg3oe82ZtL2q1PrGKELY0tHzJOtqzF
        WDeKM3Gygtmi43oB0tIwpJrNxJMcWes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-ucmI_8ZvNZWVexsyOIdx3g-1; Fri, 09 Jul 2021 04:11:39 -0400
X-MC-Unique: ucmI_8ZvNZWVexsyOIdx3g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53F94804141;
        Fri,  9 Jul 2021 08:11:37 +0000 (UTC)
Received: from localhost (ovpn-13-13.pek2.redhat.com [10.72.13.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EA9119D9F;
        Fri,  9 Jul 2021 08:11:32 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 10/10] blk-mq: don't deactivate hctx if managed irq isn't used
Date:   Fri,  9 Jul 2021 16:10:05 +0800
Message-Id: <20210709081005.421340-11-ming.lei@redhat.com>
In-Reply-To: <20210709081005.421340-1-ming.lei@redhat.com>
References: <20210709081005.421340-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk-mq deactivates one hctx when the last CPU in hctx->cpumask become
offline by draining all requests originated from this hctx and moving new
allocation on other active hctx. This way is for avoiding inflight IO in
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

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 27 +++++++++++++++++----------
 block/blk-mq.h |  5 +++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2e9fd0ec63d7..d00546d3b757 100644
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
index d08779f77a26..bee755ed0903 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -119,6 +119,11 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 	return ctx->hctxs[type];
 }
 
+static inline bool blk_mq_hctx_use_managed_irq(struct blk_mq_hw_ctx *hctx)
+{
+	return hctx->queue->tag_set->map[hctx->type].use_managed_irq;
+}
+
 /*
  * sysfs helpers
  */
-- 
2.31.1

