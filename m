Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C576CF2CB
	for <lists+linux-block@lfdr.de>; Wed, 29 Mar 2023 21:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjC2TKR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Mar 2023 15:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjC2TKQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 15:10:16 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7990010F
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 12:10:15 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 5so5082429qky.5
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20210112.gappssmtp.com; s=20210112; t=1680117014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvuwFXbgUAZbOJPeg//uwBjMCt7EFsCpzym2Ulfy8+Y=;
        b=ebtARkhWyJHfb4xtYmoYLGrX90kc/jqbKsnTc1bFtUGbeXJTTtNSjWPR/37szx/txC
         HSK5H/HTOxvPW/DiblqMtvOIpwMd8KJMsw1Yrs44z/1hzgwbP/BeOHDbFz5apnBTrbpL
         9xMWAlkZ1hlrdu7JYlxAnGZu2sdiaP5L9M6tuvAqST9HmN+Xo8ZbZPu1cbZH2fDDxMMp
         RNR0rco3qMLpRaOrC4bpW4AixtA46YIItjBLMPwTA2K4hehu6SOF4jHGMGoJSREa9atw
         /D43mJK5uSjS3KTSTM7H4HFaxALEIBTlBWYpk56E7grKxlsje3B5HOWznCjKAZqya0AN
         Wgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680117014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvuwFXbgUAZbOJPeg//uwBjMCt7EFsCpzym2Ulfy8+Y=;
        b=Ba7UMHkQiKp4CzNw3dQ8szhFx3h9kjUV8VgRdmFXiTy8k+8dDUO7I3DBIF98kR11p1
         RL6VrfFc3qUXgBnGuAsHrqOPqOQ2fdHX0MFk63WQMPJAAHN3u01n1llqNXrrtDf30xFs
         7WuwCMnPQsklj08fiw4oBpnyYmf/nhgbEqTxh+A66qnEFfAa/ATmesK0AfLIj2wbppbs
         VbXltMje3uUY57i5JcEMeYJpb9qz5YzAl69zJNaGjUC0bYxbM8yyLSQpd5EIVZPBKirg
         oh4roMJA2fhLHfzd3/fGpkasSihanEdXszng2eTmKbDPCyfDO0xCRFkUFDWU8vQDKeGu
         M3Vw==
X-Gm-Message-State: AO0yUKWfz6ZW8E/4cU9LuHdlbAp1P5BAEYODuxMISWSuVkG6aG6SsyBp
        BjNd9rZobtQnNWARg9fk6Qzecq6dghe+HpCkjcXeGg==
X-Google-Smtp-Source: AK7set/Yb2wuao9kPPFNja0Rt/lA/InUM3qkLAM9YZSn3q+PyxYrIVFQqkC65KODw3TvQ6tAHSedKs/4ZupBKHOYc20=
X-Received: by 2002:a05:620a:4154:b0:745:32ab:4d2a with SMTP id
 k20-20020a05620a415400b0074532ab4d2amr4017411qko.14.1680117014615; Wed, 29
 Mar 2023 12:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230328112716.50120-1-p.raghav@samsung.com> <CGME20230328112718eucas1p263dacecb2a59f5fce510f81685f9d497@eucas1p2.samsung.com>
 <20230328112716.50120-3-p.raghav@samsung.com> <ZCMF+QjynkdSHbn0@casper.infradead.org>
 <970b8475-a52e-9adc-65cf-5a95220bd35b@samsung.com>
In-Reply-To: <970b8475-a52e-9adc-65cf-5a95220bd35b@samsung.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Wed, 29 Mar 2023 15:10:03 -0400
Message-ID: <CAOg9mSRqNJUmKWaAkZZ_h1T_n1PDN2oPGHfH0z+vfGTUZD=Yow@mail.gmail.com>
Subject: Re: [PATCH 2/5] orangefs: use folios in orangefs_readahead
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Matthew Wilcox <willy@infradead.org>, martin@omnibond.com,
        axboe@kernel.dk, minchan@kernel.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, senozhatsky@chromium.org,
        brauner@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        linux-mm@kvack.org, devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I thought telling you that I tested it was good :-) ...

Please do put a tested-by me in there...

-Mike

On Tue, Mar 28, 2023 at 12:02=E2=80=AFPM Pankaj Raghav <p.raghav@samsung.co=
m> wrote:
>
> On 2023-03-28 17:21, Matthew Wilcox wrote:
> > On Tue, Mar 28, 2023 at 01:27:13PM +0200, Pankaj Raghav wrote:
> >> Convert orangefs_readahead() from using struct page to struct folio.
> >> This conversion removes the call to page_endio() which is soon to be
> >> removed, and simplifies the final page handling.
> >>
> >> The page error flags is not required to be set in the error case as
> >> orangefs doesn't depend on them.
> >>
> >> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> >
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >
> > Shouldn't Mike's tested-by be in here?
>
> I mentioned that he tested in my cover letter as I didn't receive a Teste=
d-by
> tag from him.
