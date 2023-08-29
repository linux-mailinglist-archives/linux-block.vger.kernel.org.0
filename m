Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2A578BB38
	for <lists+linux-block@lfdr.de>; Tue, 29 Aug 2023 00:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjH1Wxv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 28 Aug 2023 18:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjH1Wxc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Aug 2023 18:53:32 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE3E11A
        for <linux-block@vger.kernel.org>; Mon, 28 Aug 2023 15:53:29 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7a29ef55d5fso1340240241.3
        for <linux-block@vger.kernel.org>; Mon, 28 Aug 2023 15:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693263209; x=1693868009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rPp/OBCbyvFuIsHpW2W/8NQ9YGESVReCdBvNabrZPc=;
        b=PmlCkaLnq/9d+ZnDSOIUY8W62gfd1Q4PDaWiXBTWNtBqBxYKE0gyPz8TTHoby2nbd2
         hw7d1NxYT8IfYsrUgaU4vmdj7yC/f37TtpJKdoKKajqtzT0PxJFhfWfiVvqLdcj36VyQ
         zzRd+gduere0MLd8tVzamhFXpcsOpDoWyG8ITbEttncN9w/gQYVubKGK6R/hk9enDdVc
         KuoAasgQXK6fWagBTZNNNPYuiwZM1ErU/dzEuhbMpEdWCSepeH1B2Sd8lVyra99gSHqa
         AmBGiUfY/IrrFEybNYJsSUxFjFyL5vyEQd09jeisfTE7jMdZ5P+gMQZwwcOt4qBalOEt
         3NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693263209; x=1693868009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rPp/OBCbyvFuIsHpW2W/8NQ9YGESVReCdBvNabrZPc=;
        b=hp/ZMdsSIMOin4H2Kps27phsMSvy7hRkbAXmHUOMQ04esAZGNmwHFAxrMjxccr3Qh6
         xvCXW20XXl+Wgsi6Md89vgeB6mX27944HJoXjxM+fwU5Jf508g/d8btmB7J7nAk1ZuOD
         cPcLpqBO9SQOnNyy3dTuYDTqdX33r6/N2+mTobF5hFkk3G2hLOJnas/A/tFb6otBgKys
         lf5I8Ula+gVadzrOmmVeLmxnTuABROgjNnZbCS2mwJupTZqPQlFO7eVK2aVx3IR/eMfK
         OyvQZ3Pho2vv4mQT0fEKbfyzB8lDKUHiWS2A35gMqrPWmuXhoP1wNBFO+yYu/vJx01VF
         DFjA==
X-Gm-Message-State: AOJu0Yxxb/spJ8c6vd3GyV1BHfxV6x00iKaOLEv9GtTB5Y7E6iY9CGzj
        fR3vbZOQvI/wyPhHc/s3/qTPb16rYD5BtdGOiVuJqg==
X-Google-Smtp-Source: AGHT+IGrZ5DKqPE2cjwP21nhG3fcsE8gMLdq/0yZ6jUtdfaFjIXOh1d5/lBcvYIomLGq7Sd4rp173jQCHPoyaeaI+uM=
X-Received: by 2002:a67:fb49:0:b0:44e:8e28:284f with SMTP id
 e9-20020a67fb49000000b0044e8e28284fmr11952083vsr.18.1693263208813; Mon, 28
 Aug 2023 15:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230828153142.2843753-1-hca@linux.ibm.com> <20230828153142.2843753-2-hca@linux.ibm.com>
 <ZO0j3M8KFWeEznXy@google.com>
In-Reply-To: <ZO0j3M8KFWeEznXy@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Aug 2023 15:53:17 -0700
Message-ID: <CAKwvOd=MG6KdE9fTGBV317s9-RkjcUWednkC1akpODGE2iuvgQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] s390/dasd: fix string length handling
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        =?UTF-8?B?SmFuIEjDtnBwbmVy?= <hoeppner@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, nathan@kernel.org,
        llvm@lists.linux.dev, David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 28, 2023 at 3:46=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Aug 28, 2023 at 05:31:42PM +0200, Heiko Carstens wrote:
> > Building dasd_eckd.o with latest clang reveals this bug:
> >
> >     CC      drivers/s390/block/dasd_eckd.o
> >       drivers/s390/block/dasd_eckd.c:1082:3: warning: 'snprintf' will a=
lways be truncated;
> >       specified size is 1, but format string expands to at least 11 [-W=
fortify-source]
> >        1082 |                 snprintf(print_uid, sizeof(*print_uid),
> >             |                 ^
> >       drivers/s390/block/dasd_eckd.c:1087:3: warning: 'snprintf' will a=
lways be truncated;
> >       specified size is 1, but format string expands to at least 10 [-W=
fortify-source]
> >        1087 |                 snprintf(print_uid, sizeof(*print_uid),
> >             |                 ^
> >
> > Fix this by moving and using the existing UID_STRLEN for the arrays
> > that are being written to. Also rename UID_STRLEN to DASD_UID_STRLEN
> > to clarify its scope.
> >
> > Fixes: 23596961b437 ("s390/dasd: split up dasd_eckd_read_conf")
> > Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
>
> Thanks for the patch! Nathan just reported a bunch of these. I took a
> look at these two and thought "yeah that's clearly a bug in the kernel
> sources." Fix LGTM.
>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1923
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Meant to add:

Tested-by: Nick Desaulniers <ndesaulniers@google.com> # build

>
> I also like David's idea of passing `char ident [DASD_UID_STRLEN]`, too,
> but I don't feel strongly either way.



--=20
Thanks,
~Nick Desaulniers
