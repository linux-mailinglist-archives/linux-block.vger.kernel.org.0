Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C19F46387A
	for <lists+linux-block@lfdr.de>; Tue,  9 Jul 2019 17:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfGIPSu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 9 Jul 2019 11:18:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54003 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfGIPSu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 11:18:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so3498967wmj.3
        for <linux-block@vger.kernel.org>; Tue, 09 Jul 2019 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bn9gSFayf8w5FKgfP36Gj02tgxyFSUDJTdBJDm+i8tg=;
        b=Fl/l3lgzHGZQGnvX1km+i2//vjtFMm7tboRZdXyZqlVZ/zohNudbzf+o9xjMZaK2Az
         V5N57leY/WuGB0G8cwGSikoy8w7pElx5oWoPiujnUpRfgjYqbV7QbbpDfMhJuEQoXfap
         h9RBFGN2VBahIrRzjB/RkR7C7LfUzYH6kdEqjuzARPuP8jfbmejdRL7KnOLOvNHbpFdL
         PZJvUryEjRfoKUWSPleETEEp020r06u4dx2Y4x4o5Xm01dkz0pUjxM20aMXyWF94QPfH
         Vbr9FS9JlnxsDniXe1EGYC3+OR4tnbLkxzYVrPEgTBzKNtELkWBN91LF1+doIGDcsXck
         ZrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bn9gSFayf8w5FKgfP36Gj02tgxyFSUDJTdBJDm+i8tg=;
        b=nXikp8ACguIqhGUVPDrxjLSImDzGiZQ1Bul6ATOcaLpIfimkcqPkNXaHsyQm4Sme3R
         9B9c/+nyauOiju24PScuh2zP8oRdYOz/JhnfRkzf05SHvO1A3AF6a9rLavDf+dcvZvxL
         Wu8hPoNQJmBfWIAXIgalWDezqWb2L0MG8RUhJESGOBTXCbg+UA6kvCLkVZt8criUZnAl
         0LaEVjmtswMCYONOhd+3AMbibuXhDAZA96pUMuhTHcMs74MYGqkn2yrzGvyHz6/V8dv0
         36584i0ejjN6Yj6FMKc8U5Dnjbq8dykevFEDVQDL3VWLmTsSHYys8rnNtnsYTJdn1OPk
         HpYg==
X-Gm-Message-State: APjAAAVdwUmjm4q66n1I3yZelDcMT5G+wo3ogbWRVqCVMw+BtPc6wCB2
        NHYJ671seYM0z+B5BWTp/tQygsWpS9wrlXbQQ4fg6w==
X-Google-Smtp-Source: APXvYqzOY5ekXZ9APSUAGKE2zg52znpHx+Ch76+TC6s7UsjOKEVXrpCO7fk3ZzX1r9kovxQTrw1SEEHJYdX2omwITxY=
X-Received: by 2002:a1c:c005:: with SMTP id q5mr426342wmf.59.1562685528057;
 Tue, 09 Jul 2019 08:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-26-jinpuwang@gmail.com>
 <20190709151013.GW7034@mtr-leonro.mtl.com>
In-Reply-To: <20190709151013.GW7034@mtr-leonro.mtl.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 9 Jul 2019 17:18:37 +0200
Message-ID: <CAMGffEmeH7-oEENYLQ3tEnkKbO4pcb7omPeavNscVJteEnupyw@mail.gmail.com>
Subject: Re: [PATCH v4 25/25] MAINTAINERS: Add maintainer for IBNBD/IBTRS modules
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 9, 2019 at 5:10 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Jun 20, 2019 at 05:03:37PM +0200, Jack Wang wrote:
> > From: Roman Pen <roman.penyaev@profitbricks.com>
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  MAINTAINERS | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a6954776a37e..0b7fd93f738d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7590,6 +7590,20 @@ IBM ServeRAID RAID DRIVER
> >  S:   Orphan
> >  F:   drivers/scsi/ips.*
> >
> > +IBNBD BLOCK DRIVERS
> > +M:   IBNBD/IBTRS Storage Team <ibnbd@cloud.ionos.com>
> > +L:   linux-block@vger.kernel.org
> > +S:   Maintained
> > +T:   git git://github.com/profitbricks/ibnbd.git
> > +F:   drivers/block/ibnbd/
> > +
> > +IBTRS TRANSPORT DRIVERS
> > +M:   IBNBD/IBTRS Storage Team <ibnbd@cloud.ionos.com>
>
> I don't know if it rule or not, but can you please add real
> person/persons to Maintainers list? Many times, those global
> support lists are simply ignored.

Sure, we can use my and Danil 's name in next round.

>
> > +L:   linux-rdma@vger.kernel.org
> > +S:   Maintained
> > +T:   git git://github.com/profitbricks/ibnbd.git
>
> How did you imagine patch flow for ULP, while your tree is
> external to RDMA tree?

Plan was we gather the patch in the git tree, and
send patches to the list via git send email, do we accept pull request
from github?
What the preferred way?

Thanks Leon.
Jack
>
> > +F:   drivers/infiniband/ulp/ibtrs/
> > +
> >  ICH LPC AND GPIO DRIVER
> >  M:   Peter Tyser <ptyser@xes-inc.com>
> >  S:   Maintained
> > --
> > 2.17.1
> >
