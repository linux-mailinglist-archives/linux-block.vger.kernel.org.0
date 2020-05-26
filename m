Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543EA1B722E
	for <lists+linux-block@lfdr.de>; Fri, 24 Apr 2020 12:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgDXKlk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Apr 2020 06:41:40 -0400
Received: from verein.lst.de ([213.95.11.211]:34319 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgDXKlk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 06:41:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 43D3C68CEE; Fri, 24 Apr 2020 12:41:37 +0200 (CEST)
Date:   Fri, 24 Apr 2020 12:41:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 08/11] block: add blk_end_flush_machinery
Message-ID: <20200424104136.GE28156@lst.de>
References: <20200424102351.475641-1-ming.lei@redhat.com> <20200424102351.475641-9-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424102351.475641-9-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 24, 2020 at 06:23:48PM +0800, Ming Lei wrote:
> +/* complete requests which just requires one flush command */
> +static void blk_complete_flush_requests(struct blk_flush_queue *fq,
> +		struct list_head *flush_list)
> +{
> +	struct block_device *bdev;
> +	struct request *rq;
> +	int error = -ENXIO;
> +
> +	if (list_empty(flush_list))
> +		return;
> +
> +	rq = list_first_entry(flush_list, struct request, queuelist);
> +
> +	/* Send flush via one active hctx so we can move on */
> +	bdev = bdget_disk(rq->rq_disk, 0);
> +	if (bdev) {
> +		error = blkdev_issue_flush(bdev, GFP_KERNEL, NULL);
> +		bdput(bdev);
> +	}

FYI, we don't really need the bdev to send a bio anymore, this could just
do:

	bio = bio_alloc(GFP_KERNEL, 0); // XXX: shouldn't this be GFP_NOIO??
	bio->bi_disk = rq->rq_disk;
	bio->bi_partno = 0;
	bio_associate_blkg(bio); // XXX: actually, shouldn't this come from rq?
	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
	error = submit_bio_wait(bio);
	bio_put(bio);

