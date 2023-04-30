Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E6B6F2AFA
	for <lists+linux-block@lfdr.de>; Sun, 30 Apr 2023 23:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjD3VrM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 30 Apr 2023 17:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjD3VrL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Apr 2023 17:47:11 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC1E51
        for <linux-block@vger.kernel.org>; Sun, 30 Apr 2023 14:47:08 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54fc94476e2so25318797b3.1
        for <linux-block@vger.kernel.org>; Sun, 30 Apr 2023 14:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1682891227; x=1685483227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CCBo9acX629wUTWbYgO6PJPSdCs1aVlP/Jra4BC8lc=;
        b=R+x/59M9qp8UonQFB6yAJM9fzbeBnIqbkZs3BiwzW+izc3wrD+66D3BSwauSYZj7s2
         y98b78TC+/YzvW4g0sl7IWQO1GHyn+bzNn7OfaSNjDTVd7bdVjVY2NPV0R4zfoQn0I/S
         FRcp8Uh1n+i+Ycr8zPmu9oXPBGNcTSW1r5b0aVlpt+Y5nAKfH8q4nnS78XIJJfofgsaB
         yZiGFXuO2EvWOGQDl53MiiqKlZUGP34PXRrVnI0vSxQXKJyMH3dvLFnvLPBEpmRt7F1b
         GlQbS05GxIgml0nPQmZ985G1VMQ7KklWFdJ6k4Y0V/1Cu3Ra1C4yFBJeF9WKO3MsbRR0
         U4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682891227; x=1685483227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CCBo9acX629wUTWbYgO6PJPSdCs1aVlP/Jra4BC8lc=;
        b=hk5BR4wl5FJNxbMMnTVtGgDEbeX6wFGX7cMMVKFLxEUeXGEWWZXDklBxUILJOnn/ix
         Nx1Alb01H2QAVlEBjXWHvdH75mRtgs5wEgF4rpWss3JzN61aXtiXmtWR7/tJgvpSK3j+
         94fGlBbvLLXnDgntfrKm/qs4lBjp7VrD4U25I3s9V6wfpAggm0Jvo96M3jf4AjaB7yvH
         n1iD91hnQRsBGy2Xe9z6nyW9PS1sh4iSLSmVjGHQun+vMxAFi1yeNG2SbyejuP9KfnvE
         mkbnrA1PmynEUAfD2ibnfsNlSck1DWO4PuXpsHDKK6LYe7Hqg1DNGAbcytbA6iFq7JE2
         MTgA==
X-Gm-Message-State: AC+VfDw/TkZpwsUP1Rpxw/MSA4Ou3UTfkc04xc/rRQ+Ui0mztwzSOkIH
        2yD+My7CoSvhgVgSmtxhnEAroyJE5estaUEbyBol
X-Google-Smtp-Source: ACHHUZ7uG2q6MlFL1epYc1uO3KRpPD/VQJENnlUkGD9/HYCl3XiTRI1mhAKhCBQdAnHp74YqVuFqNRo399rfVfEO47c=
X-Received: by 2002:a81:498b:0:b0:555:da78:c3e3 with SMTP id
 w133-20020a81498b000000b00555da78c3e3mr12125307ywa.29.1682891227314; Sun, 30
 Apr 2023 14:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230420215331.88326-1-junxiao.bi@oracle.com> <20230420215331.88326-2-junxiao.bi@oracle.com>
 <05b3eebd-7a3f-13d5-1fe9-8f4ab3080521@oracle.com> <30ab7555-8f36-cfb7-9101-0ebb92af3c2f@kernel.dk>
 <6300a33a-9d3d-42a2-d332-81e02d52d310@oracle.com> <CAHC9VhT2uCc5ePi+ung+rLaDiLCCCF=fjq8G+D3FJf0i4E8_hQ@mail.gmail.com>
 <f016d747-c01a-c46e-59a7-13d0d6306827@oracle.com>
In-Reply-To: <f016d747-c01a-c46e-59a7-13d0d6306827@oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 30 Apr 2023 17:46:56 -0400
Message-ID: <CAHC9VhSCjuJZ122EqdDxzJTU1tGq5nU_3+11WGKZ-WHjzU2FBw@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] blktrace: allow access trace file in lockdown mode
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-block@vger.kernel.org,
        nathanl@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        konrad.wilk@oracle.com, joe.jin@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 28, 2023 at 6:41=E2=80=AFPM Junxiao Bi <junxiao.bi@oracle.com> =
wrote:
> On 4/28/23 2:26 PM, Paul Moore wrote:
> > On Wed, Apr 26, 2023 at 12:33=E2=80=AFPM Junxiao Bi <junxiao.bi@oracle.=
com> wrote:
> >> Paul,  do you have any other concerns regarding blktrace? As Jens
> >> mentioned, blktrace just exported IO metadata to Userspace, those were
> >> not security sensitive information.
> > I think this version of the patchset is much better, thanks for your
> > patience.  I don't have any further concerns, and since the lockdown
> > LSM doesn't have a dedicated maintainer I think you should be all set
> > from my perspective.
>
> Thanks a lot for the review.
>
> > Since there are no changes under security/, I'm assuming this will go
> > in via the tracing tree?
>
> Should I notify some specific maintainer or mail list for merging?

When in doubt, the scripts/get_maintainer.pl tool in the kernel
sources can be helpful.

The results for the debugfs and relay files are fairly generic, but if
you look at the results for the blktrace.c file you get a more
reasonable list of maintainers and mailing lists.  I believe Jens has
already commented on your patches at least once, I don't recall if the
others have or not.  I see you've already CC'd the block mailing list,
so that might be enough.

Keep in mind that we are in the middle of a merge window so it is very
possible this patch might not be merged in a working/next/etc. branch
until after the merge window closes (every maintainer is a little bit
different in this regard).

--=20
paul-moore.com
