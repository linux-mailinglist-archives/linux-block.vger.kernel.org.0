Return-Path: <linux-block+bounces-15060-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A899E8D9F
	for <lists+linux-block@lfdr.de>; Mon,  9 Dec 2024 09:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EC7163098
	for <lists+linux-block@lfdr.de>; Mon,  9 Dec 2024 08:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2D22156E5;
	Mon,  9 Dec 2024 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HskT8TnZ"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC2D215191;
	Mon,  9 Dec 2024 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733523; cv=none; b=NREY6qXGmbSiddfmAj3ulHtJxEal/lTAIXRCQUq9oKka8AecUy9Etq14h/kKcTUQP2gKupPre70MtBQmA74LH7HoMCKMQ6M1T+6ISMaMiIQTZ9dMwcjgaEJwYau+kjJBYSWda9EkApqDvbfyOEs3Dmv+30dxpT/TNYyoGNfJG0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733523; c=relaxed/simple;
	bh=P9ZhCNc2wcrqmMZsNL7ztx9Ss2egh36Osy894lq2CRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uuG/v3TR7fq/JdPMJXpicJUb+i1ZuRkNsHAVEbXaMecNX0y3qiExbY791K52gHIhmdy7fvzW2nfngWD2DgnpC6r2K2Q/X7xVreY3PDvqAj5e6jFogum9oD0JBELCwztApsL+vJjyaLIn+pdc6P330ugzxiYApNFYHMB6RxbKPSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HskT8TnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0503EC4CED1;
	Mon,  9 Dec 2024 08:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733733523;
	bh=P9ZhCNc2wcrqmMZsNL7ztx9Ss2egh36Osy894lq2CRc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HskT8TnZ0cJnmqM++Co4xjivZnP9a0D9THdbAix2d2cjwSPNk13oMmWEQDyH05WAa
	 wSChpWoyW5ZRbbK95B6YDfi8zRE7Bc+Y4Key1gL13nwQcRozgNq5YyB495MxGmU4a/
	 dlOQT7VmuF1++4+4l9tmRAMdymCRjmcl782j5ESOp5woI80XO5SZZrQQdl3vTLRAvO
	 h3F+n8lSuae0hD5UT585pEXvvtqQb1Tzh0p0NbsRKrR7WCLM4izYqdhQ7vf/R73htW
	 LtFLsffxh5gAYp7onASSrdTcKXsck9WjJPsot1BaJ80nNhMfhMKTLBX9BbxoNYoMMq
	 kPkfF4fs3S7BQ==
Message-ID: <56ee11bb-0dbc-4498-a529-b2f47e92e934@kernel.org>
Date: Mon, 9 Dec 2024 17:38:40 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] dm: Fix dm-zoned-reclaim zone write pointer
 alignment
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 dm-devel@lists.linux.dev, Bart Van Assche <bvanassche@acm.org>
References: <20241208225758.219228-1-dlemoal@kernel.org>
 <20241208225758.219228-5-dlemoal@kernel.org> <20241209074408.GA24323@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241209074408.GA24323@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 16:44, Christoph Hellwig wrote:
> On Mon, Dec 09, 2024 at 07:57:58AM +0900, Damien Le Moal wrote:
>> +int blkdev_issue_zone_zeroout(struct block_device *bdev, sector_t sector,
>> +		sector_t nr_sects, gfp_t gfp_mask)
> 
> Nit: Would blk_zone_issue_zeroout be a better name?

Yes.

> Also I think this needs to be re-ordered before the previous patch to
> preserve bisectability.

The problem with doing that is that there is absolutely nothing to patch/fix
before the previous patch, since the "recovery/report zones" was done
automatically. So if anything, maybe I should just squash this patch together
with the previous one to be consistent against bisect ? That does make sense
since this patch is needed *because* of the previous patch change.

>> +EXPORT_SYMBOL(blkdev_issue_zone_zeroout);
> 
> EXPORT_SYMBOL_GPL is used for all other zoned code, I'd do the same
> here for consitency.

Indeed. Will do.


-- 
Damien Le Moal
Western Digital Research

