Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B211E0A34
	for <lists+linux-block@lfdr.de>; Mon, 25 May 2020 11:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbgEYJVN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 25 May 2020 05:21:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39801 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389352AbgEYJVN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 05:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590398470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bHwc3ISLSs9+E/DWUI7MgmeV4rADM3VzcEPWbpT0roA=;
        b=EqqQJeS1lBnOf0GM0q26UDo4A5AG30oYVs0tNjj7+OfzC5EWXavlEtElCz0BkyPDGsui4g
        Z98TnTpG12itJAxjII6W/zt1XQidN6oXZ/ZBqTtftJTBPGQGnF+D+t4P8WsMr8tz4N1RsV
        KSqn34sFinTxeo44cQwKXCP6elEQthM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-n4gfDXT5MU2MZbN9N8qF0g-1; Mon, 25 May 2020 05:21:05 -0400
X-MC-Unique: n4gfDXT5MU2MZbN9N8qF0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E8D4107ACCA;
        Mon, 25 May 2020 09:21:03 +0000 (UTC)
Received: from T590 (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 248AD19D61;
        Mon, 25 May 2020 09:20:54 +0000 (UTC)
Date:   Mon, 25 May 2020 17:20:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6/6] blk-mq: drain I/O when all CPUs in a hctx are offline
Message-ID: <20200525092050.GA802845@T590>
References: <20200520170635.2094101-1-hch@lst.de>
 <20200520170635.2094101-7-hch@lst.de>
 <98028672-be06-fb18-8cb3-b4ae1422caf9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98028672-be06-fb18-8cb3-b4ae1422caf9@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 22, 2020 at 11:25:42AM +0200, Hannes Reinecke wrote:
> On 5/20/20 7:06 PM, Christoph Hellwig wrote:
> > From: Ming Lei <ming.lei@redhat.com>
> > 
> > Most of blk-mq drivers depend on managed IRQ's auto-affinity to setup
> > up queue mapping. Thomas mentioned the following point[1]:
> > 
> > "That was the constraint of managed interrupts from the very beginning:
> > 
> >   The driver/subsystem has to quiesce the interrupt line and the associated
> >   queue _before_ it gets shutdown in CPU unplug and not fiddle with it
> >   until it's restarted by the core when the CPU is plugged in again."
> > 
> > However, current blk-mq implementation doesn't quiesce hw queue before
> > the last CPU in the hctx is shutdown.  Even worse, CPUHP_BLK_MQ_DEAD is a
> > cpuhp state handled after the CPU is down, so there isn't any chance to
> > quiesce the hctx before shutting down the CPU.
> > 
> > Add new CPUHP_AP_BLK_MQ_ONLINE state to stop allocating from blk-mq hctxs
> > where the last CPU goes away, and wait for completion of in-flight
> > requests.  This guarantees that there is no inflight I/O before shutting
> > down the managed IRQ.
> > 
> > Add a BLK_MQ_F_STACKING and set it for dm-rq and loop, so we don't need
> > to wait for completion of in-flight requests from these drivers to avoid
> > a potential dead-lock. It is safe to do this for stacking drivers as those
> > do not use interrupts at all and their I/O completions are triggered by
> > underlying devices I/O completion.
> > 
> > [1] https://lore.kernel.org/linux-block/alpine.DEB.2.21.1904051331270.1802@nanos.tec.linutronix.de/
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > [hch: different retry mechanism, merged two patches, minor cleanups]
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >   block/blk-mq-debugfs.c     |   2 +
> >   block/blk-mq-tag.c         |   8 +++
> >   block/blk-mq.c             | 114 ++++++++++++++++++++++++++++++++++++-
> >   drivers/block/loop.c       |   2 +-
> >   drivers/md/dm-rq.c         |   2 +-
> >   include/linux/blk-mq.h     |  10 ++++
> >   include/linux/cpuhotplug.h |   1 +
> >   7 files changed, 135 insertions(+), 4 deletions(-)
> > 
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index 96b7a35c898a7..15df3a36e9fa4 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -213,6 +213,7 @@ static const char *const hctx_state_name[] = {
> >   	HCTX_STATE_NAME(STOPPED),
> >   	HCTX_STATE_NAME(TAG_ACTIVE),
> >   	HCTX_STATE_NAME(SCHED_RESTART),
> > +	HCTX_STATE_NAME(INACTIVE),
> >   };
> >   #undef HCTX_STATE_NAME
> > @@ -239,6 +240,7 @@ static const char *const hctx_flag_name[] = {
> >   	HCTX_FLAG_NAME(TAG_SHARED),
> >   	HCTX_FLAG_NAME(BLOCKING),
> >   	HCTX_FLAG_NAME(NO_SCHED),
> > +	HCTX_FLAG_NAME(STACKING),
> >   };
> >   #undef HCTX_FLAG_NAME
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index c27c6dfc7d36e..3925d1e55bc8f 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -180,6 +180,14 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
> >   	sbitmap_finish_wait(bt, ws, &wait);
> >   found_tag:
> > +	/*
> > +	 * Give up this allocation if the hctx is inactive.  The caller will
> > +	 * retry on an active hctx.
> > +	 */
> > +	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state))) {
> > +		blk_mq_put_tag(tags, data->ctx, tag + tag_offset);
> > +		return -1;
> > +	}
> >   	return tag + tag_offset;
> >   }
> I really wish we could have a dedicated NO_TAG value; returning
> -1 for an unsigned int always feels dodgy.
> And we could kill all the various internal definitions in drivers/scsi ...
> 
> Hmm?

Good catch.

> 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 42aee2978464b..672c7e3f61243 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -375,14 +375,32 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
> >   			e->type->ops.limit_depth(data->cmd_flags, data);
> >   	}
> > +retry:
> >   	data->ctx = blk_mq_get_ctx(q);
> >   	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
> >   	if (!(data->flags & BLK_MQ_REQ_INTERNAL))
> >   		blk_mq_tag_busy(data->hctx);
> > +	/*
> > +	 * Waiting allocations only fail because of an inactive hctx.  In that
> > +	 * case just retry the hctx assignment and tag allocation as CPU hotplug
> > +	 * should have migrated us to an online CPU by now.
> > +	 */
> >   	tag = blk_mq_get_tag(data);
> > -	if (tag == BLK_MQ_TAG_FAIL)
> > -		return NULL;
> > +	if (tag == BLK_MQ_TAG_FAIL) {
> > +		if (data->flags & BLK_MQ_REQ_NOWAIT)
> > +			return NULL;
> > +
> > +		/*
> > +		 * All kthreads that can perform I/O should have been moved off
> > +		 * this CPU by the time the the CPU hotplug statemachine has
> > +		 * shut down a hctx.  But better be sure with an extra sanity
> > +		 * check.
> > +		 */
> > +		if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
> > +			return NULL;
> > +		goto retry;
> > +	}
> >   	return blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
> >   }
> > @@ -2324,6 +2342,86 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
> >   	return -ENOMEM;
> >   }
> > +struct rq_iter_data {
> > +	struct blk_mq_hw_ctx *hctx;
> > +	bool has_rq;
> > +};
> > +
> > +static bool blk_mq_has_request(struct request *rq, void *data, bool reserved)
> > +{
> > +	struct rq_iter_data *iter_data = data;
> > +
> > +	if (rq->mq_hctx != iter_data->hctx)
> > +		return true;
> > +	iter_data->has_rq = true;
> > +	return false;
> > +}
> > +
> > +static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
> > +{
> > +	struct blk_mq_tags *tags = hctx->sched_tags ?
> > +			hctx->sched_tags : hctx->tags;
> > +	struct rq_iter_data data = {
> > +		.hctx	= hctx,
> > +	};
> > +
> > +	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
> > +	return data.has_rq;
> > +}
> > +
> To my reading this would only work reliably if we run the iteration on one
> of the cpus in the corresponding mask for the hctx.
> Yet I fail to see any provision for this neither here nor in the previous
> patch
> How do you guarantee that?
> Or is there some implicit mechanism which I've missed?

Yeah, it is guaranteed by memory barrier.

[1] tag allocation path

sbitmap_get()	/* smp_mb() is implied */
test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state)

[2] cpu is going to offline

set_bit(BLK_MQ_S_INACTIVE, &data->hctx->state)
smp_mb__after_atomic();
blk_mq_hctx_has_requests()
	blk_mq_all_tag_iter
		bt_tags_for_each
			sbitmap_for_each_set

So setting tag bit and reading BLK_MQ_S_INACTIVE is ordered, and
setting BLK_MQ_S_INACTIVE and readding tag bit is ordered too.

Then either one request is re-tried to be allocated on another online CPU,
or the request is allocated & drained before the cpu is going to
offline.


Thanks,
Ming

