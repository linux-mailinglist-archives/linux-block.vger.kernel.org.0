Return-Path: <linux-block+bounces-8873-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FDF909011
	for <lists+linux-block@lfdr.de>; Fri, 14 Jun 2024 18:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CDA1C22373
	for <lists+linux-block@lfdr.de>; Fri, 14 Jun 2024 16:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A4116B751;
	Fri, 14 Jun 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OdPvCMXR"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361416E888
	for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382218; cv=none; b=fMcWRPWqtNcIgzwOa0wI9wA2JLq0kbDGn3hIMV2TlQRPKU+k68nAeC2SUUakaBcYPkShnFbSoyL6Pd5gT4d2+wCmOiuSJeBI2wRl7yN+J3R05pBOMCMVlVzJ3/smc0ZT74E//YcfiST6q9chI6FQUC2gmkHBplsombfdBRLresg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382218; c=relaxed/simple;
	bh=WoWOHKjU+KL6TRZLfvPcBUOFt61J2dtVf/RZIND74SM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qtc2QwY3TXOUMQMrFdaLG5kYrMDws9bFzstC9lvB+2IyXQG4Xxmpl2fnngSGaqxJ0ewRMAAdNYIrbA1PlP5pBgTfIxel8EW3uqCkr8Vbb8154O9zi/CdhAkCFqyIzGNDNsacakuQjf8w4rrHiMzj6v4dGlAGJO+KQdCaLBGFsMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OdPvCMXR; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6e85807d306so172588a12.3
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718382216; x=1718987016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3I8EQqt1crG6Q0TuvnTQoOetYt/333GlTD0SUTj3N30=;
        b=OdPvCMXRfdsJaYIdZHedxJgJo17PCN8a8/oI80S568/AbsCWOaVIU+mi+dcP9UxDZ+
         X95GNyzQhbYwc03KDwQEiod2URXHm7J3HoilBLm3hGzUNco1XbepkHIyTjvs7HgLDlfq
         V3zbO8IBvoO53wzx5+6Sb3wBAce5+yhd0wO8wm1OOws+ovGSvquQI9SHHZQ8efjo2VTd
         N+3zqPM6r/vE+F763fdqwqBvvuj5SrP641NGQKeteDsj2O82KP4SQb5uOUa710/fPfFC
         HrtG8FmiNu60l64qQpgh5Uy5h3A2+OYplo9mtqTwSQQtNDRVG7s3Qvd3z1tnFBDhB3cN
         QTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382216; x=1718987016;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3I8EQqt1crG6Q0TuvnTQoOetYt/333GlTD0SUTj3N30=;
        b=enjs3Dq85dprZr0ZgycH8m/DjXKl9BkOf+M20fzjIjF0cpkCQWUwjWe5A6CEmUreHp
         xfVDYlog7xYLrgqEvFB3qq0s9QoEtxIhyeB1kHrHVXBU7fIYi+hDEhKIKkVg0L+qKD9K
         fxNTJR1ChZDuiTVMXXX79wddt4MXeu5CQZwyFchtBBvPvb1tKqMRxwHJditaZ7Qd1lT9
         5IB36rdxqzw1hOqh1RWiiNTqlGNBsuaT31yc7mNtR/wnsGC8HYKjvYesGNh0sL1vHpKZ
         MjjEmt+rNndY17m+MtDeQxwf54Lzd/7fR/Adb9vQ68c4FKg4W0/zhULfsJkZFgxCBRIo
         a0Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU4kPBYm9ckMG5qz1M5uljz/eTthusfYLXtG2Ea8jEM0hfrMjfAjxiHEfPFH8np/vtyt+SqLP7U23JCBT5DVpgf1w/pkeqhPU367xo=
X-Gm-Message-State: AOJu0YyWrz1opU3LMZkPkByuFsi0aIg1plMRYch50oUduR7u1oLyiq4n
	2JSd/jTlawYAUim79TaTcfUwMI1Ga+c3KLP+d7ot5C8PCbZWnmX2+YaktgZwMSA=
X-Google-Smtp-Source: AGHT+IESX47a6MjNSHBX1WWMmqXAUrRz04daSkbqzpNkyc1AvtEK1pUdz6iDmWheXtCqLaPD91gHzA==
X-Received: by 2002:a17:902:d511:b0:1f3:10e8:1e0 with SMTP id d9443c01a7336-1f8627f38bbmr33817845ad.2.1718382216194;
        Fri, 14 Jun 2024 09:23:36 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f525fcsm33896755ad.294.2024.06.14.09.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 09:23:35 -0700 (PDT)
Message-ID: <2fb3fc18-64fb-4a12-9771-3685111fd19f@kernel.dk>
Date: Fri, 14 Jun 2024 10:23:33 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: move integrity settings to queue_limits v3
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20240613084839.1044015-1-hch@lst.de>
 <f134f09a-69df-4860-90a9-ec9ad97507b2@kernel.dk>
 <20240614160322.GA16649@lst.de>
 <af0144b5-315e-4af0-a1df-ec422f55e5be@kernel.dk>
 <20240614160708.GA17171@lst.de>
 <6c5d4295-098c-4dc2-8ad2-f747a205f689@kernel.dk>
Content-Language: en-US
In-Reply-To: <6c5d4295-098c-4dc2-8ad2-f747a205f689@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/14/24 10:16 AM, Jens Axboe wrote:
> On 6/14/24 10:07 AM, Christoph Hellwig wrote:
>> On Fri, Jun 14, 2024 at 10:04:28AM -0600, Jens Axboe wrote:
>>>> That sounds like you didn't apply the above mentioned
>>>> "convert the SCSI ULDs to the atomic queue limits API v2" series before?
>>>
>>> That might indeed explain it... Surprising it applied without.
>>
>> Also as mentioned a couple weeks ago and again earlier this week,
>> can we please have a shared branch for the SCSI tree to pull in for
>> the limits conversions (including the flags series I need to resend
>> next week) so that Martin can pull it in?
> 
> For some reason, lore is missing 12-14 of that series, which makes applying
> it a bit more difficult... But I can setup a for-6.11/block-limits branch
> off 6.10-rc3 and apply both series, then both scsi and block can pull that
> in.

Done, both series are in for-6.11/block-limits. It's pulled into the main
block branch as well, but SCSI can pull it too as needed.

-- 
Jens Axboe



