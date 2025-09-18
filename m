Return-Path: <linux-block+bounces-26542-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84D6B3DFA8
	for <lists+linux-block@lfdr.de>; Mon,  1 Sep 2025 12:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FE03B55FB
	for <lists+linux-block@lfdr.de>; Mon,  1 Sep 2025 10:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D70130FF06;
	Mon,  1 Sep 2025 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvCZ+GAR"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0C3101A3
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721068; cv=none; b=VGhDaJE2W+WdK8mEwLIigy1mpDckgihnTf90NQlCqWHkN70uuUt4W+pq+orYHq4T7wrNmm8a5mRPTuOBRVePNtySokZaibC0GOD8u/KqNpsjMxShXHYMi3OQ0OUBwd9ruRRroo4e57cddSrkLmoeWaWP8ZfZVg7hNNHF1bIvIPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721068; c=relaxed/simple;
	bh=NjM8cjGmqwxEm4AL7wQ7QDR4iI4C7owGRMv67mSF5n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fb+Pwc5hXR7LMlxpPx3E3uzeL7J0+laPmsF2VSdhprL4vFB7dPsouWoO2VRX/ngs5q9VaN5Dnz5wBKynEV6kj+IwZlEeaBON078gexvsG+zIUsMHLAq1dzrokxhwA3U41ILB8NxHubjL0deoJdb88uODbTlVDsaUMMr8BzTk24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvCZ+GAR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756721066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngpsZ8CfEPffR1bfNancB2tTn2JmJuCDwdo+jQQ89D4=;
	b=OvCZ+GARycLuz/pxCE8WvqUbcKMpHJajrmPdzNC/duFTiEBoElCuj8stL04Yb9dvSz7MmM
	GJOJ8hx87tI72/eCSxWK4T8qS2X5pZWZhNy6clTffPy5rv+uOS7QMuUbDdHgb/RSMrqlYR
	+pFgnNruJmD7YpFtaUI2aFlIyAO2DkA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-wlh-i6GgMba8ZQCNzXhPpQ-1; Mon,
 01 Sep 2025 06:04:20 -0400
X-MC-Unique: wlh-i6GgMba8ZQCNzXhPpQ-1
X-Mimecast-MFC-AGG-ID: wlh-i6GgMba8ZQCNzXhPpQ_1756721059
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C887195E908;
	Mon,  1 Sep 2025 10:04:19 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7EC00180047F;
	Mon,  1 Sep 2025 10:04:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 22/23] selftests: ublk: add --batch/-b for enabling F_BATCH_IO
Date: Mon,  1 Sep 2025 18:02:39 +0800
Message-ID: <20250901100242.3231000-23-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-1-ming.lei@redhat.com>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add --batch/-b for enabling F_BATCH_IO.

Add generic_13 for covering its basic function.

Add stress_06 and stress_07 for covering stress test.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  3 ++
 tools/testing/selftests/ublk/kublk.c          | 13 +++++-
 .../testing/selftests/ublk/test_generic_13.sh | 32 +++++++++++++
 .../testing/selftests/ublk/test_stress_06.sh  | 45 +++++++++++++++++++
 .../testing/selftests/ublk/test_stress_07.sh  | 44 ++++++++++++++++++
 5 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_13.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_06.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_07.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 19793678f24c..7141995f1f14 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -20,6 +20,7 @@ TEST_PROGS += test_generic_09.sh
 TEST_PROGS += test_generic_10.sh
 TEST_PROGS += test_generic_11.sh
 TEST_PROGS += test_generic_12.sh
+TEST_PROGS += test_generic_13.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
@@ -38,6 +39,8 @@ TEST_PROGS += test_stress_02.sh
 TEST_PROGS += test_stress_03.sh
 TEST_PROGS += test_stress_04.sh
 TEST_PROGS += test_stress_05.sh
+TEST_PROGS += test_stress_06.sh
+TEST_PROGS += test_stress_07.sh
 
 TEST_GEN_PROGS_EXTENDED = kublk
 
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index ceb2e80304a6..4b7e9c1c09f4 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1439,6 +1439,7 @@ static int cmd_dev_get_features(void)
 		[const_ilog2(UBLK_F_AUTO_BUF_REG)] = "AUTO_BUF_REG",
 		[const_ilog2(UBLK_F_QUIESCE)] = "QUIESCE",
 		[const_ilog2(UBLK_F_PER_IO_DAEMON)] = "PER_IO_DAEMON",
+		[const_ilog2(UBLK_F_BATCH_IO)] = "BATCH_IO",
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -1534,6 +1535,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 	printf("\t[--foreground] [--quiet] [-z] [--auto_zc] [--auto_zc_fallback] [--debug_mask mask] [-r 0|1 ] [-g]\n");
 	printf("\t[-e 0|1 ] [-i 0|1]\n");
 	printf("\t[--nthreads threads] [--per_io_tasks]\n");
+	printf("\t[--batch|-b]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
 	printf("\tdefault: nthreads=nr_queues");
@@ -1595,6 +1597,7 @@ int main(int argc, char *argv[])
 		{ "size",		1,	NULL, 's'},
 		{ "nthreads",		1,	NULL,  0 },
 		{ "per_io_tasks",	0,	NULL,  0 },
+		{ "batch",              0,      NULL, 'b'},
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1616,9 +1619,12 @@ int main(int argc, char *argv[])
 
 	opterr = 0;
 	optind = 2;
-	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:s:gaz",
+	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:s:gazb",
 				  longopts, &option_idx)) != -1) {
 		switch (opt) {
+		case 'b':
+			ctx.flags |= UBLK_F_BATCH_IO;
+			break;
 		case 'a':
 			ctx.all = 1;
 			break;
@@ -1697,6 +1703,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (ctx.per_io_tasks && (ctx.flags & UBLK_F_BATCH_IO)) {
+		ublk_err("per_io_task and F_BATCH_IO conflict\n");
+		return -EINVAL;
+	}
+
 	/* auto_zc_fallback depends on F_AUTO_BUF_REG & F_SUPPORT_ZERO_COPY */
 	if (ctx.auto_zc_fallback &&
 	    !((ctx.flags & UBLK_F_AUTO_BUF_REG) &&
diff --git a/tools/testing/selftests/ublk/test_generic_13.sh b/tools/testing/selftests/ublk/test_generic_13.sh
new file mode 100755
index 000000000000..ac457b45f439
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_13.sh
@@ -0,0 +1,32 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_13"
+ERR_CODE=0
+
+if ! _have_feature "BATCH_IO"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "generic" "test basic function of UBLK_F_BATCH_IO"
+
+_create_backfile 0 256M
+_create_backfile 1 256M
+
+dev_id=$(_add_ublk_dev -t loop -q 2 -b "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
+
+if ! _mkfs_mount_test /dev/ublkb"${dev_id}"; then
+	_cleanup_test "generic"
+	_show_result $TID 255
+fi
+
+dev_id=$(_add_ublk_dev -t stripe -b --auto_zc "${UBLK_BACKFILES[0]}" "${UBLK_BACKFILES[1]}")
+_check_add_dev $TID $?
+_mkfs_mount_test /dev/ublkb"${dev_id}"
+ERR_CODE=$?
+
+_cleanup_test "generic"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_06.sh b/tools/testing/selftests/ublk/test_stress_06.sh
new file mode 100755
index 000000000000..190db0b4f2ad
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stress_06.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+TID="stress_06"
+ERR_CODE=0
+
+ublk_io_and_remove()
+{
+	run_io_and_remove "$@"
+	ERR_CODE=$?
+	if [ ${ERR_CODE} -ne 0 ]; then
+		echo "$TID failure: $*"
+		_show_result $TID $ERR_CODE
+	fi
+}
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+if ! _have_feature "ZERO_COPY"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+if ! _have_feature "AUTO_BUF_REG"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+if ! _have_feature "BATCH_IO"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "stress" "run IO and remove device(zero copy)"
+
+_create_backfile 0 256M
+_create_backfile 1 128M
+_create_backfile 2 128M
+
+ublk_io_and_remove 8G -t null -q 4 -b &
+ublk_io_and_remove 256M -t loop -q 4 --auto_zc -b "${UBLK_BACKFILES[0]}" &
+ublk_io_and_remove 256M -t stripe -q 4 --auto_zc -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback -b &
+wait
+
+_cleanup_test "stress"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_07.sh b/tools/testing/selftests/ublk/test_stress_07.sh
new file mode 100755
index 000000000000..1b6bdb31da03
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stress_07.sh
@@ -0,0 +1,44 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+TID="stress_07"
+ERR_CODE=0
+
+ublk_io_and_kill_daemon()
+{
+	run_io_and_kill_daemon "$@"
+	ERR_CODE=$?
+	if [ ${ERR_CODE} -ne 0 ]; then
+		echo "$TID failure: $*"
+		_show_result $TID $ERR_CODE
+	fi
+}
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+if ! _have_feature "ZERO_COPY"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+if ! _have_feature "AUTO_BUF_REG"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+if ! _have_feature "BATCH_IO"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "stress" "run IO and kill ublk server(zero copy)"
+
+_create_backfile 0 256M
+_create_backfile 1 128M
+_create_backfile 2 128M
+
+ublk_io_and_kill_daemon 8G -t null -q 4 -z -b &
+ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc -b "${UBLK_BACKFILES[0]}" &
+ublk_io_and_kill_daemon 256M -t stripe -q 4 -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback -b &
+wait
+
+_cleanup_test "stress"
+_show_result $TID $ERR_CODE
-- 
2.47.0


