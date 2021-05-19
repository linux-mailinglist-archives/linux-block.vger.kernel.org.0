Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9332838877E
	for <lists+linux-block@lfdr.de>; Wed, 19 May 2021 08:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhESG0G (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 May 2021 02:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhESG0G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 02:26:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9FFC06175F;
        Tue, 18 May 2021 23:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SDkzOixdbKtAXhONcwwO+uZ0tQOsJcX7nllPcsziFLE=; b=Yq44CG4ZbXirepqi/YtI0iGf6I
        ra2hIhVutUDo3/WxEb6qeEanH2LcZOC0aMamk4HZQgQVhSr2Logy1iuSxsQMj3VqyJzqY9lH65XxX
        f1QuYZ9Fj0fhkMi7Y2Q4FhnqIoXgtsT3asCT6YLsr67pLYp07pEDbd3XZJmBfiwl44+RGibUQ5JWo
        4YuAV+jaPJEaxObGpCXHVgQCGarPoPWg9k3XDvvxoa+DlEaqbl3BhB520JZmvsWaFEdtLI+MFoC7I
        7LdNQnF6TLFOhuAJx+Pd+sAiWuz8rPQs2CP9DbYQPL/Vv2xG62W60Of7xSTHi+r/Dwlx0hXXv0NTG
        wTG51Ovg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljFcr-00Egfv-5k; Wed, 19 May 2021 06:24:23 +0000
Date:   Wed, 19 May 2021 07:24:13 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     song@kernel.org, axboe@kernel.dk, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, "Florian D ." <spam02@dazinger.net>
Subject: Re: [PATCH] md/raid5: remove an incorect assert in in_chunk_boundary
Message-ID: <YKSvDeWqtmYOl/ua@infradead.org>
References: <20210519062215.4111256-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519062215.4111256-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

s/incorect/incorrect/ in the subject, sorry.

On Wed, May 19, 2021 at 08:22:15AM +0200, Christoph Hellwig wrote:
> Now that the original bdev is stored in the bio this assert is incorrect
> and will trigge for any partitioned raid5 device.
> 
> Reported-by:  Florian D. <spam02@dazinger.net>
> Fixes: 309dca309fc3 ("block: store a block_device pointer in struct bio"),
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/md/raid5.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 841e1c1aa5e6..7d4ff8a5c55e 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -5311,8 +5311,6 @@ static int in_chunk_boundary(struct mddev *mddev, struct bio *bio)
>  	unsigned int chunk_sectors;
>  	unsigned int bio_sectors = bio_sectors(bio);
>  
> -	WARN_ON_ONCE(bio->bi_bdev->bd_partno);
> -
>  	chunk_sectors = min(conf->chunk_sectors, conf->prev_chunk_sectors);
>  	return  chunk_sectors >=
>  		((sector & (chunk_sectors - 1)) + bio_sectors);
> -- 
> 2.30.2
> 
---end quoted text---
