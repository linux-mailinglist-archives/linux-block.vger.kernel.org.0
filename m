Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE7F17BEF8
	for <lists+linux-block@lfdr.de>; Fri,  6 Mar 2020 14:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCFNda (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 6 Mar 2020 08:33:30 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42583 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbgCFNda (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Mar 2020 08:33:30 -0500
Received: by mail-io1-f68.google.com with SMTP id q128so2056918iof.9
        for <linux-block@vger.kernel.org>; Fri, 06 Mar 2020 05:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOgNubgvkB+PFv8kOH/Puf/i8J9C6TgnMdeObKC0G2g=;
        b=CnuwD6IW/Zj53S5DiPzKIfnMKa/2r1EcNlAgSe9glmmT8Dz0m8kk6f5EXlxqU6EzyZ
         mHLtw+Abz96XpzRUkGL5je/otVL2uYAZoDsTKunKgf/xpx8kjyRo9pcmDFE6mAP8fO9V
         mueONh6C/wKb/LWPZu4Hdf0Bl8OsiCmwHnErMVBen8fF6arV3fy9gKO/WaH7tUFop3Ho
         qEQ8aiDu8qPDQJKDRoZitYf6oco+48StXcNdVR3/cfT3qataUpYFk0FklCmKHJEmHu2E
         BzPulcoOlL4cT/T4WzOjfpizhpWd2VsqDq0YAS9Nk66hdDcBYRDiq5gKi3pLRtKk4Ktn
         3Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOgNubgvkB+PFv8kOH/Puf/i8J9C6TgnMdeObKC0G2g=;
        b=m9tu+r4BTTDjfGoyyRWp1Ui/mN1AQPpRmugMbP9GL3SGgQ0vdlddar7HrSTqd6VRE6
         lzd8ypMgMKgQhp7WorV/oZQSApDti9OvJI+JsQUhEFanQE9dK07BY1lCZ55HMmcHCftd
         Nc+/WXhTjgtFDR1yN4TYajJN4PFDX0XzLOKVsV1NXVxOJx0TQgxdXX+sC8mLULG9m8RB
         ojl7/RWeshLyK9cTDa/xR0bDhv8vGVbceYKeTqwa+UctiCexVBJJWSOcet2LYcfX20gr
         gYBMcAhNzJXcldUi1d+liPVKgv9yb3LbEYMhTE/92fQZzgHHI+iXLRuuiSweOnRhInzH
         mbng==
X-Gm-Message-State: ANhLgQ1jVr8FuiXQmpZ6DfaYR0qkJubDM9mNz8y8ZwtyU1n6b3QwrFfo
        cgcQ3GyLyJ/uk2hG42IsL6pmrTCEdTB7swQFqzhCEg==
X-Google-Smtp-Source: ADFU+vvh8femgnXWgeDBLCi2J965f7nTs4zoQBV4JhSVb97H+FBR5UyAbx/Rxb9RCxt0jHVlP14KqqDS1RaBkaqCqwI=
X-Received: by 2002:a05:6638:e8b:: with SMTP id p11mr2935174jas.11.1583501609095;
 Fri, 06 Mar 2020 05:33:29 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-7-jinpuwang@gmail.com>
 <c3c8fbcc-0028-9b23-8eff-3b5f1f60e652@acm.org> <CAHg0HuxJgjQca3Vy7nbcVKs0bUoj=-Uqoa5DOzYoqRHQ6Vph7A@mail.gmail.com>
 <597777e7-ac5a-5fc4-c1f7-3ffa5876a6f2@acm.org> <CAMGffEmbV1YL4O860EswBKm2UHBYP_cgqMFYFVc2AdHnAFeu+g@mail.gmail.com>
 <20200304164903.GF31668@ziepe.ca> <CAMGffEncbGXhFLDxZJp957c7vmV4vCaTZFUVKwqDROFikCTLPg@mail.gmail.com>
 <20200305132748.GH31668@ziepe.ca> <CAMGffEkYvTit0Zv6HMDaUgo8kLEOLs_8vex7p1qgVeUDUxa4XA@mail.gmail.com>
 <20200305135455.GI31668@ziepe.ca>
In-Reply-To: <20200305135455.GI31668@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 6 Mar 2020 14:33:18 +0100
Message-ID: <CAMGffE=hmJiAeKvPH_YimbqmAHvW3Cy0W_d5qqgnr-HEdXHw7Q@mail.gmail.com>
Subject: Re: [PATCH v9 06/25] RDMA/rtrs: client: main functionality
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 5, 2020 at 2:54 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Mar 05, 2020 at 02:37:59PM +0100, Jinpu Wang wrote:
> > On Thu, Mar 5, 2020 at 2:27 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Thu, Mar 05, 2020 at 12:26:01PM +0100, Jinpu Wang wrote:
> > >
> > > > We have to admit, the code snip is from null_blk, get_tag function,
> > > > not invented by us.
> > > > the get_cpu/put_cpu was added to get/save the current cpu_id, which
> > > > can be removed around the do-while loop.,
> > > > we only need to raw_smp_processor_id to get current cpu, we use it
> > > > later to pick which connection to use.
> > >
> > > Be careful copying crazy core code into drivers..
> > >
> > > > > You have to do something to provably guarantee the send q cannot
> > > > > overflow. send q overflow is defined as calling post_send before a
> > > > > poll_cq has confirmed space is available for send.
> > >
> > > > Shouldn't the cq api handle that already,  with IB_POLL_SOFTIRQ,
> > > > poll cq is done on very softirq run, so send queue space should be reclaimed
> > > > fast enough, with IB_POLL_WORKQUEUE, when cq->com_handler get called,
> > > > the ib_cq_poll_work will do the poll_cq, together with extra
> > > > send_queue size reserved,
> > > > the send queue can not overflow!
> > >
> > > Somehow that doesn't sound like 'provably guarentee' - that is some
> > > statistical argument..
> > Could you give an example which meets the "provably guarantee",
> > seems most of the driver is based on the cq API.
>
> You are supposed to directly keep track of completions and not issue
> sends until completions are seen.
>
> Jason
ok, got it!

Thanks
