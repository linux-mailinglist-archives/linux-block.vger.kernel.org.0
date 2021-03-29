Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC3534C32A
	for <lists+linux-block@lfdr.de>; Mon, 29 Mar 2021 07:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhC2FsE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 29 Mar 2021 01:48:04 -0400
Received: from verein.lst.de ([213.95.11.211]:52057 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhC2FsB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 01:48:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 535D368BEB; Mon, 29 Mar 2021 07:47:58 +0200 (CEST)
Date:   Mon, 29 Mar 2021 07:47:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org
Subject: Re: [RFC PATCH] block: protect bi_status with spinlock
Message-ID: <20210329054758.GB26736@lst.de>
References: <20210329022337.3992955-1-yuyufen@huawei.com> <20210329030246.GA15392@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329030246.GA15392@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 29, 2021 at 12:02:46PM +0900, Keith Busch wrote:
> On Sun, Mar 28, 2021 at 10:23:37PM -0400, Yufen Yu wrote:
> >  static struct bio *__bio_chain_endio(struct bio *bio)
> >  {
> >  	struct bio *parent = bio->bi_private;
> > +	unsigned long flags;
> >  
> > +	spin_lock_irqsave(&parent->bi_lock, flags);
> >  	if (!parent->bi_status)
> >  		parent->bi_status = bio->bi_status;
> > +	spin_unlock_irqrestore(&parent->bi_lock, flags);
> 
> 
> I don't see a spin_lock_init() on this new lock, though a spinlock seems
> overkill here. If you need an atomic update, you could do:
> 
> 	cmpxchg(&parent->bi_status, 0, bio->bi_status);
> 
> But I don't even think that's necessary. There really is no need to set
> parent->bi_status if bio->bi_status is 0, so something like this should
> be fine:
> 
>   	if (bio->bi_status && !parent->bi_status)
>   		parent->bi_status = bio->bi_status;

At very least we'd need READ_ONCE/WRITE_ONCE annotations, but yes,
those should be enough if every place that sets bi_status is careful.
