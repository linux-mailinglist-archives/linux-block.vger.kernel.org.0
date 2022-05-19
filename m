Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A9652C989
	for <lists+linux-block@lfdr.de>; Thu, 19 May 2022 03:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiESB7r (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 May 2022 21:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiESB7o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 21:59:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C942D6811;
        Wed, 18 May 2022 18:59:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B69B3B82297;
        Thu, 19 May 2022 01:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6614C385A5;
        Thu, 19 May 2022 01:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652925580;
        bh=DslAZr7vMpCa6Ap0ypgNw9nOb31pmpP1pS6LHSZlX9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tML+YFxPtSIG5rXbhl9sid3F3dg/f6y50fIxi0uLis2K9z5ZWwOlDbcmccTNpt38/
         u1McaR6kE+f7BUBym1ytsESdubEffulBds13FbFqu+VacO51YPJv+2/6RgJf+W0wyJ
         Fdu/1TU3AZGPCjtmOhIdfw16mwOx3I0wLbEjFNf6+gw0+jlWH7+AAb+P/EKFxPAgzn
         wKi2d+gaNB5mkU3t+Ll3cs0BgOcw/D7/bESlJ6SD14kW6VtsUmm2uB+cPVXALBddqx
         ck+8t1V4rEH0R6eI+MqUs+ODO6ZxYX2BdDXnFBBzpWsar7+6cADmnk24r+0aoRXPr3
         ly+fTlba9RydA==
Date:   Wed, 18 May 2022 19:59:36 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <YoWkiCdduzyQxHR+@kbusch-mbp.dhcp.thefacebook.com>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <20220518171131.3525293-4-kbusch@fb.com>
 <YoWL+T8JiIO5Ln3h@sol.localdomain>
 <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com>
 <YoWjBxmKDQC1mCIz@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoWjBxmKDQC1mCIz@sol.localdomain>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 18, 2022 at 06:53:11PM -0700, Eric Biggers wrote:
> On Wed, May 18, 2022 at 07:00:39PM -0600, Keith Busch wrote:
> > On Wed, May 18, 2022 at 05:14:49PM -0700, Eric Biggers wrote:
> > > On Wed, May 18, 2022 at 10:11:31AM -0700, Keith Busch wrote:
> > > > diff --git a/block/fops.c b/block/fops.c
> > > > index b9b83030e0df..d8537c29602f 100644
> > > > --- a/block/fops.c
> > > > +++ b/block/fops.c
> > > > @@ -54,8 +54,9 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
> > > >  	struct bio bio;
> > > >  	ssize_t ret;
> > > >  
> > > > -	if ((pos | iov_iter_alignment(iter)) &
> > > > -	    (bdev_logical_block_size(bdev) - 1))
> > > > +	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
> > > > +		return -EINVAL;
> > > > +	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
> > > >  		return -EINVAL;
> > > 
> > > The block layer makes a lot of assumptions that bios can be split at any bvec
> > > boundary.  With this patch, bios whose length isn't a multiple of the logical
> > > block size can be generated by splitting, which isn't valid.
> > 
> > How? This patch ensures every segment is block size aligned.
> 
> No, it doesn't.  It ensures that the *total* length of each bio is logical block
> size aligned.  It doesn't ensure that for the individual bvecs.  By decreasing
> the required memory alignment to below the logical block size, you're allowing
> logical blocks to span a page boundary.  Whenever the two pages involved aren't
> physically contiguous, the data of the block will be split across two bvecs.

I'm aware that spanning pages can cause bad splits on the bi_max_vecs
condition, but I believe it's well handled here. Unless I'm terribly confused,
which is certainly possible, I think you may have missed this part of the
patch:

@@ -1223,6 +1224,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);

 	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	if (size > 0)
+		size = ALIGN_DOWN(size, queue_logical_block_size(q));
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;

