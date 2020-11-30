Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C1B2C7E70
	for <lists+linux-block@lfdr.de>; Mon, 30 Nov 2020 08:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgK3HIk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 Nov 2020 02:08:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:37500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgK3HIj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 02:08:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A17FAC8F;
        Mon, 30 Nov 2020 07:07:58 +0000 (UTC)
Subject: Re: [PATCH 07/45] loop: do not call set_blocksize
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201128161510.347752-1-hch@lst.de>
 <20201128161510.347752-8-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2b576021-844b-cdd9-a11d-f1f124707e65@suse.de>
Date:   Mon, 30 Nov 2020 08:07:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128161510.347752-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/20 5:14 PM, Christoph Hellwig wrote:
> set_blocksize is used by file systems to use their preferred buffer cache
> block size.  Block drivers should not set it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>   drivers/block/loop.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 9a27d4f1c08aac..b42c728620c9e4 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1164,9 +1164,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>   	size = get_loop_size(lo, file);
>   	loop_set_size(lo, size);
>   
> -	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
> -		      block_size(inode->i_bdev) : PAGE_SIZE);
> -
>   	lo->lo_state = Lo_bound;
>   	if (part_shift)
>   		lo->lo_flags |= LO_FLAGS_PARTSCAN;
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
