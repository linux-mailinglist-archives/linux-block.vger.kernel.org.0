Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FAE6079A0
	for <lists+linux-block@lfdr.de>; Fri, 21 Oct 2022 16:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJUOck (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 21 Oct 2022 10:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJUOci (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 10:32:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12BE27E2E3;
        Fri, 21 Oct 2022 07:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D46B1B82C12;
        Fri, 21 Oct 2022 14:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBED8C433D6;
        Fri, 21 Oct 2022 14:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666362754;
        bh=gV36/8a1mToLZ9CEhoI5MVfQ6sWGD3XIzmxBgwKLQnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fjf2afBnTgI4gFcVH2X6FWrrZ4CR+GncXKpns47YOaeyLuwuBb7ReGgUCQ4CyA8Vo
         sT2Ka5SIahWmvny2ig5smx/4Y8xybtPrWVHpMxAbKZxWGsqKhJd0E16WaV/dKWX4B+
         QIAHVU7bLmvbNWyp0FyB+4HWQw6KLUz5hFmgmi+ms0yfztRUauCHmJH08yrP6RgbEw
         dia3jk7vE9m+Qnr/fAII793MR0QSkeJ+fMgiqSSufBKNCmiqu1z9E/WUZHLkP2W0KM
         x2nmJ8wSqRn122Yibl4YCmYJU3WeVDKMnHLn5zAaXRaZFzgf144DB4tFQsMM53GY6F
         xDf2GUpDEH6FA==
Date:   Fri, 21 Oct 2022 08:32:31 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, djeffery@redhat.com,
        stefanha@redhat.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [Bug] double ->queue_rq() because of timeout in ->queue_rq()
Message-ID: <Y1Ktf2jRTlPMQwJR@kbusch-mbp.dhcp.thefacebook.com>
References: <Y1EQdafQlKNAsutk@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1EQdafQlKNAsutk@T590>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 20, 2022 at 05:10:13PM +0800, Ming Lei wrote:
> @@ -1593,10 +1598,17 @@ static void blk_mq_timeout_work(struct work_struct *work)
>  	if (!percpu_ref_tryget(&q->q_usage_counter))
>  		return;
>  
> -	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
> +	/* Before walking tags, we must ensure any submit started before the
> +	 * current time has finished. Since the submit uses srcu or rcu, wait
> +	 * for a synchronization point to ensure all running submits have
> +	 * finished
> +	 */
> +	blk_mq_wait_quiesce_done(q);
> +
> +	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &expired);

The blk_mq_wait_quiesce_done() will only wait for tasks that entered
just before calling that function. It will not wait for tasks that
entered immediately after.

If I correctly understand the problem you're describing, the hypervisor
may prevent any guest process from running. If so, the timeout work may
be stalled after the quiesce, and if a queue_rq() process also stalled
after starting quiesce_done(), then we're in the same situation you're
trying to prevent, right?

I agree with your idea that this is a lower level driver responsibility:
it should reclaim all started requests before allowing new queuing.
Perhaps the block layer should also raise a clear warning if it's
queueing a request that's already started.
