Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA721CDC01
	for <lists+linux-block@lfdr.de>; Mon, 11 May 2020 15:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgEKNxd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 11 May 2020 09:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730274AbgEKNxc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 09:53:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0ABC05BD0B
        for <linux-block@vger.kernel.org>; Mon, 11 May 2020 06:53:32 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so18093760wmj.3
        for <linux-block@vger.kernel.org>; Mon, 11 May 2020 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVBhZt03wXB09SQpaisoaWTctJpSMvKx9AU5bhdDfRw=;
        b=ReMV/SpSB6rvFd0U3X8IC6wyiDwPyjAJnFo8aPMNq/TpdHtkGqavofGDB6urACaR1j
         v8GxdgTYiIIWzmR3gugZAwUA7WigyM64rop3dN+Fbs1xyHk/L8f7D0tayvXIgtOwSMN9
         vQBDarpb30HcYyXe+DeVtO72PTqY72d8L2rZPAknaXi/po3+p71I8GGHWyierVCrOIfQ
         LBy5Vp+4cf3TMpYyGpUgFnJLwjIaoBiTECqIYXcainNVspsEUsaL9xDNFhsc4kJeSjeM
         oVZ/0YECiyiE2Ac2XkKuddED3tUwBAcnQ3aQv2wR9d+zuPGBYoHorE02eY0HQrUyNr3v
         079Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVBhZt03wXB09SQpaisoaWTctJpSMvKx9AU5bhdDfRw=;
        b=UlCmmm0yex4kaMv6YmC4WmznIwcqpdjqjxN7e4/xoyZ7IONQL2r5hdZybIL4cFMQbO
         /TCDqHhzU3mfUdk3pdKsO4PJLo2wG9hruNRp5obLJl3yQCuTJERLYRtum659jQXGCK0J
         KRnh/90orxC4VAPA/pBiBR3BmSg4kZHZqSj0kg/i6RfFXqdnIgoM9+n9BSbHJxRssLqV
         liobDFqywM1TeEx3pDX93bVXqPnpBxsgGh2sr04DlPHEPoHoeoGqUXLJa4fUDPa5wybr
         z/HB/X7z041w8oRsov11P24EOaMbAJgJgRPgGIiRm4qJCg0Nu5kgC1KFknY0MLm7bkA/
         H1Rg==
X-Gm-Message-State: AGi0PualEEhMcg6RLshofWVZpr/7Y6JXtMrU/yK8Ex3hiaVJWufrgGIG
        Y3mzk4Hq2C3TtfXJn0O0V8xFfEBsJ9dCvAw=
X-Google-Smtp-Source: APiQypLOO/9z6VnBMGS3rYPkhjo0ZtNtMLOvyES2xasmy9FiZYqHmSBnF4up56Zd7N81icEB5XDCDg==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26mr30340979wmb.127.1589205210533;
        Mon, 11 May 2020 06:53:30 -0700 (PDT)
Received: from dkxps.local (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id v205sm9220018wmg.11.2020.05.11.06.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:53:29 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v15 19/25] block/rnbd: server: private header with server structs and functions
Date:   Mon, 11 May 2020 15:51:25 +0200
Message-Id: <20200511135131.27580-20-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
References: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This header describes main structs and functions used by rnbd-server
module, namely structs for managing sessions from different clients
and mapped (opened) devices.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rnbd/rnbd-srv.h | 78 +++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-srv.h

diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
new file mode 100644
index 000000000000..5a8544b5e74f
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+#ifndef RNBD_SRV_H
+#define RNBD_SRV_H
+
+#include <linux/types.h>
+#include <linux/idr.h>
+#include <linux/kref.h>
+
+#include <rtrs.h>
+#include "rnbd-proto.h"
+#include "rnbd-log.h"
+
+struct rnbd_srv_session {
+	/* Entry inside global sess_list */
+	struct list_head        list;
+	struct rtrs_srv		*rtrs;
+	char			sessname[NAME_MAX];
+	int			queue_depth;
+	struct bio_set		sess_bio_set;
+
+	struct xarray		index_idr;
+	/* List of struct rnbd_srv_sess_dev */
+	struct list_head        sess_dev_list;
+	struct mutex		lock;
+	u8			ver;
+};
+
+struct rnbd_srv_dev {
+	/* Entry inside global dev_list */
+	struct list_head                list;
+	struct kobject                  dev_kobj;
+	struct kobject                  *dev_sessions_kobj;
+	struct kref                     kref;
+	char				id[NAME_MAX];
+	/* List of rnbd_srv_sess_dev structs */
+	struct list_head		sess_dev_list;
+	struct mutex			lock;
+	int				open_write_cnt;
+};
+
+/* Structure which binds N devices and N sessions */
+struct rnbd_srv_sess_dev {
+	/* Entry inside rnbd_srv_dev struct */
+	struct list_head		dev_list;
+	/* Entry inside rnbd_srv_session struct */
+	struct list_head		sess_list;
+	struct rnbd_dev			*rnbd_dev;
+	struct rnbd_srv_session		*sess;
+	struct rnbd_srv_dev		*dev;
+	struct kobject                  kobj;
+	u32                             device_id;
+	fmode_t                         open_flags;
+	struct kref			kref;
+	struct completion               *destroy_comp;
+	char				pathname[NAME_MAX];
+	enum rnbd_access_mode		access_mode;
+};
+
+/* rnbd-srv-sysfs.c */
+
+int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
+			      struct block_device *bdev,
+			      const char *dir_name);
+void rnbd_srv_destroy_dev_sysfs(struct rnbd_srv_dev *dev);
+int rnbd_srv_create_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev);
+void rnbd_srv_destroy_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev);
+int rnbd_srv_create_sysfs_files(void);
+void rnbd_srv_destroy_sysfs_files(void);
+void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev);
+
+#endif /* RNBD_SRV_H */
-- 
2.20.1

