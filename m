Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE539241B9D
	for <lists+linux-block@lfdr.de>; Tue, 11 Aug 2020 15:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgHKNjf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Aug 2020 09:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728532AbgHKNje (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 09:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597153173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NnggE9IjeaSwlRVMPqA9l649GAePiPfZTA1vky92y5o=;
        b=ELaLne3z37mhK+Prsn91n32vw3RZaMeutzJIdbHSmaBDvk4zGe1hhBkEhC0HBdVsRVrx1o
        yorGeJobvAOUa93VSB6PByQHvrS8D99x8PzdgqmLp495VUVmZ1qg4EuXLIlKCkOcqn/knm
        O7oosj8l4O+GNTnkNV+KNKsbzQg6oRo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-l3Moj7t4MLuLmLgYoGAsjg-1; Tue, 11 Aug 2020 09:39:31 -0400
X-MC-Unique: l3Moj7t4MLuLmLgYoGAsjg-1
Received: by mail-wr1-f72.google.com with SMTP id w7so5635296wrt.9
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 06:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NnggE9IjeaSwlRVMPqA9l649GAePiPfZTA1vky92y5o=;
        b=dTz8Ifrfaa1UNWRvhpfQPIwkAAkhj+ETFz/XN8JZBPyqgdZGsiEKB0AU+MKQKLXJDz
         kWnpcp9oDbzLx9NpWZMoUiUnSpi9qjDjou7sDdvD3rsbodV6JoOQPY+q8sYAAoL0G6iR
         pxIyBtUuIuGLuvfTfvEyhv5l21cfK60BLNicA8wOvhlys46nkcm32NLPTj9z5+fZMDD2
         fE1159wL3QuGmv7wVP1hEIQLMfG/k0iXMAOQtQw5/hxDPKOfkXEs2YSvP7dGxWGq7bRX
         skgw0/8KjqBVqM6OKdZHBeBNqPxPm79JKw97FsdMfhjiSWU5G8o/nFNi7wrZR0k8hkPl
         3eyQ==
X-Gm-Message-State: AOAM532UBPDvjs0vra85PUFv5wSGuYVY44LC4pWIix36VMBzdxAATJCY
        P0AiJ8qgCryMzxk0OlMjoDXCo3bYE6ICMtHP8brIGmKSrzw3YCnxs3fbDh+/PuXykON9r3teqco
        4qm7vttg0WZwKiQr6agdG+S4=
X-Received: by 2002:a7b:c257:: with SMTP id b23mr3923695wmj.164.1597153170069;
        Tue, 11 Aug 2020 06:39:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxmKltMhaxvcow2QaS3Hxl+aSvNECr651+5CFBc5QsDIN7HLQ+QeWp/dU1pzf/GyTSSLlAIA==
X-Received: by 2002:a7b:c257:: with SMTP id b23mr3923678wmj.164.1597153169803;
        Tue, 11 Aug 2020 06:39:29 -0700 (PDT)
Received: from steredhat ([5.171.229.81])
        by smtp.gmail.com with ESMTPSA id t17sm4929351wmj.34.2020.08.11.06.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 06:39:28 -0700 (PDT)
Date:   Tue, 11 Aug 2020 15:39:25 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Changpeng Liu <changpeng.liu@intel.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/2] block: virtio_blk: fix handling single range discard
 request
Message-ID: <20200811133925.m6szpaxqetsxxutz@steredhat>
References: <20200811092134.2256095-1-ming.lei@redhat.com>
 <20200811092134.2256095-3-ming.lei@redhat.com>
 <20200811123044.mzsc2clpf6nxf6f6@steredhat>
 <20200811130953.GA2225752@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811130953.GA2225752@T590>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 11, 2020 at 09:09:53PM +0800, Ming Lei wrote:
> On Tue, Aug 11, 2020 at 02:30:44PM +0200, Stefano Garzarella wrote:
> > Hi Ming,
> > 
> > On Tue, Aug 11, 2020 at 05:21:34PM +0800, Ming Lei wrote:
> > > 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support") starts
> > > to support multi-range discard for virtio-blk. However, the virtio-blk
> > > disk may report max discard segment as 1, at least that is exactly what
> > > qemu is doing.
> > > 
> > > So far, block layer switches to normal request merge if max discard segment
> > > limit is 1, and multiple bios can be merged to single segment. This way may
> > > cause memory corruption in virtblk_setup_discard_write_zeroes().
> > > 
> > > Fix the issue by handling single max discard segment in straightforward
> > > way.
> > > 
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Changpeng Liu <changpeng.liu@intel.com>
> > > Cc: Daniel Verkamp <dverkamp@chromium.org>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  drivers/block/virtio_blk.c | 23 +++++++++++++++--------
> > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 63b213e00b37..05b01903122b 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c'
> > > @@ -126,14 +126,21 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
> > >  	if (!range)
> > >  		return -ENOMEM;
> > 
> > We are allocating the 'range' array to contain 'segments' elements.
> > When queue_max_discard_segments() returns 1, should we limit 'segments'
> > to 1?
> 
> That is block layer's responsibility to make sure that 'segments' is <=
> 1, and we can double check & warn here.

So, IIUC, the number of bio in a request may not be the same as
the return value of blk_rq_nr_discard_segments(). Is it right?

If it is true, is not clear to me why we are allocating the 'range'
array using 'segments' as the size, and then we are filling it cycling
on the bios.

Maybe I need to take a closer look at the block layer to understand it better.

Thanks,
Stefano

> 
> > 
> > >  
> > > -	__rq_for_each_bio(bio, req) {
> > > -		u64 sector = bio->bi_iter.bi_sector;
> > > -		u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> > > -
> > > -		range[n].flags = cpu_to_le32(flags);
> > > -		range[n].num_sectors = cpu_to_le32(num_sectors);
> > > -		range[n].sector = cpu_to_le64(sector);
> > > -		n++;
> > > +	if (queue_max_discard_segments(req->q) == 1) {
> > > +		range[0].flags = cpu_to_le32(flags);
> > > +		range[0].num_sectors = cpu_to_le32(blk_rq_sectors(req));
> > > +		range[0].sector = cpu_to_le64(blk_rq_pos(req));
> > > +		n = 1;
> >                 ^
> >                 this doesn't seem necessary since we don't use 'n' afterwards.
> 
> OK.
> 
> Thanks,
> Ming
> 

