Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556261BD5FA
	for <lists+linux-block@lfdr.de>; Wed, 29 Apr 2020 09:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgD2H0a (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Apr 2020 03:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgD2H0a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 03:26:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855A6C03C1AD;
        Wed, 29 Apr 2020 00:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LGUajY3zrEqlVG97WYEWRDf+dd4RxLtAou449QsqwG8=; b=V7V1P9rMO8ynOmu1ucNMN2K119
        1XXWnJHB7kYIapdre1i+SIFMTjhfsPMlUUjHKR2Am/uBfX3nrnes6gpWaEUSXpOQa+g3dy7a/79gd
        vddgtayQBI9AgCBhiUnpYZmztiqUj4p1rViwVd1vFelA5QwoBFU8Ryuuddxb7MMtpVHrg/F+UE+6/
        YS/VTznhQ/FgzibxcCyA7hSYcqmjPiOm8b375zpibp11Y3ZWfTDt7JSkQC+0Mt/VKyDUt+/uN7FEI
        3Tcl6mJeoqbrpBGeBBtB88UBQVwm/3ncSzS+7SM5sU+7lzSBvbu/ayRY44VyMiHEpikGZc+hXlsQQ
        EvujYA5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTh6z-0000w9-VV; Wed, 29 Apr 2020 07:26:29 +0000
Date:   Wed, 29 Apr 2020 00:26:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] blk-mq: Use BUG_ON() instead of BUG()
Message-ID: <20200429072629.GE11410@infradead.org>
References: <1588126224-47877-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588126224-47877-1-git-send-email-zou_wei@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 10:10:24AM +0800, Zou Wei wrote:
> Fixes coccicheck warning:
> 
>  block/blk-mq.c:546:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
> 
> Fixes: 63151a449eba ("blk-mq: allow drivers to hook into I/O completion")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  block/blk-mq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index bcc3a23..49a227e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -542,8 +542,7 @@ EXPORT_SYMBOL(__blk_mq_end_request);
>  
>  void blk_mq_end_request(struct request *rq, blk_status_t error)
>  {
> -	if (blk_update_request(rq, error, blk_rq_bytes(rq)))
> -		BUG();
> +	BUG_ON(blk_update_request(rq, error, blk_rq_bytes(rq)));

I don't think hiding something that actually does do the work in a
BUG_ON ever is a good style.
