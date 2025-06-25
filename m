Return-Path: <linux-block+bounces-23179-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5ACAE76E2
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 08:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554A03B143E
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 06:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC051E5213;
	Wed, 25 Jun 2025 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pD+/vEkx"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7C307498;
	Wed, 25 Jun 2025 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750832368; cv=none; b=XjiWdhenmPEFYbEvet4BEwh1wTsUOGH5d0dTFzTUJpsUCX0AGDH/8/08fyIwAuOAz6y/4HhrVyzi0DV5T/pxP2RILecOuOTjYpp+raDHbksTET1w1R0FloK9+QMwM9oRn4aZHkRvCKbeBv7WpBKPgiycRxOxfzpuPUWgUm1DKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750832368; c=relaxed/simple;
	bh=1qi5Yov3GODs0w+gAA6kJpkM3UlrycwVwLRtJ/45JGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrGgFf4b4MLbP87CCdnPZ6Q3pGICAiABmFTJFf52sKDwlgmTU2i9Xw7aknQgJu3e9wgTpq7ORR8TpsCdb3mN6H+jyxW7XXlgQxzEOVzo9lCNDmAhRHw3FcuiNXR0kMK6QV1to1SuPt4YOELD2p++jkEIBWG4CWJVzwF9A+i74BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pD+/vEkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7093C4CEEA;
	Wed, 25 Jun 2025 06:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750832367;
	bh=1qi5Yov3GODs0w+gAA6kJpkM3UlrycwVwLRtJ/45JGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pD+/vEkxlkaopInOSehvBZ4WJSwjO37Xt7FMTR4Y33CsBc3JYOPZ8cjzvGwqZbsBG
	 FG+e0gbLNmJfhvMcnLLyKfd751q0ru0OV12bTO1ON5CKrmeAARni8/7gxNe/RslgQ6
	 o76HsXKlM7YZIvqggqtB1iPSG0fk/QUPrm7UKdXP/aTsoKyJ68090TkzI75ydgSfUa
	 ZUcMXcpaaI6JDxXkhCS093MuZBCjoQXi6UNJz6xKx97ucKz+mOnZYHBUuMtZWlW6Cq
	 V7SQ+RDVf2CoQL1+XI+qCqLe/vJ5r4V7oSnKm3dHWH9tavxBkW1nILYHCMxIwS28TF
	 SsmSm/QqYhahw==
Message-ID: <06dc67be-f258-4c88-941a-d5b7817baf38@kernel.org>
Date: Wed, 25 Jun 2025 15:17:23 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] block: Introduce bio_needs_zone_write_plugging()
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Bart Van Assche <bvanassche@acm.org>
References: <20250625055908.456235-1-dlemoal@kernel.org>
 <20250625055908.456235-2-dlemoal@kernel.org> <aFuTYxdeAzG1iSl9@infradead.org>
 <576bb6dd-18b1-4c78-b848-51577d99b124@kernel.org>
 <aFuUpLwmUWWwOmeB@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aFuUpLwmUWWwOmeB@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/25 3:18 PM, Christoph Hellwig wrote:
> On Wed, Jun 25, 2025 at 03:14:51PM +0900, Damien Le Moal wrote:
>> On 6/25/25 3:12 PM, Christoph Hellwig wrote:
>>> On Wed, Jun 25, 2025 at 02:59:05PM +0900, Damien Le Moal wrote:
>>>> +bool bio_needs_zone_write_plugging(struct bio *bio)
>>>
>>> Can you use this in blk_zone_plug_bio instead of duplicating the logic?
>>
>> I thought about doing that, but we would still need to again do the switch/case
>> on the bio op. But the checks before that could go into a common static helper.
>>
>>> I also wonder if we should only it it, as despite looking quite complex
>>
>> This does not parse...
> 
> The "only it" above should be "inline", -ENOTENOUGHCOFFEE

OK. Let me see if I can do that.


-- 
Damien Le Moal
Western Digital Research

