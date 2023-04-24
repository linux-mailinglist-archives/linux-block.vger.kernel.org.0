Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356486DDB18
	for <lists+linux-block@lfdr.de>; Tue, 11 Apr 2023 14:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjDKMoE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Apr 2023 08:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDKMoD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 08:44:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB943584
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 05:44:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8475A68C7B; Tue, 11 Apr 2023 14:43:58 +0200 (CEST)
Date:   Tue, 11 Apr 2023 14:43:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v2 06/12] block: Preserve the order of requeued requests
Message-ID: <20230411124358.GC14106@lst.de>
References: <20230407235822.1672286-1-bvanassche@acm.org> <20230407235822.1672286-7-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407235822.1672286-7-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I think this should be merged with the previous patch.

>  void blk_mq_kick_requeue_list(struct request_queue *q)
>  {
> +	blk_mq_run_hw_queues(q, true);
>  }
>  EXPORT_SYMBOL(blk_mq_kick_requeue_list);

Pleae just remove blk_mq_kick_requeue_list entirely.

>
>  
>  void blk_mq_delay_kick_requeue_list(struct request_queue *q,
>  				    unsigned long msecs)
>  {
> +	blk_mq_delay_run_hw_queues(q, msecs);
>  }
>  EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);

Same for blk_mq_delay_kick_requeue_list.

>  		if (!sq_hctx || sq_hctx == hctx ||
> -		    !list_empty_careful(&hctx->dispatch))
> +		    blk_mq_hctx_has_pending(hctx))
>  			blk_mq_run_hw_queue(hctx, async);
>  	}
>  }
> @@ -2353,7 +2341,7 @@ void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
>  		 * scheduler.
>  		 */
>  		if (!sq_hctx || sq_hctx == hctx ||
> -		    !list_empty_careful(&hctx->dispatch))
> +		    blk_mq_hctx_has_pending(hctx))

This check would probably benefit from being factored into a helper.
