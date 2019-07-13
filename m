Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36B106770C
	for <lists+linux-block@lfdr.de>; Sat, 13 Jul 2019 01:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfGLX5y (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 12 Jul 2019 19:57:54 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60268 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfGLX5y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jul 2019 19:57:54 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hm5QG-0004Ox-Dz; Fri, 12 Jul 2019 17:57:53 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hm5QE-0005uL-Fa; Fri, 12 Jul 2019 17:57:50 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 12 Jul 2019 17:57:34 -0600
Message-Id: <20190712235742.22646-5-logang@deltatee.com>
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
Subject: [PATCH blktests 04/12] nvme/003,004: Add missing calls to nvme disconnect
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Tests 003 and 004 do not call  nvme disconnect. In most cases it is
cleaned up by removing the modules but it should be made explicit.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/003     | 1 +
 tests/nvme/003.out | 1 +
 tests/nvme/004     | 1 +
 tests/nvme/004.out | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tests/nvme/003 b/tests/nvme/003
index c6b3d4037aa6..374e6af0ca6f 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -42,6 +42,7 @@ test() {
 		echo "Fail"
 	fi
 
+	nvme disconnect -n nqn.2014-08.org.nvmexpress.discovery
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_subsystem "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
diff --git a/tests/nvme/003.out b/tests/nvme/003.out
index 01b275612159..beb356128c9d 100644
--- a/tests/nvme/003.out
+++ b/tests/nvme/003.out
@@ -1,2 +1,3 @@
 Running nvme/003
+NQN:nqn.2014-08.org.nvmexpress.discovery disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/004 b/tests/nvme/004
index 0506fa220de3..767aedaa0263 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -40,6 +40,7 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
+	nvme disconnect -n "blktests-subsystem-1"
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_subsystem "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
diff --git a/tests/nvme/004.out b/tests/nvme/004.out
index 53f911ecf329..51f605227320 100644
--- a/tests/nvme/004.out
+++ b/tests/nvme/004.out
@@ -1,4 +1,5 @@
 Running nvme/004
 91fdba0d-f87b-4c25-b80f-db7be1418b9e
 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
-- 
2.17.1

