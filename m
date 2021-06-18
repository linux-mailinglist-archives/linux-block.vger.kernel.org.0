Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588583AC02E
	for <lists+linux-block@lfdr.de>; Fri, 18 Jun 2021 02:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhFRArT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 17 Jun 2021 20:47:19 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:35743 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhFRArS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 20:47:18 -0400
Received: by mail-pl1-f180.google.com with SMTP id x19so3821734pln.2
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 17:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DiwHV2a0AY/6FRuXaKLhtQzSE81rtDtOgOU6LlMxhwY=;
        b=qbdH2IcbRYr0t4DDqEpflTlLetQaWXTE5QUh9PtwJ/8iIn0g4DEoDcpQuWiCLyDQXY
         avpkGLRe3zvznYn3kSDKsK00KgczNzU3T9W1fsunO/SWTjwfDVcJCwGi1qGTFEpBhFzO
         qVeHVmMCC9Ymubx5wU5/CbgzP1mf8+4jDhaczmj4p9+LiUGjFcBvXNGDTNCoyj9bGTkb
         qwynATtnpQNdBjKfLDqyNJ8zjNF/IZm46/TE2dEUbyQstiY4ZvlT44cuvx7HybXqpkG+
         Q7TchzkbyeeEhikkLLi/dWf+UXHwhmHBahhD2BWaqDmsQokNUuL2c9H1l3f4AL+xsZeQ
         xcIg==
X-Gm-Message-State: AOAM531EQHg3B3TFDAJq5XU5KLVxZgfrFflgecCKNvCUposd2UJQVQjd
        andm/Xp32zLV4LUa7/GKvkA=
X-Google-Smtp-Source: ABdhPJzujD+SgAEJDYyX/AvntsAAcYAwBgFeK6kqO8R/YP2q212A8UjnkQt5IECxRx5RpFGJ30RHNw==
X-Received: by 2002:a17:903:182:b029:112:b62f:8852 with SMTP id z2-20020a1709030182b0290112b62f8852mr2361081plg.4.1623977110035;
        Thu, 17 Jun 2021 17:45:10 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b10sm6215573pff.14.2021.06.17.17.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:45:09 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH v3 04/16] block: Introduce the ioprio rq-qos policy
Date:   Thu, 17 Jun 2021 17:44:44 -0700
Message-Id: <20210618004456.7280-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618004456.7280-1-bvanassche@acm.org>
References: <20210618004456.7280-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce an rq-qos policy that assigns an I/O priority to requests based
on blk-cgroup configuration settings. This policy has the following
advantages over the ioprio_set() system call:
- This policy is cgroup based so it has all the advantages of cgroups.
- While ioprio_set() does not affect page cache writeback I/O, this rq-qos
  controller affects page cache writeback I/O for filesystems that support
  assiociating a cgroup with writeback I/O. See also
  Documentation/admin-guide/cgroup-v2.rst.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 Documentation/admin-guide/cgroup-v2.rst |  55 +++++
 block/Kconfig                           |   9 +
 block/Makefile                          |   1 +
 block/blk-cgroup.c                      |   5 +
 block/blk-ioprio.c                      | 262 ++++++++++++++++++++++++
 block/blk-ioprio.h                      |  19 ++
 block/blk-mq-debugfs.c                  |   2 +
 block/blk-rq-qos.h                      |   1 +
 8 files changed, 354 insertions(+)
 create mode 100644 block/blk-ioprio.c
 create mode 100644 block/blk-ioprio.h

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index b1e81aa8598a..4e59925e6583 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -56,6 +56,7 @@ v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgrou
        5-3-3. IO Latency
          5-3-3-1. How IO Latency Throttling Works
          5-3-3-2. IO Latency Interface Files
+       5-3-4. IO Priority
      5-4. PID
        5-4-1. PID Interface Files
      5-5. Cpuset
@@ -1866,6 +1867,60 @@ IO Latency Interface Files
 		duration of time between evaluation events.  Windows only elapse
 		with IO activity.  Idle periods extend the most recent window.
 
+IO Priority
+~~~~~~~~~~~
+
+A single attribute controls the behavior of the I/O priority cgroup policy,
+namely the blkio.prio.class attribute. The following values are accepted for
+that attribute:
+
+  no-change
+	Do not modify the I/O priority class.
+
+  none-to-rt
+	For requests that do not have an I/O priority class (NONE),
+	change the I/O priority class into RT. Do not modify
+	the I/O priority class of other requests.
+
+  restrict-to-be
+	For requests that do not have an I/O priority class or that have I/O
+	priority class RT, change it into BE. Do not modify the I/O priority
+	class of requests that have priority class IDLE.
+
+  idle
+	Change the I/O priority class of all requests into IDLE, the lowest
+	I/O priority class.
+
+The following numerical values are associated with the I/O priority policies:
+
++-------------+---+
+| no-change   | 0 |
++-------------+---+
+| none-to-rt  | 1 |
++-------------+---+
+| rt-to-be    | 2 |
++-------------+---+
+| all-to-idle | 3 |
++-------------+---+
+
+The numerical value that corresponds to each I/O priority class is as follows:
+
++-------------------------------+---+
+| IOPRIO_CLASS_NONE             | 0 |
++-------------------------------+---+
+| IOPRIO_CLASS_RT (real-time)   | 1 |
++-------------------------------+---+
+| IOPRIO_CLASS_BE (best effort) | 2 |
++-------------------------------+---+
+| IOPRIO_CLASS_IDLE             | 3 |
++-------------------------------+---+
+
+The algorithm to set the I/O priority class for a request is as follows:
+
+- Translate the I/O priority class policy into a number.
+- Change the request I/O priority class into the maximum of the I/O priority
+  class policy number and the numerical I/O priority class.
+
 PID
 ---
 
diff --git a/block/Kconfig b/block/Kconfig
index 6685578b2a20..e71c63eaaf52 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -162,6 +162,15 @@ config BLK_CGROUP_IOCOST
 	distributes IO capacity between different groups based on
 	their share of the overall weight distribution.
 
+config BLK_CGROUP_IOPRIO
+	bool "Cgroup I/O controller for assigning an I/O priority class"
+	depends on BLK_CGROUP
+	help
+	Enable the .prio interface for assigning an I/O priority class to
+	requests. The I/O priority class affects the order in which an I/O
+	scheduler and block devices process requests. Only some I/O schedulers
+	and some block devices support I/O priorities.
+
 config BLK_DEBUG_FS
 	bool "Block layer debugging information in debugfs"
 	default y
diff --git a/block/Makefile b/block/Makefile
index 8d841f5f986f..af3d044abaf1 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_BLK_DEV_BSGLIB)	+= bsg-lib.o
 obj-$(CONFIG_BLK_CGROUP)	+= blk-cgroup.o
 obj-$(CONFIG_BLK_CGROUP_RWSTAT)	+= blk-cgroup-rwstat.o
 obj-$(CONFIG_BLK_DEV_THROTTLING)	+= blk-throttle.o
+obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= blk-ioprio.o
 obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
 obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= blk-iocost.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3b0f6efaa2b6..7b06a5fa3cac 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -31,6 +31,7 @@
 #include <linux/tracehook.h>
 #include <linux/psi.h>
 #include "blk.h"
+#include "blk-ioprio.h"
 
 /*
  * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.
@@ -1187,6 +1188,10 @@ int blkcg_init_queue(struct request_queue *q)
 	if (ret)
 		goto err_destroy_all;
 
+	ret = blk_ioprio_init(q);
+	if (ret)
+		goto err_destroy_all;
+
 	ret = blk_throtl_init(q);
 	if (ret)
 		goto err_destroy_all;
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
new file mode 100644
index 000000000000..332a07761bf8
--- /dev/null
+++ b/block/blk-ioprio.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Block rq-qos policy for assigning an I/O priority class to requests.
+ *
+ * Using an rq-qos policy for assigning I/O priority class has two advantages
+ * over using the ioprio_set() system call:
+ *
+ * - This policy is cgroup based so it has all the advantages of cgroups.
+ * - While ioprio_set() does not affect page cache writeback I/O, this rq-qos
+ *   controller affects page cache writeback I/O for filesystems that support
+ *   assiociating a cgroup with writeback I/O. See also
+ *   Documentation/admin-guide/cgroup-v2.rst.
+ */
+
+#include <linux/blk-cgroup.h>
+#include <linux/blk-mq.h>
+#include <linux/blk_types.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include "blk-ioprio.h"
+#include "blk-rq-qos.h"
+
+/**
+ * enum prio_policy - I/O priority class policy.
+ * @POLICY_NO_CHANGE: (default) do not modify the I/O priority class.
+ * @POLICY_NONE_TO_RT: modify IOPRIO_CLASS_NONE into IOPRIO_CLASS_RT.
+ * @POLICY_RESTRICT_TO_BE: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_RT into
+ *		IOPRIO_CLASS_BE.
+ * @POLICY_ALL_TO_IDLE: change the I/O priority class into IOPRIO_CLASS_IDLE.
+ *
+ * See also <linux/ioprio.h>.
+ */
+enum prio_policy {
+	POLICY_NO_CHANGE	= 0,
+	POLICY_NONE_TO_RT	= 1,
+	POLICY_RESTRICT_TO_BE	= 2,
+	POLICY_ALL_TO_IDLE	= 3,
+};
+
+static const char *policy_name[] = {
+	[POLICY_NO_CHANGE]	= "no-change",
+	[POLICY_NONE_TO_RT]	= "none-to-rt",
+	[POLICY_RESTRICT_TO_BE]	= "restrict-to-be",
+	[POLICY_ALL_TO_IDLE]	= "idle",
+};
+
+static struct blkcg_policy ioprio_policy;
+
+/**
+ * struct ioprio_blkg - Per (cgroup, request queue) data.
+ * @pd: blkg_policy_data structure.
+ */
+struct ioprio_blkg {
+	struct blkg_policy_data pd;
+};
+
+/**
+ * struct ioprio_blkcg - Per cgroup data.
+ * @cpd: blkcg_policy_data structure.
+ * @prio_policy: One of the IOPRIO_CLASS_* values. See also <linux/ioprio.h>.
+ */
+struct ioprio_blkcg {
+	struct blkcg_policy_data cpd;
+	enum prio_policy	 prio_policy;
+};
+
+static inline struct ioprio_blkg *pd_to_ioprio(struct blkg_policy_data *pd)
+{
+	return pd ? container_of(pd, struct ioprio_blkg, pd) : NULL;
+}
+
+static struct ioprio_blkcg *blkcg_to_ioprio_blkcg(struct blkcg *blkcg)
+{
+	return container_of(blkcg_to_cpd(blkcg, &ioprio_policy),
+			    struct ioprio_blkcg, cpd);
+}
+
+static struct ioprio_blkcg *
+ioprio_blkcg_from_css(struct cgroup_subsys_state *css)
+{
+	return blkcg_to_ioprio_blkcg(css_to_blkcg(css));
+}
+
+static struct ioprio_blkcg *ioprio_blkcg_from_bio(struct bio *bio)
+{
+	struct blkg_policy_data *pd = blkg_to_pd(bio->bi_blkg, &ioprio_policy);
+
+	if (!pd)
+		return NULL;
+
+	return blkcg_to_ioprio_blkcg(pd->blkg->blkcg);
+}
+
+static int ioprio_show_prio_policy(struct seq_file *sf, void *v)
+{
+	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_css(seq_css(sf));
+
+	seq_printf(sf, "%s\n", policy_name[blkcg->prio_policy]);
+	return 0;
+}
+
+static ssize_t ioprio_set_prio_policy(struct kernfs_open_file *of, char *buf,
+				      size_t nbytes, loff_t off)
+{
+	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_css(of_css(of));
+	int ret;
+
+	if (off != 0)
+		return -EIO;
+	/* kernfs_fop_write_iter() terminates 'buf' with '\0'. */
+	ret = sysfs_match_string(policy_name, buf);
+	if (ret < 0)
+		return ret;
+	blkcg->prio_policy = ret;
+
+	return nbytes;
+}
+
+static struct blkg_policy_data *
+ioprio_alloc_pd(gfp_t gfp, struct request_queue *q, struct blkcg *blkcg)
+{
+	struct ioprio_blkg *ioprio_blkg;
+
+	ioprio_blkg = kzalloc(sizeof(*ioprio_blkg), gfp);
+	if (!ioprio_blkg)
+		return NULL;
+
+	return &ioprio_blkg->pd;
+}
+
+static void ioprio_free_pd(struct blkg_policy_data *pd)
+{
+	struct ioprio_blkg *ioprio_blkg = pd_to_ioprio(pd);
+
+	kfree(ioprio_blkg);
+}
+
+static struct blkcg_policy_data *ioprio_alloc_cpd(gfp_t gfp)
+{
+	struct ioprio_blkcg *blkcg;
+
+	blkcg = kzalloc(sizeof(*blkcg), gfp);
+	if (!blkcg)
+		return NULL;
+	blkcg->prio_policy = POLICY_NO_CHANGE;
+	return &blkcg->cpd;
+}
+
+static void ioprio_free_cpd(struct blkcg_policy_data *cpd)
+{
+	struct ioprio_blkcg *blkcg = container_of(cpd, typeof(*blkcg), cpd);
+
+	kfree(blkcg);
+}
+
+#define IOPRIO_ATTRS						\
+	{							\
+		.name		= "prio.class",			\
+		.seq_show	= ioprio_show_prio_policy,	\
+		.write		= ioprio_set_prio_policy,	\
+	},							\
+	{ } /* sentinel */
+
+/* cgroup v2 attributes */
+static struct cftype ioprio_files[] = {
+	IOPRIO_ATTRS
+};
+
+/* cgroup v1 attributes */
+static struct cftype ioprio_legacy_files[] = {
+	IOPRIO_ATTRS
+};
+
+static struct blkcg_policy ioprio_policy = {
+	.dfl_cftypes	= ioprio_files,
+	.legacy_cftypes = ioprio_legacy_files,
+
+	.cpd_alloc_fn	= ioprio_alloc_cpd,
+	.cpd_free_fn	= ioprio_free_cpd,
+
+	.pd_alloc_fn	= ioprio_alloc_pd,
+	.pd_free_fn	= ioprio_free_pd,
+};
+
+struct blk_ioprio {
+	struct rq_qos rqos;
+};
+
+static void blkcg_ioprio_track(struct rq_qos *rqos, struct request *rq,
+			       struct bio *bio)
+{
+	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_bio(bio);
+
+	/*
+	 * Except for IOPRIO_CLASS_NONE, higher I/O priority numbers
+	 * correspond to a lower priority. Hence, the max_t() below selects
+	 * the lower priority of bi_ioprio and the cgroup I/O priority class.
+	 * If the cgroup policy has been set to POLICY_NO_CHANGE == 0, the
+	 * bio I/O priority is not modified. If the bio I/O priority equals
+	 * IOPRIO_CLASS_NONE, the cgroup I/O priority is assigned to the bio.
+	 */
+	bio->bi_ioprio = max_t(u16, bio->bi_ioprio,
+			       IOPRIO_PRIO_VALUE(blkcg->prio_policy, 0));
+}
+
+static void blkcg_ioprio_exit(struct rq_qos *rqos)
+{
+	struct blk_ioprio *blkioprio_blkg =
+		container_of(rqos, typeof(*blkioprio_blkg), rqos);
+
+	blkcg_deactivate_policy(rqos->q, &ioprio_policy);
+	kfree(blkioprio_blkg);
+}
+
+static struct rq_qos_ops blkcg_ioprio_ops = {
+	.track	= blkcg_ioprio_track,
+	.exit	= blkcg_ioprio_exit,
+};
+
+int blk_ioprio_init(struct request_queue *q)
+{
+	struct blk_ioprio *blkioprio_blkg;
+	struct rq_qos *rqos;
+	int ret;
+
+	blkioprio_blkg = kzalloc(sizeof(*blkioprio_blkg), GFP_KERNEL);
+	if (!blkioprio_blkg)
+		return -ENOMEM;
+
+	ret = blkcg_activate_policy(q, &ioprio_policy);
+	if (ret) {
+		kfree(blkioprio_blkg);
+		return ret;
+	}
+
+	rqos = &blkioprio_blkg->rqos;
+	rqos->id = RQ_QOS_IOPRIO;
+	rqos->ops = &blkcg_ioprio_ops;
+	rqos->q = q;
+
+	/*
+	 * Registering the rq-qos policy after activating the blk-cgroup
+	 * policy guarantees that ioprio_blkcg_from_bio(bio) != NULL in the
+	 * rq-qos callbacks.
+	 */
+	rq_qos_add(q, rqos);
+
+	return 0;
+}
+
+static int __init ioprio_init(void)
+{
+	return blkcg_policy_register(&ioprio_policy);
+}
+
+static void __exit ioprio_exit(void)
+{
+	blkcg_policy_unregister(&ioprio_policy);
+}
+
+module_init(ioprio_init);
+module_exit(ioprio_exit);
diff --git a/block/blk-ioprio.h b/block/blk-ioprio.h
new file mode 100644
index 000000000000..a7785c2f1aea
--- /dev/null
+++ b/block/blk-ioprio.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _BLK_IOPRIO_H_
+#define _BLK_IOPRIO_H_
+
+#include <linux/kconfig.h>
+
+struct request_queue;
+
+#ifdef CONFIG_BLK_CGROUP_IOPRIO
+int blk_ioprio_init(struct request_queue *q);
+#else
+static inline int blk_ioprio_init(struct request_queue *q)
+{
+	return 0;
+}
+#endif
+
+#endif /* _BLK_IOPRIO_H_ */
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6ac1c86f62ef..4b66d2776eda 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -946,6 +946,8 @@ static const char *rq_qos_id_to_name(enum rq_qos_id id)
 		return "latency";
 	case RQ_QOS_COST:
 		return "cost";
+	case RQ_QOS_IOPRIO:
+		return "ioprio";
 	}
 	return "unknown";
 }
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index a77afbdd472c..f000f83e0621 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -17,6 +17,7 @@ enum rq_qos_id {
 	RQ_QOS_WBT,
 	RQ_QOS_LATENCY,
 	RQ_QOS_COST,
+	RQ_QOS_IOPRIO,
 };
 
 struct rq_wait {
