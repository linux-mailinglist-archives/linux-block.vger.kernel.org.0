Return-Path: <linux-block+bounces-2232-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31395839A26
	for <lists+linux-block@lfdr.de>; Tue, 23 Jan 2024 21:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 927D7B29836
	for <lists+linux-block@lfdr.de>; Tue, 23 Jan 2024 20:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B84785C6F;
	Tue, 23 Jan 2024 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKzB7+iQ"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA8182D9A
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041134; cv=none; b=JMfa2my6WOJovsQ2ekM0AqZVMnl/EcmkmqQIW9WSSQgeBwbeB93ZYouCuBPpZsC3Decu1yOEeQXrD2Eyh1zhxHQwsXCs/s/S7HtVrNou1IzSi30czLohIb0Om2sLQ9CvgchFYg/ZBhroG6Im01HqPnxvBxArdxm+WYkW7itv5nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041134; c=relaxed/simple;
	bh=eHPdMiedBHLxjR/VrGf90w5dVPBjtNVAkIoW+L8GPQw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=drVtfDWJX4kutHkboPUq6CYkjfSlyb7glryTBeBXNFMgy0dX6HtgTAkN8nhhzArFfiDaIBsHhXwmhcrbUbcGqPdaiIjMAHgJEH3WCME4WEmdue9QidojfiimmrfSrDSwsv/uSeQnBUEJpp+OckCnC3BLtg9slp7nzbbsl6SouPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKzB7+iQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706041131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0XX4UE7LBcIxPzCfE5s5PrNdR9h0h9VUxg0e4qCV+gs=;
	b=PKzB7+iQpMuxs6eOESZERlbarhhR0qaPQxl5UfdtxfDMckZ9VNWa7/+Bs6SlsDw+ttp7A4
	1nE2//cnxUr6CRfhO4eF5jQwb3EUTInRIoB0+BzIaXUuQxzo1T2MFhQTGd6Efj09wSNccG
	a41HnwdH7B+MpGpodjfWBt9g9q/itfg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-EUy2mcVyOKOCDA3_mOVAAQ-1; Tue, 23 Jan 2024 15:18:47 -0500
X-MC-Unique: EUy2mcVyOKOCDA3_mOVAAQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C176188B5BD;
	Tue, 23 Jan 2024 20:18:45 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A1AB51D5;
	Tue, 23 Jan 2024 20:18:45 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 6180130A79CB; Tue, 23 Jan 2024 20:18:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 5BF883FB4E;
	Tue, 23 Jan 2024 21:18:45 +0100 (CET)
Date: Tue, 23 Jan 2024 21:18:45 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
cc: Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
    Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev, 
    Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
    David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, 
    Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
    Chaitanya Kulkarni <kch@nvidia.com>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
    linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org, 
    linux-nvme@lists.infradead.org, 
    "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 2/5] dm: dm-zoned: pass GFP_KERNEL to blkdev_zone_mgmt
In-Reply-To: <20240123-zonefs_nofs-v1-2-cc0b0308ef25@wdc.com>
Message-ID: <55226421-ce21-f769-94e0-d42c97e55e7d@redhat.com>
References: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com> <20240123-zonefs_nofs-v1-2-cc0b0308ef25@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5



On Tue, 23 Jan 2024, Johannes Thumshirn wrote:

> The call to blkdev_zone_mgmt() in dm-zoned is only used to perform a
> ZONE_RESET operation when freeing a zone.
> 
> This is not done in the IO path, so we can use GFP_KERNEL here, as it will
> never recurse back into the driver on reclaim.

Hi

This doesn't seem safe to me. There's a possible call chain dmz_handle_bio 
-> dmz_put_chunk_mapping -> dmz_free_zone -> dmz_reset_zone -> 
blkdev_zone_mgmt -> recursion (via GFP_KERNEL) back into the dm-zoned 
target.

Mikulas

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  drivers/md/dm-zoned-metadata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
> index fdfe30f7b697..a39734f0cb7d 100644
> --- a/drivers/md/dm-zoned-metadata.c
> +++ b/drivers/md/dm-zoned-metadata.c
> @@ -1658,7 +1658,7 @@ static int dmz_reset_zone(struct dmz_metadata *zmd, struct dm_zone *zone)
>  
>  		ret = blkdev_zone_mgmt(dev->bdev, REQ_OP_ZONE_RESET,
>  				       dmz_start_sect(zmd, zone),
> -				       zmd->zone_nr_sectors, GFP_NOIO);
> +				       zmd->zone_nr_sectors, GFP_KERNEL);
>  		if (ret) {
>  			dmz_dev_err(dev, "Reset zone %u failed %d",
>  				    zone->id, ret);
> 
> -- 
> 2.43.0
> 
> 


