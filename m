Return-Path: <linux-block+bounces-6336-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483908A86B1
	for <lists+linux-block@lfdr.de>; Wed, 17 Apr 2024 16:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D6C285D45
	for <lists+linux-block@lfdr.de>; Wed, 17 Apr 2024 14:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D1E1411E8;
	Wed, 17 Apr 2024 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lkxRgT4c"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C3414290C;
	Wed, 17 Apr 2024 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365457; cv=none; b=XBOVWGkcq1RkflY4RAJzafolio1/o9Vszatwb3Esss/nilp/75W6qKeL2iwZXOOoQPiz2f1yHQVzOT+UQQVZLO7qo2vgcQorzNaNinz49heZEw64XuyZuOym9GtURthp63UmQK3AnJf7gzE9J6qUTE96V95W6ecMZQDc/NY+A4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365457; c=relaxed/simple;
	bh=KXyYkQguWhYNZJ8K2JdqO4nXcxU/vy0kD22Tcik71DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjoLvUPOLZMnra1YwVte3SgQFHD6lNMIlrwayWGkHeoV8Ysp6SBeS7DAn3CW4awhwpUj99PC0TyEUljyI+7uzhwXbTyOFeXov9CRAU5h2fB4KP/Rqak1Qwy78oyh3i3ZWrIj5onOpEARD6G5BQYOI82tcEEsGlpq7lbU7FO4AoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lkxRgT4c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9szQsyAow1UDlIBLINoaPCqHbjIeUQuqhnIQmSRpz7U=; b=lkxRgT4c8zqJVjT2K8LtF4hNF8
	wSGVpFUfoPWN5EzgvbBKxUp4am4UiAM+e93ytHsXNApOPZAdlnI9Sgink2+IsSPBlSxvs8TGA/dnR
	vJOsSMBPQQaMiVvj0/8pUYnWx4DX3kQQ8/ypbbECqWfof9QFfXHmazimmrzP71Ow8kxyv1CJkyQh7
	k6V83SuUULeavYY+AF/y1AxLmzLFFgfawk9E9hh3qXPu48UYuZruGXov3B3/c544JI6W88RV0LRMU
	fCROVak1JR7rT8kjB+kvCNl/ienrDKw6FKB9Ft8c9Efcyyv2Ne94bx/9ow6T4zdgKCCoQ0IbKmS/v
	lZiDp7Bg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6cg-0000000GRJS-2pw6;
	Wed, 17 Apr 2024 14:50:54 +0000
Date: Wed, 17 Apr 2024 07:50:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Mike Snitzer <msnitzer@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
	Guangwu Zhang <guazhang@redhat.com>, dm-devel@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dm-io: don't warn if flush takes too long time
Message-ID: <Zh_hzvgnY-VbkdO5@infradead.org>
References: <754d1973-31cb-d3ca-1f6f-2d35b96364db@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <754d1973-31cb-d3ca-1f6f-2d35b96364db@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> --- linux-2.6.orig/include/linux/completion.h	2024-04-15 15:54:22.000000000 +0200
> +++ linux-2.6/include/linux/completion.h	2024-04-15 15:57:14.000000000 +0200
> @@ -10,6 +10,7 @@
>   */
>  
>  #include <linux/swait.h>
> +#include <linux/sched/sysctl.h>

If you're touching completion.h you need to CC lkml and the people
who wrote/maintain it even if we don't have a proper maintainer.

I don't think adding yet another include into it is a good idea.

As is this whole hack here.  Pleas just add the proper TASK_STATE for
task that can legitimately sleep for very long times  instead of
extending this hack again and again, just like I told Kent when he messed with the timeout.

>  
>  /*
>   * struct completion - structure used to maintain state for a "completion"
> @@ -119,4 +120,20 @@ extern void complete(struct completion *
>  extern void complete_on_current_cpu(struct completion *x);
>  extern void complete_all(struct completion *);
>  
> +/**
> + * wait_for_completion_long_io - this is like wait_for_completion_io,
> + * but it doesn't warn if the wait takes too long.
> + */
> +static inline void wait_for_completion_long_io(struct completion *done)
> +{
> +	/* Prevent hang_check timer from firing at us during very long I/O */
> +	unsigned long timeout = sysctl_hung_task_timeout_secs * HZ / 2;
> +
> +	if (timeout)
> +		while (!wait_for_completion_io_timeout(done, timeout))
> +			;
> +	else
> +		wait_for_completion_io(done);
> +}
> +
>  #endif
> Index: linux-2.6/block/bio.c
> ===================================================================
> --- linux-2.6.orig/block/bio.c	2024-03-30 20:07:03.000000000 +0100
> +++ linux-2.6/block/bio.c	2024-04-15 15:55:13.000000000 +0200
> @@ -1378,7 +1378,7 @@ int submit_bio_wait(struct bio *bio)
>  	bio->bi_end_io = submit_bio_wait_endio;
>  	bio->bi_opf |= REQ_SYNC;
>  	submit_bio(bio);
> -	blk_wait_io(&done);
> +	wait_for_completion_long_io(&done);
>  
>  	return blk_status_to_errno(bio->bi_status);
>  }
> Index: linux-2.6/block/blk-mq.c
> ===================================================================
> --- linux-2.6.orig/block/blk-mq.c	2024-03-30 20:07:03.000000000 +0100
> +++ linux-2.6/block/blk-mq.c	2024-04-15 15:55:05.000000000 +0200
> @@ -1407,7 +1407,7 @@ blk_status_t blk_execute_rq(struct reque
>  	if (blk_rq_is_poll(rq))
>  		blk_rq_poll_completion(rq, &wait.done);
>  	else
> -		blk_wait_io(&wait.done);
> +		wait_for_completion_long_io(&wait.done);
>  
>  	return wait.ret;
>  }
> 
> 
---end quoted text---

