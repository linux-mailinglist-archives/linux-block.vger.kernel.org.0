Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3054A77D
	for <lists+linux-block@lfdr.de>; Tue, 14 Jun 2022 05:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350410AbiFNDTh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 13 Jun 2022 23:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350725AbiFNDTf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jun 2022 23:19:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BE12E69C
        for <linux-block@vger.kernel.org>; Mon, 13 Jun 2022 20:19:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e9so7340004pju.5
        for <linux-block@vger.kernel.org>; Mon, 13 Jun 2022 20:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7L8e1Wz/Bd9z7iLzaFmqZHzg9hGkFUKT87XneuMBC4s=;
        b=UXGxXFisJTDA5eg/7J+MzK1OfxHBFi3fX5Hr9jfiVqSYvKefez4KuMeV9V2EJcHwyS
         u0p2ak8L1LS9b0xqmMzO4boRwj+o88ckA/SQhGa0etdFy4Sb+OYvBc1GdtRO9SKYMoLV
         E/bBmZBENCoJN1eexVato9L4Ks2NmoR5u9fRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7L8e1Wz/Bd9z7iLzaFmqZHzg9hGkFUKT87XneuMBC4s=;
        b=qjg6qnmOPqqckojx60vl7quoyZLThT7ecgSBq0IVG/ftOMb6t9nFV9beIIPROPZPWG
         AsS+5SxUICQFHcC8YWQ4AIDYH8n2Ck7/DP5orIssuhVSKcXknftvu9y80bGl8yFbXwrJ
         XyquyKhW5WVeG+aDs6o5kcbrwf5hwB3i/sgTUjnFluwb+DWVzk3umGqn+dIPgMAOc5KV
         ch+hHTuLr+AFNjYYPytTslyBYBLt5O763sTcYAmBD/AeNI6TLxoharMPH6dKX9UioRC/
         gX8BfV7e7XEOOqFa+bBljVrX3mEe0Nk9rhE7oc8bJqGGgm/wzoqdK1GaI6UVXF8Sfup2
         zAgQ==
X-Gm-Message-State: AJIora8Gw2TgPECIFfDffdVZuhJWAJRdkrDp3u9IIqAzFBgTc2npvdAj
        ScDh/u86gZ033ljCHJDxCJKDag==
X-Google-Smtp-Source: AGRyM1vWB6bubOckC1eBAZ912PtyRJ9dDViWlYRgpIAHNDPo8sztccizLgEYqmphzjIE3Rz/945vWA==
X-Received: by 2002:a17:90a:c7cf:b0:1e8:2b77:7835 with SMTP id gf15-20020a17090ac7cf00b001e82b777835mr2163700pjb.109.1655176770633;
        Mon, 13 Jun 2022 20:19:30 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:580a:28cf:a82b:5610])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902650600b0015ee985999dsm5905819plk.97.2022.06.13.20.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 20:19:29 -0700 (PDT)
Date:   Tue, 14 Jun 2022 12:19:24 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        umgwanakikbuti@gmail.com, bigeasy@linutronix.de,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        regressions@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Nitin Gupta <ngupta@vflare.org>
Subject: Re: qemu-arm: zram: mkfs.ext4 : Unable to handle kernel NULL pointer
 dereference at virtual address 00000140
Message-ID: <Yqf+PC+cKePAsaNI@google.com>
References: <Yp47DODPCz0kNgE8@google.com>
 <CA+G9fYsjn0zySHU4YYNJWAgkABuJuKtHty7ELHmN-+30VYgCDA@mail.gmail.com>
 <Yp/kpPA7GdbArXDo@google.com>
 <YqAL+HeZDk5Wug28@google.com>
 <YqAMmTiwcyS3Ttla@google.com>
 <YqANP1K/6oRNCUKZ@google.com>
 <YqBRZcsfrRMZXMCC@google.com>
 <CA+G9fYvjpCOcTVdpnHTOWaf3KcDeTM3Njn_NnXvU37ppoHH5uw@mail.gmail.com>
 <YqbtH9F47dkZghJ7@google.com>
 <Yqdqfz4Ycbg33k1R@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqdqfz4Ycbg33k1R@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (22/06/13 09:49), Minchan Kim wrote:
> > Many thanks for the tests.
> > 
> > Quite honestly I was hoping that the patch would not help :) Well, ok,
> > we now know that it's mapping area lock and the lockdep part of its
> > memory is zero-ed out. The question is - "why?" It really should not
> > be zeroed out.
> 
> Ccing Mike and Sebastian who are author/expert of the culprit patch
> 
> Naresh found zsmalloc crashed on the testing [1] and confirmed
> that Sergey's patch[2] fixed the problem.
> However, I don't understand why we need reinit the local_lock
> on cpu_up handler[3].
> 
> Could you guys shed some light?

My guess is that it's either something very specific to Naresh's arch/config
or a bug somewhere, which memset() per-CPU memory. Not sure how to track it
down. KASAN maybe?

We certainly don't expect that

	static DEFINE_PER_CPU(struct mapping_area, zs_map_area) = {
	        .lock   = INIT_LOCAL_LOCK(lock),
	};

would produce un-initialized dep_map. So I guess we start off with a
valid per-CPU lock, but then it somehow gets zeroed-out.
