Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 551CA18CDA2
	for <lists+linux-block@lfdr.de>; Fri, 20 Mar 2020 13:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgCTMRU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Mar 2020 08:17:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55456 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCTMRU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 08:17:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so6258786wmi.5
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2020 05:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m3W51qWfJyjyKFgtUG71wjO8XZXSgVEBRmSLLElBsdc=;
        b=aF0OqHZxcqM+dLvgZ5cKD0DU9swaE/lTzLJp85tUu7L+wSvKLjH5oc0o90US6a0Cx8
         JF/gJOfO3jOEtaQ4Z0sUEfflGymCt0nw6NPtwHkC4+xFLJlg2VQ5Upz/kNy5oUBu7WRT
         CLCySS9p/9oA5THNOw+mGyoVuh0FByAE3MSfz/3o4aqc1OEBpcfEmoCq0HTwaNmHcJTf
         FbT8LmSvhaptfo37oQOZX4G4jSL+S0g3eyHyenfdyOi7zHPVCUAQr0/VaoFbefDYk+vJ
         agpHmW5gvIj1YGOZCcOX2a3HwY/B/l4a5db4AzzdhKPq9e3Gj1QUpfZCP+03MUvg2vK6
         P34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m3W51qWfJyjyKFgtUG71wjO8XZXSgVEBRmSLLElBsdc=;
        b=qsFuMzy4EB1k+x6nJfofFILn+ho0mIYMHHre85GQacJkSkSf7i3/ZTK97LkIj4O2U8
         YVAAlOUwSczdElKL6N/XtJOPExsDvyoiZ0HQ39JenKl0qyJUGYCZ3St81Hl8lClxNIR8
         2QTrkhyuFOFu574a4WMDTbxgZaUayrU1JuE4XiI9ZhisCKjTE1VuKO6zIG7IZif3R0Sx
         jul8bLtQQTwqk9v1rggn1EUhvs9y2ZvfUbsPYMbAx1exoL6mznl1qGOVXsTCluRjyKfo
         1KxUmClDrZ03vd4mQMr8Tpiu9BNd7TjswOVDcsOC7KzjU3okihJxl2xMOgjeNYBm7yHA
         qyjw==
X-Gm-Message-State: ANhLgQ1TwdL4hsRByP85rVlaZfr5lzK3PFowWCDX12wuWGqXsckx7Ngx
        S8Q6VrPXqjdmwvhN78HArB7UOGELOQM=
X-Google-Smtp-Source: ADFU+vtG57maNxLlWypW43Lx0ZUECBTYAP5ps4gFrvsTbLC/e5cHX4MJUd8JFsXVYRGIHwyTwuEqrg==
X-Received: by 2002:a05:600c:22c5:: with SMTP id 5mr9599717wmg.24.1584706638257;
        Fri, 20 Mar 2020 05:17:18 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4927:3900:64cf:432e:192d:75a2])
        by smtp.gmail.com with ESMTPSA id j39sm8593662wre.11.2020.03.20.05.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:17:17 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v11 11/26] RDMA/rtrs: server: statistics functions
Date:   Fri, 20 Mar 2020 13:16:42 +0100
Message-Id: <20200320121657.1165-12-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This introduces set of functions used on server side to account
statistics of RDMA data sent/received.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 40 ++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
new file mode 100644
index 000000000000..e9eb87d81ec5
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RDMA Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include "rtrs-srv.h"
+
+int rtrs_srv_reset_rdma_stats(struct rtrs_srv_stats *stats, bool enable)
+{
+	if (enable) {
+		struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
+
+		memset(r, 0, sizeof(*r));
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
+				    char *page, size_t len)
+{
+	struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
+	struct rtrs_srv_sess *sess;
+
+	sess = container_of(stats, typeof(*sess), stats);
+
+	return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
+			 (s64)atomic64_read(&r->dir[READ].cnt),
+			 (s64)atomic64_read(&r->dir[READ].size_total),
+			 (s64)atomic64_read(&r->dir[WRITE].cnt),
+			 (s64)atomic64_read(&r->dir[WRITE].size_total),
+			 atomic_read(&sess->ids_inflight));
+}
-- 
2.17.1

