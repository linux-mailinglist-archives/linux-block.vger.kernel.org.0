Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF1BC67711
	for <lists+linux-block@lfdr.de>; Sat, 13 Jul 2019 01:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfGLX55 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 12 Jul 2019 19:57:57 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60304 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfGLX55 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jul 2019 19:57:57 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hm5QG-0004Ow-Dz; Fri, 12 Jul 2019 17:57:56 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hm5QE-0005uI-Cr; Fri, 12 Jul 2019 17:57:50 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 12 Jul 2019 17:57:33 -0600
Message-Id: <20190712235742.22646-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712235742.22646-1-logang@deltatee.com>
References: <20190712235742.22646-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, osandov@fb.com, chaitanya.kulkarni@wdc.com, tytso@mit.edu, mmoese@suse.de, jthumshirn@suse.de, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH blktests 03/12] nvme: Add new test to verify the generation counter
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that the other discovery tests ignore the generation counter value,
create a new test to specifically check that it increments when
subsystems are added or removed from ports and when allow_any_host
is set/unset.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/030     | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/030.out |  2 ++
 tests/nvme/rc      |  5 +++
 3 files changed, 83 insertions(+)
 create mode 100755 tests/nvme/030
 create mode 100644 tests/nvme/030.out

diff --git a/tests/nvme/030 b/tests/nvme/030
new file mode 100755
index 000000000000..963e1ad7118c
--- /dev/null
+++ b/tests/nvme/030
@@ -0,0 +1,76 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Logan Gunthorpe
+#
+# Test nvme discovery generation counter
+
+. tests/nvme/rc
+
+DESCRIPTION="ensure the discovery generation counter is updated appropriately"
+QUICK=1
+
+requires() {
+	_have_program nvme &&
+	_have_modules loop nvme-loop nvmet &&
+	_have_configfs
+}
+
+
+checkgenctr() {
+	local last=$1
+	local msg=$2
+	local genctr
+
+	genctr=$(_discovery_genctr)
+	if (( "${genctr}" <= "${last}" )); then
+		echo "Generation counter not incremented when ${msg} (${genctr} <= ${last})"
+	fi
+
+	echo "${genctr}"
+}
+
+test() {
+	local port
+	local genctr
+	local subsys="blktests-subsystem-"
+
+	echo "Running ${TEST_NAME}"
+
+	modprobe nvmet
+	modprobe nvme-loop
+
+	port="$(_create_nvmet_port "loop")"
+
+	_create_nvmet_subsystem "${subsys}1" "$(losetup -f)"
+	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
+
+	genctr=$(_discovery_genctr)
+
+	_create_nvmet_subsystem "${subsys}2" "$(losetup -f)"
+	_add_nvmet_subsys_to_port "${port}" "${subsys}2"
+
+	genctr=$(checkgenctr "${genctr}" "adding a subsystem to a port")
+
+	echo 0 > "${NVMET_CFS}/subsystems/${subsys}2/attr_allow_any_host"
+
+	genctr=$(checkgenctr "${genctr}" "clearing attr_allow_any_host")
+
+	echo 1 > "${NVMET_CFS}/subsystems/${subsys}2/attr_allow_any_host"
+
+	genctr=$(checkgenctr "${genctr}" "setting attr_allow_any_host")
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys}2"
+	_remove_nvmet_subsystem "${subsys}2"
+
+	genctr=$(checkgenctr "${genctr}" "removing a subsystem from a port")
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys}1"
+	_remove_nvmet_subsystem "${subsys}1"
+
+	_remove_nvmet_port "${port}"
+
+	modprobe -r nvme-loop
+	modprobe -r nvmet
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/030.out b/tests/nvme/030.out
new file mode 100644
index 000000000000..93e51905b5d4
--- /dev/null
+++ b/tests/nvme/030.out
@@ -0,0 +1,2 @@
+Running nvme/030
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 60dc05869726..39b2c2e2b91c 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -123,3 +123,8 @@ _filter_discovery() {
 	sed -r -e "s/Generation counter [0-9]+/Generation counter X/" |
 		grep 'Discovery Log Number\|Log Entry\|trtype\|subnqn'
 }
+
+_discovery_genctr() {
+	nvme discover -t loop |
+		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
+}
-- 
2.17.1

