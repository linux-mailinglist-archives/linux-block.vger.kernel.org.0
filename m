Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93564157D6
	for <lists+linux-block@lfdr.de>; Thu, 23 Sep 2021 07:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhIWF2j (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 Sep 2021 01:28:39 -0400
Received: from verein.lst.de ([213.95.11.211]:34273 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhIWF2i (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 01:28:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C8ED67373; Thu, 23 Sep 2021 07:27:05 +0200 (CEST)
Date:   Thu, 23 Sep 2021 07:27:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] block: drain file system I/O on del_gendisk
Message-ID: <20210923052705.GA5314@lst.de>
References: <20210922172222.2453343-1-hch@lst.de> <20210922172222.2453343-4-hch@lst.de> <YUvZi2a0KjxEkiHo@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUvZi2a0KjxEkiHo@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 23, 2021 at 09:34:03AM +0800, Ming Lei wrote:
> > +	set_bit(GD_DEAD, &disk->state);
> >  	set_capacity(disk, 0);
> >  
> > +	/*
> > +	 * Prevent new I/O from crossing bio_queue_enter().
> > +	 */
> > +	blk_queue_start_drain(q);
> > +	blk_mq_freeze_queue_wait(q);
> > +
> > +	rq_qos_exit(q);
> > +	blk_sync_queue(q);
> > +	blk_flush_integrity();
> > +	/*
> > +	 * Allow using passthrough request again after the queue is torn down.
> > +	 */
> > +	blk_mq_unfreeze_queue(q);
> 
> After blk_mq_unfreeze_queue() returns, blk_try_enter_queue() will return
> true, so new FS I/O from opened bdev still won't be blocked, right?

It won't be blocked by blk_mq_unfreeze_queue, but because the capacity
is set to 0 it still won't make it to the driver.
