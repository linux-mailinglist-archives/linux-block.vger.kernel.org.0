Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFAB245C85
	for <lists+linux-block@lfdr.de>; Mon, 17 Aug 2020 08:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgHQGb5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 17 Aug 2020 02:31:57 -0400
Received: from verein.lst.de ([213.95.11.211]:55197 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgHQGbz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 02:31:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 46E4B67357; Mon, 17 Aug 2020 08:31:53 +0200 (CEST)
Date:   Mon, 17 Aug 2020 08:31:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 4/5] block: Remove blk_mq_attempt_merge()
 function
Message-ID: <20200817063153.GD12248@lst.de>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com> <b9ae58ae4bc8b16a53fabd35ce163897286d856a.1597637287.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9ae58ae4bc8b16a53fabd35ce163897286d856a.1597637287.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 17, 2020 at 12:09:18PM +0800, Baolin Wang wrote:
>  		unsigned int nr_segs)
>  {
> @@ -447,7 +425,16 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
>  			!list_empty_careful(&ctx->rq_lists[type])) {
>  		/* default per sw-queue merge */
>  		spin_lock(&ctx->lock);
> -		ret = blk_mq_attempt_merge(q, hctx, ctx, bio, nr_segs);
> +		/*
> +		 * Reverse check our software queue for entries that we could
> +		 * potentially merge with. Currently includes a hand-wavy stop
> +		 * count of 8, to not spend too much time checking for merges.
> +		 */
> +		if (blk_mq_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs)) {
> +			ctx->rq_merged++;
> +			ret = true;
> +		}
> +
>  		spin_unlock(&ctx->lock);

This adds an overly long line.  That being said the whole thing could
be nicely simplified to:

	...

	if (e && e->type->ops.bio_merge)
		return e->type->ops.bio_merge(hctx, bio, nr_segs);

	if (!(hctx->flags & BLK_MQ_F_SHOULD_MERGE) ||
	    list_empty_careful(&ctx->rq_lists[hctx->type]))
		return false;

	/*
	 * Reverse check our software queue for entries that we could
	 * potentially merge with. Currently includes a hand-wavy stop count of
	 * 8, to not spend too much time checking for merges.
	 */
	spin_lock(&ctx->lock);
	ret = blk_mq_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs);
	if (ret)
		ctx->rq_merged++;
	spin_unlock(&ctx->lock);

Also I think it would make sense to move the locking into
blk_mq_bio_list_merge.
