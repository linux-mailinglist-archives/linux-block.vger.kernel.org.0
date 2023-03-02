Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCAE6A82D7
	for <lists+linux-block@lfdr.de>; Thu,  2 Mar 2023 13:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjCBMz3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 2 Mar 2023 07:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCBMz2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 07:55:28 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9D583D7
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 04:55:27 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u9so17691122edd.2
        for <linux-block@vger.kernel.org>; Thu, 02 Mar 2023 04:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1677761725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54k/F/kd1jw+ZRVo2rfRXmr6Q0n6AeiP/4wU154+q3M=;
        b=DiYufgsNUoUuET376YLirzNgz4MVoF9JGtbOLkgT9k9ZJD35xX57JvfCvzvTT7g+BM
         2VMDCUs2GtxDAM0nBW6VRfnbt9NmMM58l2kJ+BNWAxLG4I7dRVN4MAw5/XZWjRMPZ3YR
         to1KACqfwGfqC8mvdRQ6Vpu7XE7ULLgmMLBUoQWJKc8WQ5Wc65+kkPNBwwveSN9Zl6dA
         KYI1BuagHWj57GzPc96lXU2WqQD3Zrsh9+jiotUGPmBTJdrlIx4Erqv8XW4a6JaFsDyO
         0E+Wo4giVsNhttMqArV20tgQaWpNYnv4T7C8+hqwiBc+WI+iWL7hbbPUlGJm2MsCYW4A
         SLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677761725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54k/F/kd1jw+ZRVo2rfRXmr6Q0n6AeiP/4wU154+q3M=;
        b=J1mfoJoL84wT3MPvHtpIRXYqkDTX0lyhIu6NIPc+aF8x2xUOVx0X9Sc7xczyOIRofL
         oJGzbnx0JfayYABaf3vEYRxuXwYKJcEjG+TpdIcvGHzriM2ABS+kBFrwRDolQMRMXmIw
         rrsTqT3MiorwJbhdOFtLZ/W8cyXhB9iQCzX44ue5TQQ0rkRhsoZF9Osts+tQLNc0iKKq
         es2+6jnrKwdW/PV1zrArPxq35pmjk+2dgVbM/c4rOMQMskZywbJgrbZ3OX6ai1Yfnt71
         9q6ykDJZVQsyLC7sMrLu+ER8MCrBUI8om76KRgAAq90OGxsFHvQb/uutPXR2DK4zqaTT
         nIXg==
X-Gm-Message-State: AO0yUKUlcBvnebQE6DD489AXa0OSp/htqE282qwzOqZFZmS9G/99pXwM
        nN1rzHI2IFV2zVc44J2xXbj9zA==
X-Google-Smtp-Source: AK7set/8pIVyuXgKoQRPGW3GjFFjUmIZqdaOxXk1X6aOFM5g3/5F089uBAXT394Gy23mPnOOYs6zpg==
X-Received: by 2002:a17:906:468d:b0:8b1:353a:2636 with SMTP id a13-20020a170906468d00b008b1353a2636mr11122371ejr.14.1677761725603;
        Thu, 02 Mar 2023 04:55:25 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id a98-20020a509eeb000000b004ad601533a3sm6955034edf.55.2023.03.02.04.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:55:24 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH v2 1/7] genetlink: make _genl_cmd_to_str static
Date:   Thu,  2 Mar 2023 13:54:39 +0100
Message-Id: <20230302125445.2653493-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302125445.2653493-1-christoph.boehmwalder@linbit.com>
References: <20230302125445.2653493-1-christoph.boehmwalder@linbit.com>
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

Primarily to silence warnings like:
warning: no previous prototype for 'xxx_genl_cmd_to_str' [-Wmissing-prototypes]

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 include/linux/genl_magic_func.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/genl_magic_func.h b/include/linux/genl_magic_func.h
index 4a4b387181ad..2984b0cb24b1 100644
--- a/include/linux/genl_magic_func.h
+++ b/include/linux/genl_magic_func.h
@@ -209,7 +209,7 @@ static int s_name ## _from_attrs_for_change(struct s_name *s,		\
  * Magic: define op number to op name mapping				{{{1
  *									{{{2
  */
-const char *CONCAT_(GENL_MAGIC_FAMILY, _genl_cmd_to_str)(__u8 cmd)
+static const char *CONCAT_(GENL_MAGIC_FAMILY, _genl_cmd_to_str)(__u8 cmd)
 {
 	switch (cmd) {
 #undef GENL_op
-- 
2.39.1

