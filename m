Return-Path: <linux-block+bounces-5908-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C121B89B297
	for <lists+linux-block@lfdr.de>; Sun,  7 Apr 2024 16:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FBA8B21216
	for <lists+linux-block@lfdr.de>; Sun,  7 Apr 2024 14:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECABB39AF2;
	Sun,  7 Apr 2024 14:57:07 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65BF39AC7
	for <linux-block@vger.kernel.org>; Sun,  7 Apr 2024 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712501827; cv=none; b=A0RXgTzMrEa/gJxEAAd7QvG6euFJ1OOhZPcQJjf4NmK2UQSxn+u/6+Xsj/tJe2NfmeR0mnrWCSn/nlTlGmJZGnaiMg9w0VcB1n11iKSO881H1ve74MK+xXyKb0GVntN6nD5W3fX73mT0V0U8sqFrpmDrE6uGTtDVGUuzXpbFqQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712501827; c=relaxed/simple;
	bh=e4fwXOUyYq6mV6uhvLjPhbnGjuszMvN9URKWpUlfXvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7mYl8glPV9MOwkI8oEQknA3WiC/Ycua8AdtkKMIu4JMxodc4fDvKHkfzfL+jZezvB030VeH7yuw9ep42Vq+MgsdeOsk3VzVwOJKxW+x95f9F1CDFlFu8mYDh4MQzY/0+pXoyX162WwfeYSF0nxIOjP1UFAx9TaUZ49JUFBUVgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-789f1b59a28so239720585a.3
        for <linux-block@vger.kernel.org>; Sun, 07 Apr 2024 07:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712501825; x=1713106625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9UKQt8oRXG6Dh8pSrRfOqttC99MPstJOYP5P6LSjTI=;
        b=U6iBjtqChPjV9eqBHf5yiuIcwY9g6GTChvUwmF/KeNRWod3OV6alq6dzVbO+5vKtzc
         Ku2b40nPORSg9/+WildDIh3jdHLNBVEGGmPgdLY9dKGdLExyFYs2qd7jUDu8ptW2KwMI
         YmBzCxm023HctVnIqwzx9dkBMANSetWELFSCodag21c22TP4P6qKskua+tPBJrTalJVr
         G+wlb5juIXFtZfngi2kryZXu8lymIbX253rhf8HBfnooOtxvOMqvzGWQhw0rlPyU4m7i
         Zi84+t+utIE7emTyO6uT2c8W42C5JtKrKTqMLXiNk5b/TCSbkOdsnLZa1FS1tn3MVzTA
         VbQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkFaL3hkCsp5v5Naf/M5g/91bydehfhSXeCFh1zXB6sxJVg4KEFyuYjzvvQPxen6HoprcL2UoOy6/CI9bpGjKWO0gnnP+WKFjaNgI=
X-Gm-Message-State: AOJu0YzhbGk/6UaYkI0fG4Ch5vneNwUyAU/CuRfLbnyj/gJ8tVTaltpk
	5f/Hje3fkTWle/0Pl1abFmJT0I9+dowUVrp5AatgQWYU7V3HT4V3/U6JATKHtQ==
X-Google-Smtp-Source: AGHT+IFOCt5ITUSZM9yD/CST7Tn+uc5Nrf1bq7XmB0Gqa35jK1G/uyfDDNQaypFMkPS1UTQNfQ/K9w==
X-Received: by 2002:ae9:e412:0:b0:78a:22bd:d980 with SMTP id q18-20020ae9e412000000b0078a22bdd980mr7153654qkc.64.1712501824869;
        Sun, 07 Apr 2024 07:57:04 -0700 (PDT)
Received: from localhost ([64.44.118.111])
        by smtp.gmail.com with ESMTPSA id bq12-20020a05620a468c00b0078d64195031sm328312qkb.31.2024.04.07.07.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 07:57:04 -0700 (PDT)
Date: Sun, 7 Apr 2024 10:57:02 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	janpieter.sollie@edpnet.be, Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev, Song Liu <song@kernel.org>,
	linux-raid@vger.kernel.org
Subject: Re: block: allow device to have both virt_boundary_mask and max
 segment size
Message-ID: <ZhK0PvAtXfIfHG4t@redhat.com>
References: <20240407131931.4055231-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407131931.4055231-1-ming.lei@redhat.com>

On Sun, Apr 07 2024 at  9:19P -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> When one stacking device is over one device with virt_boundary_mask and
> another one with max segment size, the stacking device have both limits
> set. This way is allowed before d690cb8ae14b ("block: add an API to
> atomically update queue limits").
> 
> Relax the limit so that we won't break such kind of stacking setting.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218687
> Reported-by: janpieter.sollie@edpnet.be
> Fixes: d690cb8ae14b ("block: add an API to atomically update queue limits")
> Link: https://lore.kernel.org/linux-block/ZfGl8HzUpiOxCLm3@fedora/
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: dm-devel@lists.linux.dev
> Cc: Song Liu <song@kernel.org>
> Cc: linux-raid@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-settings.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index cdbaef159c4b..d2731843f2fc 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -182,17 +182,13 @@ static int blk_validate_limits(struct queue_limits *lim)
>  		return -EINVAL;
>  
>  	/*
> -	 * Devices that require a virtual boundary do not support scatter/gather
> -	 * I/O natively, but instead require a descriptor list entry for each
> -	 * page (which might not be identical to the Linux PAGE_SIZE).  Because
> -	 * of that they are not limited by our notion of "segment size".
> +	 * Stacking device may have both virtual boundary and max segment
> +	 * size limit, so allow this setting now, and long-term the two
> +	 * might need to move out of stacking limits since we have immutable
> +	 * bvec and lower layer bio splitting is supposed to handle the two
> +	 * correctly.
>  	 */
> -	if (lim->virt_boundary_mask) {
> -		if (WARN_ON_ONCE(lim->max_segment_size &&
> -				 lim->max_segment_size != UINT_MAX))
> -			return -EINVAL;
> -		lim->max_segment_size = UINT_MAX;
> -	} else {
> +	if (!lim->virt_boundary_mask) {
>  		/*
>  		 * The maximum segment size has an odd historic 64k default that
>  		 * drivers probably should override.  Just like the I/O size we
> -- 
> 2.41.0
> 

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

