Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFA744E2EF
	for <lists+linux-block@lfdr.de>; Fri, 12 Nov 2021 09:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhKLIYe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 12 Nov 2021 03:24:34 -0500
Received: from verein.lst.de ([213.95.11.211]:60413 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230464AbhKLIYd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 03:24:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id EB22A68AA6; Fri, 12 Nov 2021 09:21:40 +0100 (CET)
Date:   Fri, 12 Nov 2021 09:21:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: setup blk_mq_alloc_data.cmd_flags after
 submit_bio_checks() is done
Message-ID: <20211112082140.GA30681@lst.de>
References: <20211112081137.406930-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112081137.406930-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 12, 2021 at 04:11:37PM +0800, Ming Lei wrote:
> @@ -2564,13 +2564,15 @@ static inline struct request *blk_mq_get_request(struct request_queue *q,
>  			if (blk_mq_attempt_bio_merge(q, bio, nsegs,
>  						same_queue_rq))
>  				return NULL;
> +			if (bio->bi_opf != rq->cmd_flags)
> +				goto fallback;

I think this deserves a comment, as this means a read prealloc
can only be used for reads, and no fua can be set if the preallocating
I/O didn't use fua, etc.

What are the pitfalls of just chanigng cmd_flags?
