Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81233177BC4
	for <lists+linux-block@lfdr.de>; Tue,  3 Mar 2020 17:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbgCCQU4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 3 Mar 2020 11:20:56 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37461 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbgCCQU4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Mar 2020 11:20:56 -0500
Received: by mail-io1-f68.google.com with SMTP id c17so4228276ioc.4
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2020 08:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZAaJpXYNbdE39jeCEup28isyGTBokuMuM2Ns8CeYXpk=;
        b=HD0T88U4IkciFmBKWyjieLSLkNW3mJ/jo47mvAmUmHM6QC3x2rDf/J2E3pIX2w8lAW
         5cChn1rhH1SZP/4pg9PFwAcqeoPu7B4kuvMEFhM95FQP7S0T/K66P558/RLJto5aFaQR
         GMscF8sTTKNYzWy2t4t8wkx9yqZAInEqLqpP+TGMmYqtbvaqbOWk3eSxMI29zWzJga5V
         6pOrg+AFLECIpvEfNeUeW9RijMq0aJ5CGE/NAvztt3O9r3srrg4XOe8FeHo8prsqQSRO
         zmvuGHVHgOnrlnI+4SCNRM38tCgZ/NuHkhnlHB8kdnJxHHtoy/WQeKR76FLW0zcMmsSC
         mZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZAaJpXYNbdE39jeCEup28isyGTBokuMuM2Ns8CeYXpk=;
        b=m14ftPkeyMC/KwF2KCmq8t7OZjjRT28aPaBOOCLvbgfMu4pX4iPUbY4BaW8+C0kFE/
         85/rg4jTjOJBwEviTwnB65VzLvKKbmZmvobZ8YbRrCdY7WgWZ1CFNLoW9oVLLg0FGPca
         KveE0x1Ut89wbSC2Z3diBn/T5/6X5qLHnzE+0ocaF/hkQvdEBJzR8MwDKIJ56Jbbzq6B
         T2Qu8IyBqTXUPk7XfYjNb8lPXAIobg/RKGa5hWhfL8DIZ0pYt32IlvMRAHvZ/PnJ962g
         wPSNtxXfoEJyGW+rvEhkeWzlk2K6/F+MG5A8o5un/mh9L1xxHm3obh/XfwHIArYEqlMu
         XVJQ==
X-Gm-Message-State: ANhLgQ2/jDA/5z7jgnLUjaJi5dxVrVpzM3XA94ye09KNPR4CXWg6P1FH
        W1WNG+cjFyS/IaNrjQCcsQiSD3FXGcnaho2iZwc21Q==
X-Google-Smtp-Source: ADFU+vtHmu7s11pv6vuoIx5myn8AoL3UJnCv3Sy9IzzZ1EBiom/NdmFIyFbd6DkSKNl/HLwSFGtJ+Tcgr3JKWphP/cA=
X-Received: by 2002:a05:6602:1508:: with SMTP id g8mr1734085iow.22.1583252453918;
 Tue, 03 Mar 2020 08:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-22-jinpuwang@gmail.com>
 <92721a50-158f-3018-39d4-40fce7b0f4d8@acm.org> <CAHg0Huy_8hzxxA6R8_EzPNfYd3QN-meUckFStUrjiGeVaGj_Qg@mail.gmail.com>
In-Reply-To: <CAHg0Huy_8hzxxA6R8_EzPNfYd3QN-meUckFStUrjiGeVaGj_Qg@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 3 Mar 2020 17:20:41 +0100
Message-ID: <CAMGffEmtJJE8eoMQ4X3MYEJez35M20DaWwTt_3-+hk7i=R-r=w@mail.gmail.com>
Subject: Re: [PATCH v9 21/25] block/rnbd: server: functionality for IO
 submission to file or block dev
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 2, 2020 at 11:06 AM Danil Kipnis
<danil.kipnis@cloud.ionos.com> wrote:
>
> On Sun, Mar 1, 2020 at 4:09 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 2020-02-21 02:47, Jack Wang wrote:
> > > +static struct bio *rnbd_bio_map_kern(struct request_queue *q, void *data,
> > > +                                   struct bio_set *bs,
> > > +                                   unsigned int len, gfp_t gfp_mask)
> > > +{
> > > +     unsigned long kaddr = (unsigned long)data;
> > > +     unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > > +     unsigned long start = kaddr >> PAGE_SHIFT;
> > > +     const int nr_pages = end - start;
> > > +     int offset, i;
> > > +     struct bio *bio;
> > > +
> > > +     bio = bio_alloc_bioset(gfp_mask, nr_pages, bs);
> > > +     if (!bio)
> > > +             return ERR_PTR(-ENOMEM);
> > > +
> > > +     offset = offset_in_page(kaddr);
> > > +     for (i = 0; i < nr_pages; i++) {
> > > +             unsigned int bytes = PAGE_SIZE - offset;
> > > +
> > > +             if (len <= 0)
> > > +                     break;
> > > +
> > > +             if (bytes > len)
> > > +                     bytes = len;
> > > +
> > > +             if (bio_add_pc_page(q, bio, virt_to_page(data), bytes,
> > > +                                 offset) < bytes) {
> > > +                     /* we don't support partial mappings */
> > > +                     bio_put(bio);
> > > +                     return ERR_PTR(-EINVAL);
> > > +             }
> > > +
> > > +             data += bytes;
> > > +             len -= bytes;
> > > +             offset = 0;
> > > +     }
> > > +
> > > +     bio->bi_end_io = bio_put;
> > > +     return bio;
> > > +}
> >
> > The above function is almost identical to bio_map_kern(). Please find a
> > way to prevent such code duplication.
>
> Hi Bart,
>
> We prealloc bio_set in order to avoid allocation in io path done by
> bio_map_kern() (call to bio_kmalloc). Instead we use
> bio_alloc_bioset() with a preallocated bio_set. Will test whether
> performance advantage is measurable and if not will switch to
> bio_map_kern.
Hi Bart,

We tried the above approach and just noticed the bio_map_kern was no
longer exported since 5.4 kernel.
We checked target_core_iblock.c and nvme io-cmd-bdev.c, they are open
coding similar function.

I guess re-export bio_map_kern will not be accepted?
Do you have suggestion how should we handle it?

Thanks!
