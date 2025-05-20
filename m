Return-Path: <linux-block+bounces-21836-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B4BABE156
	for <lists+linux-block@lfdr.de>; Tue, 20 May 2025 18:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1858C152A
	for <lists+linux-block@lfdr.de>; Tue, 20 May 2025 16:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD282472A4;
	Tue, 20 May 2025 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UQ8MXIB4"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0DA257AFB
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760174; cv=none; b=sq/qtlDPLag109cyDhoH93HeN1jsD5MNWBNYAz/Z+9rdCCQNx2iyIh6gu6vM4bz4mGalL0oLPlcf1C4STwdzPUbNYINv4ZbXOeLCcQ7wz+5Lv1T74NfApIX6W5tjT69+D5PA+GknOf7BE8iiSMdpbDfLXgnT+W++sbSfIcjz7hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760174; c=relaxed/simple;
	bh=wb9jveR8gfrm/HLOmEI3ZVUiaVgfP80NHuLXY6U2rvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rk9yFTjQNZWVMLjWolSZ//w0x0mA5mtsV3BweISI5p2aTl2NrYruB1OOI61lArEVsGFFl9D4Po03YDRmlocKxGq4Z++O7lgKJ8vqW3cyFxA9500VWethDj9iJ6tFJJboOeEi0EuETC0HzenJuOQoER/LCBGlBxAJ8n7MKJZCd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UQ8MXIB4; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3dc7ffeb9b8so2162525ab.2
        for <linux-block@vger.kernel.org>; Tue, 20 May 2025 09:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747760170; x=1748364970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9+I4gTPT9Nr19IG2h0bYwR+TaspSdeGh5uzYNeV/gxE=;
        b=UQ8MXIB4zpYUk3VPcQfuuIS+NoTEux8yivljyuzPVnqf6JFkd3ckEmgKgF4KWQWNH7
         icZffsJpuMtgrCPymTT+TuTUNPdYUh6WPUe6WQQUMYyv4dOvtm5pYrVMXWA/FNRtkyNq
         7nVS128jCoIchq+3auu5wAFRY1E8fxyWrnsp5xwvQiC9hhAJWyniF4r8z/CErreE84XA
         ifrI3NNfqpHWL1Bufd+uEaTfZ0cA4bHWbb40dOphGOm1FscwxUECRYLNm49B903nEjQf
         kLQks2zMsgp8fRdTHw8usAZQ5zvBzVfXhpsm1/N6JvbppVJX/MYrfSaekue4lYUKCKT2
         JvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747760170; x=1748364970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+I4gTPT9Nr19IG2h0bYwR+TaspSdeGh5uzYNeV/gxE=;
        b=wWaB/pETFFc+Lx7ftNIfRWm4sjGR0BpRQgJQuYUVR1AxzNbZZrxTgeqMvntrWAoH6J
         DuS3o2zdayHFgZbO8S6E5dsBJJsIutmZ18xVI+kuNoE8HLVQHTKZrO+9z6bOjEOIE9OL
         i3A6dTYWjNoRiw359/quruTpbbt4vAalPHZ0qJdo5pp6RHViZtInllKVrQt9B8UTfR4K
         Mk9+txU0yVLWDrGQ6uopsRDHMIAF1jOezrOg4YP+xAjNzNn4LXDAPHRHjKVmfr0Ycy/F
         n8UuEGVMTnB7y2UHUyUtdUiFCIzPXUfX0PVD7QwMij1aKht+8edXyot5Z3dhvcY2jX7k
         C1rA==
X-Forwarded-Encrypted: i=1; AJvYcCW9AMRQMtb+yc5gK1ZGaxgpcPiioURTEXxAt/LhxDJS9uk2rteQGC72Ux96uXNE2Qjtsb2NULq40pJG1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6qmj36ilL6uocwAGWGtRAjQ3biN8mBEQPWQwz4AJOE25mmEer
	7qKQq0+s2B+VTfGSt5fP+erwRo7ZoCtw6gE74BYVcFS0OalqlqNPhw4MmPjlIwP1EeE=
X-Gm-Gg: ASbGncvLJsEMxG6ELlWVyLjygE34Yzpgi2QtLG2jwalFiTGl27AO8QpKMaaXDdJ3l3t
	3jouMknKAkD3r56Ib/8Mx4ThO5pYiaWZHnOzE0EbQaK/XwDCVp0D108RGzyoFo4FMVlGZHMZYC5
	jkRoQ+TCvORUq+eTFvyYJMlHle3mbPIxdFrO4a1wV8A7+j/5VjWJJYu1Mjx8dE4pGbxkusSezhk
	3yoSlzLcn/VPMtyepqxaJO4AFso632cOQLrn7rGKQClcraS6mqWnZg/IlOskjDoEP7kem13UKR7
	B9yCMMLrQA6/OUX0xIq3jnwN/15kkoXg5N7hgp+DkkzpMG0=
X-Google-Smtp-Source: AGHT+IFGEk6WV38wfO2fNFtvLWC8v+J/V3qGJaKnt61cz/eASxvGslO2+1tn3+3paF9Jj9ay2Bch9Q==
X-Received: by 2002:a05:6e02:1909:b0:3dc:76ad:7990 with SMTP id e9e14a558f8ab-3dc76ad7baamr61593435ab.15.1747760170063;
        Tue, 20 May 2025 09:56:10 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3b1c90sm2302153173.56.2025.05.20.09.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 09:56:09 -0700 (PDT)
Message-ID: <7708ccbe-f967-4910-8a73-bb66bbca214e@kernel.dk>
Date: Tue, 20 May 2025 10:56:08 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rbd: replace strcpy() with strscpy()
To: Alex Elder <elder@ieee.org>, Siddarth Gundu <siddarthsgml@gmail.com>,
 idryomov@gmail.com, dongsheng.yang@easystack.cn, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250519063840.6743-1-siddarthsgml@gmail.com>
 <f92ddea4-edf1-42f9-a738-51233ce3d45e@ieee.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f92ddea4-edf1-42f9-a738-51233ce3d45e@ieee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/20/25 10:44 AM, Alex Elder wrote:
> On 5/19/25 1:38 AM, Siddarth Gundu wrote:
>> strcpy() is deprecated; use strscpy() instead.
>>
>> Both the destination and source buffer are of fixed length
>> so strscpy with 2-arguments is used.
>>
>> Introduce a typedef for cookie array to improve code clarity.
>>
>> Link: https://github.com/KSPP/linux/issues/88
>> Signed-off-by: Siddarth Gundu <siddarthsgml@gmail.com>
>> ---
>> changes since v1
>> - added a typedef for cookie arrays
>>
>> About the typedef: I was a bit hesitant to add it since the kernel
>> style guide is against adding new typedef but I wanted to follow
>> the review feedback for this.
> 
> I personally think the typedef here is the appropriate.  But
> it's really up to Ilya whether he likes this approach.  Get
> his input before you do more.

In any case, this should be 2 patches at that point, not collapsed
into one patch.

-- 
Jens Axboe


