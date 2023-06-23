Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5C073B052
	for <lists+linux-block@lfdr.de>; Fri, 23 Jun 2023 07:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjFWFuI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Jun 2023 01:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjFWFto (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jun 2023 01:49:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB403297C
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 22:48:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4AB6868B05; Fri, 23 Jun 2023 07:48:24 +0200 (CEST)
Date:   Fri, 23 Jun 2023 07:48:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v4 4/7] block: One requeue list per hctx
Message-ID: <20230623054823.GD9085@lst.de>
References: <20230621201237.796902-1-bvanassche@acm.org> <20230621201237.796902-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621201237.796902-5-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  void blk_mq_kick_requeue_list(struct request_queue *q)
>  {
> -	kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &q->requeue_work, 0);
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned long i;
> +
> +	queue_for_each_hw_ctx(q, hctx, i)
> +		kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND,
> +					    &hctx->requeue_work, 0);
>  }
>  EXPORT_SYMBOL(blk_mq_kick_requeue_list);
>  
>  void blk_mq_delay_kick_requeue_list(struct request_queue *q,
>  				    unsigned long msecs)
>  {
> -	kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &q->requeue_work,
> -				    msecs_to_jiffies(msecs));
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned long i;
> +
> +	queue_for_each_hw_ctx(q, hctx, i)
> +		kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND,
> +					    &hctx->requeue_work,
> +					    msecs_to_jiffies(msecs));
>  }

I'd iplement blk_mq_kick_requeue_list as a wrapper around
blk_mq_delay_kick_requeue_list that passes a 0 msec argument.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
