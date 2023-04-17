Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC0A6E3FE7
	for <lists+linux-block@lfdr.de>; Mon, 17 Apr 2023 08:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjDQGje (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 17 Apr 2023 02:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjDQGje (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 02:39:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E7535A6
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 23:39:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E8BC067373; Mon, 17 Apr 2023 08:39:29 +0200 (CEST)
Date:   Mon, 17 Apr 2023 08:39:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 5/7] blk-mq: defer to the normal submission path for
 post-flush requests
Message-ID: <20230417063929.GA3192@lst.de>
References: <20230416200930.29542-1-hch@lst.de> <20230416200930.29542-6-hch@lst.de> <4689ec07-8da7-eecd-5980-e89fe255af6a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4689ec07-8da7-eecd-5980-e89fe255af6a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 17, 2023 at 03:36:54PM +0900, Damien Le Moal wrote:
> > +	case REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH:
> > +		/*
> > +		 * Initialize the flush fields and completion handler to trigger
> > +		 * the post flush, and then just pass the command on.
> > +		 */
> > +		blk_rq_init_flush(rq);
> > +		rq->flush.seq |= REQ_FSEQ_PREFLUSH;
> 
> Shouldn't this be REQ_FSEQ_POSTFLUSH ?

Yes.  My fault for optimizing away the complicated assignment in the
last minute..
