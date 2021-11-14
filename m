Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1DC44FBB5
	for <lists+linux-block@lfdr.de>; Sun, 14 Nov 2021 22:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhKNVHF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 14 Nov 2021 16:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbhKNVGs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Nov 2021 16:06:48 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00047C061746
        for <linux-block@vger.kernel.org>; Sun, 14 Nov 2021 13:03:51 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id k1so14521077ilo.7
        for <linux-block@vger.kernel.org>; Sun, 14 Nov 2021 13:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0ip9qQ/u4QUXJg3D+FksBcZUmlcQDc65Po9w80w1ZF4=;
        b=46H4Cr1UNL40m37Tk4q5RVt6cYsjJq4Fx9008xDbfZNbJ/xcrfzPUkOwP1RVCVst0h
         fZLAje+b87aaKvJ9x6axY4Sm4JA2WquyIDtQQSOTh7D+x6xqhE9amD0FP34Mem/iLGod
         Efm1tL8/ZQQEDG/XTxOeG6CjENfDFKn/o7ZnmVLwWxB3mg8Yz9hw1XuJxSz31I/TGsLV
         LY059wSpMCZQHKRv9frfY4fOB6ktLo00femLCHr5cRjgyQB1Wy/SE28c4ZdbjjviACC9
         P0lVCnWFjFm0WS4ht65l67EykN/ddbYW1LhA/UTeiBYjvJY2wt/Ovcjwy9bVu2owu9+h
         TyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ip9qQ/u4QUXJg3D+FksBcZUmlcQDc65Po9w80w1ZF4=;
        b=Mdu5XxHIl3+gEVHFZwr95ufZBVNvncS4pWjAaE4IbF366xqQmLngufWjKYGjgOuQGC
         tTJFRh0ui/gV/Xj7PDgXUIIAQduaKFsHZBZH4Y6zM/9zsr5l+jdGtvCFUeWJCGI8F08C
         nPk9IhiqyE7d2/ny1R9mp7kaOONsp9iJiisa4lXVn9VUZhs1C793kBY89xM+4rJcPayk
         pi8zMTm2OvA4LxV2Lfhv55m/tuncQqCvyLJZ5aDY7uzn2o0d+1Q7PoDACtfYx0xmcTZG
         SzZfmmzTB5TEzHpShO6dh1AzO/Nytmh1+Zp4DoP9KA2b2cMCCmgdOnNSGGkn9yCy5yKH
         lb1Q==
X-Gm-Message-State: AOAM531XlE4SiRLdb9T7iQyAo5HxzcC7rDpbE308pn0Sk2G6QtE7br6k
        359umTfO57dcas3yOaV55NjIlg==
X-Google-Smtp-Source: ABdhPJyctzjAfpa3VD0odqC9dlG8ubmykPwmzxgT7DWg4OEvy8Qk8DhP9ASOLzRRB1t4YSzPrMU5HQ==
X-Received: by 2002:a92:360c:: with SMTP id d12mr19181644ila.172.1636923831387;
        Sun, 14 Nov 2021 13:03:51 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l2sm7966729ils.82.2021.11.14.13.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 13:03:51 -0800 (PST)
Subject: Re: uring regression - lost write request
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Daniel Black <daniel@mariadb.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, io-uring@vger.kernel.org
References: <CABVffEOpuViC9OyOuZg28sRfGK4GRc8cV0CnkOU2cM0RJyRhPw@mail.gmail.com>
 <e9b4d07e-d43d-9b3c-ac4c-f8b88bb987d4@kernel.dk>
 <1bd48c9b-c462-115c-d077-1b724d7e4d10@kernel.dk>
 <c6d6bffe-1770-c51d-11c6-c5483bde1766@kernel.dk>
 <bd7289c8-0b01-4fcf-e584-273d372f8343@kernel.dk>
 <6d0ca779-3111-bc5e-88c0-22a98a6974b8@kernel.dk>
 <281147cc-7da4-8e45-2d6f-3f7c2a2ca229@kernel.dk>
 <c92f97e5-1a38-e23f-f371-c00261cacb6d@kernel.dk>
 <CABVffEN0LzLyrHifysGNJKpc_Szn7qPO4xy7aKvg7LTNc-Fpng@mail.gmail.com>
 <00d6e7ad-5430-4fca-7e26-0774c302be57@kernel.dk>
 <YZF5csKMKfKBeIyN@eldamar.lan>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <627629af-d8ed-416a-cbef-4d74bdeee031@kernel.dk>
Date:   Sun, 14 Nov 2021 14:03:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZF5csKMKfKBeIyN@eldamar.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/21 2:02 PM, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Sun, Nov 14, 2021 at 01:55:20PM -0700, Jens Axboe wrote:
>> On 11/14/21 1:33 PM, Daniel Black wrote:
>>> On Fri, Nov 12, 2021 at 10:44 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> Alright, give this one a go if you can. Against -git, but will apply to
>>>> 5.15 as well.
>>>
>>>
>>> Works. Thank you very much.
>>>
>>> https://jira.mariadb.org/browse/MDEV-26674?page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel&focusedCommentId=205599#comment-205599
>>>
>>> Tested-by: Marko Mäkelä <marko.makela@mariadb.com>
>>
>> Awesome, thanks so much for reporting and testing. All bugs are shallow
>> when given a reproducer, that certainly helped a ton in figuring out
>> what this was and nailing a fix.
>>
>> The patch is already upstream (and in the 5.15 stable queue), and I
>> provided 5.14 patches too.
> 
> FTR, I cherry-picked as well the respective commit for Debian's upload
> of 5.15.2-1~exp1 to experimental as
> https://salsa.debian.org/kernel-team/linux/-/commit/657413869fa29b97ec886cf62a420ab43b935fff

Great thanks, you're beating stable :-)

-- 
Jens Axboe

