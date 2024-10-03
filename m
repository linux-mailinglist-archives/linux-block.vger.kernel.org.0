Return-Path: <linux-block+bounces-12133-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC1198F19A
	for <lists+linux-block@lfdr.de>; Thu,  3 Oct 2024 16:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBF11C216FB
	for <lists+linux-block@lfdr.de>; Thu,  3 Oct 2024 14:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DEB19F13C;
	Thu,  3 Oct 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H2kRjhgk"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E52C823C3
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966333; cv=none; b=HSVRXiuNkunNVtbJwaCH2azl0zNy1qS8Zhe1Yo/rr1OniVvJXTI3fKf5kCupur+D1mHrm6ZO2U67AIlpHKo/Hx5/PArDJoAbd7GbIsUjeNpnkDl6b8s0uaUl3Yleww81bYYDRb5mOk6sLdjBy5RV6fC51XbxU/CjWdCZaDLi584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966333; c=relaxed/simple;
	bh=q9t98pdjyuMYvI4LfE26CXv/VAUouoqEy+BXkMt9aiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etiEKLAbg+r/qdFID4HnUkHRH5NwHhTQK1j+L6leiqjUuyIKVRhwGxHmNRLpw8wMPf1UpFJTGf0lMElI2cNTJx7qXLsWKv3ZV/kXPscH7B93Yw12XBmYX9OCLkvkgyw7QBBNMYXlaJgTyHR3MkzMT9HRJ/JU+Cdy5062j4xkiYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H2kRjhgk; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a363feabc6so7097065ab.1
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727966330; x=1728571130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tKVVmDgqgVBNuR9G4/w7onFoyTymtNc4n7+PK7hFPug=;
        b=H2kRjhgk2Ru3JGhcj+icEvd5+AqEd48E+HRZACq7vd2Vhggt007aWK6fHjLfaZKUZk
         jsDyoSEE5miQPte08PqE0TCAJcAfQre6iIGbcNav5CHcg5XAaVQJ67KTgkWu+rXr5/TK
         pGJZv0IdQK9Hzj1ukvbeoJfe5ayqaN9dp5ML1h+NXESojawF9i8auDvo/Y1D5IthM1uO
         /F6kO/j6wbFr8VsnRMahkcKJbNaUOFV/4gurv8039j/Ti8e8oZHMuOrYrOELIEMyoze6
         cQY4CldA2QJOGvs95/j55xY4xCIvgDuKxwJfWF8nWYAUjOIQx3lCYtieB9UOe0NIfkhk
         CFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727966330; x=1728571130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKVVmDgqgVBNuR9G4/w7onFoyTymtNc4n7+PK7hFPug=;
        b=NNkRu0v/01AcTvYbfarEyBEUI0YzqDbJJDcMk5ygAMZFcK3xYqco7GprZ+e9QKHjwl
         3zTVwsadXAmgqU1KpC+dhWTz11D0NPUi3nvSqcwWfC6FGnaLUV1L2P1FW6MS0TvnHmcI
         azogFssF9Hq99cASWmhlFC4FX41j/w+KrzQyEH9Pmh3yb1oIx+uRpRiBdaQDbZAnfhqD
         NVCJwopWj84HmoE0FOPIWz8lLxXwhEzuyL6G0u8ZKqhXLNlNND3krr11PDn27scUHv1n
         oLCYGUYJabKzfNDl449PP+Xvd3+13zbGZE9NtTYy3j+y2ZaaxcRVjtYzrcaGcY1wxaZy
         /bZw==
X-Forwarded-Encrypted: i=1; AJvYcCWe3piOOsRROvG3TPc/F5d+IGRYCimaaSqkK3spZ05MNOs4tanabP2TVDFII+PRZCH7tq8p1xgK6UGoUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+fKc4Q2Xbtu0HTJihFP/6NKdOJ+QqGISl2s5d1arElmAD6jZ
	n1GCmbMJHsaQxObog3u2PB0/9+mma+aZtXXAK7XytbZeCwxJ/XLtAFE4Y8dy8xc=
X-Google-Smtp-Source: AGHT+IGEODw9+4ozttoOxYFSoxtp6pCkcMizOFyGuWIdCHmaofX6M6puA8OJjxE7+kQ6cezS5zArTg==
X-Received: by 2002:a05:6e02:2188:b0:395:e85e:f2fa with SMTP id e9e14a558f8ab-3a36e22140fmr25652915ab.1.1727966330627;
        Thu, 03 Oct 2024 07:38:50 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a371979012sm2312045ab.51.2024.10.03.07.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 07:38:49 -0700 (PDT)
Message-ID: <c26e5b36-d369-4353-a5a8-9c9b381ce239@kernel.dk>
Date: Thu, 3 Oct 2024 08:38:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Waiman Long <longman@redhat.com>, Yu Kuai <yukuai3@huawei.com>,
 Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
 <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>
 <925f3337-cf9b-4dc1-87ea-f1e63168fbc4@stanley.mountain>
 <df1cc7cb-bac6-4ec2-b148-0260654cc59a@redhat.com>
 <3083c357-9684-45d3-a9c7-2cd2912275a1@stanley.mountain>
 <fe7ce685-f7e3-4963-a0d3-b992354ea1d8@kernel.dk>
 <68f3e5f8-895e-416b-88cf-284a263bd954@stanley.mountain>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <68f3e5f8-895e-416b-88cf-284a263bd954@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/24 8:31 AM, Dan Carpenter wrote:
> On Thu, Oct 03, 2024 at 07:21:25AM -0600, Jens Axboe wrote:
>> On 10/3/24 6:03 AM, Dan Carpenter wrote:
>>>   3117                                  ioc_now(iocg->ioc, &now);
>>>   3118                                  weight_updated(iocg, &now);
>>>   3119                                  spin_unlock(&iocg->ioc->lock);
>>>   3120                          }
>>>   3121                  }
>>>   3122                  spin_unlock_irq(&blkcg->lock);
>>>   3123  
>>>   3124                  return nbytes;
>>>   3125          }
>>>   3126  
>>>   3127          blkg_conf_init(&ctx, buf);
>>>   3128  
>>>   3129          ret = blkg_conf_prep(blkcg, &blkcg_policy_iocost, &ctx);
>>>   3130          if (ret)
>>>   3131                  goto err;
>>>   3132  
>>>   3133          iocg = blkg_to_iocg(ctx.blkg);
>>>   3134  
>>>   3135          if (!strncmp(ctx.body, "default", 7)) {
>>>   3136                  v = 0;
>>>   3137          } else {
>>>   3138                  if (!sscanf(ctx.body, "%u", &v))
>>>   3139                          goto einval;
>>>   3140                  if (v < CGROUP_WEIGHT_MIN || v > CGROUP_WEIGHT_MAX)
>>>   3141                          goto einval;
>>>   3142          }
>>>   3143  
>>>   3144          spin_lock(&iocg->ioc->lock);
>>>
>>> But why is this not spin_lock_irq()?  I haven't analyzed this so maybe it's
>>> fine.
>>
>> That's a bug.
>>
> 
> I could obviously write this patch but I feel stupid writing the
> commit message. My level of understanding is Monkey See Monkey do.
> Could you take care of this?

Sure - or let's add Tejun who knows this code better. Ah he's already
added. Tejun?

> So somewhere we're taking a lock in the IRQ handler and this can lead
> to a deadlock? I thought this would have been caught by lockdep?

It's nested inside blkcg->lock which is IRQ safe, that is enough. But
doing a quick scan of the file, the usage is definitely (widly)
inconsistent. Most times ioc->lock is grabbed disabling interrupts, but
there are also uses that doesn't disable interrupts, coming from things
like seq_file show paths which certainly look like they need it. lockdep
should certainly warn about this, only explanation I have is that nobody
bothered to do that :-)

-- 
Jens Axboe

