Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 865305D8C8
	for <lists+linux-block@lfdr.de>; Wed,  3 Jul 2019 02:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfGCA2s (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Jul 2019 20:28:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45751 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfGCA2s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 20:28:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so209433pgp.12
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2019 17:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Us77UaHLRVjrTB6MQwbk/01T666Qb+tu0urYtqWwkSg=;
        b=fKmVdX4rh6Cr7rwe2xOyzokZOEOwLIjcUswFHnPndHrQZ6cxcfvtzaT2r4yDJEBOxl
         u+6YulBOu8sS19UJbTkbNKQ0xqlI0hkDddZAm5YHtTFazGr5ctDU5L7kVmCAud1KCABF
         UFG2R+QS2wCDANL1WSEnjW6rKaCxlW1zCFG9kwwxHL59TJLw3IXWShSA4lBdlELneKJj
         znTtMsguTzAnBG1dNpdCaHgBnPbEOjEdxZNo0aslqiSj2bNtB0ztOoSzgSPxOVPGMqRf
         co/gN2PiaKY7gHEkEyJdzOA6pinMjuL38N23Y0aYx8mhw1zRIzFLouG4P648Xa9kPJtE
         uxwg==
X-Gm-Message-State: APjAAAViven5Ze2Vx7Qat99wJPCoAj0hUgG8mOSr0ZgiNytj4TGLLc7h
        5YwlQUFqWHtOxH6JMr9YM43JtGC2
X-Google-Smtp-Source: APXvYqwOEdHeHJUSr+Rs5BY4kgSUjVdyjIXRuLW7FDyC3on2xYq48qbvZfhr3p1+Klqb1Rf4S72WlQ==
X-Received: by 2002:a17:90a:ac11:: with SMTP id o17mr7858818pjq.134.1562099467562;
        Tue, 02 Jul 2019 13:31:07 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id e10sm15228702pfi.173.2019.07.02.13.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 13:31:05 -0700 (PDT)
Subject: Re: [PATCH liburing 2/2] Fix the use of memory barriers
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>
References: <20190701214232.29338-1-bvanassche@acm.org>
 <20190701214232.29338-3-bvanassche@acm.org>
 <5d5931e08e338a8a8edb1e58a33a120e@suse.de>
 <876fa5e3-f050-b95c-a30c-755d1e0430d1@acm.org>
 <723180510314b2928ba97752e5383202@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0bffbfd9-a57e-857f-4699-856295a11f3a@acm.org>
Date:   Tue, 2 Jul 2019 13:31:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <723180510314b2928ba97752e5383202@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/19 11:40 AM, Roman Penyaev wrote:
> On 2019-07-02 18:17, Bart Van Assche wrote:
>> On 7/2/19 2:07 AM, Roman Penyaev wrote:
>>> Hi Bart,
>>>
>>> On 2019-07-01 23:42, Bart Van Assche wrote:
>>>
>>> ...
>>>
>>>> +#if defined(__x86_64__)
>>>> +#define smp_store_release(p, v)            \
>>>> +do {                        \
>>>> +    barrier();                \
>>>> +    WRITE_ONCE(*(p), (v));            \
>>>> +} while (0)
>>>> +
>>>> +#define smp_load_acquire(p)            \
>>>> +({                        \
>>>> +    typeof(*p) ___p1 = READ_ONCE(*(p));    \
>>>> +    barrier();                \
>>>> +    ___p1;                    \
>>>> +})
>>>
>>> Can we have these two macros for x86_32 as well?
>>> For i386 it will take another branch with full mb,
>>> which is not needed.
>>>
>>> Besides that both patches looks good to me.
>>
>> Hi Roman,
>>
>> Thanks for having taken a look. From Linux kernel source file
>> arch/x86/include/asm/barrier.h:
>>
>> #ifdef CONFIG_X86_32
>> #define mb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)",\
>>         "mfence", X86_FEATURE_XMM2) ::: "memory", "cc")
>> #define rmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)",\
>>         "lfence", X86_FEATURE_XMM2) ::: "memory", "cc")
>> #define wmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)",\
>>         "sfence", X86_FEATURE_XMM2) ::: "memory", "cc")
>> #else
>> #define mb()     asm volatile("mfence":::"memory")
>> #define rmb()    asm volatile("lfence":::"memory")
>> #define wmb()    asm volatile("sfence" ::: "memory")
>> #endif
>>
>> In other words, I think that 32-bit and 64-bit systems really have to
>> be treated in a different way.
> 
> I meant smp_load_acquire / smp_store_release

Hi Roman,

Since there are 32-bit x86 CPUs that can reorder loads and stores I'm 
not sure it is safe to use the 64-bit smp_load_acquire() / 
smp_store_release() implementations for 32-bit CPUs. In case you would 
not yet have encountered this paper, a thorough discussion of the x86 
memory model is available in Sewell, Peter, Susmit Sarkar, Scott Owens, 
Francesco Zappa Nardelli, and Magnus O. Myreen. "x86-TSO: a rigorous and 
usable programmer's model for x86 multiprocessors." Communications of 
the ACM 53, no. 7 (2010): 89-97
(https://dl.acm.org/citation.cfm?id=1785443 / 
http://www.spinroot.com/spin/Doc/course/x86_tso.pdf).

Bart.
