Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46FC17201F
	for <lists+linux-block@lfdr.de>; Tue, 23 Jul 2019 21:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387978AbfGWTex (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Jul 2019 15:34:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39680 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbfGWTex (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 15:34:53 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so84379345ioh.6
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2019 12:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HC9PR3HC0XNWdkabk4UND96yybABreQPrLWbCiZycdU=;
        b=RdXequCWyR/MYSqoeWE3d4DVUYvWt1fsLVPUvc4/yXClPOv6ZH1oBt1z3F9vFnFc7j
         Lj/EemlmGQ3ZvawWDxi0OdLkvJFGenk7XmpL+CbNMqzmyrcBGuYX1hCgpNKWznzpTcgR
         OpHJAOuq9h/o+TBDRTrVRgma4vEk0u5LKGo6tkvhoVjZLtP7eAdS8MqdPXPv4dNiMgUn
         yJ5mptb5Qua5yHRvs4J8mnyCcmwg98hipsXMVp023D7H8/tj2WjJvwGBqrwKJiThn1CP
         /dvFvqref+R5OXx+n/QKk3m21C45oLPUmy28GAXZ+9KvtAR7ogW7ZCq71AlpoX/TSmi7
         X6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HC9PR3HC0XNWdkabk4UND96yybABreQPrLWbCiZycdU=;
        b=jxjHG3ssE+J3aIx4oF9VuEbh6fITC3OtCtmK6m9A5Fp1hapIMCKS5qziF33zi7UKSk
         oh6LmMMv6iN1IJhqwXcWz0rrGDWD3ZGkbMjd0QFrHgnJvT5t+iky9Uk5cvPhaEbFfGon
         o969ERDvhKWN6RSySlb93EhcJOEFKMTry2xl8oeLIFk3BwAKPcxgdZV0NcRh9HqIL8Vr
         b36QfChEOt8X7UNbq5TM8kOZEHx885epD0XTpeh3EB91z4SwcSZhu8KW50Pg00Wu+1OX
         l1n9twnEJWwK6v1QXDv7kymoWR7iUzY5ROShXtb/cF7yoCrPkF41hnJ1jhbaHg6Zs/0Y
         Usug==
X-Gm-Message-State: APjAAAVlkl6wPqegJKkUj1skSzXA5VEwW6wKuUxQ10YUNmFRM39XjRky
        waVdcVcysgfEQl3xeD0H2Ts=
X-Google-Smtp-Source: APXvYqzxE7jhc8AxcWQlAt3hGFl+0bPDjzWyakCps5e/JZAo++vrSZLfUDW31Xh0OBMnpBTpJsD9VA==
X-Received: by 2002:a6b:3883:: with SMTP id f125mr24197ioa.109.1563910492289;
        Tue, 23 Jul 2019 12:34:52 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w23sm39726873ioa.51.2019.07.23.12.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 12:34:51 -0700 (PDT)
Subject: Re: [PATCH] psi: annotate refault stalls from IO submission
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190722201337.19180-1-hannes@cmpxchg.org>
 <20190723000226.GV7777@dread.disaster.area>
 <20190723190438.GA22541@cmpxchg.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2d80cfdb-f5e0-54f1-29a3-a05dee5b94eb@kernel.dk>
Date:   Tue, 23 Jul 2019 13:34:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723190438.GA22541@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/23/19 1:04 PM, Johannes Weiner wrote:
> CCing Jens for bio layer stuff
> 
> On Tue, Jul 23, 2019 at 10:02:26AM +1000, Dave Chinner wrote:
>> Even better: If this memstall and "refault" check is needed to
>> account for bio submission blocking, then page cache iteration is
>> the wrong place to be doing this check. It should be done entirely
>> in the bio code when adding pages to the bio because we'll only ever
>> be doing page cache read IO on page cache misses. i.e. this isn't
>> dependent on adding a new page to the LRU or not - if we add a new
>> page then we are going to be doing IO and so this does not require
>> magic pixie dust at the page cache iteration level
> 
> That could work. I had it at the page cache level because that's
> logically where the refault occurs. But PG_workingset encodes
> everything we need from the page cache layer and is available where
> the actual stall occurs, so we should be able to push it down.
> 
>> e.g. bio_add_page_memstall() can do the working set check and then
>> set a flag on the bio to say it contains a memstall page. Then on
>> submission of the bio the memstall condition can be cleared.
> 
> A separate bio_add_page_memstall() would have all the problems you
> pointed out with the original patch: it's magic, people will get it
> wrong, and it'll be hard to verify and notice regressions.
> 
> How about just doing it in __bio_add_page()? PG_workingset is not
> overloaded - when we see it set, we can generally and unconditionally
> flag the bio as containing userspace workingset pages.
> 
> At submission time, in conjunction with the IO direction, we can
> clearly tell whether we are reloading userspace workingset data,
> i.e. stalling on memory.
> 
> This?

Not vehemently opposed to it, even if it sucks having to test page flags
in the hot path. Maybe even do:

	if (!bio_flagged(bio, BIO_WORKINGSET) && PageWorkingset(page))
		bio_set_flag(bio, BIO_WORKINGSET);

to at least avoid it for the (common?) case where multiple pages are
marked as workingset.

-- 
Jens Axboe

