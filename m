Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4E18DB1C
	for <lists+linux-block@lfdr.de>; Fri, 20 Mar 2020 23:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgCTWYa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Mar 2020 18:24:30 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50304 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTWYa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 18:24:30 -0400
Received: by mail-pj1-f66.google.com with SMTP id v13so3120351pjb.0
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2020 15:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHkMYa5vZVVlYvxrWrdgU60QiqaYfeJK4ma/tbzKKVM=;
        b=goBnRIZh1GBwqIghmEa8NIZXQ6fvyKjXrsGe8ZWXo++H3jXs79JxJOFVv43Mr0xwEe
         7XizHQy4VTErGtzDapM3jHPwmBJj8/OAXDhXSpmRJno4eth+y596oBShsHy7c2Iw6mKV
         r8J2FC9p9EsmPRz8pJ7k/soQLQS/XsE6VR6ZKu8mlve94EMjS8b6alZ+ahLEfzMuF1eS
         aJdUaqneBMZb8O+12xE2RtDK1LtoR7/RmUqNQkSeKWM84OBLDfwpvmE1PvX9Bnpwtt1D
         cvmBNlNvSW2Nbt0lhX2MqCAmh3LSEg1/VSXHYY0r7jI5di7YgD0LSmc7PBros8lGLbv6
         AmWg==
X-Gm-Message-State: ANhLgQ0QLHH7IA5DgAxw5rBK5AMwceIBIk2rQhtZhAZlUpTUCzQLJpSG
        4c0zMHg/LO5r49DAgIaNo8I=
X-Google-Smtp-Source: ADFU+vvTx5eJz0CW8OwYpguhzejQsBu3e1/yVuCtfOokBLoUOjLMcHh2TJMKCWdEIVziSoDy6swJHQ==
X-Received: by 2002:a17:902:7d91:: with SMTP id a17mr10672073plm.267.1584743067615;
        Fri, 20 Mar 2020 15:24:27 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:c142:5d77:5a3f:9429])
        by smtp.gmail.com with ESMTPSA id z20sm6050530pge.62.2020.03.20.15.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 15:24:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH blktests v3 4/4] Add a test that triggers the blk_mq_realloc_hw_ctxs() error path
Date:   Fri, 20 Mar 2020 15:24:13 -0700
Message-Id: <20200320222413.24386-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320222413.24386-1-bvanassche@acm.org>
References: <20200320222413.24386-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a test that triggers the code touched by commit d0930bb8f46b ("blk-mq:
Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()"). This
test only runs if a recently added fault injection feature is available,
namely commit 596444e75705 ("null_blk: Add support for init_hctx() fault
injection").

Cc: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/block/030     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/block/030.out |  1 +
 2 files changed, 43 insertions(+)
 create mode 100755 tests/block/030
 create mode 100644 tests/block/030.out

diff --git a/tests/block/030 b/tests/block/030
new file mode 100755
index 000000000000..4a17550ab8eb
--- /dev/null
+++ b/tests/block/030
@@ -0,0 +1,42 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2020 Google LLC
+#
+# Trigger the blk_mq_realloc_hw_ctxs() error path.
+
+. tests/block/rc
+. common/null_blk
+
+DESCRIPTION="trigger the blk_mq_realloc_hw_ctxs() error path"
+QUICK=1
+
+requires() {
+	_have_null_blk || return $?
+	_have_module_param null_blk init_hctx || return $?
+}
+
+test() {
+	local i sq=/sys/kernel/config/nullb/nullb0/submit_queues
+
+	: "${TIMEOUT:=30}"
+	if ! _init_null_blk nr_devices=0 queue_mode=2 "init_hctx=$(nproc),100,0,0"; then
+		echo "Loading null_blk failed"
+		return 1
+	fi
+	if ! _configure_null_blk nullb0 completion_nsec=0 blocksize=512 size=16\
+	     submit_queues="$(nproc)" memory_backed=1 power=1; then
+		echo "Configuring null_blk failed"
+		return 1
+	fi
+	if { echo "$(<"$sq")" >$sq; } 2>/dev/null; then
+		for ((i=0;i<100;i++)); do
+			echo 1 >$sq
+			nproc >$sq
+		done
+	else
+		SKIP_REASON="Skipping test because $sq cannot be modified"
+	fi
+	rmdir /sys/kernel/config/nullb/nullb0
+	_exit_null_blk
+	echo Passed
+}
diff --git a/tests/block/030.out b/tests/block/030.out
new file mode 100644
index 000000000000..863339fb8ced
--- /dev/null
+++ b/tests/block/030.out
@@ -0,0 +1 @@
+Passed
