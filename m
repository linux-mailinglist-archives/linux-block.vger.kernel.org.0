Return-Path: <linux-block+bounces-87-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6007E7643
	for <lists+linux-block@lfdr.de>; Fri, 10 Nov 2023 02:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C87D4B2131D
	for <lists+linux-block@lfdr.de>; Fri, 10 Nov 2023 01:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0918C2586;
	Fri, 10 Nov 2023 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GWrkSSWr"
X-Original-To: linux-block@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C823D6
	for <linux-block@vger.kernel.org>; Fri, 10 Nov 2023 01:01:56 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896A044A6
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 17:01:55 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28120aa1c24so1316225a91.0
        for <linux-block@vger.kernel.org>; Thu, 09 Nov 2023 17:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699578115; x=1700182915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQQfAGVkAKgYf59iXbnKQtwf1SRSbMQhaeMVSM1Y7tg=;
        b=GWrkSSWrCoK5rd5LUATh/8NA5igPFSS7+EfT2MTFQzFgaUNku1YWSLle0sJE1i5T82
         XuaRptn52X738p248UZk0GiJ754Xr8J310YfnNW5Xbs5g4YNW3ktRYrPOUgfCDg8/PEJ
         MxeaOV+AqGGdlSu0G8m/PSBEautfCt7GN+Fn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699578115; x=1700182915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQQfAGVkAKgYf59iXbnKQtwf1SRSbMQhaeMVSM1Y7tg=;
        b=M5TcmsdVK8q2DEm1wsJ/0cngTyhOcTSR0DdR2C0r+rTdVAwWspuCw5BCqe2H3bpTVv
         DZpgJ09f1EJENQPQC+g3gSHeB2F4fYeREvWJF1dp8GIU9+178ToEav1WHrtE/udo48yv
         /SIhfUBU7tX7sVXBoLHLEWlz7VGV5Cem2Vy0z9V7pYTEUcIU+jEIQgfY4sBOcbpcUCgi
         uU2pEgtOCWGK7lKH3Su/uyStrptlZHeiLcXXRldGRyJdIHhUS32C4QP7Sm33grxg5gep
         C7ed9X2BASFg2UTNNAsaICjZTJlsItTLj5KYoba0S7MW7SxGReYyYHdlJdntb6emtNGN
         etyQ==
X-Gm-Message-State: AOJu0YzVRaIYeEEsp9CsyzYs5XIrRhWLxUzsSy9fLLzop7vVpj1H5yw8
	geUcNfaGdLQ/rjyIT2efo5R2rQ==
X-Google-Smtp-Source: AGHT+IEsIfY/Y7KdBuWjcVyScz3wvYDxi5f/SaW4+80IzWig45+uhH/lxxVaTEsJIA97uxu9vBWmGw==
X-Received: by 2002:a17:90b:4c50:b0:27f:fcc8:9196 with SMTP id np16-20020a17090b4c5000b0027ffcc89196mr3455145pjb.32.1699578114986;
        Thu, 09 Nov 2023 17:01:54 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:e584:25c0:d29c:54c])
        by smtp.gmail.com with UTF8SMTPSA id 4-20020a17090a018400b0028098225450sm470634pjc.1.2023.11.09.17.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 17:01:54 -0800 (PST)
From: Sarthak Kukreti <sarthakkukreti@chromium.org>
To: dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Dave Chinner <david@fromorbit.com>,
	Brian Foster <bfoster@redhat.com>,
	Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH] loop/010: Add test for mode 0 fallocate() on loop devices
Date: Thu,  9 Nov 2023 17:01:39 -0800
Message-ID: <20231110010139.3901150-5-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent patch series[1] adds support for calling fallocate() in mode 0
on block devices. This test adds a basic sanity test for loopback devices
setup on a sparse file and validates that writes to the loopback device
succeed, even when the underlying filesystem runs out of space.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 tests/loop/010     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/loop/010.out |  2 ++
 2 files changed, 62 insertions(+)
 create mode 100644 tests/loop/010
 create mode 100644 tests/loop/010.out

diff --git a/tests/loop/010 b/tests/loop/010
new file mode 100644
index 0000000..091be5e
--- /dev/null
+++ b/tests/loop/010
@@ -0,0 +1,60 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Google LLC.
+# Author: sarthakkukret@google.com (Sarthak Kukreti)
+#
+# Test if fallocate() on a loopback device provisions space on the underlying
+# filesystem and writes on the loop device succeed, even if the lower
+# filesystem is filled up.
+
+. tests/loop/rc
+
+DESCRIPTION="Loop device fallocate() space provisioning"
+QUICK=1
+
+requires() {
+	_have_program mkfs.ext4
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local mount_dir="$TMPDIR/mnt"
+	mkdir -p ${mount_dir}
+
+	local image_file="$TMPDIR/img"
+	truncate -s 1G "${image_file}"
+
+	local loop_device
+	loop_device="$(losetup -P -f --show "${image_file}")"
+
+	mkfs.ext4 ${loop_device} &> /dev/null
+	mount -t ext4 ${loop_device} ${mount_dir}
+
+	local provisioned_file="${mount_dir}/provisioned"
+	truncate -s 200M "${provisioned_file}"
+
+	local provisioned_loop_device
+	provisioned_loop_device="$(losetup -P -f --show "${provisioned_file}")"
+
+	# Provision space for the file: without provisioning support, this fails
+	# with EOPNOTSUPP.
+	fallocate -l 200M "${provisioned_loop_device}"
+
+	# Fill the filesystem, this command will error out with ENOSPC.
+	local fs_fill_file="${mount_dir}/fill"
+	dd if=/dev/zero of="${fs_fill_file}" bs=1M count=1024 status=none &>/dev/null
+	sync
+
+	# Write to provisioned loop device, ensure that it does not run into ENOSPC.
+	dd if=/dev/zero of="${provisioned_loop_device}" bs=1M count=200 status=none
+	sync
+
+	# Cleanup.
+	losetup --detach "${provisioned_loop_device}"
+	umount "${mount_dir}"
+	losetup --detach "${loop_device}"
+	rm "${image_file}"
+
+	echo "Test complete"
+}
\ No newline at end of file
diff --git a/tests/loop/010.out b/tests/loop/010.out
new file mode 100644
index 0000000..068c489
--- /dev/null
+++ b/tests/loop/010.out
@@ -0,0 +1,2 @@
+Running loop/009
+Test complete
-- 
2.42.0.758.gaed0368e0e-goog


