Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC5D1E695C
	for <lists+linux-block@lfdr.de>; Thu, 28 May 2020 20:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405798AbgE1Sby (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 May 2020 14:31:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:52988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405775AbgE1Sbx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 14:31:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2F24AAD1A;
        Thu, 28 May 2020 18:31:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 66B781E1289; Thu, 28 May 2020 20:31:52 +0200 (CEST)
Date:   Thu, 28 May 2020 20:31:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] blktrace: Avoid sparse warnings when assigning
 q->blk_trace
Message-ID: <20200528183152.GH14550@quack2.suse.cz>
References: <20200528092910.11118-1-jack@suse.cz>
 <298af02a-3b58-932a-8769-72dcc52750ad@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <298af02a-3b58-932a-8769-72dcc52750ad@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 28-05-20 07:44:38, Bart Van Assche wrote:
> (+Luis)
> 
> On 2020-05-28 02:29, Jan Kara wrote:
> > Mostly for historical reasons, q->blk_trace is assigned through xchg()
> > and cmpxchg() atomic operations. Although this is correct, sparse
> > complains about this because it violates rcu annotations. Furthermore
> > there's no real need for atomic operations anymore since all changes to
> > q->blk_trace happen under q->blk_trace_mutex. So let's just replace
> > xchg() with rcu_replace_pointer() and cmpxchg() with explicit check and
> > rcu_assign_pointer(). This makes the code more efficient and sparse
> > happy.
> > 
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> How about adding a reference to commit c780e86dd48e ("blktrace: Protect
> q->blk_trace with RCU") in the description of this patch?

Yes, that's probably a good idea.

> > @@ -1669,10 +1672,7 @@ static int blk_trace_setup_queue(struct request_queue *q,
> >  
> >  	blk_trace_setup_lba(bt, bdev);
> >  
> > -	ret = -EBUSY;
> > -	if (cmpxchg(&q->blk_trace, NULL, bt))
> > -		goto free_bt;
> > -
> > +	rcu_assign_pointer(q->blk_trace, bt);
> >  	get_probe_ref();
> >  	return 0;
> 
> This changes a conditional assignment of q->blk_trace into an
> unconditional assignment. Shouldn't q->blk_trace only be assigned if
> q->blk_trace == NULL?

Yes but both callers of blk_trace_setup_queue() actually check that
q->blk_trace is NULL before calling blk_trace_setup_queue() and since we
hold blk_trace_mutex all the time, the value of q->blk_trace cannot change.
So the conditional assignment was just bogus.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
