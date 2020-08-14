Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAC02444E8
	for <lists+linux-block@lfdr.de>; Fri, 14 Aug 2020 08:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgHNGSk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 14 Aug 2020 02:18:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39752 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgHNGSk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Aug 2020 02:18:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id a5so7324027wrm.6
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2020 23:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sK8T3YT5/vJQKNOfi96qwKKGpK4HInUhYgSH8H49ltk=;
        b=JL2TYR7n+bvXeOETvEo7nC8sMAuGw8ICUgPC8tKYW0Q9ThMQFLkVXo0P3dAOxJgcn8
         QcmKQSFOcYfytI0SMdFbZh9mBYCv17E03Po+WYLJPky3LnGvxXrPtzVhw64XdUMtMjM0
         IsDkv5TJ18nfZVF9pI6fnx8HnHMOLQ+gS643vUoMeWWrOFr7/KIt+oc164/qjonG3j44
         thp7I9+kPAB9tdSmLOjtt5plSu9OrXfJBSp6tibcScZIgAzp8lz/4RqAwoQEhBmkSSOx
         Cqz+pEQt6Or4e8DQqEkxIvbHWyrNfdzXkbrh4aHI1WneYnkAyPCd6sRByGeLUobz8yJS
         bS+w==
X-Gm-Message-State: AOAM533MuvBa89SUYIOFl7tMCTN9ipFDkYiiWvGJOlwzjB5iWmgwAPUt
        UROZ+RfMlHTlJA53mPAbbk8=
X-Google-Smtp-Source: ABdhPJx0Z0ZiodMYXwnBJLNLp5WoPJiEAJPaiV6FhsjRlDDKnzgofOlTmLaBJgzS8guN5nrfcaFSmA==
X-Received: by 2002:adf:a102:: with SMTP id o2mr1180696wro.319.1597385915582;
        Thu, 13 Aug 2020 23:18:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:51f:3472:bc7:2f4f])
        by smtp.gmail.com with ESMTPSA id l21sm12278131wmj.25.2020.08.13.23.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 23:18:35 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v4 2/7] nvme: consolidate some nvme-cli utility functions
Date:   Thu, 13 Aug 2020 23:18:10 -0700
Message-Id: <20200814061815.536540-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814061815.536540-1-sagi@grimberg.me>
References: <20200814061815.536540-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/002 |  2 +-
 tests/nvme/003 |  4 ++--
 tests/nvme/004 |  4 ++--
 tests/nvme/005 |  4 ++--
 tests/nvme/008 |  4 ++--
 tests/nvme/009 |  4 ++--
 tests/nvme/010 |  4 ++--
 tests/nvme/011 |  4 ++--
 tests/nvme/012 |  4 ++--
 tests/nvme/013 |  4 ++--
 tests/nvme/014 |  4 ++--
 tests/nvme/015 |  4 ++--
 tests/nvme/016 |  2 +-
 tests/nvme/017 |  2 +-
 tests/nvme/018 |  4 ++--
 tests/nvme/019 |  4 ++--
 tests/nvme/020 |  4 ++--
 tests/nvme/021 |  4 ++--
 tests/nvme/022 |  4 ++--
 tests/nvme/023 |  4 ++--
 tests/nvme/024 |  4 ++--
 tests/nvme/025 |  4 ++--
 tests/nvme/026 |  4 ++--
 tests/nvme/027 |  4 ++--
 tests/nvme/028 |  4 ++--
 tests/nvme/029 |  4 ++--
 tests/nvme/031 |  4 ++--
 tests/nvme/rc  | 31 +++++++++++++++++++++++++++++--
 28 files changed, 80 insertions(+), 53 deletions(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index aaa5ec4d729a..999e222705bf 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -31,7 +31,7 @@ test() {
 		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
 	done
 
-	nvme discover -t loop | _filter_discovery
+	_nvme_discover "loop" | _filter_discovery
 
 	for ((i = iterations - 1; i >= 0; i--)); do
 		_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-$i"
diff --git a/tests/nvme/003 b/tests/nvme/003
index fd696d9efe2c..6ea6a23b7942 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -29,7 +29,7 @@ test() {
 	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	nvme connect -t loop -n nqn.2014-08.org.nvmexpress.discovery
+	_nvme_connect_subsys "loop" "nqn.2014-08.org.nvmexpress.discovery"
 
 	# This is ugly but checking for the absence of error messages is ...
 	sleep 10
@@ -42,7 +42,7 @@ test() {
 		echo "Fail"
 	fi
 
-	nvme disconnect -n nqn.2014-08.org.nvmexpress.discovery
+	_nvme_disconnect_subsys "nqn.2014-08.org.nvmexpress.discovery"
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_subsystem "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
diff --git a/tests/nvme/004 b/tests/nvme/004
index b841a8d4cd87..7ea539fda55e 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -33,14 +33,14 @@ test() {
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	nvme connect -t loop -n blktests-subsystem-1
+	_nvme_connect_subsys "loop" "blktests-subsystem-1"
 
 	local nvmedev
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	nvme disconnect -n "blktests-subsystem-1"
+	_nvme_disconnect_subsys "blktests-subsystem-1"
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_subsystem "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
diff --git a/tests/nvme/005 b/tests/nvme/005
index df0900b372be..d4ce6d703c1b 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -33,7 +33,7 @@ test() {
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	nvme connect -t loop -n blktests-subsystem-1
+	_nvme_connect_subsys "loop" "blktests-subsystem-1"
 
 	local nvmedev
 	nvmedev="$(_find_nvme_loop_dev)"
@@ -42,7 +42,7 @@ test() {
 
 	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
 
-	nvme disconnect -d "${nvmedev}"
+	_nvme_disconnect_ctrl "${nvmedev}"
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/008 b/tests/nvme/008
index f19de17fefac..5ab5c49b2039 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -42,7 +42,7 @@ test() {
 
 	udevadm settle
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/009 b/tests/nvme/009
index 4afbe62864f6..f6b999dea541 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -30,7 +30,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -38,7 +38,7 @@ test() {
 
 	udevadm settle
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/010 b/tests/nvme/010
index 53b97484615f..6caa2d0f813d 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -42,7 +42,7 @@ test() {
 
 	_run_fio_verify_io --size=950m --filename="/dev/${nvmedev}n1"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/011 b/tests/nvme/011
index a54583d5c582..7a5535982a74 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -32,7 +32,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 
 	_run_fio_verify_io --size=950m --filename="/dev/${nvmedev}n1"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/012 b/tests/nvme/012
index 0049c3d8ceb6..5c3477a16af9 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -38,7 +38,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -54,7 +54,7 @@ test() {
 
 	umount "${mount_dir}" > /dev/null 2>&1
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/013 b/tests/nvme/013
index 622706ec4088..49784a0d46b5 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -35,7 +35,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -51,7 +51,7 @@ test() {
 
 	umount "${mount_dir}" > /dev/null 2>&1
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/014 b/tests/nvme/014
index 9517230253ab..a33ff439fb3d 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -44,7 +44,7 @@ test() {
 
 	nvme flush "/dev/${nvmedev}" -n 1
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/015 b/tests/nvme/015
index 40b850974b43..cb9792e13442 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 
 	nvme flush "/dev/${nvmedev}n1" -n 1
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/016 b/tests/nvme/016
index e1bad2f81461..1ad744abb9b0 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -33,7 +33,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "$port" "${subsys_nqn}"
 
-	nvme discover -t loop | _filter_discovery
+	_nvme_discover "loop" | _filter_discovery
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_nqn}"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/017 b/tests/nvme/017
index 2e6d649f9b65..2507bcd606b7 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -36,7 +36,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme discover -t loop | _filter_discovery
+	_nvme_discover "loop" | _filter_discovery
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/018 b/tests/nvme/018
index e39613709c90..4863274cc525 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -32,7 +32,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -46,7 +46,7 @@ test() {
 	nvme read "/dev/${nvmedev}n1" -s "$sectors" -c 0 -z "$bs" &>"$FULL" \
 		&& echo "ERROR: nvme read for out of range LBA was not rejected"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/019 b/tests/nvme/019
index 86a2a2945b35..19c5b4755387 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -36,7 +36,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -44,7 +44,7 @@ test() {
 
 	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/020 b/tests/nvme/020
index ccadec6a5822..0a817004225a 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -32,7 +32,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 
 	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/021 b/tests/nvme/021
index bbcb9d56a350..ac3cbd17cd03 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: device not listed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/022 b/tests/nvme/022
index 452e7b3d196c..4c91f98734fc 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: reset failed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/023 b/tests/nvme/023
index 2714571d16d9..dcbe821f2709 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -44,7 +44,7 @@ test() {
 		echo "ERROR: smart-log bdev-ns failed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/024 b/tests/nvme/024
index 1f87bd19ec69..0f4bddcb3142 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 	if ! nvme smart-log "/dev/${nvmedev}" -n 1 >> "$FULL" 2>&1; then
 		echo "ERROR: smart-log file-ns failed"
 	fi
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/025 b/tests/nvme/025
index 1b9e33351f61..90896d327cff 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: effects-log failed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/026 b/tests/nvme/026
index 21a265a630ba..39cfe12a23c7 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: ns-desc failed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/027 b/tests/nvme/027
index d7d33796e122..5915c336a0cd 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 	if ! nvme ns-rescan "/dev/${nvmedev}" >> "$FULL" 2>&1; then
 		echo "ERROR: ns-rescan failed"
 	fi
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/028 b/tests/nvme/028
index 1643857437e8..cf44102b3957 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 	if ! nvme list-subsys 2>> "$FULL" | grep -q loop; then
 		echo "ERROR: list-subsys"
 	fi
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/029 b/tests/nvme/029
index 9f437285d085..192b5c52168c 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -67,7 +67,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -81,7 +81,7 @@ test() {
 	test_user_io "$dev" 511 1023 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 511 1025 > "$FULL" 2>&1 || echo FAIL
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/031 b/tests/nvme/031
index 7e7ee7327e62..ab17633bc8fc 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -41,8 +41,8 @@ test() {
 	for ((i = 0; i < iterations; i++)); do
 		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
 		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
-		nvme connect -t loop -n "${subsys}$i"
-		nvme disconnect -n "${subsys}$i" >> "${FULL}" 2>&1
+		_nvme_connect_subsys "loop" "${subsys}$i"
+		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
 		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
 		_remove_nvmet_subsystem "${subsys}$i"
 	done
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 320aa4b2b475..6d57cf591300 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -64,7 +64,7 @@ _cleanup_nvmet() {
 		transport="$(cat "/sys/class/nvme/${dev}/transport")"
 		if [[ "$transport" == "loop" ]]; then
 			echo "WARNING: Test did not clean up loop device: ${dev}"
-			nvme disconnect -d "${dev}"
+			_nvme_disconnect_ctrl "${dev}"
 		fi
 	done
 
@@ -97,6 +97,33 @@ _setup_nvmet() {
 	modprobe nvme-loop
 }
 
+_nvme_disconnect_ctrl() {
+	local ctrl="$1"
+
+	nvme disconnect -d ${ctrl}
+}
+
+_nvme_disconnect_subsys() {
+	local subsysnqn="$1"
+
+	nvme disconnect -n ${subsysnqn}
+}
+
+_nvme_connect_subsys() {
+	local trtype="$1"
+	local subsysnqn="$2"
+
+	cmd="nvme connect -t ${trtype} -n ${subsysnqn}"
+	eval $cmd
+}
+
+_nvme_discover() {
+	local trtype="$1"
+
+	cmd="nvme discover -t ${trtype}"
+	eval $cmd
+}
+
 _create_nvmet_port() {
 	local trtype="$1"
 
@@ -206,6 +233,6 @@ _filter_discovery() {
 }
 
 _discovery_genctr() {
-	nvme discover -t loop |
+	_nvme_discover "loop" |
 		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
 }
-- 
2.25.1

