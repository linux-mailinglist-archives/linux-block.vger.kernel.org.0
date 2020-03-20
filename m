Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C73F18CDB4
	for <lists+linux-block@lfdr.de>; Fri, 20 Mar 2020 13:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgCTMRe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Mar 2020 08:17:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54913 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgCTMRd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 08:17:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id f130so5066742wmf.4
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2020 05:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bFZMoThFPsHK0B7YajbqOi+az87fjoCNRv6x74L1yQw=;
        b=CQs5Bq3WWrQuFLOTCfweqIOZK6LYpFcKBNJV1fPelMp1NbzPQhwu39Wed2N+H/hL5e
         Bg/E4JY1yIijeKSZs5rSpaSgpB8bacBw/S+t5RTksym0EWqmpGCnUj13fJN0ACVW9X42
         SqaF1Gq+hurfNoQ/KEWYLbUkGYSJZm42HbF9BX2NPESP6ssHqMcC/ZwAaY7dlP8dSr3G
         go3GyuW4EOBe35kJU8DlGZkeH/YwnVagSn4/QYydRsxAYJk6aXskjEEt0lvezrx18ADV
         WvdLdvvP8oUhmaF6bGCYDHScwReWcbCXtbP765aPzrs5ZJh3C9maDev5UBR1loWSDYpM
         Q1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bFZMoThFPsHK0B7YajbqOi+az87fjoCNRv6x74L1yQw=;
        b=id9ugHvnzTwwqmkb1VGukKYdqFGiS0VclVK5D5mgyvurN4J6DTpsQHIOaX8PzB6gje
         wKLwCPxlJubZXT3FIpxaSJKSgZTvGS8T4JieWZSma5FOlzxYOdEpdBJlxqBV5juF3+mH
         qkxGET1iN3XLXJ1d+IGiSD8F9V2RNkiU+JLnOtD6iMy7WMdvVguks7/ALHhMrFAjlXMJ
         HSZgpJoZU+LmeSOO0/ig/UtQM5GGr1EOkZ4GTVnMrbIKasMMMm2CnLqTQiyCTW2yaKVD
         bn4L6KAp8jn6O0vyLsIFYgGXK1CyRqN06b5bokJDxR5ulyLj5r3aU3LrqlURtUa8OW8H
         j4kg==
X-Gm-Message-State: ANhLgQ2F5dXIgaSTUvTnZ/f9xAFoEO+dg9ULk5lMBSpGm8aj7vNGlefZ
        FaCA6+DM5DKO1LwENhwldm2nSCHjr44=
X-Google-Smtp-Source: ADFU+vvy9y4pHVjdtwuhVb/qH/tuRXg6uzZWN7MPW/x6cbdpAEaDxBHDGYqKcCOPm5q0umM5b0aTmg==
X-Received: by 2002:a1c:f213:: with SMTP id s19mr9797760wmc.116.1584706651917;
        Fri, 20 Mar 2020 05:17:31 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4927:3900:64cf:432e:192d:75a2])
        by smtp.gmail.com with ESMTPSA id j39sm8593662wre.11.2020.03.20.05.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:17:31 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v11 20/26] block/rnbd: server: private header with server structs and functions
Date:   Fri, 20 Mar 2020 13:16:51 +0100
Message-Id: <20200320121657.1165-21-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This header describes main structs and functions used by rnbd-server
module, namely structs for managing sessions from different clients
and mapped (opened) devices.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rnbd/rnbd-srv.h | 77 +++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-srv.h

diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
new file mode 100644
index 000000000000..27cbcb86bc38
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -0,0 +1,77 @@
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
+#include "rtrs.h"
+#include "rnbd-proto.h"
+#include "rnbd-log.h"
+
+struct rnbd_srv_session {
+	/* Entry inside global sess_list */
+	struct list_head        list;
+	struct rtrs_srv		*rtrs;
+	char			sessname[NAME_MAX];
+
+	rwlock_t                index_lock ____cacheline_aligned;
+	struct idr              index_idr;
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
+	struct kobject                  dev_sessions_kobj;
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
+	struct completion		*sysfs_release_compl;
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
+
+#endif /* RNBD_SRV_H */
-- 
2.17.1

