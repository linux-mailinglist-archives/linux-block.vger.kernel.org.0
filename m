Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353D13D5908
	for <lists+linux-block@lfdr.de>; Mon, 26 Jul 2021 14:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhGZLT0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 26 Jul 2021 07:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbhGZLTZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jul 2021 07:19:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E2EC061757
        for <linux-block@vger.kernel.org>; Mon, 26 Jul 2021 04:59:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id jg2so11136771ejc.0
        for <linux-block@vger.kernel.org>; Mon, 26 Jul 2021 04:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+zWE2pjVlI5xEn+MGzIEirIqnTc2Cgc7sV35sOC8mo=;
        b=VILVSCKXe/Jox2yw1cq+BG70NwE8LkrRegYxz9QSW+Vpuct5JAoiE15vuG0etoCP9k
         4xpORY7nAmoOAzo1SzAzN4DWhdOWT9ubMsJSu5uricYvlLzD5N0VDul2F0ep252mIEMU
         0wKyF40AtS9QPg/VkHFoMv5xQ78WCMXOTYPQItmJtf8jn1086XcAn/NCCgY12oYqc38P
         3VGQwcdlMBwwFoik3/l7cd6tk/+cY5mfoAX2tt0xj98D9UGiiukBXq6ow8V/dvP7gS6r
         9BI5qdhwDyWPJ/AR79jHsPLLQxVyfyItQzISQ1nOz8JxT62xInQgHH0l0k6Ue60mzgpx
         hiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+zWE2pjVlI5xEn+MGzIEirIqnTc2Cgc7sV35sOC8mo=;
        b=Iis+wSTu9WzbXBgmOvtX7tu2pqGOvJHIVzsNbOtW/FPL+WfBPRX9Gb6Wbu/Ds1XkLg
         u8uHxzaf2vd1HwmjyARCzbv6LiKZPqELA8hkEiIVd4pVF0KS0dig/O85WA5B1a8O+gni
         NUTo3fdfMCrBeMMciGqM4MwwkFLz7j+g4T6A4pibQSY7wuBt5wnDZkqs43E+kIhbBaEk
         wKlGT6OYy55m5eJ+s+r9+b4q9QhzP6EFHWFGjSUAJyNB0qeuK5j440T7iaHbuoozN43x
         2ZO3rX1AjwstPV8jswemEtcHuf4d2F7ig6t85H/ZVCcwPh1vZhR6aCoWMFN+O7TE2rdQ
         baZA==
X-Gm-Message-State: AOAM531ergiVgyvYBXvDxY4JQumEqvPy9+Luud4rwWTJ4zgQ7wsnjqX4
        xETAh2qFNWZm6Ggz1dX6z9IlwAjEFq6SVA==
X-Google-Smtp-Source: ABdhPJxBNPvFM1de94K2u5DzJ3b8yWtqJX8JsbOBoJab09XciLvmhqGyJXHutA8aXSth0jSZmKboYA==
X-Received: by 2002:a17:906:b209:: with SMTP id p9mr11636311ejz.395.1627300792570;
        Mon, 26 Jul 2021 04:59:52 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49ed:6f00:7449:2292:4806:d4e5])
        by smtp.gmail.com with ESMTPSA id y8sm731408eds.91.2021.07.26.04.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 04:59:52 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 1/2] block/rnbd-clt: Use put_cpu_ptr after get_cpu_ptr
Date:   Mon, 26 Jul 2021 13:59:49 +0200
Message-Id: <20210726115950.470543-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726115950.470543-1-jinpu.wang@ionos.com>
References: <20210726115950.470543-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@ionos.com>

This patch replaces put_cpu_var with put_cpu_ptr because
get_cpu_ptr should be paired with put_cpu_ptr.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index e9cc413495f0..bd4a41afbbfc 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -271,7 +271,7 @@ static bool rnbd_rerun_if_needed(struct rnbd_clt_session *sess)
 	 */
 	if (cpu_q)
 		*cpup = cpu_q->cpu;
-	put_cpu_var(sess->cpu_rr);
+	put_cpu_ptr(sess->cpu_rr);
 
 	if (q)
 		rnbd_clt_dev_requeue(q);
-- 
2.25.1

