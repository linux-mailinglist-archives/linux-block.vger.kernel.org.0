Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2127E27F264
	for <lists+linux-block@lfdr.de>; Wed, 30 Sep 2020 21:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgI3TOu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 30 Sep 2020 15:14:50 -0400
Received: from ale.deltatee.com ([204.191.154.188]:37978 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbgI3TOt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Sep 2020 15:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tJSHvT1QhRVl+G04VHp6oB+MDJJauXzKMIhMmzCIDDM=; b=ZQOD/b/n4WQ66CxWM/hXXEMnhK
        0NYEsye4QqL616Iw5u2GZboX3lty9Lq8lZODHVzOUhB+y/DLrbg7HypDABv4UYvUlcUw5kqtbTiMH
        QLIUfPGgkbYILPEtkuOAkxbd58IF+JnPtt5OAh1kSlSdaMjQqdd3P1l+y9GbDHGSDI9IqkJoEge6w
        XA1uld3DMwjGPmttwaMbphFCu3uoTSoe24ac18NwOnAtu1tOlzQfhK0TdNMeMFr1cIL2c6TRidfjJ
        WuW3uazKXx+d2/mmmJ18YzLhdNXvzGB5I4MQiry+tHnJ/tw/glq2TuPpcm5DaT3Wq/lPAuxpHLn9U
        IfEC3Vbw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kNhFE-0000ux-52; Wed, 30 Sep 2020 12:54:32 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kNhFD-00030L-6Z; Wed, 30 Sep 2020 12:54:27 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date:   Wed, 30 Sep 2020 12:54:12 -0600
Message-Id: <20200930185422.11494-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930185422.11494-1-logang@deltatee.com>
References: <20200930185422.11494-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, sbates@raithlin.com, logang@deltatee.com, Chaitanya.Kulkarni@wdc.com, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.2
Subject: [PATCH blktests v2 01/11] common/fio: Remove state file in common helper
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of each individual test removing this file, just do it
in the common helper.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 common/fio     | 1 +
 tests/nvme/010 | 1 -
 tests/nvme/011 | 1 -
 tests/nvme/012 | 1 -
 tests/nvme/013 | 1 -
 5 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/common/fio b/common/fio
index 8bfad4238dda..94c65c107a14 100644
--- a/common/fio
+++ b/common/fio
@@ -181,6 +181,7 @@ _run_fio_rand_io() {
 _run_fio_verify_io() {
 	_run_fio --name=verify --rw=randwrite --direct=1 --ioengine=libaio --bs=4k \
 		--iodepth=16 --verify=crc32c "$@"
+	rm -f local*verify*state
 }
 
 _fio_perf_report() {
diff --git a/tests/nvme/010 b/tests/nvme/010
index 9d96d7803be3..0188e842213e 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -52,7 +52,6 @@ test() {
 	losetup -d "${loop_dev}"
 
 	rm "${file_path}"
-	rm -f local*verify*state
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/011 b/tests/nvme/011
index 06dc568fb6ea..543dbe840874 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -48,7 +48,6 @@ test() {
 	_remove_nvmet_port "${port}"
 
 	rm "${file_path}"
-	rm -f local-write-and-verify*state
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/012 b/tests/nvme/012
index 8110430e49d4..1dbd59804ed7 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -63,7 +63,6 @@ test() {
 
 	losetup -d "${loop_dev}"
 
-	rm -f local*verify*state
 	rm "${file_path}"
 	rm -fr "${mount_dir}"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 176b11b9ccb5..df7f23e69252 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -58,7 +58,6 @@ test() {
 	_remove_nvmet_subsystem "${subsys_name}"
 	_remove_nvmet_port "${port}"
 
-	rm -f local*verify*state
 	rm "${file_path}"
 	rm -fr "${mount_dir}"
 
-- 
2.20.1

