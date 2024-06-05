Return-Path: <linux-block+bounces-8223-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775908FC2D8
	for <lists+linux-block@lfdr.de>; Wed,  5 Jun 2024 06:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F6E1C22729
	for <lists+linux-block@lfdr.de>; Wed,  5 Jun 2024 04:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F4712F5A6;
	Wed,  5 Jun 2024 04:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4Qae8yb"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E321438396;
	Wed,  5 Jun 2024 04:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717563124; cv=none; b=iGyNMMMLl6cNLF97ndxdYVs375VqPAllGtUo+l+Txw2uxs3dpTB7+DLwphxUOJlUdJNf/RohDBs8FklMHS86d/DDV5Z8Js0dBTjLI4BV5JngIX0zCdN6ZhsDIb5JRHYOzDtx/q1SiHrqtbXGi05zNSpfN4paM9Cw88daQOZwXkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717563124; c=relaxed/simple;
	bh=of3+m6Ir5k8EscPF5x05jGCd4aSQ4kEkwutyMisWzbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxsQ7i20pU6fFKdUuQmNUaQKkNL+YMaVD7FRiSvsFxc4o1sS7jDxJ91lrS3tCf61HxnbNzUzQPUeG3735V3lxaaF0JIFOpunkkbDo7ja3caRbtO7BPwgrGz9cZC4DHbKIiqtopYIg99FKgWmFu7BhC218IXEotKq8cci3ZGreq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4Qae8yb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A93C32781;
	Wed,  5 Jun 2024 04:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717563123;
	bh=of3+m6Ir5k8EscPF5x05jGCd4aSQ4kEkwutyMisWzbM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c4Qae8yb22T8keiUIcwPwLzI3lqYaq90CTDZe9PuDSFVg3oKMaFxgDVFHaPvQHbO7
	 H7bXroQ6ZIQm7cbFOwZ2+WA+bA7eKqMU+6eMFjbT9Y5PlpV5okbO1Mw98Yl0rIrOpc
	 RC3vgXZOGGxOJ1zu0hLeVMAE4+UpOdbYqcr2RJLJUADzF0mYNB6ZW44F3YywrfR97L
	 idcdAxnWKwJDstfVvLfuUY/K7Df+U9VcgBWf6RTPHNntfIKl6xTxbivirB0zvtZFAb
	 SKVj1py+oXM4q8cb9FLJvkdIXQ+lwsyKytF/yQgoDjy6QJ9Oc2bXgY3sMDbyZPKfRX
	 zLX0QcOJ9yqlQ==
Message-ID: <71118710-51fd-491a-8dd6-5b43b61e297a@kernel.org>
Date: Wed, 5 Jun 2024 13:52:01 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: Imporve checks on zone resource limits
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>
References: <20240605022445.105747-1-dlemoal@kernel.org>
 <20240605022445.105747-2-dlemoal@kernel.org> <20240605041754.GA12183@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240605041754.GA12183@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/24 13:17, Christoph Hellwig wrote:
> improve is misspelled in the subject.
> 
>> @@ -80,6 +80,10 @@ static int blk_validate_zoned_limits(struct queue_limits *lim)
>>  	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_BLK_DEV_ZONED)))
>>  		return -EINVAL;
>>  
>> +	if (lim->max_active_zones &&
>> +	    WARN_ON_ONCE(lim->max_open_zones > lim->max_active_zones))
>> +		lim->max_open_zones = lim->max_active_zones;
> 
> Given how active zones are defined this is an error condition, and
> should return -EINVAL.
> 
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index 52abebf56027..2af4d5ca81d2 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -1660,6 +1660,11 @@ static int disk_update_zone_resources(struct gendisk *disk,
>>  	lim = queue_limits_start_update(q);
>>  
>>  	nr_seq_zones = disk->nr_zones - nr_conv_zones;
>> +	if (WARN_ON_ONCE(lim.max_active_zones > nr_seq_zones))
>> +		lim.max_active_zones = 0;
>> +	if (WARN_ON_ONCE(lim.max_open_zones > nr_seq_zones))
>> +		lim.max_open_zones = 0;
> 
> Why would you warn about this?  Offering an open/active limit larger
> than the number of sequential zones is a pretty natural condition
> for certain corner cases (e.g. create only a tiny namespace on a ZNS
> SSD).  This could also use a code comment explaining why the limit
> is adjusted.

Right. I actually did not consider that case, which is indeed valid given that
for nvme, the limits are per controller, not namespace (which is a very
unfortunate design flaw...).

I will remove the warn and add a comment.

-- 
Damien Le Moal
Western Digital Research


