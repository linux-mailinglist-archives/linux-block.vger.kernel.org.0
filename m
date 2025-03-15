Return-Path: <linux-block+bounces-18479-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE12A630EB
	for <lists+linux-block@lfdr.de>; Sat, 15 Mar 2025 18:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD7E3B2FB0
	for <lists+linux-block@lfdr.de>; Sat, 15 Mar 2025 17:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A27D63CB;
	Sat, 15 Mar 2025 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UW8BkNu4"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72587202F96
	for <linux-block@vger.kernel.org>; Sat, 15 Mar 2025 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742060614; cv=none; b=sIuLtuX+wmbyoDdcdryxWfe4wcAfbcflKWU68AkRi8aGcQvRJf4FOfQDFAR2BChm6+1ar3S/ZoMfqsUZ+Qm4+eyW3hubhSTkiDUdHS1x2ZjSmC/r3ogvtgjhZVNp0szDJ2FrziaKuD2TIt2EuqtQTJLAV+4RbnR/R4OMKfA6pyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742060614; c=relaxed/simple;
	bh=8B7FabHqskcxfIkIahGna3Z/xLvt6pUmxe4pzSfQ70c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLwxB42gPgF8TiplxAmH6nUXxMf391KKDS7HyX9BrZnHzcR1j0z27w+L8iH/tYVfK9+rvtoJAVFXB9g0fMUGFHaaS+Q4FjZH7pkTmZ4KN1DjHX5DSDaP4BUrJ343j8dXy0tMsiwFATMzMM0rH+gZsaUX1oB6FryytUWfy3EMVho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UW8BkNu4; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-855fc51bdfcso135956739f.0
        for <linux-block@vger.kernel.org>; Sat, 15 Mar 2025 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742060611; x=1742665411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5mrlT3xIGjuTGv63EX5DNH3FIcnEnf1rv9hzQbUYWjQ=;
        b=UW8BkNu4y0if2VQ+24TBVgG+wlc/YZWIBHOC96ZITbMYWS6+DsZx1TQu82VVxa8rE4
         SnnKkN6ki4mVEQ53AF6cBuOgzadlr7AyB8TE7zyC2vXiJAbFdjkzNno7iPKJiT7FUgru
         CZg4gCulIj1g64WKn2+3Lw2gqE/9y57AwqBj67au8qbEZ2W9j0gRsmX8X5i6qjmiCvbe
         LcON80KExO11FvLqMHztexsOjojdctLSmM3DNPMGU6gALHLQqnJxAk+0d+mh4xmB8Agg
         SEVTSEHFihmprMc1UJI8hRdZiK4QBXBwXDvh6fIWnt9lHxJ44dgsArtNjIU1Ttnh5kLu
         DScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742060611; x=1742665411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mrlT3xIGjuTGv63EX5DNH3FIcnEnf1rv9hzQbUYWjQ=;
        b=k5ApVzUv63pdf7eY4rXPFGbUDxdiQy6a4hToikm0fy506tqhfeCOv6uGm6I4OJmoPA
         yn6E37o02ttzsFplNKyyGWuxTosNuGoZtbV8aDLwttklBq98sZfnyg5+rP0ZaznTcQr/
         ai3vImuF7hKeiW660ncT21gl8HyHCzuHFx1uqafwpLzQDAGeDi1xp4IAt2rGq2wqZmBb
         +1XUyG+CqVI80Q/zraI2zc6m9A6WA5F7C0iRSf2iC6AHBnv7V3ogMn+sKWPbwOIPiGrE
         25AumvE+x/5/XZFEEBGSP4J5bSFKpH3LtfLdwGwqBRkHk2cTwxjnKllp80MczrCOfVeB
         tljg==
X-Forwarded-Encrypted: i=1; AJvYcCWfMpgoMJ7o5zPZPvCt0FAla9cEmFVaxsT5kTIG3EGy6QjQyOmgFoj4omMoW96F6iVbeEQKPPkMCPQ5uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YysNSNQCWCFz1hX9VLBkHms/J2J5H6ZS4kieSrcxI8a0YKcqzPK
	6LWkvK4pci1ZGtc/lsfKzZl/WUvW+9ni7kUOhZaHK/NxyreYnWkwWQPsqSciGE8=
X-Gm-Gg: ASbGnctMkxqgTD7mH0vyqd1RG2hCcMYZnIsJy6MqP77XZS76F886tBlsKpI1F0a4hTK
	Lr1sKW1LfOnEUXHpXqFKzWnC0eJ4L1H+Q5rGL0ywl9IjxRQ/4d0xVGat2R7g4d5UiqJaPwYi1+Y
	fNBkWSzNwnI0t24gY7JzymG+jTclcKxLKJpvIS7S4PkfruBFk3qehGkA2nf21CWzLVTnwd11Avz
	95gPcPloVSbiiQiHTfeRRWrOBR4Pz/BBqS9y9ytiwZicTXNMKapnbeZvN8bcztcxHy7lGaEtETB
	TPnPbXXLurE2B5SIavrlqcGuZwKV4zC1wYO03XNgww==
X-Google-Smtp-Source: AGHT+IEvrtGFdMOgAMOedhiYVS9wcsNpV1fQGxb2LrV3O86HhTrXCjTOzbAFAobOS+dErlfsa/0DYQ==
X-Received: by 2002:a92:dc4b:0:b0:3d4:346e:8d49 with SMTP id e9e14a558f8ab-3d47a022860mr98377385ab.9.1742060611501;
        Sat, 15 Mar 2025 10:43:31 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a67e5b3sm16154225ab.35.2025.03.15.10.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 10:43:30 -0700 (PDT)
Message-ID: <0712e91f-2342-41ef-baad-3f2348f47ed6@kernel.dk>
Date: Sat, 15 Mar 2025 11:43:30 -0600
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
 <510692e2-b83c-45bc-8d9d-08f7a172ffe6@kernel.dk>
 <5ymzmc3u3ar7p4do5xtrmlmddpzhkqse2gfharr3nrhvdexiiq@p3hszkhipbgr>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5ymzmc3u3ar7p4do5xtrmlmddpzhkqse2gfharr3nrhvdexiiq@p3hszkhipbgr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/25 11:27 AM, Kent Overstreet wrote:
> On Sat, Mar 15, 2025 at 11:03:20AM -0600, Jens Axboe wrote:
>> On 3/15/25 11:01 AM, Kent Overstreet wrote:
>>> On Sat, Mar 15, 2025 at 10:47:09AM -0600, Jens Axboe wrote:
>>>> On 3/11/25 2:15 PM, Kent Overstreet wrote:
>>>>> REQ_FUA|REQ_READ means "do a read that bypasses the controller cache",
>>>>> the same as writes.
>>>>>
>>>>> This is useful for when the filesystem gets a checksum error, it's
>>>>> possible that a bit was flipped in the controller cache, and when we
>>>>> retry we want to retry the entire IO, not just from cache.
>>>>>
>>>>> The nvme driver already passes through REQ_FUA for reads, not just
>>>>> writes, so disabling the warning is sufficient to start using it, and
>>>>> bcachefs is implementing additional retries for checksum errors so can
>>>>> immediately use it.
>>>>
>>>> This one got effectively nak'ed by various folks here:
>>>>
>>>>> Link: https://lore.kernel.org/linux-block/20250311133517.3095878-1-kent.overstreet@linux.dev/
>>>>
>>>> yet it's part of this series and in linux-next? Hmm?
>>>
>>> As I explained in that thread, they were only thinking about the caching
>>> of writes.
>>>
>>> That's not what we're concerned about; when we retry a read due to a
>>> checksum error we do not want the previous _read_ cached.
>>
>> Please follow the usual procedure of getting the patch acked/reviewed on
>> the block list, and go through the usual trees. Until that happens, this
>> patch should not be in your tree, not should it be staged in linux-next.
> 
> It's been posted to linux-block and sent to your inbox. If you're going
> to take it that's fine, otherwise - since this is necessary for handling
> bitrotted data correctly and I've got users who've been waiting on this
> patch series, and it's just deleting a warning, I'm inclined to just
> send it.
> 
> I'll make sure he's got the lore links and knows what's going on, but
> this isn't a great thing to be delaying on citing process.

Kent, you know how this works, there's nothing to argue about here.

Let the block people get it reviewed and staged. You can't just post a
patch, ignore most replies, and then go on to stage it yourself later
that day. It didn't work well in other subsystems, and it won't work
well here either.

EOD on my end.

-- 
Jens Axboe

