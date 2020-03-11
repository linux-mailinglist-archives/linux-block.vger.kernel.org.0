Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F162181D60
	for <lists+linux-block@lfdr.de>; Wed, 11 Mar 2020 17:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgCKQNI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Mar 2020 12:13:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53258 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbgCKQND (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 12:13:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id 25so2733664wmk.3
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2020 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m3W51qWfJyjyKFgtUG71wjO8XZXSgVEBRmSLLElBsdc=;
        b=XICYYwIwHmBJgw/Q+xGj6MnRlh4DsOIhQTwVptGCyPa9P+9QvF1nEnTtoAcZST9yFS
         6kJ7hNAck2c1U3tOWoORuRMPE1QbFkXdxZAsmWVGF0/jDwZYKecU5DVOjZ2SSK65cwjW
         Kr6AJTZosAV9WKxCnox5JY6wlrkWOh7ThYquQqI1wMsYBEOzrXt1EQkZi3aEkCKoNc1S
         nioMoAwqWtCaCJQdfFrPGmGLskNF8HBQcYcPsyTtExEkki+lT/rI+LvdtUMpTxYb33oL
         hhWdiW0iW5aE8w2k7pL2Vyww3IH6ZzC22hiO8DvwDY2jGtlA4Kfs5xwx59f4raRiciP1
         FThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m3W51qWfJyjyKFgtUG71wjO8XZXSgVEBRmSLLElBsdc=;
        b=Me2N959sjSZwq3emThIYDntzwG7FPYQ2y1xchWpuAfpv6Vr12FxKeOBRRVmOjoKaU7
         llcT/Xbk/BoONtk6YuyGev9T6PTlfgj3tgn+7uIcbsMaanpr/Ye44+oBtA95VqbSkSep
         P8VXYxN5wYpe1vSR6Y6PR8u/+f8Si+s2Zx3iTyaaTrXO2bdPBMYqKxzRf1cT8PaRajDL
         2KxR0+tG1pWScexuNrmYWfOnKQobrRikKTXZ3fIvJHMnaNeLW1mk2tpfhm1SORF3LcXV
         BwuT8ksefetwXBsXdP0xKgC8Dbj86q5jfhCdlnRNPn/7bn2b+BKO8EXykKHs0pdSXemg
         TZfA==
X-Gm-Message-State: ANhLgQ39d6lDMRpxW9fh0KKVi5FUNAQ4ascSwCRB+sBgHD0FMItftGda
        I5vGs5sn8ckddvLoaM97+y5GGwagonI=
X-Google-Smtp-Source: ADFU+vvx9hX8k1e06vwzRssTO05hOUSFnuspj+4rCMmj9nVGaJWDOusRYqmutSwCsaJ/yoNADXxUHA==
X-Received: by 2002:a1c:e442:: with SMTP id b63mr4527095wmh.174.1583943180376;
        Wed, 11 Mar 2020 09:13:00 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4963:f600:4938:8f65:9543:5ec9])
        by smtp.gmail.com with ESMTPSA id v13sm2739332wru.47.2020.03.11.09.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 09:12:59 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v10 11/26] RDMA/rtrs: server: statistics functions
Date:   Wed, 11 Mar 2020 17:12:25 +0100
Message-Id: <20200311161240.30190-12-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
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

