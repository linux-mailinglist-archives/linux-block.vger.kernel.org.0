Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 384E310A816
	for <lists+linux-block@lfdr.de>; Wed, 27 Nov 2019 02:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbfK0Bqj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 26 Nov 2019 20:46:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39232 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfK0Bqj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 20:46:39 -0500
Received: by mail-pg1-f195.google.com with SMTP id b137so7647995pga.6
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2019 17:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D6t9Cwt+Vu79N9+2JsQ1/zQXaSAT/1qvtlCuPBuDo8A=;
        b=Zymz3q9jURrU5FWSHJlr1GHmy0KXKpQRbpaT+mpyCIM6X8m7MWlfItXpI12x1Tj7XT
         dm8zaLwcvx/77aFcBkQ14wMUJj45rJnAETXnDGW+JGXz9wBIR/WC60nrxRep2HXa5QBx
         PDfnahavm/RIb0AWaKn7QLEQFXzNxFYjt5mh+Pq0KhoXMuzMAYRUgL79PYpAz+rvm8J3
         UpAGtNjF5eDkdAAXhmbY3essF17yoBwSwTXfIEb2S71HqOUt32rlmshgBYAeLt9b4SnI
         jthVMSMJ2AmdKg9rkni1L985wJB4YcArZMCnorIAbeGVt7EAm6nGdVsUBJzHpYxocO0m
         5nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D6t9Cwt+Vu79N9+2JsQ1/zQXaSAT/1qvtlCuPBuDo8A=;
        b=QOLGg2PhxONUhbs6z6ka9gMldDP0Ul9N54oGRfUq6v3kwtmPBW3wkri72KpO9jqToj
         jBRBCCsQOsVyWT0dpY5V+jPYuAEgnkCq/6jixYUKAfiQQ0Pwy5mK0gjIzgs0kR7oqNUY
         hnFJTgxVS1A/g+VzXNAOOc0r5/7jdvVT/Gmp8PuBV8DEcBFLhIYHjqRkOUSqQ2tRAa8s
         OW/LGNvHr/59xjVR/3m2qM7F9oFK6IzNjpjFBv0SzaSfNKqNIloYKRgTTI3iWr13WyeU
         h6iILt2Jo7vpSKjzpW69GFODq1fov/71yipIhm51fL60Fm5/tibFgy4pAP8VzAxhcs78
         uMZw==
X-Gm-Message-State: APjAAAWFFh8QqL2sBVfzRDwTZo9YJz2X993hs/xzl8VFfgY08BpgcstT
        250OVJ24O/h0jYPEffs601EYpuRaUkw=
X-Google-Smtp-Source: APXvYqyCJKfzwwNPf310bwKtxlvevUZMBUOEBy9JduvNDkVO9b2zlRXIvUINsnf3eswEtAtOiRUx9w==
X-Received: by 2002:a63:4501:: with SMTP id s1mr1892695pga.5.1574819197761;
        Tue, 26 Nov 2019 17:46:37 -0800 (PST)
Received: from ?IPv6:2600:380:7746:eea0:4854:d740:64b2:1b9b? ([2600:380:7746:eea0:4854:d740:64b2:1b9b])
        by smtp.gmail.com with ESMTPSA id z29sm9533pge.21.2019.11.26.17.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 17:46:36 -0800 (PST)
Subject: Re: [PATCH 3/8] blk-mq: Use a pointer for sbitmap
To:     John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20191126091416.20052-1-hare@suse.de>
 <20191126091416.20052-4-hare@suse.de>
 <8f0522ee-2a81-c2ae-d111-3ff89ee6f93e@kernel.dk>
 <62838bca-cd3c-fccf-767c-76d8bea12324@huawei.com>
 <00a6d920-1855-c861-caa3-e845dcbe1fd8@kernel.dk>
 <baffb360-56c0-3da5-9a52-400fb763adbf@huawei.com>
 <9290eb7f-8d0b-8012-f9a4-a49c068def1b@kernel.dk>
 <157f3e58-1d16-cc6b-52aa-15a6e1ac828a@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1add0896-4867-12c5-4507-76526c27fb56@kernel.dk>
Date:   Tue, 26 Nov 2019 18:46:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <157f3e58-1d16-cc6b-52aa-15a6e1ac828a@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/19 11:08 AM, John Garry wrote:
> On 26/11/2019 17:25, Jens Axboe wrote:
>> On 11/26/19 10:23 AM, John Garry wrote:
>>> On 26/11/2019 17:11, Jens Axboe wrote:
>>>> On 11/26/19 9:54 AM, John Garry wrote:
>>>>> On 26/11/2019 15:14, Jens Axboe wrote:
>>>>>> On 11/26/19 2:14 AM, Hannes Reinecke wrote:
>>>>>>> Instead of allocating the tag bitmap in place we should be using a
>>>>>>> pointer. This is in preparation for shared host-wide bitmaps.
>>>>>>
>>>>>> Not a huge fan of this, it's an extra indirection in the hot path
>>>>>> of both submission and completion.
>>>>>
>>>>> Hi Jens,
>>>>>
>>>>> Thanks for having a look.
>>>>>
>>>>> I checked the disassembly for blk_mq_get_tag() as a sample - which I
>>>>> assume is one hot path function which you care about - and the cost of
>>>>> the indirection is a load instruction instead of an add, denoted by ***,
>>>>> below:
>>>>
>>>
>>> Hi Jens,
>>>
>>>> I'm not that worried about an extra instruction, my worry is the extra
>>>> load is from different memory. When it's embedded in the struct, we're
>>>> on the same cache line or adjacent.
>>>
>>> Right, so the earlier iteration of this series kept the embedded struct
>>> and we simply pointed at that, so I wouldn't expect a caching issue of
>>> different memory in that case.
>>
> 
> Hi Jens,
> 
>> That would be a much better solution for the common case, my concern
>> here is slowing down the fast path for device that don't need shared
>> tags.
>>
>> Would be interesting to check the generated code for that, ideally we'd
>> get rid of the extra load for that case, even if it is in the same
>> cacheline.
>>
> 
> I checked the disassembly and we still have the load instead of the add.
> 
> This is not surprising, as the compiler would not know for certain that
> we point to a field within the same struct. But at least we still should
> point to a close memory.
> 
> Note that the pointer could be dropped, which would remove the load, but
> then we have many if-elses which could be slower, not to mention that
> the blk-mq-tag code deals in bitmap pointers anyway.

It might still be worthwhile to do:

if (tags->ptr == &tags->__default)
	foo(&tags->__default);

to make it clear, as that branch will predict easily. If if can be done
in a nice enough fashion and not sprinkled everywhere, in some fashion.

Should be testable, though.

-- 
Jens Axboe

