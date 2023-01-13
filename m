Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D366A669797
	for <lists+linux-block@lfdr.de>; Fri, 13 Jan 2023 13:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbjAMMpT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 Jan 2023 07:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241765AbjAMMnJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2023 07:43:09 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0529988DC5
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 04:35:48 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id fy8so51881045ejc.13
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 04:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8mQ1DNdko28cUxvjVBwoXrO008ZDGIG0DMI/J1nWT4=;
        b=spZ9bBE74IdXZvFGyhmamqe/1SDBwGLUSQcAXBhiwbLOeW5LdETOuSw5m+TSnCduvh
         i1dq8pBx80HiBAQcGyxEY7bGUwTu7HGxSxh5IVd2vJJzbwTudnAkAOm1FZMZACIgnAUG
         LJFOsRpwpphyUe8m9LlCxV+VWqB3hnbrDjtKvi8zr4L8jJ7bq1yM+6S8hSkauyzAELBb
         h8cwpFX/WD9jR0CJed2lXICxX6+pQu+9OhUREJogH4PvwJZEDLXjcm1ihM0rQwzO7Ya5
         859r3Uyiovs6+qkiWv/7Wy163pJ4VOkBZlrkbGWRu9MdVP8K0Q7Rt7so9rV00GVCbZko
         T0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8mQ1DNdko28cUxvjVBwoXrO008ZDGIG0DMI/J1nWT4=;
        b=AE466KiJ+lsSvo3pQmULup0M8GW+wXQMS1e9qt13FjMhSB9EbCn4Zx4ebQsFSSzvIK
         yvmAlgrGH2Uu6YTdgCH3FjEsHTX4F0OEdVR1MZtMv0XyMvxM0T7/TRZHDPMa40yvSmHM
         B921E0tjBY54G9QWm2n3GojroJgo9LmdKB/Lw3QJCmMOdqWp315IKm8lAwEuD/zI79qm
         SKijHoy4FO1afx4meYi1/NpfetragOdvIubZJcscjXN+QjCzLH+5zJjk3SC/6VhusoWS
         9mZror5z0tdwIckI/G/D9yFQOlkD/uHHCEwFJpBtUWz11P8krRlGkrI3M+uEw/L/T/f9
         be/Q==
X-Gm-Message-State: AFqh2kqOwSmS3dvZgdzTgW0KsHZPYZmhn7Ibe7sgb7gw7Hui4GNi1vgH
        9/lHVVSD1xBdDnbRHc2xmQQzig==
X-Google-Smtp-Source: AMrXdXsjRgGq/XdmuiDTy/O+NIzOeI0x1b11hX7Z1ViInZBjrvxvNGqtTAecfa6o7Iznz1GQ/tHnaQ==
X-Received: by 2002:a17:907:7f22:b0:869:c5a4:e1a7 with SMTP id qf34-20020a1709077f2200b00869c5a4e1a7mr4493526ejc.62.1673613319454;
        Fri, 13 Jan 2023 04:35:19 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906201200b00846734faa9asm8386323ejo.164.2023.01.13.04.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:35:19 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 1/3] drbd: split off drbd_buildtag into separate file
Date:   Fri, 13 Jan 2023 13:35:04 +0100
Message-Id: <20230113123506.144082-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230113123506.144082-1-christoph.boehmwalder@linbit.com>
References: <20230113123506.144082-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To be more similar to what we do in the out-of-tree module and ease the
upstreaming process.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 drivers/block/drbd/Makefile        |  2 +-
 drivers/block/drbd/drbd_buildtag.c | 22 ++++++++++++++++++++++
 drivers/block/drbd/drbd_main.c     | 18 ------------------
 3 files changed, 23 insertions(+), 19 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_buildtag.c

diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index c93e462130ff..67a8b352a1d5 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-drbd-y := drbd_bitmap.o drbd_proc.o
+drbd-y := drbd_buildtag.o drbd_bitmap.o drbd_proc.o
 drbd-y += drbd_worker.o drbd_receiver.o drbd_req.o drbd_actlog.o
 drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
 drbd-y += drbd_interval.o drbd_state.o
diff --git a/drivers/block/drbd/drbd_buildtag.c b/drivers/block/drbd/drbd_buildtag.c
new file mode 100644
index 000000000000..956a4d5c339b
--- /dev/null
+++ b/drivers/block/drbd/drbd_buildtag.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/drbd.h>
+#include <linux/module.h>
+
+const char *drbd_buildtag(void)
+{
+	/* DRBD built from external sources has here a reference to the
+	 * git hash of the source code.
+	 */
+
+	static char buildtag[38] = "\0uilt-in";
+
+	if (buildtag[0] == 0) {
+#ifdef MODULE
+		sprintf(buildtag, "srcversion: %-24s", THIS_MODULE->srcversion);
+#else
+		buildtag[0] = 'b';
+#endif
+	}
+
+	return buildtag;
+}
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 7213ffd69a16..345bfac441da 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3776,24 +3776,6 @@ _drbd_insert_fault(struct drbd_device *device, unsigned int type)
 }
 #endif
 
-const char *drbd_buildtag(void)
-{
-	/* DRBD built from external sources has here a reference to the
-	   git hash of the source code. */
-
-	static char buildtag[38] = "\0uilt-in";
-
-	if (buildtag[0] == 0) {
-#ifdef MODULE
-		sprintf(buildtag, "srcversion: %-24s", THIS_MODULE->srcversion);
-#else
-		buildtag[0] = 'b';
-#endif
-	}
-
-	return buildtag;
-}
-
 module_init(drbd_init)
 module_exit(drbd_cleanup)
 
-- 
2.38.1

