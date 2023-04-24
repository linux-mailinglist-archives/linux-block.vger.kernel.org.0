Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D646E0747
	for <lists+linux-block@lfdr.de>; Thu, 13 Apr 2023 08:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjDMG7p (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 13 Apr 2023 02:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMG7o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:59:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7857280
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:59:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DD2BF6732D; Thu, 13 Apr 2023 08:59:40 +0200 (CEST)
Date:   Thu, 13 Apr 2023 08:59:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 16/20] blk-mq: don't kick the requeue_list in
 blk_mq_add_to_requeue_list
Message-ID: <20230413065940.GB16260@lst.de>
References: <20230413064057.707578-1-hch@lst.de> <20230413064057.707578-17-hch@lst.de> <1f06dd70-bf06-2983-f9fd-5875a8f5d20d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f06dd70-bf06-2983-f9fd-5875a8f5d20d@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 13, 2023 at 03:54:31PM +0900, Damien Le Moal wrote:
> >  void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
> >  {
> > +	struct request_queue *q = rq->q;
> 
> Nit: not really needed given that it is used in one place only.
> You could just call "blk_mq_kick_requeue_list(rq->q)" below.

It is needed, because we can't dereference rq safely after
blk_mq_add_to_requeue_list returns.
