Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02B54D5657
	for <lists+linux-block@lfdr.de>; Fri, 11 Mar 2022 01:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344662AbiCKAIv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 10 Mar 2022 19:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiCKAIu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 19:08:50 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C86289BF
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 16:07:46 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id p8so6486889pfh.8
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 16:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c8+wak2ki/A/g/kxWs823XsVefyEuUkbFdJO3RjmWsw=;
        b=At+U+RfFWHA65evfl4fyyUVROLPzqfrBDWpKTuI6wB250egnIaFrQQ2QdUJB5sztXp
         fkcZ7XRkkiyxecAPbvwrqo4q8xIrIQXHsehrZxnY1T/J6KG+wyLEYDh1M1ESyWMMflWg
         yuJU4fvO191lnW1Y3/3Aa2hDpCn9Vv71F7U6OmMoBLbc8/PZfGSAou5qFx7q6h2gPGyD
         yzZHFaYw58GFGfWvBigt9IlbnBGaaBD95Dh7o8a2u1b7lORv9gD2DPhm4Yf6kM3OrC68
         PF8lXA+jEuA33Hgf9It8dnrTRbuDNPX/UA0IknbgmwIYivlOouPr+q4jL310hMRPhx4G
         9raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c8+wak2ki/A/g/kxWs823XsVefyEuUkbFdJO3RjmWsw=;
        b=LI1fMTF7qzd0BcU0O1ZhA2weHxVaUAQpCrDG0CCcmDY5TxUEb+sJJXLnEDIF/Gm6AH
         uf8AJ94MyNpQLq9iF9hBCftdUwHCTYMP17BrUW3nraPyj2uzpBSXNpDJ3TvxBj+M3+yN
         QJX5fxCyQuSVJmTB3VKRGNdizWm0ztvdYq5eCMEKv9c9xU5Am3YeeWeA70eDSrUlHRtT
         OCCaIZa3E4IDMK7yaMdeWtff4Y11PSCpmSBEotARuP5ScAj0zjmdH04fqo6kgabFSJRk
         4nDinSDr20gfhho40bIh4PKog9avLtwQ7U2ry/TkFIFGOMyiP+B/KiuRdJOQEmz9bnUZ
         7CoA==
X-Gm-Message-State: AOAM530D9evs1F0ieF7UsxGTwPfhG6PvnfLHg5aaSwGInQGie4/Mvkpy
        g/rO8s0KLvDREdoK1WqIB2wu6A==
X-Google-Smtp-Source: ABdhPJwS7ThzsaI94LPbIZGbJjcXUKKVFpUCdAWX9NAP5uUKS/JBj+UocSs6fEWa4MQ/cAvC0inkpg==
X-Received: by 2002:a65:6d8f:0:b0:380:8b0c:a5b0 with SMTP id bc15-20020a656d8f000000b003808b0ca5b0mr6387382pgb.558.1646957266062;
        Thu, 10 Mar 2022 16:07:46 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id pj13-20020a17090b4f4d00b001bf2ff56430sm11751637pjb.30.2022.03.10.16.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 16:07:45 -0800 (PST)
Message-ID: <2b437948-ba2a-c59c-1059-e937ea8636bd@kernel.dk>
Date:   Thu, 10 Mar 2022 17:07:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] block: check more requests for multiple_queues in
 blk_attempt_plug_merge
Content-Language: en-US
To:     Song Liu <song@kernel.org>
Cc:     linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>, stable@vger.kernel.org,
        Larkin Lowrey <llowrey@nuclearwinter.com>,
        Wilson Jonathan <i400sjon@gmail.com>,
        Roger Heflin <rogerheflin@gmail.com>
References: <20220309064209.4169303-1-song@kernel.org>
 <9516f407-bb91-093b-739d-c32bda1b5d8d@kernel.dk>
 <CAPhsuW5zX96VaBMu-o=JUqDz2KLRBcNFM_gEsT=tHjeYqrngSQ@mail.gmail.com>
 <38f7aaf5-2043-b4f4-1fa5-52a7c883772b@kernel.dk>
 <CAPhsuW7zdYZqxaJ7SOWdnVOx-cASSoXS4OwtWVbms_jOHNh=Kw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAPhsuW7zdYZqxaJ7SOWdnVOx-cASSoXS4OwtWVbms_jOHNh=Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/10/22 4:33 PM, Song Liu wrote:
> On Thu, Mar 10, 2022 at 3:02 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 3/10/22 3:37 PM, Song Liu wrote:
>>> On Thu, Mar 10, 2022 at 2:15 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 3/8/22 11:42 PM, Song Liu wrote:
>>>>> RAID arrays check/repair operations benefit a lot from merging requests.
>>>>> If we only check the previous entry for merge attempt, many merge will be
>>>>> missed. As a result, significant regression is observed for RAID check
>>>>> and repair.
>>>>>
>>>>> Fix this by checking more than just the previous entry when
>>>>> plug->multiple_queues == true.
>>>>>
>>>>> This improves the check/repair speed of a 20-HDD raid6 from 19 MB/s to
>>>>> 103 MB/s.
>>>>
>>>> Do the underlying disks not have an IO scheduler attached? Curious why
>>>> the merges aren't being done there, would be trivial when the list is
>>>> flushed out. Because if the perf difference is that big, then other
>>>> workloads would be suffering they are that sensitive to being within a
>>>> plug worth of IO.
>>>
>>> The disks have mq-deadline by default. I also tried kyber, the result
>>> is the same. Raid repair work sends IOs to all the HDDs in a
>>> round-robin manner. If we only check the previous request, there isn't
>>> much opportunity for merge. I guess other workloads may have different
>>> behavior?
>>
>> Round robin one at the time? I feel like there's something odd or
>> suboptimal with the raid rebuild, if it's that sensitive to plug
>> merging.
> 
> It is not one request at a time, but more like (for raid456):
>    read 4kB from HDD1, HDD2, HDD3...,
>    then read another 4kB from HDD1, HDD2, HDD3, ...

Ehm, that very much looks like one-at-the-time from each drive, which is
pretty much the worst way to do it :-)

Is there a reason for that? Why isn't it using 64k chunks or something
like that? You could still do that as a kind of read-ahead, even if
you're still processing in chunks of 4k.

>> Plug merging is mainly meant to reduce the overhead of merging,
>> complement what the scheduler would do. If there's a big drop in
>> performance just by not getting as efficient merging on the plug side,
>> that points to an issue with something else.
> 
> We introduced blk_plug_max_rq_count() to give md more opportunities to
> merge at plug side, so I guess the behavior has been like this for a
> long time. I will take a look at the scheduler side and see whether we
> can just merge later, but I am not very optimistic about it.

Yeah I remember, and that also kind of felt like a work-around for some
underlying issue. Maybe there's something about how the IO is issued
that makes it go straight to disk and we never get any merging? Is it
because they are sync reads?

In any case, just doing larger reads would likely help quite a bit, but
would still be nice to get to the bottom of why we're not seeing the
level of merging we expect.

-- 
Jens Axboe

