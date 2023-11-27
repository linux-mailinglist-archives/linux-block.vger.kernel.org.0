Return-Path: <linux-block+bounces-485-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 809C37FA5BE
	for <lists+linux-block@lfdr.de>; Mon, 27 Nov 2023 17:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3C71C20CDD
	for <lists+linux-block@lfdr.de>; Mon, 27 Nov 2023 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08887358AA;
	Mon, 27 Nov 2023 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Fvt1xH21"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17488A7
	for <linux-block@vger.kernel.org>; Mon, 27 Nov 2023 08:10:06 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35ca48d48f1so1715075ab.1
        for <linux-block@vger.kernel.org>; Mon, 27 Nov 2023 08:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701101405; x=1701706205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtIIccdhs8yz+yiJjCrLMyK2ZFy1CQEPmm7PUbEVf7I=;
        b=Fvt1xH210eU0Tp6AOVG5kL42g89qbCU+v3xMkVldRwz+w+SyT4sF2gTig63NG9An8w
         6XWxuhEmN/72kDT1VUjR8y2s7fBgFn6s4mkj652xAYasd7M0NoXsJs//fn1edF6Hy3ZN
         gX7HZDfcdR2/77zDc28YvedHmqUCgX6kiHYeoZMLPURqxb1cE015hArO7KB7DTCyt+5H
         WmSEbypw504TG4kTwmlTbx3kC1o9v4YjteytrqBUxOaEdy+qUk2D5ofW47dwCa1Y5aKO
         dzNSR05NZ1xKC3BrQf6uZ/yPI1AnawH3hgB10ikfgUwAglfJZ7WVGqBFRd+bMv+tK1pl
         tTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701101405; x=1701706205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtIIccdhs8yz+yiJjCrLMyK2ZFy1CQEPmm7PUbEVf7I=;
        b=ZNVipKHlAnJHTZLFXd2s0bGLZ1y9qS9655Kw1P59E2QMR0ewZqV3EkFYgnWeKnTzCy
         QOFPmsWOu06AZBG0Vp5O02aMaqTD4f56dzBxVgpA+DB3hNzKWFAdbrrE+8loFl8vP044
         UxZUbL3X7tuWSY9zwwB6o/G8oaBRF/rVewW/W7vEqo5TJQEW8Tq9LClUt4DGCTxqh+Xk
         R8+jp0lHbWwcB3+YTThPbkz31U5bOqy9uxdcDqYAbY5cO4pF4+6MiQZSOfH3QZrvJzgs
         8qMqyMr2Lk6mSN3/MItMO+7wqJL+s/JtNUA/g4z+LshW9EqIDvWfnBXISCcis1R/j9zJ
         /kqQ==
X-Gm-Message-State: AOJu0YzOpuhmZrbbb2r3U1OSy9/IGEcLiWBgCKr3yK6xJ2+kjYpgbUnA
	cawjQp2gdryqkiyZMMY8aWzTSXhthap/PQdKtdQQRg==
X-Google-Smtp-Source: AGHT+IG/IaqyGyROu7hEZKzZJuUB5m4Skn6QbtiicnN+TWTrcKiqLe/Y3pmcCOuwBT1U4spu+VXwcQ==
X-Received: by 2002:a05:6602:489a:b0:7b3:95a4:de9c with SMTP id ee26-20020a056602489a00b007b395a4de9cmr6090167iob.1.1701101405357;
        Mon, 27 Nov 2023 08:10:05 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c24-20020a05660221d800b007870289f4fdsm2459925ioc.51.2023.11.27.08.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 08:10:04 -0800 (PST)
Message-ID: <f2735bdc-1234-4477-a579-90bafa7ae4ea@kernel.dk>
Date: Mon, 27 Nov 2023 09:10:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Merging raw block device writes
Content-Language: en-US
To: "hch@lst.de" <hch@lst.de>, Michael Kelley <mhklinux@outlook.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <SN6PR02MB41575884C4898B59615B496AD4BFA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20231127065928.GA27811@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231127065928.GA27811@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/23 11:59 PM, hch@lst.de wrote:
> On Sat, Nov 25, 2023 at 05:38:28PM +0000, Michael Kelley wrote:
>> Hyper-V guests and the Azure cloud have a particular interest here
>> because Hyper-V guests uses SCSI as the standard interface to virtual
>> disks.  Azure cloud disks can be throttled to a limited number of IOPS,
>> so the number of in-flights I/Os can be relatively high, and
>> merging can be beneficial to staying within the throttle
>> limits.  Of the flip side, this problem hasn't generated complaints
>> over the last 18 months that I'm aware of, though that may be more
>> because commercial distros haven't been running 5.16 or later kernels
>> until relatively recently.
> 
> I think the more important thing is that if you care about reducing
> the number of I/Os you probably should use an I/O scheduler.  Reducing
> the number of I/Os without an I/O scheduler isn't (and I'll argue
> shouldn't) be a concern for the non I/O scheduler.

Yep fully agree.

-- 
Jens Axboe


