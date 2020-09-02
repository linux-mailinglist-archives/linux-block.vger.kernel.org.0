Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121D625B673
	for <lists+linux-block@lfdr.de>; Thu,  3 Sep 2020 00:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIBW3Q (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Sep 2020 18:29:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43220 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgIBW3O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Sep 2020 18:29:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id f18so526286pfa.10
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2020 15:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4766iF8tGytH+Vfs6i3/U2RwWmzQyiBC+bGyaYv3Kg=;
        b=RLcrpwhva1j7VI/a3tPT/MVK0fC1nQ96gO5bhtLnjxrekitnWGeAqOmflLo2RbdD1I
         OFJh1mMwnCBJY/5HNPsjiD+pBwirXAS5R5TyCyISgO7C/3etAlb8Qxu0kXDcuYQ2QDbB
         IW+Nef1y9v7hBM2ej8woFRFZipqUc2LPR9B2BI7INR0+kieYOBuscx+AW69PVmZF78im
         g3TcuG22BH4n95DSSJqsvbRRLCCham4O8rWc4sE3qqrHUfvPD4k4RP2DcaD/x6sY8jFl
         8n2fRBncY+GDt+kcBke3XviC6OoHyTaMlZywhp2RGLG1SJgC3vmb19kMt7rQoVm5Oqir
         m7dw==
X-Gm-Message-State: AOAM5316BS40/hKTrd8NYLv9Q5gfIASE5pt8XxcY47uk+oV1RGGGTHew
        mWpavK68J4S2Nc9OkMz7/14O8dWr/8rZ0g==
X-Google-Smtp-Source: ABdhPJyvMZJjKcKtcSXf0iutBlhu3d663TCKEIsEdD9BJUIUzGYjf3qT4AlLnO8W+EC5g0UMpr65SA==
X-Received: by 2002:aa7:983d:: with SMTP id q29mr564194pfl.298.1599085753051;
        Wed, 02 Sep 2020 15:29:13 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:4025:ed24:701e:8cf3])
        by smtp.gmail.com with ESMTPSA id p184sm569293pfb.47.2020.09.02.15.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 15:29:12 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v5 6/7] common: move module_unload to common
Date:   Wed,  2 Sep 2020 15:29:00 -0700
Message-Id: <20200902222901.408217-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902222901.408217-1-sagi@grimberg.me>
References: <20200902222901.408217-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It creates a dependency between multipath-over-rdma and test/nvmeof/rc
(and test/srp/rc) which is not a natural home for it.

Move it to common helpers.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 common/rc          | 13 +++++++++++++
 tests/nvmeof-mp/rc | 13 -------------
 tests/srp/rc       | 13 -------------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/common/rc b/common/rc
index 7f02103dc786..cdc0150ea5ea 100644
--- a/common/rc
+++ b/common/rc
@@ -291,3 +291,16 @@ _filter_xfs_io_error() {
 _uptime_s() {
 	awk '{ print int($1) }' /proc/uptime
 }
+
+# Arguments: module to unload ($1) and retry count ($2).
+unload_module() {
+	local i m=$1 rc=${2:-1}
+
+	[ ! -e "/sys/module/$m" ] && return 0
+	for ((i=rc;i>0;i--)); do
+		modprobe -r "$m"
+		[ ! -e "/sys/module/$m" ] && return 0
+		sleep .1
+	done
+	return 1
+}
diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index b95adf047a2f..d7a7c878fb19 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -149,19 +149,6 @@ remove_mpath_devs() {
 	} &>> "$FULL"
 }
 
-# Arguments: module to unload ($1) and retry count ($2).
-unload_module() {
-	local i m=$1 rc=${2:-1}
-
-	[ ! -e "/sys/module/$m" ] && return 0
-	for ((i=rc;i>0;i--)); do
-		modprobe -r "$m"
-		[ ! -e "/sys/module/$m" ] && return 0
-		sleep .1
-	done
-	return 1
-}
-
 start_nvme_client() {
 	modprobe nvme-core dyndbg=+pmf &&
 		modprobe nvme dyndbg=+pmf &&
diff --git a/tests/srp/rc b/tests/srp/rc
index 72a3bca3b44d..7fc094b8267f 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -321,19 +321,6 @@ remove_mpath_devs() {
 	} &>> "$FULL"
 }
 
-# Arguments: module to unload ($1) and retry count ($2).
-unload_module() {
-	local i m=$1 rc=${2:-1}
-
-	[ ! -e "/sys/module/$m" ] && return 0
-	for ((i=rc;i>0;i--)); do
-		modprobe -r "$m"
-		[ ! -e "/sys/module/$m" ] && return 0
-		sleep .1
-	done
-	return 1
-}
-
 # Load the SRP initiator driver with kernel module parameters $1..$n.
 start_srp_ini() {
 	modprobe scsi_transport_srp || return $?
-- 
2.25.1

