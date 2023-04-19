Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246A76E7287
	for <lists+linux-block@lfdr.de>; Wed, 19 Apr 2023 07:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjDSFHL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Apr 2023 01:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjDSFHL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 01:07:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C001701
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 22:07:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE66668AFE; Wed, 19 Apr 2023 07:07:06 +0200 (CEST)
Date:   Wed, 19 Apr 2023 07:07:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 08/11] block: mq-deadline: Fix a race condition
 related to zoned writes
Message-ID: <20230419050706.GC25898@lst.de>
References: <20230418224002.1195163-1-bvanassche@acm.org> <20230418224002.1195163-9-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418224002.1195163-9-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 18, 2023 at 03:39:59PM -0700, Bart Van Assche wrote:
> Let deadline_next_request() only consider the first zoned write per
> zone. This patch fixes a race condition between deadline_next_request()
> and completion of zoned writes.

Can you explain the condition in a bit more detail?

>   * For the specified data direction, return the next request to
> @@ -386,9 +388,25 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  	 */
>  	spin_lock_irqsave(&dd->zone_lock, flags);
>  	while (rq) {
> +		unsigned int zno __maybe_unused;
> +
>  		if (blk_req_can_dispatch_to_zone(rq))
>  			break;
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +		zno = blk_rq_zone_no(rq);
> +
>  		rq = deadline_skip_seq_writes(dd, rq);
> +
> +		/*
> +		 * Skip all other write requests for the zone with zone number
> +		 * 'zno'. This prevents that this function selects a zoned write
> +		 * that is not the first write for a given zone.
> +		 */
> +		while (rq && blk_rq_zone_no(rq) == zno &&
> +		       blk_rq_is_seq_zoned_write(rq))
> +			rq = deadline_latter_request(rq);
> +#endif

The ifdefere and extra checks are a bit ugly here.

I'd suggest to:

 - move all the zoned related logic in deadline_next_request into
   a separate helper that is stubbed out for !CONFIG_BLK_DEV_ZONED
 - merge the loop in deadline_skip_seq_writes and
   added here into one single loop.  Something like:

static struct request *
deadline_zoned_next_request(struct deadline_data *dd, struct request *rq)
{
        unsigned long flags;

	spin_lock_irqsave(&dd->zone_lock, flags);
	while (!blk_req_can_dispatch_to_zone(rq)) {
		unsigned int zone_no = blk_rq_zone_no(rq);
		sector_t pos = blk_rq_pos(rq);

		while (blk_rq_is_seq_zoned_write(rq)) {
			// XXX: good comment explaining the check here
			if (blk_rq_pos(rq) != pos &&
			    blk_rq_zone_no(rq) != zone_no)
				break;
			pos += blk_rq_sectors(rq);
			rq = deadline_latter_request(rq);
			if (!rq)
				goto out_unlock;
		}
	}
out_unlock:
 	spin_unlock_irqrestore(&dd->zone_lock, flags);
	return rq;
} 
