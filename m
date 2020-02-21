Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28D5A167B59
	for <lists+linux-block@lfdr.de>; Fri, 21 Feb 2020 11:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgBUKug (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 21 Feb 2020 05:50:36 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:45608 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgBUKug (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Feb 2020 05:50:36 -0500
Received: by mail-il1-f195.google.com with SMTP id p8so1256845iln.12
        for <linux-block@vger.kernel.org>; Fri, 21 Feb 2020 02:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OPS6z2b9xpPF3wQKIuekk4fC9RzWMOEqMORb//JIJpo=;
        b=I//oOyFh8ZfE9orwZucAjqt0Xsc5RS48pWVW07HFUdNIV6/4JmHCZJk+gpiBuxguin
         fo7DvsXOXoJu9hQHA8yJYpAuXPrAi/eUtoYOA1Y8X7Xq2Gtl1gmY27dFq0COSgWY3w/V
         2nN0hI81lI4wtTntPmvOJk4UdD94yQRN81sXFnWGJYLoSqiKuk3zM6jjuRxMZcZdwXHK
         9UfwG76RPGKYXub7zjT5vSFbDlQUUK4O/mkknKarLFxtdMSVOmwZSiLo44a9ivhDwUbJ
         KoTk9lpvzO+e/FvsMnbivhukh3vYXAR/8Ugn9iscw92uW401rtNHOs7eUPGgqefWD7qV
         XiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OPS6z2b9xpPF3wQKIuekk4fC9RzWMOEqMORb//JIJpo=;
        b=ivu8vLCQGS7wAwPtkW3sn0PBxKWIxTLo7Bui0NB8kcI595JQMU6lwRScpl3hEZYJny
         2JxKulf2yZuaPgcUHN2sQDPbxSDsQMG9ACVYXfB7WPwwrj5YmSGf7VkDP9yffe7vVTri
         JvNHsSRWRBnEl0d1z3u3da8CZG2z4dYJ3bpd2DmOoasA8fRTQ3svAPAetbKMRqEYpWRQ
         3n4p6MaPgydm/4JFM1vJQg1s9x6vm4MthnqwVIX7oQ/xbFqGGm7GBNmxNNAUHVL+1XXj
         8hvCrJf9JXDbMgYMMwWLWL7d7i6JtFHU+xeZ/wpyKh3vIVrP+I5lK+Y90nMasbJh6FUW
         /SSg==
X-Gm-Message-State: APjAAAU/KAJbP5NzI1WFkybprYMy1OaS+iuLzQJTxIASo9QiMECwS+zo
        IbdKg186LOzDb4Wg5nKnQjPLsGbXXSFlkA0/O0k1aA==
X-Google-Smtp-Source: APXvYqzMSH2AYlu+wEv2Y0IUsXD22f9VImOhSPAYzmjr3fXLgz7dusvmqw4OEdsMwL529YhwVccDqy4UrBeOcJe68TQ=
X-Received: by 2002:a05:6e02:4d2:: with SMTP id f18mr33874619ils.54.1582282234244;
 Fri, 21 Feb 2020 02:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20200124204753.13154-1-jinpuwang@gmail.com> <CAHg0HuzLLHqp_76ThLhUdHGG_986Oxvvr15h_13T12eEWjyAxA@mail.gmail.com>
 <20200131165421.GB29820@ziepe.ca> <f657d371-3b23-e4b2-50b3-db47cd521e1f@kernel.dk>
 <CAD9gYJLVMVPjQcCj0aqbAW3CD86JQoFNvzJwGziRXT8B2UT0VQ@mail.gmail.com>
 <a1aaa047-3a44-11a7-19a1-e150a9df4616@kernel.dk> <CAMGffEkLkwkd73Q+m46VeOw0UnzZ0EkZQF-QcSZjyqNcqigZPw@mail.gmail.com>
 <20200219002449.GA11943@ziepe.ca> <20200219061949.GB15239@unreal>
In-Reply-To: <20200219061949.GB15239@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 21 Feb 2020 11:50:23 +0100
Message-ID: <CAMGffE=N6EAuudLgh-jYt26bMVwoF8iy9mYkpuM1OEKQamcbUQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Jinpu Wang <jinpuwang@gmail.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Doug Ledford <dledford@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 19, 2020 at 7:19 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Feb 18, 2020 at 08:24:49PM -0400, Jason Gunthorpe wrote:
> > On Thu, Feb 06, 2020 at 04:12:22PM +0100, Jinpu Wang wrote:
> > > On Fri, Jan 31, 2020 at 6:49 PM Jens Axboe <axboe@kernel.dk> wrote:
> > > >
> > > > On 1/31/20 10:28 AM, Jinpu Wang wrote:
> > > > > Jens Axboe <axboe@kernel.dk> =E4=BA=8E2020=E5=B9=B41=E6=9C=8831=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:04=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > >>
> > > > >> On 1/31/20 9:54 AM, Jason Gunthorpe wrote:
> > > > >>> On Fri, Jan 31, 2020 at 05:50:44PM +0100, Danil Kipnis wrote:
> > > > >>>> Hi Doug, Hi Jason, Hi Jens, Hi All,
> > > > >>>>
> > > > >>>> since we didn't get any new comments for the V8 prepared by Ja=
ck a
> > > > >>>> week ago do you think rnbd/rtrs could be merged in the current=
 merge
> > > > >>>> window?
> > > > >>>
> > > > >>> No, the cut off for something large like this would be rc4ish
> > > > >>
> > > > >> Since it's been around for a while, I would have taken it in a b=
it
> > > > >> later than that. But not now, definitely too late. If folks are
> > > > >> happy with it, we can get it queued for 5.7.
> > > > >>
> > > > >
> > > > > Thanks Jason, thanks Jens, then we will prepare later another rou=
nd for 5.7
> > > >
> > > > It would also be really nice to see official sign-offs (reviews) fr=
om non
> > > > ionos people...
> > >
> > > Totally agree.
> > > Hi Bart, hi Leon,
> > >
> > > Both of you spent quite some time to review the code, could you give =
a
> > > Reviewed-by for some of the patches you've reviewed?
> >
> > Anyone? I don't want to move ahead with a block driver without someone
> > from the block community saying it is OK
>
> I wanted to ask for a resend based on latest -rc2, if it is possible.
>
> Thanks
>
Hi, all

I just send v9 out based on latest 5.6-rc2.

Thanks!
