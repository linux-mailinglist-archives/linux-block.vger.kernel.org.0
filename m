Return-Path: <linux-block+bounces-12290-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9029934E3
	for <lists+linux-block@lfdr.de>; Mon,  7 Oct 2024 19:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 875A3B222F7
	for <lists+linux-block@lfdr.de>; Mon,  7 Oct 2024 17:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EDB1DD875;
	Mon,  7 Oct 2024 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BwJqjvRz"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD631DD862
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321905; cv=none; b=dKCWCDoAoP6hdptmfNC8uRcXi3KsVHNFr0jxmQ6TXWmglxbsNn5Otj5uHDRndlTj8O2h8QG3m4lIQupWApT0bbtLq9YxO5c0sNl6kaOJw282S9joABxdk+wwoxY9LGlp8A+6NpQ7/Ci76l+PfBXNtzMWSDsrFtLlYSOms7Rqofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321905; c=relaxed/simple;
	bh=1/7sb4L013jDAAikYnXrFI6XHOPJj4cPj8B9qnNztFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkwLLD/yahPNBSR2hJzEkdt2u7QYsN4nssA0BnP4mfffBBJt24er1brCfNVVkDi3gfhCBtN9oFhoh/qRm7JfMjsQ5gISZRtMjhbXj5Bkdji1HZdohWNaCikPm84FSP+H5XPQtO2ahcYY10UAxFZFX0Ulyl181hkCUbW4LXj+LaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BwJqjvRz; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82ce603d8b5so217668639f.0
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728321902; x=1728926702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDdjFXnqmzo2D0DMdD34d22tTx1BzoX1VwMsigXz9oA=;
        b=BwJqjvRzFR1laLjjVMwjjOphH10LIdrPsOfmNvXCPsnJjfG2mWBc/n5zw1Ljb9JFqz
         UziNOhml7Dig1yB88LEFrx7WitHV1Gc1V8E6AQqq3qw7Ce90cYWbbPEc7eXscdutEn6H
         +Fq3dKEPLwQ3Ss3EPyFKNpm2uwlZiOQrlZCuOIXRrbgYxGLFLPt8AXmMAJuKkTGGfkuK
         83muVKMGkDKNl7Y6+CAWX30giOTTMZEP3s1BBk0aaSShjOUv6dCeL95+834dmdJ+UAK1
         V5Ih2aZE+o6Pq91CdRfd0Rvx63xrX9EghM1es8b15fiuh8aQRds47VVvuQqDddoPKUr1
         IUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728321902; x=1728926702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDdjFXnqmzo2D0DMdD34d22tTx1BzoX1VwMsigXz9oA=;
        b=XYiMDHP/bcx04yeIk8qMTmenw9W9D0dCa5bKD3l0CDltjP8ZSwCQvl2X25RCdahCwS
         TWKghzRSOMLRtjEx9RjcfgmQfcBHFr3GaCASsnGzSdEC51EpCmHpU5FYlUa4xS1OhWJZ
         XSwwXbh0PKJbE6gnaUGrQLHunriZlwC7mSDgp1LSuiHzBiOIjEMGkP7u0dclDKRAkC0Z
         eCDj/UV6jL8BLP3KtL9BuY3PcF97SYpo7sR0HWpPa6/kk3LfAFunyResBSDZHUJHqcmK
         qv2AcO22yFzkhY7dlcrg8UYU0cCHAqrVlC82u2zwsUz2W6hKTH68/lLcQdykxZubs5T+
         70lg==
X-Forwarded-Encrypted: i=1; AJvYcCV5yz6/rtz94BXdbBi7QC2uxm3Otu90eqPLSv37B4P/2dOzdrnUEXOebxqBuPK9b1YhRKNfW8EpqBboGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVX4ExyWhcCLaLEHKrZtmgGALkIZD3pG09SEIbDl61Nw1/VVhs
	tZk2xo+yR02+Nsa7WWFI7zOwoPtXk4JrwIbr7sLDOh/X5BiuGSOE6ZtSr5aP5tE=
X-Google-Smtp-Source: AGHT+IGWfL6HTIq4hx4Xl9HY/v7hmc4gwRkJVnaJ9iEtS1GjCpScQx9VZE12aSSpuwRj5pyXh82SWw==
X-Received: by 2002:a05:6602:48c:b0:82d:2a45:79f6 with SMTP id ca18e2360f4ac-834f7d65548mr1332217339f.11.1728321902609;
        Mon, 07 Oct 2024 10:25:02 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503b2fc8csm132792039f.48.2024.10.07.10.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 10:25:02 -0700 (PDT)
Message-ID: <5878e794-a5b3-4a76-ba1e-5ab678dac86b@kernel.dk>
Date: Mon, 7 Oct 2024 11:25:01 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/srpt: Make slab cache names unique
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20241004173730.1932859-1-bvanassche@acm.org>
 <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
 <e9778971-9041-4383-8633-c3c8b137e92e@kernel.dk>
 <09ffcd22-8853-4bb3-8471-ef620303174b@acm.org>
 <09aa620c-b44b-41d2-a207-d2cc477fdad2@kernel.dk>
 <04daaf4c-9c62-404e-8c5e-1fffb3f2ecbd@acm.org>
 <d6df2c28-467d-458e-9b53-4cb7abcf682f@kernel.dk>
 <20241007172253.GB1365916@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241007172253.GB1365916@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 11:22 AM, Jason Gunthorpe wrote:
> On Mon, Oct 07, 2024 at 11:20:56AM -0600, Jens Axboe wrote:
> 
>> stand by my comment that using ida for this is overengineering. And that
>> yes there are 3 slab caches, but having 3 per whatever instance is silly
>> and you should share those 3 across instances. 
> 
> Store the slab cache in an xarray indexed by the variable size and
> name them according to their size?

That's a way better idea.

-- 
Jens Axboe


