Return-Path: <linux-block+bounces-18477-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABCCA63070
	for <lists+linux-block@lfdr.de>; Sat, 15 Mar 2025 18:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3C11892E02
	for <lists+linux-block@lfdr.de>; Sat, 15 Mar 2025 17:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED8E1F8736;
	Sat, 15 Mar 2025 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TlPMonJf"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4A61EDA26
	for <linux-block@vger.kernel.org>; Sat, 15 Mar 2025 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742058204; cv=none; b=Usk1YGtZ10ebcay/P+AIvYvppgmVJ26iG8zuYCtKAN0JaOET8iLH55p22ivdL0w1zqLOVzkFKb7XOUKwx2bXYNJvu5i02N/lCt9pbtn4b8eLxdCq+cwq3ltJ598KxdRtpKbevlKpXTiRY8j9LZzOkwvkUdDLOG0abgJVRoTYW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742058204; c=relaxed/simple;
	bh=7ZdLXaf+CadhUXljcsUJzvjVnLmjmhtXw6QW5CUaWKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/Tl6nJOgkK/ofv04N8eAG0xsI1Iul7KaWE/WQJwlqJwj1GhcBdKd4/W8HU2eEX/GumI2fnZtLF+87l8pw+5UvJBMZ6IRZrIegB+dDeSAPyPBApC9U1GxoZJWeBeDSC9F13rZ0/Jxqm/Imqse5ekpbqCzIFTMJRgv57WNWhLWw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TlPMonJf; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85b3f92c8dfso95375439f.2
        for <linux-block@vger.kernel.org>; Sat, 15 Mar 2025 10:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742058201; x=1742663001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Egxjbspk7CUTt0+tSR1DyNLTrwPXLP2pqAPJwtCDH5M=;
        b=TlPMonJfTBp+8Lb+TLdCihB5zrZAXN5sVUWjsv/WIkpvCX+1diKrEdSr7AcrBV44Th
         a6wQk0Jz6ElhavFnpcQE6wC7EA1pkhJFY7Z3u0REgQqaDMYcSjjICJCjpZPdj/qq658t
         6R02lx6NnZF7Hx+AH8DBSnNDXUjp1JI1U0tGw3Ggiht7NZ89Nr6fwqFlRSQWM/IQpAH9
         UmG7RWpGYPOgIzaQqnwbajDvdDI2uqVTDx8OkxqRXE0eXQJEORwToA/qBG7WvXRF3SAf
         RZfRe1Oq1wWyMDKLwmkCDfRyQJJYRLlwk2xTB+/ijQS8U5cvvupxVNNBGgR1RnZULosF
         jVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742058201; x=1742663001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Egxjbspk7CUTt0+tSR1DyNLTrwPXLP2pqAPJwtCDH5M=;
        b=phuqqhlsmvwlOkiYHJKguGWWaDO5XRsksFx47MCALkLEAWn8gmXn0vPTwoqEfWWVzL
         fNjis4ZSIu/qtGMoMEG88ok19nnO0lACGLr4v3DxFywyorGcReeyOhthTkvXcPBHCgdy
         qXcSF7YKnF2QpK5jJEXIVxWLpK2saKy70UfXamOOEibqZCaiRhKGH40IYAFq3pvJ7Inj
         nsgmfuztXrKa8gwSb7rHqBfOyHqBwsU4cCFhZ6xTfBvpXHtiPWWiLlkMKCnmK2ksWUmZ
         QdFqVoHoLs8nt14i9ghv+fXcZ1Uur3T5g3o7qeBuRaFQxG1dkLp1zQRkUAS8m0ET5e/2
         k3ag==
X-Forwarded-Encrypted: i=1; AJvYcCURzGFfaIn0930O22qgsBCdpE4L81CXXcOgVg/gQ/zjkWqkoa8MzOCNkAxczQd6XuFrwAXe8p9YgUjAQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVVgkDNwKi31vWM8His+n4PYNO7MM14kfsgetXLakBeB/mRGvJ
	VpZ/fJltzPHLirlkpX3GmgKRrNq2tzsc28xRkKmFSrwtH0pzXwPCfqhd88bNC6M=
X-Gm-Gg: ASbGncszN+CyTYMhuEPrO2oc0tIF+6KUprA3n3fQOHxepHW0CEfa1AH6voPCNwfjJ3J
	uXkbMP+4r9oA9eE7yHR/srjqMoJcYpbTBJKio5IjBfUERlJyICVq9tQMp//spSE2tc15xxZIrgb
	AP93+hkw/SIXbP7TvAQTNYdn3IFoPxO991F6orQ0uRiQ0+8GG/ap5zoF/LDluUk4+rxl+AbWyL9
	ZPy5uE7dpf59QcaHC+GF0rLe1PO371E5V1p4kmVYml0QLuWObEzmzba5bqNwGaPdeYUfw2gkfyo
	XpEgIm7DCBc7mfTnDssReojp6krntRNL/+wfgXoPjbtcP2/dp7LO
X-Google-Smtp-Source: AGHT+IE321PsNWhzNdrkjj2zIMLoscsn+Dfjy1kwPwR01aE8+0mG91VZHf8xuhXbf7dGLwUeABh1Qw==
X-Received: by 2002:a05:6e02:3710:b0:3d3:d965:62c4 with SMTP id e9e14a558f8ab-3d483a0adb3mr64189635ab.10.1742058201572;
        Sat, 15 Mar 2025 10:03:21 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a667197sm16598545ab.25.2025.03.15.10.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 10:03:20 -0700 (PDT)
Message-ID: <510692e2-b83c-45bc-8d9d-08f7a172ffe6@kernel.dk>
Date: Sat, 15 Mar 2025 11:03:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] block: Allow REQ_FUA|REQ_READ
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-block@vger.kernel.org
References: <20250311201518.3573009-1-kent.overstreet@linux.dev>
 <20250311201518.3573009-14-kent.overstreet@linux.dev>
 <9db17620-4b93-4c01-b7f8-ecab83b12d0f@kernel.dk>
 <abk74sbsvsuijqhohyenl2mecz6unmkhavkga55fxsld6m6ise@ncbz3xmjlymw>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <abk74sbsvsuijqhohyenl2mecz6unmkhavkga55fxsld6m6ise@ncbz3xmjlymw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/25 11:01 AM, Kent Overstreet wrote:
> On Sat, Mar 15, 2025 at 10:47:09AM -0600, Jens Axboe wrote:
>> On 3/11/25 2:15 PM, Kent Overstreet wrote:
>>> REQ_FUA|REQ_READ means "do a read that bypasses the controller cache",
>>> the same as writes.
>>>
>>> This is useful for when the filesystem gets a checksum error, it's
>>> possible that a bit was flipped in the controller cache, and when we
>>> retry we want to retry the entire IO, not just from cache.
>>>
>>> The nvme driver already passes through REQ_FUA for reads, not just
>>> writes, so disabling the warning is sufficient to start using it, and
>>> bcachefs is implementing additional retries for checksum errors so can
>>> immediately use it.
>>
>> This one got effectively nak'ed by various folks here:
>>
>>> Link: https://lore.kernel.org/linux-block/20250311133517.3095878-1-kent.overstreet@linux.dev/
>>
>> yet it's part of this series and in linux-next? Hmm?
> 
> As I explained in that thread, they were only thinking about the caching
> of writes.
> 
> That's not what we're concerned about; when we retry a read due to a
> checksum error we do not want the previous _read_ cached.

Please follow the usual procedure of getting the patch acked/reviewed on
the block list, and go through the usual trees. Until that happens, this
patch should not be in your tree, not should it be staged in linux-next.

-- 
Jens Axboe

