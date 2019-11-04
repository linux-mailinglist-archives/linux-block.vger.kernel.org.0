Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B90AEE854
	for <lists+linux-block@lfdr.de>; Mon,  4 Nov 2019 20:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfKDTaJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 Nov 2019 14:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbfKDTaJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Nov 2019 14:30:09 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9691920869;
        Mon,  4 Nov 2019 19:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572895809;
        bh=KIm1BXETWm0K9qnZYKk9XVNAw+iay6pmiy3HTzZD4zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJtKxYGYdCKkcADCiq6ra3B8eoJ2FRTapsMdQf+SGouZcXJWwm3jpduutTYciKyP8
         ZZ/mjJRK31EWhgX+xaZjAdL+W/CcjEN0FszrZbSFqm2M/D+dkL6xWuMuEGNINESHyU
         nq77Q7O+S1hblW9tVH69pOzPHCJpHa8P1fm6VQ5Y=
Date:   Tue, 5 Nov 2019 04:30:02 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: avoid blk_bio_segment_split for small I/O
 operations
Message-ID: <20191104193002.GA21075@redsun51.ssa.fujisawa.hgst.com>
References: <20191104180543.23123-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104180543.23123-1-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 04, 2019 at 10:05:43AM -0800, Christoph Hellwig wrote:
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 48e6725b32ee..06eb38357b41 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -293,7 +293,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  void __blk_queue_split(struct request_queue *q, struct bio **bio,
>  		unsigned int *nr_segs)
>  {
> -	struct bio *split;
> +	struct bio *split = NULL;
>  
>  	switch (bio_op(*bio)) {
>  	case REQ_OP_DISCARD:
> @@ -309,6 +309,19 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
>  				nr_segs);
>  		break;
>  	default:
> +		/*
> +		 * All drivers must accept single-segments bios that are <=
> +		 * PAGE_SIZE.  This is a quick and dirty check that relies on
> +		 * the fact that bi_io_vec[0] is always valid if a bio has data.
> +		 * The check might lead to occasional false negatives when bios
> +		 * are cloned, but compared to the performance impact of cloned
> +		 * bios themselves the loop below doesn't matter anyway.
> +		 */
> +		if ((*bio)->bi_vcnt == 1 &&
> +		    (*bio)->bi_io_vec[0].bv_len <= PAGE_SIZE) {
> +			*nr_segs = 1;
> +			break;
> +		}
>  		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
>  		break;
>  	}

If the device advertises a chunk boundary and this small IO happens to
cross it, skipping the split is going to harm performance.
