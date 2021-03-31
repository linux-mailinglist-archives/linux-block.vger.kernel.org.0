Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC253485ED
	for <lists+linux-block@lfdr.de>; Thu, 25 Mar 2021 01:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbhCYAc2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Mar 2021 20:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239326AbhCYAcQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 20:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616632335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q3e27mFe+SdlrRkFTD0Oi5wfD4h0zwYD1ZYIdliuSD4=;
        b=aqhD5Bi8q+hUzkZ54/IIMgz6uQxhaU9s9BFLWORPfTj9Pz1KxD859KtTbNt+CmZPQ3B+kR
        GZoS/drsYhHGM0pqubmOstUVQ4Ax2bidHuI5MASqyNyy0RvP2U83mzYzwGextU9w/Bk4Yo
        v0kv+sVykgD/vHgWXqmICQzaCsA7ZbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-wOVQGhhfM5i1cd-HZK_ljA-1; Wed, 24 Mar 2021 20:32:14 -0400
X-MC-Unique: wOVQGhhfM5i1cd-HZK_ljA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD2501B2C981;
        Thu, 25 Mar 2021 00:32:12 +0000 (UTC)
Received: from T590 (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B18355D723;
        Thu, 25 Mar 2021 00:32:07 +0000 (UTC)
Date:   Thu, 25 Mar 2021 08:32:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: Re: [PATCH V3 05/13] block: add req flag of REQ_POLL_CTX
Message-ID: <YFvaAl1WakY+rXdC@T590>
References: <20210324121927.362525-1-ming.lei@redhat.com>
 <20210324121927.362525-6-ming.lei@redhat.com>
 <614dcf6d-2b45-394c-d295-c14c14dc9070@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <614dcf6d-2b45-394c-d295-c14c14dc9070@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 24, 2021 at 04:32:31PM +0100, Hannes Reinecke wrote:
> On 3/24/21 1:19 PM, Ming Lei wrote:
> > Add one req flag REQ_POLL_CTX which will be used in the following patch for
> > supporting bio based IO polling.
> > 
> > Exactly this flag can help us to do:
> > 
> > 1) request flag is cloned in bio_fast_clone(), so if we mark one FS bio
> > as REQ_POLL_CTX, all bios cloned from this FS bio will be marked as
> > REQ_POLL_CTX too.
> > 
> > 2) create per-task io polling context if the bio based queue supports
> > polling and the submitted bio is HIPRI. Per-task io poll context will be
> > created during submit_bio() before marking this HIPRI bio as REQ_POLL_CTX.
> > Then we can avoid to create such io polling context if one cloned bio with
> > REQ_POLL_CTX is submitted from another kernel context.
> > 
> > 3) for supporting bio based io polling, we need to poll IOs from all
> > underlying queues of the bio device, this way help us to recognize which
> > IO needs to polled in bio based style, which will be applied in
> > following patch.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-core.c          | 25 ++++++++++++++++++++++++-
> >   include/linux/blk_types.h |  4 ++++
> >   2 files changed, 28 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 4671bbf31fd3..eb07d61cfdc2 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -840,11 +840,30 @@ static inline bool blk_queue_support_bio_poll(struct request_queue *q)
> >   static inline void blk_bio_poll_preprocess(struct request_queue *q,
> >   		struct bio *bio)
> >   {
> > +	bool mq;
> > +
> >   	if (!(bio->bi_opf & REQ_HIPRI))
> >   		return;
> > -	if (!blk_queue_poll(q) || (!queue_is_mq(q) && !blk_get_bio_poll_ctx()))
> > +	/*
> > +	 * Can't support bio based IO polling without per-task poll ctx
> > +	 *
> > +	 * We have created per-task io poll context, and mark this
> > +	 * bio as REQ_POLL_CTX, so: 1) if any cloned bio from this bio is
> > +	 * submitted from another kernel context, we won't create bio
> > +	 * poll context for it, and that bio can be completed by IRQ;
> > +	 * 2) If such bio is submitted from current context, we will
> > +	 * complete it via blk_poll(); 3) If driver knows that one
> > +	 * underlying bio allocated from driver is for FS bio, meantime
> > +	 * it is submitted in current context, driver can mark such bio
> > +	 * as REQ_HIPRI & REQ_POLL_CTX manually, so the bio can be completed
> > +	 * via blk_poll too.
> > +	 */
> > +	mq = queue_is_mq(q);
> > +	if (!blk_queue_poll(q) || (!mq && !blk_get_bio_poll_ctx()))
> >   		bio->bi_opf &= ~REQ_HIPRI;
> > +	else if (!mq)
> > +		bio->bi_opf |= REQ_POLL_CTX;
> >   }
> >   static noinline_for_stack bool submit_bio_checks(struct bio *bio)
> > @@ -894,8 +913,12 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
> >   	/*
> >   	 * Create per-task io poll ctx if bio polling supported and HIPRI
> >   	 * set.
> > +	 *
> > +	 * If REQ_POLL_CTX isn't set for this HIPRI bio, we think it originated
> > +	 * from FS and allocate io polling context.
> >   	 */
> >   	blk_create_io_context(q, blk_queue_support_bio_poll(q) &&
> > +			!(bio->bi_opf & REQ_POLL_CTX) &&
> >   			(bio->bi_opf & REQ_HIPRI));
> >   	blk_bio_poll_preprocess(q, bio);
> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > index db026b6ec15a..99160d588c2d 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -394,6 +394,9 @@ enum req_flag_bits {
> >   	__REQ_HIPRI,
> > +	/* for marking IOs originated from same FS bio in same context */
> > +	__REQ_POLL_CTX,
> > +
> >   	/* for driver use */
> >   	__REQ_DRV,
> >   	__REQ_SWAP,		/* swapping request. */
> > @@ -418,6 +421,7 @@ enum req_flag_bits {
> >   #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
> >   #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
> > +#define REQ_POLL_CTX			(1ULL << __REQ_POLL_CTX)
> >   #define REQ_DRV			(1ULL << __REQ_DRV)
> >   #define REQ_SWAP		(1ULL << __REQ_SWAP)
> > 
> What happens to split bios?
> Will they be tracked similarly to cloned bios?
> If so, shouldn't you document that here, too?

split bios are simply cloned bios, please see bio_split().


thanks,
Ming

