Return-Path: <linux-block+bounces-19241-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB8CA7DED1
	for <lists+linux-block@lfdr.de>; Mon,  7 Apr 2025 15:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8984E3AC3C6
	for <lists+linux-block@lfdr.de>; Mon,  7 Apr 2025 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C80024BCF9;
	Mon,  7 Apr 2025 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGMCFkMn"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4962459EA
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031776; cv=none; b=N3BiL8nkwBJvsXw8q2sY0n+58k9lFkwA2tj6nlwS4jXKiv01CX24foO2HpeHtYrSP2ETjBGdnkUD+okO1DWgiHXKpmFClnp4JsYajFOkhEeDGL9jRkd3UAbEhVrBBJdqhBhvokyih7v67U3aWw9KM2bc2apKJ/F2MF/HJm0dBsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031776; c=relaxed/simple;
	bh=DcEdmoV39YzuFWN3OQMpRoAb0U4B/RUWTtABEmzh3gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLF8wUaA/H6v7ZFeNUZDVd7Fu6JPH8n3ZxNG0xN6+Ht5LBIfprJBA1CAQ+2xlCqRltP1dmg2Pozry5mBB+xm3SBVQarH5ysH/kdvoeKcY0ryuXNsJcMYRibpMLcFQgjrh+QEKycx1gTyaHGrQmdYsESKDxCvL06GDVu8RDY1Po8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGMCFkMn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744031773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PeMGoRN+UxnP+3uSSnDJxhJBpstQ7gg7qXYPMs6Ozk=;
	b=AGMCFkMnsdTArLCts6yr8nEn7BHqV6ofLbKN3R44n4tMkiNqf4MeaFOH4t8KAZtgC1mq2+
	VYMWTp+noXv9KZbq2KQI8NxXlvhqK4pAFX2f+9hZQgFicCmCnr+dTVSPTOOFrarxKGp9fK
	+4xCTVSntdbokDEqh/W6kZfG5od0hCY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-Qk0J98UnNkqfOsg3W7USwQ-1; Mon,
 07 Apr 2025 09:16:12 -0400
X-MC-Unique: Qk0J98UnNkqfOsg3W7USwQ-1
X-Mimecast-MFC-AGG-ID: Qk0J98UnNkqfOsg3W7USwQ_1744031771
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EF7D195609E;
	Mon,  7 Apr 2025 13:16:11 +0000 (UTC)
Received: from localhost (unknown [10.72.120.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C641192C7C3;
	Mon,  7 Apr 2025 13:16:09 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 05/13] selftests: ublk: make sure _add_ublk_dev can return in sub-shell
Date: Mon,  7 Apr 2025 21:15:16 +0800
Message-ID: <20250407131526.1927073-6-ming.lei@redhat.com>
In-Reply-To: <20250407131526.1927073-1-ming.lei@redhat.com>
References: <20250407131526.1927073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Detach ublk daemon from the starting process completely by double-fork and
clearing its process group, so that _add_ublk_dev can return from
sub-shell.

Prepare for running ublk test in parallel.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c          | 29 +++++++++++++++----
 tools/testing/selftests/ublk/test_common.sh   | 15 +++++-----
 .../testing/selftests/ublk/test_stress_01.sh  |  8 ++---
 .../testing/selftests/ublk/test_stress_02.sh  |  8 ++---
 4 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 5c03c776426f..f01d8618739b 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -654,6 +654,8 @@ static int ublk_send_dev_event(const struct dev_ctx *ctx, int dev_id)
 	if (write(evtfd, &id, sizeof(id)) != sizeof(id))
 		return -EINVAL;
 
+	close(evtfd);
+
 	return 0;
 }
 
@@ -889,22 +891,39 @@ static int cmd_dev_add(struct dev_ctx *ctx)
 		exit(-1);
 	}
 
-	setsid();
 	res = fork();
 	if (res == 0) {
+		int res2;
+
+		setsid();
+		res2 = fork();
+
+		if (res2 == 0) {
+			/* prepare for detaching */
+			close(STDIN_FILENO);
+			close(STDOUT_FILENO);
+			close(STDERR_FILENO);
 run:
-		res = __cmd_dev_add(ctx);
-		return res;
+			res = __cmd_dev_add(ctx);
+			return res;
+		} else {
+			/* detached from the parent */
+			exit(EXIT_SUCCESS);
+		}
 	} else if (res > 0) {
 		uint64_t id;
+		int exit_code = EXIT_FAILURE;
 
 		res = read(ctx->_evtfd, &id, sizeof(id));
 		close(ctx->_evtfd);
 		if (res == sizeof(id) && id != ERROR_EVTFD_DEVID) {
 			ctx->dev_id = id - 1;
-			return __cmd_dev_list(ctx);
+			if (__cmd_dev_list(ctx) >= 0)
+				exit_code = EXIT_SUCCESS;
 		}
-		exit(EXIT_FAILURE);
+		/* wait for child */
+		wait(NULL);
+		exit(exit_code);
 	} else {
 		return res;
 	}
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index c7d04da7235a..c43bd1d5c9c0 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -170,7 +170,6 @@ _have_feature()
 }
 
 _add_ublk_dev() {
-	local kublk_temp;
 	local dev_id;
 
 	if [ ! -c /dev/ublk-control ]; then
@@ -182,17 +181,17 @@ _add_ublk_dev() {
 		fi
 	fi
 
-	kublk_temp=$(mktemp /tmp/kublk-XXXXXX)
-	if ! "${UBLK_PROG}" add "$@" > "${kublk_temp}" 2>&1; then
+	if ! dev_id=$("${UBLK_PROG}" add "$@" | grep "dev id" | awk -F '[ :]' '{print $3}'); then
 		echo "fail to add ublk dev $*"
-		rm -f "${kublk_temp}"
 		return 255
 	fi
-
-	dev_id=$(grep "dev id" "${kublk_temp}" | awk -F '[ :]' '{print $3}')
 	udevadm settle
-	rm -f "${kublk_temp}"
-	echo "${dev_id}"
+
+	if [[ "$dev_id" =~ ^[0-9]+$ ]]; then
+		echo "${dev_id}"
+	else
+		return 255
+	fi
 }
 
 # kill the ublk daemon and return ublk device state
diff --git a/tools/testing/selftests/ublk/test_stress_01.sh b/tools/testing/selftests/ublk/test_stress_01.sh
index 4c37a2cf13a3..61fdbdfe70bc 100755
--- a/tools/testing/selftests/ublk/test_stress_01.sh
+++ b/tools/testing/selftests/ublk/test_stress_01.sh
@@ -4,19 +4,19 @@
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 TID="stress_01"
 ERR_CODE=0
-DEV_ID=-1
 
 ublk_io_and_remove()
 {
 	local size=$1
+	local dev_id
 	shift 1
 
-	DEV_ID=$(_add_ublk_dev "$@")
+	dev_id=$(_add_ublk_dev "$@")
 	_check_add_dev $TID $?
 
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "run ublk IO vs. remove device(ublk add $*)"
-	if ! __run_io_and_remove "${DEV_ID}" "${size}" "no"; then
-		echo "/dev/ublkc${DEV_ID} isn't removed"
+	if ! __run_io_and_remove "$dev_id" "${size}" "no"; then
+		echo "/dev/ublkc$dev_id isn't removed"
 		exit 255
 	fi
 }
diff --git a/tools/testing/selftests/ublk/test_stress_02.sh b/tools/testing/selftests/ublk/test_stress_02.sh
index 4b6ad441d500..7643e58637c8 100755
--- a/tools/testing/selftests/ublk/test_stress_02.sh
+++ b/tools/testing/selftests/ublk/test_stress_02.sh
@@ -4,19 +4,19 @@
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 TID="stress_02"
 ERR_CODE=0
-DEV_ID=-1
 
 ublk_io_and_kill_daemon()
 {
 	local size=$1
+	local dev_id
 	shift 1
 
-	DEV_ID=$(_add_ublk_dev "$@")
+	dev_id=$(_add_ublk_dev "$@")
 	_check_add_dev $TID $?
 
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "run ublk IO vs kill ublk server(ublk add $*)"
-	if ! __run_io_and_remove "${DEV_ID}" "${size}" "yes"; then
-		echo "/dev/ublkc${DEV_ID} isn't removed res ${res}"
+	if ! __run_io_and_remove "$dev_id" "${size}" "yes"; then
+		echo "/dev/ublkc$dev_id isn't removed res ${res}"
 		exit 255
 	fi
 }
-- 
2.47.0


