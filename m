Return-Path: <linux-block+bounces-13234-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 392559B63F4
	for <lists+linux-block@lfdr.de>; Wed, 30 Oct 2024 14:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE431F22929
	for <lists+linux-block@lfdr.de>; Wed, 30 Oct 2024 13:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328B061FFE;
	Wed, 30 Oct 2024 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nRhcURT1"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3033817579
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294454; cv=none; b=YI6lkND/cU3p6uW8S3vnJETLOk6B/SsKvPyXCt2OEjIHMBsBlzOSIbb9XJO81RvUteTDiMKxPc+cUZ87U+40DUBffM5ajKXjsWZViRvlQr9/2NgliG10U5Dc4SxPgr0i86dpTmpd0duRzd4LemuYLo++1bOJCv+AlJbkE4FUn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294454; c=relaxed/simple;
	bh=V2WPzvbbzQfgwMPqDzWNQTTXVsQclLVGxXXHSG2cCNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAslIWVz5/056jdEaBeHb49iWM2vesvc9Esu/fFIRatvs99XHpInaPdb9nAfp8IPS6Amxxb9Mh1sRL5BxclTSo6wtJ58SU7EOrlrVJUJWiMlxsjOXO9Ls1Y5J46lx716lXmHvQ3szP5mB4gcSLLw+ohFzvZNvXcWr+hEoLgqty4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nRhcURT1; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83abf71f244so218796439f.1
        for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 06:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730294451; x=1730899251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=adEXhwMuT7QHQGAB5KoTePWRnBbGG1A5V3HCE+rDC+o=;
        b=nRhcURT1AraPTZ0t2yvM6LqmMSOkCqYedi7vPWrPvC1LXynylZBn8gqQM6z1VySTzJ
         EzzOtM41qobpejSVIUiNmhd8OCPCw4ZFIwPkouQxXf/kgGl+UsjygV3Au9o/6+Ffd/xz
         vybWRP6QquJwqZ/qgQpSfgrrWv6QgnIsPMAHDQyEnVNYtpyoa8EYyYKV77WSSlYpY3Kf
         Vhk9oqFNFaUTY/XXigSgjV+MQ91wNNsytA0ii0BIWZubUdHyLxsYQB4gW9YSoa6cMA/r
         bMhSmhffGbbD4n8MTJHV1e2ZEEqLKGfsyfqYx4E41yWIIzsQE4cM5cnPu+oLEcpzSTW0
         yrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294451; x=1730899251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adEXhwMuT7QHQGAB5KoTePWRnBbGG1A5V3HCE+rDC+o=;
        b=abPo7yER4TBaNgmyMfUFNaKvyqVljKLAe+mwF4k7XX633MxrBm4SNEOIFZHgHwAhWL
         m14xAxj1hxa3bV9mK5ttnaJR+Tpm+QHIE+usgGpiEULR+WUWrQUZsYTXSJJ8hnKdP2h0
         35z4bHbXpk/P1A5NrWFsOYKjKk8ksQ3kKy2FW//sSK4Zc6mkTNq0C4fz4pN+dxDMuryl
         j5wy339GPsUM3eSCQXSMn/k14v8XUuM6gpUCRy/APnkt5vWGJiUj5RlOt3kuAxch0cPH
         /SsqnbKEe+r5X3+K4+lcc0Cw5EgkXlta/ayMWjlm+tdtYh50bt1lqgqwz4MTN8QwLE6L
         8I3g==
X-Forwarded-Encrypted: i=1; AJvYcCU9XOSRaiFX0CLTbaN75HI8NsAh7PPZFqq86zbpe1GeIlJtFJd1ayLntu10/OxHNvcDYhsCMhju/IpGhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFOuEs7NNmvrzdYgLfKE1zRbLb1hJghr0TkKZcYKJXrzth9sxZ
	7cVeXWsRivrAw+g5h1Dldh4xY0w6/Ir4Lq8SlawoeUEirkTqJGqBngLJmp7p6sI=
X-Google-Smtp-Source: AGHT+IE1gya8DOKv02mrGw2idtxQZHTZ4tVr3O33fc42BDUiQhAjx67dZQQUsUaBW8z5Sau94zjOGA==
X-Received: by 2002:a05:6602:6343:b0:83b:29a5:ff89 with SMTP id ca18e2360f4ac-83b29a602bamr1106197239f.15.1730294451146;
        Wed, 30 Oct 2024 06:20:51 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc727ae9cdsm2840996173.158.2024.10.30.06.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 06:20:50 -0700 (PDT)
Message-ID: <d986221d-7399-4487-9c28-5d6f953510cd@kernel.dk>
Date: Wed, 30 Oct 2024 07:20:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 0/8] io_uring: support sqe group and leased group kbuf
To: Ming Lei <ming.lei@redhat.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>,
 Akilesh Kailash <akailash@google.com>
References: <20241025122247.3709133-1-ming.lei@redhat.com>
 <15b9b1e0-d961-4174-96ed-5a6287e4b38b@gmail.com>
 <d859c85c-b7bf-4673-8c77-9d7113f19dbb@kernel.dk>
 <bc44d3c0-41e8-425c-957f-bad70aedcc50@kernel.dk>
 <e76d9742-5693-4057-b925-3917943c7441@kernel.dk>
 <f51e50c8-271e-49b6-b3e1-a63bf61d7451@kernel.dk> <ZyGT3h5jNsKB0mrZ@fedora>
 <674e8c3c-1f2c-464a-ad59-da3d00104383@kernel.dk> <ZyGjID-17REc9X3e@fedora>
 <ZyGx4JBPdU4VlxlZ@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZyGx4JBPdU4VlxlZ@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 10:11 PM, Ming Lei wrote:
> On Wed, Oct 30, 2024 at 11:08:16AM +0800, Ming Lei wrote:
>> On Tue, Oct 29, 2024 at 08:43:39PM -0600, Jens Axboe wrote:
> 
> ...
> 
>>> You could avoid the OP dependency with just a flag, if you really wanted
>>> to. But I'm not sure it makes a lot of sense. And it's a hell of a lot
>>
>> Yes, IO_LINK won't work for submitting multiple IOs concurrently, extra
>> syscall makes application too complicated, and IO latency is increased.
>>
>>> simpler than the sqe group scheme, which I'm a bit worried about as it's
>>> a bit complicated in how deep it needs to go in the code. This one
>>> stands alone, so I'd strongly encourage we pursue this a bit further and
>>> iron out the kinks. Maybe it won't work in the end, I don't know, but it
>>> seems pretty promising and it's soooo much simpler.
>>
>> If buffer register and lookup are always done in ->prep(), OP dependency
>> may be avoided.
> 
> Even all buffer register and lookup are done in ->prep(), OP dependency
> still can't be avoided completely, such as:
> 
> 1) two local buffers for sending to two sockets
> 
> 2) group 1: IORING_OP_LOCAL_KBUF1 & [send(sock1), send(sock2)]  
> 
> 3) group 2: IORING_OP_LOCAL_KBUF2 & [send(sock1), send(sock2)]
> 
> group 1 and group 2 needs to be linked, but inside each group, the two
> sends may be submitted in parallel.

That is where groups of course work, in that you can submit 2 groups and
have each member inside each group run independently. But I do think we
need to decouple the local buffer and group concepts entirely. For the
first step, getting local buffers working with zero copy would be ideal,
and then just live with the fact that group 1 needs to be submitted
first and group 2 once the first ones are done.

Once local buffers are done, we can look at doing the sqe grouping in a
nice way. I do think it's a potentially powerful concept, but we're
going to make a lot more progress on this issue if we carefully separate
dependencies and get each of them done separately.

-- 
Jens Axboe

