Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5522521D6D
	for <lists+linux-block@lfdr.de>; Tue, 10 May 2022 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344921AbiEJPHh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 10 May 2022 11:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346481AbiEJPH3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 11:07:29 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA432C4F4D
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 07:34:35 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id l15so11481068ilh.3
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rGblXoUkUHtvTljXNDLZVxTcvx9dZj70mMSSLo73A/0=;
        b=gRAlNipA2oxaI1fA4spq7HV83J45VpHsnLHXN/8Ma8MJZhSm/qXwpbsJMN8h0mbsxN
         RNBl06+bi5bo2dw8/gCYStXWSyBVOixoyuUC9jVDg15R8TvoQze7x3PF6c71Vlgq1jzU
         XRuCU3cf7Y4p/LaHyA9wNcO6Ug/GeSuh1MHnDH077LmGX8lhcVk3gUEBQvllRO1pOVd3
         VfjlnmfuaEUbdjUBdaupw4nAjOiu6VQ04rctPlf5gwiZnUNL83cd+QGEnufl1ZfY7FeE
         dEZlwpQw6ldVozVs5fQhVo7ixyRFLWUReeoEGJ+gJWqmykv5cQVaIDnlnQPjqheEu4JL
         ftmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rGblXoUkUHtvTljXNDLZVxTcvx9dZj70mMSSLo73A/0=;
        b=XZAs7G+wYVbxcy6zulRno7Q1TSXo+tWDEVWkVnqSvNl6K9tdM2177AvKpUlWV4fqDp
         uc/fGQlKlyzfX26HZc3p1wmD6LTz1zhHCkjYMtO7eaq/LQHuR7sYMn5yWs5Qhkf0NDF7
         TL7fLkgUpVg7hKPACfFygszch/sRaWntyxwWkstLmy6mXlKegB6uUCWN3CdObRta/SGC
         m0eNj9bz+DNE6FE7ec5JN8lLL9CZLNW51AaEiOszfIa+DDgu+9wdyvK00Qr+r4e6CZq9
         t7gA59QrwWDiZ/BIJO2I/NWVxZ3alwj8pLBlQmllh2VZ815ATxhNgLkCoDUrm075rSlt
         VTNw==
X-Gm-Message-State: AOAM532mgcpZdpVNXgbnTGZDaXk4S4bHAOvuHRD1WmfnaSMF1sGWG8QR
        tLpGY7cNdluhgV0Xn+CsH/2gIQ==
X-Google-Smtp-Source: ABdhPJx+LSU3byZXjsmlDOaLGZkN952dv5wFlk+RVrffs6jor3BObJzc6TW4hH64Z4ryTFGrtGXHyA==
X-Received: by 2002:a92:d1d1:0:b0:2cd:73a5:f0 with SMTP id u17-20020a92d1d1000000b002cd73a500f0mr9010743ilg.161.1652193274502;
        Tue, 10 May 2022 07:34:34 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c4-20020a92c8c4000000b002cd7dc16ae4sm3935720ilq.1.2022.05.10.07.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 07:34:33 -0700 (PDT)
Message-ID: <ae314168-4cb8-cdcf-1e13-2c5f30f8f96c@kernel.dk>
Date:   Tue, 10 May 2022 08:34:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 0/2] sbitmap: NUMA node spreading
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1652181274-136198-1-git-send-email-john.garry@huawei.com>
 <1afd2c01-69b3-ab8f-6bfe-118e3e56001c@kernel.dk>
 <9ede7211-ae58-5cd4-4cf6-74c1f508f1a6@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <9ede7211-ae58-5cd4-4cf6-74c1f508f1a6@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/10/22 7:44 AM, John Garry wrote:
> On 10/05/2022 13:50, Jens Axboe wrote:
>>> fio config:
>>> bs=4096, iodepth=128, numjobs=10, cpus_allowed_policy=split, rw=read,
>>> ioscheduler=none
>>>
>>> Before:
>>> 7130K
>>>
>>> After:
>>> 7630K
>>>
>>> So a +7% IOPS gain.
> 
> Thanks for having a look.
> 
>> What does the comparison run on a non-NUMA non-shared queue look like?
>> Because I bet it'd be slower.
> 
> I could test more to get a solid result for that.
> 
>>
>> To be honest, I don't like this approach at all. It makes the normal
>> case quite a bit slower by having an extra layer of indirection for the
>> word, that's quite a bit of extra cost.
> 
> Yes, there is the extra load. I would hope that there would be a low
> cost, but I agree that we still want to avoid it. So prob no point in
> testing this more.

I don't think that's low cost at all. It's the very hot path, and you're
now not only doing an extra load, it's a dependent load - you need to
load both to make any progress. On top of that, it's not like it's two
loads from the same cacheline or even page. The most important thing for
performance these days is having good cache utilization, the patch as it
stands very much makes that a lot worse.

Besides, for any kind of performance work like that, it's customary to
showcase both the situation that is supposedly fixed or improved with
the change, but also to test that it didn't regress the existing
common/fast case.

>> It doesn't seem like a good
>> approach for the issue, as it pessimizes the normal fast case.
>>
>> Spreading the memory out does probably make sense, but we need to retain
>> the fast normal case. Making sbitmap support both, selected at init
>> time, would be far more likely to be acceptable imho.
> 
> I wanted to keep the code changes minimal for an initial RFC to test
> the water.
>
> My original approach did not introduce the extra load for normal path
> and had some init time selection for a normal word map vs numa word
> map, but the code grew and became somewhat unmanageable. I'll revisit
> it to see how to improve that.

Probably just needs some clean refactoring first, so that the actual
change can be pretty small.

-- 
Jens Axboe

