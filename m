Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F66367716
	for <lists+linux-block@lfdr.de>; Sat, 13 Jul 2019 01:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfGLX6A (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 12 Jul 2019 19:58:00 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60350 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfGLX57 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jul 2019 19:57:59 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hm5QG-0004Ou-E0; Fri, 12 Jul 2019 17:57:59 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hm5QE-0005uC-6e; Fri, 12 Jul 2019 17:57:50 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 12 Jul 2019 17:57:31 -0600
Message-Id: <20190712235742.22646-2-logang@deltatee.com>
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
Subject: [PATCH blktests 01/12] Add filter function for nvme discover
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Michael Moese <mmoese@suse.de>

Several NVMe tests (002, 016, 017) used a pipe to a sed call filtering
the output. This call is moved to a new filter function nvme/rc and
the calls to sed are replaced by this function.

Additionally, the test nvme/016 failed for me due to the Generation
counter being greater than 1, so the new filter function was expanded to
replace the Generation counter with 'X'.

Signed-off-by: Michael Moese <mmoese@suse.de>
[logang@deltatee.com: added missing changes to 002.out and 017.out]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/002     | 2 +-
 tests/nvme/002.out | 2 +-
 tests/nvme/016     | 2 +-
 tests/nvme/016.out | 2 +-
 tests/nvme/017     | 2 +-
 tests/nvme/017.out | 2 +-
 tests/nvme/rc      | 5 +++++
 7 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index 106a5a8395f2..ceac1c677bd4 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -32,7 +32,7 @@ test() {
 		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
 	done
 
-	nvme discover -t loop | sed -r -e "s/portid:  [0-9]+/portid:  X/"
+	nvme discover -t loop | _filter_discovery
 
 	for ((i = iterations - 1; i >= 0; i--)); do
 		_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-$i"
diff --git a/tests/nvme/002.out b/tests/nvme/002.out
index aa71d8f5f5f8..7437a21f60a9 100644
--- a/tests/nvme/002.out
+++ b/tests/nvme/002.out
@@ -1,6 +1,6 @@
 Running nvme/002
 
-Discovery Log Number of Records 1000, Generation counter 1000
+Discovery Log Number of Records 1000, Generation counter X
 =====Discovery Log Entry 0======
 trtype:  loop
 adrfam:  pci
diff --git a/tests/nvme/016 b/tests/nvme/016
index 966d5dc0a4a2..dd1b84a16daa 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "$port" "${subsys_nqn}"
 
-	nvme discover -t loop | sed -r -e "s/portid:  [0-9]+/portid:  X/"
+	nvme discover -t loop | _filter_discovery
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_nqn}"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/016.out b/tests/nvme/016.out
index 59bd2935346f..b70603144d5c 100644
--- a/tests/nvme/016.out
+++ b/tests/nvme/016.out
@@ -1,6 +1,6 @@
 Running nvme/016
 
-Discovery Log Number of Records 1, Generation counter 1
+Discovery Log Number of Records 1, Generation counter X
 =====Discovery Log Entry 0======
 trtype:  loop
 adrfam:  pci
diff --git a/tests/nvme/017 b/tests/nvme/017
index 0b86bece9520..5f8d60907293 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -37,7 +37,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme discover -t loop | sed -r -e "s/portid:  [0-9]+/portid:  X/"
+	nvme discover -t loop | _filter_discovery
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/017.out b/tests/nvme/017.out
index 4b0877aaf3ca..cf212971d180 100644
--- a/tests/nvme/017.out
+++ b/tests/nvme/017.out
@@ -1,6 +1,6 @@
 Running nvme/017
 
-Discovery Log Number of Records 1, Generation counter 1
+Discovery Log Number of Records 1, Generation counter X
 =====Discovery Log Entry 0======
 trtype:  loop
 adrfam:  pci
diff --git a/tests/nvme/rc b/tests/nvme/rc
index eff1dd992460..22833d8ef9bb 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -118,3 +118,8 @@ _find_nvme_loop_dev() {
 		fi
 	done
 }
+
+_filter_discovery() {
+	sed -r  -e "s/portid:  [0-9]+/portid:  X/" \
+		-e "s/Generation counter [0-9]+/Generation counter X/"
+}
-- 
2.17.1

