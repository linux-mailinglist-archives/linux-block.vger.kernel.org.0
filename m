Return-Path: <linux-block+bounces-24475-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B30FB093A7
	for <lists+linux-block@lfdr.de>; Thu, 17 Jul 2025 19:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0EA57A5DB9
	for <lists+linux-block@lfdr.de>; Thu, 17 Jul 2025 17:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817382FCE0F;
	Thu, 17 Jul 2025 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gEaPWN4F"
X-Original-To: linux-block@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C354503B
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752775104; cv=none; b=Y+PKlQmsGersMo54S0qdnJnqR414Y8St8tjqr+p6IKHON3NJP2WgFtytpdJYpiJfUsMAllU0x5iO9ciYdEndPf8ju5mYGCVrm0Rb9225Fp2NJAvIjJYz3heWJXZ7bRCxL4fGfa1sxbw7THFZTN66zOlK4jfJI/BlKOmNoHHj2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752775104; c=relaxed/simple;
	bh=REHFq7fXYWLOb/d9We1a5bI1xSuUX/MSQR6CeeOP6HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEZeJSv+DDlOSsdrWf099j/QHd5mkv3QgUn2TM7z7fpyBWv/xZYhHx1FZbYTUgDn2xW5TSAA48l+7cV5qUCKNb2hdmDiwEmhMP+o14vUufJFJdMhNWzX2sSl/d61bYTNMEyzzWRmt3Fd52M/U1AqEvk+dXK249mOg1a6WWp7G9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gEaPWN4F; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bjgdM6BvdzlfkW0;
	Thu, 17 Jul 2025 17:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752775094; x=1755367095; bh=aDPMH9x+3klwJASEQpE636Zq
	CMOGtxDcspwpEODb1Ko=; b=gEaPWN4FSjbS7HF6Q2DYLbBLkJ3h/Wa5oyfn409J
	YJTrQsZMPpaqatBZd9YY2LqgysjpbZNlx99XY/PPNQP/TUELzkGBiYSokP0DGFdC
	0whijNCdsMGmJmUYYqD3kNAR04qO0BnKULZR3cCSpKC2nNo+tJxoXkbXiofO5qJm
	/2LfWwturoj8dGlHVM9ayD+hQdyYlH+FlPOMLsKGFDGTyBk6Hka1ZTCPGgmVqJSn
	Gw+KpEnCNDOuj3+aFwXhtX0SyUvac31NvoBfNHXO1jrpkAwFyqw+92AJVs1c4s4O
	cVD9VjKZRknaJ4AvuRomMP/omgY6H5ZVn/lLhJR480YyLA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QjJRJgleppf5; Thu, 17 Jul 2025 17:58:14 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bjgdH4NzczlgqyN;
	Thu, 17 Jul 2025 17:58:10 +0000 (UTC)
Message-ID: <4bc3f4ab-ddc4-48aa-902c-8a24c1189dfc@acm.org>
Date: Thu, 17 Jul 2025 10:58:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Fix bio splitting by the crypto fallback code
To: Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20250715201057.1176740-1-bvanassche@acm.org>
 <20250715214456.GA765749@google.com> <20250717044342.GA26995@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250717044342.GA26995@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/25 9:43 PM, Christoph Hellwig wrote:
> Getting back to this.  While the ton is a bit snarky, it brings up a good
> point.  Relying on the block layer to ensure that data is always
> encrypted seems like a bad idea, given that is really not what the block
> layer is about, and definitively not high on the mind of anyone touching
> the code.  So I would not want to rely on the block layer developers to
> ensure that data is encrypted properly through APIs not one believes part
> that mission.
> 
> So I think you'd indeed be much better off not handling the (non-inline)
> incryption in the block layer.
> 
> Doing that in fact sounds pretty easy - instead of calling the
> blk-crypto-fallback code from inside the block layer, call it from the
> callers instead of submit_bio when inline encryption is not actually
> supported, e.g.
> 
> 	if (!blk_crypto_config_supported(bdev, &crypto_cfg))
> 		blk_crypto_fallback_submit_bio(bio);
> 	else
> 		submit_bio(bio);
> 
> combined with checks in the low-level block code that we never get a
> crypto context into the low-level submission into ->submit_bio or
> ->queue_rq when not supported.
> 
> That approach not only is much easier to verify for correct encryption
> operation, but also makes things like bio splitting and the required
> memory allocation for it less fragile.

Is there agreement that this work falls outside the scope of my patch
series that fixes the write errors encountered with the combination of
inline encryption and zoned storage?

Thanks,

Bart.

