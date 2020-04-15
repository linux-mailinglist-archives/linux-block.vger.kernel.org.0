Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62081A988C
	for <lists+linux-block@lfdr.de>; Wed, 15 Apr 2020 11:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895413AbgDOJX3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Apr 2020 05:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895412AbgDOJXQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Apr 2020 05:23:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF91C0610D6
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2020 02:23:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so18071285wma.4
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2020 02:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BuJOZVsEd9h9dD9WNCH05BihJUfcD+XqHViZvcPGzLM=;
        b=Vv2BrChPQwTZ+TxYjq5broHmWleTf4t2LsEi2Hehh7s9Xc0ABJ568A6mElJju4ud9G
         Zby4yakzs+3DUzCzWrdBOWm3g0xYObBxiVNQ2j6S/O6/PJqvsl4lDlxxa4HKXapy2Jui
         Jvog4lGKrcUuXURHL2c542vse85byrgrgx2yt1njMEGv0xVq4H07E1TcUs/cb8BZQyH4
         XnnxfbN2sk2k3MAYhn3HPlbYrXXI/cizUXbAxJrWVTgMUYVMNuVS4s12cRT9OrCLhJ5l
         4eDMQIg0F3jUMLtF23jdd300jkwTvUPAVzdHJ/CoVhgRNLH7D28Vq1E6MbnaErYxdlAF
         EOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BuJOZVsEd9h9dD9WNCH05BihJUfcD+XqHViZvcPGzLM=;
        b=PZR53L2nIP/RHIS4xwmzO8qqV+uwau49oFfYsVzHWrn0+KIUF4gLrd3c/3h7fUD8vT
         TNvmB9MfMdOP9FgqBnxfJgwsjiHHgg/KfaynplGsUgg2ZwihKfTrFaCKTmbzhbTHqn1f
         K052HV5vWI6qefTrptpOikr81IyLsWKqRKzbq96MUjaax2xtj4LSdF3qlUaUwUsDkGet
         zF0wGA1eQFLrDubAW0MG17xk7A24A1OS2vXXd5Du/y+24DhEnaSyLo4O2GVBKMZcYfyz
         BVd3/H+VBRqjtwXa0xUlepWJy7aJS/0oAJt+KvxHamVE68sRoi/4yUAa69V9t6GtmuSg
         J++w==
X-Gm-Message-State: AGi0PubEPGfOftDOz53U7wbQVmh24pl5eHUt4gUIBQz62CPJZ95bMFBJ
        h9tkjShMqowcUSzSEk2v9EoPBSg7jeo9oGI=
X-Google-Smtp-Source: APiQypIXvZescO7vqyp81RXUb9OFCSOlrGc1HQysxYi1rzXdJRu6MzW92LvGp81F4q++72003/c7xQ==
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr4508468wmj.13.1586942594227;
        Wed, 15 Apr 2020 02:23:14 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-231-072.002.204.pools.vodafone-ip.de. [2.204.231.72])
        by smtp.gmail.com with ESMTPSA id v7sm22534615wmg.3.2020.04.15.02.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:23:13 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v12 23/25] block/rnbd: include client and server modules into kernel compilation
Date:   Wed, 15 Apr 2020 11:20:43 +0200
Message-Id: <20200415092045.4729-24-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Add rnbd Makefile, Kconfig and also corresponding lines into upper
block layer files.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/Kconfig       |  2 ++
 drivers/block/Makefile      |  1 +
 drivers/block/rnbd/Kconfig  | 28 ++++++++++++++++++++++++++++
 drivers/block/rnbd/Makefile | 15 +++++++++++++++
 4 files changed, 46 insertions(+)
 create mode 100644 drivers/block/rnbd/Kconfig
 create mode 100644 drivers/block/rnbd/Makefile

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 025b1b77b11a..084b9efcefca 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -458,4 +458,6 @@ config BLK_DEV_RSXX
 	  To compile this driver as a module, choose M here: the
 	  module will be called rsxx.
 
+source "drivers/block/rnbd/Kconfig"
+
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 795facd8cf19..e1f63117ee94 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX)	+= mtip32xx/
 
 obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
 obj-$(CONFIG_ZRAM) += zram/
+obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
 null_blk-objs	:= null_blk_main.o
diff --git a/drivers/block/rnbd/Kconfig b/drivers/block/rnbd/Kconfig
new file mode 100644
index 000000000000..4b6d3d816d1f
--- /dev/null
+++ b/drivers/block/rnbd/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config BLK_DEV_RNBD
+	bool
+
+config BLK_DEV_RNBD_CLIENT
+	tristate "RDMA Network Block Device driver client"
+	depends on INFINIBAND_RTRS_CLIENT
+	select BLK_DEV_RNBD
+	help
+	  RNBD client is a network block device driver using rdma transport.
+
+	  RNBD client allows for mapping of a remote block devices over
+	  RTRS protocol from a target system where RNBD server is running.
+
+	  If unsure, say N.
+
+config BLK_DEV_RNBD_SERVER
+	tristate "RDMA Network Block Device driver server"
+	depends on INFINIBAND_RTRS_SERVER
+	select BLK_DEV_RNBD
+	help
+	  RNBD server is the server side of RNBD using rdma transport.
+
+	  RNBD server allows for exporting local block devices to a remote client
+	  over RTRS protocol.
+
+	  If unsure, say N.
diff --git a/drivers/block/rnbd/Makefile b/drivers/block/rnbd/Makefile
new file mode 100644
index 000000000000..450a9e4974d7
--- /dev/null
+++ b/drivers/block/rnbd/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+ccflags-y := -Idrivers/infiniband/ulp/rtrs
+
+rnbd-client-y := rnbd-clt.o \
+		  rnbd-common.o \
+		  rnbd-clt-sysfs.o
+
+rnbd-server-y := rnbd-srv.o \
+		  rnbd-common.o \
+		  rnbd-srv-dev.o \
+		  rnbd-srv-sysfs.o
+
+obj-$(CONFIG_BLK_DEV_RNBD_CLIENT) += rnbd-client.o
+obj-$(CONFIG_BLK_DEV_RNBD_SERVER) += rnbd-server.o
-- 
2.20.1

