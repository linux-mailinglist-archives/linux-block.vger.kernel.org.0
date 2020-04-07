Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B480B1A127D
	for <lists+linux-block@lfdr.de>; Tue,  7 Apr 2020 19:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDGROJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Apr 2020 13:14:09 -0400
Received: from verein.lst.de ([213.95.11.211]:38756 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgDGROJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Apr 2020 13:14:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D3E4968C4E; Tue,  7 Apr 2020 19:14:05 +0200 (CEST)
Date:   Tue, 7 Apr 2020 19:14:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V6 1/8] blk-mq: assign rq->tag in blk_mq_get_driver_tag
Message-ID: <20200407171405.GA5614@lst.de>
References: <20200407092901.314228-1-ming.lei@redhat.com> <20200407092901.314228-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407092901.314228-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 07, 2020 at 05:28:54PM +0800, Ming Lei wrote:
> @@ -472,14 +462,18 @@ static void __blk_mq_free_request(struct request *rq)
>  	struct request_queue *q = rq->q;
>  	struct blk_mq_ctx *ctx = rq->mq_ctx;
>  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> -	const int sched_tag = rq->internal_tag;
> +	const int tag = rq->internal_tag;
> +	bool has_sched = !!hctx->sched_tags;
>  
>  	blk_pm_mark_last_busy(rq);
>  	rq->mq_hctx = NULL;
> +	if (!has_sched)
> +		blk_mq_put_tag(hctx->tags, ctx, tag);
> +	else if (rq->tag >= 0)
>  		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
> +
> +	if (has_sched)
> +		blk_mq_put_tag(hctx->sched_tags, ctx, tag);

This looks weird to me.  Why not simply:

	if (hctx->sched_tags) {
		if (rq->tag >= 0)
			blk_mq_put_tag(hctx->tags, ctx, rq->tag);
		blk_mq_put_tag(hctx->sched_tags, ctx, rq->internal_tag);
	} else {
		blk_mq_put_tag(hctx->tags, ctx, rq->internal_tag);
	}


> @@ -1037,14 +1031,21 @@ bool blk_mq_get_driver_tag(struct request *rq)

FYI, it seems like blk_mq_get_driver_tag can be marked static.

Otherwise this looks pretty sensible to me.
