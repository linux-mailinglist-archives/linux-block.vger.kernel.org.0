Return-Path: <linux-block+bounces-2847-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEEE84881D
	for <lists+linux-block@lfdr.de>; Sat,  3 Feb 2024 18:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB51CB23CB4
	for <lists+linux-block@lfdr.de>; Sat,  3 Feb 2024 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AFD5F46B;
	Sat,  3 Feb 2024 17:58:55 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D933C5F865
	for <linux-block@vger.kernel.org>; Sat,  3 Feb 2024 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706983134; cv=none; b=NSY0yE5XS0TuebuBtzDzjP4tEroP8KqghC2TE4WLDkxEBY1zqQG5/rkTtGjdXL+520Tx+RvnUXPZVPRsxniJadq68F4nEZOqKwvw6KfeaaZ6vtZCPlFhaQtdZ+J7jI4CiuqHN6vkkShL4os4Y8YRm+vw5A0zm9JWHPTEhb01zk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706983134; c=relaxed/simple;
	bh=GMR9eTy07E8pepEiT1I2Ci94pv1fx2XZ3jo3DIztS5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZyZvqyqyBaKHNGECItnYIboxtmmyL2FNsXVKJudEiVK8WisrxVkKog66JROSMclElrIPQb9e/ovoVcu54THgJrgcp3ZbwXmTk1PlGbiPPnE9/jWaycA6MMm30QoiTU75ygsJjiA4Y04CDymaWs9qpSUmTzJOFGl2ueAHoc1wtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e0f43074edso1931856a34.1
        for <linux-block@vger.kernel.org>; Sat, 03 Feb 2024 09:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706983131; x=1707587931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOliNUqI71qLaQZn8VZTphk7egJbvCAyLqPvDh9Lh3w=;
        b=oVCPWtma4VtvQ5PbcOcxwawKEzBuUDpowlkppT7rRyFlTjaM1HuMGKDegnQwyeKoWv
         VnYRAlU0WKgKYwlyilqUF8G7jcQFIEuYl7VdVt8pcKyu1D01Bl+Cs7ifz1x8rbVYabO4
         vew+/V/LZ+4Bv8CnNDGGDtWuvX+dtQUu+cGEuY7NOyGaiW9AXnflGHSCeD+ncxmp6pO/
         r9MH7+8s8e6gfVnesdbqbnocLSNwHCRseNfk6/A6ppBYptzoRrqU1Wem/TWpvBVBd3yU
         Lu4w/mKLkjPKvjZGt6+QtN8Ppe3wnJktt1Zuqr0EI2ExpWfhHtbJhMd/GZjHkxPKMJ1E
         71cg==
X-Gm-Message-State: AOJu0Yx6nRfc67+zdDVqeqf/If7pegrLEDJEKzB/cYnYCsDabHZvEFJZ
	RHEVaZZxzY/ebvQtIMJPhKxs2A18LMV4ppgLwkktGezUEliL0Eup7CClGGxwpw==
X-Google-Smtp-Source: AGHT+IGTtt7bhSSQCWu93iUoruII8M21I1KuWYt41Al2/26tOAVs7IfkYmE1K/wOoyn5Wimk46x5RQ==
X-Received: by 2002:a05:6870:2006:b0:219:44bb:ba93 with SMTP id o6-20020a056870200600b0021944bbba93mr2442939oab.17.1706983129580;
        Sat, 03 Feb 2024 09:58:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUSr51JqyMhwRKWtGx14yO6OQu0fv9MTwI870NV93oAbFWcKw3iTQxO8+vfSVxwYWzVvUIdlZ5E04renrZVX8eL037w8l7kFY4K7N6/XfLArJ42kF2g+uHTZ4KE5qOLqHiht2k2hXkfHZ7WifloEBRtkDYr27GdO0P8v4bPpfownyxiHvvFXHD7xA+eU6c7AOL13B+LjLFSMY3oLEBy
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id l22-20020ac87256000000b0042bf0b37b5csm1974371qtp.28.2024.02.03.09.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 09:58:49 -0800 (PST)
Date: Sat, 3 Feb 2024 12:58:48 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/26] dm: Use the block layer zone append emulation
Message-ID: <Zb5-2LsnQtJHV2mL@redhat.com>
References: <20240202073104.2418230-1-dlemoal@kernel.org>
 <20240202073104.2418230-11-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202073104.2418230-11-dlemoal@kernel.org>

On Fri, Feb 02 2024 at  2:30P -0500,
Damien Le Moal <dlemoal@kernel.org> wrote:

> For targets requiring zone append operation emulation with regular
> writes (e.g. dm-crypt), we can use the block layer emulation provided by
> zone write plugging. Remove DM implemented zone append emulation and
> enable the block layer one.
> 
> This is done by setting the max_zone_append_sectors limit of the
> mapped device queue to 0 for mapped devices that have a target table
> that cannot support native zone append operations. These includes
> mixed zoned and non-zoned targets, or targets that explicitly requested
> emulation of zone append (e.g. dm-crypt). For these mapped devices, the
> new field emulate_zone_append is set to true. dm_split_and_process_bio()
> is modified to call blk_zone_write_plug_bio() for such device to let the
> block layer transform zone append operations into regular writes. This
> is done after ensuring that the submitted BIO is split if it straddles
> zone boundaries.
> 
> dm_revalidate_zones() is also modified to use the block layer provided
> function blk_revalidate_disk_zones() so that all zone resources needed
> for zone append emulation are allocated and initialized by the block
> layer without DM core needing to do anything. Since the device table is
> not yet live when dm_revalidate_zones() is executed, enabling the use of
> blk_revalidate_disk_zones() requires adding a pointer to the device
> table in struct mapped_device. This avoids errors in
> dm_blk_report_zones() trying to get the table with dm_get_live_table().
> The mapped device table pointer is set to the table passed as argument
> to dm_revalidate_zones() before calling blk_revalidate_disk_zones() and
> reset to NULL after this function returns to restore the live table
> handling for user call of report zones.
> 
> All the code related to zone append emulation is removed from
> dm-zone.c. This leads to simplifications of the functions __map_bio()
> and dm_zone_endio(). This later function now only needs to deal with
> completions of real zone append operations for targets that support it.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Love the overall improvement to the DM core code and the broader block
layer by switching to this bio-based ZWP approach.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

But one incremental suggestion inlined below.

> ---
>  drivers/md/dm-core.h |  11 +-
>  drivers/md/dm-zone.c | 470 ++++---------------------------------------
>  drivers/md/dm.c      |  44 ++--
>  drivers/md/dm.h      |   7 -
>  4 files changed, 68 insertions(+), 464 deletions(-)
> 

<snip>

> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 8dcabf84d866..92ce3b2eb4ae 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1419,25 +1419,12 @@ static void __map_bio(struct bio *clone)
>  		down(&md->swap_bios_semaphore);
>  	}
>  
> -	if (static_branch_unlikely(&zoned_enabled)) {
> -		/*
> -		 * Check if the IO needs a special mapping due to zone append
> -		 * emulation on zoned target. In this case, dm_zone_map_bio()
> -		 * calls the target map operation.
> -		 */
> -		if (unlikely(dm_emulate_zone_append(md)))
> -			r = dm_zone_map_bio(tio);
> -		else
> -			goto do_map;
> -	} else {
> -do_map:
> -		if (likely(ti->type->map == linear_map))
> -			r = linear_map(ti, clone);
> -		else if (ti->type->map == stripe_map)
> -			r = stripe_map(ti, clone);
> -		else
> -			r = ti->type->map(ti, clone);
> -	}
> +	if (likely(ti->type->map == linear_map))
> +		r = linear_map(ti, clone);
> +	else if (ti->type->map == stripe_map)
> +		r = stripe_map(ti, clone);
> +	else
> +		r = ti->type->map(ti, clone);
>  
>  	switch (r) {
>  	case DM_MAPIO_SUBMITTED:
> @@ -1774,19 +1761,33 @@ static void dm_split_and_process_bio(struct mapped_device *md,
>  	struct clone_info ci;
>  	struct dm_io *io;
>  	blk_status_t error = BLK_STS_OK;
> -	bool is_abnormal;
> +	bool is_abnormal, need_split;
>  
>  	is_abnormal = is_abnormal_io(bio);
> -	if (unlikely(is_abnormal)) {
> +	if (likely(!md->emulate_zone_append))
> +		need_split = is_abnormal;
> +	else
> +		need_split = is_abnormal || bio_straddle_zones(bio);
> +	if (unlikely(need_split)) {
>  		/*
>  		 * Use bio_split_to_limits() for abnormal IO (e.g. discard, etc)
>  		 * otherwise associated queue_limits won't be imposed.
> +		 * Also split the BIO for mapped devices needing zone append
> +		 * emulation to ensure that the BIO does not cross zone
> +		 * boundaries.
>  		 */
>  		bio = bio_split_to_limits(bio);
>  		if (!bio)
>  			return;
>  	}
>  
> +	/*
> +	 * Use the block layer zone write plugging for mapped devices that
> +	 * need zone append emulation (e.g. dm-crypt).
> +	 */
> +	if (md->emulate_zone_append && blk_zone_write_plug_bio(bio, 0))
> +		return;
> +
>  	/* Only support nowait for normal IO */
>  	if (unlikely(bio->bi_opf & REQ_NOWAIT) && !is_abnormal) {
>  		io = alloc_io(md, bio, GFP_NOWAIT);

Would prefer to see this incremental change included from the start:

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 92ce3b2eb4ae..1fd9bbf35db3 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1763,11 +1763,10 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 	blk_status_t error = BLK_STS_OK;
 	bool is_abnormal, need_split;
 
-	is_abnormal = is_abnormal_io(bio);
-	if (likely(!md->emulate_zone_append))
-		need_split = is_abnormal;
-	else
+	need_split = is_abnormal = is_abnormal_io(bio);
+	if (static_branch_unlikely(&zoned_enabled) && unlikely(md->emulate_zone_append))
 		need_split = is_abnormal || bio_straddle_zones(bio);
+
 	if (unlikely(need_split)) {
 		/*
 		 * Use bio_split_to_limits() for abnormal IO (e.g. discard, etc)
@@ -1781,12 +1780,14 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 			return;
 	}
 
-	/*
-	 * Use the block layer zone write plugging for mapped devices that
-	 * need zone append emulation (e.g. dm-crypt).
-	 */
-	if (md->emulate_zone_append && blk_zone_write_plug_bio(bio, 0))
-		return;
+	if (static_branch_unlikely(&zoned_enabled)) {
+		/*
+		 * Use the block layer zone write plugging for mapped devices that
+		 * need zone append emulation (e.g. dm-crypt).
+		 */
+		if (unlikely(md->emulate_zone_append) && blk_zone_write_plug_bio(bio, 0))
+			return;
+	}
 
 	/* Only support nowait for normal IO */
 	if (unlikely(bio->bi_opf & REQ_NOWAIT) && !is_abnormal) {

