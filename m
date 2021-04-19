Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C874363B57
	for <lists+linux-block@lfdr.de>; Mon, 19 Apr 2021 08:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbhDSGQt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Apr 2021 02:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhDSGQp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 02:16:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA91DC061760
        for <linux-block@vger.kernel.org>; Sun, 18 Apr 2021 23:16:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w23so35242766ejb.9
        for <linux-block@vger.kernel.org>; Sun, 18 Apr 2021 23:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4V00X4g8iTi3YjRqFiUXK8A9Z5ApFoZoEKZaxGIZdCo=;
        b=UXGaQjQrhGIz6uKTETg91SeCbEVU4WWaYT+Jvjgw6Y8ofSPvqR2p3Hu0p9PloZWwEk
         VpsNH5fcfnzKIyza7kkxmGgWLE2fJ3qXDnHzdtkpo59t3gDypGkHNt0bptcTMpg59rFN
         TG2+tBlCQnYfMYcABVYsPmNs4Jdcx60xGpC08g3nYWK8CsPitvxcA7In5kyzJAXHUSXj
         areRnL0VaDhHYVfF5wtTuMejzOjf2q/6vU+wIQ9aqXiGNAvbLG66Sw3/6FaSrHyQGp17
         nym9TXyM489PxSKfPpXuujfNGdJFL91OlOgFrOOfLDxOTQ3ehSq3ZVmrmGO4114MCOz3
         eucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4V00X4g8iTi3YjRqFiUXK8A9Z5ApFoZoEKZaxGIZdCo=;
        b=lOmJQKyBertxsKbtnDvrY6ftMQAEa0eUQi67O/19v7xskgEw6dSIqFdQOXejTERGM3
         myKU6yj1s8zXCsTE/9h3lOAMfc733+EIH2EuOTfSBBCOYzAWsM6ah3ZEM3YokJ+SO4bE
         t935K9gxZiGK94vIzgXggn2TGy99M9LyY4jEhVmydK3ArS54QI0X+S9KrFAtvCiVqZnI
         Kg+DH2WvEms784HE4k/JZ0w2ANS5FQwB5rQvN3H5NTwpWkgNNLmbHPsgfm0NgQci0Il+
         639K8Krkm4dyeC0ym0o6WgcsLLyyglMMDx3lnot7lXTMii9m/wNKJwmwIfF4VCXsNaW5
         Wp+Q==
X-Gm-Message-State: AOAM532ODKcpDgGopffVFQ/fHcipAeRl+ew4FcOeH89PfWo+VrrPOkPX
        jcZN1DKw49FdZmdzAuj8U7+vJv6/x1ivXbTkDRbxcg==
X-Google-Smtp-Source: ABdhPJxCLB66739zHIBl2ICVISKVfMONe+7lmGXEGA3LuDx50Sy7t44Bt+3LJaN5d6FrQdGCHuPoGHddDCvLWls7weM=
X-Received: by 2002:a17:906:f42:: with SMTP id h2mr20872722ejj.317.1618812974396;
 Sun, 18 Apr 2021 23:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210414122402.203388-1-gi-oh.kim@ionos.com> <20210414122402.203388-14-gi-oh.kim@ionos.com>
 <YHvvdskHgQe9gX09@unreal> <CAJX1YtaN3TmwdOE_8UrRuUU=3cCvtQRBX+DmwvU0Tj3nw-knyg@mail.gmail.com>
 <YH0TBlXxU5cq2eO4@unreal> <CAJX1Ytb=nFvfy4KNgHDxHaSp+4z3_Wh5EHXXVgg-dcNU39LAwQ@mail.gmail.com>
 <YH0ej9ZplTrkA156@unreal>
In-Reply-To: <YH0ej9ZplTrkA156@unreal>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Mon, 19 Apr 2021 08:15:38 +0200
Message-ID: <CAJX1YtbLB2SqPPr8Oh6hHc26QHq7LAL5YyZajbA_s_Rp9PMU=Q@mail.gmail.com>
Subject: Re: [PATCHv4 for-next 13/19] block/rnbd-clt: Support polling mode for
 IO latency optimization
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        hch@infradead.org, sagi@grimberg.me,
        Bart Van Assche <bvanassche@acm.org>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 19, 2021 at 8:09 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Apr 19, 2021 at 07:51:34AM +0200, Gioh Kim wrote:
> > On Mon, Apr 19, 2021 at 7:46 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Mon, Apr 19, 2021 at 07:12:09AM +0200, Gioh Kim wrote:
> > > > On Sun, Apr 18, 2021 at 10:36 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > On Wed, Apr 14, 2021 at 02:23:56PM +0200, Gioh Kim wrote:
> > > > > > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > > > > >
> > > > > > RNBD can make double-queues for irq-mode and poll-mode.
> > > > > > For example, on 4-CPU system 8 request-queues are created,
> > > > > > 4 for irq-mode and 4 for poll-mode.
> > > > > > If the IO has HIPRI flag, the block-layer will call .poll function
> > > > > > of RNBD. Then IO is sent to the poll-mode queue.
> > > > > > Add optional nr_poll_queues argument for map_devices interface.
> > > > > >
> > > > > > To support polling of RNBD, RTRS client creates connections
> > > > > > for both of irq-mode and direct-poll-mode.
> > > > > >
> > > > > > For example, on 4-CPU system it could've create 5 connections:
> > > > > > con[0] => user message (softirq cq)
> > > > > > con[1:4] => softirq cq
> > > > > >
> > > > > > After this patch, it can create 9 connections:
> > > > > > con[0] => user message (softirq cq)
> > > > > > con[1:4] => softirq cq
> > > > > > con[5:8] => DIRECT-POLL cq
> > >
> > > <...>
> >
> > I am sorry that I don't understand exactly.
> > Do I need to change them to "con<5..8>"?
>
> No, I just removed not relevant text and replaced it with <...> in
> automatic way :).

Oh ;-)

>
> >
> >
> > >
> > > > > > +int rtrs_clt_rdma_cq_direct(struct rtrs_clt *clt, unsigned int index)
> > > > > > +{
> > > > > > +     int cnt;
> > > > > > +     struct rtrs_con *con;
> > > > > > +     struct rtrs_clt_sess *sess;
> > > > > > +     struct path_it it;
> > > > > > +
> > > > > > +     rcu_read_lock();
> > > > > > +     for (path_it_init(&it, clt);
> > > > > > +          (sess = it.next_path(&it)) && it.i < it.clt->paths_num; it.i++) {
> > > > > > +             if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
> > > > >
> > > > > We talked about useless likely/unlikely in your workloads.
> > > >
> > > > Right, I've made a patch to remove all likely/unlikely
> > > > and will send with the next patch set.
> > >
> > > This specific line is "brand new". We don't add code that will be
> > > removed in next patch.
> >
> > Ah, ok. So you mean,
> > 1. remove unlikely from that line
> > 2. send a patch to remove all likely/unlikely for next round
> >
> > Am I right?
>
> Right

Thank you very much.
I will send V5 soon.
