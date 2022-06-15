Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3797B54C175
	for <lists+linux-block@lfdr.de>; Wed, 15 Jun 2022 08:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiFOGEs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Jun 2022 02:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbiFOGEr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 02:04:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1C01A831
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 23:04:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 31D6768B05; Wed, 15 Jun 2022 08:04:43 +0200 (CEST)
Date:   Wed, 15 Jun 2022 08:04:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/3] blk-mq: avoid to touch q->elevator without any
 protection
Message-ID: <20220615060442.GD22115@lst.de>
References: <20220615023712.750122-1-ming.lei@redhat.com> <20220615023712.750122-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615023712.750122-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +++ b/block/elevator.c
> @@ -612,6 +612,16 @@ int elevator_switch_mq(struct request_queue *q,
>  		}
>  	}
>  
> +	/*
> +	 * Is the request queue handled by an IO scheduler that does not
> +	 * respect hardware queues when dispatching?
> +	 */
> +	if (new_e && new_e->ops.dispatch_request &&
> +	    !(new_e->elevator_features & ELEVATOR_F_MQ_AWARE))
> +		blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
> +	else
> +		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);

Please just set the QUEUE_FLAG_SQ_SCHED flag directly from the
mq-deadline and bfq scheduler ans drop the ELEVATOR_F_MQ_AWARE
flag.

Otherwise this approach looks good.

