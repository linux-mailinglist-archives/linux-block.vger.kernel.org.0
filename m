Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E931B5603
	for <lists+linux-block@lfdr.de>; Thu, 23 Apr 2020 09:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgDWHks (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 Apr 2020 03:40:48 -0400
Received: from verein.lst.de ([213.95.11.211]:56528 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgDWHkq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 03:40:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 81D3068BEB; Thu, 23 Apr 2020 09:40:42 +0200 (CEST)
Date:   Thu, 23 Apr 2020 09:40:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V7 6/9] block: add blk_end_flush_machinery
Message-ID: <20200423074042.GG10951@lst.de>
References: <20200418030925.31996-1-ming.lei@redhat.com> <20200418030925.31996-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418030925.31996-7-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 18, 2020 at 11:09:22AM +0800, Ming Lei wrote:
> Flush requests aren't same with normal FS request:
> 
> 1) on dedicated per-hctx flush rq is pre-allocated for sending flush request
> 
> 2) flush requests are issued to hardware via one machinary so that flush merge
> can be applied
> 
> We can't simply re-submit flush rqs via blk_steal_bios(), so add
> blk_end_flush_machinery to collect flush requests which needs to
> be resubmitted:
> 
> - if one flush command without DATA is enough, send one flush, complete this
> kind of requests
> 
> - otherwise, add the request into a list and let caller re-submit it.

The code looks sensible:

Reviewed-by: Christoph Hellwig <hch@lst.de>
