Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF8D1D1217
	for <lists+linux-block@lfdr.de>; Wed, 13 May 2020 14:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgEMMA0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 08:00:26 -0400
Received: from verein.lst.de ([213.95.11.211]:46085 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728379AbgEMMA0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:00:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D788668BEB; Wed, 13 May 2020 14:00:23 +0200 (CEST)
Date:   Wed, 13 May 2020 14:00:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V11 08/12] block: add blk_end_flush_machinery
Message-ID: <20200513120023.GD6297@lst.de>
References: <20200513034803.1844579-1-ming.lei@redhat.com> <20200513034803.1844579-9-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513034803.1844579-9-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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

> +	/* Send flush via one active hctx so we can move on */
> +	bdev = bdget_disk(rq->rq_disk, 0);
> +	if (bdev) {
> +		error = blkdev_issue_flush(bdev, GFP_KERNEL, NULL);
> +		bdput(bdev);
> +	}

As mentioned before:  please don't add pointless bdget calls, as we
don't even need the block_device.  Just open code the trivial bits of
blkdev_issue_flushblkdev_issue_flush that are needed.
