Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA09354C1A1
	for <lists+linux-block@lfdr.de>; Wed, 15 Jun 2022 08:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351699AbiFOGJB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Jun 2022 02:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349813AbiFOGI7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 02:08:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404C827FC0
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 23:08:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96FE567373; Wed, 15 Jun 2022 08:08:51 +0200 (CEST)
Date:   Wed, 15 Jun 2022 08:08:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] block: Specify the operation type when calling
 blk_mq_map_queue()
Message-ID: <20220615060851.GE22115@lst.de>
References: <20220614175725.612878-1-bvanassche@acm.org> <20220614175725.612878-4-bvanassche@acm.org> <YqkoWUjOPgpqzn4E@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqkoWUjOPgpqzn4E@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 15, 2022 at 08:31:21AM +0800, Ming Lei wrote:
> > -	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, 0, ctx);
> > +	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, REQ_OP_WRITE, ctx);
> 
> The change itself doesn't make a difference, since both results in choosing
> HCTX_TYPE_DEFAULT, but passing REQ_OP_WRITE is a bit misleading.

Well, the argument is an operationm so we better pass in a correct
operation (at some point we should look into a __bitwise annotation
or similar to make it clean).  And as 0 is REQ_OP_READ, we will end
up with the HCTX_TYPE_READ hctx IFF someone configures read queues
and uses an sq only schedule.  Which is a completely stupid but
possible setup.
