Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04D21123B66
	for <lists+linux-block@lfdr.de>; Wed, 18 Dec 2019 01:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfLRAPu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Dec 2019 19:15:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38141 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLRAPt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 19:15:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id a33so219245pgm.5
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 16:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YQMmzMY37i2Mof3lbYfpF5chISi7sMrvZ/ycgoxfAyA=;
        b=w1cqjlIYrAIkEphkj7SjLigIfIMzBn0DtSSscagQOjaBWS1xVHc9HO7ue1501V9FuR
         YAPsJDbP/asVmSC7PQlSEbkOqHc1WzR1NP0129mG6G7x0gNohKSh+76V7lIuFMObyPED
         kX32//b8ctPM3sgFXfm6SqxiXLt4eHljSLIoDruli2RsZXHQb3Hru+To3T8wt/OVW9AH
         bIxjtLX/riBfARkhw23oslkfo1EJwHIYkL6X/8rwC+IGGpSZFtqlw5t5cyrvcvoyNAJr
         uGxkFiYtrGCxH5f/QylLn/0O3f7JM0VkzNVKEBxeGUGQSFsI3xXayhR6xzo3KZSR99zA
         Cf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YQMmzMY37i2Mof3lbYfpF5chISi7sMrvZ/ycgoxfAyA=;
        b=bbiGd5T6WpgWptgEOfzCFU1RE/1lWOI1dapIxJ5TonfyoO/UDYX1mXecdHiqdHARKW
         vbFdp66xVvPlShnh6YRXiL+lE8F/NgZjNi2/ykrOn9YdL5K2St4e55EKRe3CzlFcGhrJ
         uWOt4/FyEApJfDjjbkZgU994OE4UwI7WmWdtFNJtLStWpZEYE4rLhtcU0gmJHKogMDh9
         +hEcHl542tTtdCmBRouek4hT3woMe78y4MbH+CBhD6xL2pY/5lypJrIRNYkUxLa8F1YS
         Fx9eOJGfsEPkbfaO0YpxfGzscdXjVoEtKOGVpaqI3X/OExN9gcFEp1Cqpr+mbI3BxUAR
         zebA==
X-Gm-Message-State: APjAAAXKPVTjpJxeBBHk/lvpyhRNX6pvf8o6klO6aBMDuq7xf220sUR5
        vE8OUk0+rJc4Ybg1mFauvbnbSg==
X-Google-Smtp-Source: APXvYqyg4gmsFwb+g+QqPm6sNT4veLef7n1AMHYvnq9f2ULLZNauq5tLOQMsMKSXl1ieZQsQbjMe9w==
X-Received: by 2002:a65:6216:: with SMTP id d22mr80575pgv.437.1576628148980;
        Tue, 17 Dec 2019 16:15:48 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::13f4? ([2620:10d:c090:180::6446])
        by smtp.gmail.com with ESMTPSA id l186sm161084pge.31.2019.12.17.16.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 16:15:48 -0800 (PST)
Subject: Re: [PATCH 4/6] iomap: add struct iomap_ctx
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>
References: <20191217143948.26380-1-axboe@kernel.dk>
 <20191217143948.26380-5-axboe@kernel.dk>
 <CAHk-=wgcPAfOSigMf0xwaGfVjw413XN3UPATwYWHrss+QuivhQ@mail.gmail.com>
 <CAHk-=wgvROUnrEVADVR_zTHY8NmYo-_jVjV37O1MdDm2de+Lmw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9941995e-19c5-507b-9339-b8d2cb568932@kernel.dk>
Date:   Tue, 17 Dec 2019 17:15:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgvROUnrEVADVR_zTHY8NmYo-_jVjV37O1MdDm2de+Lmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/19 1:26 PM, Linus Torvalds wrote:
> On Tue, Dec 17, 2019 at 11:39 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> 'loff_t length' is not right.
> 
> Looking around, it does seem to get used that way. Too much, though.
> 
>>> +       loff_t pos = data->pos;
>>> +       loff_t length = pos + data->len;
>>
>> And WTH is that? "pos + data->len" is not "length", that's end. And this:
>>
>>>         loff_t end = pos + length, done = 0;
>>
>> What? Now 'end' is 'pos+length', which is 'pos+pos+data->len'.
> 
> But this is unrelated to the crazy types. That just can't bve right.

Yeah, I fixed that one up, that was my error.

>> Is there some reason for this horrible case of "let's allow 64-bit sizes?"
>>
>> Because even if there is, it shouldn't be "loff_t". That's an
>> _offset_. Not a length.
> 
> We do seem to have a lot of these across filesystems. And a lot of
> confusion. Most of the IO reoutines clearly take or return a size_t
> (returning ssize_t) as the IO size. And then you have the
> zeroing/truncation stuff that tends to take loff_t. Which still smells
> wrong, and s64 would look like a better case, but whatever.
> 
> The "iomap_zero_range() for truncate" case really does seem to need a
> 64-bit value, because people do the difference of two loff_t's for it.
> In fact, it almost looks like that function should take a "start ,
> end" pair, which would make loff_t be the _right_ thing.
> 
> Because "length" really is just (a positive) size_t normally.

Honestly, I'd much rather leave the loff_t -> size_t/ssize_t to
Darrick/Dave, it's really outside the scope of this patch, and I'd
prefer not to have to muck with it. They probably feel the same way!

-- 
Jens Axboe

