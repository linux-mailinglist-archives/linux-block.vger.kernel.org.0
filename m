Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23241D120B
	for <lists+linux-block@lfdr.de>; Wed, 13 May 2020 13:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgEML7e (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 07:59:34 -0400
Received: from verein.lst.de ([213.95.11.211]:46074 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbgEML7e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 07:59:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8AAA268BEB; Wed, 13 May 2020 13:59:32 +0200 (CEST)
Date:   Wed, 13 May 2020 13:59:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V11 07/12] blk-mq: stop to handle IO and drain IO
 before hctx becomes inactive
Message-ID: <20200513115932.GC6297@lst.de>
References: <20200513034803.1844579-1-ming.lei@redhat.com> <20200513034803.1844579-8-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513034803.1844579-8-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	if (unlikely(direct_issue && rq->mq_ctx->cpu != raw_smp_processor_id()))
> +		smp_mb();
> +	else
> +		barrier();

Independ of the fact that I still think this is horrible and hacky,
I also still don't see what the barrier() is trying to help with.
