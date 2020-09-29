Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30027B85F
	for <lists+linux-block@lfdr.de>; Tue, 29 Sep 2020 01:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgI1Xkb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 28 Sep 2020 19:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgI1Xkb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 19:40:31 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9278F2389F;
        Mon, 28 Sep 2020 22:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601331677;
        bh=I+9KCmG29XWUvT/SwB+J7fZNEQSnCsF+RhKZtZeeDPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=atYoa7IPm05DQEvBm+59B+if2hKMKGVLh8nxjQlnnsia2ZVs/NmspWumWrnRN6kBW
         FDEICPNSmeimCt8WQjmof/Uv969izA+P5ONxhPWFWIbpsYtn6UE5xLYQxD0d1k2+e+
         LoflNcb3nFeGTuJ6Sy2OsRxUPFqtR0oiZb42RF0Q=
Date:   Mon, 28 Sep 2020 15:21:16 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: change the hash used for looking up block devices
Message-ID: <20200928222116.GG1340@sol.localdomain>
References: <20200927071115.372289-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927071115.372289-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 27, 2020 at 09:11:15AM +0200, Christoph Hellwig wrote:
> Adding the minor to the major creates tons of pointless conflicts. Just
> use the dev_t itself, which is 32-bits and thus is guaranteed to fit
> into ino_t.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/block_dev.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 6b9d19ffa5af7b..da7d4868057632 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -870,35 +870,12 @@ void __init bdev_cache_init(void)
>  	blockdev_superblock = bd_mnt->mnt_sb;   /* For writeback */
>  }
>  
> -/*
> - * Most likely _very_ bad one - but then it's hardly critical for small
> - * /dev and can be fixed when somebody will need really large one.
> - * Keep in mind that it will be fed through icache hash function too.
> - */
> -static inline unsigned long hash(dev_t dev)
> -{
> -	return MAJOR(dev)+MINOR(dev);
> -}
> -
> -static int bdev_test(struct inode *inode, void *data)
> -{
> -	return BDEV_I(inode)->bdev.bd_dev == *(dev_t *)data;
> -}
> -
> -static int bdev_set(struct inode *inode, void *data)
> -{
> -	BDEV_I(inode)->bdev.bd_dev = *(dev_t *)data;
> -	return 0;
> -}
> -
>  struct block_device *bdget(dev_t dev)
>  {
>  	struct block_device *bdev;
>  	struct inode *inode;
>  
> -	inode = iget5_locked(blockdev_superblock, hash(dev),
> -			bdev_test, bdev_set, &dev);
> -
> +	inode = iget_locked(blockdev_superblock, dev);
>  	if (!inode)
>  		return NULL;

Doesn't ->bd_dev still need to be set somewhere?

- Eric
