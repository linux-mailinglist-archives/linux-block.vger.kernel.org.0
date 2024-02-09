Return-Path: <linux-block+bounces-3065-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15CC84EE39
	for <lists+linux-block@lfdr.de>; Fri,  9 Feb 2024 01:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7716E284565
	for <lists+linux-block@lfdr.de>; Fri,  9 Feb 2024 00:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA3523A3;
	Fri,  9 Feb 2024 00:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0OSitqyc"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6FC1847
	for <linux-block@vger.kernel.org>; Fri,  9 Feb 2024 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707437465; cv=none; b=ZkuIKgAPaKn7dSQOqwOM92weTSaghVi2bf0lp0EBBfpRAEsgLIKY9yKt/dqIE3XeCSxjwd0xcxzLdx5sRSvMKDtpbXoc/xdlkRLSdN7pYrAxdXVvuIXqPw+dGlJ2Z+lcj55cnhSwh8IOGbNbTC1L+GVCg/J7jjjiOHogmThUJ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707437465; c=relaxed/simple;
	bh=KB3qelQUqrjIj/uz/ReinabwlpII/Xxei1mrmVVdOnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSLa+MCvLq/VD+msZB2vtbuMh1YHQ/MOCODNnMDQMDv2x+iA9VEc6LIE4gbHYQNFKi9Wr8rIk2A5/HU62YMai/KxP0WGI//4A2AyjHt4jK4BTzB23MCSoMB206niHPKdjw+c9t2jceIUENdamHG85k/5uY5gZeZHCT9nnsbD9ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0OSitqyc; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d862e8b163so85078a12.1
        for <linux-block@vger.kernel.org>; Thu, 08 Feb 2024 16:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707437460; x=1708042260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljXVSv+IgTxgkdxdQikP7le8cjzvQmmm9yxoN2Ry244=;
        b=0OSitqycywgDTah2eWq/zpojJgFGYm0OYQ4ZZDddoHDf+ws75gMi8Dozn7hE7eb25N
         xyp84DXRmy8f1gCDou+OLv2nl/Q9V2acG+Gie9fiZDHxbcys26u5s+zaLtzA3Eh30Kpn
         qpPEDsbJWsbJwvAGSAcnCdE68uPhV9G4tACmkusFW1h2UPDtXYOdf5hi9iiSwNJyKbNg
         fuKX+waVL24klH55OeagC2n30Lkd2f1YCs7oPTadpAf1bM4izzunvjox8BdBSFmmQCWi
         Ykp7cdZKPyY5PiuUzEJhvp2hizUURxu1hFd5xyrE8LMQEF4ae+BtmqvsLLwXUWc1aEOn
         IlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707437460; x=1708042260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljXVSv+IgTxgkdxdQikP7le8cjzvQmmm9yxoN2Ry244=;
        b=WscEAq9mZB3Hn7VxAprj9EKmNNySxUdrM/fJo036fzvd/i2EtybAxv7X1fK1G7hFjr
         MFGChjMEPZDU6p9Y96BO5V4zhY/YZeu8LNjeDhVrT4mJAxd/Sk6/lD8YMMe0hJ/Db/EH
         iN7MDVnJvnN6GGihKIFVS3qMRXv8b3b7NaZVRCsTg0XN0ituACXVyai0jjHt9kYbw0Jy
         kiMnf4FJxlD+ynZmxoIfI0onVnh1hgGeIfWD4IcjDoWhR8i2GYymQrQrqaDKnTiM02Z1
         15ssOrtJJYkmGV2laJnj2sgvGpSQdxPH/slyKegB5gwqnaW6TwOu9eQr2wHkfYAXYEbt
         cfPg==
X-Gm-Message-State: AOJu0YwW70ZKgk1mj1AHS7FEkBXCBwhKJxbMk2TLOmpHTgWaFHOmvCPZ
	eNzR6GYtBwTSeu7YdvTzLwGQq1EHjgNeW5rrRnHSur1u8ULKpHJLBa5EyakThsE=
X-Google-Smtp-Source: AGHT+IGgnUU0WWk10gz1SbM9SzUbCWL4i86urZgiiMOFTwgPxFz1IWduLacvCimLm6imOkMlfcbBIA==
X-Received: by 2002:a05:6a20:da9c:b0:19e:886c:9035 with SMTP id iy28-20020a056a20da9c00b0019e886c9035mr143756pzb.5.1707437460268;
        Thu, 08 Feb 2024 16:11:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/htOrcuRo3ZwAywpqM+MCfPY7d7iJjMGSn3FKekp/FyFogkeIR/zg9kMsXWV/aMrPi80bXUQ06DpUc4KIyVS4QIRrQ4xxrBuxAmqaJcXarwEJSOY5+VzrOcAt0L91NrwnfH8uuhwEutqmrBPoTu0mTzV5kugUNqT2czSosYKpgh3C9fY4CdZa2kbGM6xqDUm9MqgBgaBYBnAOa/hOhTZ8KePKRJFdjcRjj8NqqqGcd6YL31eWzGW09WKgnFuHeLdkAymJeDJPm6jPw3ZOKtMJnlXkJBoaCSRbFnc35FbMrnUcKC0/+gMlQlbS9ZQS
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d1-20020a634f01000000b005cda7a1d72dsm471481pgb.74.2024.02.08.16.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 16:10:59 -0800 (PST)
Message-ID: <da41bac4-015f-4df0-b8cc-6c8b2f468e12@kernel.dk>
Date: Thu, 8 Feb 2024 17:10:58 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block: introducing a bias over deadline's fifo_time
Content-Language: en-US
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Yu Zhao <yuzhao@google.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 steve.kang@unisoc.com
References: <20240208093136.178797-1-zhaoyang.huang@unisoc.com>
 <20240208093136.178797-3-zhaoyang.huang@unisoc.com>
 <ca00ff75-e98d-4652-9c52-94b2e876901e@kernel.dk>
 <CAGWkznH6Y8u7PsoHWid0uQ+ceRK_qzSn6=eWn4dvDhK+DzSXzg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAGWkznH6Y8u7PsoHWid0uQ+ceRK_qzSn6=eWn4dvDhK+DzSXzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/8/24 5:02 PM, Zhaoyang Huang wrote:
> On Fri, Feb 9, 2024 at 1:49?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 2/8/24 2:31 AM, zhaoyang.huang wrote:
>>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>>> index f958e79277b8..43c08c3d6f18 100644
>>> --- a/block/mq-deadline.c
>>> +++ b/block/mq-deadline.c
>>> @@ -15,6 +15,7 @@
>>>  #include <linux/compiler.h>
>>>  #include <linux/rbtree.h>
>>>  #include <linux/sbitmap.h>
>>> +#include "../kernel/sched/sched.h"
>>>
>>>  #include <trace/events/block.h>
>>>
>>> @@ -802,6 +803,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>>       u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
>>>       struct dd_per_prio *per_prio;
>>>       enum dd_prio prio;
>>> +     int fifo_expire;
>>>
>>>       lockdep_assert_held(&dd->lock);
>>>
>>> @@ -840,7 +842,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>>               /*
>>>                * set expire time and add to fifo list
>>>                */
>>> -             rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
>>> +             fifo_expire = task_is_realtime(current) ? dd->fifo_expire[data_dir] :
>>> +                     CFS_PROPORTION(current, dd->fifo_expire[data_dir]);
>>> +             rq->fifo_time = jiffies + fifo_expire;
>>>               insert_before = &per_prio->fifo_list[data_dir];
>>>  #ifdef CONFIG_BLK_DEV_ZONED
>>>               /*
>>
>> Hard pass on this blatant layering violation. Just like the priority
>> changes, this utterly fails to understand how things are properly
>> designed.
> IMHO, I don't think this is a layering violation. bio_set_ioprio is
> the one which introduces the scheduler thing into the block layer,
> this commit just wants to do a little improvement based on that. This
> commit helps CFS task save some IO time when preempted by RT heavily.

Listen, both this and the previous content ioprio thing show a glaring
misunderstanding of how to design these kinds of things. You have no
grasp of what the different layers do, or how they interact. I'm not
sure how to put this kindly, but it's really an awful idea to hardcore
some CFS helper into the IO scheduler. The fact that you had to fiddle
around with headers to make it work was the first warning sign, and the
fact that you didn't stop at that point to consider how it could be
properly done makes it even worse.

You need to stop sending kernel patches until you understand basic
software design. Neither of these patches are going anywhere until this
happens. There's been plenty of feedback to telling you that, but you
seem to just ignore it and plow on ahead. Stop.

-- 
Jens Axboe


