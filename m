Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98663EFB15
	for <lists+linux-block@lfdr.de>; Wed, 18 Aug 2021 08:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbhHRGIb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 Aug 2021 02:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbhHRGHc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:07:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A697C06114B
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:05:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so8249201pjr.1
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qoEKEQz6V+86Or8qeKX5Yf4kWfMbF2QL0Db0kr0lz4g=;
        b=WlAKi22Aaxd66aE7c+5MNAXbM8FHEvSvKzaUuHnR9khMLMSWG4+MoK+yl2AxzSeyBL
         0oOnLRoNLvr/TBkuuoRdc5S0LXzxct+MemC0GpBBq4/rob2GaI4AsUJyVBJ0Mi2qIHKU
         TK85IEQc1tX7BUJWo8e7hcKQC3q5yrO4G+IS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qoEKEQz6V+86Or8qeKX5Yf4kWfMbF2QL0Db0kr0lz4g=;
        b=PKTybTKa2/LOigvTWQHShIRrSpPJwbozLzo7DPo/R0OUW4mIHlPu1dSqhkvvL9cp0v
         luQ4WsYBDnxcSWW9REb7Z1hYPhxMqUuOSbdJ9Tuv61lDwqbgLcRE5lRxanR7WNTWZQXA
         UtfkMdwGKQc5qLllScEUnWVjIIQqpAnyntNCTf6Dr15FBBgwnGuNoaGdpVurbuym/WYR
         tR+o0JXNhebrz7hkXxQrpzfWGt86cIasff7+1ol2nlaeD6ZS6jG6S2VY0ZYEQaHJ2dUz
         As5yXSNO0PWlxxZmgA3KTHpkzsXeNNxiNxg03VrBswC2zC8wMRjW6mUAtLn+nh0rktHu
         j8gA==
X-Gm-Message-State: AOAM533xVxJJaYyJCWpc/Z6WKW1a01tCu65wFOWqcjjWDvotjoP4D+gT
        mGc+umkBbeabov3wiX7eJt+7yg==
X-Google-Smtp-Source: ABdhPJxpJFXNWAYeCCCFJZIlEATzNRZ2aSFGR938kI5Z+spsDKnKwOVP6z3feYwVg3UGuU+iIGtdmQ==
X-Received: by 2002:a17:902:a986:b029:12d:21a9:74e5 with SMTP id bh6-20020a170902a986b029012d21a974e5mr5948924plb.1.1629266758174;
        Tue, 17 Aug 2021 23:05:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t20sm2997336pgb.16.2021.08.17.23.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:05:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 14/63] cxgb3: Use struct_group() for memcpy() region
Date:   Tue, 17 Aug 2021 23:04:44 -0700
Message-Id: <20210818060533.3569517-15-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1772; h=from:subject; bh=dC6mcEspFz77gHbxWbBozA/2WMcBANzLR6HyJHBb8Uk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMgVl8joI0ywpJ0LBjKJdVvCciANpNIOWTCAd0k tQdZJNSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjIAAKCRCJcvTf3G3AJpJlD/ 94VIp465N4ZikuyhCqr9oOxy3hfC8wSJm8aVEwloaG01XD1LFCR8s27vmn7TaR3Onvi0mShPzxfZVp z/0QHutcgzRmdKNmqUJplk8jCLV/Ka51qcE6BTRvOMGquGDo2ct0ChYwMZDk1LMPNJ2jm64OPw5nKY y0crYHeld2bi9RXWQ+Ukx77u16N/RWqpwUyRVbAqD1S4Bdan5KxpbN5Xq0t50nCnvKAyIzHv9Nk/+s bLOdz5lavXExfcEWBkCycCMFlNEl2riJKH5C9yoaPdGxylxjbWhFDsGBeTnUOVoiCNnlTV9RdcJl3R s029/Oh4nOA1H+Vg7mE0DW/vIHISxFXQ702NKF0D8XG5CuW1PTI6qbzGffXYHTDzApNzS7NmjkFTJs qvjyLJeTlYxFgqXgwtjvR2JZMsu/QY2tSZGxcZ2t2Vot8PoU19q6BtLBv2htxt/A1VgnpntQz8w3T9 2g3JsgEdrrRmIRG0jtyJgCi968GluQnrByGPGL0PLPvgKluk4p/jLJDYvjZg6GaoB0zLXOy3sXtYYt nnmde30+gam1BpjliHZbYIEqoSqGNVd0iwK8Deo4DkRqqFVT7CfbSDCPFub2TYNvLMWHfrp/zvIIXS uVJup0qetCqvbanZgkYM4YYEZmZ41k/RQ1gFaZ/uMI2ZTumZZrqJt1PlHysQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct rss_hdr around members imm_data and intr_gen,
so they can be referenced together. This will allow memcpy() and sizeof()
to more easily reason about sizes, improve readability, and avoid future
warnings about writing beyond the end of imm_data.

"pahole" shows no size nor member offset changes to struct rss_hdr.
"objdump -d" shows no object code changes.

Cc: Raju Rangoju <rajur@chelsio.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/chelsio/cxgb3/sge.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/ethernet/chelsio/cxgb3/sge.c
index cb5c79c43bc9..1ab1bd86a3a6 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
@@ -126,8 +126,10 @@ struct rsp_desc {		/* response queue descriptor */
 	struct rss_header rss_hdr;
 	__be32 flags;
 	__be32 len_cq;
-	u8 imm_data[47];
-	u8 intr_gen;
+	struct_group(immediate,
+		u8 imm_data[47];
+		u8 intr_gen;
+	);
 };
 
 /*
@@ -929,7 +931,8 @@ static inline struct sk_buff *get_imm_packet(const struct rsp_desc *resp)
 
 	if (skb) {
 		__skb_put(skb, IMMED_PKT_SIZE);
-		skb_copy_to_linear_data(skb, resp->imm_data, IMMED_PKT_SIZE);
+		BUILD_BUG_ON(IMMED_PKT_SIZE != sizeof(resp->immediate));
+		skb_copy_to_linear_data(skb, &resp->immediate, IMMED_PKT_SIZE);
 	}
 	return skb;
 }
-- 
2.30.2

