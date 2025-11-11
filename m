Return-Path: <linux-block+bounces-30002-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61229C4C159
	for <lists+linux-block@lfdr.de>; Tue, 11 Nov 2025 08:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27D618E432F
	for <lists+linux-block@lfdr.de>; Tue, 11 Nov 2025 07:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6FC34C81B;
	Tue, 11 Nov 2025 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtcDFUbu"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551DF34CFA1
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845053; cv=none; b=cQwMSHyCIv0TgziGNvAhA0JSECsB3q6k44sUJIQvauAnhMHEkqUzUNbyyWXGctWwgrR2ziapRudx/ihR+m8i9WqQ1P+hoBDUoolF9UF2KiCerNyTdnPQhVcni0nzUBYKg5N/Wn/kcPeKVoDScuZJ8HP5WpXp1df2YeA9UnIjR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845053; c=relaxed/simple;
	bh=0dwmo+5C0Xk6vgui/qm7J3MyDRsIQ346S3LjWhnuJ8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMG8iP5XHwWM57fq8gNBoGCH96HCRwZI1iUM1pbu8N35i77eCANXo5ur+sSpmmOUnraLOdSqj8ZWIXTfg2rPbD80dZkQrvlrLkZCpMyIGIssNwE4eeyn1mwxyPnVVP14CDZwwBP9JosW8OkbqU8szlb6heCBSlM8tT4Ad8JcMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtcDFUbu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B8CC116D0;
	Tue, 11 Nov 2025 07:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762845052;
	bh=0dwmo+5C0Xk6vgui/qm7J3MyDRsIQ346S3LjWhnuJ8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KtcDFUbuTGiQvDg76leDcVkiW0iiHIesEAPvtVRnsm1ZPyWzABWfctn0JXg+0O87e
	 PVYSbh6f/M6TO1uF9CIDRVD+UOQyj0Jwy7TgBEjg6eJdzcMjZzizDOBim2LmW3yEvP
	 broe5WHs/Qt46AL+H/kfVeqC1hMsNMFD00mNK1sU6S+CQr7OU6uODPY3CKwkRauB6a
	 5jpqkVSQ8QgidDeoPaeSDYc0eonmL43x01LVWOJq9B2XFGQbTxya7DdyK2AelsBWVj
	 RFoP+8XZTCobvHz10D9nAU31OdicORk/H9bxe0OcoM2XbPahqGapTUHkaIv3AsEtBn
	 +ud2P3o+TZBaQ==
Message-ID: <9b62d0ce-3a72-4e62-9b8e-4f7d9fcd60a7@kernel.org>
Date: Tue, 11 Nov 2025 16:06:55 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] blk-zoned: Fix a typo in a source code comment
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20251110223003.2900613-1-bvanassche@acm.org>
 <20251110223003.2900613-2-bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251110223003.2900613-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 7:29 AM, Bart Van Assche wrote:
> Remove a superfluous parenthesis that was introduced by commit fa8555630b32
> ("blk-zoned: Improve the queue reference count strategy documentation").
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

