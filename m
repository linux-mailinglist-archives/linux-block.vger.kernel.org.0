Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6020825DCCD
	for <lists+linux-block@lfdr.de>; Fri,  4 Sep 2020 17:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgIDPGy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 4 Sep 2020 11:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730137AbgIDPGy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Sep 2020 11:06:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052BBC061245
        for <linux-block@vger.kernel.org>; Fri,  4 Sep 2020 08:06:54 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t7so181078pjd.3
        for <linux-block@vger.kernel.org>; Fri, 04 Sep 2020 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hlEjALJyt1K/75tjEOKRvapkLS2P0DesGjPj2dfwGLo=;
        b=VysYSopEx+s6Tcr6FJ00Vv6ltUZrQfNwFVPnDWwQwW/WdHv5pLHYwXIgtVvMwDHO4c
         bsGzBDLE+kQQW2x4NypOyBCaVCAhK6oRxc4pfASp1rCek8SqljYjSAKIiX4DB4BKl8Gz
         HyD7cyM+fe/eiAyiRlPxqzpYj1a/xheCjcVP5bja4onwMboVG0tPNK4i5PzEQpegBpU+
         cQdeOpKOsx/iANhI3njgtgkmLT/pyBb0y5g+Y+AxAl6E+NuC65YpUxyiWrimojm1spEL
         UCZQcLZzk/2STRZu6QUM1VRMo46y0Rr8igYh/7LCC95NW9iPBSd5STEZc+Zm/sUtDwNr
         aOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hlEjALJyt1K/75tjEOKRvapkLS2P0DesGjPj2dfwGLo=;
        b=dYjpwSPEof7s2b7mTfe2yFgqv/C0nMOLxzF4v19MYnbV6DtPNf9sTiaRnxeAW6SsyD
         r2vaqfQmCXA8d4Fz28YthkWEvyQ7BKnkGpq7nIwGl8j+FiDQh7HGR4EFaZSFouUsPRAU
         TOymLwoSWZ1+oENLxRqC2U5aIo8h7p4F+CyYxu03NU5sTyy7QtvtAViTU/BniSwFzsZA
         jWqZj4dwgSkqkYoBkVhqpXA94WHsZJI+eWibYYm3AxpI1l8YruJ/0IqBn0xEJV5/kiTA
         UCWLHG4c0azgNUaxa+vzx079A5u+WGLZ0wQBqbMVhkfnRDDxTfHLR6bRGaNBAykuwlzA
         TcBw==
X-Gm-Message-State: AOAM532XwWmRTtmcCoHH2F2UL0Nz5u6GdIOjSF1Xk31wi+522WoCCn07
        QtBNDu6KmwK5yNy8W5s4iKe5XQ==
X-Google-Smtp-Source: ABdhPJyBoZFtPxyA2bnq1XuDpA3JKHAzZ66DVMHoj2ocd7tv29lxL2IJVZge2jlxFadHSDxGjZY6FQ==
X-Received: by 2002:a17:90a:714b:: with SMTP id g11mr8933468pjs.216.1599232012910;
        Fri, 04 Sep 2020 08:06:52 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21cf::1188? ([2620:10d:c090:400::5:1a09])
        by smtp.gmail.com with ESMTPSA id w203sm2568619pff.0.2020.09.04.08.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 08:06:52 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=f0=9f=92=a5_PANICKED=3a_Test_report_for_kernel_5?=
 =?UTF-8?Q?=2e9=2e0-rc3-020ad03=2ecki_=28block=29?=
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        linux-block@vger.kernel.org, Changhui Zhong <czhong@redhat.com>,
        Rachel Sibley <rasibley@redhat.com>,
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
References: <cki.538AE6A321.BMB0X5ZYG5@redhat.com>
 <0f92c40e-b234-896c-0810-af36ee95e259@redhat.com>
 <18db2772-3f37-55a7-d92e-dbcbe92d2cc4@kernel.dk>
 <ad1bf306-6f23-9b7c-842f-766a6efbda3e@redhat.com>
 <1300213431.10047993.1599163090152.JavaMail.zimbra@redhat.com>
 <cc956f4c-9b71-2b02-80be-dd387316dad8@kernel.dk>
 <20200904032244.GA808936@T590>
 <9066ba15-f60e-50af-719b-691651449cf4@kernel.dk>
 <20200904042403.GB808936@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1d26e821-9971-201c-3293-8990bb460a58@kernel.dk>
Date:   Fri, 4 Sep 2020 09:06:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904042403.GB808936@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/3/20 10:24 PM, Ming Lei wrote:
> On Thu, Sep 03, 2020 at 09:37:40PM -0600, Jens Axboe wrote:
>> On 9/3/20 9:22 PM, Ming Lei wrote:
>>> It is one MD's bug, and percpu_ref_exit() may be called on one ref not
>>> initialized via percpu_ref_init(), and the following patch can fix the
>>> issue:
>>
>> I really (REALLY) think this should be handled by percpu_ref_exit(), if
> 
> OK, we can do that by return immediately from percpu_ref_exit() if
> percpu_count_ptr(ref) is 0 just like before.

Yep that's going to be a must, also see recent syzbot report that's the
same issue, just the core block parts instead.

>> it worked before. Otherwise you're just setting yourself up for a world
>> of pain with other users, and we'll be fixing this fallout for a while.
>> I don't want to carry that. So let's just make it do the right thing,
>> needing to do this:
>>
>>> +       if (mddev->writes_pending.percpu_count_ptr)
>>> +               percpu_ref_exit(&mddev->writes_pending);
>>
>> is really nasty.
> 
> Yeah, it is as mddev_init_writes_pending():
> 
>         if (mddev->writes_pending.percpu_count_ptr)
>                 return 0;
>         if (percpu_ref_init(&mddev->writes_pending, no_op,
>                             PERCPU_REF_ALLOW_REINIT, GFP_KERNEL) < 0)
>                 return -ENOMEM;

Indeed, that's another eye sore... No users should need to know about
these internals. Maybe add a percpu_ref_inited() or something to test
for it, at least that'd allow us to clean up these bad use cases after
the fact.

-- 
Jens Axboe

