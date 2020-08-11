Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B44241B68
	for <lists+linux-block@lfdr.de>; Tue, 11 Aug 2020 15:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgHKNKW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Aug 2020 09:10:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35558 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728557AbgHKNKV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 09:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597151420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pJa9rffYLPwC2GRm8JX4Xdkgxrttl+Elzpi4fVIyYr8=;
        b=Qxfn7FwMfTdUzPLXETqv1Y3hw2hpuIH/7hA/sPK2CbDBlLDF3laEFxZa4C2hDUlySQ5a1L
        RhcDT9fe4TCD/35gdyH9mibwEapousQf0eV6KIfHxGmINttdqh1c1Zdx2EEHKTPFtzSnxQ
        uNm+zoasJphy2MTZytO9+Pq+cXU3RLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-aFGbMQEbM_6afhGjt6rNNA-1; Tue, 11 Aug 2020 09:10:16 -0400
X-MC-Unique: aFGbMQEbM_6afhGjt6rNNA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 494188015FC;
        Tue, 11 Aug 2020 13:10:15 +0000 (UTC)
Received: from T590 (ovpn-13-156.pek2.redhat.com [10.72.13.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1932C8BB00;
        Tue, 11 Aug 2020 13:09:58 +0000 (UTC)
Date:   Tue, 11 Aug 2020 21:09:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Changpeng Liu <changpeng.liu@intel.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/2] block: virtio_blk: fix handling single range discard
 request
Message-ID: <20200811130953.GA2225752@T590>
References: <20200811092134.2256095-1-ming.lei@redhat.com>
 <20200811092134.2256095-3-ming.lei@redhat.com>
 <20200811123044.mzsc2clpf6nxf6f6@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811123044.mzsc2clpf6nxf6f6@steredhat>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 11, 2020 at 02:30:44PM +0200, Stefano Garzarella wrote:
> Hi Ming,
> 
> On Tue, Aug 11, 2020 at 05:21:34PM +0800, Ming Lei wrote:
> > 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support") starts
> > to support multi-range discard for virtio-blk. However, the virtio-blk
> > disk may report max discard segment as 1, at least that is exactly what
> > qemu is doing.
> > 
> > So far, block layer switches to normal request merge if max discard segment
> > limit is 1, and multiple bios can be merged to single segment. This way may
> > cause memory corruption in virtblk_setup_discard_write_zeroes().
> > 
> > Fix the issue by handling single max discard segment in straightforward
> > way.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Changpeng Liu <changpeng.liu@intel.com>
> > Cc: Daniel Verkamp <dverkamp@chromium.org>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  drivers/block/virtio_blk.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 63b213e00b37..05b01903122b 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c'
> > @@ -126,14 +126,21 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
> >  	if (!range)
> >  		return -ENOMEM;
> 
> We are allocating the 'range' array to contain 'segments' elements.
> When queue_max_discard_segments() returns 1, should we limit 'segments'
> to 1?

That is block layer's responsibility to make sure that 'segments' is <=
1, and we can double check & warn here.

> 
> >  
> > -	__rq_for_each_bio(bio, req) {
> > -		u64 sector = bio->bi_iter.bi_sector;
> > -		u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> > -
> > -		range[n].flags = cpu_to_le32(flags);
> > -		range[n].num_sectors = cpu_to_le32(num_sectors);
> > -		range[n].sector = cpu_to_le64(sector);
> > -		n++;
> > +	if (queue_max_discard_segments(req->q) == 1) {
> > +		range[0].flags = cpu_to_le32(flags);
> > +		range[0].num_sectors = cpu_to_le32(blk_rq_sectors(req));
> > +		range[0].sector = cpu_to_le64(blk_rq_pos(req));
> > +		n = 1;
>                 ^
>                 this doesn't seem necessary since we don't use 'n' afterwards.

OK.

Thanks,
Ming

