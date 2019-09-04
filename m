Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C800EA7AF1
	for <lists+linux-block@lfdr.de>; Wed,  4 Sep 2019 07:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfIDFuA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Sep 2019 01:50:00 -0400
Received: from verein.lst.de ([213.95.11.211]:36091 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDFuA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Sep 2019 01:50:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 69660227A8A; Wed,  4 Sep 2019 07:49:56 +0200 (CEST)
Date:   Wed, 4 Sep 2019 07:49:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        linux-block@vger.kernel.org, martin.petersen@oracle.com,
        linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH 1/4] block: centrelize PI remapping logic to the block
 layer
Message-ID: <20190904054956.GA10553@lst.de>
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com> <8df57b71-9404-904d-7abd-587942814039@grimberg.me> <e9e36b41-f262-e825-15dc-aecadb44cf85@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9e36b41-f262-e825-15dc-aecadb44cf85@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 03, 2019 at 01:21:59PM -0600, Jens Axboe wrote:
> On 9/3/19 1:11 PM, Sagi Grimberg wrote:
> > 
> >> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
> >> +	    error == BLK_STS_OK)
> >> +		t10_pi_complete(req,
> >> +				nr_bytes / queue_logical_block_size(req->q));
> >> +
> > 
> > div in this path? better to use  >> ilog2(block_size).
> > 
> > Also, would be better to have a wrapper in place like:
> > 
> > static inline unsigned short blk_integrity_interval(struct request *rq)
> > {
> > 	return queue_logical_block_size(rq->q);
> > }
> 
> If it's a hot path thing that matters, I'd strongly suggest to add
> a queue block size shift instead.

Make that a protection_interval_shift, please.  While that currently
is the same as the logical block size the concepts are a little
different, and that makes it clear.  Except for that this patch looks
very nice to me, it is great to avoid having drivers to deal with the
PI remapping.
