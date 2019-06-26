Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC6F5620F
	for <lists+linux-block@lfdr.de>; Wed, 26 Jun 2019 08:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbfFZGKu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Jun 2019 02:10:50 -0400
Received: from verein.lst.de ([213.95.11.211]:40394 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZGKu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 02:10:50 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5D7E768B05; Wed, 26 Jun 2019 08:10:17 +0200 (CEST)
Date:   Wed, 26 Jun 2019 08:10:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2 1/3] block: Allow mapping of vmalloc-ed buffers
Message-ID: <20190626061016.GA23902@lst.de>
References: <20190626014759.15285-1-damien.lemoal@wdc.com> <20190626014759.15285-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626014759.15285-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 26, 2019 at 10:47:57AM +0900, Damien Le Moal wrote:
> @@ -1501,9 +1502,14 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
>  	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	unsigned long start = kaddr >> PAGE_SHIFT;
>  	const int nr_pages = end - start;
> +	bool is_vmalloc = is_vmalloc_addr(data);
> +	struct page *page;
>  	int offset, i;
>  	struct bio *bio;
>  
> +	if (is_vmalloc)
> +		invalidate_kernel_vmap_range(data, len);

That is not correct.

The submission path needs an unconditional flush_kernel_vmap_range call,
and the read completion path will additionally need the
invalidate_kernel_vmap_range call.
