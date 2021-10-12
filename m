Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343C942A227
	for <lists+linux-block@lfdr.de>; Tue, 12 Oct 2021 12:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbhJLKcR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Oct 2021 06:32:17 -0400
Received: from verein.lst.de ([213.95.11.211]:40848 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235840AbhJLKcQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 06:32:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7315267373; Tue, 12 Oct 2021 12:30:11 +0200 (CEST)
Date:   Tue, 12 Oct 2021 12:30:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 6/6] blk-mq: support concurrent queue
 quiesce/unquiesce
Message-ID: <20211012103010.GA29640@lst.de>
References: <20211009034713.1489183-1-ming.lei@redhat.com> <20211009034713.1489183-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009034713.1489183-7-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 09, 2021 at 11:47:13AM +0800, Ming Lei wrote:
> +	spin_lock_irqsave(&q->queue_lock, flags);
> +	if (!q->quiesce_depth++)
> +		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);

We can get rid of the QUEUE_FLAG_QUIESCED flag now and just look
at ->quiesce_depth directly.

> +	spin_lock_irqsave(&q->queue_lock, flags);
> +	WARN_ON_ONCE(q->quiesce_depth <= 0);
> +	if (q->quiesce_depth > 0 && !--q->quiesce_depth) {

	if (WARN_ON_ONCE(q->quiesce_depth <= 0))
		; /* oops */
	else if (!--q->quiesce_depth)
		run_queue = true;

Otherwise this looks sensible.
