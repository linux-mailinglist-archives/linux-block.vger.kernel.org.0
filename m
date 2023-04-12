Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DB86DF3EC
	for <lists+linux-block@lfdr.de>; Wed, 12 Apr 2023 13:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjDLLkJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Apr 2023 07:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjDLLj7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 07:39:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FC740F2
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 04:39:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4ACFB68AA6; Wed, 12 Apr 2023 13:39:23 +0200 (CEST)
Date:   Wed, 12 Apr 2023 13:39:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: call blk_mq_hctx_stopped in
 __blk_mq_run_hw_queue
Message-ID: <20230412113923.GA8890@lst.de>
References: <20230412063743.618957-1-hch@lst.de> <ZDZ2Ibe7AtvgrtdE@ovpn-8-21.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDZ2Ibe7AtvgrtdE@ovpn-8-21.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 12, 2023 at 05:13:05PM +0800, Ming Lei wrote:
> > +	if (blk_mq_hctx_stopped(hctx))
> > +		return;
> >  	blk_mq_run_dispatch_ops(hctx->queue,
> >  			blk_mq_sched_dispatch_requests(hctx));
> 
> The above new check isn't needed actually, since blk_mq_sched_dispatch_requests()
> does check it with rcu read lock held, which should be more reliable.  

The check is not new, it is just moved.   But yes, we could probably
just remove it instead.
