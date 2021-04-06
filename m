Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A73355855
	for <lists+linux-block@lfdr.de>; Tue,  6 Apr 2021 17:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345901AbhDFPmq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Apr 2021 11:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345903AbhDFPmn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 11:42:43 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53BC4C06174A;
        Tue,  6 Apr 2021 08:42:35 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 43EC592009D; Tue,  6 Apr 2021 17:42:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3E08F92009B;
        Tue,  6 Apr 2021 17:42:33 +0200 (CEST)
Date:   Tue, 6 Apr 2021 17:42:33 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Christoph Hellwig <hch@lst.de>
cc:     Jens Axboe <axboe@kernel.dk>, Khalid Aziz <khalid@gonehiking.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Ondrej Zary <linux@rainbow-software.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/8] Buslogic: remove ISA support
In-Reply-To: <20210406062750.GA6277@lst.de>
Message-ID: <alpine.DEB.2.21.2104061722220.65251@angie.orcam.me.uk>
References: <20210331073001.46776-1-hch@lst.de> <20210331073001.46776-3-hch@lst.de> <alpine.DEB.2.21.2104031805520.18977@angie.orcam.me.uk> <20210406062750.GA6277@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 6 Apr 2021, Christoph Hellwig wrote:

> >  Last but not least I do hope you do not plan to retire ISA DMA bounce 
> > buffering support for drivers/block/floppy.c, as there is hardly an 
> > alternative available (I do have a single SCSI<->FDD interface built 
> > around an Intel 8080 CPU, in the half-height 5.25" drive form factor, but 
> > such devices are exceedingly rare, and then you need a suitable parallel 
> > SCSI host too).
> 
> The floppy driver already uses its own bounce buffering for addressing
> limitations, and only the kernel bounce buffering to avoid getting
> fed highmem patches.  Please take a look at this series to clean up the
> latter:
> 
> https://lore.kernel.org/linux-block/20210406061755.811522-1-hch@lst.de/T/#u

 Great, thanks!

> >  Would it be feasible to convert it and any other drivers for ISA DMA 
> > devices (like those support for which you propose to remove here) still 
> > have users who could verify operation to the IOMMU framework?
> 
> I've converted the only once that still has signs of having users in
> the last 10 or so years.

 I infer the answer is "yes" then.  Of course it makes no sense to waste 
time and speculatively convert code nobody has expressed interest in and 
there's no immediate way to verify.

  Maciej
