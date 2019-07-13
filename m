Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 309B367710
	for <lists+linux-block@lfdr.de>; Sat, 13 Jul 2019 01:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfGLX55 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 12 Jul 2019 19:57:57 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60292 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbfGLX55 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jul 2019 19:57:57 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hm5QG-0004Oz-Dz; Fri, 12 Jul 2019 17:57:56 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hm5QE-0005uR-LE; Fri, 12 Jul 2019 17:57:50 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 12 Jul 2019 17:57:36 -0600
Message-Id: <20190712235742.22646-7-logang@deltatee.com>
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
Subject: [PATCH blktests 06/12] nvme/015: Ensure the namespace is flushed not the char device
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Flushing the char device now results in the warning:

   nvme nvme1: using deprecated NVME_IOCTL_IO_CMD ioctl on the char
	device!

Instead, call the flush on the namespace.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/015 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/015 b/tests/nvme/015
index 47e1b048e16d..ca1216163e16 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -39,7 +39,7 @@ test() {
 
 	dd if=/dev/urandom of="/dev/${nvmedev}n1" count=128000 bs=4k status=none
 
-	nvme flush "/dev/${nvmedev}" -n 1
+	nvme flush "/dev/${nvmedev}n1" -n 1
 
 	nvme disconnect -n "${subsys_name}"
 
-- 
2.17.1

