Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68281B7256
	for <lists+linux-block@lfdr.de>; Fri, 24 Apr 2020 12:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgDXKpC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Apr 2020 06:45:02 -0400
Received: from verein.lst.de ([213.95.11.211]:34355 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgDXKpC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 06:45:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E045B68CF0; Fri, 24 Apr 2020 12:44:59 +0200 (CEST)
Date:   Fri, 24 Apr 2020 12:44:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 10/11] blk-mq: re-submit IO in case that hctx is
 inactive
Message-ID: <20200424104458.GA28721@lst.de>
References: <20200424102351.475641-1-ming.lei@redhat.com> <20200424102351.475641-11-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424102351.475641-11-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	/* avoid allocation failure by clearing NOWAIT */
> +	nrq = blk_get_request(rq->q, rq->cmd_flags & ~REQ_NOWAIT, flags);
> +	if (!nrq)
> +		return;
> +
> +	blk_rq_copy_request(nrq, rq);
> +
> +	nrq->timeout = rq->timeout;

Shouldn't the timeout also go into blk_rq_copy_request?

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
