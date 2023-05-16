Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789E8704541
	for <lists+linux-block@lfdr.de>; Tue, 16 May 2023 08:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjEPGYH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 16 May 2023 02:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjEPGYG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 02:24:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CAD4C2C
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 23:23:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8CBEB68BEB; Tue, 16 May 2023 08:22:21 +0200 (CEST)
Date:   Tue, 16 May 2023 08:22:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH V2 1/2] blk-mq: don't queue plugged passthrough
 requests into scheduler
Message-ID: <20230516062221.GA7325@lst.de>
References: <20230515144601.52811-1-ming.lei@redhat.com> <20230515144601.52811-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515144601.52811-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 15, 2023 at 10:46:00PM +0800, Ming Lei wrote:
> +		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx ||
> +				pt != blk_rq_is_passthrough(rq)) {

Can your format this as:

		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx ||
			   pt != blk_rq_is_passthrough(rq)) {

for readability?

> +			/*
> +			 * Both passthrough and flush request don't belong to
> +			 * scheduler, but flush request won't be added to plug
> +			 * list, so needn't handle here.
> +			 */
>  			rq_list_add_tail(&requeue_lastp, rq);

This comment confuses the heck out of me.  The check if for passthrough
vs non-passthrough and doesn't involved flush requests at all.

I'd prefer to drop it, and instead comment on passthrough requests
not going to the scheduled below where we actually issue other requests
to the scheduler.

> +	if (pt) {
> +		spin_lock(&this_hctx->lock);
> +		list_splice_tail_init(&list, &this_hctx->dispatch);
> +		spin_unlock(&this_hctx->lock);
> +		blk_mq_run_hw_queue(this_hctx, from_sched);

.. aka here.  But why can't we just use the blk_mq_insert_requests
for this case anyway?

As in just doing a:


-	if (this_hctx->queue->elevator) {
+	if (this_hctx->queue->elevator && !pt) {

?
