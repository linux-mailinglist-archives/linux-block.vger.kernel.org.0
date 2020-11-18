Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6252B86AE
	for <lists+linux-block@lfdr.de>; Wed, 18 Nov 2020 22:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgKRVeb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 Nov 2020 16:34:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:52074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgKRVe0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Nov 2020 16:34:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35A12B011;
        Wed, 18 Nov 2020 21:34:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A0C1D1E130B; Wed, 18 Nov 2020 15:10:24 +0100 (CET)
Date:   Wed, 18 Nov 2020 15:10:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 02/20] block: remove a duplicate __disk_get_part prototype
Message-ID: <20201118141024.GG1981@quack2.suse.cz>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118084800.2339180-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 18-11-20 09:47:42, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/genhd.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 46553d6d602563..22f5b9fd96f8bf 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -250,7 +250,6 @@ static inline dev_t part_devt(struct hd_struct *part)
>  	return part_to_dev(part)->devt;
>  }
>  
> -extern struct hd_struct *__disk_get_part(struct gendisk *disk, int partno);
>  extern struct hd_struct *disk_get_part(struct gendisk *disk, int partno);
>  
>  static inline void disk_put_part(struct hd_struct *part)
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
