Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8D725B671
	for <lists+linux-block@lfdr.de>; Thu,  3 Sep 2020 00:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIBW3N (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Sep 2020 18:29:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38787 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgIBW3L (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Sep 2020 18:29:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id l191so456543pgd.5
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2020 15:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p0c8av8YfxEDp98eq1BdEC8I88lbnOK0VL5iuEdgHAM=;
        b=rlt/fWd25zBy+wmClt60n0TxR43Mt4yiwtJh98bIH6xOByUJ5P6lc0CUhCNspR24xu
         qfX4nJl4+7KBXab+sM8mjsVlsdlGHQ5blq+Q+jk3Y7KXFMQ/ZqUtAkcGpXlft/cSYTGU
         Mexff7VpB4rn/8j0cx2DqSGW8I6V/BH8KY4cof/+aVkA3izM/V/M46yQi2DxOKH6Otus
         chAJg14b9UmvWIf+JZ8axOyfX10z7Pp22iqFERjxsRTiLNVyNB3zgF0sre7OueppWcDc
         /PyETuN0mGRaluBtBdnnqP0SSFw0moXuNQDCM2h3/7TSlBRfxdC/MRgAPA51St+Iqw3H
         dm6g==
X-Gm-Message-State: AOAM530+Dl0Ly0gdkGKcySYlxVFdI/C8fSa4eNLkA+5ihGlIjjg4hRns
        73WISAWq2mAjVwDvFggeUcT+9qyBu4R2ig==
X-Google-Smtp-Source: ABdhPJw0k+11IRvjXCc8cyyygWp6mQP/erEM0YjC2ir38xAHtVn/P9pVrjnMaEqmrUppKSru9aoQDA==
X-Received: by 2002:a17:902:ee54:b029:d0:4c09:c0 with SMTP id 20-20020a170902ee54b02900d04c0900c0mr515441plo.2.1599085748884;
        Wed, 02 Sep 2020 15:29:08 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:4025:ed24:701e:8cf3])
        by smtp.gmail.com with ESMTPSA id p184sm569293pfb.47.2020.09.02.15.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 15:29:08 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v5 3/7] nvme: make tests transport type agnostic
Date:   Wed,  2 Sep 2020 15:28:57 -0700
Message-Id: <20200902222901.408217-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902222901.408217-1-sagi@grimberg.me>
References: <20200902222901.408217-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass in nvme_trtype to common routines that can
support multiple transport types.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/002 |  4 ++--
 tests/nvme/003 |  4 ++--
 tests/nvme/004 |  6 +++---
 tests/nvme/005 |  6 +++---
 tests/nvme/006 |  2 +-
 tests/nvme/007 |  2 +-
 tests/nvme/008 |  6 +++---
 tests/nvme/009 |  6 +++---
 tests/nvme/010 |  6 +++---
 tests/nvme/011 |  6 +++---
 tests/nvme/012 |  6 +++---
 tests/nvme/013 |  6 +++---
 tests/nvme/014 |  6 +++---
 tests/nvme/015 |  6 +++---
 tests/nvme/016 |  2 +-
 tests/nvme/017 |  2 +-
 tests/nvme/018 |  6 +++---
 tests/nvme/019 |  6 +++---
 tests/nvme/020 |  6 +++---
 tests/nvme/021 |  6 +++---
 tests/nvme/022 |  6 +++---
 tests/nvme/023 |  6 +++---
 tests/nvme/024 |  6 +++---
 tests/nvme/025 |  6 +++---
 tests/nvme/026 |  6 +++---
 tests/nvme/027 |  6 +++---
 tests/nvme/028 |  8 ++++----
 tests/nvme/029 |  6 +++---
 tests/nvme/030 |  2 +-
 tests/nvme/031 |  4 ++--
 tests/nvme/rc  | 39 ++++++++++++++++++++++++++++++++-------
 31 files changed, 110 insertions(+), 85 deletions(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index 92779e8d28ca..7ff6f339017c 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -21,7 +21,7 @@ test() {
 
 	local iterations=1000
 	local port
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 
 	local loop_dev
 	loop_dev="$(losetup -f)"
@@ -31,7 +31,7 @@ test() {
 		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
 	done
 
-	_nvme_discover loop | _filter_discovery
+	_nvme_discover ${nvme_trtype} | _filter_discovery
 
 	for ((i = iterations - 1; i >= 0; i--)); do
 		_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-$i"
diff --git a/tests/nvme/003 b/tests/nvme/003
index 83d1b2ff9cb0..a4c66b1ba7ad 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -21,7 +21,7 @@ test() {
 	_setup_nvmet
 
 	local port
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	local loop_dev
 	loop_dev="$(losetup -f)"
@@ -29,7 +29,7 @@ test() {
 	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	_nvme_connect_subsys loop nqn.2014-08.org.nvmexpress.discovery
+	_nvme_connect_subsys ${nvme_trtype} nqn.2014-08.org.nvmexpress.discovery
 
 	# This is ugly but checking for the absence of error messages is ...
 	sleep 10
diff --git a/tests/nvme/004 b/tests/nvme/004
index 1a3eedd634cf..e6142ded7f06 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -22,7 +22,7 @@ test() {
 	_setup_nvmet
 
 	local port
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 
 	truncate -s 1G "$TMPDIR/img"
 
@@ -33,10 +33,10 @@ test() {
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	_nvme_connect_subsys loop blktests-subsystem-1
+	_nvme_connect_subsys ${nvme_trtype} blktests-subsystem-1
 
 	local nvmedev
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/005 b/tests/nvme/005
index 708e37766e0e..b8f3cab176b0 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -22,7 +22,7 @@ test() {
 	_setup_nvmet
 
 	local port
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 
 	truncate -s 1G "$TMPDIR/img"
 
@@ -33,10 +33,10 @@ test() {
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	_nvme_connect_subsys loop blktests-subsystem-1
+	_nvme_connect_subsys ${nvme_trtype} blktests-subsystem-1
 
 	local nvmedev
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 
 	udevadm settle
 
diff --git a/tests/nvme/006 b/tests/nvme/006
index 3f47613d52d2..3f161d08bc22 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -29,7 +29,7 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
diff --git a/tests/nvme/007 b/tests/nvme/007
index 0902745a4ab2..b0e61186e886 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -28,7 +28,7 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
diff --git a/tests/nvme/008 b/tests/nvme/008
index 177a1f27dcd6..a236d16d41d2 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -31,12 +31,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/009 b/tests/nvme/009
index 621eec668926..10b5d81ff101 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -27,12 +27,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/010 b/tests/nvme/010
index 3a629469014f..7b0648957e3c 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -31,12 +31,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/011 b/tests/nvme/011
index 068090a0f42d..11dda72351b3 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -29,12 +29,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/012 b/tests/nvme/012
index 4cab4c1891a9..c4bd34bec812 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -35,12 +35,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index b646f08be26a..17fc8a2d00cc 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -32,12 +32,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/014 b/tests/nvme/014
index 979f77009209..b79069850da8 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -31,12 +31,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index ecd23b206e25..ec15dbce498d 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/016 b/tests/nvme/016
index a2b22adfc6b9..229aa9ab02e7 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -30,7 +30,7 @@ test() {
 		_create_nvmet_ns "${subsys_nqn}" "${i}" "${loop_dev}"
 	done
 
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "$port" "${subsys_nqn}"
 
 	_nvme_discover loop | _filter_discovery
diff --git a/tests/nvme/017 b/tests/nvme/017
index 7ec146ec7414..a630b8217a70 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -33,7 +33,7 @@ test() {
 		_create_nvmet_ns "${subsys_name}" "${i}" "${file_path}"
 	done
 
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
 	_nvme_discover loop | _filter_discovery
diff --git a/tests/nvme/018 b/tests/nvme/018
index 9b5abefd39d2..698fa7b2095f 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -29,12 +29,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/019 b/tests/nvme/019
index 5bc68e4514f9..58f1dbeea400 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -33,12 +33,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/020 b/tests/nvme/020
index 32f7490b0796..ce4fbe648f14 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -29,12 +29,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/021 b/tests/nvme/021
index c10c09277cff..d34ec9dca49e 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/022 b/tests/nvme/022
index f7286ef008e0..2461abed7df5 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/023 b/tests/nvme/023
index 0b93fe95954b..f98b77d832f7 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -31,12 +31,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/024 b/tests/nvme/024
index 174fdc74a4e1..a311ff5b0f00 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/025 b/tests/nvme/025
index 7f90a57861bd..cdf7f4499f33 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index 5af08b753fe9..7cc3794099b9 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/027 b/tests/nvme/027
index 445f4fc65306..48f761922e73 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/028 b/tests/nvme/028
index 70f6462bb9f3..d841906982da 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -28,16 +28,16 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	if ! nvme list-subsys 2>> "$FULL" | grep -q loop; then
+	if ! nvme list-subsys 2>> "$FULL" | grep -q ${nvme_trtype}; then
 		echo "ERROR: list-subsys"
 	fi
 	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
diff --git a/tests/nvme/029 b/tests/nvme/029
index 873e54e7e43a..79e30a1c337b 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -64,12 +64,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys ${nvme_trtype} ${subsys_name}
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/030 b/tests/nvme/030
index 7156cad7b657..220b29f42962 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -37,7 +37,7 @@ test() {
 
     _setup_nvmet
 
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 
 	_create_nvmet_subsystem "${subsys}1" "$(losetup -f)"
 	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
diff --git a/tests/nvme/031 b/tests/nvme/031
index 7053553cb837..001f9d2b0b3a 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -36,12 +36,12 @@ test() {
 
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
 
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 
 	for ((i = 0; i < iterations; i++)); do
 		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
 		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
-		_nvme_connect_subsys loop "${subsys}$i"
+		_nvme_connect_subsys ${nvme_trtype} "${subsys}$i"
 		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
 		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
 		_remove_nvmet_subsystem "${subsys}$i"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index db19d50131e9..a9abec1b20af 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -6,6 +6,9 @@
 
 . common/rc
 
+def_traddr="127.0.0.1"
+def_adrfam="ipv4"
+def_trsvcid="4420"
 nvme_trtype=${nvme_trtype:-"loop"}
 
 _nvme_requires() {
@@ -62,8 +65,8 @@ _cleanup_nvmet() {
 	for dev in /sys/class/nvme/nvme*; do
 		dev="$(basename "$dev")"
 		transport="$(cat "/sys/class/nvme/${dev}/transport")"
-		if [[ "$transport" == "loop" ]]; then
-			echo "WARNING: Test did not clean up loop device: ${dev}"
+		if [[ "$transport" == "${nvme_trtype}" ]]; then
+			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
 			_nvme_disconnect_ctrl "${dev}"
 		fi
 	done
@@ -87,14 +90,20 @@ _cleanup_nvmet() {
 	shopt -u nullglob
 	trap SIGINT
 
-	modprobe -r nvme-loop 2>/dev/null
+	modprobe -r nvme-${nvme_trtype} 2>/dev/null
+	if [[ "${nvme_trtype}" != "loop" ]]; then
+		modprobe -r nvmet-${nvme_trtype} 2>/dev/null
+	fi
 	modprobe -r nvmet 2>/dev/null
 }
 
 _setup_nvmet() {
 	_register_test_cleanup _cleanup_nvmet
 	modprobe nvmet
-	modprobe nvme-loop
+	if [[ "${nvme_trtype}" != "loop" ]]; then
+		modprobe nvmet-${nvme_trtype}
+	fi
+	modprobe nvme-${nvme_trtype}
 }
 
 _nvme_disconnect_ctrl() {
@@ -112,20 +121,33 @@ _nvme_disconnect_subsys() {
 _nvme_connect_subsys() {
 	local trtype="$1"
 	local subsysnqn="$2"
+	local traddr="${3:-$def_traddr}"
+	local trsvcid="${4:-$def_trsvcid}"
 
 	ARGS=(-t "${trtype}" -n "${subsysnqn}")
+	if [[ "${trtype}" != "loop" ]]; then
+		ARGS+=(-a "${traddr}" -s "${trsvcid}")
+	fi
 	nvme connect "${ARGS[@]}"
 }
 
 _nvme_discover() {
 	local trtype="$1"
+	local traddr="${2:-$def_traddr}"
+	local trsvcid="${3:-$def_trsvcid}"
 
 	ARGS=(-t "${trtype}" -n "${subsysnqn}")
+	if [[ "${trtype}" != "loop" ]]; then
+		ARGS+=(-a "${traddr}" -s "${trsvcid}")
+	fi
 	nvme discover "${ARGS[@]}"
 }
 
 _create_nvmet_port() {
 	local trtype="$1"
+	local traddr="${2:-$def_traddr}"
+	local adrfam="${3:-$def_adrfam}"
+	local trsvcid="${4:-$def_trsvcid}"
 
 	local port
 	for ((port = 0; ; port++)); do
@@ -136,6 +158,9 @@ _create_nvmet_port() {
 
 	mkdir "${NVMET_CFS}/ports/${port}"
 	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
+	echo "${traddr}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
+	echo "${adrfam}" > "${NVMET_CFS}/ports/${port}/addr_adrfam"
+	echo "${trsvcid}" > "${NVMET_CFS}/ports/${port}/addr_trsvcid"
 
 	echo "${port}"
 }
@@ -207,13 +232,13 @@ _remove_nvmet_subsystem_from_port() {
 	rm "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
 }
 
-_find_nvme_loop_dev() {
+_find_nvme_dev() {
 	local dev
 	local transport
 	for dev in /sys/class/nvme/nvme*; do
 		dev="$(basename "$dev")"
 		transport="$(cat "/sys/class/nvme/${dev}/transport")"
-		if [[ "$transport" == "loop" ]]; then
+		if [[ "$transport" == "${nvme_trtype}" ]]; then
 			echo "$dev"
 			for ((i = 0; i < 10; i++)); do
 				if [[ -e /sys/block/$dev/uuid &&
@@ -233,6 +258,6 @@ _filter_discovery() {
 }
 
 _discovery_genctr() {
-	_nvme_discover loop |
+	_nvme_discover "${nvme_trtype}" |
 		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
 }
-- 
2.25.1

