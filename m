Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCDF2EAFF3
	for <lists+linux-block@lfdr.de>; Tue,  5 Jan 2021 17:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbhAEQWX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 Jan 2021 11:22:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:43834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbhAEQWX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Jan 2021 11:22:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A30A6AA7C;
        Tue,  5 Jan 2021 16:21:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 22B401E07FD; Tue,  5 Jan 2021 17:21:41 +0100 (CET)
Date:   Tue, 5 Jan 2021 17:21:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] bfq: Fix computation of shallow depth
Message-ID: <20210105162141.GA28898@quack2.suse.cz>
References: <20201210094433.25491-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210094433.25491-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 10-12-20 10:44:33, Jan Kara wrote:
> BFQ computes number of tags it allows to be allocated for each request type
> based on tag bitmap. However it uses 1 << bitmap.shift as number of
> available tags which is wrong. 'shift' is just an internal bitmap value
> containing logarithm of how many bits bitmap uses in each bitmap word.
> Thus number of tags allowed for some request types can be far to low.
> Use proper bitmap.depth which has the number of tags instead.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Ping Jens? I think it has fallen through the cracks?

								Honza

> ---
>  block/bfq-iosched.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 9e81d1052091..9e4eb0fc1c16 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -6332,13 +6332,13 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
>  	 * limit 'something'.
>  	 */
>  	/* no more than 50% of tags for async I/O */
> -	bfqd->word_depths[0][0] = max((1U << bt->sb.shift) >> 1, 1U);
> +	bfqd->word_depths[0][0] = max(bt->sb.depth >> 1, 1U);
>  	/*
>  	 * no more than 75% of tags for sync writes (25% extra tags
>  	 * w.r.t. async I/O, to prevent async I/O from starving sync
>  	 * writes)
>  	 */
> -	bfqd->word_depths[0][1] = max(((1U << bt->sb.shift) * 3) >> 2, 1U);
> +	bfqd->word_depths[0][1] = max((bt->sb.depth * 3) >> 2, 1U);
>  
>  	/*
>  	 * In-word depths in case some bfq_queue is being weight-
> @@ -6348,9 +6348,9 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
>  	 * shortage.
>  	 */
>  	/* no more than ~18% of tags for async I/O */
> -	bfqd->word_depths[1][0] = max(((1U << bt->sb.shift) * 3) >> 4, 1U);
> +	bfqd->word_depths[1][0] = max((bt->sb.depth * 3) >> 4, 1U);
>  	/* no more than ~37% of tags for sync writes (~20% extra tags) */
> -	bfqd->word_depths[1][1] = max(((1U << bt->sb.shift) * 6) >> 4, 1U);
> +	bfqd->word_depths[1][1] = max((bt->sb.depth * 6) >> 4, 1U);
>  
>  	for (i = 0; i < 2; i++)
>  		for (j = 0; j < 2; j++)
> -- 
> 2.16.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
