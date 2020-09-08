Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED0E261F37
	for <lists+linux-block@lfdr.de>; Tue,  8 Sep 2020 22:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgIHUBD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Sep 2020 16:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730367AbgIHPf0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Sep 2020 11:35:26 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D48921D6C;
        Tue,  8 Sep 2020 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579071;
        bh=Cxp51egYnklrprsgu3/iIRmmK0GhOZAdQglfcB/KiPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1bOkFPQjvij1LBFwfNqqTJ2SJAYs8xQhIcOckM+b+r8ikpjc2XzB4K/MVXBSLV/o
         SDHHcjaKKBRCRPQF6eR/DE7FFmkCH2577EudPfA1egdUVoxYfK21yAtwdKoGJ1CRnT
         WeVi6O9bEjO4RStGnn0nrG88GjIe/qSG70BBlDIs=
Date:   Tue, 8 Sep 2020 08:31:08 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH V3 2/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200908153108.GA3341002@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200908081538.1434936-1-ming.lei@redhat.com>
 <20200908081538.1434936-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908081538.1434936-3-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 08, 2020 at 04:15:36PM +0800, Ming Lei wrote:
>  void blk_mq_quiesce_queue(struct request_queue *q)
>  {
> -	struct blk_mq_hw_ctx *hctx;
> -	unsigned int i;
> -	bool rcu = false;
> +	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
>  
>  	mutex_lock(&q->mq_quiesce_lock);
>  
> -	if (blk_queue_quiesced(q))
> -		goto exit;

Why remove the 'goto exit' on this condition? There shouldn't be a need
to synchronize dispatch again if a previous quiesce already did so.

> -	blk_mq_quiesce_queue_nowait(q);
> -
> -	queue_for_each_hw_ctx(q, hctx, i) {
> -		if (hctx->flags & BLK_MQ_F_BLOCKING)
> -			synchronize_srcu(hctx->srcu);
> -		else
> -			rcu = true;
> +	if (!blk_queue_quiesced(q)) {
> +		blk_mq_quiesce_queue_nowait(q);
> +		if (blocking)
> +			percpu_ref_kill(&q->dispatch_counter);
>  	}
> -	if (rcu)
> +
> +	if (blocking)
> +		wait_event(q->mq_quiesce_wq,
> +			   percpu_ref_is_zero(&q->dispatch_counter));
> +	else
>  		synchronize_rcu();
> - exit:
> +
>  	mutex_unlock(&q->mq_quiesce_lock);
>  }
