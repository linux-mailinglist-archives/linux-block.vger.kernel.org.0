Return-Path: <linux-block+bounces-13717-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B1A9C0DB3
	for <lists+linux-block@lfdr.de>; Thu,  7 Nov 2024 19:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2A61C21F8A
	for <lists+linux-block@lfdr.de>; Thu,  7 Nov 2024 18:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59FD215C6D;
	Thu,  7 Nov 2024 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gjT+5qAO"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E60366
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004059; cv=none; b=JobkK1NDkCcAICabAlaYrL0+vifbZ0hzt1akg6NON4JQUmEW44JTKBXzOlDm/9by7EavBq4GpsGUvpxsAZdcEPdIKALpscaf6BgAy/dN2zkZwV5S9qQETrOXAaacNokAIw5ea6dakCtMIwD98YfA3Qe6CG6THk/h9VJryLQKeeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004059; c=relaxed/simple;
	bh=20LrKDdXKwohLrR7m/+QaoGSjbWanGlIA0WTQG1VuBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLYvVX2ScsbkQeFjpPBno7KDjfgFPtKXLkye9TsXF1djdX31fJptRb23Xf4QCqcgCerNTkFXcqmv4peG3FwLCEkViQRaMjLc6xOxbwAFxevL40xxAGM/semGKBk6iT+FqwGW5J3tOG+gGuNFg31crm8pRdO0gdGjeB3A+GdIPSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gjT+5qAO; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-29538198f2fso852415fac.1
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 10:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731004057; x=1731608857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVnaoenE/nrPuz7L1JcnZlXT27mO9irch1BC/+wWZcY=;
        b=gjT+5qAOs6q+hOnTQLfvkunfI2tkPZ9VwKkZIDzUu2L0pYWahtTs8cwco7Pf2qe0sM
         mx7+dQaKkcwEpx6cq6+3VeVOJgBThU4Yx0TSL2CvOI1xNLYjl7oikVhmSCFNKyTj5MFw
         VU6z8LSL4lMtVha4IyXb41aT1LcvQ+f87OsIUlRpX43S3z6sUSEHOv+ghc7ggObIx/z7
         wdPRKnNx9coOdSrl3Tzg8OkeqYwpVoLsbNOBDbfsogk0/txzNVM8gIGT/Q555/+CUb4x
         1Cz9CkvESPRyz5SHYrUNKMbstSRlUI14EKnIpG0MbYqt4+D2j1cBUF19sl+L4spzDyxY
         q/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731004057; x=1731608857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVnaoenE/nrPuz7L1JcnZlXT27mO9irch1BC/+wWZcY=;
        b=i+zmFbFv7ByfQkCI3zldCU2l7TtYp2ctl6Cl1Zy2fcCeyfLQSNSmcORL4Mdl8quH5y
         lTFiL5D57BcC7FYRRCiM5Bq3HJ8OFRncCIz7Wd/35Rlmt/oZUaaQNRb4UsnmT6s1jdT3
         xWB99XA7pHfw1T6cKZJcxE77+KpjYZYKpBS6DyCLxDyy/N0Ug1uCiKoOp7ppKKKg1Nj8
         6NjR1ox4vzhqRtows42W618DVmmoHC6qPSYiLsZxbNfx/4khsZBHNjHFjumyiKltDfXY
         shRXC54vmbwf16laWM2dZjTxts6XlF0xvLxtTJZ2HEpwnpWrUjfNthYr6812kggamG0W
         n1OA==
X-Forwarded-Encrypted: i=1; AJvYcCU7+ijoZ88UAaL3uP8HkO0ha51g4GA8ENgIsH6CNXCyV8b2P6iJGbIhtIcgFNUqv4hja8HySyQJYPwSKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyEzWxf/lJS6oBwoveGMp0dEp1Xm2srMsQlkPba0biovTTBskg
	Y+NbVWuWOoUI5TDt5pjFQKo3MhN05qKBq81DhEbn1AgTNiIucfvHEmGOKSn436E=
X-Google-Smtp-Source: AGHT+IHmQOgwVXtosc5C3zjOqsrNAr1v/lfSp7QNRqpm1iXYwNBCmnKvsMh+W3pIhyccXko0ObQGvA==
X-Received: by 2002:a05:6871:5891:b0:288:59d3:2a03 with SMTP id 586e51a60fabf-2949f07a886mr21485563fac.39.1731004056679;
        Thu, 07 Nov 2024 10:27:36 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546f3f58dsm490090fac.49.2024.11.07.10.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 10:27:35 -0800 (PST)
Message-ID: <26049689-238e-4f04-9a68-db002ed5c1e0@kernel.dk>
Date: Thu, 7 Nov 2024 11:27:34 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] bio_split() error handling rework
To: John Garry <john.g.garry@oracle.com>, song@kernel.org,
 yukuai3@huawei.com, hch@lst.de
Cc: martin.petersen@oracle.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, hare@suse.de,
 Johannes.Thumshirn@wdc.com
References: <20241031095918.99964-1-john.g.garry@oracle.com>
 <e0a82859-6c9e-43d4-b6ee-4b96fa193fa9@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e0a82859-6c9e-43d4-b6ee-4b96fa193fa9@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 11:49 PM, John Garry wrote:
> On 31/10/2024 09:59, John Garry wrote:
> 
> Hi Jens,
> 
> Could you kindly consider picking up this series via the block tree?
> 
> Please note that the raid 0/1/10 atomic write support in https://lore.kernel.org/linux-block/20241101144616.497602-1-john.g.garry@oracle.com/ depends on this series, so maybe you would also be willing to pick that one up (when it's fully reviewed). Or create a branch with all the block changes, like which was done for the atomic writes XFS support.

The series doesn't apply to for-6.13/block - the 3rd patch for bio
splitting conflicts with:

commit b35243a447b9fe6457fa8e1352152b818436ba5a
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Aug 26 19:37:54 2024 +0200

    block: rework bio splitting

which was in long before for-6.13/block, which it's supposed to be based
on?

Please double check and resend a v4.

-- 
Jens Axboe

