Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04246E7274
	for <lists+linux-block@lfdr.de>; Wed, 19 Apr 2023 06:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjDSExB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Apr 2023 00:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjDSExA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 00:53:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D423AB2
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 21:52:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 240E66732D; Wed, 19 Apr 2023 06:52:56 +0200 (CEST)
Date:   Wed, 19 Apr 2023 06:52:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 04/11] block: mq-deadline: Simplify
 deadline_skip_seq_writes()
Message-ID: <20230419045255.GB25898@lst.de>
References: <20230418224002.1195163-1-bvanassche@acm.org> <20230418224002.1195163-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418224002.1195163-5-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 18, 2023 at 03:39:55PM -0700, Bart Van Assche wrote:
> Make the deadline_skip_seq_writes() code shorter without changing its
> functionality.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 5839a027e0f0..3dde720e2f59 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -310,12 +310,9 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
>  						struct request *rq)
>  {
>  	sector_t pos = blk_rq_pos(rq);
> -	sector_t skipped_sectors = 0;
>  
> -	while (rq) {
> -		if (blk_rq_pos(rq) != pos + skipped_sectors)
> -			break;
> -		skipped_sectors += blk_rq_sectors(rq);
> +	while (rq && blk_rq_pos(rq) == pos) {
> +		pos += blk_rq_sectors(rq);
>  		rq = deadline_latter_request(rq);
>  	}

This still reads a bit odd.

Maybe turn this into:

	do {
		pos += blk_rq_sectors(rq);
		rq = deadline_latter_request(rq);
		if (!rq)
			break;
	} while (blk_rq_pos(rq) == pos);

