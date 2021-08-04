Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A843DFEB6
	for <lists+linux-block@lfdr.de>; Wed,  4 Aug 2021 12:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbhHDKCS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Aug 2021 06:02:18 -0400
Received: from verein.lst.de ([213.95.11.211]:46473 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237234AbhHDKCR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Aug 2021 06:02:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 766E967373; Wed,  4 Aug 2021 12:02:03 +0200 (CEST)
Date:   Wed, 4 Aug 2021 12:02:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lauri Kasanen <cand@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] n64cart: fix the dma address in n64cart_do_bvec
Message-ID: <20210804100203.GA20072@lst.de>
References: <20210804094958.460298-1-hch@lst.de> <20210804130136.55f633eeb4522f844463159a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804130136.55f633eeb4522f844463159a@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 04, 2021 at 01:01:36PM +0300, Lauri Kasanen wrote:
> > diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
> > index 7b4dd10af9ec..c84be0028f63 100644
> > --- a/drivers/block/n64cart.c
> > +++ b/drivers/block/n64cart.c
> > @@ -74,7 +74,7 @@ static bool n64cart_do_bvec(struct device *dev, struct bio_vec *bv, u32 pos)
> >
> >  	n64cart_wait_dma();
> >
> > -	n64cart_write_reg(PI_DRAM_REG, dma_addr + bv->bv_offset);
> > +	n64cart_write_reg(PI_DRAM_REG, dma_addr);
> >  	n64cart_write_reg(PI_CART_REG, (bstart | CART_DOMAIN) & CART_MAX);
> >  	n64cart_write_reg(PI_WRITE_REG, bv->bv_len - 1);
> 
> Hm, then how did it work? Does it always happen to be zero?

It isn't always zero, but for your use cases it might.  That is if
you have a page aligned buffer (e.g. the page cache) it tends to be
zero.

> Have you tested this? I don't have the equipment currently.

No, I don't.  I'm just auditing uses of bv_offset and this one is
clearly bogus.
