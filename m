Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4C2388CE9
	for <lists+linux-block@lfdr.de>; Wed, 19 May 2021 13:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbhESLiF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 May 2021 07:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhESLiF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 07:38:05 -0400
X-Greylist: delayed 2123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 May 2021 04:36:45 PDT
Received: from wp118.webpack.hosteurope.de (wp118.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:847d::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCBEC06175F
        for <linux-block@vger.kernel.org>; Wed, 19 May 2021 04:36:45 -0700 (PDT)
Received: from app20-neu.ox.hosteurope.de ([92.51.170.154]); authenticated
        by wp118.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1ljJx0-0000iH-Q8; Wed, 19 May 2021 13:01:18 +0200
Date:   Wed, 19 May 2021 13:01:18 +0200 (CEST)
From:   wp1083705-spam02 wp1083705-spam02 <spam02@dazinger.net>
To:     Christoph Hellwig <hch@lst.de>, song@kernel.org, axboe@kernel.dk
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org
Message-ID: <1102825331.165797.1621422078235@ox.hosteurope.de>
In-Reply-To: <20210519062215.4111256-1-hch@lst.de>
References: <20210519062215.4111256-1-hch@lst.de>
Subject: Re: [PATCH] md/raid5: remove an incorect assert in
 in_chunk_boundary
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.4-Rev21
X-Originating-IP: 87.247.200.216
X-Originating-Client: open-xchange-appsuite
X-Originating-Sender: spam02@dazinger.net
X-bounce-key: webpack.hosteurope.de;spam02@dazinger.net;1621424205;2e6f0c14;
X-HE-SMSGID: 1ljJx0-0000iH-Q8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Christoph Hellwig <hch@lst.de> hat am 19.05.2021 08:22 geschrieben:
> 
>  
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

yes, this solves it, I can confirm with this patch the error/warning message when booting linux-5.12 is gone!

Thanks a lot!
Florian
