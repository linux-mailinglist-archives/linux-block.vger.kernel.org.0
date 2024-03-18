Return-Path: <linux-block+bounces-4610-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8C687E1C4
	for <lists+linux-block@lfdr.de>; Mon, 18 Mar 2024 02:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72147283097
	for <lists+linux-block@lfdr.de>; Mon, 18 Mar 2024 01:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C011E894;
	Mon, 18 Mar 2024 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ecGXhTeJ"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC71DFC7
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725677; cv=none; b=T4uU70N0FMnTbDOmHE9zXrE+y/EFa8nOFdzAncK8Don2aMtMYHP6BJW+F3HxDuCFMxA+EEjHVehuK3Rlj46o/KuPjl4Y3xbq8+u41/abQ4JsCqftCl3HUtHIpoT/wowJjcdfVenzWRBrnU7QPBXgQgvBA3xuyidlvDOAagfiXsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725677; c=relaxed/simple;
	bh=MJtB2mB10Ma25y7CMmu8ng3n367foS4b19Z6p5/h0wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGdOULjoLR4ik0RhdzKf502OeWln2PJCjgJn3oo/eDhEmP1X7w+7uXLCZkmh9hPgpbiGwkmaa2HI2K+G0W7XuwDUDi1GAx/j3iB1Hul2gxLHfOnLwCFLQ9Y/mYYNIyQoOdFrccOZw99a/BGzLSyh3s5cd0MozkEd+cJF+7iQuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ecGXhTeJ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29c572d4b84so1402849a91.1
        for <linux-block@vger.kernel.org>; Sun, 17 Mar 2024 18:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710725673; x=1711330473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkRJQ3yOV+B8i49Y8S+i+W2OsC6nj6PC6yFzUPg8TEw=;
        b=ecGXhTeJ7vK4U8Qjyfs6glO0msGILFGtuiOfBaCctQuhQ12cqB2xeU0Pfttb7HU9Ab
         cqAAoNv5mZiAr+looA7v4eK8xTKYAwOI8epOEhvrRdpLeShBIqfNInbvVBemJZhjZBg/
         NXROCXzFzenlMDh4y2RQo6oirKbuKM01LmqvilvxuvK3VDaA33yjHAZuFFWf0d9VshS2
         6fpqLm2nBVoVsfXbswCT1uNmHOYqc4CrFw4OuUF0bB+IDBMipakdxjrrNVU/MUNIT3pf
         2cGiH1KGaYdyeBu0VHjLRaPQexQVBiFvZ3I+aQiHZkrf/bKHy3kfoOwiY39byrehV8ZZ
         w/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710725673; x=1711330473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkRJQ3yOV+B8i49Y8S+i+W2OsC6nj6PC6yFzUPg8TEw=;
        b=Y7a/eBcTQKi8VZXnHScmzI0kQRcxoVTYSHRF9PdazeJMcMBb8Vw9f96WwQT6f9P4qN
         njD7kWTPSB3ibNE4TEXF+kl2LFoibKYY46o3EYik0d2cZPITdyHbFnqSG7uB7k1f0gor
         JgP6HK1hXN9zPx/h3UmO4au+EyXWhY4Z+L8QrFa8Hw1PuNHElz/CurrHM1SkQteAdry0
         oECqNLVA8PLEH9GesFGDezwThc1L6CPI0GzMGJ0SvBK59glgZsIrxc0PXqQYxQNwDbxr
         xmPLKRtUfiI53+wLOCqumskqQdjd3oQiT3PjfQQ9F0A3kjKhywiWPuDWfrfEnVnsm1z9
         StZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCAkglFAUhcqERpHZs4cwBDf0vMbsIBfIZlaJNNlgkZuLbx448mOYZZm64IeqGEt2NZxi7K1b6jn93+L2ZV01NP4/VyVyl43smteY=
X-Gm-Message-State: AOJu0YwvcQ4Aj6qs4339thvXY4zYt8w68fcJmO3barWlD6Pjhvq6LuF+
	gPATl2OnytT62h1XPWU0na+y2tlE9QCB+QO1ZruzzvgFRqekZprJraELuXntYqs=
X-Google-Smtp-Source: AGHT+IGKQdXsAKwlz+k7HamlNCmxV0ZQfbvWTsHQKfQgtcbTh9z/M3iGYsAmNTkR1zzhWMHWAGdQCg==
X-Received: by 2002:a17:903:186:b0:1dd:6f1a:2106 with SMTP id z6-20020a170903018600b001dd6f1a2106mr14067111plg.0.1710725672973;
        Sun, 17 Mar 2024 18:34:32 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id o11-20020a170902d4cb00b001dedfc0b9f3sm6005363plg.177.2024.03.17.18.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 18:34:32 -0700 (PDT)
Message-ID: <1e05aee5-4166-4e5d-9b76-94e1d833ab17@kernel.dk>
Date: Sun, 17 Mar 2024 19:34:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 00/11] remove aux CQE caches
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <ZfWk9Pp0zJ1i1JAE@fedora>
 <1132db8f-829f-4ea8-bdee-8f592b5e3c19@gmail.com>
 <e25412ba-916c-4de7-8ed2-18268f656731@kernel.dk>
 <d3beeb72-c4cf-4fad-80bc-10ca1f035fff@gmail.com>
 <4787bb12-bb89-490a-9d30-40b4f54a19ad@kernel.dk>
 <6dea0285-254d-4985-982b-39f3897bf064@gmail.com>
 <2091c056-d5ed-44e3-a163-b95680cece27@gmail.com>
 <d016a590-d7a9-405f-a2e4-d7c4ffa80fce@kernel.dk>
 <4c47f80f-df74-4b27-b1e7-ce30d5c959f9@kernel.dk>
 <4320d059-0308-42c3-b01f-18107885ffbd@kernel.dk> <ZfeHmNtoTo9nvTaV@fedora>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZfeHmNtoTo9nvTaV@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/24 6:15 PM, Ming Lei wrote:
> On Sun, Mar 17, 2024 at 04:24:07PM -0600, Jens Axboe wrote:
>> On 3/17/24 4:07 PM, Jens Axboe wrote:
>>> On 3/17/24 3:51 PM, Jens Axboe wrote:
>>>> On 3/17/24 3:47 PM, Pavel Begunkov wrote:
>>>>> On 3/17/24 21:34, Pavel Begunkov wrote:
>>>>>> On 3/17/24 21:32, Jens Axboe wrote:
>>>>>>> On 3/17/24 3:29 PM, Pavel Begunkov wrote:
>>>>>>>> On 3/17/24 21:24, Jens Axboe wrote:
>>>>>>>>> On 3/17/24 2:55 PM, Pavel Begunkov wrote:
>>>>>>>>>> On 3/16/24 13:56, Ming Lei wrote:
>>>>>>>>>>> On Sat, Mar 16, 2024 at 01:27:17PM +0000, Pavel Begunkov wrote:
>>>>>>>>>>>> On 3/16/24 11:52, Ming Lei wrote:
>>>>>>>>>>>>> On Fri, Mar 15, 2024 at 04:53:21PM -0600, Jens Axboe wrote:
>>>>>>>>>>>
>>>>>>>>>>> ...
>>>>>>>>>>>
>>>>>>>>>>>>> The following two error can be triggered with this patchset
>>>>>>>>>>>>> when running some ublk stress test(io vs. deletion). And not see
>>>>>>>>>>>>> such failures after reverting the 11 patches.
>>>>>>>>>>>>
>>>>>>>>>>>> I suppose it's with the fix from yesterday. How can I
>>>>>>>>>>>> reproduce it, blktests?
>>>>>>>>>>>
>>>>>>>>>>> Yeah, it needs yesterday's fix.
>>>>>>>>>>>
>>>>>>>>>>> You may need to run this test multiple times for triggering the problem:
>>>>>>>>>>
>>>>>>>>>> Thanks for all the testing. I've tried it, all ublk/generic tests hang
>>>>>>>>>> in userspace waiting for CQEs but no complaints from the kernel.
>>>>>>>>>> However, it seems the branch is buggy even without my patches, I
>>>>>>>>>> consistently (5-15 minutes of running in a slow VM) hit page underflow
>>>>>>>>>> by running liburing tests. Not sure what is that yet, but might also
>>>>>>>>>> be the reason.
>>>>>>>>>
>>>>>>>>> Hmm odd, there's nothing in there but your series and then the
>>>>>>>>> io_uring-6.9 bits pulled in. Maybe it hit an unfortunate point in the
>>>>>>>>> merge window -git cycle? Does it happen with io_uring-6.9 as well? I
>>>>>>>>> haven't seen anything odd.
>>>>>>>>
>>>>>>>> Need to test io_uring-6.9. I actually checked the branch twice, both
>>>>>>>> with the issue, and by full recompilation and config prompts I assumed
>>>>>>>> you pulled something in between (maybe not).
>>>>>>>>
>>>>>>>> And yeah, I can't confirm it's specifically an io_uring bug, the
>>>>>>>> stack trace is usually some unmap or task exit, sometimes it only
>>>>>>>> shows when you try to shutdown the VM after tests.
>>>>>>>
>>>>>>> Funky. I just ran a bunch of loops of liburing tests and Ming's ublksrv
>>>>>>> test case as well on io_uring-6.9 and it all worked fine. Trying
>>>>>>> liburing tests on for-6.10/io_uring as well now, but didn't see anything
>>>>>>> the other times I ran it. In any case, once you repost I'll rebase and
>>>>>>> then let's see if it hits again.
>>>>>>>
>>>>>>> Did you run with KASAN enabled
>>>>>>
>>>>>> Yes, it's a debug kernel, full on KASANs, lockdeps and so
>>>>>
>>>>> And another note, I triggered it once (IIRC on shutdown) with ublk
>>>>> tests only w/o liburing/tests, likely limits it to either the core
>>>>> io_uring infra or non-io_uring bugs.
>>>>
>>>> Been running on for-6.10/io_uring, and the only odd thing I see is that
>>>> the test output tends to stall here:
>>>>
>>>> Running test read-before-exit.t
>>>>
>>>> which then either leads to a connection disconnect from my ssh into that
>>>> vm, or just a long delay and then it picks up again. This did not happen
>>>> with io_uring-6.9.
>>>>
>>>> Maybe related? At least it's something new. Just checked again, and yeah
>>>> it seems to totally lock up the vm while that is running. Will try a
>>>> quick bisect of that series.
>>>
>>> Seems to be triggered by the top of branch patch in there, my poll and
>>> timeout special casing. While the above test case runs with that commit,
>>> it'll freeze the host.
>>
>> Had a feeling this was the busy looping off cancelations, and flushing
>> the fallback task_work seems to fix it. I'll check more tomorrow.
>>
>>
>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
>> index a2cb8da3cc33..f1d3c5e065e9 100644
>> --- a/io_uring/io_uring.c
>> +++ b/io_uring/io_uring.c
>> @@ -3242,6 +3242,8 @@ static __cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
>>  	ret |= io_kill_timeouts(ctx, task, cancel_all);
>>  	if (task)
>>  		ret |= io_run_task_work() > 0;
>> +	else if (ret)
>> +		flush_delayed_work(&ctx->fallback_work);
>>  	return ret;
>>  }
> 
> Still can trigger the warning with above patch:
> 
> [  446.275975] ------------[ cut here ]------------
> [  446.276340] WARNING: CPU: 8 PID: 731 at kernel/fork.c:969 __put_task_struct+0x10c/0x180

And this is running that test case you referenced? I'll take a look, as
it seems related to the poll kill rather than the other patchset.

-- 
Jens Axboe


