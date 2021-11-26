Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EDD45F513
	for <lists+linux-block@lfdr.de>; Fri, 26 Nov 2021 20:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhKZTUF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 26 Nov 2021 14:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhKZTSE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Nov 2021 14:18:04 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9FEC061A14
        for <linux-block@vger.kernel.org>; Fri, 26 Nov 2021 10:41:25 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id k1so9937564ilo.7
        for <linux-block@vger.kernel.org>; Fri, 26 Nov 2021 10:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dn3JlSLQT9unLajVMFXj26hJHVTESOPmLbf77Et5Cto=;
        b=UNjy/Jv4WKcXZelCIVYlBcimUg0Fp/9Y0SMcJdLYa7It/0ARpXcFAH7DXMGioH/USa
         FcmTsiNaR5DOOqqdIAZsb7zTEnFac9CelF5GI6Zh5xGDPZbn9pxHhbNl9DwaSQBq3NXB
         pg6xIt2AKWQBhpjx1jsxoBbD9fq79X6ab0ie1Dd8BIfNxzmtcyEhf2S8gfRCvhN10IyW
         X5GwEKylzoQhqasSxkkWHOwgjo0POyGVrNFu1RubvkX3RkoXf/T7vBIX8kdZVRwKBbcC
         6UfQH3R9tnOZrpyKI/ldw8y/aPZA5IKcMF6tutHL8gV9tGsdSNJzbcPEVcwzyZqWLMbb
         qlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dn3JlSLQT9unLajVMFXj26hJHVTESOPmLbf77Et5Cto=;
        b=I6XIG8n2C65swJ07MAIZqelL2xP6UKnGC0l1LProtFRRevkIVXeelbzauE8PqVfc9I
         iqcz6BBx1WG00lHJIKlr1Z1WzbX5+Mfiy9nW2pbYx4d0HyEx8Kms4pP8vyWn1Sb2YeYV
         iKizZBLOSiuW7tcICxjKtkN1uW5zO55nK/VuG3NYh38ZHHK4EWWRDQnqakgitD8TWnsL
         IIWU/XPjyimvONtLdCGbxfO9VVyIKdPcQJEwbhixE1W83/JG4QS3stQJ1Q0Hv8UuIKyR
         hevIIY8COiryeB2GfBzDK70CgWNZwTKgv2lQ9ur+Yg4+bJwjdxyhDssNUTg+HYIgPo3Y
         zG3g==
X-Gm-Message-State: AOAM5339OL5nqoXk28iwfACsK2KK4NTzGE61Vj0WCSae1oRYRuV/9Su5
        4/W5zXe0poG2Dgl/7tgvYeGvLA==
X-Google-Smtp-Source: ABdhPJzJK9pUIli5rOMIsOCySu1SxFt6BSM8IWUQXMeRmK3cP+2UPpMd/+bu06A3rIg3MRg5+wUwTQ==
X-Received: by 2002:a92:d38b:: with SMTP id o11mr33208142ilo.35.1637952085029;
        Fri, 26 Nov 2021 10:41:25 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id n12sm3981499ilk.80.2021.11.26.10.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 10:41:24 -0800 (PST)
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
 <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
 <903be817-4118-f34e-1b35-a0108045590f@kernel.dk>
 <986e942b-d430-783b-5b1c-4525d4a94e48@panix.com>
 <ddc41b84-c414-006a-0840-250281caf1e5@kernel.dk>
 <1ff86d55-f39d-f88b-b8d-b6dfbd2f1b19@panix.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a4d728c2-703d-66be-bffd-3bfde0fddf41@kernel.dk>
Date:   Fri, 26 Nov 2021 11:41:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1ff86d55-f39d-f88b-b8d-b6dfbd2f1b19@panix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/21 11:20 AM, Kenneth R. Crudup wrote:
> 
> On Fri, 26 Nov 2021, Jens Axboe wrote:
> 
>> I'd just do what you usually do, that's usually the best way to gain
>> confidence in the fix.
> ...
>> That said, I'm pretty confident in the fix,
> 
> OK, then I'll just continue my normal workflow.

Sounds good.

> ... but am I the first report of this you've seen? (I sometimes wonder how many
> people use the master branch as a daily driver; an -rc went out a couple of
> weeks ago that had a commit that broke suspend that manifested right away.)

https://lore.kernel.org/linux-block/20211126095352.bkbrvtgfcmfj3wkj@shindev/

There's another here from today. But this particular window has a pretty
narrow window, which often means that most people won't hit it, while the
people that do hit it all the time...

-- 
Jens Axboe

