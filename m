Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B48D265D04
	for <lists+linux-block@lfdr.de>; Fri, 11 Sep 2020 11:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgIKJxE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Sep 2020 05:53:04 -0400
Received: from verein.lst.de ([213.95.11.211]:36286 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgIKJxB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 05:53:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C59B68B02; Fri, 11 Sep 2020 11:52:58 +0200 (CEST)
Date:   Fri, 11 Sep 2020 11:52:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        David Milburn <dmilburn@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH] blk-mq: always allow reserved allocation in
 hctx_may_queue
Message-ID: <20200911095258.GA914@lst.de>
References: <20200911094453.160109-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911094453.160109-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 11, 2020 at 05:44:53PM +0800, Ming Lei wrote:
>  	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
>  	int tag;
> +	bool reserved = blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags,
> +			rq->internal_tag);
>  
>  	blk_mq_tag_busy(rq->mq_hctx);
>  
> -	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
> +	if (reserved) {
>  		bt = rq->mq_hctx->tags->breserved_tags;
>  		tag_offset = 0;
>  	}
>  
> -	if (!hctx_may_queue(rq->mq_hctx, bt))
> +	if (!reserved && !hctx_may_queue(rq->mq_hctx, bt))

What about:

	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
  		bt = rq->mq_hctx->tags->breserved_tags;
  		tag_offset = 0;
	} else {
		if (!hctx_may_queue(rq->mq_hctx, bt))
	 		return false;
	}

which seems a little easier to follow?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
