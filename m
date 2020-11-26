Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119302C5AA9
	for <lists+linux-block@lfdr.de>; Thu, 26 Nov 2020 18:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391672AbgKZRfU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Nov 2020 12:35:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:40188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391600AbgKZRfU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 12:35:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E1737ACBD;
        Thu, 26 Nov 2020 17:35:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5BFEB1E10D0; Thu, 26 Nov 2020 18:35:18 +0100 (CET)
Date:   Thu, 26 Nov 2020 18:35:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 36/44] block: allocate struct hd_struct as part of struct
 bdev_inode
Message-ID: <20201126173518.GV422@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-37-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126130422.92945-37-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 26-11-20 14:04:14, Christoph Hellwig wrote:
> Allocate hd_struct together with struct block_device to pre-load
> the lifetime rule changes in preparation of merging the two structures.
> 
> Note that part0 was previously embedded into struct gendisk, but is
> a separate allocation now, and already points to the block_device instead
> of the hd_struct.  The lifetime of struct gendisk is still controlled by
> the struct device embedded in the part0 hd_struct.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Just one comment below. With that fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index f397ec9922bd6e..9c7e6730fa6098 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -265,9 +265,9 @@ static const struct attribute_group *part_attr_groups[] = {
>  static void part_release(struct device *dev)
>  {
>  	struct hd_struct *p = dev_to_part(dev);
> +
>  	blk_free_devt(dev->devt);
> -	hd_free_part(p);
> -	kfree(p);
> +	bdput(p->bdev);
>  }

I don't think hd_struct holds a reference to block_device, does it?
bdev_alloc() now just assigns bdev->bd_part->bdev = bdev...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
