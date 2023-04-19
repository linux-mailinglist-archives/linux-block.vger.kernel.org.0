Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058086E7289
	for <lists+linux-block@lfdr.de>; Wed, 19 Apr 2023 07:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjDSFIC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Apr 2023 01:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjDSFIC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 01:08:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E676A63
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 22:08:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1EC2468AFE; Wed, 19 Apr 2023 07:07:59 +0200 (CEST)
Date:   Wed, 19 Apr 2023 07:07:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 09/11] block: mq-deadline: Handle requeued requests
 correctly
Message-ID: <20230419050758.GD25898@lst.de>
References: <20230418224002.1195163-1-bvanassche@acm.org> <20230418224002.1195163-10-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418224002.1195163-10-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  deadline_add_rq_rb(struct dd_per_prio *per_prio, struct request *rq)
>  {
>  	struct rb_root *root = deadline_rb_root(per_prio, rq);
> +	struct request **next_rq __maybe_unused;
>  
>  	elv_rb_add(root, rq);
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	next_rq = &per_prio->next_rq[rq_data_dir(rq)];
> +	if (*next_rq == NULL || !blk_queue_is_zoned(rq->q))
> +		return;
> +	/*
> +	 * If a request got requeued or requests have been submitted out of
> +	 * order, make sure that per zone the request with the lowest LBA is
> +	 * submitted first.
> +	 */
> +	if (blk_rq_pos(rq) < blk_rq_pos(*next_rq) &&
> +	    blk_rq_zone_no(rq) == blk_rq_zone_no(*next_rq))
> +		*next_rq = rq;
> +#endif

Please key move this into a helper only called when blk_queue_is_zoned
is true.
