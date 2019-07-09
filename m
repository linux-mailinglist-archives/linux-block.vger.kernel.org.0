Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37B6A636FE
	for <lists+linux-block@lfdr.de>; Tue,  9 Jul 2019 15:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfGINct (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 9 Jul 2019 09:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfGINct (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Jul 2019 09:32:49 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE1B720844;
        Tue,  9 Jul 2019 13:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562679168;
        bh=MCYnuJfEscac9g8Nz2a9rq95rRvzJOa4Z7pZxI2FS9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UEGTAPpYktq4n9WZVG7zQMWWXfc5+Rod/zYUn0twUgGoKDXLGC1hzMIGwCvzAWeai
         Tm88GrTXHY6mfVIziUVjThuuwgQYelcjEdoGaY4WgrOyyG0pQUkawfBUP5qSyl/JK9
         XO6j8um5pjkcX6N8yaBGSJ/a0RTR/PgxRyws0CKI=
Date:   Tue, 9 Jul 2019 16:32:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, axboe@kernel.dk,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>, bvanassche@acm.org,
        jgg@mellanox.com, dledford@redhat.com,
        Roman Pen <r.peniaev@gmail.com>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
Message-ID: <20190709133245.GT7034@mtr-leonro.mtl.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <20190709110036.GQ7034@mtr-leonro.mtl.com>
 <20190709111737.GB6719@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709111737.GB6719@kroah.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 09, 2019 at 01:17:37PM +0200, Greg KH wrote:
> On Tue, Jul 09, 2019 at 02:00:36PM +0300, Leon Romanovsky wrote:
> > On Tue, Jul 09, 2019 at 11:55:03AM +0200, Danil Kipnis wrote:
> > > Hallo Doug, Hallo Jason, Hallo Jens, Hallo Greg,
> > >
> > > Could you please provide some feedback to the IBNBD driver and the
> > > IBTRS library?
> > > So far we addressed all the requests provided by the community and
> > > continue to maintain our code up-to-date with the upstream kernel
> > > while having an extra compatibility layer for older kernels in our
> > > out-of-tree repository.
> > > I understand that SRP and NVMEoF which are in the kernel already do
> > > provide equivalent functionality for the majority of the use cases.
> > > IBNBD on the other hand is showing higher performance and more
> > > importantly includes the IBTRS - a general purpose library to
> > > establish connections and transport BIO-like read/write sg-lists over
> > > RDMA, while SRP is targeting SCSI and NVMEoF is addressing NVME. While
> > > I believe IBNBD does meet the kernel coding standards, it doesn't have
> > > a lot of users, while SRP and NVMEoF are widely accepted. Do you think
> > > it would make sense for us to rework our patchset and try pushing it
> > > for staging tree first, so that we can proof IBNBD is well maintained,
> > > beneficial for the eco-system, find a proper location for it within
> > > block/rdma subsystems? This would make it easier for people to try it
> > > out and would also be a huge step for us in terms of maintenance
> > > effort.
> > > The names IBNBD and IBTRS are in fact misleading. IBTRS sits on top of
> > > RDMA and is not bound to IB (We will evaluate IBTRS with ROCE in the
> > > near future). Do you think it would make sense to rename the driver to
> > > RNBD/RTRS?
> >
> > It is better to avoid "staging" tree, because it will lack attention of
> > relevant people and your efforts will be lost once you will try to move
> > out of staging. We are all remembering Lustre and don't want to see it
> > again.
>
> That's up to the developers, that had nothing to do with the fact that
> the code was in the staging tree.  If the Lustre developers had actually
> done the requested work, it would have moved out of the staging tree.
>
> So if these developers are willing to do the work to get something out
> of staging, and into the "real" part of the kernel, I will gladly take
> it.

Greg,

It is not matter of how much *real* work developers will do, but
it is a matter of guidance to do *right* thing, which is hard to achieve
if people mentioned in the beginning of this thread wouldn't look on
staging code.

>
> But I will note that it is almost always easier to just do the work
> ahead of time, and merge it in "correctly" than to go from staging into
> the real part of the kernel.  But it's up to the developers what they
> want to do.
>
> thanks,
>
> greg k-h
