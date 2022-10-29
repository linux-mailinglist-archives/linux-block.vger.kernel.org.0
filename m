Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D281561247D
	for <lists+linux-block@lfdr.de>; Sat, 29 Oct 2022 18:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJ2Qp4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 29 Oct 2022 12:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJ2Qpz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2022 12:45:55 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839D15A2C2
        for <linux-block@vger.kernel.org>; Sat, 29 Oct 2022 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ytlZHzXvVElyumf7th8tU5wsApgH5RDbnaflJhuYAhM=; b=ml7tFMagg8eNw3OcWI0uy1Ffmz
        0PunpYfPKeEpnVpcT7J6gWj6ygQsW0vESBqVU2ysEpkoNtErx/erHjVdkaZdnt4fGVTvVe83Nnw2F
        QU0UpJeMUgJQa+ATujN8XB8XXNC4yImf+3yaAm5JqgpLTdXFoZuif1+xKe2fwgOV2tvwvIhEmupLs
        x5vSHH1QA56jPxw6Hx0N5cZ4k2tt+nvneGSVfcjycFXgMW/LmFfc+xuxzzueww2l4Ee5IeG1CC8p4
        cr8jnvR7yn1eLmWmVdIRFPCxQ2n+VZgfwftaJw4V4ut5LsXzYoJNFNMwOSdEF6r+0Q3by51/I8Tmq
        T2kHW6GQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oooxt-00FIDZ-1G;
        Sat, 29 Oct 2022 16:45:45 +0000
Date:   Sat, 29 Oct 2022 17:45:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [bug?] blk_queue_may_bounce() has the comparison max_low_pfn and
 max_pfn wrong way
Message-ID: <Y11YuS3kiOWoOjuI@ZenIV>
References: <Y1wZTtENDq3fvs6n@ZenIV>
 <01ce222b-8ad6-b4b3-428a-bae9534795e7@kernel.dk>
 <Y1wr0g39GzHcAk9v@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1wr0g39GzHcAk9v@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 28, 2022 at 08:21:55PM +0100, Al Viro wrote:
> On Fri, Oct 28, 2022 at 12:51:00PM -0600, Jens Axboe wrote:
> > On 10/28/22 12:02 PM, Al Viro wrote:
> > > 	We have this:
> > > 
> > > static inline bool blk_queue_may_bounce(struct request_queue *q)
> > > {
> > >         return IS_ENABLED(CONFIG_BOUNCE) &&
> > >                 q->limits.bounce == BLK_BOUNCE_HIGH &&
> > >                 max_low_pfn >= max_pfn;
> > > }
> > > 
> > > static inline struct bio *blk_queue_bounce(struct bio *bio,
> > >                 struct request_queue *q)
> > > {
> > >         if (unlikely(blk_queue_may_bounce(q) && bio_has_data(bio)))
> > >                 return __blk_queue_bounce(bio, q);
> > >         return bio;
> > > }
> > > 
> > > Now, the last term in expression in blk_queue_may_bounce() is
> > > true only on the boxen where max_pfn is no greater than max_low_pfn.
> > > 
> > > Unless I'm very confused, that's the boxen where we don't *have*
> > > any highmem pages.
> > > 
> > > What's more, consider this:
> > > 
> > > static __init int init_emergency_pool(void)
> > > {
> > >         int ret;
> > > 
> > > #ifndef CONFIG_MEMORY_HOTPLUG
> > >         if (max_pfn <= max_low_pfn)
> > >                 return 0;
> > > #endif
> > > 
> > >         ret = mempool_init_page_pool(&page_pool, POOL_SIZE, 0);
> > >         BUG_ON(ret);
> > >         pr_info("pool size: %d pages\n", POOL_SIZE);
> > > 
> > >         init_bounce_bioset();
> > >         return 0;
> > > }
> > > 
> > > On the same boxen (assuming we've not hotplug) page_pool won't be set up
> > > at all, so we wouldn't be able to bounce any highmem page if we ever
> > > ran into one.
> > > 
> > > AFAICS, this condition is backwards - it should be
> > > 
> > > static inline bool blk_queue_may_bounce(struct request_queue *q)
> > > {
> > >         return IS_ENABLED(CONFIG_BOUNCE) &&
> > >                 q->limits.bounce == BLK_BOUNCE_HIGH &&
> > >                 max_low_pfn < max_pfn;
> > > }
> > > 
> > > What am I missing here?
> > 
> > I don't think you're missing anything, the case we need it for is when
> > max_pfn > max_low_pfn. I wonder when this got botched? Because some
> > of those statements date back probably about 20 years when we started
> > allowing highmem pages to do IO.
> 
> 9bb33f24abbd "block: refactor the bounce buffering code" about a year ago.
> 
> But fixing the test alone is not going to be enough - just a quick look
> through __blk_queue_bounce() catches an obvious bug on write (we copy
> the part of highmem page we covered by bio into the beginning of the
> bounce page - and leave ->bv_offset as-is) as well as a possible bug in
> ->bi_status handling (if we really can run into bio_split() there).
> 
> I wonder if we ought to simply add "depends on BROKEN" for CONFIG_BOUNCE... ;-/

BTW, ->bi_status propagation looks brittle in general.  Are there any
places other than bio_init() where we would want to store 0 in ->bi_status
of anything?

Look at e.g. null_blk; AFAICS, we store to ->bi_status on any request
completion (in NULL_Q_BIO case, at least).  What happens if request
gets split and split-off part finishes first with an error?  AFAICS,
its ->bi_status will be copied to parent (original bio, the one that
covers the tail).  Now the IO on the original bio is over as well
and we hit drivers/block/null_blk/main.c:end_cmd().  Suppose this
part succeeds; won't we end up overwriting ->bi_status with zero
and assuming that the entire thing had succeeded, despite the
(now lost) error on the split-off part?
