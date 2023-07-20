Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A9375A5E8
	for <lists+linux-block@lfdr.de>; Thu, 20 Jul 2023 07:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjGTFyq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Jul 2023 01:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGTFyp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 01:54:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7F01724
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 22:54:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BCACD67373; Thu, 20 Jul 2023 07:54:37 +0200 (CEST)
Date:   Thu, 20 Jul 2023 07:54:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v2 3/3] block: Improve performance for
 BLK_MQ_F_BLOCKING drivers
Message-ID: <20230720055437.GA2665@lst.de>
References: <20230719182243.2810134-1-bvanassche@acm.org> <20230719182243.2810134-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719182243.2810134-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 19, 2023 at 11:22:42AM -0700, Bart Van Assche wrote:
> blk_mq_run_queue() runs the queue asynchronously if BLK_MQ_F_BLOCKING
> has been set.

Maybe something like:

blk_mq_run_queue() always runs the queue asynchronously if
BLK_MQ_F_BLOCKING is set on the tag_set.

> + *    for execution. Don't wait for completion. May sleep if BLK_MQ_F_BLOCKING
> + *    has been set.
>   *
>   * Note:
>   *    This function will invoke @done directly if the queue is dead.
> @@ -2213,6 +2214,8 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>  	 */
>  	WARN_ON_ONCE(!async && in_interrupt());
>  
> +	might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);

This is some odd an very complex calling conventions.  I suspect most
!BLK_MQ_F_BLOCKING could also deal with the may sleep if not async,
and that would give us a much easier to audit change as we could
remove the WARN_ON_ONCE above and just do a:

	might_sleep_if(!async);

In fact this might be a good time to split up blk_mq_run_hw_queue
into blk_mq_run_hw_queue and blk_mq_run_hw_queue_async and do
away with the bool and have cristal clear calling conventions.

If we really need !async calles than can sleep we can add a specific
blk_mq_run_hw_queue_atomic.
