Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D43522FF6F
	for <lists+linux-block@lfdr.de>; Tue, 28 Jul 2020 04:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgG1CSF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Jul 2020 22:18:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57198 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726247AbgG1CSE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 22:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595902682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRr0s/+nd1++TZkkLCmAJQ0c2kzcOd+I34nkvoL12so=;
        b=hr6D5nXW3pKmxmEjAfyvvGHY1YK2KnmqGdu/cfI1/P/QMOc+JOLCzZJaycE82QC56dGBJa
        8i1lbZTMNE+2tHeeV0jC3iMgNONuwICMbU38f1D2+iN+kXO431Hdx+uKSKrYOEoEo3A2s3
        AhSHm3XonsMPVULEL7fyisdd46sGgTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-T0DFJtclMPSxw-AbjktqdA-1; Mon, 27 Jul 2020 22:17:58 -0400
X-MC-Unique: T0DFJtclMPSxw-AbjktqdA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C56A101C8A5;
        Tue, 28 Jul 2020 02:17:57 +0000 (UTC)
Received: from T590 (ovpn-12-109.pek2.redhat.com [10.72.12.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACC3890E6B;
        Tue, 28 Jul 2020 02:17:48 +0000 (UTC)
Date:   Tue, 28 Jul 2020 10:17:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Ming Lin <mlin@kernel.org>, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200728021744.GB1305646@T590>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
 <20200728014038.GA1305646@T590>
 <1d119df0-c3af-2dfa-d569-17109733ac80@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d119df0-c3af-2dfa-d569-17109733ac80@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 27, 2020 at 07:51:16PM -0600, Jens Axboe wrote:
> On 7/27/20 7:40 PM, Ming Lei wrote:
> > On Mon, Jul 27, 2020 at 04:10:21PM -0700, Sagi Grimberg wrote:
> >> drivers that have shared tagsets may need to quiesce potentially a lot
> >> of request queues that all share a single tagset (e.g. nvme). Add an interface
> >> to quiesce all the queues on a given tagset. This interface is useful because
> >> it can speedup the quiesce by doing it in parallel.
> >>
> >> For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
> >> in parallel such that all of them wait for the same rcu elapsed period with
> >> a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
> >> BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
> >> sufficient.
> >>
> >> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> >> ---
> >>  block/blk-mq.c         | 66 ++++++++++++++++++++++++++++++++++++++++++
> >>  include/linux/blk-mq.h |  4 +++
> >>  2 files changed, 70 insertions(+)
> >>
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index abcf590f6238..c37e37354330 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -209,6 +209,42 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
> >>  }
> >>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
> >>  
> >> +static void blk_mq_quiesce_blocking_queue_async(struct request_queue *q)
> >> +{
> >> +	struct blk_mq_hw_ctx *hctx;
> >> +	unsigned int i;
> >> +
> >> +	blk_mq_quiesce_queue_nowait(q);
> >> +
> >> +	queue_for_each_hw_ctx(q, hctx, i) {
> >> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
> >> +		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
> >> +		if (!hctx->rcu_sync)
> >> +			continue;
> > 
> > This approach of quiesce/unquiesce tagset is good abstraction.
> > 
> > Just one more thing, please allocate a rcu_sync array because hctx is
> > supposed to not store scratch stuff.
> 
> I'd be all for not stuffing this in the hctx, but how would that work?
> The only thing I can think of that would work reliably is batching the
> queue+wait into units of N. We could potentially have many thousands of
> queues, and it could get iffy (and/or unreliable) in terms of allocation
> size. Looks like rcu_synchronize is 48-bytes on my local install, and it
> doesn't take a lot of devices at current CPU counts to make an alloc
> covering all of it huge. Let's say 64 threads, and 32 devices, then
> we're already at 64*32*48 bytes which is an order 5 allocation. Not
> friendly, and not going to be reliable when you need it. And if we start
> batching in reasonable counts, then we're _almost_ back to doing a queue
> or two at the time... 32 * 48 is 1536 bytes, so we could only do two at
> the time for single page allocations.

We can convert to order 0 allocation by one extra indirect array. 


Thanks,
Ming

