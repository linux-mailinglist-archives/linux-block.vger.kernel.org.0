Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF874C8CC2
	for <lists+linux-block@lfdr.de>; Tue,  1 Mar 2022 14:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiCANiB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Mar 2022 08:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiCANiA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 08:38:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E089D0F8
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 05:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u3tLw5ZeGoSiDbcH6v5iLJ1Kz3D8CxYacZcGoCAytZk=; b=SzYE0J4ltP4mLGulkjUX8UoLq9
        tvDYnMGwHW3depYKdOkpK16hRhCIhyRCJxWmiZgx1/ewCEsmoacFVqrQODaaqxTz4XFcKYwC1qlbC
        JxIYTh122GzGF1w2Und3hCGDUNKBD9h4DZqR0mR3koMJZ1aee1ce2r2sBTf415cpKe4H9+HwqPYhd
        YvJ4Uz9rrc6h0C5/d5zRt0CBco5SffJHutQ5+eh+K/XGq7a/o6lVOsg4z+7fX8xee7DEJLpt7BPNs
        RKHi/6ca4Bq4h3myJ2/KhHPuHE45yPNe3ZbqN1eqozYylrvP1FjcbB0UXqekBCvQlVobM6XNJ+wyo
        J3EP6KJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP2gn-00GvLk-Jp; Tue, 01 Mar 2022 13:37:17 +0000
Date:   Tue, 1 Mar 2022 05:37:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 6/6] blk-mq: manage hctx map via xarray
Message-ID: <Yh4hjS0S3vXfLWlH@infradead.org>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
 <20220228090430.1064267-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228090430.1064267-7-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -			hctxs[i] = blk_mq_alloc_and_init_hctx(set, q, i,
> -					old_node);
> -			WARN_ON_ONCE(!hctxs[i]);
> +			WARN_ON_ONCE(!blk_mq_alloc_and_init_hctx(set, q, i,
> +						old_node));


Please avoid doing the actual work inside a WARN_ON statement.

>  
>  	for (; j < end; j++) {
> -		struct blk_mq_hw_ctx *hctx = hctxs[j];
> +		struct blk_mq_hw_ctx *hctx = blk_mq_get_hctx(q, j);
>  
> -		if (hctx) {
> +		if (hctx)
>  			blk_mq_exit_hctx(q, set, hctx, j);
> -			hctxs[j] = NULL;
> -		}
>  	}

Instead of a for loop that does xa_loads repeatedly this can just
use xa_for_each_range.  Same for a bunch of other loops like that,
e.g. in blk_mq_unregister_dev or the __blk_mq_register_dev failure
path.

> @@ -919,12 +919,12 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
>  static inline struct blk_mq_hw_ctx *blk_mq_get_hctx(struct request_queue *q,
>  		unsigned int hctx_idx)
>  {
> -	return q->queue_hw_ctx[hctx_idx];
> +	return xa_load(&q->hctx_table, hctx_idx);
>  }
>  
>  #define queue_for_each_hw_ctx(q, hctx, i)				\
>  	for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
> -	     ({ hctx = blk_mq_get_hctx((q), (i)); 1; }); (i)++)
> +	     (hctx = blk_mq_get_hctx((q), (i))); (i)++)

This should be using a xa_for_each loop.

With various places converted to loops I'm not even sure we really
want the blk_mq_get_hctx helper at all.
