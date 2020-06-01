Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FE21E9D96
	for <lists+linux-block@lfdr.de>; Mon,  1 Jun 2020 07:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgFAFzz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 1 Jun 2020 01:55:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48195 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725818AbgFAFzz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jun 2020 01:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590990952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DIJ6Xj4Hoblj00gttZJAUGNw4TbO4ESUpy7u0xURB9w=;
        b=WHQXHVjumnqQ6OB8M7Yc7yzWjHIQtsqad6nHBSd/Mn9eQGTNiLe32GAm8O6CZxokBznIa8
        eJ9Pwf/tH3MeoQr+yyX+6tchJ4HyLndzUjoFRkx0PmMUCu+7AzudwXx/6y/0vzQSaSX5XP
        ho7G41BgJ/coBjTZGG9s7ytNlPwyzVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-ruq97eFdN4myvG1PZYcQQA-1; Mon, 01 Jun 2020 01:55:50 -0400
X-MC-Unique: ruq97eFdN4myvG1PZYcQQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8A8718A8220;
        Mon,  1 Jun 2020 05:55:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC0A360BE1;
        Mon,  1 Jun 2020 05:55:39 +0000 (UTC)
Subject: Re: [PATCH v3] block: improve discard bio alignment in
 __blkdev_issue_discard()
To:     Coly Li <colyli@suse.de>, linux-block@vger.kernel.org
Cc:     linux-bcache@vger.kernel.org,
        Acshai Manoj <acshai.manoj@microfocus.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Enzo Matsumiya <ematsumiya@suse.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
References: <20200530135231.122389-1-colyli@suse.de>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <1b8a99a6-3010-0927-9488-ce3b683609f4@redhat.com>
Date:   Mon, 1 Jun 2020 13:55:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20200530135231.122389-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 05/30/2020 09:52 PM, Coly Li wrote:
> This patch improves discard bio split for address and size alignment in
> __blkdev_issue_discard(). The aligned discard bio may help underlying
> device controller to perform better discard and internal garbage
> collection, and avoid unnecessary internal fragment.
>
> Current discard bio split algorithm in __blkdev_issue_discard() may have
> non-discarded fregment on device even the discard bio LBA and size are
> both aligned to device's discard granularity size.
>
> Here is the example steps on how to reproduce the above problem.
> - On a VMWare ESXi 6.5 update3 installation, create a 51GB virtual disk
>    with thin mode and give it to a Linux virtual machine.
> - Inside the Linux virtual machine, if the 50GB virtual disk shows up as
>    /dev/sdb, fill data into the first 50GB by,
>          # dd if=/dev/zero of=/dev/sdb bs=4096 count=13107200
> - Discard the 50GB range from offset 0 on /dev/sdb,
>          # blkdiscard /dev/sdb -o 0 -l 53687091200
> - Observe the underlying mapping status of the device
>          # sg_get_lba_status /dev/sdb -m 1048 --lba=0
>    descriptor LBA: 0x0000000000000000  blocks: 2048  mapped (or unknown)
>    descriptor LBA: 0x0000000000000800  blocks: 16773120  deallocated
>    descriptor LBA: 0x0000000000fff800  blocks: 2048  mapped (or unknown)
>    descriptor LBA: 0x0000000001000000  blocks: 8386560  deallocated
>    descriptor LBA: 0x00000000017ff800  blocks: 2048  mapped (or unknown)
>    descriptor LBA: 0x0000000001800000  blocks: 8386560  deallocated
>    descriptor LBA: 0x0000000001fff800  blocks: 2048  mapped (or unknown)
>    descriptor LBA: 0x0000000002000000  blocks: 8386560  deallocated
>    descriptor LBA: 0x00000000027ff800  blocks: 2048  mapped (or unknown)
>    descriptor LBA: 0x0000000002800000  blocks: 8386560  deallocated
>    descriptor LBA: 0x0000000002fff800  blocks: 2048  mapped (or unknown)
>    descriptor LBA: 0x0000000003000000  blocks: 8386560  deallocated
>    descriptor LBA: 0x00000000037ff800  blocks: 2048  mapped (or unknown)
>    descriptor LBA: 0x0000000003800000  blocks: 8386560  deallocated
>    descriptor LBA: 0x0000000003fff800  blocks: 2048  mapped (or unknown)
>    descriptor LBA: 0x0000000004000000  blocks: 8386560  deallocated
>    descriptor LBA: 0x00000000047ff800  blocks: 2048  mapped (or unknown)
>    descriptor LBA: 0x0000000004800000  blocks: 8386560  deallocated
>    descriptor LBA: 0x0000000004fff800  blocks: 2048  mapped (or unknown)
>    descriptor LBA: 0x0000000005000000  blocks: 8386560  deallocated
>    descriptor LBA: 0x00000000057ff800  blocks: 2048  mapped (or unknown)
>    descriptor LBA: 0x0000000005800000  blocks: 8386560  deallocated
>    descriptor LBA: 0x0000000005fff800  blocks: 2048  mapped (or unknown)
>    descriptor LBA: 0x0000000006000000  blocks: 6291456  deallocated
>    descriptor LBA: 0x0000000006600000  blocks: 0  deallocated
>
> Although the discard bio starts at LBA 0 and has 50<<30 bytes size which
> are perfect aligned to the discard granularity, from the above list
> these are many 1MB (2048 sectors) internal fragments exist unexpectedly.
>
> The problem is in __blkdev_issue_discard(), an improper algorithm causes
> an improper bio size which is not aligned.
>
>   25 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>   26                 sector_t nr_sects, gfp_t gfp_mask, int flags,
>   27                 struct bio **biop)
>   28 {
>   29         struct request_queue *q = bdev_get_queue(bdev);
>     [snipped]
>   56
>   57         while (nr_sects) {
>   58                 sector_t req_sects = min_t(sector_t, nr_sects,
>   59                                 bio_allowed_max_sectors(q));
>   60
>   61                 WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
>   62
>   63                 bio = blk_next_bio(bio, 0, gfp_mask);
>   64                 bio->bi_iter.bi_sector = sector;
>   65                 bio_set_dev(bio, bdev);
>   66                 bio_set_op_attrs(bio, op, 0);
>   67
>   68                 bio->bi_iter.bi_size = req_sects << 9;
>   69                 sector += req_sects;
>   70                 nr_sects -= req_sects;
>     [snipped]
>   79         }
>   80
>   81         *biop = bio;
>   82         return 0;
>   83 }
>   84 EXPORT_SYMBOL(__blkdev_issue_discard);
>
> At line 58-59, to discard a 50GB range, req_sects is set as return value
> of bio_allowed_max_sectors(q), which is 8388607 sectors. In the above
> case, the discard granularity is 2048 sectors, although the start LBA
> and discard length are aligned to discard granularity, req_sects never
> has chance to be aligned to discard granularity. This is why there are
> some still-mapped 2048 sectors fragment in every 4 or 8 GB range.
>
> If req_sects at line 58 is set to a value aligned to discard_granularity
> and close to UNIT_MAX, then all consequent split bios inside device
> driver are (almostly) aligned to discard_granularity of the device
> queue. The 2048 sectors still-mapped fragment will disappear.
>
> This patch introduces bio_aligned_discard_max_sectors() to return the
> the value which is aligned to q->limits.discard_granularity and closest
> to UINT_MAX. Then this patch replaces bio_allowed_max_sectors() with
> this new routine to decide a more proper split bio length.
>
> But we still need to handle the situation when discard start LBA is not
> aligned to q->limits.discard_granularity, otherwise even the length is
> aligned, current code may still leave 2048 fragment around every 4GB
> range. Therefore, to calculate req_sects, firstly the start LBA of
> discard range is checked, if it is not aligned to discard granularity,
> the first split location should make sure following bio has bi_sector
> aligned to discard granularity. Then there won't be still-mapped
> fragment in the middle of the discard range.
>
> The above is how this patch improves discard bio alignment in
> __blkdev_issue_discard(). Now with this patch, after discard with same
> command line mentiond previously, sg_get_lba_status returns,
> descriptor LBA: 0x0000000000000000  blocks: 106954752  deallocated
> descriptor LBA: 0x0000000006600000  blocks: 0  deallocated
>
> We an see there is no 2048 sectors segment anymore, everything is clean.
>
> Reported-by: Acshai Manoj <acshai.manoj@microfocus.com>
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Enzo Matsumiya <ematsumiya@suse.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Xiao Ni <xni@redhat.com>
> ---
> Changelog:
> v2, the improved version with inspire from review comments by Bart,
>      Ming and Xiao.
> v1, the initial version.
>
>   block/blk-lib.c | 25 +++++++++++++++++++++++--
>   block/blk.h     | 14 ++++++++++++++
>   2 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 5f2c429d4378..7bffdee63a20 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -55,8 +55,29 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>   		return -EINVAL;
>   
>   	while (nr_sects) {
> -		sector_t req_sects = min_t(sector_t, nr_sects,
> -				bio_allowed_max_sectors(q));
> +		sector_t granularity_aligned_lba;
> +		sector_t req_sects;
> +
> +		granularity_aligned_lba = round_up(sector,
> +				q->limits.discard_granularity >> SECTOR_SHIFT);
> +
> +		/*
> +		 * Check whether the discard bio starts at a discard_granularity
> +		 * aligned LBA,
> +		 * - If no: set (granularity_aligned_lba - sector) to bi_size of
> +		 *   the first split bio, then the second bio will start at a
> +		 *   discard_granularity aligned LBA.
> +		 * - If yes: use bio_aligned_discard_max_sectors() as the max
> +		 *   possible bi_size of the first split bio. Then when this bio
> +		 *   is split in device drive, the split ones are very probably
> +		 *   to be aligned to discard_granularity of the device's queue.
> +		 */
> +		if (granularity_aligned_lba == sector)
> +			req_sects = min_t(sector_t, nr_sects,
> +					  bio_aligned_discard_max_sectors(q));
> +		else
> +			req_sects = min_t(sector_t, nr_sects,
> +					  granularity_aligned_lba - sector);
>   
>   		WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
>   
> diff --git a/block/blk.h b/block/blk.h
> index 0a94ec68af32..589007ac564e 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -292,6 +292,20 @@ static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
>   	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
>   }
>   
> +/*
> + * The max bio size which is aligned to q->limits.discard_granularity. This
> + * is a hint to split large discard bio in generic block layer, then if device
> + * driver needs to split the discard bio into smaller ones, their bi_size can
> + * be very probably and easily aligned to discard_granularity of the device's
> + * queue.
> + */
> +static inline unsigned int bio_aligned_discard_max_sectors(
> +					struct request_queue *q)
> +{
> +	return round_down(UINT_MAX, q->limits.discard_granularity) >>
> +			SECTOR_SHIFT;
> +}
> +
>   /*
>    * Internal io_context interface
>    */
Reviewed-by: Xiao Ni <xni@redhat.com>

