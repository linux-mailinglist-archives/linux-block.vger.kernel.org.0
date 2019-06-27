Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11BDA57D26
	for <lists+linux-block@lfdr.de>; Thu, 27 Jun 2019 09:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfF0H2e (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Jun 2019 03:28:34 -0400
Received: from verein.lst.de ([213.95.11.211]:50163 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfF0H2e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 03:28:34 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0F08D68B20; Thu, 27 Jun 2019 09:28:00 +0200 (CEST)
Date:   Thu, 27 Jun 2019 09:28:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V4 1/3] block: Allow mapping of vmalloc-ed buffers
Message-ID: <20190627072800.GA9949@lst.de>
References: <20190627024910.23987-1-damien.lemoal@wdc.com> <20190627024910.23987-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627024910.23987-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +#ifdef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE

That seems like an odd constructu, as you don't call
flush_kernel_dcache_page.  From looking whoe defines it it seems
to be about the right set of architectures, but that might be
by a mix of chance and similar requirements for cache flushing.

> +static void bio_invalidate_vmalloc_pages(struct bio *bio)
> +{
> +	if (bio->bi_private) {
> +		struct bvec_iter_all iter_all;
> +		struct bio_vec *bvec;
> +		unsigned long len = 0;
> +
> +		bio_for_each_segment_all(bvec, bio, iter_all)
> +			len += bvec->bv_len;
> +             invalidate_kernel_vmap_range(bio->bi_private, len);

We control the bio here, so we can directly iterate over the
segments instead of doing the fairly expensive bio_for_each_segment_all
call that goes to each page and builds a bvec for it.

> +	struct page *page;
>  	int offset, i;
>  	struct bio *bio;
>  
> @@ -1508,6 +1529,12 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
>  	if (!bio)
>  		return ERR_PTR(-ENOMEM);
>  
> +	if (is_vmalloc) {
> +		flush_kernel_vmap_range(data, len);
> +		if ((!op_is_write(bio_op(bio))))
> +			bio->bi_private = data;
> +	}

We've just allocate the bio, so bio->bi_opf is not actually set at
this point unfortunately.
