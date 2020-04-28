Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3371BB710
	for <lists+linux-block@lfdr.de>; Tue, 28 Apr 2020 08:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgD1Gyy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Apr 2020 02:54:54 -0400
Received: from verein.lst.de ([213.95.11.211]:54378 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgD1Gyy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 02:54:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C326568C7B; Tue, 28 Apr 2020 08:54:50 +0200 (CEST)
Date:   Tue, 28 Apr 2020 08:54:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200428065450.GA18754@lst.de>
References: <20200424102351.475641-1-ming.lei@redhat.com> <20200424102351.475641-8-ming.lei@redhat.com> <20200424103851.GD28156@lst.de> <20200425031723.GC477579@T590> <20200425083224.GA5634@lst.de> <20200425093437.GA495669@T590> <20200425095351.GC495669@T590> <20200425154832.GA16004@lst.de> <20200427190337.GK7560@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427190337.GK7560@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 27, 2020 at 12:03:37PM -0700, Paul E. McKenney wrote:
> On Sat, Apr 25, 2020 at 05:48:32PM +0200, Christoph Hellwig wrote:
> > FYI, here is what I think we should be doing (but the memory model
> > experts please correct me):
> 
> I would be happy to, but could you please tell me what to apply this
> against?  I made several wrong guesses, and am not familiar enough with
> this code to evaluate this patch in isolation.

Here is a link to the whole series on lore:

https://lore.kernel.org/linux-block/1eba973b-25cf-88bd-7284-d86730b4ddf2@kernel.dk/T/#t
