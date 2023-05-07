Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196F46F9960
	for <lists+linux-block@lfdr.de>; Sun,  7 May 2023 17:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjEGPci (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 7 May 2023 11:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEGPch (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 May 2023 11:32:37 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C991BF3
        for <linux-block@vger.kernel.org>; Sun,  7 May 2023 08:32:11 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52c6f8ba7e3so3365482a12.3
        for <linux-block@vger.kernel.org>; Sun, 07 May 2023 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683473531; x=1686065531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAJuFKA2WbO5t/MWWkp+wgsDKDGBHsZX3U7rMhZW364=;
        b=UpbnHFU0yNMCgNV9dnHl4cjW83awcatKcDRhy2ig6Ca5S9Z3M94my+SMkCOVeNFnTl
         RAQfynxmMy0N2iLYGLBm5Az1588DhsKr6umonO9iVsKIg4VskyU0ABt3asFM4iEdqmr6
         uTHJsBxh4dFRGoxgZFmA7YNRcXzrdpD9P/dyvHQTmjSiC0dl2LutRFA0d7RsKavWGiNR
         WwNFi73Hd1VzqbCbKaO5MSTkw1+nIXtIfdlquAe0Mz+PmgvH3ZCetgaMwxwgxaCkn3Gf
         7BKZH0oX19hHHZ6TLmtytJ/cRW2hMBWKyRsaBKsFcwdNszfw9hY60KQq/B79zbfVUnHm
         Ybeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683473531; x=1686065531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hAJuFKA2WbO5t/MWWkp+wgsDKDGBHsZX3U7rMhZW364=;
        b=Ngs5b8PzJSkApIcLVje7ziWMEE/GYp3Zo0Rx973tdTHGIpPQiNqAHp9j8A8jT/zn2M
         hzDGihkm7iFuHZUZ5YHYBTruXK+0QFnH43nD93oEmvBh94WBfrnWCYqPSiJiD8i/KkRn
         iy1FpqdZVJS6OzTnJuZxsLgqTqjrBprzbL61SAI0zzTsdPd3/0caVOc6ht0Ouo+hMzH8
         4r37x28pvfWjMtH97Kp7tXFRcPZHQapJGHARDZfxRbcC2By+VhW3OkCa5hx3OJY4Nfhl
         gOJVA+2QaHFnAFUfNXzgJY1+bINy6y2z5vR5k3+ZYjMF3XO2D5S7JXa0LS7dLCJX42GO
         C0Rw==
X-Gm-Message-State: AC+VfDyJY3IrcGHwcxNncxsMUaAwPH0NRM85MXCLrAKdMuEW2gG9PsOu
        LFyqkp1XKftkXpuq8RnJ0R/7Sg==
X-Google-Smtp-Source: ACHHUZ5vaZYny/4Xt5w97TuH6E7aN33rhIjuGoHCPKDMntXPppnOmvCAE8+RUtWWpI3C0dGcV61hZg==
X-Received: by 2002:a17:902:6b86:b0:1a2:9183:a49c with SMTP id p6-20020a1709026b8600b001a29183a49cmr6998070plk.32.1683473531065;
        Sun, 07 May 2023 08:32:11 -0700 (PDT)
Received: from [10.4.245.5] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090301c900b001ac7af57fd4sm120008plh.86.2023.05.07.08.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 08:32:10 -0700 (PDT)
Message-ID: <9b3abfd1-e925-61fe-80c0-6076b03f49f9@bytedance.com>
Date:   Sun, 7 May 2023 23:32:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [External] Re: [PATCH v2] blk-throttle: Fix io statistics for
 cgroup v1
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230401094708.77631-1-hanjinke.666@bytedance.com>
 <ZEwY5Oo+5inO9UFf@righiandr-XPS-13-7390>
 <eb2eeb6b-07da-4e98-142c-da1e7ea35c2b@bytedance.com>
 <ZFQf3TCs7DqsSR8l@righiandr-XPS-13-7390>
 <6696100e-e838-d96a-2894-bbca9783d2a3@bytedance.com>
 <ZFY9ocCi2EPU3Cu3@righiandr-XPS-13-7390>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <ZFY9ocCi2EPU3Cu3@righiandr-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2023/5/6 下午7:44, Andrea Righi 写道:
> On Fri, May 05, 2023 at 09:35:21PM +0800, hanjinke wrote:
>>
>>
>> 在 2023/5/5 上午5:13, Andrea Righi 写道:
>>> On Thu, May 04, 2023 at 11:08:53PM +0800, hanjinke wrote:
>>>> Hi
>>>>
>>>> Sorry for delay（Chinese Labor Day holiday).
>>>
>>> No problem, it was also Labor Day in Italy. :)
>>>
>>>>
>>>> 在 2023/4/29 上午3:05, Andrea Righi 写道:
>>>>> On Sat, Apr 01, 2023 at 05:47:08PM +0800, Jinke Han wrote:
>>>>>> From: Jinke Han <hanjinke.666@bytedance.com>
>>>>>>
>>>>>> After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
>>>>>> blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
>>>>>> the only stable io stats interface of cgroup v1, and these statistics
>>>>>> are done in the blk-throttle code. But the current code only counts the
>>>>>> bios that are actually throttled. When the user does not add the throttle
>>>>>> limit, the io stats for cgroup v1 has nothing. I fix it according to the
>>>>>> statistical method of v2, and made it count all ios accurately.
>>>>>>
>>>>>> Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")
>>>>>> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
>>>>>
>>>>> Thanks for fixing this!
>>>>>
>>>>> The code looks correct to me, but this seems to report io statistics
>>>>> only if at least one throttling limit is defined. IIRC with cgroup v1 it
>>>>> was possible to see the io statistics inside a cgroup also with no
>>>>> throttling limits configured.
>>>>>
>>>>> Basically to restore the old behavior we would need to drop the
>>>>> cgroup_subsys_on_dfl() check, something like the following (on top of
>>>>> your patch).
>>>>>
>>>>> But I'm not sure if we're breaking other behaviors in this way...
>>>>> opinions?
>>>>>
>>>>>     block/blk-cgroup.c   |  3 ---
>>>>>     block/blk-throttle.h | 12 +++++-------
>>>>>     2 files changed, 5 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>>>>> index 79138bfc6001..43af86db7cf3 100644
>>>>> --- a/block/blk-cgroup.c
>>>>> +++ b/block/blk-cgroup.c
>>>>> @@ -2045,9 +2045,6 @@ void blk_cgroup_bio_start(struct bio *bio)
>>>>>     	struct blkg_iostat_set *bis;
>>>>>     	unsigned long flags;
>>>>> -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
>>>>> -		return;
>>>>> -
>>>>>     	/* Root-level stats are sourced from system-wide IO stats */
>>>>>     	if (!cgroup_parent(blkcg->css.cgroup))
>>>>>     		return;
>>>>> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
>>>>> index d1ccbfe9f797..bcb40ee2eeba 100644
>>>>> --- a/block/blk-throttle.h
>>>>> +++ b/block/blk-throttle.h
>>>>> @@ -185,14 +185,12 @@ static inline bool blk_should_throtl(struct bio *bio)
>>>>>     	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
>>>>>     	int rw = bio_data_dir(bio);
>>>>> -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
>>>>> -		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
>>>>> -			bio_set_flag(bio, BIO_CGROUP_ACCT);
>>>>> -			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
>>>>> -					bio->bi_iter.bi_size);
>>>>> -		}
>>>>> -		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
>>>>> +	if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
>>>>> +		bio_set_flag(bio, BIO_CGROUP_ACCT);
>>>>> +		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
>>>>> +				bio->bi_iter.bi_size);
>>>>>     	}
>>>>> +	blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
>>>>
>>
>> I checked the code again. If we remove cgroup_subsys_on_dfl check here, io
>> statistics will still be performed in the case of v2, which I think is
>> unnecessary, and this information will be counted to
>> io_service_bytes/io_serviced, these two files are not visible in v2. Am I
>> missing something?
> 
> You are absolutely right. Sorry, I have just re-tested your fix and it
> seems to handle the cgroup v1 case correctly, you can add my:
> 
> Tested-by: Andrea Righi <andrea.righi@canonical.com>
> 
> And we definitely need the cgroup_subsys_on_dfl() check, otherwise we'd
> account extra IO in the v2 case that is not really needed.
> 

Thanks a lot! I will add it and send a v3.

Thanks，
Jinke
