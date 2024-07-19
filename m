Return-Path: <linux-block+bounces-10103-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E45937434
	for <lists+linux-block@lfdr.de>; Fri, 19 Jul 2024 09:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96372282B7E
	for <lists+linux-block@lfdr.de>; Fri, 19 Jul 2024 07:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2804AEEA;
	Fri, 19 Jul 2024 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyWoB0XO"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91FC1799B
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721373252; cv=none; b=d4fEwIXHltb5BYdRGFkwczFGE36+PuEAvZc39cixCeX/8s7eHorYQLdi5us0rzRQ78sFZhGvLMiLDFYUhDqmZBhSOpm23fUBdMxLR0TsRzT2bBGdiK07vVsNiCtn2aujTI3Cv5f5+wymUjV6WQoQlLWgl2tctEjgnthLPL9JQlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721373252; c=relaxed/simple;
	bh=NR/l22+8F43M9Olq6hu5LdffsnSk0CAPqIAnTk6oJXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4NCe2PgZs2STU0w/0HBcTeL9W7oKy71u9FZLcKknGvUmWcKjSqZ97rvc+t4DmdA94EiMAfVOoyrawqBpJ4k6SjRWYGf/AtpFZaIxuxjkIBEbQQ3bXQOjyolCxkAvzIexYkmc3bBI5/5AJCerMVNAv5NcCM/xZi5RJHnxi57wTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyWoB0XO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a79fe8e6282so177971366b.2
        for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 00:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721373249; x=1721978049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z7XXjcpefHjY4dKKfeHxLjkWmYGZ0fCgxRRsIqcwpK0=;
        b=JyWoB0XO4+V93+qtQQ0CLa02uXYWYkpVdRrPL/iglx277xJRYgDUN9IGJr4jL06tMk
         waPBsjEBzITqDAqUyz+gfTL9I7wQrIjSuB+zlzfCn5NLPM3vckl3frHCskrriJkzQ/CF
         Qw8Ho2pmDfVFMRZamDwuYsfKnQVv+t5G3gqQ8T2Gc3Ncdos0nP3yUK4BV2YKwMY8TUOO
         9ADGMSX70/RwVcFOW4Xof2ZrjHEHqejdzq+GmvroeXkCSqzsLz4YXViljMksZ//LfmCK
         wkizT8EkHT7xoJeynuK+ROuH7l2c1ZFESArwUQz5rmFpDJg0P92GYN3eW/0BMf9jJc+7
         ZdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721373249; x=1721978049;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7XXjcpefHjY4dKKfeHxLjkWmYGZ0fCgxRRsIqcwpK0=;
        b=vNu479cOIalLRwKuOmk1ITj79WOUE9mpBDmSUK/XgBHTYiAWRwLhEDHwdFKlbcFeY1
         GMGidWDKji45/rowtNpNW5jWanQiK441q7H0v1bySyxopxSZj3d2E74EeDsGL0+f7UGv
         4A10RHWW0wpJjBKrr6hy2aiYAV+BTm0i3kREFT0Mupj17A3vAr27gWGEmu/pVKoyST4E
         GVpinvYHO2Eu87lsL8FVc4mdYgmA4LGF9SdkzGIsh/zsR5qVo9WVGVBFBWA6OD+1f7nm
         pcXP/aKE2Vl/Bc0FckH8bbV5X3UrLEFHh4VELCiwrxW4V5TW06OyyrZ/CJyYXrurT1Ti
         rnzA==
X-Forwarded-Encrypted: i=1; AJvYcCX3iz36K7iRS/uKYMRBkG2qtKlmkqhNakRVCerVAmpV7yPQ0W5P17PN/MWm3dJjwx3k11xPdSuB6A78ljDHXzSB2JdanOpZB1tGghA=
X-Gm-Message-State: AOJu0YzJBaly7jxj1jhCuZLbQP8LvskCOIRUCL4abZD6RgUiulCpdGwt
	/ywJCR1eGH7gSg3AI5RUhLwnv2ZRwi8NCxN/5L6AgeH6y0Vt2D7S
X-Google-Smtp-Source: AGHT+IFRkNV61tQuxWW/7ZtR1+cnQS2dnSE7f81DsPX6e+9QfeL5QAOyS+74/mybckg7KsrK8mRksg==
X-Received: by 2002:a17:906:48c5:b0:a77:c548:6457 with SMTP id a640c23a62f3a-a7a011e514bmr503027466b.25.1721373248501;
        Fri, 19 Jul 2024 00:14:08 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a33a81399sm65857666b.19.2024.07.19.00.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 00:14:07 -0700 (PDT)
Message-ID: <b53ffb90-096f-41f6-b7be-ecbe8e8ac786@gmail.com>
Date: Fri, 19 Jul 2024 09:14:06 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2] dm/002: avoid device access by udev at
 dmsetup remove
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev
Cc: Bart Van Assche <bvanassche@acm.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Bryan Gurney <bgurney@redhat.com>
References: <20240719042318.265227-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20240719042318.265227-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/19/24 6:23 AM, Shin'ichiro Kawasaki wrote:
> The test case dm/002 rarely fails with the message below:
> 
> dm/002 => nvme0n1 (dm-dust general functionality test)       [failed]
>      runtime  0.204s  ...  0.174s
>      --- tests/dm/002.out        2024-06-14 14:37:40.480794693 +0900
>      +++ /home/shin/Blktests/blktests/results/nvme0n1/dm/002.out.bad     2024-06-14 21:38:18.588976499 +0900
>      @@ -7,4 +7,6 @@
>       countbadblocks: 0 badblock(s) found
>       countbadblocks: 3 badblock(s) found
>       countbadblocks: 0 badblock(s) found
>      +device-mapper: remove ioctl on dust1  failed: Device or resource busy
>      +Command failed.
>       Test complete
> modprobe: FATAL: Module dm_dust is in use.
> 
> This failure happens when udev opens the dm device at "dmsetup remove"
> command. To avoid the failure, call "udevadm settle" before the "dmsetup
> remove" command.

I think udevadm settle is overkill as it waits for everything, not only that device.

Did you consider to use "dmsetup remove --retry <dev>"? This is one
liner and you do not need to implement the retry yourself.

We have many such situations in cryptsetup tests and --retry was enough
to fix it (as the busy comes usually from blkid scan that is fast enough).
It will print a few benign messages while retrying, though.

(Just a hint, I am not nacking the patch :)

Milan

> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> This patch addresses a failure found during the debug work for another
> dm/002 failure [1]. Per discussion on v1 patch [2], do "udevadm settle"
> instead of retrying "dmsetup remove".
> 
> [1] https://lore.kernel.org/linux-block/42ecobcsduvlqh77iavjj2p3ewdh7u4opdz4xruauz4u5ddljz@yr7ye4fq72tr/
> [2] https://lore.kernel.org/linux-block/o5wik4yvo2teffpjlwycbaek6znrtde5kml3hkof5r2w5rxttj@bhokt2ksdcbj/
> 
>   tests/dm/002 | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/dm/002 b/tests/dm/002
> index fae3986..afa174a 100755
> --- a/tests/dm/002
> +++ b/tests/dm/002
> @@ -37,6 +37,7 @@ test_device() {
>   	sync
>   	dmsetup message dust1 0 countbadblocks
>   	sync
> +	udevadm settle
>   	dmsetup remove dust1
>   
>   	echo "Test complete"


