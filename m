Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54621BDC21
	for <lists+linux-block@lfdr.de>; Wed, 29 Apr 2020 14:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD2M2D (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Apr 2020 08:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgD2M2D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 08:28:03 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C5AD2137B;
        Wed, 29 Apr 2020 12:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588163282;
        bh=XnAP/0SRmW6b82kGVzORbOu6imKJ+JO5iY7wdhBk5OA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZbzHRozRVIUDy8f0oo5UZYr65Uzj00zq9rSCbDkodMmTJGNde4MCRR5YJeDWVmuTD
         OrU6J8uCpx41IIwFmjh8jfjym9v/JyPU3cKQiTIh5KgXqf3REznf6+AWB2B1HyaFFX
         ATeWhL6nFu+NyOPUSyXQ7zmGz/laKm3TwnIfE9Fg=
Date:   Wed, 29 Apr 2020 13:27:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200429122757.GA30247@willie-the-truck>
References: <20200424103851.GD28156@lst.de>
 <20200425031723.GC477579@T590>
 <20200425083224.GA5634@lst.de>
 <20200425093437.GA495669@T590>
 <20200425095351.GC495669@T590>
 <20200425154832.GA16004@lst.de>
 <20200428155837.GA16910@hirez.programming.kicks-ass.net>
 <20200429021612.GD671522@T590>
 <20200429080728.GB29143@willie-the-truck>
 <20200429094616.GB700644@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429094616.GB700644@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 05:46:16PM +0800, Ming Lei wrote:
> On Wed, Apr 29, 2020 at 09:07:29AM +0100, Will Deacon wrote:
> > On Wed, Apr 29, 2020 at 10:16:12AM +0800, Ming Lei wrote:
> > > On Tue, Apr 28, 2020 at 05:58:37PM +0200, Peter Zijlstra wrote:
> > > > On Sat, Apr 25, 2020 at 05:48:32PM +0200, Christoph Hellwig wrote:
> > > > >  		atomic_inc(&data.hctx->nr_active);
> > > > >  	}
> > > > >  	data.hctx->tags->rqs[rq->tag] = rq;
> > > > >  
> > > > >  	/*
> > > > > +	 * Ensure updates to rq->tag and tags->rqs[] are seen by
> > > > > +	 * blk_mq_tags_inflight_rqs.  This pairs with the smp_mb__after_atomic
> > > > > +	 * in blk_mq_hctx_notify_offline.  This only matters in case a process
> > > > > +	 * gets migrated to another CPU that is not mapped to this hctx.
> > > > >  	 */
> > > > > +	if (rq->mq_ctx->cpu != get_cpu())
> > > > >  		smp_mb();
> > > > > +	put_cpu();
> > > > 
> > > > This looks exceedingly weird; how do you think you can get to another
> > > > CPU and not have an smp_mb() implied in the migration itself? Also, what
> > > 
> > > What we need is one smp_mb() between the following two OPs:
> > > 
> > > 1) 
> > >    rq->tag = rq->internal_tag;
> > >    data.hctx->tags->rqs[rq->tag] = rq;
> > > 
> > > 2) 
> > > 	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state)))
> > > 
> > > And the pair of the above barrier is in blk_mq_hctx_notify_offline().
> > 
> > I'm struggling with this, so let me explain why. My understanding of the
> > original patch [1] and your explanation above is that you want *either* of
> > the following behaviours
> > 
> >   - __blk_mq_get_driver_tag() (i.e. (1) above) and test_bit(BLK_MQ_S_INACTIVE, ...)
> >     run on the same CPU with barrier() between them, or
> > 
> >   - There is a migration and therefore an implied smp_mb() between them
> > 
> > However, given that most CPUs can speculate loads (and therefore the
> > test_bit() operation), I don't understand how the "everything runs on the
> > same CPU" is safe if a barrier() is required.  In other words, if the
> > barrier() is needed to prevent the compiler hoisting the load, then the CPU
> > can still cause problems.
> 
> Do you think the speculate loads may return wrong value of
> BLK_MQ_S_INACTIVE bit in case of single CPU? BTW, writing the bit is
> done on the same CPU. If yes, this machine may not obey cache consistency,
> IMO.

If the write is on the same CPU, then the read will of course return the
value written by that write, otherwise we'd have much bigger problems!

But then I'm confused, because you're saying that the write is done on the
same CPU, but previously you were saying that migration occuring before (1)
was problematic. Can you explain a bit more about that case, please? What
is running before (1) that is relevant here?

Thanks,

Will
