Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7331191ED8
	for <lists+linux-block@lfdr.de>; Wed, 25 Mar 2020 03:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgCYCKr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Mar 2020 22:10:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38128 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgCYCKr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 22:10:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id x7so395628pgh.5
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2020 19:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2G7HyyAUCMvTRRqYv5M0bsEQtQlNMh/QkxpcRsDEGEc=;
        b=VoL1bFgSBCsnKC6O+oOK2OAh0OqQa3pkauC+i92U5pWuqr9dSMHtyvlpIPONvOR8rC
         FmnQ1+a6MpBjf24DxYDBcbjEKxmhk0+Gyvz8og6pLkr7/77SKKsvTcgYmhiukbRG4WJl
         4SLKok01e5EUhuIuUgemM44eXPAtmt12x94XJzr9ittsx1OGhcNDfhE5eKZ6DXnGVCQ3
         S9ovjqeV3IjJP91NVnkjU4MJ0Jtf7fft1lXPih08f7lt4kh2VeVMkYM+byGXmURhAVvH
         pmCe3Fszc0tOZnFYzR5YrDafOy6evJbj1EMFb1i8w1r5kx/gx1Ax9viLP8Ymch2xgwK/
         CMIg==
X-Gm-Message-State: ANhLgQ3bic4UioRuCohZWfHyT788MdXkUlcW5jn8haddXj0TeTlaJWzl
        vJRKXolc9nycIWd+aBkd9Sg=
X-Google-Smtp-Source: ADFU+vuNvzV1+DNDtwqojqMZU12aMUSAoL/OAQcZO0+hRnsla4GGYw0HfAXFuOu/WpSNYZ1ultQ4VA==
X-Received: by 2002:a62:d407:: with SMTP id a7mr840673pfh.57.1585102245501;
        Tue, 24 Mar 2020 19:10:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:5d47:ccb1:eaa5:8a3c? ([2601:647:4000:d7:5d47:ccb1:eaa5:8a3c])
        by smtp.gmail.com with ESMTPSA id f69sm17376622pfa.124.2020.03.24.19.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 19:10:44 -0700 (PDT)
Subject: Re: [PATCH blktests v3 4/4] Add a test that triggers the
 blk_mq_realloc_hw_ctxs() error path
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20200320222413.24386-1-bvanassche@acm.org>
 <20200320222413.24386-5-bvanassche@acm.org>
 <20200323112909.wrbnlvdioe37mni7@beryllium.lan>
 <e4248d0c-445d-55b2-36c7-05b453f6d343@acm.org>
 <20200324104132.kihzqmgrcel3ufco@beryllium.lan>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <9c9aaf03-a8c7-03a1-16cd-128b05a0c6b2@acm.org>
Date:   Tue, 24 Mar 2020 19:10:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324104132.kihzqmgrcel3ufco@beryllium.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-03-24 03:41, Daniel Wagner wrote:
> Hi Bart,
> 
> On Mon, Mar 23, 2020 at 08:09:27PM -0700, Bart Van Assche wrote:
>> On 2020-03-23 04:29, Daniel Wagner wrote:
>>> On Fri, Mar 20, 2020 at 03:24:13PM -0700, Bart Van Assche wrote:
>>>> +test() {
>>>> +	local i sq=/sys/kernel/config/nullb/nullb0/submit_queues
>>>> +
>>>> +	: "${TIMEOUT:=30}"
>>>> +	if ! _init_null_blk nr_devices=0 queue_mode=2 "init_hctx=$(nproc),100,0,0"; then
> 
>>From the kernel code:
> 
> 	/* "<interval>,<probability>,<space>,<times>" */
> 
> Don't you need to set the times attribute to -1 in order to inject the
> everytime the interval is reached? If I understood it correctly,
> with times=0 no failure is injected.
> 
> BTW, I've had to change it to init_hctx=$(($(nproc)+1)) to pass
> the initial __configure_null_blk call before the first fail hits.

Hi Daniel,

I will make both changes in the init_hctx string. Not sure how this
escaped from my attention.

>>> Doesn't make the $(nproc) the test subtil depending on the execution
>>> environment?
>> The value $(nproc) has been chosen on purpose. The following code from
>> the test script:
>>
>> +			echo 1 >$sq
>> +			nproc >$sq
>>
>> triggers (nproc + 1) calls to null_init_hctx().So injecting a failure
>> after (nproc) null_init_hctx() calls triggers the following pattern:
>> * The first blk_mq_realloc_hw_ctxs() call fails after (nproc - 1)
>> null_init_hctx() calls.
>> * The second blk_mq_realloc_hw_ctxs() call fails after (nproc - 2)
>> null_init_hctx() calls.
>> ...
>> * The (nproc) th blk_mq_realloc_hw_ctxs() call fails after one
>> null_init_hctx() call.
>> * The (nproc + 1) th blk_mq_realloc_hw_ctxs() call succeeds.
>>
>> I'm not sure to trigger this behavior without using the $(nproc) value?
> 
> Okay, I get the idea how you want to test.
> 
> Is the dependency on nproc because null_blk expects submit_queue <= online
> cpus?

That's correct. I want to test with the maximum number of submit queues
allowed, hence the use of $(nproc).

> Though why the 100?
> 
> 		for ((i=0;i<100;i++)); do
> 			echo 1 >$sq
> 			nproc >$sq
> 		done

No particular reason other than "a significant number of iterations".

> And shouldn't be there a test for error?

All I want to test is the absence of kernel crashes. The blktests
framework already inspects dmesg for the absence of kernel crashes. So I
don't think that I have to check whether or not the quoted sysfs writes
succeed.

Thanks,

Bart.
