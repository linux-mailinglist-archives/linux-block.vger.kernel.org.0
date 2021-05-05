Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B80E3749CA
	for <lists+linux-block@lfdr.de>; Wed,  5 May 2021 23:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbhEEVCx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 5 May 2021 17:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbhEEVCw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 May 2021 17:02:52 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7270C061574
        for <linux-block@vger.kernel.org>; Wed,  5 May 2021 14:01:54 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id 33so1018875uaa.7
        for <linux-block@vger.kernel.org>; Wed, 05 May 2021 14:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jwVhRJYy+js/5o51kgFRGHXOKLlg07+mPyfmQzLfQ8=;
        b=kB5B593ODR2DISukFThhU5ogL5oH8WLCwb5sZBns6LORxL4mEDsoiSMUraJ1iD+iX2
         mCZ/iOQEK7kDFxm5G/45RbVshEH2TpIOrXHKIqYdDBAPTvBEGLfatBSmxgUPBqxp9Y+u
         G3D3iPdErQYq42LqaFoJ/TkNUmF2YodqlNImbanGv67zYc7RL+6/JaFQ5hvJJJz3wUZ7
         9NCpBuT6xrGpxxoBVKO7kDy+zQof9pRp1ZZ9oX1qx4/LHmnuL4sDVb4Fxa501DZGhZF1
         qDxcBx6d84sxdPWrXCOgf072TGvfSTAvGoxf31dsXjtbdfA1VkoZITUvWmMWB9f0KZZK
         wtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jwVhRJYy+js/5o51kgFRGHXOKLlg07+mPyfmQzLfQ8=;
        b=NTcyok4xFT2s5xCPpWKq6fVF5zoyP3UFDLKfJGs5GIRSYQpvpRhLHjydHmA/1Gx12B
         ovf0X6hIjNTSph+khdk3NSvfRPsg0s3is93+23Numz7G38oY0b6D1UeXw7PQ3u9nOuNp
         FMG8AaleXM3JEwMVL0c2UbA7bqEU5lNKVeffyyUndsR5Xf3ccoxLI9nMz/dj0V5veKA+
         tGRD4pgVCJvHA9o6Zs8vCDGswDSG9sF4p1LEE0hdUZiBt9zfy/0h0NAkC4ESkFDijQkl
         ZloqCfxPgA9mWsQUmjsrV/pC4nAM0wI9rJci1enhXhQp9bfelwj6sJrG2KsCe0GzwWOW
         roPQ==
X-Gm-Message-State: AOAM531+HqvKVamL4yoMxhvbiHqQF4tJRbagKW7gaXiqDuk5KZ/XVb2S
        Ik8+snENLbrGnOprMH+xUX09feMf0DOdH0MvDEkYSXGiV8o=
X-Google-Smtp-Source: ABdhPJzVXtTlfYT098kgAkzC6wolQxwCdgP32x5eynwQtlGyY2/rwYtvNV4kUcYtDX6R/EMSRXzEuVGMKHTAtflgYqY=
X-Received: by 2002:ab0:724c:: with SMTP id d12mr982714uap.63.1620248513497;
 Wed, 05 May 2021 14:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210420162556.217350-1-egranata@google.com> <20210505054314.GA4179527@infradead.org>
 <20210505161022-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210505161022-mutt-send-email-mst@kernel.org>
From:   Enrico Granata <egranata@google.com>
Date:   Wed, 5 May 2021 15:01:42 -0600
Message-ID: <CAPR809tf07tqpbK9z1jJ61PneLwE1WwD+9H9DM0GA95p7ks=zw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH] Provide detailed specification of
 virtio-blk lifetime metrics
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        virtio-dev@lists.oasis-open.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

FWIW, that patch needs a few updates, so I will be sending out an
updated version (ETA within next week is the plan), but I do agree
that Ack: would be good since there were some strong philosophical
objections in the beginning & it might make sense to let the wider
community know those are being addressed

Thanks,
- Enrico

On Wed, May 5, 2021 at 2:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, May 05, 2021 at 06:43:14AM +0100, Christoph Hellwig wrote:
> > On Tue, Apr 20, 2021 at 04:25:56PM +0000, Enrico Granata wrote:
> > > In the course of review, some concerns were surfaced about the
> > > original virtio-blk lifetime proposal, as it depends on the eMMC
> > > spec which is not open
> > >
> > > Add a more detailed description of the meaning of the fields
> > > added by that proposal to the virtio-blk specification, as to
> > > make it feasible to understand and implement the new lifetime
> > > metrics feature without needing to refer to JEDEC's specification
> > >
> > > This patch does not change the meaning of those fields nor add
> > > any new fields, but it is intended to provide an open and more
> > > clear description of the meaning associated with those fields.
> > >
> > > Signed-off-by: Enrico Granata <egranata@google.com>
> >
> > Still not a fan of the encoding, but at least it is properly documented
> > now:
> >
> > Acked-by: Christoph Hellwig <hch@lst.de>
>
> With that, would you like to ack the virtip-blk patch too?
> The format didn't actually change ...
>
> --
> MST
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
