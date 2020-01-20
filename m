Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D055114292A
	for <lists+linux-block@lfdr.de>; Mon, 20 Jan 2020 12:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgATLYc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Jan 2020 06:24:32 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:34319 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgATLYc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jan 2020 06:24:32 -0500
Received: by mail-il1-f195.google.com with SMTP id s15so26999754iln.1
        for <linux-block@vger.kernel.org>; Mon, 20 Jan 2020 03:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vs6pynO+HWeCj8gwa5J0byk24CKYRIcbvcXdDxDoQOU=;
        b=IzryOyecmOiKS1L17ZlRAtgFcWh+McCMRGG0hKhYWKt6aulCK3I53QYhf7h334gtYp
         10YxTBBENVPLPQK98XC8gBphHsnPWju4UKbKCORfhFReIvAtEfeK589pbyNtXkw+X1k3
         a6ZlrkNAYmtsS8ceo0jsmUaDQnoFELi7Dhj9koYikTLHDjTAM3KwWTxUCAtCje40Aaw4
         f7HIois+d+4KM+iCDAH/e+GpsT9WJlOAQ3MuVZ7rPffIvv+EJQqBB31J8ouJp5ktjhRq
         /rpUWZ3nycjzDv3QtepjixydGPxhKBdn/Crh0HJ6Ta5g8GXaGbCT/O/jAyGjvFDi08Al
         yUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vs6pynO+HWeCj8gwa5J0byk24CKYRIcbvcXdDxDoQOU=;
        b=DyrSdkipKVaVdH0ubOGJeiAH/BzjNFT6NMs2rXq5XfRHgK8BjwasDaLa7kb0yRHovK
         i4GJh25pZ36RyfjtolIxcRvElFG2EA3H3URQvmy/30MU03Xz/wOsAs+RpmrgxV91da24
         tq6+8nuiEHfH0pocQqVKbTvLgge+QQtfkxgAA00bc6z2aeXL45yyfNm2v0cVBxJjU9dU
         yg5inzlp/vltRDqRdTs79GaMJ621NcAqJfICHCoq9srNsxD9qqCAFIegSn0CCZmy5Fn4
         2iUGA1cydWAcemzCrRHz7sjH3upSGwUpJCCmVLMO7xQDs5CMuptRznprc0NEEFNVmygt
         DdCg==
X-Gm-Message-State: APjAAAUc2OCYArjXYaYZ8EZQ+CjRW94KwY8lkb0zI3B/V9JPNVkabNgZ
        2kMD/XDvPD8IFidC920Oqu0fl/2enr8snRlMkgZwvA==
X-Google-Smtp-Source: APXvYqy3UjtyjVjRWo2MnXNUkl6Ug2wzh0ecd2Ts/Hc2mMHoTNWBDdJT9qPzJoKuzv9EZnBnJvDf3W/fOumtkV9usC8=
X-Received: by 2002:a92:8d88:: with SMTP id w8mr10628788ill.71.1579519471918;
 Mon, 20 Jan 2020 03:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20200116125915.14815-1-jinpuwang@gmail.com> <20200116125915.14815-7-jinpuwang@gmail.com>
 <20200116145300.GC12433@unreal> <CAMGffE=pym8iz4OVxx7s6i37AU+KPFN3AeVrCTOpLx+N8A9dEQ@mail.gmail.com>
 <20200116155800.GA18467@unreal> <CAMGffEkLHNPJ3feWhX0vnjr3hasVp3=+Z76wO3-07s9+Te=7Pw@mail.gmail.com>
 <20200118101254.GD18467@unreal>
In-Reply-To: <20200118101254.GD18467@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Jan 2020 12:24:21 +0100
Message-ID: <CAMGffE=22zvvOFJpzyJPOLQFwA+9oMoxZSj=FAZV6RBonwJaEA@mail.gmail.com>
Subject: Re: [PATCH v7 06/25] RDMA/rtrs: client: main functionality
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > > > > > +static bool __rtrs_clt_change_state(struct rtrs_clt_sess *sess,
> > > > > > +                                  enum rtrs_clt_state new_state)
> > > > > > +{
> > > > > > +     enum rtrs_clt_state old_state;
> > > > > > +     bool changed = false;
> > > > > > +
> > > > > > +     lockdep_assert_held(&sess->state_wq.lock);
> > > > > > +
> > > > > > +     old_state = sess->state;
> > > > > > +     switch (new_state) {
> > > > > > +     case RTRS_CLT_CONNECTING:
> > > > > > +             switch (old_state) {
> > > > >
> > > > > Double switch is better to be avoided.
> > > > what's the better way to do it?
> > >
> > > Rewrite function to be more readable.
> > Frankly I think it's easy to read, depends on old_state change to new state.
> > see also scsi_device_set_state
>
> If you so in favor of switch inside switch, at lest do it properly.
>
> The scsi_device_set_state() function implements success-oriented
> approach and has very clear state machine without distraction and
> extra variables like changed/not_changed. You have completely
> opposite implementation to scsi_device_set_state().
Thanks for reviewing our code during the weekend, I respect the effort.

The reason we have "changed" variable is only when the state changed
as expected,
the caller will do further action like reconnect or close the session.

I will add kernel-doc around the function to make it more clear.

Thanks Leon
