Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 783F6FE727
	for <lists+linux-block@lfdr.de>; Fri, 15 Nov 2019 22:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfKOV0i (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 15 Nov 2019 16:26:38 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:39405 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfKOV0i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 16:26:38 -0500
Received: by mail-io1-f44.google.com with SMTP id k1so11987491ioj.6
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2019 13:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0xibZ013otwd37avQJB6w6rnfqu5PZISVC58dUyWTbE=;
        b=XUesHK2oLrShjkrEST268zIX1iSEvCuCDBovKsVuhUjctzKjpnRxIunz2cxl0NZTkz
         KvhGEXmM9sZCUVBgivmtFpa73kZUvAWM273p+2hadSG4/AzRruU9cTsUHZZxZUeOZlgx
         jJTeAT5YtKD87xOoe6ED9R5py9XfPLbWVVDqCsTZQTZmQEmvsMLVRwAobYpXcmsf5IqH
         UKVGOdI2ogCXkiTQ+uTEFH/7DLN2ucOT+ABKSTNKwB8SMr7fwWEC7S2kQyuvyhHS8X5b
         EwTKoyeRQrlrGZeO5IpDhOXX1SYlaAio8KOYzdZQo3g+fJS93fIp1fcpXrQlQ0RZsLLv
         6jaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0xibZ013otwd37avQJB6w6rnfqu5PZISVC58dUyWTbE=;
        b=a3ALspwlvI1mGovwGrQbEVshvHEt7meLtmPP1SUIpZhoSv3M175A2cfiX21aNAfgAP
         /RzE+7SgUTHZzsn+WdKpGjw7AbLg29mHFCnU0JErjXovKMBXId/FhhVu9cwCX4P9DKIs
         InBh/iXRuaq0AinF2h+EVUz4tEpMVzkM8FCgKHpBMfb/F9hVZFKMAc4CV08P1BtvWiFR
         KoiAh+BHYRqCsXPM2Gmj88DtXb3FyMrk02yyC503O0DjQaMd6kcKcmdwP9LarB8ewErc
         5h2o3JZckY56v0lqGzua3L5x5CKDE3ysFGJYdOnXuCZBcfblipdkFJMqFK2krUBznR+M
         919Q==
X-Gm-Message-State: APjAAAVE0x6YPrIRoLUPlC7E2jpYGpFaKIiPWLRy29HVAOu/fXgqjwXb
        GSN4zQKgX7nd74zq7N6PVm6TOg==
X-Google-Smtp-Source: APXvYqz2Cacn7i7KAkz/AoEXTLnQaChHCkubu6fpzisXWPKzQwgIYMpWH93aLxYNlDS0jy/sEmsBNw==
X-Received: by 2002:a05:6602:187:: with SMTP id m7mr2892095ioo.16.1573853196245;
        Fri, 15 Nov 2019 13:26:36 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z24sm1478582ioc.47.2019.11.15.13.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 13:26:35 -0800 (PST)
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
References: <20191105211130.6130-1-axboe@kernel.dk>
 <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
 <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
 <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>
 <178bae7d-3162-7de2-8bb8-037bac70469b@gmail.com>
 <d0f1065e-f295-6c0d-66cc-a424ec72751b@kernel.dk>
 <aabbed5f-db68-4a48-1596-28ac4110ce95@gmail.com>
 <2b35c1a0-69bf-1e50-8bda-2fff73bac8de@kernel.dk>
 <06929659-a545-87c8-fbf4-edfc01c69520@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <71860cea-313d-b6ef-895d-9635c73d7530@kernel.dk>
Date:   Fri, 15 Nov 2019 14:26:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <06929659-a545-87c8-fbf4-edfc01c69520@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/15/19 2:22 PM, Pavel Begunkov wrote:
> On 15/11/2019 22:34, Jens Axboe wrote:
>> How about something like this? Should work (and be valid) to have any
>> sequence of timeout links, as long as there's something in front of it.
>> Commit message has more details.
> 
> If you don't mind, I'll give a try rewriting this. A bit tight
> on time, so hopefully by this Sunday.
> 
> In any case, there are enough of edge cases, I need to spend some
> time to review and check it.

Of course, appreciate more eyes on this for sure. We'll see what happens
with 5.4 release, I suspect it won't happen until 11/24. In any case,
this is not really staged yet, just sitting in for-5.5/io_uring-post
as part of a series that'll likely go in after the initial merge.

> REQ1 -> LINKED_TIMEOUT -> REQ2 -> REQ3
> Is this a valid case? Just to check that I got this "can't have both" right.
> If no, why so? I think there are a lot of use cases for this.

Yes, it's valid. With the recently posted stuff, the only invalid case
is having a linked timeout as the first entry since that's nonsensical.
It has to be linked from a previous request. We no longer need to
restrict where the linked timeout appears otherwise.

-- 
Jens Axboe

