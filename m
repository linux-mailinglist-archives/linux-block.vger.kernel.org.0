Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4A41C3C1D
	for <lists+linux-block@lfdr.de>; Mon,  4 May 2020 16:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgEDOC2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 May 2020 10:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgEDOC1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 May 2020 10:02:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8DFC061A10
        for <linux-block@vger.kernel.org>; Mon,  4 May 2020 07:02:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so21091097wrx.4
        for <linux-block@vger.kernel.org>; Mon, 04 May 2020 07:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pQCniYLvJw1t2gFCRxCBobqn/8Zkqb7cqfvQGuESp0=;
        b=bZ8CiIkacJub0culTSIHmqdAfPPV274r0E6ADk0H/9YWY7vmZQBgL7msI17wtvGInu
         gHxdMMnS5uuTxQYsNe/FdWb/+/3HJV7E+246/V52Rmz2F+ciaAMluoeOzXYBvkMdsBd9
         UYaUUvrEKTq2TTwRk+P6Lap5NdKI7JRIS0Ve36BJhEI5dbQj+snWXAs+U7TJ3yjihiO6
         AKORE65ZtKYe4rMHZTMog8Eb0lpD0nLrxC8w9QbMiiTNBQNGYCblFPq2HT/6fgCwQ9CE
         oHyeiwf3Ce4m/+/lOYmMRie1FJciNOTmMAabEsHlG/fDGpJ2UIGvCEunyydI8VYXNgh3
         WOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pQCniYLvJw1t2gFCRxCBobqn/8Zkqb7cqfvQGuESp0=;
        b=l6dbyVjvMduyf5OnNrHaR2JscBR6oQs8p0AFLlJrHqtSLfkatcTBBFxcG/O7VbaYC7
         9yPkgae7T9+6G7SYkK6OxAs9w8gm5tsZFlYAlAG1hZS+Io51iRxLRj2U0oXdhVdiN1UL
         F5NxizAvfvnSGWfBTNr+R1pekHALLg+05a8yJuLi6dCNdUWBd9R5mHt+NWojqMSaIX2c
         bLgD6xg2jD238tigXylARHU40ET9mmnLmfkgEK+nGFd+Lqd0FAuVA7eknrupxkxoUl1F
         ugJSf0yq9QH3mPy5uMZHuF/Fr2kAlfGkYXWDWMIfwyOuFiFwVGqMqeva8aGyMTDw1KWG
         JRwA==
X-Gm-Message-State: AGi0Pub7MABQ5r8OU0cG5SPtiytsO7calIovDEaIniB/yXO4SklNqz50
        Tqq1pNkfXENK3QTvsMUjfOAlLt3bDc3DwCo=
X-Google-Smtp-Source: APiQypJsYUtNzRwfzxOYIe6xoDr/JATIV4Knbp1lAtCpim1+NTUsrYGEd6gkR0PRJFiDEegOEhe1Kw==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr7808740wrp.427.1588600945245;
        Mon, 04 May 2020 07:02:25 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id a13sm11681559wrv.67.2020.05.04.07.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:02:24 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v14 11/25] RDMA/rtrs: server: statistics functions
Date:   Mon,  4 May 2020 16:01:01 +0200
Message-Id: <20200504140115.15533-12-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
References: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This introduces set of functions used on server side to account
statistics of RDMA data sent/received.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
new file mode 100644
index 000000000000..e102b1368d0c
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
@@ -0,0 +1,38 @@
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
+	struct rtrs_srv_sess *sess = stats->sess;
+
+	return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
+			 (s64)atomic64_read(&r->dir[READ].cnt),
+			 (s64)atomic64_read(&r->dir[READ].size_total),
+			 (s64)atomic64_read(&r->dir[WRITE].cnt),
+			 (s64)atomic64_read(&r->dir[WRITE].size_total),
+			 atomic_read(&sess->ids_inflight));
+}
-- 
2.20.1

