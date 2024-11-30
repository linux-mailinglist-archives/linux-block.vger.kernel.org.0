Return-Path: <linux-block+bounces-14727-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413B49DF1E4
	for <lists+linux-block@lfdr.de>; Sat, 30 Nov 2024 17:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF5C9B20E66
	for <lists+linux-block@lfdr.de>; Sat, 30 Nov 2024 16:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFB514AD17;
	Sat, 30 Nov 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GrXOfIzX"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDCD4436E
	for <linux-block@vger.kernel.org>; Sat, 30 Nov 2024 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732982426; cv=none; b=p4SMjhvZQ6+T8J0jOxy2WJg6fnUbCu4mpfYWGGCzVraTervg5SVbWP4XIjndyjP7zHOouRySJxpLbSuFH0QT5vawr5H0dO2xH2k87q3B/U8uqOBMNJQu3w/L4Fw/2wxomD3XMy1m9TK4Och7nNF6umt++9mH2l1OOmSzyHu5BB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732982426; c=relaxed/simple;
	bh=sVk+xK9OlSg6wVXyYOgSw4yWHPa2n+jrEqXIvAEe8t8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnVxCfA/ULpZHnx6PUdc9eA7/qpN1ez4HyQ/Qw4+UxS20l17vE12mTBm/svedkCgqg+BPlII9+zyqUyBSwCryTk/5p9SP0q3x0jK/QGmnUPD88xtbSpmFN/qhJqxlfuZliGeWtTNrpAFceCU9sRbwbMcyp3Pu2dH+tr8GF6wI6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GrXOfIzX; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee9050346cso220007a91.0
        for <linux-block@vger.kernel.org>; Sat, 30 Nov 2024 08:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732982423; x=1733587223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBp9IrYeZGmrlk+/+Z0GIb8sd46LxSapmHIVfvyatgc=;
        b=GrXOfIzX6XAjAzssRobiwd01ECgDR2mym9jx5AzQeRCuGOvxUtx99697kj8J2eFh9U
         M+4WFcRR9Aa5LlljKTSc4qMZ85YU6GyKBeR0jB+bB7idLzOrprwW0sdObMyCG+XUBHGf
         3KjUWDLA0UNPxp2CzQ1BVDDK7FPzZ9v3tdTvJeUsUCYz+erZh7UFH96tykTlFRAOT4fM
         59siCjV5jZ06ryJHFtloftYB3pcKLA1BKBdg6fhOl3yWHrH/cRC6o2LtswVuEIR+P16O
         PZZKQZMrwBmtsuj6JxB7yGhZBCtfC4JAm80ZHv6rxC/QGXAGT1lV+N/wdtyaE+jTh58U
         ELKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732982423; x=1733587223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBp9IrYeZGmrlk+/+Z0GIb8sd46LxSapmHIVfvyatgc=;
        b=AEw9nOd6jqw+vhUENfOjNxIg84n5yJU4csKPfkpj1GH4WAyvuDwIcZnTwIpDe9elb9
         A2UHGY8jRWr3C96VmwFJjUcqY78WToYyYU9kwES+kY833Z+zzOAT9oLuuOQFvowwqygl
         3WdKGsmw6b8mp6GddrQ9tUcPbjKlkN5zW0LJUjRv6fcvCaWNBf1YbvIOxXs0lppIJFgy
         r67yVoH6wIt7hlsynGGcDNhP9NWaKMduqHcPC2NqyRVnkqpaZOj0KdrFgpVZZUhRw6o4
         QabygaL7kotiVPbt41jePPBQKd0agW7oEJRthzH9tAIOBllk61+o8NGOcqwPnnYTY462
         HA5g==
X-Forwarded-Encrypted: i=1; AJvYcCV3KwuSLsDVRkq6+zFev7PLrpG5qadqBAwvrJu77oyqN327qu0S9Qn2CS4ofSb7J22ST8YP9oqGc0rEEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkEpVIsYW0Ovq3AxAUWypKmOM3EljaJFddEjoWqPMLjFdZ7e4y
	GYSPgjK7BGJtCp3+V9lu6iVyCd2QI30kSmNlEPcMglSHn/RQzDu4cLoM2H11aK0=
X-Gm-Gg: ASbGncviDFCCN/R9bsGdJ06FFTwvkT72fefdUMk/r2JLAlpND6cT4GHlvkaONkvYtxK
	T15zhjtiscLroS9UdqcG5zeMYjtGtjaHzqCauNbM0cFJNSUE+8L5ehAPI0k3sEQdkcirgfiOfq8
	DyMgDNxmpFPhZXoXPpJsz81sViGq6zj4JGB36inXZ6Si7yxdJFWjHGVzh6+VRoeu3rgWWkGNBL3
	g5fKwfxaYstaM4YHr08lRCu1Ax3yWtkZ3VXg5dVFf5HI1Q=
X-Google-Smtp-Source: AGHT+IG1gHPYs7dRx/9K/MKMozvZqss0Yzgyf9xmOJ+a9uwRem4JCoxPp54/uDhnsiyHbktTmr/V0Q==
X-Received: by 2002:a17:90b:4d01:b0:2ea:59e3:2d2e with SMTP id 98e67ed59e1d1-2ee08eb1144mr20727390a91.10.1732982422887;
        Sat, 30 Nov 2024 08:00:22 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa47ffbsm7135857a91.12.2024.11.30.08.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 08:00:21 -0800 (PST)
Message-ID: <09db95ba-b396-4734-9ff0-9331579c92b7@kernel.dk>
Date: Sat, 30 Nov 2024 09:00:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ioprio performance hangs, bisected
To: David Wang <00107082@163.com>, chris.bainbridge@gmail.com
Cc: bvanassche@acm.org, hch@lst.de, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 semen.protsenko@linaro.org
References: <CAP-bSRZehc2BxRC_z5MXKQ6qHNPXPgZoOQTtkiK_CFd494D_Fg@mail.gmail.com>
 <20241130060949.122381-1-00107082@163.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241130060949.122381-1-00107082@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 11:09 PM, David Wang wrote:
> Would fix/revert reach 6.13-rc1? I think this regression has
> significant nagative impact on daily usage. From time to time,
> my system would *stuck* for seconds, sometimes even when
>  just `cat` some small file it would take seconds, and once,
> my desktop failed to resume from a suspend, I had to power cycle the system;
> Polling /proc/diskstats,  I noticed Block-IO read latency,
> delta(# of milliseconds spent reading)/delta(# of reads completed),
> is very high, ~200ms average, and frequently reaches 10s.
>  (Strangely block-io write latency seems normal.)
> My bisect also land on this commit, revert or apply this patch would
> fix it.
> 
> Kind of think that 6.13-rc1 would be very unpleseant to use without
> a fix/revert for this.

The pull including this fix has been sent off to Linus yesterday,
it should make -rc1.

-- 
Jens Axboe


