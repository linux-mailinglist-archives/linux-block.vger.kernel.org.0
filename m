Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD1B39276
	for <lists+linux-block@lfdr.de>; Fri,  7 Jun 2019 18:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfFGQp7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 7 Jun 2019 12:45:59 -0400
Received: from verein.lst.de ([213.95.11.211]:57399 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbfFGQp7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Jun 2019 12:45:59 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id ED67E68AFE; Fri,  7 Jun 2019 18:45:32 +0200 (CEST)
Date:   Fri, 7 Jun 2019 18:45:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@fb.com,
        Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/6] block: remove the bi_phys_segments field in struct
 bio
Message-ID: <20190607164532.GD7307@lst.de>
References: <20190606102904.4024-1-hch@lst.de> <20190606102904.4024-4-hch@lst.de> <481003ba-aa95-0d0e-ba1f-ce48f2c61105@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <481003ba-aa95-0d0e-ba1f-ce48f2c61105@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 07, 2019 at 08:02:55AM +0200, Hannes Reinecke wrote:
> > +void blk_queue_split(struct request_queue *q, struct bio **bio)
> > +{
> > +	unsigned int nr_segs;
> > +
> > +	__blk_queue_split(q, bio, &nr_segs);
> > +}
> >  EXPORT_SYMBOL(blk_queue_split);
> >  
> That looks a bit weird, and I guess some or other compiler might
> complain here about nr_segs being unused.
> Can't we modify __blk_queue_split() to accept a NULL argument here?

We could.  But that would bloat the fast path for absolutely no
reason.  Passing a by reference output argument that is then ignored
is a pretty common pattern.
