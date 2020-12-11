Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAB22D75DA
	for <lists+linux-block@lfdr.de>; Fri, 11 Dec 2020 13:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395437AbgLKMmp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Dec 2020 07:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395446AbgLKMmm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Dec 2020 07:42:42 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CE1C0613CF
        for <linux-block@vger.kernel.org>; Fri, 11 Dec 2020 04:42:02 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id d3so7438908wmb.4
        for <linux-block@vger.kernel.org>; Fri, 11 Dec 2020 04:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eHGvny+nj+7zxJdSEBI1haezHDnvQ4y7FF/N0XySois=;
        b=Cd5kK9HqbMxAfrj6DGpX72ZQJZ9K+OurkjereYanKs6RNirD5qCG10hUfwnZ/tVz1W
         iI5VqSbe1ofcIyMWPM6tYSgr0ABlAE+MnrT4dndPWL9f9S9iNWMfDUTl4ZWehi73y8tg
         vfjVeeD21WajlnarlYUdnaGlLri1m6ypru0ydHoPSYGT+Rc/1AasxS8Vd/h4ZCGHpPgy
         DUFANTrxoAgECQx202cL8iy/DGy8p3WWln/d/rSO6JajDLNRoy6jRZFm2CIRoYPHaJWE
         kDM/wLusx+rhj+Ky29mury4jVnMVHy/q3QvgpCNP4vPkZRPlCtV7RDm228ze0sZZMNdh
         uf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eHGvny+nj+7zxJdSEBI1haezHDnvQ4y7FF/N0XySois=;
        b=dVM1Bn855f9N8wHD+OU3/ww9bLux1qva/qbu7e8qBXLFiAsOcPxmjp7ftF1TUMrvxd
         QC3rny+4xLZqDPwOUpNtXVuqhaz7nS94AMzuNrtpg/xXcXop5LJVJ57ABJ6HHUZk15od
         J1arApRNLZagtsCQbys43iO/BCCvinAP2su9yW3fiSZl0TSG/qR8oqJ7CKbHpFza/18G
         q03SwmkA9UPpE98eyWT0wGC3m7mBfRddWeAJRM0eMDuPe48CrX+dR3r5MUojoArUs/kt
         i+0Lgyw16Beam444tZYf1+E1ieWwbhNWAiotx0zyS4B4WugDMwrht336NUsSywUa7TeA
         g42A==
X-Gm-Message-State: AOAM530810mVMdudMOHkjXiSy2+B9XeW53lH4DLhyqFCwrwca5uevdOl
        BaBhd/DlwTn2DmYIFlb5oWo=
X-Google-Smtp-Source: ABdhPJyAeZsP6r+MxxmpRDp8N9HN5gEiBdxq/06Zh8dyrMBQVJPRXzhcEKgQpFCW6MpM7fDpHFZvHw==
X-Received: by 2002:a1c:98cc:: with SMTP id a195mr13505393wme.150.1607690521251;
        Fri, 11 Dec 2020 04:42:01 -0800 (PST)
Received: from [192.168.8.123] ([85.255.234.121])
        by smtp.gmail.com with ESMTPSA id c2sm14330927wrv.41.2020.12.11.04.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 04:42:00 -0800 (PST)
To:     Keith Busch <kbusch@kernel.org>
Cc:     Andres Freund <andres@anarazel.de>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20201210205141.px7suygfrl2lhdkr@alap3.anarazel.de>
 <73c43682-10f2-0bc9-5aa5-e433abd4f3c3@gmail.com>
 <aa735173-fad1-b7d4-1c90-4fccc90c562d@gmail.com>
 <20201211011940.ouc4k3am5gg2ithp@alap3.anarazel.de>
 <de0b46d2-d053-a7a8-23e7-fc954807c70d@gmail.com>
 <20201211033719.GA6414@redsun51.ssa.fujisawa.hgst.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: hybrid polling on an nvme doesn't seem to work with iodepth > 1
 on 5.10.0-rc5
Message-ID: <2b26eaca-d143-6951-3bed-ce29df4dd07d@gmail.com>
Date:   Fri, 11 Dec 2020 12:38:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201211033719.GA6414@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/12/2020 03:37, Keith Busch wrote:
> On Fri, Dec 11, 2020 at 01:44:38AM +0000, Pavel Begunkov wrote:
>> On 11/12/2020 01:19, Andres Freund wrote:
>>> On 2020-12-10 23:15:15 +0000, Pavel Begunkov wrote:
>>>> On 10/12/2020 23:12, Pavel Begunkov wrote:
>>>>> On 10/12/2020 20:51, Andres Freund wrote:
>>>>>> Hi,
>>>>>>
>>>>>> When using hybrid polling (i.e echo 0 >
>>>>>> /sys/block/nvme1n1/queue/io_poll_delay) I see stalls with fio when using
>>>>>> an iodepth > 1. Sometimes fio hangs, other times the performance is
>>>>>> really poor. I reproduced this with SSDs from different vendors.
>>>>>
>>>>> Can you get poll stats from debugfs while running with hybrid?
>>>>> For both iodepth=1 and 32.
>>>>
>>>> Even better if for 32 you would show it in dynamic, i.e. cat it several
>>>> times while running it.
>>>
>>> Should read all email before responding...
>>>
>>> This is a loop of grepping for 4k writes (only type I am doing), with 1s
>>> interval. I started it before the fio run (after one with
>>> iodepth=1). Once the iodepth 32 run finished (--timeout 10, but took
>>> 42s0, I started a --iodepth 1 run.
>>
>> Thanks! Your mean grows to more than 30s, so it'll sleep for 15s for each
>> IO. Yep, the sleep time calculation is clearly broken for you.
>>
>> In general the current hybrid polling doesn't work well with high QD,
>> that's because statistics it based on are not very resilient to all sorts
>> of problems. And it might be a problem I described long ago
>>
>> https://www.spinics.net/lists/linux-block/msg61479.html
>> https://lkml.org/lkml/2019/4/30/120
> 
> It sounds like the statistic is using the wrong criteria. It ought to
> use the average time for the next available completion for any request
> rather than the average latency of a specific IO. It might work at high
> depth if the hybrid poll knew the hctx's depth when calculating the
> sleep time, but that information doesn't appear to be readily available.

It polls (and so sleeps) from submission of a request to its completion,
not from request to request. Looks like the other scheme doesn't suit well
when you don't have a constant-ish flow of requests, e.g. QD=1 and with
different latency in the userspace.

-- 
Pavel Begunkov
