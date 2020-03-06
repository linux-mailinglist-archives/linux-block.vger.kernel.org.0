Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D97717B9FE
	for <lists+linux-block@lfdr.de>; Fri,  6 Mar 2020 11:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCFKOz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 6 Mar 2020 05:14:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFKOz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Mar 2020 05:14:55 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACF2D2070A
        for <linux-block@vger.kernel.org>; Fri,  6 Mar 2020 10:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583489694;
        bh=JrMs07MY2g+UKb5EDRgE23qQsFrvwRFqTNqqEh89w9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tsejcwBp81Lz6i+Tb9oWqeV/vCHSpsJjg/9htKHt+VDcm28uprrv+cXYJJXcZDGmG
         O88SRyhooFMIq6c8bl36S7aQReYQKI/Ymdu0tpr276VUzCJ6ufeN/ZAspKA6P6Dy1X
         +x6+kfFK85OQEXfM0RijBDFp4m82j1JwNnToL4O0=
Received: by mail-wm1-f50.google.com with SMTP id j1so1728075wmi.4
        for <linux-block@vger.kernel.org>; Fri, 06 Mar 2020 02:14:54 -0800 (PST)
X-Gm-Message-State: ANhLgQ1ocHRzdlbnmTMKPPrNHSn16X+FJ6OKJR9CmPzc0KVdhKwdkmjs
        zbZa5XKtQPIU879KkmT05oXdqV5wMDegm9zEeTB2mw==
X-Google-Smtp-Source: ADFU+vsFANSACzYGytLz08mb68pZbS2PCm3O8i7TdajdJ592AHhe7xTjYxrFq3+qMx59PCDEw8uloFEVf2JUd1CVHok=
X-Received: by 2002:a1c:9d43:: with SMTP id g64mr3184759wme.62.1583489692927;
 Fri, 06 Mar 2020 02:14:52 -0800 (PST)
MIME-Version: 1.0
References: <20181124162123.21300-1-n.merinov@inango-systems.com>
 <20191224092119.4581-1-n.merinov@inango-systems.com> <20200108133926.GC4455@infradead.org>
 <26f7bd89f212f68b03a4b207e96d8702c9049015.1578910723.git.n.merinov@inango-systems.com>
 <20200218185336.GA14242@infradead.org> <797777312.1324734.1582544319435.JavaMail.zimbra@inango-systems.com>
 <20200224170813.GA27403@infradead.org> <711479725.2305.1583484191776.JavaMail.zimbra@inango-systems.com>
 <CAKv+Gu8ufmONSU8SX=NaAZBAKuD4Coo19z6e2MJ7BegsseJ63A@mail.gmail.com>
In-Reply-To: <CAKv+Gu8ufmONSU8SX=NaAZBAKuD4Coo19z6e2MJ7BegsseJ63A@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 6 Mar 2020 11:14:41 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_22KX4q7SJxEQ_tUcWDXHrFOdFj2jmXxFR_04KawQXnA@mail.gmail.com>
Message-ID: <CAKv+Gu_22KX4q7SJxEQ_tUcWDXHrFOdFj2jmXxFR_04KawQXnA@mail.gmail.com>
Subject: Re: [PATCH v3] partitions/efi: Fix partition name parsing in GUID
 partition entry
To:     Nikolai Merinov <n.merinov@inango-systems.com>
Cc:     hch <hch@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
        Jens Axboe <axboe@kernel.dk>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 6 Mar 2020 at 10:25, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 6 Mar 2020 at 09:43, Nikolai Merinov
> <n.merinov@inango-systems.com> wrote:
> >
> > Hi Christoph,
> >
> > Should I perform any other steps in order to get this change in the master?
> >
>
> I can take it via the EFI tree with an ack from Dave.
>

... or actually, I'm sure Dave is fine with it, so I'll just queue it
in efi/next directly (with Christoph's ack)

>
> >
> > ----- Original Message -----
> > > From: "hch" <hch@infradead.org>
> > > To: "n merinov" <n.merinov@inango-systems.com>
> > > Cc: "hch" <hch@infradead.org>, "Davidlohr Bueso" <dave@stgolabs.net>, "Jens Axboe" <axboe@kernel.dk>, "Ard Biesheuvel"
> > > <ardb@kernel.org>, "linux-efi" <linux-efi@vger.kernel.org>, "linux-block" <linux-block@vger.kernel.org>, "linux-kernel"
> > > <linux-kernel@vger.kernel.org>
> > > Sent: Monday, February 24, 2020 10:08:13 PM
> > > Subject: Re: [PATCH v3] partitions/efi: Fix partition name parsing in GUID partition entry
> >
> > > On Mon, Feb 24, 2020 at 01:38:39PM +0200, Nikolai Merinov wrote:
> > >> Hi Christoph,
> > >>
> > >> > I'd rather use plain __le16 and le16_to_cpu here. Also the be
> > >> > variants seems to be entirely unused.
> > >>
> > >> Looks like I misunderstood your comment from
> > >> https://patchwork.kernel.org/patch/11309223/:
> > >>
> > >> > Please add a an efi_char_from_cpu or similarly named helper
> > >> > to encapsulate this logic.
> > >>
> > >> The "le16_to_cpu(ptes[i].partition_name[label_count])" call is the
> > >> full implementation of the "efi_char_from_cpu" logic. Do you want
> > >> to encapsulate "utf16_le_to_7bit_string" logic entirely like in
> > >> the attached version?
> > >
> > > I think I though of just the inner loop, but your new version looks even
> > > better, so:
> > >
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
