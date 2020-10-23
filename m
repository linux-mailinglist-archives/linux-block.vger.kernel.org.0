Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5E429704D
	for <lists+linux-block@lfdr.de>; Fri, 23 Oct 2020 15:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373408AbgJWNVj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Oct 2020 09:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373214AbgJWNVj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Oct 2020 09:21:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A00C0613CE;
        Fri, 23 Oct 2020 06:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/2c0g9gKUSdARpYmdua/z4fhTsqME5++uEBau8jJhvQ=; b=TxRWkWPeM0PGLBYhraIWYx3jji
        vKvRNw8Lf9phgFQfED1jI6awnEFbU0BtkMhp/uqDCSHeoiWNiTl7dt8tg2m5uctFsWV5VUWl8YSj9
        g+Z1IqHuZVGDENuXOe5tjRl0joghyf16i4DIhaFs26S9NdA/ehclAN49LifG1k3D2gHiFk4VtRMGb
        Ybs1JCPcJhRTW8SMGF/uf5wIruyKjFFr6Te1zMKitSSzZWFCBKxGEp/WfzTI8mp9g+OCBpwbRbd+S
        2QstdDkheQmWcUj8yV8+ZQ0XzM4K4b9q43p2SK2scFj1LtU1yLp3bkbCD5R/LR6hlGaHr4k3icMqd
        MWxCurrA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVx0k-0005mF-39; Fri, 23 Oct 2020 13:21:38 +0000
Date:   Fri, 23 Oct 2020 14:21:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: Convert block_read_full_page to be synchronous
Message-ID: <20201023132138.GB20115@casper.infradead.org>
References: <20201022212228.15703-1-willy@infradead.org>
 <20201022212228.15703-4-willy@infradead.org>
 <20201022234011.GD3613750@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022234011.GD3613750@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 22, 2020 at 04:40:11PM -0700, Eric Biggers wrote:
> On Thu, Oct 22, 2020 at 10:22:25PM +0100, Matthew Wilcox (Oracle) wrote:
> > +static int readpage_submit_bhs(struct page *page, struct blk_completion *cmpl,
> > +		unsigned int nr, struct buffer_head **bhs)
> > +{
> > +	struct bio *bio = NULL;
> > +	unsigned int i;
> > +	int err;
> > +
> > +	blk_completion_init(cmpl, nr);
> > +
> > +	for (i = 0; i < nr; i++) {
> > +		struct buffer_head *bh = bhs[i];
> > +		sector_t sector = bh->b_blocknr * (bh->b_size >> 9);
> > +		bool same_page;
> > +
> > +		if (buffer_uptodate(bh)) {
> > +			end_buffer_async_read(bh, 1);
> > +			blk_completion_sub(cmpl, BLK_STS_OK, 1);
> > +			continue;
> > +		}
> > +		if (bio) {
> > +			if (bio_end_sector(bio) == sector &&
> > +			    __bio_try_merge_page(bio, bh->b_page, bh->b_size,
> > +					bh_offset(bh), &same_page))
> > +				continue;
> > +			submit_bio(bio);
> > +		}
> > +		bio = bio_alloc(GFP_NOIO, 1);
> > +		bio_set_dev(bio, bh->b_bdev);
> > +		bio->bi_iter.bi_sector = sector;
> > +		bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
> > +		bio->bi_end_io = readpage_end_bio;
> > +		bio->bi_private = cmpl;
> > +		/* Take care of bh's that straddle the end of the device */
> > +		guard_bio_eod(bio);
> > +	}
> 
> The following is needed to set the bio encryption context for the
> '-o inlinecrypt' case on ext4:
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 95c338e2b99c..546a08c5003b 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2237,6 +2237,7 @@ static int readpage_submit_bhs(struct page *page, struct blk_completion *cmpl,
>  			submit_bio(bio);
>  		}
>  		bio = bio_alloc(GFP_NOIO, 1);
> +		fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
>  		bio_set_dev(bio, bh->b_bdev);
>  		bio->bi_iter.bi_sector = sector;
>  		bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));

Thanks!  I saw that and had every intention of copying it across.
And then I forgot.  I'll add that.  I'm also going to do:

-                           __bio_try_merge_page(bio, bh->b_page, bh->b_size,
-                                       bh_offset(bh), &same_page))
+                           bio_add_page(bio, bh->b_page, bh->b_size,
+                                       bh_offset(bh)))

I wonder about allocating bios that can accommodate more bvecs.  Not sure
how often filesystems have adjacent blocks which go into non-adjacent
sub-page blocks.  It's certainly possible that a filesystem might have
a page consisting of DDhhDDDD ('D' for Data, 'h' for hole), but how
likely is it to have written the two data chunks next to each other?
Maybe with O_SYNC?

Anyway, this patchset needs some more thought because I've just seen
the path from mpage_readahead() to block_read_full_page() that should
definitely not be synchronous.
