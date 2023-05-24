Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C37F70EDAC
	for <lists+linux-block@lfdr.de>; Wed, 24 May 2023 08:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbjEXGNF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 May 2023 02:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjEXGNF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 02:13:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA81132
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 23:13:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D87A068CFE; Wed, 24 May 2023 08:13:00 +0200 (CEST)
Date:   Wed, 24 May 2023 08:13:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v3 2/7] block: Send requeued requests to the I/O
 scheduler
Message-ID: <20230524061300.GD19611@lst.de>
References: <20230522183845.354920-1-bvanassche@acm.org> <20230522183845.354920-3-bvanassche@acm.org> <20230523071835.GB8758@lst.de> <639fa0ac-e7b9-2ba7-3d68-3fe1a501e779@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <639fa0ac-e7b9-2ba7-3d68-3fe1a501e779@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23, 2023 at 03:30:16PM -0700, Bart Van Assche wrote:
>  static inline void blk_mq_sched_requeue_request(struct request *rq)
>  {
> -	if (rq->rq_flags & RQF_USE_SCHED) {
> -		struct request_queue *q = rq->q;
> -		struct elevator_queue *e = q->elevator;
> -
> -		if (e->type->ops.requeue_request)
> -			e->type->ops.requeue_request(rq);
> -	}
> +	if (rq->rq_flags & RQF_USE_SCHED)
> +		rq->rq_flags |= RQF_REQUEUED;
>  }

I'd drop this helper function if we go down this way.  But maybe
we might just want to keep the method.  Sorry for the noise.

