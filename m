Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FA91EEBE6
	for <lists+linux-block@lfdr.de>; Thu,  4 Jun 2020 22:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgFDUZb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 Jun 2020 16:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729797AbgFDUZa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 16:25:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EB8C08C5C7
        for <linux-block@vger.kernel.org>; Thu,  4 Jun 2020 13:25:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q24so1721803pjd.1
        for <linux-block@vger.kernel.org>; Thu, 04 Jun 2020 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TblIMkzhKEVNZyPa1dQf8kFQ+MgYlpgsesY6pOK1xME=;
        b=eTUIYqIrq5sxbgWQO/3JauOnTYpVr1lxYINDt5nKOAMkJOKF9ufyGFqb5XSmsRi3m+
         Uksx9+kJJ0xBVvvMTZtWdGvFYckH9URWghdJ/VSzZBwwBmizmaE949JntUM6qTfFIrip
         3zzyVfVtH7B2Lzj4WQ8kAWj65+Txwm/2hs5XFlhCKdRU1uedTRsD04P49ZgSRY5QBLTc
         CQBCbVHZuVCB29pP2Co0mZAOf0TgkJUljtb0VB8CHI8VhuigYp30PE+r/D7MHanlVYxK
         BKS8ooZdHaU0PWi8nTHb08bOMRG7dMr/qLVaTlH87DKKqIpufZxi7ZRUHWNmW4PpK4km
         2vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TblIMkzhKEVNZyPa1dQf8kFQ+MgYlpgsesY6pOK1xME=;
        b=Jp5sEXe/byEmCP+R9QMnIehTa1PtQS7ep/C8ZLjYkXga2nxGgyWOJcljaLOLrgph+x
         RHrgU6+/VGEsKx1iSLRPu2aovSoFRC+xKNsH5hM3hpsNa1F+APv9O14ZwLaMDroFjBIw
         IdzwnQBFHHHt+2eDTl263E5pHd9LHfsnpHag71+E7rXkzzTRVGScDsXbj5d6P8dQrFlF
         mPbfkbws6CCR5ViOV9MwR1VmFsjO5gMGveBxhi6JnwaIdm7lPssy58534tB26pVqURC4
         XGt1DtuVA7detLxaga/MTZN2uEyY2224cFrEEQx0RlDu2MmNDHGvukb0fbdrbI+v4sgr
         39cA==
X-Gm-Message-State: AOAM5306HvxD8bo1/lpqj6Zj9w2aZq/vtZDcENYAJUf7liwYpz+4YAH8
        csBciMK3EALlOcgo5zMhs0QtBrpZPuQyEuJf4E+nwg==
X-Google-Smtp-Source: ABdhPJzjhN/4pCp12TIV+9JXZmAnmqzfEHd9/r8jgURCikDTNzP/FuiRKg13zAi0ZiROLKM3I1SNYAlTdBzPgSsKmW0=
X-Received: by 2002:a17:902:341:: with SMTP id 59mr6129425pld.119.1591302328252;
 Thu, 04 Jun 2020 13:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200603233203.1695403-1-keescook@chromium.org>
 <20200603233203.1695403-4-keescook@chromium.org> <CAKwvOdnNuFySqAMk7s_cXqFM=dPX4JfvqNVLCuj90Gn4tzciAw@mail.gmail.com>
 <202006041316.A15D952@keescook>
In-Reply-To: <202006041316.A15D952@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Jun 2020 13:25:16 -0700
Message-ID: <CAKwvOdk9e19MqJNhGYV5mJisLOcjK+ba2sYzLgf7cvNerqNuwA@mail.gmail.com>
Subject: Re: [PATCH 03/10] b43: Remove uninitialized_var() usage
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org,
        Network Development <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 4, 2020 at 1:18 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jun 04, 2020 at 01:08:44PM -0700, Nick Desaulniers wrote:
> > On Wed, Jun 3, 2020 at 4:32 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Using uninitialized_var() is dangerous as it papers over real bugs[1]
> > > (or can in the future), and suppresses unrelated compiler warnings (e.g.
> > > "unused variable"). If the compiler thinks it is uninitialized, either
> > > simply initialize the variable or make compiler changes. As a precursor
> > > to removing[2] this[3] macro[4], just initialize this variable to NULL,
> > > and make the (unreachable!) code do a conditional test.
> > >
> > > [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> > > [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> > > [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> > > [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
> > >
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  drivers/net/wireless/broadcom/b43/phy_n.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/wireless/broadcom/b43/phy_n.c b/drivers/net/wireless/broadcom/b43/phy_n.c
> > > index d3c001fa8eb4..88cdcea10d61 100644
> > > --- a/drivers/net/wireless/broadcom/b43/phy_n.c
> > > +++ b/drivers/net/wireless/broadcom/b43/phy_n.c
> > > @@ -4222,7 +4222,7 @@ static void b43_nphy_tx_gain_table_upload(struct b43_wldev *dev)
> >
> > The TODOs and `#if 0` in this function are concerning.  It looks like
> > `rf_pwr_offset_table` is only used when `phy->rev` is >=7 && < 19.
> >
> > Further, the loop has a case for `phy->rev >= 19` but we would have
> > returned earlier if that was the case.

oh, and there's an early return for `phy->rev < 3` I just noticed.

>
> Yeah, that's why I put the "(unreachable!)" note in the commit log. ;)

I don't think that note is correct.

>
> >
> > >         u32 rfpwr_offset;
> > >         u8 pga_gain, pad_gain;
> > >         int i;
> > > -       const s16 *uninitialized_var(rf_pwr_offset_table);
> > > +       const s16 *rf_pwr_offset_table = NULL;
> > >
> > >         table = b43_nphy_get_tx_gain_table(dev);
> > >         if (!table)
> > > @@ -4256,9 +4256,13 @@ static void b43_nphy_tx_gain_table_upload(struct b43_wldev *dev)
> > >                         pga_gain = (table[i] >> 24) & 0xf;
> > >                         pad_gain = (table[i] >> 19) & 0x1f;
> > >                         if (b43_current_band(dev->wl) == NL80211_BAND_2GHZ)
> > > -                               rfpwr_offset = rf_pwr_offset_table[pad_gain];
> > > +                               rfpwr_offset = rf_pwr_offset_table
> > > +                                               ? rf_pwr_offset_table[pad_gain]
> > > +                                               : 0;
> > >                         else
> > > -                               rfpwr_offset = rf_pwr_offset_table[pga_gain];
> > > +                               rfpwr_offset = rf_pwr_offset_table
> > > +                                               ? rf_pwr_offset_table[pga_gain]
> > > +                                               : 0;
> >
> >
> > The code is trying to check `phy->rev >= 7 && phy->rev < 19` once
> > before the loop, then set `rf_pwr_offset_table`, so having another
> > conditional on `rf_pwr_offset_table` in the loop is unnecessary. I'm
> > ok with initializing it to `NULL`, but I'm not sure the conditional
> > check is necessary.  Do you get a compiler warning otherwise?
>
> I mean, sort of the best thing to do is just remove nearly everything
> here since it's actually unreachable. But it is commented as "when

This code is reachable. Consider `phy->rev >= 7 && phy->rev < 19`.  If
`rf_pwr_offset_table` was NULL, it would have returned early on L4246,
so the checks added in this patch are unnecessary.  Forgive me if
there's some other control flow I'm not considering.

> supported ..." etc, so I figured I'd leave it. As part of that I didn't
> want to leave any chance of a NULL deref, so I added the explicit tests
> just for robustness.
>
> *shrug*
-- 
Thanks,
~Nick Desaulniers
