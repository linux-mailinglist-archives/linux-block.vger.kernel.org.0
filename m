Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96F372D739
	for <lists+linux-block@lfdr.de>; Wed, 29 May 2019 10:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfE2IE4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 May 2019 04:04:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33580 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2IE4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 04:04:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so3761435wmh.0
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 01:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EBIy8akgJJVzGMeoN5L9X2jn2x1GxoKHTkHoU0+i4ZQ=;
        b=HfhL8wqCiookSl50jiJuT1YB5TlSuMeuNrqU2tWcfEUtEQ/AmjA+cvuYkaVQ4gKcHN
         wSRpxcuZF/NNGH2Y5MLanq3MH+ekyD5LIGY1quGY/RW5R5wx60RM2QX8PBTXSjr2f0LE
         GrSfel5vdtBCsk+50onjqOuy0SlHUJmcYWNmZ+DBqkKeGydvzo7ncC0b4i0ZsrazeUrf
         deHnMa1fNBN0eEKOkh+v4Ss0TZu+V2tywk5KUFTt/qlnJ5I7ACVuMx3DbtH06LlW1z78
         GWgSB5/zjVexZBSTTMUPM0xJTUHJ53ZnuNkmkf6Oq1DG3cc4TV4/F0AGW1Mtw4DTfMaA
         KOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EBIy8akgJJVzGMeoN5L9X2jn2x1GxoKHTkHoU0+i4ZQ=;
        b=WM2WvrqimJ5sMn9gFSsm+9fNmkoG6bUUDTC42nm4p+ahEJaAUG8CPLgtVaS7JJSEyL
         fth5o3/mnh3xo0VgRRuW9EvgUttJyIYytdm2VWW23myjEhHbSWY4ZksRwnn01+8G/h1T
         /GkBixCrzm/qNEmhIsPITXg3pa0BLudzh9uXwsKEKsJQiYH1ifPHkdh4MGgOZJCBkGhU
         n25gJnt4rriydeXwR3E8K8C0uGnArlwqKjT/dEmB7iVNi8sXRHlU9X5zmsPUxTrV9dkH
         jAKZBkKf21VDdfJ0IzLia8f8MnGPRDyWyr8IP5Rsvhjnv3GkQWRSpYdqAgMU+k8A524P
         mcow==
X-Gm-Message-State: APjAAAVljc/7p2BEn3bNAd0Xu59DbEyG9auagFHZo4/OWlhsN1QhAJyf
        6uNwiJgnTEbdtxCtwprIB8WGWw==
X-Google-Smtp-Source: APXvYqxVQa+Y+auwZsalqmIXIrSP2DzX25u2YHdLtGqKGkI2wS47Xd0Zk+TI/HfX1YOt5NBkbVB2tg==
X-Received: by 2002:a7b:c8c1:: with SMTP id f1mr5434256wml.159.1559117094718;
        Wed, 29 May 2019 01:04:54 -0700 (PDT)
Received: from localhost (ip-89-177-126-215.net.upcbroadband.cz. [89.177.126.215])
        by smtp.gmail.com with ESMTPSA id u9sm3165755wme.48.2019.05.29.01.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 01:04:53 -0700 (PDT)
Date:   Wed, 29 May 2019 10:04:52 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Igor Konopko <igor.j.konopko@intel.com>,
        David Howells <dhowells@redhat.com>,
        "Mohit P . Tahiliani" <tahiliani@nitk.edu.in>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Joe Perches <joe@perches.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] [RFC] devlink: Fix uninitialized error code in
 devlink_fmsg_prepare_skb()
Message-ID: <20190529080452.GE2252@nanopsycho>
References: <20190528142424.19626-1-geert@linux-m68k.org>
 <20190528142424.19626-6-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190528142424.19626-6-geert@linux-m68k.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Tue, May 28, 2019 at 04:24:24PM CEST, geert@linux-m68k.org wrote:
>With gcc 4.1:
>
>    net/core/devlink.c: In function ‘devlink_fmsg_prepare_skb’:
>    net/core/devlink.c:4325: warning: ‘err’ may be used uninitialized in this function
>
>Indeed, if the list has less than *start entries, an uninitialized error
>code will be returned.
>
>Fix this by preinitializing err to zero.
>
>Fixes: 1db64e8733f65381 ("devlink: Add devlink formatted message (fmsg) API")
>Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>---
>I don't know if this can really happen, and if this is the right fix.
>Perhaps err should be initialized to some valid error code instead?

0 is correct here.
Acked-by: Jiri Pirko <jiri@mellanox.com>

Thanks!

>---
> net/core/devlink.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/core/devlink.c b/net/core/devlink.c
>index d43bc52b8840d76b..91377e4eae9a43c1 100644
>--- a/net/core/devlink.c
>+++ b/net/core/devlink.c
>@@ -4321,8 +4321,8 @@ devlink_fmsg_prepare_skb(struct devlink_fmsg *fmsg, struct sk_buff *skb,
> {
> 	struct devlink_fmsg_item *item;
> 	struct nlattr *fmsg_nlattr;
>+	int err = 0;
> 	int i = 0;
>-	int err;
> 
> 	fmsg_nlattr = nla_nest_start_noflag(skb, DEVLINK_ATTR_FMSG);
> 	if (!fmsg_nlattr)
>-- 
>2.17.1
>
