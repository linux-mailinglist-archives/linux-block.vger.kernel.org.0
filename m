Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF84E7D74E7
	for <lists+linux-block@lfdr.de>; Wed, 25 Oct 2023 21:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjJYTz7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Oct 2023 15:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJYTz6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Oct 2023 15:55:58 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D8E93
        for <linux-block@vger.kernel.org>; Wed, 25 Oct 2023 12:55:10 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7789a4c01easo12197185a.0
        for <linux-block@vger.kernel.org>; Wed, 25 Oct 2023 12:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698263709; x=1698868509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ekPau7DZNUdzR+f7zD17FyTym1sI9YNJQ3q9QYnQIM=;
        b=EH2JwL1nwR7QHwxods8Q9bQVjpqy/aZ84/rf1tnZOjUts/5Ssc55q065+yr/j7/Xm5
         lT41uy8LWbVmLnyjoZz5Ik/8PzKZwskvV61nOafuL66pRwQVh+gX3d1UkJBJY01+f6Xa
         pFuUDUzMd2EAcK0r44wf3nGoko5qkWZfRhyL2BEq3qfnObABvol6IIn8O6mdFBBqEPGL
         GeGr8FvQLfR6ziuawY1UfAbL80RntC6xSPQzcSGSqXeNoAvPzR9RDLXW2KoGEPNSuqK5
         BBgogjr6Ug4o5+wPf6CdXh+DseFLTb4X01l54QpvZMK2/2k2TJr+vdGBhg+HSW+Bjzy3
         xalg==
X-Gm-Message-State: AOJu0YyQs1IyQfVt2EQYcZeCgd5LPmvINYsmfKrXOnOAdXcVydwt+gUA
        kfCN7EF53buXLgggw0sIvZvm
X-Google-Smtp-Source: AGHT+IEkASxtyJZ8inRHyoVuE+e18cb050FhVzmJbHpRVoEA6mwD77zUMN5FoX/TnBj6qvuOHfqZbw==
X-Received: by 2002:a05:620a:2910:b0:779:9b67:811 with SMTP id m16-20020a05620a291000b007799b670811mr13729243qkp.52.1698263709581;
        Wed, 25 Oct 2023 12:55:09 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id s23-20020a05620a16b700b0077891d2d12dsm4445370qkj.43.2023.10.25.12.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 12:55:09 -0700 (PDT)
Date:   Wed, 25 Oct 2023 15:55:07 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2] dm: respect REQ_NOWAIT flag in bios issued to DM
Message-ID: <ZTlym/9lyUZmApSY@redhat.com>
References: <15ca26cc-174a-d4e8-9780-d09f8e5a6ea5@redhat.com>
 <ZTgFtseG3m3WPWn/@redhat.com>
 <e796de8-bac1-8f7a-c6eb-74d39aad8a2b@redhat.com>
 <ZTgb3lkNmEUIYpsl@redhat.com>
 <ZTlt0HPbVZf0gYcI@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTlt0HPbVZf0gYcI@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 25 2023 at  3:34P -0400,
Mike Snitzer <snitzer@kernel.org> wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> Update DM core's IO submission to allocate required memory using
> GFP_NOWAIT if REQ_NOWAIT is set.  Lone exception is in the error path
> where DM's requeue support needs to allocate a clone bio in
> dm_io_rewind() to allow the IO to be resubmitted: GFP_NOWAIT is used
> first but if it fails GFP_NOIO is used as a last resort.
> 
> Tested with simple test provided in commit a9ce385344f916 ("dm: don't
> attempt to queue IO under RCU protection") that was enhanced to check
> error codes.  Also tested using fio's pvsync2 with nowait=1.
> 
> But testing with induced GFP_NOWAIT allocation failures wasn't
> performed.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  drivers/md/dm-io-rewind.c | 13 ++++++--
>  drivers/md/dm.c           | 66 ++++++++++++++++++++++++++++++++-------
>  2 files changed, 65 insertions(+), 14 deletions(-)

Backfilling some comments on this v2:

1) I'm not completely clear if REQ_NOWAIT not ever sleeping (waiting
   on IO) is a hint vs a hard requirement
   -- so the dm_io_rewind() change to try GFP_NOWAIT and failback to
      GFP_NOIO might be bogus...

2) What is a good way to reliably simulate low memory allocations such
   that mempool backed GFP_NOWAIT allocations fail?

Thanks for any review/feedback.

Mike

> 
> diff --git a/drivers/md/dm-io-rewind.c b/drivers/md/dm-io-rewind.c
> index 6155b0117c9d..bde5a53e2d88 100644
> --- a/drivers/md/dm-io-rewind.c
> +++ b/drivers/md/dm-io-rewind.c
> @@ -143,8 +143,17 @@ static void dm_bio_rewind(struct bio *bio, unsigned int bytes)
>  void dm_io_rewind(struct dm_io *io, struct bio_set *bs)
>  {
>  	struct bio *orig = io->orig_bio;
> -	struct bio *new_orig = bio_alloc_clone(orig->bi_bdev, orig,
> -					       GFP_NOIO, bs);
> +	struct bio *new_orig;
> +
> +	new_orig = bio_alloc_clone(orig->bi_bdev, orig, GFP_NOWAIT, bs);
> +	if (unlikely(!new_orig)) {
> +		/*
> +		 * Returning early and failing rewind isn't an option, even
> +		 * if orig has REQ_NOWAIT set, so retry alloc with GFP_NOIO.
> +		 */
> +		new_orig = bio_alloc_clone(orig->bi_bdev, orig, GFP_NOIO, bs);
> +	}
> +
>  	/*
>  	 * dm_bio_rewind can restore to previous position since the
>  	 * end sector is fixed for original bio, but we still need
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 1113a8da3c47..b0e1425af475 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -87,6 +87,8 @@ struct clone_info {
>  	unsigned int sector_count;
>  	bool is_abnormal_io:1;
>  	bool submit_as_polled:1;
> +	bool is_nowait:1;
> +	bool nowait_failed:1;
>  };
>  
>  static inline struct dm_target_io *clone_to_tio(struct bio *clone)
> @@ -576,7 +578,13 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
>  	struct dm_target_io *tio;
>  	struct bio *clone;
>  
> -	clone = bio_alloc_clone(NULL, bio, GFP_NOIO, &md->mempools->io_bs);
> +	if (unlikely(bio->bi_opf & REQ_NOWAIT)) {
> +		clone = bio_alloc_clone(NULL, bio, GFP_NOWAIT, &md->mempools->io_bs);
> +		if (!clone)
> +			return NULL;
> +	} else {
> +		clone = bio_alloc_clone(NULL, bio, GFP_NOIO, &md->mempools->io_bs);
> +	}
>  	tio = clone_to_tio(clone);
>  	tio->flags = 0;
>  	dm_tio_set_flag(tio, DM_TIO_INSIDE_DM_IO);
> @@ -1500,9 +1508,17 @@ static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
>  			mutex_unlock(&ci->io->md->table_devices_lock);
>  		if (bio_nr == num_bios)
>  			return;
> -
> +		/*
> +		 * Failed to allocate all bios, all or nothing, so rewind partial
> +		 * allocations and short-circuit retry with GFP_NOIO if 'is_nowait'
> +		 */
>  		while ((bio = bio_list_pop(blist)))
>  			free_tio(bio);
> +
> +		if (ci->is_nowait) {
> +			ci->nowait_failed = true;
> +			return;
> +		}
>  	}
>  }
>  
> @@ -1519,7 +1535,15 @@ static unsigned int __send_duplicate_bios(struct clone_info *ci, struct dm_targe
>  	case 1:
>  		if (len)
>  			setup_split_accounting(ci, *len);
> -		clone = alloc_tio(ci, ti, 0, len, GFP_NOIO);
> +		if (unlikely(ci->is_nowait)) {
> +			clone = alloc_tio(ci, ti, 0, len, GFP_NOWAIT);
> +			if (!clone) {
> +				ci->nowait_failed = true;
> +				return 0;
> +			}
> +		} else {
> +			clone = alloc_tio(ci, ti, 0, len, GFP_NOIO);
> +		}
>  		__map_bio(clone);
>  		ret = 1;
>  		break;
> @@ -1539,7 +1563,7 @@ static unsigned int __send_duplicate_bios(struct clone_info *ci, struct dm_targe
>  	return ret;
>  }
>  
> -static void __send_empty_flush(struct clone_info *ci)
> +static blk_status_t __send_empty_flush(struct clone_info *ci)
>  {
>  	struct dm_table *t = ci->map;
>  	struct bio flush_bio;
> @@ -1572,6 +1596,8 @@ static void __send_empty_flush(struct clone_info *ci)
>  	atomic_sub(1, &ci->io->io_count);
>  
>  	bio_uninit(ci->bio);
> +
> +	return likely(!ci->nowait_failed) ? BLK_STS_OK : BLK_STS_AGAIN;
>  }
>  
>  static void __send_changing_extent_only(struct clone_info *ci, struct dm_target *ti,
> @@ -1656,7 +1682,7 @@ static blk_status_t __process_abnormal_io(struct clone_info *ci,
>  
>  	__send_changing_extent_only(ci, ti, num_bios,
>  				    max_granularity, max_sectors);
> -	return BLK_STS_OK;
> +	return likely(!ci->nowait_failed) ? BLK_STS_OK : BLK_STS_AGAIN;
>  }
>  
>  /*
> @@ -1714,7 +1740,7 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
>  	if (unlikely(!ti))
>  		return BLK_STS_IOERR;
>  
> -	if (unlikely((ci->bio->bi_opf & REQ_NOWAIT) != 0) &&
> +	if (unlikely(ci->is_nowait) &&
>  	    unlikely(!dm_target_supports_nowait(ti->type)))
>  		return BLK_STS_NOTSUPP;
>  
> @@ -1729,7 +1755,15 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
>  
>  	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
>  	setup_split_accounting(ci, len);
> -	clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
> +	if (unlikely(ci->is_nowait)) {
> +		clone = alloc_tio(ci, ti, 0, &len, GFP_NOWAIT);
> +		if (unlikely(!clone)) {
> +			ci->nowait_failed = true; /* unchecked, set for consistency */
> +			return BLK_STS_AGAIN;
> +		}
> +	} else {
> +		clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
> +	}
>  	__map_bio(clone);
>  
>  	ci->sector += len;
> @@ -1738,11 +1772,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
>  	return BLK_STS_OK;
>  }
>  
> -static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
> +static void init_clone_info(struct clone_info *ci, struct dm_io *io,
>  			    struct dm_table *map, struct bio *bio, bool is_abnormal)
>  {
> +	ci->is_nowait = !!(bio->bi_opf & REQ_NOWAIT);
> +	ci->nowait_failed = false;
>  	ci->map = map;
> -	ci->io = alloc_io(md, bio);
> +	ci->io = io;
>  	ci->bio = bio;
>  	ci->is_abnormal_io = is_abnormal;
>  	ci->submit_as_polled = false;
> @@ -1777,11 +1813,17 @@ static void dm_split_and_process_bio(struct mapped_device *md,
>  			return;
>  	}
>  
> -	init_clone_info(&ci, md, map, bio, is_abnormal);
> -	io = ci.io;
> +	io = alloc_io(md, bio);
> +	if (!io) {
> +		/* Unable to do anything without dm_io. */
> +		bio_wouldblock_error(bio);
> +		return;
> +	}
> +
> +	init_clone_info(&ci, io, map, bio, is_abnormal);
>  
>  	if (bio->bi_opf & REQ_PREFLUSH) {
> -		__send_empty_flush(&ci);
> +		error = __send_empty_flush(&ci);
>  		/* dm_io_complete submits any data associated with flush */
>  		goto out;
>  	}
> -- 
> 2.40.0
> 
