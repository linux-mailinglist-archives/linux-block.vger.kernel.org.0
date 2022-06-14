Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EE754B20C
	for <lists+linux-block@lfdr.de>; Tue, 14 Jun 2022 15:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbiFNNJu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Jun 2022 09:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbiFNNJt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 09:09:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642B836695
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 06:09:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 237FB21A82;
        Tue, 14 Jun 2022 13:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655212187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SZdXDqx2FcKfc5tK2OjYKWz5aChMyNIgpuuDl6ZYhBM=;
        b=FafK9N7BONdevsgiycxYthmFlmIY3z4oHBs5M+lq+ueLCJI1dRuyDfKfB+WC50MgYoCnL8
        aWzBefJ0yO5ZSrmwXN++dq1OuOX54ptr709XSwwt0Im6lNRxe3Fy7Gwqezop1WES2KDM/T
        D5QvjdTtOzijEzPAsdg9fcVH5gD1Hb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655212187;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SZdXDqx2FcKfc5tK2OjYKWz5aChMyNIgpuuDl6ZYhBM=;
        b=PlouNPihnOt8s9ccBxRuJTDnmrF7p9PYXXkOkgLF9cl3edXvEqAnNEQmH5qABk8ngk2GDU
        smZsJH1FXsS3zyDg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C66F32C141;
        Tue, 14 Jun 2022 13:09:45 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 705E0A062E; Tue, 14 Jun 2022 15:09:42 +0200 (CEST)
Date:   Tue, 14 Jun 2022 15:09:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Cixi Geng <cixi.geng1@unisoc.com>, Jan Kara <jack@suse.cz>,
        Yu Kuai <yukuai3@huawei.com>,
        Paolo Valente <paolo.valente@unimore.it>
Subject: Re: [PATCH] block/bfq: Enable I/O statistics
Message-ID: <20220614130942.q7rekncnyh2pvgbd@quack3.lan>
References: <20220613163234.3593026-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613163234.3593026-1-bvanassche@acm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 13-06-22 09:32:34, Bart Van Assche wrote:
> BFQ uses io_start_time_ns. That member variable is only set if I/O
> statistics are enabled. Hence this patch that enables I/O statistics
> at the time BFQ is associated with a request queue.
> 
> Compile-tested only.
> 
> Reported-by: Cixi Geng <cixi.geng1@unisoc.com>
> Cc: Cixi Geng <cixi.geng1@unisoc.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Cc: Paolo Valente <paolo.valente@unimore.it>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good. Thanks for the fix. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0d46cb728bbf..519862d82473 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -7046,6 +7046,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
>  	spin_unlock_irq(&bfqd->lock);
>  #endif
>  
> +	blk_stat_disable_accounting(bfqd->queue);
>  	wbt_enable_default(bfqd->queue);
>  
>  	kfree(bfqd);
> @@ -7189,6 +7190,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>  	bfq_init_entity(&bfqd->oom_bfqq.entity, bfqd->root_group);
>  
>  	wbt_disable_default(q);
> +	blk_stat_enable_accounting(q);
> +
>  	return 0;
>  
>  out_free:
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
