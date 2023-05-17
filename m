Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7703B7060FF
	for <lists+linux-block@lfdr.de>; Wed, 17 May 2023 09:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjEQHVD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 17 May 2023 03:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjEQHVC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 03:21:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA73E1
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 00:21:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C681868C4E; Wed, 17 May 2023 09:20:58 +0200 (CEST)
Date:   Wed, 17 May 2023 09:20:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH V2 1/2] blk-mq: don't queue plugged passthrough
 requests into scheduler
Message-ID: <20230517072058.GA27026@lst.de>
References: <20230515144601.52811-1-ming.lei@redhat.com> <20230515144601.52811-2-ming.lei@redhat.com> <20230516062221.GA7325@lst.de> <ZGM6WYmCNC7vpDIw@ovpn-8-19.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGM6WYmCNC7vpDIw@ovpn-8-19.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 16, 2023 at 04:10:01PM +0800, Ming Lei wrote:
> On Tue, May 16, 2023 at 08:22:21AM +0200, Christoph Hellwig wrote:
> > On Mon, May 15, 2023 at 10:46:00PM +0800, Ming Lei wrote:
> > > +		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx ||
> > > +				pt != blk_rq_is_passthrough(rq)) {
> > 
> > Can your format this as:
> > 
> > 		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx ||
> > 			   pt != blk_rq_is_passthrough(rq)) {
> > 
> > for readability?
> 
> Do you mean indent for 'pt = blk_rq_is_passthrough(rq)' and keep 'pt' aligned
> with 'if' in last line?

Yes.

> > This comment confuses the heck out of me.  The check if for passthrough
> > vs non-passthrough and doesn't involved flush requests at all.
> > 
> > I'd prefer to drop it, and instead comment on passthrough requests
> > not going to the scheduled below where we actually issue other requests
> > to the scheduler.
> 
> Any request can be in plug list in theory, we just don't add flush request
> to plug, that is why the above comment is added. If you don't like the
> words for flush request, I can drop it.

I just don't think it maks any sense in this context.  If we want to
enforce the invariant that there's no flush request I'd rather add a
WARN_ON to not only talk about enforce it.  I'm not sure it's really
required, though.

> > > +	if (pt) {
> > > +		spin_lock(&this_hctx->lock);
> > > +		list_splice_tail_init(&list, &this_hctx->dispatch);
> > > +		spin_unlock(&this_hctx->lock);
> > > +		blk_mq_run_hw_queue(this_hctx, from_sched);
> > 
> > .. aka here.  But why can't we just use the blk_mq_insert_requests
> > for this case anyway?
> 
> If the pt request is part of error recovery, it should be issued to
> ->dispatch list directly, so just for the sake of safety, meantime keep
> same behavior with blk_mq_insert_request().

But if it is part of error recovery it won't be plugged.  Please don't
do weird cargo cult things here and just use the common helpers.
