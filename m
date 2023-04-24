Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0382C6E3FB6
	for <lists+linux-block@lfdr.de>; Mon, 17 Apr 2023 08:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDQGYN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 17 Apr 2023 02:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQGYN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 02:24:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A643590
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 23:24:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C3F3567373; Mon, 17 Apr 2023 08:24:08 +0200 (CEST)
Date:   Mon, 17 Apr 2023 08:24:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/7] blk-mq: factor out a blk_rq_init_flush helper
Message-ID: <20230417062408.GA2566@lst.de>
References: <20230416200930.29542-1-hch@lst.de> <20230416200930.29542-2-hch@lst.de> <3947a26e-ceb6-4117-7b45-fd7578710120@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3947a26e-ceb6-4117-7b45-fd7578710120@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 17, 2023 at 03:22:21PM +0900, Damien Le Moal wrote:
> > +static void blk_rq_init_flush(struct request *rq)
> > +{
> > +	memset(&rq->flush, 0, sizeof(rq->flush));
> > +	INIT_LIST_HEAD(&rq->flush.list);
> > +	rq->rq_flags |= RQF_FLUSH_SEQ;
> > +	rq->flush.saved_end_io = rq->end_io; /* Usually NULL */
> > +	rq->end_io = mq_flush_data_end_io;
> > +}
> 
> struct flush is:
> 
> struct {
> 	unsigned int		seq;
> 	struct list_head	list;
> 	rq_end_io_fn		*saved_end_io;
> } flush;
> 
> So given that list and saved_end_io are initialized here, we could remove the
> memset() by initializing seq "manually":

Yes.  And seq is always initialized in the callers, and I think I can also
removed saved_end_io entirely.  So maybe we can drop this patch in the
end and just do some other changes.
