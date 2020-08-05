Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D1323C72A
	for <lists+linux-block@lfdr.de>; Wed,  5 Aug 2020 09:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgHEHuX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 5 Aug 2020 03:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHEHuW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Aug 2020 03:50:22 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDABDC061756
        for <linux-block@vger.kernel.org>; Wed,  5 Aug 2020 00:50:21 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a14so14830308edx.7
        for <linux-block@vger.kernel.org>; Wed, 05 Aug 2020 00:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVITyii4Ab7WJF/rdLuyAWw283bhgzvOCo7RFQUaeJw=;
        b=FI16XBZCR7RCOfvsPM/3klRLozq0Sasoj9vpyzCdk81V+/OU2jygebMXREPOjG/rAU
         8NZhaSguRjjRCY/2gRl5t0D7ra8B8VZkgOI3jkf7mFnuKwve5QUDe48/9Z476OYop82F
         EdNh/wTQy+TS2kgfb4IHyNxGsZYznWDP9R3ltZOo9cDMr1EZHxZQhDkDysl+CG7SocOJ
         9au+IrLrV8fdm58wXJ/3zWSgYlwQ1l3at09n5n7kChhMd4TVjFGZJ1q+7Qfhr+pdhFiM
         SEq1IvvAdc/WN31F5CnVN4HNIkxtLm2ZkED6xKdky+adyjtFvz6YqWJ/SaK67cLi7sbo
         X7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVITyii4Ab7WJF/rdLuyAWw283bhgzvOCo7RFQUaeJw=;
        b=AUnkPiVq9y3NHrjWLRgUw/nBckVSve4V+MJ71FHskcqiNGTNjelqPrp6CMn6ZJprzT
         vpNnl3+i/lIkkP8HEHQ5BX/xAu7Lbi33hKAWpzHIzwgDELXahlow0L9Ukqpcek8ObbeK
         yrBSknM8u2MwxUgDjAkovl08gtGybN5Nrd3NpJg8Xrn/cJtnrNb8sGanA9wot4/FCsbP
         78pEfn92o+zLrb29uTCDbKtXAfx9WP7IWy7zh8BC0vLp6g2lbIlMK8rQK5G8/uGIthEK
         /6lI+DSsmSD6OrQoO42oE1bXnWbV6eDMzAj6r5+rT30LrXUy93440dJNtlg56agbGNS1
         Au+w==
X-Gm-Message-State: AOAM532Pqg97l3CCSTzAM+vMuY8ecVMYbNEOJetGrLGfvSxRwAEO/kiH
        ikbDA6Zey6ShS9NhJmPJiZYUhqQKJa0ASz1Flm6s2A==
X-Google-Smtp-Source: ABdhPJz1vltRdOznKcBehMxM83JIxpUmVSeVzBg0Gs191MjPLV9pmVhDUk5VKV3M/SllnemqQ5Dg3kmyjLpcOJU5JfI=
X-Received: by 2002:a05:6402:1cb3:: with SMTP id cz19mr1542759edb.299.1596613820365;
 Wed, 05 Aug 2020 00:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200623172321.GC6578@ziepe.ca> <20200804133759.377950-1-haris.iqbal@cloud.ionos.com>
 <20200805055712.GE4432@unreal>
In-Reply-To: <20200805055712.GE4432@unreal>
From:   Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date:   Wed, 5 Aug 2020 13:20:09 +0530
Message-ID: <CAJpMwygZym8sSiDUdEW3PQTmwsfNdO5bQG7_LWtKmE-tY_mrmg@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rtrs-srv: Incorporate ib_register_client into
 rtrs server init
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, linux-block@vger.kernel.org,
        dledford@redhat.com, Jason Gunthorpe <jgg@ziepe.ca>,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 5, 2020 at 11:27 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Aug 04, 2020 at 07:07:58PM +0530, Md Haris Iqbal wrote:
> > The rnbd_server module's communication manager (cm) initialization depends
> > on the registration of the "network namespace subsystem" of the RDMA CM
> > agent module. As such, when the kernel is configured to load the
> > rnbd_server and the RDMA cma module during initialization; and if the
> > rnbd_server module is initialized before RDMA cma module, a null ptr
> > dereference occurs during the RDMA bind operation.
> >
> > Call trace below,
> >
> > [    1.904782] Call Trace:
> > [    1.904782]  ? xas_load+0xd/0x80
> > [    1.904782]  xa_load+0x47/0x80
> > [    1.904782]  cma_ps_find+0x44/0x70
> > [    1.904782]  rdma_bind_addr+0x782/0x8b0
> > [    1.904782]  ? get_random_bytes+0x35/0x40
> > [    1.904782]  rtrs_srv_cm_init+0x50/0x80
> > [    1.904782]  rtrs_srv_open+0x102/0x180
> > [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> > [    1.904782]  rnbd_srv_init_module+0x34/0x84
> > [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> > [    1.904782]  do_one_initcall+0x4a/0x200
> > [    1.904782]  kernel_init_freeable+0x1f1/0x26e
> > [    1.904782]  ? rest_init+0xb0/0xb0
> > [    1.904782]  kernel_init+0xe/0x100
> > [    1.904782]  ret_from_fork+0x22/0x30
> > [    1.904782] Modules linked in:
> > [    1.904782] CR2: 0000000000000015
> > [    1.904782] ---[ end trace c42df88d6c7b0a48 ]---
> >
> > All this happens cause the cm init is in the call chain of the module init,
> > which is not a preferred practice.
> >
> > So remove the call to rdma_create_id() from the module init call chain.
> > Instead register rtrs-srv as an ib client, which makes sure that the
> > rdma_create_id() is called only when an ib device is added.
> >
> > Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 77 +++++++++++++++++++++++++-
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  7 +++
> >  2 files changed, 81 insertions(+), 3 deletions(-)
>
> Please don't send vX patches as reply-to in "git send-email" command.
>
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index 0d9241f5d9e6..916f99464d09 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -16,6 +16,7 @@
> >  #include "rtrs-srv.h"
> >  #include "rtrs-log.h"
> >  #include <rdma/ib_cm.h>
> > +#include <rdma/ib_verbs.h>
> >
> >  MODULE_DESCRIPTION("RDMA Transport Server");
> >  MODULE_LICENSE("GPL");
> > @@ -31,6 +32,7 @@ MODULE_LICENSE("GPL");
> >  static struct rtrs_rdma_dev_pd dev_pd;
> >  static mempool_t *chunk_pool;
> >  struct class *rtrs_dev_class;
> > +static struct rtrs_srv_ib_ctx ib_ctx;
> >
> >  static int __read_mostly max_chunk_size = DEFAULT_MAX_CHUNK_SIZE;
> >  static int __read_mostly sess_queue_depth = DEFAULT_SESS_QUEUE_DEPTH;
> > @@ -2033,6 +2035,62 @@ static void free_srv_ctx(struct rtrs_srv_ctx *ctx)
> >       kfree(ctx);
> >  }
> >
> > +static int rtrs_srv_add_one(struct ib_device *device)
> > +{
> > +     struct rtrs_srv_ctx *ctx;
> > +     int ret;
> > +
> > +     /*
> > +      * Keep a track on the number of ib devices added
> > +      */
> > +     ib_ctx.ib_dev_count++;
> > +
> > +     if (!ib_ctx.rdma_init) {
> > +             /*
> > +              * Since our CM IDs are NOT bound to any ib device we will create them
> > +              * only once
> > +              */
> > +             ctx = ib_ctx.srv_ctx;
> > +             ret = rtrs_srv_rdma_init(ctx, ib_ctx.port);
> > +             if (ret) {
> > +                     /*
> > +                      * We errored out here.
> > +                      * According to the ib code, if we encounter an error here then the
> > +                      * error code is ignored, and no more calls to our ops are made.
> > +                      */
> > +                     pr_err("Failed to initialize RDMA connection");
> > +                     return ret;
> > +             }
> > +             ib_ctx.rdma_init = true;
>
> This rdma_init == false is equal to ib_ctx.ib_dev_count == 0 and the
> logic can be simplified.

Yes, this was the first logic in my head. But I have few thoughts,
The below suggestions uses "ib_ctx.ib_dev_count" as a marker for
successful execution of rtrs_srv_rdma_init() and not really an IB
device count. Meaning if we have multiple calls to add, due to
multiple devices, our count would stay 1. And while removal we might
end up calling rdma_destroy_id() on our first remove call even though
another device is still remaining.

If we increment "ib_ctx.ib_dev_count" every time add is called, even
before we call rtrs_srv_rdma_init() and irrespective of whether
rtrs_srv_rdma_init() succeeds or not, then we are keeping a count of
IB devices added. However, when remove is called, we now know the
number of devices added, but not whether rtrs_srv_rdma_init() was
successful or not. We may end up calling rdma_destroy_id() on NULL
cm_ids

Does this make sense or am I missing something?


>
> if (ib_ctx.ib_dev_count)
>         return 0;
>
> ctx = ib_ctx.srv_ctx;
> ret = rtrs_srv_rdma_init(ctx, ib_ctx.port);
> if (ret)
>         return ret;
> ib_ctx.ib_dev_count++;
> return 0;
>
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void rtrs_srv_remove_one(struct ib_device *device, void *client_data)
> > +{
> > +     struct rtrs_srv_ctx *ctx;
> > +
> > +     ib_ctx.ib_dev_count--;
> > +
> > +     if (!ib_ctx.ib_dev_count && ib_ctx.rdma_init) {
>
> It is not kernel coding style.
> if (ib_ctx.ib_dev_count)
>         return;
>
> ctx = ib_ctx.srv_ctx;
> rdma_destroy_id(ctx->cm_id_ip);
> rdma_destroy_id(ctx->cm_id_ib);
>
> Thanks
>
> > +             /*
> > +              * Since our CM IDs are NOT bound to any ib device we will remove them
> > +              * only once, when the last device is removed
> > +              */
> > +             ctx = ib_ctx.srv_ctx;
> > +             rdma_destroy_id(ctx->cm_id_ip);
> > +             rdma_destroy_id(ctx->cm_id_ib);
> > +             ib_ctx.rdma_init = false;
> > +     }
> > +}
> > +
> > +static struct ib_client rtrs_srv_client = {
> > +     .name   = "rtrs_server",
> > +     .add    = rtrs_srv_add_one,
> > +     .remove = rtrs_srv_remove_one
> > +};
> > +
> >  /**
> >   * rtrs_srv_open() - open RTRS server context
> >   * @ops:             callback functions
> > @@ -2051,12 +2109,26 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
> >       if (!ctx)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     err = rtrs_srv_rdma_init(ctx, port);
> > +     ib_ctx = (struct rtrs_srv_ib_ctx) {
> > +             .srv_ctx        = ctx,
> > +             .port           = port,
> > +     };
> > +
> > +     err = ib_register_client(&rtrs_srv_client);
> >       if (err) {
> >               free_srv_ctx(ctx);
> >               return ERR_PTR(err);
> >       }
> >
> > +     /*
> > +      * Since ib_register_client does not propagate the device add error
> > +      * we check if the RDMA connection init was successful or not
> > +      */
> > +     if (!ib_ctx.rdma_init) {
> > +             free_srv_ctx(ctx);
> > +             return NULL;
> > +     }
> > +
> >       return ctx;
> >  }
> >  EXPORT_SYMBOL(rtrs_srv_open);
> > @@ -2090,8 +2162,7 @@ static void close_ctx(struct rtrs_srv_ctx *ctx)
> >   */
> >  void rtrs_srv_close(struct rtrs_srv_ctx *ctx)
> >  {
> > -     rdma_destroy_id(ctx->cm_id_ip);
> > -     rdma_destroy_id(ctx->cm_id_ib);
> > +     ib_unregister_client(&rtrs_srv_client);
> >       close_ctx(ctx);
> >       free_srv_ctx(ctx);
> >  }
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > index dc95b0932f0d..6e9d9000cd8d 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > @@ -118,6 +118,13 @@ struct rtrs_srv_ctx {
> >       struct list_head srv_list;
> >  };
> >
> > +struct rtrs_srv_ib_ctx {
> > +     struct rtrs_srv_ctx     *srv_ctx;
> > +     u16                     port;
> > +     int                     ib_dev_count;
> > +     bool                    rdma_init;
> > +};
> > +
> >  extern struct class *rtrs_dev_class;
> >
> >  void close_sess(struct rtrs_srv_sess *sess);
> > --
> > 2.25.1
> >



-- 

Regards
-Haris
