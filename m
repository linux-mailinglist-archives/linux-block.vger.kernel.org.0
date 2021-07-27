Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448C23D80C5
	for <lists+linux-block@lfdr.de>; Tue, 27 Jul 2021 23:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhG0VHg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 27 Jul 2021 17:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhG0VHD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 17:07:03 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2408C0617A5
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:06:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so6654646pjb.3
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAjc7jN8mF2lxOocjxYUs8uk4UIdg9BIVyN6yKZHmUw=;
        b=Ik3f6gOvQpeLuCM/En5JJmwMGhnVmhecqCsKjDJ2odwR3b/OtNzLiyoeOTeu9TpBj2
         /OaEnt7Z40ngSvFECb51CKe1Mrq/TscdrX+6sxtX8ZJ679XmXcxAcgkm85bGnl2v4XsX
         BNB53x5u/LQy29sMxiNlUWB84NzJJ44Lw+SoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAjc7jN8mF2lxOocjxYUs8uk4UIdg9BIVyN6yKZHmUw=;
        b=JV79Pyo7vTuElw9LNsts0JcrwazKvnMxbeNduZsBbc8XOt+5sQIpwrlwfMNqPzqbvK
         2vGMeFftOjuYF34TBZ/E12oC26LRGh/ZTVYKsaEeyVAK5e2MGEDXFiwdysWkXI2k4T/f
         Vs0D0m6ISlOPPQ/vC/QKeXkcmuIZOEzfGVm6j8+jMuqkZInplcPPk+4i/TEFJrH1z+Hv
         sqfVV2Yu4x1DDHAdqYvM8uMGiOf5H1rmmy1839a+uWrF2+tssAZId2SWgrXzAZwb6N1d
         /2nb0hwxnW33SwEdckn5imx0hLe0G0XgsL5ieVwr/7jGghuDEtNrR8Ux93YoMftJjRce
         tnWg==
X-Gm-Message-State: AOAM531iPph3ZTX6usD407Pg/aS37sUB0Wt8dq6PSJB3XlWysK9cDIHZ
        4aO2RaSpU4yQBEvdw6Kx3j3hVw==
X-Google-Smtp-Source: ABdhPJzTyWnyJkM2fI4o+nQh75gG0gKQnAIhyupMsjyxw0lo+I3SNPw8cSYvp7EuMi65u5YL90cSkg==
X-Received: by 2002:a63:190b:: with SMTP id z11mr25001094pgl.320.1627420019329;
        Tue, 27 Jul 2021 14:06:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i1sm4395555pfo.37.2021.07.27.14.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:06:55 -0700 (PDT)
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
Subject: [PATCH 38/64] xfrm: Use memset_after() to clear padding
Date:   Tue, 27 Jul 2021 13:58:29 -0700
Message-Id: <20210727205855.411487-39-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608; h=from:subject; bh=g0VWO37QK3XIcvkgv5p13lDa7YD+Jvxsuneh5al+DKo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOIQmnrWwAaxPVdj8lblXkb8ZdEI/mjJwkI9weg Jb9tdxuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBziAAKCRCJcvTf3G3AJkUiD/ 9GVAFoJywTVZLGJMfv82icJWJQRMDO1fnyc7Vo6lQ1D7/W+Dagrov588jsfphYxw9bCcMrBW5+ML39 Nlw0d86SRJKsp9W1D/uWpxT7B+ZifwMCrBQiW/QQdugvpBK16DiM/nuIxmvvNngfCD7TZeYhnxyJCN Q8sbUMZx2T8aExzVPglAhsAqyZAACXNIyRAkJJKyEFCtk5DV7xNyz4H7EIco1PaNQ6CPSvz3qtegIn nv2P2319IG2VLE3I2NZVINSDUfhFT63odWJElKoysAbPDvrq3781fUtYESiohGHqBR8FD3BGT+O8y5 9KD6fIZ0TSLsD63axSBtgp5OUer7kr086Bp7sU1ndEXv436bquzOxnCxGOOZ82tsCGeW/VxkIdKzGd IqrtSepbn6JZoMYp10wQJpM6ZcvscK8K2zcp2RMRpDMku/9dFd2GQ45TO3uUh94594qJDdQG0ecNlA NIP+5MnO4vD6X6sONnGwoom7JbHdfvLOAg4vRaXZ2jfmckTzxmeUil4NB16b45RGMUUNbmfDrGgLJc 0oHx1OYHLUpyYpWBvqH49SivknOgZOZzXIyabXPipERmCdfnqRmLJeBYq67aP5IvRZgUVF848zQS1a wYduCIDFnUzR+Pq8e8OGT0DcZ9ZGKEr3Av8YeNoVe5GpEviziiQ3/Fj3WyIg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Clear trailing padding bytes using the new helper so that memset()
doesn't get confused about writing "past the end" of the last struct
member. There is no change to the resulting machine code.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/xfrm/xfrm_policy.c | 4 +---
 net/xfrm/xfrm_user.c   | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 37d17a79617c..1a06585022ab 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2486,9 +2486,7 @@ static inline struct xfrm_dst *xfrm_alloc_dst(struct net *net, int family)
 	xdst = dst_alloc(dst_ops, NULL, 1, DST_OBSOLETE_NONE, 0);
 
 	if (likely(xdst)) {
-		struct dst_entry *dst = &xdst->u.dst;
-
-		memset(dst + 1, 0, sizeof(*xdst) - sizeof(*dst));
+		memset_after(xdst, 0, u.dst);
 	} else
 		xdst = ERR_PTR(-ENOBUFS);
 
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index acc3a0dab331..0bf8fec3fd97 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2907,7 +2907,7 @@ static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct
 	copy_to_user_state(x, &ue->state);
 	ue->hard = (c->data.hard != 0) ? 1 : 0;
 	/* clear the padding bytes */
-	memset(&ue->hard + 1, 0, sizeof(*ue) - offsetofend(typeof(*ue), hard));
+	memset_after(ue, 0, hard);
 
 	err = xfrm_mark_put(skb, &x->mark);
 	if (err)
-- 
2.30.2

