Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E534C7D5A05
	for <lists+linux-block@lfdr.de>; Tue, 24 Oct 2023 19:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjJXR7F (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Oct 2023 13:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjJXR7F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Oct 2023 13:59:05 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F0310CF
        for <linux-block@vger.kernel.org>; Tue, 24 Oct 2023 10:58:17 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-777754138bdso311798585a.1
        for <linux-block@vger.kernel.org>; Tue, 24 Oct 2023 10:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698170296; x=1698775096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEf1gFY5aytx0xmstNtZsbKn4KNYEI+ZYRsJn96q1hc=;
        b=Mg7ozsrS8dHxZQDUBR88Yiog6AtYA9pQfVptxYdJQCUb1oLDVTgRnFHgVjrUcH1e/k
         XM0Y8t84D+AozXdcYvk4fld5Wpr/3TVdQt+wDQxm2tf3cwf4NV7p+o08Y4i3CJ2mnSFG
         NjSO9E40iJXsuGExhLatG2qiwoPk1gg219rg1TPGz6mFGdRDmPQWeZDobeI6/dR6Qv99
         oSi9c+5hDWtcq4JDzhGAmz7stzeZepuAZCx327c2ZXA6ME7aH96eY5TFj6NAVxhi8A23
         rBkNvzlD/+Fyw3VDAKbcbXq+eSuU1kIcGszwg4pWEINhEDWCzWlkAo7GM6uiNEFxOPwH
         evxQ==
X-Gm-Message-State: AOJu0YwZ6ILpuHhJtKi52dBgD4ISvCjmiX+5aGsdTY0BppWKw4aPzlKp
        yvQpcqFgN1hARkkSVJoIkOrlsAM5lkzEnXXxtQ==
X-Google-Smtp-Source: AGHT+IFHC3NUWgx8NpRoKuJzI/1v309PZuCivL2zFuvUPQombRsxn6IC6PkhWIEQOdClWfKgd4hQvw==
X-Received: by 2002:a05:620a:4484:b0:779:da55:b327 with SMTP id x4-20020a05620a448400b00779da55b327mr7788676qkp.11.1698170296302;
        Tue, 24 Oct 2023 10:58:16 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id bi12-20020a05620a318c00b00772662b7804sm3591614qkb.100.2023.10.24.10.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 10:58:15 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:58:14 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: dm: Respect REQ_NOWAIT bios
Message-ID: <ZTgFtseG3m3WPWn/@redhat.com>
References: <15ca26cc-174a-d4e8-9780-d09f8e5a6ea5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15ca26cc-174a-d4e8-9780-d09f8e5a6ea5@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the benefit of others, since this patch was posted to the old
dm-devel list, here is the original patch proposal:
https://patchwork.kernel.org/project/dm-devel/patch/15ca26cc-174a-d4e8-9780-d09f8e5a6ea5@redhat.com/

On Tue, Oct 03 2023 at 11:30P -0400,
Mikulas Patocka <mpatocka@redhat.com> wrote:

> Hi
> 
> Here I'm sending that patch for REQ_NOWAIT for review.
> 
> It is not tested, except for some trivial tests that involve logical 
> volume activation.

At a minimum we need to test with the simple test code Jens provided
in commit a9ce385344f9 ("dm: don't attempt to queue IO under RCU protection")

> I found out that it seems easier to propagate the error using bits in 
> clone_info rather than changing return codes for each affected function.

Yes, the various DM core code that allocates multiple bios, etc
certianly benefits from not having to worry about tracking
fine-grained return codes.  So I've kept the flag in clone_info.

> 
> Mikulas
> 
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Please don't add Signed-off-by to anything you don't want to see going
upstream (yet), especially something you haven't tested.

Even going so far as adding 'Not-Signed-off-by' is appropriate.

More comments inline below, and then at the end I'm attaching an
incremental patch that should get us closer to something that works
(but I haven't tested yet either).  I've also messaged Ming Lei to
check with him on the FIXME I added before the call to dm_io_rewind()
-- hopefully Ming will reply to this email.

> ---
>  drivers/md/dm.c |   51 +++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 45 insertions(+), 6 deletions(-)
> 
> Index: linux-2.6/drivers/md/dm.c
> ===================================================================
> --- linux-2.6.orig/drivers/md/dm.c
> +++ linux-2.6/drivers/md/dm.c
> @@ -87,6 +87,8 @@ struct clone_info {
>  	unsigned int sector_count;
>  	bool is_abnormal_io:1;
>  	bool submit_as_polled:1;
> +	bool is_nowait:1;
> +	bool nowait_failed:1;
>  };
>  
>  static inline struct dm_target_io *clone_to_tio(struct bio *clone)
> @@ -570,13 +572,21 @@ static void dm_end_io_acct(struct dm_io
>  	dm_io_acct(io, true);
>  }
>  
> -static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
> +static struct dm_io *alloc_io(struct clone_info *ci, struct mapped_device *md, struct bio *bio)
>  {
>  	struct dm_io *io;
>  	struct dm_target_io *tio;
>  	struct bio *clone;
>  
> -	clone = bio_alloc_clone(NULL, bio, GFP_NOIO, &md->mempools->io_bs);
> +	if (unlikely(ci->is_nowait)) {
> +		clone = bio_alloc_clone(NULL, bio, GFP_NOWAIT, &md->mempools->io_bs);
> +		if (!clone) {
> +			ci->nowait_failed = true;
> +			return NULL;
> +		}
> +	} else {
> +		clone = bio_alloc_clone(NULL, bio, GFP_NOIO, &md->mempools->io_bs);
> +	}
>  	tio = clone_to_tio(clone);
>  	tio->flags = 0;
>  	dm_tio_set_flag(tio, DM_TIO_INSIDE_DM_IO);

The above is bogus because if the clone cannot be allocated then the
returned NULL dm_io struct will cause NULL pointer dereference during
error handling at the end of dm_split_and_process_bio() -- my patch
attached below addresses this.

> @@ -1503,6 +1513,11 @@ static void alloc_multiple_bios(struct b
>  
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
> @@ -1519,7 +1534,15 @@ static unsigned int __send_duplicate_bio
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
> @@ -1656,7 +1679,7 @@ static blk_status_t __process_abnormal_i
>  
>  	__send_changing_extent_only(ci, ti, num_bios,
>  				    max_granularity, max_sectors);
> -	return BLK_STS_OK;
> +	return likely(!ci->nowait_failed) ? BLK_STS_OK : BLK_STS_AGAIN;
>  }
>  
>  /*
> @@ -1729,7 +1752,15 @@ static blk_status_t __split_and_process_
>  
>  	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
>  	setup_split_accounting(ci, len);
> -	clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
> +	if (unlikely(ci->is_nowait)) {
> +		clone = alloc_tio(ci, ti, 0, &len, GFP_NOWAIT);
> +		if (unlikely(!clone)) {
> +			ci->nowait_failed = true;
> +			return BLK_STS_AGAIN;
> +		}
> +	} else {
> +		clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
> +	}
>  	__map_bio(clone);
>  
>  	ci->sector += len;
> @@ -1741,8 +1772,10 @@ static blk_status_t __split_and_process_
>  static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
>  			    struct dm_table *map, struct bio *bio, bool is_abnormal)
>  {
> +	ci->is_nowait = !!(bio->bi_opf & REQ_NOWAIT);
> +	ci->nowait_failed = false;
>  	ci->map = map;
> -	ci->io = alloc_io(md, bio);
> +	ci->io = alloc_io(ci, md, bio);
>  	ci->bio = bio;
>  	ci->is_abnormal_io = is_abnormal;
>  	ci->submit_as_polled = false;
> @@ -1778,10 +1811,16 @@ static void dm_split_and_process_bio(str
>  	}
>  
>  	init_clone_info(&ci, md, map, bio, is_abnormal);
> +	if (unlikely(ci.nowait_failed)) {
> +		error = BLK_STS_AGAIN;
> +		goto out;
> +	}
>  	io = ci.io;
>  
>  	if (bio->bi_opf & REQ_PREFLUSH) {
>  		__send_empty_flush(&ci);
> +		if (unlikely(ci.nowait_failed))
> +			error = BLK_STS_AGAIN;
>  		/* dm_io_complete submits any data associated with flush */
>  		goto out;
>  	}
> 

Below you'll see I insulated dm_split_and_process_bio() from ever
checking ci.nowait_failed -- prefer methods like __send_empty_flush
that are called from dm_split_and_process_bio() return blk_status_t
(like __process_abnormal_io and __split_and_process_bio do).

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index d6fbbaa7600b..2a9ff269c28b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -572,18 +572,16 @@ static void dm_end_io_acct(struct dm_io *io)
 	dm_io_acct(io, true);
 }
 
-static struct dm_io *alloc_io(struct clone_info *ci, struct mapped_device *md, struct bio *bio)
+static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 {
 	struct dm_io *io;
 	struct dm_target_io *tio;
 	struct bio *clone;
 
-	if (unlikely(ci->is_nowait)) {
+	if (unlikely(bio->bi_opf & REQ_NOWAIT)) {
 		clone = bio_alloc_clone(NULL, bio, GFP_NOWAIT, &md->mempools->io_bs);
-		if (!clone) {
-			ci->nowait_failed = true;
-			return NULL;
-		}
+		if (!clone)
+			return PTR_ERR(-EAGAIN);
 	} else {
 		clone = bio_alloc_clone(NULL, bio, GFP_NOIO, &md->mempools->io_bs);
 	}
@@ -1001,6 +999,8 @@ static void dm_wq_requeue_work(struct work_struct *work)
 	while (io) {
 		struct dm_io *next = io->next;
 
+		// FIXME: if io->orig_bio has REQ_NOWAIT set should GFP_NOWAIT be used?
+		// requeue performed from completion path so REQ_NOWAIT can be safely dropped?
 		dm_io_rewind(io, &md->disk->bio_split);
 
 		io->next = NULL;
@@ -1565,7 +1565,7 @@ static unsigned int __send_duplicate_bios(struct clone_info *ci, struct dm_targe
 	return ret;
 }
 
-static void __send_empty_flush(struct clone_info *ci)
+static blk_status_t __send_empty_flush(struct clone_info *ci)
 {
 	struct dm_table *t = ci->map;
 	struct bio flush_bio;
@@ -1598,6 +1598,8 @@ static void __send_empty_flush(struct clone_info *ci)
 	atomic_sub(1, &ci->io->io_count);
 
 	bio_uninit(ci->bio);
+
+	return likely(!ci->nowait_failed) ? BLK_STS_OK : BLK_STS_AGAIN;
 }
 
 static void __send_changing_extent_only(struct clone_info *ci, struct dm_target *ti,
@@ -1758,7 +1760,7 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
 	if (unlikely(ci->is_nowait)) {
 		clone = alloc_tio(ci, ti, 0, &len, GFP_NOWAIT);
 		if (unlikely(!clone)) {
-			ci->nowait_failed = true;
+			ci->nowait_failed = true; /* unchecked, set for consistency */
 			return BLK_STS_AGAIN;
 		}
 	} else {
@@ -1772,13 +1774,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
 	return BLK_STS_OK;
 }
 
-static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
+static void init_clone_info(struct clone_info *ci, struct dm_io *io,
 			    struct dm_table *map, struct bio *bio, bool is_abnormal)
 {
 	ci->is_nowait = !!(bio->bi_opf & REQ_NOWAIT);
 	ci->nowait_failed = false;
 	ci->map = map;
-	ci->io = alloc_io(ci, md, bio);
+	ci->io = io;
 	ci->bio = bio;
 	ci->is_abnormal_io = is_abnormal;
 	ci->submit_as_polled = false;
@@ -1813,17 +1815,17 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 			return;
 	}
 
-	init_clone_info(&ci, md, map, bio, is_abnormal);
-	if (unlikely(ci.nowait_failed)) {
-		error = BLK_STS_AGAIN;
-		goto out;
+	io = alloc_io(md, bio);
+	if (unlikely(IS_ERR(io) && ERR_PTR(io) == -EAGAIN)) {
+		/* Unable to do anything without dm_io. */
+		bio_wouldblock_error(bio);
+		return;
 	}
-	io = ci.io;
+
+	init_clone_info(&ci, io, map, bio, is_abnormal);
 
 	if (bio->bi_opf & REQ_PREFLUSH) {
-		__send_empty_flush(&ci);
-		if (unlikely(ci.nowait_failed))
-			error = BLK_STS_AGAIN;
+		error = __send_empty_flush(&ci);
 		/* dm_io_complete submits any data associated with flush */
 		goto out;
 	}
