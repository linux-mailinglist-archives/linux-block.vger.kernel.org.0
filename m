Return-Path: <linux-block+bounces-19763-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E34AA8AEC0
	for <lists+linux-block@lfdr.de>; Wed, 16 Apr 2025 05:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4AD5A05EA
	for <lists+linux-block@lfdr.de>; Wed, 16 Apr 2025 03:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A897D229B1A;
	Wed, 16 Apr 2025 03:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BP0gIHDU"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262C229B13
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 03:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775734; cv=none; b=IgeNcZwig3m8EicbKsZK7e5U3fZpNYnP8szT/M6wSEXjnCxWoaAaXhIw/mSnMsOQ5CBM42Vamk1MEkwRAT0pOYTSy1nUBLDibCOOPbP0o2QJRItP++XKS7nMAM+C/+rJ1SnQkNUeEYPfIzcpJF7SgGBpF2/NsLhLhA6ZEvBz3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775734; c=relaxed/simple;
	bh=gJG5ffb68ImItF2g0OFIbTWQWZan80qpWta48FOyU88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYDzc7HdPnFTCx6hLPxlSBNOF47DVTZSgxy/evEGSpDKyREpU2EceJHqSRb/SUN6z49JMTpfXkDMexFTuNh3BD3j42KuDjUO3eZNVC9BhP6YEh4UU4aY0xHgNNVwH0dCfl4k8rqCNLZOAoBZ0ZO1I7JeMiC3hFXwUu4TRKYI3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BP0gIHDU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744775731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ORU4/tYb65HnRv92j5jGSn6duR/PrwEKaPPGM5xt5TY=;
	b=BP0gIHDUE/z+Pt/rg/wUPl8+C8j0nq4rlPaWOiIHFO9PhiZQzMlAJOL5f1YGud7V1Edot4
	4kHtfXT7G1DYhGzVGXLdjk+Y5U2eZe56B1k37ebE12FXy7EUXxEp3erkXKmeIovQWHBDB2
	pGxxvv/VH9jzHOdWTzsD97QI5TKrgw0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-UMSsVNzLMOSAQTqp_vNn3w-1; Tue,
 15 Apr 2025 23:55:27 -0400
X-MC-Unique: UMSsVNzLMOSAQTqp_vNn3w-1
X-Mimecast-MFC-AGG-ID: UMSsVNzLMOSAQTqp_vNn3w_1744775726
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A25DE1956089;
	Wed, 16 Apr 2025 03:55:26 +0000 (UTC)
Received: from localhost (unknown [10.72.116.72])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8BCA81828AAD;
	Wed, 16 Apr 2025 03:55:25 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 8/8] selftests: ublk: add generic_06 for covering fault inject
Date: Wed, 16 Apr 2025 11:54:42 +0800
Message-ID: <20250416035444.99569-9-ming.lei@redhat.com>
In-Reply-To: <20250416035444.99569-1-ming.lei@redhat.com>
References: <20250416035444.99569-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Uday Shankar <ushankar@purestorage.com>

Add one simple fault inject target, and verify if an application using ublk
device sees an I/O error quickly after the ublk server dies.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  4 +-
 tools/testing/selftests/ublk/fault_inject.c   | 98 +++++++++++++++++++
 tools/testing/selftests/ublk/kublk.c          |  3 +-
 tools/testing/selftests/ublk/kublk.h          | 12 ++-
 .../testing/selftests/ublk/test_generic_06.sh | 41 ++++++++
 5 files changed, 155 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/fault_inject.c
 create mode 100755 tools/testing/selftests/ublk/test_generic_06.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index dddc64036aa1..ec4624a283bc 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -8,6 +8,7 @@ TEST_PROGS += test_generic_02.sh
 TEST_PROGS += test_generic_03.sh
 TEST_PROGS += test_generic_04.sh
 TEST_PROGS += test_generic_05.sh
+TEST_PROGS += test_generic_06.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
@@ -31,7 +32,8 @@ TEST_GEN_PROGS_EXTENDED = kublk
 
 include ../lib.mk
 
-$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe.c
+$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe.c \
+	fault_inject.c
 
 check:
 	shellcheck -x -f gcc *.sh
diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
new file mode 100644
index 000000000000..94a8e729ba4c
--- /dev/null
+++ b/tools/testing/selftests/ublk/fault_inject.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Fault injection ublk target. Hack this up however you like for
+ * testing specific behaviors of ublk_drv. Currently is a null target
+ * with a configurable delay before completing each I/O. This delay can
+ * be used to test ublk_drv's handling of I/O outstanding to the ublk
+ * server when it dies.
+ */
+
+#include "kublk.h"
+
+static int ublk_fault_inject_tgt_init(const struct dev_ctx *ctx,
+				      struct ublk_dev *dev)
+{
+	const struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
+	unsigned long dev_size = 250UL << 30;
+
+	dev->tgt.dev_size = dev_size;
+	dev->tgt.params = (struct ublk_params) {
+		.types = UBLK_PARAM_TYPE_BASIC,
+		.basic = {
+			.logical_bs_shift	= 9,
+			.physical_bs_shift	= 12,
+			.io_opt_shift		= 12,
+			.io_min_shift		= 9,
+			.max_sectors		= info->max_io_buf_bytes >> 9,
+			.dev_sectors		= dev_size >> 9,
+		},
+	};
+
+	dev->private_data = (void *)(unsigned long)(ctx->fault_inject.delay_us * 1000);
+	return 0;
+}
+
+static int ublk_fault_inject_queue_io(struct ublk_queue *q, int tag)
+{
+	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+	struct io_uring_sqe *sqe;
+	struct __kernel_timespec ts = {
+		.tv_nsec = (long long)q->dev->private_data,
+	};
+
+	ublk_queue_alloc_sqes(q, &sqe, 1);
+	io_uring_prep_timeout(sqe, &ts, 1, 0);
+	sqe->user_data = build_user_data(tag, ublksrv_get_op(iod), 0, 1);
+
+	ublk_queued_tgt_io(q, tag, 1);
+
+	return 0;
+}
+
+static void ublk_fault_inject_tgt_io_done(struct ublk_queue *q, int tag,
+					  const struct io_uring_cqe *cqe)
+{
+	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+
+	if (cqe->res != -ETIME)
+		ublk_err("%s: unexpected cqe res %d\n", __func__, cqe->res);
+
+	if (ublk_completed_tgt_io(q, tag))
+		ublk_complete_io(q, tag, iod->nr_sectors << 9);
+	else
+		ublk_err("%s: io not complete after 1 cqe\n", __func__);
+}
+
+static void ublk_fault_inject_cmd_line(struct dev_ctx *ctx, int argc, char *argv[])
+{
+	static const struct option longopts[] = {
+		{ "delay_us", 	1,	NULL,  0  },
+		{ 0, 0, 0, 0 }
+	};
+	int option_idx, opt;
+
+	ctx->fault_inject.delay_us = 0;
+	while ((opt = getopt_long(argc, argv, "",
+				  longopts, &option_idx)) != -1) {
+		switch (opt) {
+		case 0:
+			if (!strcmp(longopts[option_idx].name, "delay_us"))
+				ctx->fault_inject.delay_us = strtoll(optarg, NULL, 10);
+		}
+	}
+}
+
+static void ublk_fault_inject_usage(const struct ublk_tgt_ops *ops)
+{
+	printf("\tfault_inject: [--delay_us us (default 0)]\n");
+}
+
+const struct ublk_tgt_ops fault_inject_tgt_ops = {
+	.name = "fault_inject",
+	.init_tgt = ublk_fault_inject_tgt_init,
+	.queue_io = ublk_fault_inject_queue_io,
+	.tgt_io_done = ublk_fault_inject_tgt_io_done,
+	.parse_cmd_line = ublk_fault_inject_cmd_line,
+	.usage = ublk_fault_inject_usage,
+};
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 0cd6dce3f303..759f06637146 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -12,6 +12,7 @@ static const struct ublk_tgt_ops *tgt_ops_list[] = {
 	&null_tgt_ops,
 	&loop_tgt_ops,
 	&stripe_tgt_ops,
+	&fault_inject_tgt_ops,
 };
 
 static const struct ublk_tgt_ops *ublk_find_tgt(const char *name)
@@ -1234,7 +1235,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 {
 	int i;
 
-	printf("%s %s -t [null|loop|stripe] [-q nr_queues] [-d depth] [-n dev_id]\n",
+	printf("%s %s -t [null|loop|stripe|fault_inject] [-q nr_queues] [-d depth] [-n dev_id]\n",
 			exe, recovery ? "recover" : "add");
 	printf("\t[--foreground] [--quiet] [-z] [--debug_mask mask] [-r 0|1 ] [-g 0|1]\n");
 	printf("\t[-e 0|1 ] [-i 0|1]\n");
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 3d2b9f14491c..29571eb296f1 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -68,6 +68,11 @@ struct stripe_ctx {
 	unsigned int    chunk_size;
 };
 
+struct fault_inject_ctx {
+	/* fault_inject */
+	unsigned long   delay_us;
+};
+
 struct dev_ctx {
 	char tgt_type[16];
 	unsigned long flags;
@@ -81,6 +86,9 @@ struct dev_ctx {
 	unsigned int	fg:1;
 	unsigned int	recovery:1;
 
+	/* fault_inject */
+	long long	delay_us;
+
 	int _evtfd;
 	int _shmid;
 
@@ -88,7 +96,8 @@ struct dev_ctx {
 	struct ublk_dev *shadow_dev;
 
 	union {
-		struct stripe_ctx  stripe;
+		struct stripe_ctx 	stripe;
+		struct fault_inject_ctx fault_inject;
 	};
 };
 
@@ -384,6 +393,7 @@ static inline int ublk_queue_use_zc(const struct ublk_queue *q)
 extern const struct ublk_tgt_ops null_tgt_ops;
 extern const struct ublk_tgt_ops loop_tgt_ops;
 extern const struct ublk_tgt_ops stripe_tgt_ops;
+extern const struct ublk_tgt_ops fault_inject_tgt_ops;
 
 void backing_file_tgt_deinit(struct ublk_dev *dev);
 int backing_file_tgt_init(struct ublk_dev *dev);
diff --git a/tools/testing/selftests/ublk/test_generic_06.sh b/tools/testing/selftests/ublk/test_generic_06.sh
new file mode 100755
index 000000000000..b67230c42c84
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_06.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_06"
+ERR_CODE=0
+
+_prep_test "fault_inject" "fast cleanup when all I/Os of one hctx are in server"
+
+# configure ublk server to sleep 2s before completing each I/O
+dev_id=$(_add_ublk_dev -t fault_inject -q 2 -d 1 --delay_us 2000000)
+_check_add_dev $TID $?
+
+STARTTIME=${SECONDS}
+
+dd if=/dev/urandom of=/dev/ublkb${dev_id} oflag=direct bs=4k count=1 status=none > /dev/null 2>&1 &
+dd_pid=$!
+
+__ublk_kill_daemon ${dev_id} "DEAD"
+
+wait $dd_pid
+dd_exitcode=$?
+
+ENDTIME=${SECONDS}
+ELAPSED=$(($ENDTIME - $STARTTIME))
+
+# assert that dd sees an error and exits quickly after ublk server is
+# killed. previously this relied on seeing an I/O timeout and so would
+# take ~30s
+if [ $dd_exitcode -eq 0 ]; then
+        echo "dd unexpectedly exited successfully!"
+        ERR_CODE=255
+fi
+if [ $ELAPSED -ge 5 ]; then
+        echo "dd took $ELAPSED seconds to exit (>= 5s tolerance)!"
+        ERR_CODE=255
+fi
+
+_cleanup_test "fault_inject"
+_show_result $TID $ERR_CODE
-- 
2.47.0


