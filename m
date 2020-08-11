Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2304C241BB2
	for <lists+linux-block@lfdr.de>; Tue, 11 Aug 2020 15:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgHKNnu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Aug 2020 09:43:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53001 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728532AbgHKNnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 09:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597153429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qTs9tEIfkpkQuoImhzLg73XNWyICbg9KzMJ6GTUMsIw=;
        b=ATJOVB/ZXctybd851XCVEA67NiugPosQ77+i0d/HUkUiHWYcx63wKKdqWcwZILWIlxTSe3
        0k/OVVaL01YDszGPils7BasPAZGqCA3HYl2+BhVR+q9NPIl77SrUM+uKd5mEP53ajDRkC6
        904PNY7k+pp42CjWqigZxOS45jNVboo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-bgUQICEpNKeZBFXtIH2srA-1; Tue, 11 Aug 2020 09:43:47 -0400
X-MC-Unique: bgUQICEpNKeZBFXtIH2srA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2241E8017FB;
        Tue, 11 Aug 2020 13:43:46 +0000 (UTC)
Received: from T590 (ovpn-13-156.pek2.redhat.com [10.72.13.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7498269319;
        Tue, 11 Aug 2020 13:43:31 +0000 (UTC)
Date:   Tue, 11 Aug 2020 21:43:26 +0800
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
Message-ID: <20200811134326.GA2266621@T590>
References: <20200811092134.2256095-1-ming.lei@redhat.com>
 <20200811092134.2256095-3-ming.lei@redhat.com>
 <20200811123044.mzsc2clpf6nxf6f6@steredhat>
 <20200811130953.GA2225752@T590>
 <20200811133925.m6szpaxqetsxxutz@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811133925.m6szpaxqetsxxutz@steredhat>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 11, 2020 at 03:39:25PM +0200, Stefano Garzarella wrote:
> On Tue, Aug 11, 2020 at 09:09:53PM +0800, Ming Lei wrote:
> > On Tue, Aug 11, 2020 at 02:30:44PM +0200, Stefano Garzarella wrote:
> > > Hi Ming,
> > > 
> > > On Tue, Aug 11, 2020 at 05:21:34PM +0800, Ming Lei wrote:
> > > > 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support") starts
> > > > to support multi-range discard for virtio-blk. However, the virtio-blk
> > > > disk may report max discard segment as 1, at least that is exactly what
> > > > qemu is doing.
> > > > 
> > > > So far, block layer switches to normal request merge if max discard segment
> > > > limit is 1, and multiple bios can be merged to single segment. This way may
> > > > cause memory corruption in virtblk_setup_discard_write_zeroes().
> > > > 
> > > > Fix the issue by handling single max discard segment in straightforward
> > > > way.
> > > > 
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > Cc: Changpeng Liu <changpeng.liu@intel.com>
> > > > Cc: Daniel Verkamp <dverkamp@chromium.org>
> > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > > ---
> > > >  drivers/block/virtio_blk.c | 23 +++++++++++++++--------
> > > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index 63b213e00b37..05b01903122b 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c'
> > > > @@ -126,14 +126,21 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
> > > >  	if (!range)
> > > >  		return -ENOMEM;
> > > 
> > > We are allocating the 'range' array to contain 'segments' elements.
> > > When queue_max_discard_segments() returns 1, should we limit 'segments'
> > > to 1?
> > 
> > That is block layer's responsibility to make sure that 'segments' is <=
> > 1, and we can double check & warn here.
> 
> So, IIUC, the number of bio in a request may not be the same as
> the return value of blk_rq_nr_discard_segments(). Is it right?

In case that queue_max_discard_segments() is 1, it is right. If
queue_max_discard_segments() is > 1, nr_range is supposed to be
same with number of bios in a request.


Thanks, 
Ming

