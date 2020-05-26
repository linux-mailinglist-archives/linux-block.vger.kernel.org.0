Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DF71C011E
	for <lists+linux-block@lfdr.de>; Thu, 30 Apr 2020 18:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgD3QBf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 30 Apr 2020 12:01:35 -0400
Received: from verein.lst.de ([213.95.11.211]:41635 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgD3QBf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 12:01:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4E6EF68D07; Thu, 30 Apr 2020 18:01:33 +0200 (CEST)
Date:   Thu, 30 Apr 2020 18:01:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     sandeen@sandeen.net, linux-block@vger.kernel.org,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: Re: [PATCH] block: remove the bd_openers checks in
 blk_drop_partitions
Message-ID: <20200430160133.GA3752@lst.de>
References: <20200428085203.1852494-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200428085203.1852494-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

can you pick this one up?

On Tue, Apr 28, 2020 at 10:52:03AM +0200, Christoph Hellwig wrote:
> When replacing the bd_super check with a bd_openers I followed a logical
> conclusion, which turns out to be utterly wrong.  When a block device has
> bd_super sets it has a mount file system on it (although not every
> mounted file system sets bd_super), but that also implies it doesn't even
> have partitions to start with.
> 
> So instead of trying to come up with a logical check for all openers,
> just remove the check entirely.
> 
> Fixes: d3ef5536274f ("block: fix busy device checking in blk_drop_partitions")
> Fixes: cb6b771b05c3 ("block: fix busy device checking in blk_drop_partitions again")
> Reported-by: Michal Koutn� <mkoutny@suse.com>
> Reported-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/partitions/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index bc1ded1331b14..9ef48a8cff867 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -496,7 +496,7 @@ int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
>  
>  	if (!disk_part_scan_enabled(disk))
>  		return 0;
> -	if (bdev->bd_part_count || bdev->bd_openers > 1)
> +	if (bdev->bd_part_count)
>  		return -EBUSY;
>  	res = invalidate_partition(disk, 0);
>  	if (res)
> -- 
> 2.26.1
---end quoted text---
