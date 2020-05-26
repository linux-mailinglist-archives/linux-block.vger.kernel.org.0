Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF681B7A28
	for <lists+linux-block@lfdr.de>; Fri, 24 Apr 2020 17:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgDXPjz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Apr 2020 11:39:55 -0400
Received: from verein.lst.de ([213.95.11.211]:35592 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729083AbgDXPjo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 11:39:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A1ADE68CEE; Fri, 24 Apr 2020 17:39:40 +0200 (CEST)
Date:   Fri, 24 Apr 2020 17:39:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Salman Qazi <sqazi@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3] block: Limit number of items taken from the I/O
 scheduler in one go
Message-ID: <20200424153940.GA17253@lst.de>
References: <20200424150321.38617-1-sqazi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424150321.38617-1-sqazi@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	/*
> +	 * A return of -EAGAIN is an indication that hctx->dispatch is not
> +	 * empty and we must run again in order to avoid starving flushes.
> +	 */
> +	if (__blk_mq_sched_dispatch_requests(hctx) == -EAGAIN) {
> +		if (__blk_mq_sched_dispatch_requests(hctx) == -EAGAIN)
> +			blk_mq_run_hw_queue(hctx, true);
> +	}

The comment doesn't explain why we give up after the second attempt and
do a blk_mq_run_hw_queue instead.
