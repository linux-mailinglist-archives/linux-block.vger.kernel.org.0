Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED776F1167
	for <lists+linux-block@lfdr.de>; Fri, 28 Apr 2023 07:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjD1FqF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 28 Apr 2023 01:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjD1FqE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2023 01:46:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C552109
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 22:46:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 29F2268D0A; Fri, 28 Apr 2023 07:46:00 +0200 (CEST)
Date:   Fri, 28 Apr 2023 07:45:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 3/9] block: Introduce blk_rq_is_seq_zoned_write()
Message-ID: <20230428054559.GD8549@lst.de>
References: <20230424203329.2369688-1-bvanassche@acm.org> <20230424203329.2369688-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424203329.2369688-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> + */
> +bool blk_rq_is_seq_zoned_write(struct request *rq)
> +{
> +	switch (req_op(rq)) {
> +	case REQ_OP_WRITE:
> +	case REQ_OP_WRITE_ZEROES:
> +		return blk_rq_zone_is_seq(rq);

This would be another use for op_is_zoned_write..

>  bool blk_req_needs_zone_write_lock(struct request *rq)
>  {
>  	return rq->q->disk->seq_zones_wlock &&
> -		(req_op(rq) == REQ_OP_WRITE ||
> -		 req_op(rq) == REQ_OP_WRITE_ZEROES) &&
> -		blk_rq_zone_is_seq(rq);
> +		blk_rq_is_seq_zoned_write(rq);
>  }

.. and given that this just reshuffles the previous patch it might
make sense to just move it before that.
