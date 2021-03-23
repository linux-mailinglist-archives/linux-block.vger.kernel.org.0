Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4E6345E2E
	for <lists+linux-block@lfdr.de>; Tue, 23 Mar 2021 13:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCWMaW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Mar 2021 08:30:22 -0400
Received: from verein.lst.de ([213.95.11.211]:60310 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231142AbhCWMaF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 08:30:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2C21A68B02; Tue, 23 Mar 2021 13:30:03 +0100 (CET)
Date:   Tue, 23 Mar 2021 13:30:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: support zone append bvecs
Message-ID: <20210323123002.GA30758@lst.de>
References: <739a96e185f008c238fcf06cb22068016149ad4a.1616497531.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <739a96e185f008c238fcf06cb22068016149ad4a.1616497531.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 23, 2021 at 08:06:56PM +0900, Johannes Thumshirn wrote:
> diff --git a/block/bio.c b/block/bio.c
> index 26b7f721cda8..215fe24a01ee 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1094,8 +1094,14 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	int ret = 0;
>  
>  	if (iov_iter_is_bvec(iter)) {
> -		if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
> -			return -EINVAL;
> +		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> +			struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> +			unsigned int max_append =
> +				queue_max_zone_append_sectors(q) << 9;
> +
> +			if (WARN_ON_ONCE(iter->count > max_append))
> +				return -EINVAL;
> +		}

That is not correct.  bio_iov_iter_get_pages just fills the bio as far
as we can, and then returns 0 for the next call to continue.  Basically
what you want here is a partial version of bio_iov_bvec_set.
