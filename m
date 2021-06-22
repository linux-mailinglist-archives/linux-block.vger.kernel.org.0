Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE8A3AFD76
	for <lists+linux-block@lfdr.de>; Tue, 22 Jun 2021 08:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFVG5c (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Jun 2021 02:57:32 -0400
Received: from verein.lst.de ([213.95.11.211]:45321 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhFVG53 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 02:57:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4997A67357; Tue, 22 Jun 2021 08:55:12 +0200 (CEST)
Date:   Tue, 22 Jun 2021 08:55:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Wang Shanker <shankerwangmiao@gmail.com>
Subject: Re: [PATCH 2/2] block: support bio merge for multi-range discard
Message-ID: <20210622065511.GB29691@lst.de>
References: <20210609004556.46928-1-ming.lei@redhat.com> <20210609004556.46928-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609004556.46928-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 09, 2021 at 08:45:56AM +0800, Ming Lei wrote:
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index bcdff1879c34..65210e9a8efa 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -724,10 +724,10 @@ static inline bool blk_discard_mergable(struct request *req)
>  static enum elv_merge blk_try_req_merge(struct request *req,
>  					struct request *next)
>  {
> -	if (blk_discard_mergable(req))
> -		return ELEVATOR_DISCARD_MERGE;
> -	else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
> +	if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
>  		return ELEVATOR_BACK_MERGE;

Oh well, this breaks my previous suggestions.

> +		struct req_discard_range r;
> +
> +		rq_for_each_discard_range(r, req) {

... and I can't say I like this rather complex iterator.

What is the problem of just fixing the raid code to not submit stupidly
small discard requests instead?
