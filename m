Return-Path: <linux-block+bounces-973-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9687A80DCAA
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 22:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C81B216F2
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 21:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3217054BE2;
	Mon, 11 Dec 2023 21:12:49 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C7FBE
	for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 13:12:46 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-67ad277a06bso32166316d6.1
        for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 13:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702329165; x=1702933965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2FHjW16YFOZ98zKJ6t95OyWB+xQ0Ae6fs2r8OG+Q9U=;
        b=QkOPRSB3UOn1ep+BnX+YgYTj0aEGxAHfoihBX2EY2AA2FNQwICp7exe2gALrjkDoGH
         IhOe13kvhAj6RXFmGsWffo/3dn+OEcPPOIGJm/Zmoi4tCtnns3NaXDNzjM7vnC3okXs2
         GWClmFAbMJEOzSKX4AP0Xc4Enz4qrpClSOMQvbSVgY8NpG/gWKKDXvtSFdQQQc5xI+CH
         /lg30hSQuOlOLHBFA5Q09uzJHyIO5+E1Z5zjVH4KWtlWOwTnt1GwWrXTSU3EP0W4HXMX
         /G5m+SBN98PSGGUEBR8F5DN0ht81LsXDySttaMaBfYZvQtnuAZBWjlTHE7vomgsV3qES
         H+UA==
X-Gm-Message-State: AOJu0YyaCnp8AqPjx1EH2Wdttm0L4Bd3tOtwHmdueMIx/TR0n4b3DiBk
	X2prMIoGMeSqsMWYFXYl3QIc
X-Google-Smtp-Source: AGHT+IFQYUfCwkf5CHJtat4VEH6Mao0v/I/DCRJ7nP89ZfELyH4njHovv1IR2E2cZQRTvHoj0K6qXw==
X-Received: by 2002:ad4:58b0:0:b0:67a:a721:cb0d with SMTP id ea16-20020ad458b0000000b0067aa721cb0dmr6331049qvb.110.1702329165524;
        Mon, 11 Dec 2023 13:12:45 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id pz8-20020ad45508000000b0067ad69c7276sm3603083qvb.75.2023.12.11.13.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:12:44 -0800 (PST)
Date: Mon, 11 Dec 2023 16:12:43 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>, Jan Kara <jack@suse.cz>
Cc: agk@redhat.com, mpatocka@redhat.com, axboe@kernel.dk,
	ebiggers@kernel.org, zhiguo.niu@unisoc.com, ke.wang@unisoc.com,
	yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v3 1/5] block: Optimize bio io priority setting
Message-ID: <ZXd7S9V8SQ3HSEbJ@redhat.com>
References: <df68c38e-3e38-eaf1-5c32-66e43d68cae3@ewheeler.net>
 <20231211090000.9578-1-hongyu.jin.cn@gmail.com>
 <20231211090000.9578-2-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211090000.9578-2-hongyu.jin.cn@gmail.com>

On Mon, Dec 11 2023 at  3:59P -0500,
Hongyu Jin <hongyu.jin.cn@gmail.com> wrote:

> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> Current call bio_set_ioprio() for each cloned bio and splited bio,
> and the io priority can't be passed to module that implement
> struct gendisk::fops::submit_bio, such as device-mapper.
> 
> Move bio_set_ioprio() into submit_bio(), only call bio_set_ioprio()
> once set the priority of origin bio, cloned and splited bio
> auto inherit the priority of origin bio in clone process.
> 
> Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
> Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
> Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>

This patch's subject needs fixing (this is a fix, not an optimization)
and the header needs fixing (various issues that make it hard to
read).

This should also be tagged with:
Fixes: a78418e6a04c9 ("block: Always initialize bio IO priority on submit")

(commit 82b74cac28493 was commit immediately prior that placed the
direct call incorrectly)

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

> ---
>  block/blk-core.c | 10 ++++++++++
>  block/blk-mq.c   | 11 -----------
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fdf25b8d6e78..68158c327aea 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -49,6 +49,7 @@
>  #include "blk-pm.h"
>  #include "blk-cgroup.h"
>  #include "blk-throttle.h"
> +#include "blk-ioprio.h"
>  
>  struct dentry *blk_debugfs_root;
>  
> @@ -809,6 +810,14 @@ void submit_bio_noacct(struct bio *bio)
>  }
>  EXPORT_SYMBOL(submit_bio_noacct);
>  
> +static void bio_set_ioprio(struct bio *bio)
> +{
> +	/* Nobody set ioprio so far? Initialize it based on task's nice value */
> +	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
> +		bio->bi_ioprio = get_current_ioprio();
> +	blkcg_set_ioprio(bio);
> +}
> +
>  /**
>   * submit_bio - submit a bio to the block device layer for I/O
>   * @bio: The &struct bio which describes the I/O
> @@ -831,6 +840,7 @@ void submit_bio(struct bio *bio)
>  		count_vm_events(PGPGOUT, bio_sectors(bio));
>  	}
>  
> +	bio_set_ioprio(bio);
>  	submit_bio_noacct(bio);
>  }
>  EXPORT_SYMBOL(submit_bio);
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e2d11183f62e..a6e2609df9c9 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -40,7 +40,6 @@
>  #include "blk-stat.h"
>  #include "blk-mq-sched.h"
>  #include "blk-rq-qos.h"
> -#include "blk-ioprio.h"
>  
>  static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
>  static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
> @@ -2922,14 +2921,6 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
>  	return rq;
>  }
>  
> -static void bio_set_ioprio(struct bio *bio)
> -{
> -	/* Nobody set ioprio so far? Initialize it based on task's nice value */
> -	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
> -		bio->bi_ioprio = get_current_ioprio();
> -	blkcg_set_ioprio(bio);
> -}
> -
>  /**
>   * blk_mq_submit_bio - Create and send a request to block device.
>   * @bio: Bio pointer.
> @@ -2963,8 +2954,6 @@ void blk_mq_submit_bio(struct bio *bio)
>  	if (!bio_integrity_prep(bio))
>  		return;
>  
> -	bio_set_ioprio(bio);
> -
>  	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
>  	if (!rq) {
>  		if (!bio)
> -- 
> 2.34.1
> 
> 

