Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBE7B179C5C
	for <lists+linux-block@lfdr.de>; Thu,  5 Mar 2020 00:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388535AbgCDXZQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Mar 2020 18:25:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31829 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388468AbgCDXZQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Mar 2020 18:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583364314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p8juafuY9nBxbQdXTOkQQGLh3mRvbcDsJuPyMUd6LN0=;
        b=STXEfFkooG2xzETDunDOLyL95ZsWSxibSRKSv8xISCbm/VAo/CBCFAJ1fGxsi/Lkq0sIi6
        bMCYti5nBj/U51JbgpcOebLh7xHEYRKAxmvkny3UCiHFhDSkX55yHOlhVgTOMwpHmtolvI
        BQ44X6Th6YPEjo6kTY8XrD2nsP7Obio=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-S2o4UP1KPCSNom8elwSEJQ-1; Wed, 04 Mar 2020 18:25:13 -0500
X-MC-Unique: S2o4UP1KPCSNom8elwSEJQ-1
Received: by mail-ed1-f71.google.com with SMTP id n12so2828393edq.13
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2020 15:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8juafuY9nBxbQdXTOkQQGLh3mRvbcDsJuPyMUd6LN0=;
        b=f9zBEJYGPENCXBXa026gMe1P0llcxop2K0oSW3PpvRHtDaTcGiAX1ykXpRyvnonNop
         WVxci5Q206Y4SgOdea776GNhUmFGe7BbTREK3wNXG+DwTfx5SwY1DGAXXeVa2+n87X7i
         62vn2FGRssNng2VrxeEPcxJ5pcPbSu3gaFw1O4J2QDJtcQT3wTtp0emvxESrKZbQsQ9b
         nLbD6z7IFxl4E8rOwaDPMNB2nuM200pJSKK0SietnQ1lQhINHAojQWQ1+CwLrdaVmiWT
         4H7qO+f34lj5wcWaU/LdXxrYkK8gdRbYwMXg1lue2YwcNStjNPqHk4QJ4m4C5g3jfSHI
         omwA==
X-Gm-Message-State: ANhLgQ2MepWhEoGtsTSCNHzCcaKc0IDYIM4IICYM4mjvH2//omsu+SOb
        RAMfjQP6cNfuN1Z7Ih+maYMkZDHWB2zk++NfmZRp6Tb4OuTlg3J6zlgiu7DXR1vWHhgoHK/1IFc
        64gx0uVNFTxvAcjVmN1JMfgmT6OqNwev4OqSyl68=
X-Received: by 2002:aa7:cac4:: with SMTP id l4mr5308678edt.367.1583364311868;
        Wed, 04 Mar 2020 15:25:11 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtRn9VC83shY8XHTDzRhsN1U3qcWCfB7uMojQH5bbSmIYgKzcRcKNB9bk5ZyS5m8JegYhUQLyH/6undXUq6ODg=
X-Received: by 2002:aa7:cac4:: with SMTP id l4mr5308663edt.367.1583364311594;
 Wed, 04 Mar 2020 15:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20200223165724.23816-1-mcroce@redhat.com> <CAPcyv4ijKqVhHixsp42kZL4p7uReJ67p3XoPyw5ojM-ZsOOUOg@mail.gmail.com>
In-Reply-To: <CAPcyv4ijKqVhHixsp42kZL4p7uReJ67p3XoPyw5ojM-ZsOOUOg@mail.gmail.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Thu, 5 Mar 2020 00:24:35 +0100
Message-ID: <CAGnkfhxAHctB9MHD0LzSk8uh4tEoF-hw+iwYAEdfeY_=g3NT2A@mail.gmail.com>
Subject: Re: [PATCH] block: refactor duplicated macros
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-bcache@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-mmc@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 4, 2020 at 9:57 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Sun, Feb 23, 2020 at 9:04 AM Matteo Croce <mcroce@redhat.com> wrote:
> >
> > The macros PAGE_SECTORS, PAGE_SECTORS_SHIFT and SECTOR_MASK are defined
> > several times in different flavours across the whole tree.
> > Define them just once in a common header.
> >
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> > ---
> >  block/blk-lib.c                  |  2 +-
> >  drivers/block/brd.c              |  3 ---
> >  drivers/block/null_blk_main.c    |  4 ----
> >  drivers/block/zram/zram_drv.c    |  8 ++++----
> >  drivers/block/zram/zram_drv.h    |  2 --
> >  drivers/dax/super.c              |  2 +-
>
> For the dax change:
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
>
> However...
>
> [..]
> >  include/linux/blkdev.h           |  4 ++++
> [..]
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 053ea4b51988..b3c9be6906a0 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -910,6 +910,10 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
> >  #define SECTOR_SIZE (1 << SECTOR_SHIFT)
> >  #endif
> >
> > +#define PAGE_SECTORS_SHIFT     (PAGE_SHIFT - SECTOR_SHIFT)
> > +#define PAGE_SECTORS           (1 << PAGE_SECTORS_SHIFT)
> > +#define SECTOR_MASK            (PAGE_SECTORS - 1)
> > +
>
> ...I think SECTOR_MASK is misnamed given it considers pages, and
> should probably match the polarity of PAGE_MASK, i.e.
>
> #define PAGE_SECTORS_MASK            (~(PAGE_SECTORS - 1))
>

Makes sense. I just kept the same value as in drivers/block/null_blk_main.c

-- 
Matteo Croce
per aspera ad upstream

