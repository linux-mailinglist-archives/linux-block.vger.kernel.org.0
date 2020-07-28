Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DA7230BD5
	for <lists+linux-block@lfdr.de>; Tue, 28 Jul 2020 15:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgG1Nyh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Jul 2020 09:54:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730192AbgG1Nyh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 09:54:37 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81933206D4;
        Tue, 28 Jul 2020 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595944476;
        bh=DissLUbAP9Jy5mdAUWXDETYp95SfaSgQ/gBg0BubDx0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Vk40ogl5hUJG1yYnh493OVsakM8AF+Qvn+kq8JHam9/fFZsQrWhbsyb9fztTrw8Gc
         VO4zjgh/KhQM1sksHERfx+BNaAM5GeddGr2y+ALfAaEdW+1d16hwsevqxjhJ2zabCd
         E2nAEjkBxlSC3HJAzc1OTHsGpH6Qfxz2Zop9xOZw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5F3223521361; Tue, 28 Jul 2020 06:54:36 -0700 (PDT)
Date:   Tue, 28 Jul 2020 06:54:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
        Keith Busch <kbusch@kernel.org>, Ming Lin <mlin@kernel.org>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200728135436.GP9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
 <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 28, 2020 at 02:24:38AM -0700, Sagi Grimberg wrote:
> 
> > > I like the tagset based interface.  But the idea of doing a per-hctx
> > > allocation and wait doesn't seem very scalable.
> > > 
> > > Paul, do you have any good idea for an interface that waits on
> > > multiple srcu heads?  As far as I can tell we could just have a single
> > > global completion and counter, and each call_srcu would just just
> > > decrement it and then the final one would do the wakeup.  It would just
> > > be great to figure out a way to keep the struct rcu_synchronize and
> > > counter on stack to avoid an allocation.
> > > 
> > > But if we can't do with an on-stack object I'd much rather just embedd
> > > the rcu_head in the hw_ctx.
> > 
> > I think we can do that, please see the following patch which is against Sagi's V5:
> 
> I don't think you can send a single rcu_head to multiple call_srcu calls.

Indeed you cannot.  And if you build with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
it will yell at you when you try.

You -can- pass on-stack rcu_head structures to call_srcu(), though,
if that helps.  You of course must have some way of waiting for the
callback to be invoked before exiting that function.  This should be
easy for me to package into an API, maybe using one of the existing
reference-counting APIs.

So, do you have a separate stack frame for each of the desired call_srcu()
invocations?  If not, do you know at build time how many rcu_head
structures you need?  If the answer to both of these is "no", then
it is likely that there needs to be an rcu_head in each of the relevant
data structures, as was noted earlier in this thread.

Yeah, I should go read the code.  But I would need to know where it is
and it is still early in the morning over here!  ;-)

I probably should also have read the remainder of the thread before
replying, as well.  But what is the fun in that?

							Thanx, Paul
