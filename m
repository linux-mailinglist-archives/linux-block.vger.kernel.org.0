Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861C653500F
	for <lists+linux-block@lfdr.de>; Thu, 26 May 2022 15:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiEZNgK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 May 2022 09:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiEZNgJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 May 2022 09:36:09 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817B9D9E88
        for <linux-block@vger.kernel.org>; Thu, 26 May 2022 06:36:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o10-20020a17090a4e8a00b001df2fcdc165so4470715pjh.0
        for <linux-block@vger.kernel.org>; Thu, 26 May 2022 06:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y1ZHCc6xNO0U73whru3kCBTDHIP9p4rXtSNp3afIMD8=;
        b=KdRKDCFGAtjWtyuddQOjMrITCNVaocp7i+0/GFQnwGty9rVgYvh+rbmyuK26PIAv3c
         gkYMPztmvClmArM4lRY8ekPkB3fuu3jwWR+CBaMKnJZZQqi/Yad6ZtpmHOpw+UMeikrp
         2rqylks1mOWSW9vcNddUCSnlXEpA1qfshm81ynv2M9+jLj2w+YF4lGkHd8IjCqdDQrdy
         IxWXRETgsiwKVPWpI5evm6YzJRHn0LLmcZHgIv7zfmVVJWHxhYEjdv1gQJOhp1r4Sug/
         x1cBQlqhSK0NQjjbp6GcstpykI93/cxxfD2A4GCYv6aOAFshAJrkjw4gD/kZoJf/MNSm
         BHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y1ZHCc6xNO0U73whru3kCBTDHIP9p4rXtSNp3afIMD8=;
        b=M18Nq3y10x1ol8SvT9JuD7MP1mrEwq7YOodwCfZSciNZeAgbs8jsBxW96wTIDFYlFG
         BEKDNPwRoFUe5E56yfV4pVvPlTOtSZJKiGSuj7M3933D1BtP4z3JKG//kMPgRD7+UlZ3
         9zUyz+9zh3SXT2LM8E5T8BJ24enLTaaeileLs46q13tjQLA+K1PoAtfbDOCd0o26nhdr
         DbOvITrW90KQXRDRhgfMiFVaiMaKQjqAuw0A+hw/YVcOJCAtX+flJoFHgGxbiGSF3+xK
         toDsfDPWhiY9F7hsS6m0rHaUHFdNBAKqmXHBrZEDdiisLwxNCIJ2gy8vQtsJMAj6TcMN
         JYBg==
X-Gm-Message-State: AOAM533eLXm+/BwuNCtm+POJE7H52iRv9l5gur3ykKyIx7+2x+1jNPo7
        kBRZRD6cJwPyaj2RgTIiftcLBg==
X-Google-Smtp-Source: ABdhPJzadwTNEqbf2/nS04B6qn8DPyWmRbTYUVYX+TpInXl9V8aylkBa9fpPl4zxmpL1j22HhoxIcQ==
X-Received: by 2002:a17:902:6bc1:b0:15d:1e15:1a75 with SMTP id m1-20020a1709026bc100b0015d1e151a75mr38992126plt.114.1653572166012;
        Thu, 26 May 2022 06:36:06 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id v1-20020a170902b7c100b0015e8d4eb290sm1522067plz.218.2022.05.26.06.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 06:36:05 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] blk-iocost: fix false positive lagging
Date:   Thu, 26 May 2022 21:35:54 +0800
Message-Id: <20220526133554.21079-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I found many false positive lagging during iocost test.

Since iocg->vtime will be advanced to (vnow - margins.target)
in hweight_after_donation(), which called throw away excess,
the iocg->done_vtime will also be advanced that much.

       period_at_vtime  <--period_vtime-->  vnow
              |                              |
  --------------------------------------------------->
        |<--->|
     margins.target
        |->
  vtime, done_vtime

If that iocg has some inflight io when vnow, but its done_vtime
is before period_at_vtime, ioc_timer_fn() will think it has
lagging io, even these io maybe issued just before now.

This patch change the condition to check if vdone is before
(period_at_vtime - margins.target) instead of period_at_vtime.

But there is another problem that this patch doesn't fix.
Since vtime will be advanced, we can't check if vtime is
after (vnow - MAX_LAGGING_PERIODS * period_vtime) to tell
whether this iocg pin lagging for too long.

Maybe we can add lagging_periods in iocg to record how many
periods this iocg pin lagging, but I don't know when to clean it.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 33a11ba971ea..42e301b7527b 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2259,7 +2259,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 		    time_after64(vtime, vdone) &&
 		    time_after64(vtime, now.vnow -
 				 MAX_LAGGING_PERIODS * period_vtime) &&
-		    time_before64(vdone, now.vnow - period_vtime))
+		    time_before64(vdone, ioc->period_at_vtime - ioc->margins.target))
 			nr_lagging++;
 
 		/*
-- 
2.36.1

