Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F84F24CE11
	for <lists+linux-block@lfdr.de>; Fri, 21 Aug 2020 08:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgHUGex (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 21 Aug 2020 02:34:53 -0400
Received: from verein.lst.de ([213.95.11.211]:45791 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgHUGew (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 02:34:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5A75668AFE; Fri, 21 Aug 2020 08:34:49 +0200 (CEST)
Date:   Fri, 21 Aug 2020 08:34:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Message-ID: <20200821063448.GF28559@lst.de>
References: <20200820030248.2809559-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820030248.2809559-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
> -	__releases(hctx->srcu)
> +static void hctx_unlock(struct blk_mq_hw_ctx *hctx)
>  {
>  	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
>  		rcu_read_unlock();
>  	else
> -		srcu_read_unlock(hctx->srcu, srcu_idx);
> +		percpu_ref_put(&hctx->queue->dispatch_counter);

While you're at it:  can we avoid the pointless inversion in the if
statement and just do:

 	if (hctx->flags & BLK_MQ_F_BLOCKING)
		percpu_ref_put(&hctx->queue->dispatch_counter);
	else
		rcu_read_unlock();

> +static inline bool hctx_lock(struct blk_mq_hw_ctx *hctx)
>  {
>  	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> -		/* shut up gcc false positive */
> -		*srcu_idx = 0;
>  		rcu_read_lock();
> +		return true;
>  	} else
> -		*srcu_idx = srcu_read_lock(hctx->srcu);
> +		return percpu_ref_tryget_live(&hctx->queue->dispatch_counter);
>  }

Same here.

Otherwise this looks good to me, but did you do a deep audit that all
the new hctx_lock() failure cases don't cause problems?
