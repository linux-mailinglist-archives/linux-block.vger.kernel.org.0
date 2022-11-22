Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A573633DF1
	for <lists+linux-block@lfdr.de>; Tue, 22 Nov 2022 14:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiKVNnQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Nov 2022 08:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiKVNnN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 08:43:13 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AD032B8E
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 05:43:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bs21so24786648wrb.4
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 05:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KF3CZXuQwHBE4nlGvTbysgbhQTbuB3zQD8B/JpHaOzg=;
        b=Cbx7zn11EQehMM+81fn1VToCqdvNlnjLXq36xiSGojRY4l/t8KeOuqmgNPSFjh09S4
         f/4yjE67gsK/CFRgOSP0pL/8N+IHCAR0NVN9MCiq1aNMEqps0/lzg9/FIfgMCzHY/azH
         tqMu57sNswPfw1RKchHVhiLaxK1POke5vckhvWHje6LHsMcqhWn7Qd7NxidBNcNOpgOn
         J8DLQ2mg60qgLy351jlgSEPilGpsEhJasu9kc4rJHZW8aaYIWJdM9npuoGPfWj6+SXM2
         KcpGLp/W0SkFnOjbgqahbRrxXAQ+KUu0be+Iklv7EALyEIfLxDQOPJYz0wQCtZbPSqN6
         0nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KF3CZXuQwHBE4nlGvTbysgbhQTbuB3zQD8B/JpHaOzg=;
        b=O4buJEuQ2P193q80ho2u5+GuvfZVtiOPtuWWSgkEZEgAMMwo6NAATXeP6Ziccgq7Kf
         790sCkJBPGoqQhexza3832kJiViSq7pEKCvQcwKFcUAtpM/yrNGoL9uwpYFZ2d2PcUKV
         SawsCCScMrRo2etJms1LMEWyMMJ+yKNuMrqCIzEwmT4S6IR4ZDFQIGluumTbGco46kJA
         PewZ6LV14J3J6+m3kL/yGwmkNeWf8pwFI0kFZdS9+wPpKGyl+RKz+15/ncT4Pl2yvp/O
         sbclby8lKEKRBvRFxBro7khh61iyz3mXW+AbBmVK4guIoYKa3dKQERN4yxauF3BSxLwg
         HQIQ==
X-Gm-Message-State: ANoB5pnc90XEsL5gVWPeiY+7o+QcbhkzPVe5Q3/g19d3XnHVezyW/PNR
        sSVKaFxuGslCsQZ5sVQdgv5CbA==
X-Google-Smtp-Source: AA0mqf6N8cSjyb9zLCCmraBEhwm6rbiQsxbk/2HHlEM4qAz7dNe9e2uU4VCUO8pYvYUKWaMUzn/CSg==
X-Received: by 2002:a05:6000:1192:b0:241:e7a6:9135 with SMTP id g18-20020a056000119200b00241e7a69135mr661925wrx.641.1669124591378;
        Tue, 22 Nov 2022 05:43:11 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id p6-20020a1c5446000000b003b47e75b401sm21437729wmi.37.2022.11.22.05.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:43:10 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 1/4] lru_cache: use atomic operations when accessing lc->flags, always
Date:   Tue, 22 Nov 2022 14:42:58 +0100
Message-Id: <20221122134301.69258-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
References: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Or, depending on the way locking is implemented at the call sites,
some updates could be lost (has not been observed).

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 lib/lru_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index dc35464216d3..fec899386238 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -364,7 +364,7 @@ static struct lc_element *__lc_get(struct lru_cache *lc, unsigned int enr, unsig
 	struct lc_element *e;
 
 	PARANOIA_ENTRY();
-	if (lc->flags & LC_STARVING) {
+	if (test_bit(__LC_STARVING, &lc->flags)) {
 		++lc->starving;
 		RETURN(NULL);
 	}
@@ -417,7 +417,7 @@ static struct lc_element *__lc_get(struct lru_cache *lc, unsigned int enr, unsig
 	 * the LRU element, we have to wait ...
 	 */
 	if (!lc_unused_element_available(lc)) {
-		__set_bit(__LC_STARVING, &lc->flags);
+		set_bit(__LC_STARVING, &lc->flags);
 		RETURN(NULL);
 	}
 
-- 
2.38.1

