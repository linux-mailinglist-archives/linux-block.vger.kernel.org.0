Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418812B073E
	for <lists+linux-block@lfdr.de>; Thu, 12 Nov 2020 15:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgKLOIK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Nov 2020 09:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgKLOII (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 09:08:08 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC12C0613D1;
        Thu, 12 Nov 2020 06:08:06 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 11so5289212qkd.5;
        Thu, 12 Nov 2020 06:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wq0TTtOfCmq5rw8H3/BW0bTDOXciTJIX0nn7uC7rhZE=;
        b=qoi+sFlbYvSA7V/w38GUcOZj555blWHiGPwdSpj6COfEV98uSSlrabdUmrpisgpgU2
         o3bjcfgeoMPgX8e+uc7SCYW4ZavJSJzEDCL6aZNFxHf5P+MFlcyi1OML8TEurj7fNnx5
         rReBKDTugOWS8YYaWSUjkGYta8G4s2ZwGhYooyzukHoCrPRGiBofwm4BP+ESHi26agOV
         9Y5ExXWOgW7V40Xfnuw98yz4usPMfoVUk2WkVDR5JpTQsVqpQCb78tEhxV1xlk8FpR2X
         DRPoUMf7gKPJW3Z8PWxA5rB9Vm3fnF/rRZdE7USjWSJC6Zh5Pi1Abh6choNcBfXORtCw
         Ebog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wq0TTtOfCmq5rw8H3/BW0bTDOXciTJIX0nn7uC7rhZE=;
        b=E1EZ4e3gukDr0OezWCEarwOYfoHK8XnxMpeGVmsmw+iSxam6JZY3VL8YQoi+WJLobi
         8+F92T8rGwBVuj3R1O/5eZNLS4ElGQImTIFlrpWxC6JiDt9f4oeTW/KFoOsxLTAkYRQz
         XXSA284Gb3ujrc+sKrdC6VtplQNypfYTBV2JI659yvuK+vli2gFDLrQ52DtMB+GNsRrX
         UmkY9Nsh9DglzB65/7p4tf5fprpQTu0A7JP9y7q1wKAshZIOJqlY6w8U9Bmf7ISvb436
         ZlHtx/Cj6doTAbp9a8GwJNQi1lD78G/Xze6/PLYXJ/x0eOh8XcPDIC9IiDxycwiwXQ3p
         YKMw==
X-Gm-Message-State: AOAM5304RbPVAoyCZg9jOMaM0gEtLPPlip3sH4SEi8uDWP9r81dP7Mbi
        NUHIfFMzecsdZd86DuPPiw==
X-Google-Smtp-Source: ABdhPJzL3B1l0WXfWIIu4w1iDcUICTeNQKVagY5WrNdCP9DefBDeEo2k+9b71PoEaeE92rVDL7u3UA==
X-Received: by 2002:ae9:c211:: with SMTP id j17mr32011594qkg.458.1605190085900;
        Thu, 12 Nov 2020 06:08:05 -0800 (PST)
Received: from localhost.localdomain ([68.175.153.174])
        by smtp.gmail.com with ESMTPSA id g13sm4742881qth.27.2020.11.12.06.08.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 06:08:04 -0800 (PST)
From:   Rachit Agarwal <rach4x0r@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Rachit Agarwal <rach4x0r@gmail.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
        Qizhe Cai <qc228@cornell.edu>,
        Midhul Vuppalapati <mvv25@cornell.edu>,
        Rachit Agarwal <ragarwal@cs.cornell.edu>,
        Sagi Grimberg <sagi@lightbitslabs.com>,
        Rachit Agarwal <ragarwal@cornell.edu>
Subject: [PATCH] iosched: Add i10 I/O Scheduler
Date:   Thu, 12 Nov 2020 09:07:52 -0500
Message-Id: <20201112140752.1554-1-rach4x0r@gmail.com>
X-Mailer: git-send-email 2.15.2 (Apple Git-101.1)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Rachit Agarwal <rach4x0r@gmail.com>>

Hi All,

I/O batching is beneficial for optimizing IOPS and throughput for various
applications. For instance, several kernel block drivers would benefit from batching,
including mmc [1] and tcp-based storage drivers like nvme-tcp [2,3]. While we have
support for batching dispatch [4], we need an I/O scheduler to efficiently enable
batching. Such a scheduler is particularly interesting for disaggregated storage,
where the access latency of remote disaggregated storage may be higher than local
storage access; thus, batching can significantly help in amortizing the remote access
latency while increasing the throughput.

This patch introduces the i10 I/O scheduler, which performs batching per hctx in terms
of #requests, #bytes, and timeouts (at microseconds granularity). i10 starts
dispatching only when #requests or #bytes is larger than a default threshold or when
a timer expires. After that, batching dispatch [3] would happen, allowing batching
at device drivers along with "bd->last" and ".commit_rqs".

The i10 I/O scheduler builds upon recent work on [6]. We have tested the i10 I/O
scheduler with nvme-tcp optimizaitons [2,3] and batching dispatch [4], varying number
of cores, varying read/write ratios, and varying request sizes, and with NVMe SSD and
RAM block device. For NVMe SSDs, the i10 I/O scheduler achieves ~60% improvements in
terms of IOPS per core over "noop" I/O scheduler. These results are available at [5],
and many additional results are presented in [6].

While other schedulers may also batch I/O (e.g., mq-deadline), the optimization target
in the i10 I/O scheduler is throughput maximization. Hence there is no latency target
nor a need for a global tracking context, so a new scheduler is needed rather than
to build this functionality to an existing scheduler.

We currently use fixed default values as batching thresholds (e.g., 16 for #requests,
64KB for #bytes, and 50us for timeout). These default values are based on sensitivity
tests in [6]. For our future work, we plan to support adaptive batching according to
system load and to extend the scheduler to support isolation in multi-tenant deployments
(to simultaneously achieve low tail latency for latency-sensitive applications and high
throughput for throughput-bound applications).

References
[1] https://lore.kernel.org/linux-block/cover.1587888520.git.baolin.wang7@gmail.com/T/#mc48a8fb6069843827458f5fea722e1179d32af2a
[2] https://git.infradead.org/nvme.git/commit/122e5b9f3d370ae11e1502d14ff5c7ea9b144a76
[3] https://git.infradead.org/nvme.git/commit/86f0348ace1510d7ac25124b096fb88a6ab45270
[4] https://lore.kernel.org/linux-block/20200630102501.2238972-1-ming.lei@redhat.com/
[5] https://github.com/i10-kernel/upstream-linux/blob/master/dss-evaluation.pdf
[6] https://www.usenix.org/conference/nsdi20/presentation/hwang

Signed-off-by: Jaehyun Hwang <jaehyun.hwang@cornell.edu>
Signed-off-by: Qizhe Cai <qc228@cornell.edu>
Signed-off-by: Midhul Vuppalapati <mvv25@cornell.edu>
Signed-off-by: Rachit Agarwal <ragarwal@cornell.edu>
Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 Documentation/block/i10-iosched.rst |  69 +++++
 block/Kconfig.iosched               |   8 +
 block/Makefile                      |   1 +
 block/i10-iosched.c                 | 421 ++++++++++++++++++++++++++++
 4 files changed, 499 insertions(+)
 create mode 100644 Documentation/block/i10-iosched.rst
 create mode 100644 block/i10-iosched.c

diff --git a/Documentation/block/i10-iosched.rst b/Documentation/block/i10-iosched.rst
new file mode 100644
index 000000000000..3db7ca3ed4c1
--- /dev/null
+++ b/Documentation/block/i10-iosched.rst
@@ -0,0 +1,69 @@
+==========================
+i10 I/O scheduler overview
+==========================
+
+I/O batching is beneficial for optimizing IOPS and throughput for various
+applications. For instance, several kernel block drivers would
+benefit from batching, including mmc [1] and tcp-based storage drivers like
+nvme-tcp [2,3]. While we have support for batching dispatch [4], we need an
+I/O scheduler to efficiently enable batching. Such a scheduler is particularly
+interesting for disaggregated storage, where the access latency of remote
+disaggregated storage may be higher than local storage access; thus, batching
+can significantly help in amortizing the remote access latency while increasing
+the throughput.
+
+This patch introduces the i10 I/O scheduler, which performs batching per hctx in terms
+of #requests, #bytes, and timeouts (at microseconds granularity). i10 starts
+dispatching only when #requests or #bytes is larger than a default threshold or when
+a timer expires. After that, batching dispatch [3] would happen, allowing batching
+at device drivers along with "bd->last" and ".commit_rqs".
+
+The i10 I/O scheduler builds upon recent work on [6]. We have tested the i10 I/O
+scheduler with nvme-tcp optimizaitons [2,3] and batching dispatch [4], varying number
+of cores, varying read/write ratios, and varying request sizes, and with NVMe SSD and
+RAM block device. For NVMe SSDs, the i10 I/O scheduler achieves ~60% improvements in
+terms of IOPS per core over "noop" I/O scheduler. These results are available at [5],
+and many additional results are presented in [6].
+
+While other schedulers may also batch I/O (e.g., mq-deadline), the optimization target
+in the i10 I/O scheduler is throughput maximization. Hence there is no latency target
+nor a need for a global tracking context, so a new scheduler is needed rather than
+to build this functionality to an existing scheduler.
+
+We currently use fixed default values as batching thresholds (e.g., 16 for #requests,
+64KB for #bytes, and 50us for timeout). These default values are based on sensitivity
+tests in [6]. For our future work, we plan to support adaptive batching according to
+system load and to extend the scheduler to support isolation in multi-tenant deployments
+(to simultaneously achieve low tail latency for latency-sensitive applications and high
+throughput for throughput-bound applications).
+
+References
+[1] https://lore.kernel.org/linux-block/cover.1587888520.git.baolin.wang7@gmail.com/T/#mc48a8fb6069843827458f5fea722e1179d32af2a
+[2] https://git.infradead.org/nvme.git/commit/122e5b9f3d370ae11e1502d14ff5c7ea9b144a76
+[3] https://git.infradead.org/nvme.git/commit/86f0348ace1510d7ac25124b096fb88a6ab45270
+[4] https://lore.kernel.org/linux-block/20200630102501.2238972-1-ming.lei@redhat.com/
+[5] https://github.com/i10-kernel/upstream-linux/blob/master/dss-evaluation.pdf
+[6] https://www.usenix.org/conference/nsdi20/presentation/hwang
+
+==========================
+i10 I/O scheduler tunables
+==========================
+
+The three tunables for the i10 scheduler are the number of requests for
+reads/writes, the number of bytes for writes, and a timeout value.
+i10 will use these values for batching requests.
+
+batch_nr
+--------
+Number of requests for batching read/write requests
+Default: 16
+
+batch_bytes
+-----------
+Number of bytes for batching write requests
+Default: 65536 (bytes)
+
+batch_timeout
+-------------
+Timeout value for batching (in microseconds)
+Default: 50 (us)
diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 2f2158e05a91..5b3623b19487 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -44,6 +44,14 @@ config BFQ_CGROUP_DEBUG
 	Enable some debugging help. Currently it exports additional stat
 	files in a cgroup which can be useful for debugging.
 
+config MQ_IOSCHED_I10
+	tristate "i10 I/O scheduler"
+	default y
+	help
+	  The i10 I/O Scheduler supports batching at BLK-MQ.
+	  Any device driver that benefits from batching
+	  (e.g., NVMe-over-TCP) can use this scheduler.
+
 endmenu
 
 endif
diff --git a/block/Makefile b/block/Makefile
index 8d841f5f986f..27e0789589ea 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
 obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= blk-iocost.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
 obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
+obj-$(CONFIG_MQ_IOSCHED_I10)    += i10-iosched.o
 bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
 obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
 
diff --git a/block/i10-iosched.c b/block/i10-iosched.c
new file mode 100644
index 000000000000..b5451beaa66d
--- /dev/null
+++ b/block/i10-iosched.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The i10 I/O Scheduler - supports batching at blk-mq.
+ *	The main use case is disaggregated storage access
+ *	using NVMe-over-Fabric (e.g., NVMe-over-TCP device driver).
+ *
+ * An early version of the idea is described and evaluated in
+ * "TCP ≈ RDMA: CPU-efficient Remote Storage Access with i10",
+ * USENIX NSDI 2020.
+ *
+ * Copyright (C) 2020 Cornell University
+ *	Jaehyun Hwang <jaehyun.hwang@cornell.edu>
+ *	Qizhe Cai <qc228@cornell.edu>
+ *	Midhul Vuppalapati <mvv25@cornell.edu%>
+ *	Rachit Agarwal <ragarwal@cornell.edu>
+ */
+
+#include <linux/kernel.h>
+#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
+#include <linux/elevator.h>
+#include <linux/module.h>
+#include <linux/sbitmap.h>
+
+#include "blk.h"
+#include "blk-mq.h"
+#include "blk-mq-debugfs.h"
+#include "blk-mq-sched.h"
+#include "blk-mq-tag.h"
+
+/* Default batch size in number of requests */
+#define I10_DEF_BATCH_NR	16
+/* Default batch size in bytes (for write requests) */
+#define I10_DEF_BATCH_BYTES	65536
+/* Default timeout value for batching (us units) */
+#define I10_DEF_BATCH_TIMEOUT	50
+
+enum i10_state {
+	/* Batching state:
+	 * Do not run dispatching until we have
+	 * a certain amount of requests or a timer expires.
+	 */
+	I10_STATE_BATCH,
+
+	/* Dispatching state:
+	 * Run dispatching until all requests in the
+	 * scheduler's hctx ihq are dispatched.
+	 */
+	I10_STATE_DISPATCH,
+};
+
+struct i10_queue_data {
+	struct request_queue *q;
+
+	unsigned int	def_batch_nr;
+	unsigned int	def_batch_bytes;
+	unsigned int	def_batch_timeout;
+};
+
+struct i10_hctx_queue {
+	spinlock_t		lock;
+	struct list_head	rq_list;
+
+	struct blk_mq_hw_ctx	*hctx;
+
+	unsigned int	batch_nr;
+	unsigned int	batch_bytes;
+	unsigned int	batch_timeout;
+
+	unsigned int	qlen_nr;
+	unsigned int	qlen_bytes;
+
+	struct hrtimer	dispatch_timer;
+	enum i10_state	state;
+};
+
+static struct i10_queue_data *i10_queue_data_alloc(struct request_queue *q)
+{
+	struct i10_queue_data *iqd;
+
+	iqd = kzalloc_node(sizeof(*iqd), GFP_KERNEL, q->node);
+	if (!iqd)
+		return ERR_PTR(-ENOMEM);
+
+	iqd->q = q;
+	iqd->def_batch_nr = I10_DEF_BATCH_NR;
+	iqd->def_batch_bytes = I10_DEF_BATCH_BYTES;
+	iqd->def_batch_timeout = I10_DEF_BATCH_TIMEOUT;
+
+	return iqd;
+}
+
+static int i10_init_sched(struct request_queue *q, struct elevator_type *e)
+{
+	struct i10_queue_data *iqd;
+	struct elevator_queue *eq;
+
+	eq = elevator_alloc(q, e);
+	if (!eq)
+		return -ENOMEM;
+
+	iqd = i10_queue_data_alloc(q);
+	if (IS_ERR(iqd)) {
+		kobject_put(&eq->kobj);
+		return PTR_ERR(iqd);
+	}
+
+	blk_stat_enable_accounting(q);
+
+	eq->elevator_data = iqd;
+	q->elevator = eq;
+
+	return 0;
+}
+
+static void i10_exit_sched(struct elevator_queue *e)
+{
+	struct i10_queue_data *iqd = e->elevator_data;
+
+	kfree(iqd);
+}
+
+enum hrtimer_restart i10_hctx_timeout_handler(struct hrtimer *timer)
+{
+	struct i10_hctx_queue *ihq =
+		container_of(timer, struct i10_hctx_queue,
+			dispatch_timer);
+
+	ihq->state = I10_STATE_DISPATCH;
+	blk_mq_run_hw_queue(ihq->hctx, true);
+
+	return HRTIMER_NORESTART;
+}
+
+static void i10_hctx_queue_reset(struct i10_hctx_queue *ihq)
+{
+	ihq->qlen_nr = 0;
+	ihq->qlen_bytes = 0;
+	ihq->state = I10_STATE_BATCH;
+}
+
+static int i10_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+{
+	struct i10_hctx_queue *ihq;
+
+	ihq = kzalloc_node(sizeof(*ihq), GFP_KERNEL, hctx->numa_node);
+	if (!ihq)
+		return -ENOMEM;
+
+	spin_lock_init(&ihq->lock);
+	INIT_LIST_HEAD(&ihq->rq_list);
+
+	ihq->hctx = hctx;
+	ihq->batch_nr = 0;
+	ihq->batch_bytes = 0;
+	ihq->batch_timeout = 0;
+
+	hrtimer_init(&ihq->dispatch_timer,
+		CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	ihq->dispatch_timer.function = &i10_hctx_timeout_handler;
+
+	i10_hctx_queue_reset(ihq);
+
+	hctx->sched_data = ihq;
+
+	return 0;
+}
+
+static void i10_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+{
+	struct i10_hctx_queue *ihq = hctx->sched_data;
+
+	hrtimer_cancel(&ihq->dispatch_timer);
+	kfree(hctx->sched_data);
+}
+
+static bool i10_hctx_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio,
+		unsigned int nr_segs)
+{
+	struct i10_hctx_queue *ihq = hctx->sched_data;
+	struct list_head *rq_list = &ihq->rq_list;
+	bool merged;
+
+	spin_lock(&ihq->lock);
+	merged = blk_mq_bio_list_merge(hctx->queue, rq_list, bio, nr_segs);
+	spin_unlock(&ihq->lock);
+
+	if (merged && bio_data_dir(bio) == WRITE)
+		ihq->qlen_bytes += bio->bi_iter.bi_size;
+
+	return merged;
+}
+
+/*
+ * The batch size can be adjusted dynamically on a per-hctx basis.
+ * Use per-hctx variables in that case.
+ */
+static inline unsigned int i10_hctx_batch_nr(struct blk_mq_hw_ctx *hctx)
+{
+	struct i10_queue_data *iqd = hctx->queue->elevator->elevator_data;
+	struct i10_hctx_queue *ihq = hctx->sched_data;
+
+	return ihq->batch_nr ?
+		ihq->batch_nr : iqd->def_batch_nr;
+}
+
+static inline unsigned int i10_hctx_batch_bytes(struct blk_mq_hw_ctx *hctx)
+{
+	struct i10_queue_data *iqd = hctx->queue->elevator->elevator_data;
+	struct i10_hctx_queue *ihq = hctx->sched_data;
+
+	return ihq->batch_bytes ?
+		ihq->batch_bytes : iqd->def_batch_bytes;
+}
+
+static inline unsigned int i10_hctx_batch_timeout(struct blk_mq_hw_ctx *hctx)
+{
+	struct i10_queue_data *iqd = hctx->queue->elevator->elevator_data;
+	struct i10_hctx_queue *ihq = hctx->sched_data;
+
+	return ihq->batch_timeout ?
+		ihq->batch_timeout : iqd->def_batch_timeout;
+}
+
+static void i10_hctx_insert_update(struct i10_hctx_queue *ihq,
+				struct request *rq)
+{
+	if (rq_data_dir(rq) == WRITE)
+		ihq->qlen_bytes += blk_rq_bytes(rq);
+	ihq->qlen_nr++;
+}
+
+static void i10_hctx_insert_requests(struct blk_mq_hw_ctx *hctx,
+				struct list_head *rq_list, bool at_head)
+{
+	struct i10_hctx_queue *ihq = hctx->sched_data;
+	struct request *rq, *next;
+
+	list_for_each_entry_safe(rq, next, rq_list, queuelist) {
+		struct list_head *head = &ihq->rq_list;
+
+		spin_lock(&ihq->lock);
+		if (at_head)
+			list_move(&rq->queuelist, head);
+		else
+			list_move_tail(&rq->queuelist, head);
+		i10_hctx_insert_update(ihq, rq);
+		blk_mq_sched_request_inserted(rq);
+		spin_unlock(&ihq->lock);
+	}
+
+	/* Start a new timer */
+	if (ihq->state == I10_STATE_BATCH &&
+	   !hrtimer_active(&ihq->dispatch_timer))
+		hrtimer_start(&ihq->dispatch_timer,
+			ns_to_ktime(i10_hctx_batch_timeout(hctx)
+				* NSEC_PER_USEC),
+			HRTIMER_MODE_REL);
+}
+
+static struct request *i10_hctx_dispatch_request(struct blk_mq_hw_ctx *hctx)
+{
+	struct i10_hctx_queue *ihq = hctx->sched_data;
+	struct request *rq;
+
+	spin_lock(&ihq->lock);
+	rq = list_first_entry_or_null(&ihq->rq_list,
+				struct request, queuelist);
+	if (rq)
+		list_del_init(&rq->queuelist);
+	else
+		i10_hctx_queue_reset(ihq);
+	spin_unlock(&ihq->lock);
+
+	return rq;
+}
+
+static inline bool i10_hctx_dispatch_now(struct blk_mq_hw_ctx *hctx)
+{
+	struct i10_hctx_queue *ihq = hctx->sched_data;
+
+	return (ihq->qlen_nr >= i10_hctx_batch_nr(hctx)) ||
+		(ihq->qlen_bytes >= i10_hctx_batch_bytes(hctx));
+}
+
+/*
+ * Return true if we are in the dispatching state.
+ */
+static bool i10_hctx_has_work(struct blk_mq_hw_ctx *hctx)
+{
+	struct i10_hctx_queue *ihq = hctx->sched_data;
+
+	if (ihq->state == I10_STATE_BATCH) {
+		if (i10_hctx_dispatch_now(hctx)) {
+			ihq->state = I10_STATE_DISPATCH;
+			if (hrtimer_active(&ihq->dispatch_timer))
+				hrtimer_cancel(&ihq->dispatch_timer);
+		}
+	}
+
+	return (ihq->state == I10_STATE_DISPATCH);
+}
+
+#define I10_DEF_BATCH_SHOW_STORE(name)					\
+static ssize_t i10_def_batch_##name##_show(struct elevator_queue *e,	\
+				char *page)				\
+{									\
+	struct i10_queue_data *iqd = e->elevator_data;			\
+									\
+	return sprintf(page, "%u\n", iqd->def_batch_##name);		\
+}									\
+									\
+static ssize_t i10_def_batch_##name##_store(struct elevator_queue *e,	\
+			const char *page, size_t count)			\
+{									\
+	struct i10_queue_data *iqd = e->elevator_data;			\
+	unsigned long long value;					\
+	int ret;							\
+									\
+	ret = kstrtoull(page, 10, &value);				\
+	if (ret)							\
+		return ret;						\
+									\
+	iqd->def_batch_##name = value;					\
+									\
+	return count;							\
+}
+I10_DEF_BATCH_SHOW_STORE(nr);
+I10_DEF_BATCH_SHOW_STORE(bytes);
+I10_DEF_BATCH_SHOW_STORE(timeout);
+#undef I10_DEF_BATCH_SHOW_STORE
+
+#define I10_SCHED_ATTR(name)	\
+	__ATTR(batch_##name, 0644, i10_def_batch_##name##_show, i10_def_batch_##name##_store)
+static struct elv_fs_entry i10_sched_attrs[] = {
+	I10_SCHED_ATTR(nr),
+	I10_SCHED_ATTR(bytes),
+	I10_SCHED_ATTR(timeout),
+	__ATTR_NULL
+};
+#undef I10_SCHED_ATTR
+
+#ifdef CONFIG_BLK_DEBUG_FS
+#define I10_DEBUGFS_SHOW(name)	\
+static int i10_hctx_batch_##name##_show(void *data, struct seq_file *m)	\
+{									\
+	struct blk_mq_hw_ctx *hctx = data;				\
+	struct i10_hctx_queue *ihq = hctx->sched_data;			\
+									\
+	seq_printf(m, "%u\n", ihq->batch_##name);			\
+	return 0;							\
+}									\
+									\
+static int i10_hctx_qlen_##name##_show(void *data, struct seq_file *m)	\
+{									\
+	struct blk_mq_hw_ctx *hctx = data;				\
+	struct i10_hctx_queue *ihq = hctx->sched_data;			\
+									\
+	seq_printf(m, "%u\n", ihq->qlen_##name);			\
+	return 0;							\
+}
+I10_DEBUGFS_SHOW(nr);
+I10_DEBUGFS_SHOW(bytes);
+#undef I10_DEBUGFS_SHOW
+
+static int i10_hctx_state_show(void *data, struct seq_file *m)
+{
+	struct blk_mq_hw_ctx *hctx = data;
+	struct i10_hctx_queue *ihq = hctx->sched_data;
+
+	seq_printf(m, "%d\n", ihq->state);
+	return 0;
+}
+
+#define I10_HCTX_QUEUE_ATTR(name)					\
+	{"batch_" #name, 0400, i10_hctx_batch_##name##_show},		\
+	{"qlen_" #name, 0400, i10_hctx_qlen_##name##_show}
+static const struct blk_mq_debugfs_attr i10_hctx_debugfs_attrs[] = {
+	I10_HCTX_QUEUE_ATTR(nr),
+	I10_HCTX_QUEUE_ATTR(bytes),
+	{"state", 0400, i10_hctx_state_show},
+	{},
+};
+#undef I10_HCTX_QUEUE_ATTR
+#endif
+
+static struct elevator_type i10_sched = {
+	.ops = {
+		.init_sched = i10_init_sched,
+		.exit_sched = i10_exit_sched,
+		.init_hctx = i10_init_hctx,
+		.exit_hctx = i10_exit_hctx,
+		.bio_merge = i10_hctx_bio_merge,
+		.insert_requests = i10_hctx_insert_requests,
+		.dispatch_request = i10_hctx_dispatch_request,
+		.has_work = i10_hctx_has_work,
+	},
+#ifdef CONFIG_BLK_DEBUG_FS
+	.hctx_debugfs_attrs = i10_hctx_debugfs_attrs,
+#endif
+	.elevator_attrs = i10_sched_attrs,
+	.elevator_name = "i10",
+	.elevator_owner = THIS_MODULE,
+};
+
+static int __init i10_init(void)
+{
+	return elv_register(&i10_sched);
+}
+
+static void __exit i10_exit(void)
+{
+	elv_unregister(&i10_sched);
+}
+
+module_init(i10_init);
+module_exit(i10_exit);
+
+MODULE_AUTHOR("Jaehyun Hwang, Qizhe Cai, Midhul Vuppalapati, Rachit Agarwal");
+MODULE_LICENSE("GPLv2");
+MODULE_DESCRIPTION("i10 I/O scheduler");
-- 
2.22.0

