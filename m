Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2907B3D7FA0
	for <lists+linux-block@lfdr.de>; Tue, 27 Jul 2021 22:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhG0U7F (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 27 Jul 2021 16:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhG0U7E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 16:59:04 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B78C061765
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 13:59:03 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ca5so1755499pjb.5
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 13:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3ykowIwDTRKsInbKYf/ek7DP95JkPgh9oE6DtLLi+A=;
        b=Kp+U9AytVp9BwbsLQj5AYOpg8DezjsG5/creX/t5fYRDEs7tszMAJwrDdgQwhZq/SR
         pfMuBhqfFlPx2fMK05Ry9tqtfPSV8v4DUZPulqrs+9s8Twz/vFSkAn2NBw8N2WvhGIZs
         I5L0NhknTsbo7S17qVe98S4vL28QINN1K21ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3ykowIwDTRKsInbKYf/ek7DP95JkPgh9oE6DtLLi+A=;
        b=t6yTPa5CP8DV60L5DgoajTlfjp1JowoWVt8iPycouECSxh5oMD2T4Wa2IftjwW3DDr
         4aLe56T8DN1E3z3xzpcQnlsZuRdXpGfYSZHv7w4hNK04pW3a9cBrv98v04bzU3DWW485
         57EMT32Kr+4MWbpIaJLdMgcUTNpR8Sf8oNjuy2uRoQZl9Ms/drTcminShKmyhWxiRJfk
         3hQY8aqosuyutS7/5a14hp8L/FSyl5Ig15qmUe7jaj7W69CmWZu3wItRFxIBo9cPu7jC
         4cBigHpQFx6ureKpnaj10G1Ayl4FGtRZMxhPrqjJcY0dPhPvWLWhsAoDl45FDxG0hA/z
         ZTdQ==
X-Gm-Message-State: AOAM532f9Cil/Kyy/GBNS8Qmw6+dhZ/hDJOjI5XJ3Owl4K5kV4sbimUA
        I8acG9Ecx7dutYyMelDfMGnIUw==
X-Google-Smtp-Source: ABdhPJwNHFDf+F+gUxt2yA1m1JnQqLEbNlnBfRoIoqlBir+Zo4XdTRlv/GVLC3WzAXlOzz8ixT2dzQ==
X-Received: by 2002:a65:4508:: with SMTP id n8mr25560399pgq.407.1627419542777;
        Tue, 27 Jul 2021 13:59:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g3sm4480039pfi.197.2021.07.27.13.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:59:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 03/64] rpmsg: glink: Replace strncpy() with strscpy_pad()
Date:   Tue, 27 Jul 2021 13:57:54 -0700
Message-Id: <20210727205855.411487-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814; h=from:subject; bh=CGejJDIBWoCTMrdLfdYOlKTt2khst8/bmsGsqzGrjiA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOAj+vEe7YcbCfgSji3keoTaHrI/ZHofnZ1HVRt kwNnps2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzgAAKCRCJcvTf3G3AJqZUEA CIcBP+l3BbFi7alvKzzPClmhyUHq9Qrd5uMRNKMY9XyV0NR/jnI8CoYhga76FZhbT+mDmv6EqlY2QS rhhfJ44Nv7YuNm8ADcxv6ICsgHYc6ExgMQ4gO83JrsqVUuNebi/HDrFNw7T4Z5c1/UUTlWpIwnqxs7 zwuIgbFRNhuxTlpAncpl+dPIlkv40KWXaiqTIR/FuXteCb0rHpAWPYMrJ3tXcDqBwzHtpYfAYbneQq NIhvmdPjcFi5GnKQBm9eTRP7/Xcjg+8Ve3GeZadiIqC14fSgnMgtIahIDXLyAD4WuxdSRQwG+lbGXR 16M20bodkEsvyiJfNZJQdqgyHsVt/eXqpuH1om13iF7+wTit6p8gEUfPMy/V38FyOTgjikr8am4k7A 23f/4W0+nt6mLLlDMXQtGC7TmA97UCqRJ+dNmiQMLuRljr6uD1DWUTS75HLcUjcWkIU1fBUYUi0DWk P/zazmIkeRAnFcJGwZf3zUXOErBqGPmnAav3Bok+zgtGP6JjxVaiFcJN+Dq/iIMuZ8gp1+kmma1GMv m/hLrzzRYpUJQyo2xNUAyVn6zzmEqA+jINb6SqBOUVg3sNfzZTRQkVA7NvmZp+LplR7Jw/n/+91q/6 pIUu/YH+PA+X/eemAshAw2isLrLbFZdRioKXBvLqtjcD2yGkNeO8ROQmebfA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The use of strncpy() is considered deprecated for NUL-terminated
strings[1]. Replace strncpy() with strscpy_pad() (as it seems this case
expects the NUL padding to fill the allocation following the flexible
array). This additionally silences a warning seen when building under
-Warray-bounds:

./include/linux/fortify-string.h:38:30: warning: '__builtin_strncpy' offset 24 from the object at '__mptr' is out of the bounds of referenced subobject 'data' with type 'u8[]' {aka 'unsigned char[]'} at offset 24 [-Warray-bounds]
   38 | #define __underlying_strncpy __builtin_strncpy
      |                              ^
./include/linux/fortify-string.h:50:9: note: in expansion of macro '__underlying_strncpy'
   50 |  return __underlying_strncpy(p, q, size);
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/rpmsg/qcom_glink_native.c: In function 'qcom_glink_work':
drivers/rpmsg/qcom_glink_native.c:36:5: note: subobject 'data' declared here
   36 |  u8 data[];
      |     ^~~~

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/rpmsg/qcom_glink_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 05533c71b10e..c7b9de655080 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1440,7 +1440,7 @@ static int qcom_glink_rx_open(struct qcom_glink *glink, unsigned int rcid,
 		}
 
 		rpdev->ept = &channel->ept;
-		strncpy(rpdev->id.name, name, RPMSG_NAME_SIZE);
+		strscpy_pad(rpdev->id.name, name, RPMSG_NAME_SIZE);
 		rpdev->src = RPMSG_ADDR_ANY;
 		rpdev->dst = RPMSG_ADDR_ANY;
 		rpdev->ops = &glink_device_ops;
-- 
2.30.2

