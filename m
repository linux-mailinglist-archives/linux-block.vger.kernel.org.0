Return-Path: <linux-block+bounces-7964-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFACB8D53E9
	for <lists+linux-block@lfdr.de>; Thu, 30 May 2024 22:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC9E1F24220
	for <lists+linux-block@lfdr.de>; Thu, 30 May 2024 20:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F56825634;
	Thu, 30 May 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="s8m8oCr0"
X-Original-To: linux-block@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E974D8D0
	for <linux-block@vger.kernel.org>; Thu, 30 May 2024 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717101437; cv=none; b=lFTbc8J7l0FPpchMfOwyT5eoNnLYCxMF/9STLCJk6PSG2C8DFxdKi33Un79UIQpzWOTOoXmLGYjw4UY4fVdgRkiOq3gv0JSq+DWTOU84Apv5UzeRfslYm5Hi1z6MrQdW4yNdrJ/5zI65DUK0YelhAymFUVLYBLQp5qtPk9IPdAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717101437; c=relaxed/simple;
	bh=XsXuvxy2nTmG3LsTxeJWQSmu10Fmkp2b/PNj0eZ/pNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nvP8wWZGEuZUQl+Ir5eKu/bisCJ7Mn3BZN6UdZeVbA+EiZr7Y6yauG16IH/8szQRflJBD+H1O/dR8Aj788Zgc3GknEp7icLz95DRJ7dzoEXUb4tAgWiPgte0LL3Ju6szYTqyiXcHZALogyQso+WaSpJ27LvyQkLiAyl1uTPq4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=s8m8oCr0; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VqyjJ46q8z6Cnk90;
	Thu, 30 May 2024 20:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717101425; x=1719693426; bh=DLfCZtyRzHIsF2Lz55XmAEIa
	KIFIuNYrjxnUL2+9wG0=; b=s8m8oCr0+EreenuVzDGfBeujPbkaHvV8I8eN/E93
	EPvn5LE7g/dm6tCJbn7XPICdGro1C+kFEYWYfSnqgaM1CPLSM0bWcuPmetvkqPhS
	tMcUuyJVusde5iXpyxaabN7oi4HjdXVf2CeZVtGw+UHhy2rrUMKhjqbsUf+Ts/F4
	T92sGruH065VGF0DDikBkSiP5C4fcO5faN32U/kvgH/a/4Wn6Siq/8HJg5RZBOuE
	b8ROz7TsBmLNapZh9GjPaWlFvllBWXYj1bjEVsGtZFKIoZj+BnMAQ1i5DNWNameV
	1sblSM3u0psUjr1fc9pRVJ/QXdibGa2BypCUvp4GM8alSA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id t1Gnbb_krG9s; Thu, 30 May 2024 20:37:05 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VqyjF39ydz6Cnk8y;
	Thu, 30 May 2024 20:37:05 +0000 (UTC)
Message-ID: <74b00dce-c2df-4e29-87f8-5b54923fad9e@acm.org>
Date: Thu, 30 May 2024 13:37:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] block: Fix validation of zoned device with a runt
 zone
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
References: <20240530054035.491497-1-dlemoal@kernel.org>
 <20240530054035.491497-3-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240530054035.491497-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 22:40, Damien Le Moal wrote:
> Commit ecfe43b11b02 ("block: Remember zone capacity when revalidating
> zones") introduced checks to ensure that the capacity of the zones of
> a zoned device is constant for all zones. However, this check ignores
> the possibility that a zoned device has a smaller last zone with a size
> not equal to the capacity of other zones. Such device correspond in
> practice to an SMR drive with a smaller last zone and all zones with a
> capacity equal to the zone size, leading to the last zone capacity being
> different than the capacity of other zones.
> 
> Correctly handle such device by fixing the check for the constant zone
> capacity in blk_revalidate_seq_zone() using the new helper function
> disk_zone_is_last(). This helper function is also used in
> blk_revalidate_zone_cb() when checking the zone size.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

> @@ -1732,7 +1739,6 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>   {
>   	struct blk_revalidate_zone_args *args = data;
>   	struct gendisk *disk = args->disk;
> -	sector_t capacity = get_capacity(disk);
>   	sector_t zone_sectors = disk->queue->limits.chunk_sectors;
>   	int ret;

Thank you for having removed the local variable with the name 'capacity' from
this function. Having a variable with the name 'capacity' in a function that
deals both with disk capacity and zone capacity was confusing ...

Bart.


