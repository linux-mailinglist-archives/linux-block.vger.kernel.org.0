Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2651D2403
	for <lists+linux-block@lfdr.de>; Thu, 14 May 2020 02:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733170AbgENAk2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 20:40:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28081 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732970AbgENAk2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 20:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589416826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rVQTgpgPdk29UNIpQa8a+u3KQ3nyPdkOh2jfhRTBF6g=;
        b=aWlsIHxQ7u7D6OKiyhPN/uXFNXv/FzqXtWlpIem68ILCUArITZc/xqkm8GBwbKvFqiTveS
        ipgMWHpGc7V0dsAvxhozrAScqf9FhvTib71wbuoe5FNojOBfOdtbklMebyUEMaulVnpxdE
        5GA3G+BqD9dOX5C0mVPYjXCgP7yctGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-KKVuixf8PByiCQgl3ppEeg-1; Wed, 13 May 2020 20:40:22 -0400
X-MC-Unique: KKVuixf8PByiCQgl3ppEeg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6C391005512;
        Thu, 14 May 2020 00:40:20 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2442C5C1D6;
        Thu, 14 May 2020 00:40:13 +0000 (UTC)
Date:   Thu, 14 May 2020 08:40:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V11 11/12] blk-mq: re-submit IO in case that hctx is
 inactive
Message-ID: <20200514004004.GC2073570@T590>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
 <20200513034803.1844579-12-ming.lei@redhat.com>
 <20200513122147.GF6297@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513122147.GF6297@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 02:21:47PM +0200, Christoph Hellwig wrote:
> Use of the BLK_MQ_REQ_FORCE is pretty bogus here..
> 
> > +	if (rq->rq_flags & RQF_PREEMPT)
> > +		flags |= BLK_MQ_REQ_PREEMPT;
> > +	if (reserved)
> > +		flags |= BLK_MQ_REQ_RESERVED;
> > +	/*
> > +	 * Queue freezing might be in-progress, and wait freeze can't be
> > +	 * done now because we have request not completed yet, so mark this
> > +	 * allocation as BLK_MQ_REQ_FORCE for avoiding this allocation &
> > +	 * freeze hung forever.
> > +	 */
> > +	flags |= BLK_MQ_REQ_FORCE;
> > +
> > +	/* avoid allocation failure by clearing NOWAIT */
> > +	nrq = blk_get_request(rq->q, rq->cmd_flags & ~REQ_NOWAIT, flags);
> > +	if (!nrq)
> > +		return;
> 
> blk_get_request returns an ERR_PTR.
> 
> But I'd rather avoid the magic new BLK_MQ_REQ_FORCE hack when we can
> just open code it and document what is going on:

BLK_MQ_REQ_FORCE is actually not a hack, there are other use cases
which need that too, see commit log of patch 10/12.

> 
> static struct blk_mq_tags *blk_mq_rq_tags(struct request *rq)
> {
> 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> 
> 	if (rq->q->elevator)
> 		return hctx->sched_tags;
> 	return hctx->tags;
> }
> 
> static void blk_mq_resubmit_rq(struct request *rq)
> {
> 	struct blk_mq_alloc_data alloc_data = {
> 		.cmd_flags	= rq->cmd_flags & ~REQ_NOWAIT;
> 	};
> 	struct request *nrq;
> 
> 	if (rq->rq_flags & RQF_PREEMPT)
> 		alloc_data.flags |= BLK_MQ_REQ_PREEMPT;
> 	if (blk_mq_tag_is_reserved(blk_mq_rq_tags(rq), rq->internal_tag))
> 		alloc_data.flags |= BLK_MQ_REQ_RESERVED;
> 
> 	/*
> 	 * We must still be able to finish a resubmission due to a hotplug
> 	 * even even if a queue freeze is in progress.
> 	 */
> 	percpu_ref_get(&q->q_usage_counter);
> 	nrq = blk_mq_get_request(rq->q, NULL, &alloc_data);
> 	blk_queue_exit(q);

This way works too.

> 
> 	if (!nrq)
> 		return; // XXX: warn?

It isn't possible because we clears NO_WAIT flag.


Thanks, 
Ming

