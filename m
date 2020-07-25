Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD48922D7E5
	for <lists+linux-block@lfdr.de>; Sat, 25 Jul 2020 15:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgGYNjD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 25 Jul 2020 09:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgGYNjC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jul 2020 09:39:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13F4C08C5C0
        for <linux-block@vger.kernel.org>; Sat, 25 Jul 2020 06:39:02 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 207so6752932pfu.3
        for <linux-block@vger.kernel.org>; Sat, 25 Jul 2020 06:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TY9S0ksY0gJHg8WOxYnWVFJ79KubheFo7aJATivXmzk=;
        b=Xd0UQ0YgU7eSeirgLJWGWBxbU+KYNjUAsAm2rTJrtr75LiG0Cn/oOfC5UJ1HxDY13M
         qUxl5IzZP7C0MNB3vGIfTRY2qt3yXCRqagjINxYa5IBf1LJZXFtIGYueIIdcYai25+ih
         g6qnK37I0uv+gYlZydlAAq2NUAnW72r/VjCLuSGuMLxL2IXnJmx8p4Vje6KSuUbnsvOa
         TAN02cduHe5A6WA/qmA5td3OGiRQzT/pDJFQe/K9Ret6wBqz/FzaLMcMitwhl3cO1O1l
         4nzxIHIPyAExHOV9s1abWfWmj3+ikSmWFx0I47NiCwbNhIE34mGfMcUIVjQKiTFgQ6Fa
         P+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TY9S0ksY0gJHg8WOxYnWVFJ79KubheFo7aJATivXmzk=;
        b=laelqLiPmHOljYkt46pe8rEzDYlQ6Uw12tbc9iFPvNznGBKP+VWKNuPhRCpxsqugX2
         S95qg5MWxjmcgSD0J0pz5K9fL3FKMtsdsKdTTav24ldrmgMwyf/H9vW8g4fBpIIw0/Yr
         ZdPr06VYNqCFNpLhnJdzxn+SOeRwo/VVk/qeN0bNomoB5Q6ejazw0X2JQaS/5bYG8dhU
         V/6Gx6uDl4xV5sKo6L/UaeARZPoxsaOZL3oCg1ADHy7EI6QgUXCrhDnawRq2tns9vWdm
         7wMDa+ucX76qh5Wk6DsfQOjpbbLeJU+fCzf0d5U+mLPZ6wR/vDt9d8B2W/v0SwIyiXWF
         sWIw==
X-Gm-Message-State: AOAM530rvmD9kHWBkhJZ5nto76Ba3YwWAb0ThyEbLwtNLxYpMsNKtzhq
        WpogAaotUItNHWxVaQiV34lSKg==
X-Google-Smtp-Source: ABdhPJz2Gx0wKg1a/G6l9hILWNgeCCNZA/azxL2DSPyCDd2OtJQF3fKvbO1YfF39F2jZ4yMgt/TCew==
X-Received: by 2002:a62:5a45:: with SMTP id o66mr12366758pfb.43.1595684341950;
        Sat, 25 Jul 2020 06:39:01 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x7sm9625443pfq.197.2020.07.25.06.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2020 06:39:01 -0700 (PDT)
Subject: Re: [PATCH 00/25] bcache patches for Linux v5.9
To:     Coly Li <colyli@suse.de>
Cc:     linux-block@vger.kernel.org, linux-bcache@vger.kernel.org
References: <20200725120039.91071-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bbc97069-6d8f-d8c5-35b1-d85ccb2566df@kernel.dk>
Date:   Sat, 25 Jul 2020 07:39:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200725120039.91071-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/25/20 6:00 AM, Coly Li wrote:
> Hi Jens,
> 
> This is the first wave bcache series for Linux v5.9.
> 
> The most part of change is to add large_bucket size support to bcache,
> which permits user to extend the bucket size from 16bit to 32bit width.
> This is the initial state of large bucket feature, more improvement will
> happen in future versions.
> 
> Most of the patches from me are for the large_bucket feature, except for,
> - The fix for stripe size overflow
>    bcache: avoid nr_stripes overflow in bcache_device_init()
>    bcache: fix overflow in offset_to_stripe()
> - The fix to I/O account on wrong device
>    bcache: fix bio_{start,end}_io_acct with proper device
> 
> Also we have Gustavo A. R. Silva to contribute 2 patches to cleanup
> kzalloc() code by using struct_size(), Jean Delvare to contribute a
> typo fix in bcache Kconfig file, and Xu Wang to contribute two code
> cleanup patches.
> 
> Please take them for your Linux v5.9 block drivers branch.

Thanks, applied.

-- 
Jens Axboe

