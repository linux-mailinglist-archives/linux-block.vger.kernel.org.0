Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74BADB67CB
	for <lists+linux-block@lfdr.de>; Wed, 18 Sep 2019 18:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbfIRQLb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 Sep 2019 12:11:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36501 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbfIRQLb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Sep 2019 12:11:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id t3so723424wmj.1
        for <linux-block@vger.kernel.org>; Wed, 18 Sep 2019 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l9BGDAnIqbvlWzDRE+Ku2Tnq1vI7ZHAZNnDGcLJaeoI=;
        b=Lee9cvGv6LRHm4P1vIe3YyRUN3MG64NsmSRZPybtCtutHoKSLd2WvngPDQAnq51/Dd
         CutIKWoHl6mtRNpLvhG9OU3AoYFgKJ8oRsuJ02zoRttFMO0KamdhkTwVnUdzqeJJnC8H
         TrZASzjumSSEhz3mXlF02CQsQSPf0vmAUnCTSR3ks9/yCWnymcsF99oXK0DV2BMvBwq4
         q3DswQns2HdGa259y+Ol6wpd6ela13VNtewNNuy2eexI8rUEJqmdze2nJcgAlgJM3cM0
         mHgFryxTZffJQHwSf7k0TRDPNufgLOHt00y9ne7j7oaA6KfJVDc7NxSIhL1q7OAechoy
         5bXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9BGDAnIqbvlWzDRE+Ku2Tnq1vI7ZHAZNnDGcLJaeoI=;
        b=T5S0sbcrn42dEGc+cyb0CK98y1bfpTudwxvOEwovLyWM5E3Yd/3bdV0q75OYBzbWRF
         G/CBaQpu/SIJWq2A3nWpOPHxK4pkFImr7SdFK6T0CbufKcDTB2qLfNOqjBtzhTiDxNO3
         TPRbAY+XeeNSgzuG/KV9o0cWaChLrZSBtV40sQNrGOXF1DiSU+klAnuYiKlyXQkDSheP
         h5yg7j4pXK95oIsJCa9waWHe9ZzijZbWXPrYaEKqnSb62rBtWwaCQCgJonw8cwi5mOfH
         TWmmVz4ESgHgfJXZqfih6Ll/0RoQRr9pnXik2P+7mHpsyvVN9rGc2XcLNHTCltK6Vs4g
         lv4A==
X-Gm-Message-State: APjAAAVCkxJFx9DUgFckj+zRJaWQGCQljlA9fSogthWAjv3S2aaqZIi/
        xZwm/VBoFWiXtFz0gDiIV9tf3vqChLcZA4/uHReyJg==
X-Google-Smtp-Source: APXvYqyEbRxped1rON75+xXUk3BOZcaOPA2pkEEmXl5pb7A8VyKejDYVYQxPCAwpWk3zADgNyjpkO9Mc5AVHNIISCoQ=
X-Received: by 2002:a1c:7dd1:: with SMTP id y200mr3416473wmc.59.1568823089744;
 Wed, 18 Sep 2019 09:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-16-jinpuwang@gmail.com>
 <4fbad80b-f551-131e-9a5c-a24f1fa98fea@acm.org> <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
 <CAMGffE=Vsbv5O7rCSq_ymA-UXPaSWT_bMfZ+AK-2f1Z=zMMtyQ@mail.gmail.com> <66dcf1ac-53b8-aa0c-cda2-4919281500d0@acm.org>
In-Reply-To: <66dcf1ac-53b8-aa0c-cda2-4919281500d0@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 18 Sep 2019 18:11:18 +0200
Message-ID: <CAMGffEmWg18uxB3g8w0yXprdf0Bxsoz_EiSBCOb8owenYpe2qA@mail.gmail.com>
Subject: Re: [PATCH v4 15/25] ibnbd: private headers with IBNBD protocol
 structs and helpers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 18, 2019 at 5:26 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/16/19 8:39 AM, Jinpu Wang wrote:
> > - Roman's pb emal address, it's no longer valid, will fix next round.
> >
> >
> >>>
> >>>> +static inline const char *ibnbd_io_mode_str(enum ibnbd_io_mode mode)
> >>>> +{
> >>>> +     switch (mode) {
> >>>> +     case IBNBD_FILEIO:
> >>>> +             return "fileio";
> >>>> +     case IBNBD_BLOCKIO:
> >>>> +             return "blockio";
> >>>> +     case IBNBD_AUTOIO:
> >>>> +             return "autoio";
> >>>> +     default:
> >>>> +             return "unknown";
> >>>> +     }
> >>>> +}
> >>>> +
> >>>> +static inline const char *ibnbd_access_mode_str(enum ibnbd_access_mode mode)
> >>>> +{
> >>>> +     switch (mode) {
> >>>> +     case IBNBD_ACCESS_RO:
> >>>> +             return "ro";
> >>>> +     case IBNBD_ACCESS_RW:
> >>>> +             return "rw";
> >>>> +     case IBNBD_ACCESS_MIGRATION:
> >>>> +             return "migration";
> >>>> +     default:
> >>>> +             return "unknown";
> >>>> +     }
> >>>> +}
> >>>
> >>> These two functions are not in the hot path and hence should not be
> >>> inline functions.
> >> Sounds reasonable, will remove the inline.
> > inline was added to fix the -Wunused-function warning  eg:
> >
> >    CC [M]  /<<PKGBUILDDIR>>/ibnbd/ibnbd-clt.o
> > In file included from /<<PKGBUILDDIR>>/ibnbd/ibnbd-clt.h:34,
> >                   from /<<PKGBUILDDIR>>/ibnbd/ibnbd-clt.c:33:
> > /<<PKGBUILDDIR>>/ibnbd/ibnbd-proto.h:362:20: warning:
> > 'ibnbd_access_mode_str' defined but not used [-Wunused-function]
> >   static const char *ibnbd_access_mode_str(enum ibnbd_access_mode mode)
> >                      ^~~~~~~~~~~~~~~~~~~~~
> > /<<PKGBUILDDIR>>/ibnbd/ibnbd-proto.h:348:20: warning:
> > 'ibnbd_io_mode_str' defined but not used [-Wunused-function]
> >   static const char *ibnbd_io_mode_str(enum ibnbd_io_mode mode)
> >
> > We have to move both functions to a separate header file if we really
> > want to do it.
> > The function is simple and small, if you insist, I will do it.
>
> Please move these functions into a .c file. That will reduce the size of
> the kernel modules and will also reduce the size of the header file.
>
> Thanks,
>
> Bart.
>

Ok, will do.

Thanks,
Jinpu
