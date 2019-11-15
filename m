Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4637FFE779
	for <lists+linux-block@lfdr.de>; Fri, 15 Nov 2019 23:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfKOWP6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 15 Nov 2019 17:15:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37200 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfKOWP6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 17:15:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id z24so6623169pgu.4
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2019 14:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eKxh/c3BkAz0fq9C6YqvQEHWRtvFa9CSMWwDDGUgwq0=;
        b=CySj+Kj8Vurch1/bAXObQnlyUY+44AGMrFdZ9miofrz2kr9STw+C9npFGyvaIeRhz1
         8l5xxZ5G2vpXOFjBd4+TWccREy7zN0hRu8IMvoxhMwF2I0X8WQyo6HrG1QsaRgqXzktF
         mqFjCxLSHOgSijXn95ZjFutwNm+pp8mEYYl7ienRem3/IJ3PJ2Sk9GBVANfh3LUN5Nwe
         Jd/jnjbk45QgDR4MCFa6cw7JvyjANoBRbJa5P/1s89IWTZnridRBM8FeYeHqGvirsaSp
         7sysnkajvLJPim63lstCL5ABg6exZRHpHN4WRDiTR1R8BTzPIyp+FbPh34VHogEIEkcu
         dNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eKxh/c3BkAz0fq9C6YqvQEHWRtvFa9CSMWwDDGUgwq0=;
        b=QXi2EC12INRMay+rZ+jyTJYnGVmbOUY7BJ1GRQrXMGo7AvavGaz3+c3+a54OVPITLF
         JhZfAK7azTWVNCxUFDq7NiNxp89+GcDVw3S+XlHgYcNQMxZXsQz68/z5RJevWPVDB8Zn
         fhOS1zV1DEX7xhhkrU/uyYMpUXdqsKj9YbYthiVTX0ppUZw2w0288Z7AKNJNSf8wLwha
         9bxENLU9ZAmxyK6npuUA5pa5qKpx2vDzIcLYjcEpkHfTrDdoJo8w5/1TGc4+71XrHe0h
         ghRkCbod11kxOU9Jk1sriiQbyvP8f0oPVsGDebUjwbjmd6LX3Jpp8WBCsTSyr9c7rC3M
         Z+QQ==
X-Gm-Message-State: APjAAAVwBalxlri0vplRt3MbcYV1PT7NXrlS8sqYkDRTduG7+xxoE9QY
        5YfaeI97rtBlM4QwiRxMJJu8uQ==
X-Google-Smtp-Source: APXvYqynD37CfYnOEXIJY8IUwE0q+Z135SXF0xCFlJzHB5eM1ddNgLNhfMQMnwvBQOAKWJmoWtNV6A==
X-Received: by 2002:a65:60cf:: with SMTP id r15mr2000866pgv.53.1573856157148;
        Fri, 15 Nov 2019 14:15:57 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id m6sm4490899pgl.42.2019.11.15.14.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 14:15:56 -0800 (PST)
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
 <cdba1334-b037-d223-29a6-051bd49fef70@kernel.dk>
 <bde153ca-ff2a-8899-172e-0aa6359bff8c@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a35ad645-0340-62e4-fba7-7c1a080a9a65@kernel.dk>
Date:   Fri, 15 Nov 2019 15:15:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bde153ca-ff2a-8899-172e-0aa6359bff8c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/15/19 2:38 PM, Pavel Begunkov wrote:
> On 16/11/2019 00:16, Jens Axboe wrote:
>> On 11/15/19 12:34 PM, Jens Axboe wrote:
>>> How about something like this? Should work (and be valid) to have any
>>> sequence of timeout links, as long as there's something in front of it.
>>> Commit message has more details.
>>
>> Updated below (missed the sqe free), easiest to check out the repo
>> here:
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=for-5.5/io_uring-post
>>
>> as that will show the couple of prep patches, too. Let me know what
>> you think.
>>
> 
> Sure,
> 
> BTW, found "io_uring: make io_double_put_req() use normal completion
> path" in the tree. And it do exactly the same, what my patch was doing,
> the one which "blowed" the link test :)

Hah yes, you are right, you never did resend it though. I'll get
rid of the one I have, and replace with your original (but with
the arguments fixed).

> I'd add there "req->flags | REQ_F_FAIL_LINK" in-between failed
> io_req_defer() and calling io_double_put_req(). (in 2 places)
> Otherwise, even though a request failed, it will enqueue the rest
> of its link with io_queue_async_work().

Good point, updating now.

-- 
Jens Axboe

