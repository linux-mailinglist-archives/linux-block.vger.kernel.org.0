Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5198335BBD5
	for <lists+linux-block@lfdr.de>; Mon, 12 Apr 2021 10:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbhDLINU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 12 Apr 2021 04:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbhDLINT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 04:13:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77755C061574
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 01:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tpiViasTP3h3Z5SnmA2Wpk6Kw40U+CypP15POJv1EkI=; b=xSmu7Nrn5x1YCKXGjlZRyRXZW6
        M3bXvttjnGA/jB0EAHRFSitijaLx1w5nfGBhSW7QHH6rVPZOVYlIS6FHK0n042CDmXb0Aw8saxylk
        xJDgXfiDOm99ImYxXXrgeZZg+5xW9QQGX4i8LYyKrZ3+Wp+N3TKdRDx4wnPnRYpJiFhOmjUtoI2RA
        KIuwRoIZpVeYrf96Jmr5NcWvHPQ2AwSpSkOeCtRXn7jghIVYuO5ive7CTF34r/mI0I3VKlJ3EidLI
        gQ/q0AjaVCo/QX+jIfOyYgI77EWzU3Vh9hQg8p4VScObf4nVtO40hy8dc8RVAP560VmRJjp7AvAtr
        GNp6mo2A==;
Received: from [2001:4bb8:199:e2bd:3218:1918:85d1:2852] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVrgp-005xln-EX; Mon, 12 Apr 2021 08:12:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     mb@lightnvm.io, axboe@kernel.dk, javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH] lightnvm: deprecated OCSSD support and schedule it for removal in Linux 5.15
Date:   Mon, 12 Apr 2021 10:12:57 +0200
Message-Id: <20210412081257.2585860-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Lightnvm was an innovative idea to expose more low-level control over SSDs.
But it failed to get properly standardized and remains a non-standarized
extension to NVMe that requires vendor specific quirks for a few now mostly
obsolete SSD devices.  The standardized ZNS command set for NVMe has take
over a lot of the approaches and allows for fully standardized operation.

Remove the Linux code to support open channel SSDs as the few production
deployments of the above mentioned SSDs are using userspace driver stacks
instead of the fairly limited Linux support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/lightnvm/Kconfig | 4 +++-
 drivers/lightnvm/core.c  | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
index 4c2ce210c1237d..04caa0f2d445c7 100644
--- a/drivers/lightnvm/Kconfig
+++ b/drivers/lightnvm/Kconfig
@@ -4,7 +4,7 @@
 #
 
 menuconfig NVM
-	bool "Open-Channel SSD target support"
+	bool "Open-Channel SSD target support (DEPRECATED)"
 	depends on BLOCK
 	help
 	  Say Y here to get to enable Open-channel SSDs.
@@ -15,6 +15,8 @@ menuconfig NVM
 	  If you say N, all options in this submenu will be skipped and disabled
 	  only do this if you know what you are doing.
 
+	  This code is deprecated and will be removed in Linux 5.15.
+
 if NVM
 
 config NVM_PBLK
diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 28ddcaa5358b14..4394f47c81296a 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1174,6 +1174,8 @@ int nvm_register(struct nvm_dev *dev)
 {
 	int ret, exp_pool_size;
 
+	pr_warn_once("lightnvm support is deprecated and will be removed in Linux 5.15.\n");
+
 	if (!dev->q || !dev->ops) {
 		kref_put(&dev->ref, nvm_free);
 		return -EINVAL;
-- 
2.30.1

