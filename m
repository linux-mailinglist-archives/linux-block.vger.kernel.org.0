Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7238A5D41C
	for <lists+linux-block@lfdr.de>; Tue,  2 Jul 2019 18:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfGBQRR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Jul 2019 12:17:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40476 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBQRR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 12:17:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so7914349pgj.7
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2019 09:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eYzMbr9cvu8gkqBXI2fmVaq0IRnB3q2xvjTP6U8SYHc=;
        b=EOzLT9/tMYPOlES1RseG+vm6Qi0yyrtXFyLzaeudnpXaGrJ1G4Z6mHggqUmXn3Md5b
         gXTtJ7WiqQdir9DabXNlrNBum6TGcr8XMaYFS0c70RBtqaQF5oRbqLercRNf1wVqXGul
         27CNLVGWjfQgk3KZYziE9gmfLaFkkjUVZ2m4Oxg3I5XSizVjq2Avg+HeurO6qr7noOHy
         W22xtqn2VVpl8vwxTosGzl/j1miiY6v8pVLDBmehNFIJKKBbhHnzUPAb0nU8iDy5OtJ4
         5wf9B+qKzihpsIhGVJIAQ9rH/ZgwtNxmKYkP45i264zdRuSeirsuKant4VQC3rnPix/D
         Zpig==
X-Gm-Message-State: APjAAAWAt/S+9MPlYS7MkmxGVa5Xbi/UWfV7VluUNLbMQvDfObEgv0ut
        FB6PtJvmKEvFcjwBF+Ya0X7UHjFq6HE=
X-Google-Smtp-Source: APXvYqxBu5eO+57h3EfJhFytsyyaDYdBG5LZCOVE8aYTQKj1A6s7/Kiagh3hBIYEV87n70iN8C7CUQ==
X-Received: by 2002:a62:29c7:: with SMTP id p190mr80493pfp.218.1562084236551;
        Tue, 02 Jul 2019 09:17:16 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 65sm12941073pgf.30.2019.07.02.09.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 09:17:15 -0700 (PDT)
Subject: Re: [PATCH liburing 2/2] Fix the use of memory barriers
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>
References: <20190701214232.29338-1-bvanassche@acm.org>
 <20190701214232.29338-3-bvanassche@acm.org>
 <5d5931e08e338a8a8edb1e58a33a120e@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <876fa5e3-f050-b95c-a30c-755d1e0430d1@acm.org>
Date:   Tue, 2 Jul 2019 09:17:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <5d5931e08e338a8a8edb1e58a33a120e@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/19 2:07 AM, Roman Penyaev wrote:
> Hi Bart,
> 
> On 2019-07-01 23:42, Bart Van Assche wrote:
> 
> ...
> 
>> +#if defined(__x86_64__)
>> +#define smp_store_release(p, v)            \
>> +do {                        \
>> +    barrier();                \
>> +    WRITE_ONCE(*(p), (v));            \
>> +} while (0)
>> +
>> +#define smp_load_acquire(p)            \
>> +({                        \
>> +    typeof(*p) ___p1 = READ_ONCE(*(p));    \
>> +    barrier();                \
>> +    ___p1;                    \
>> +})
> 
> Can we have these two macros for x86_32 as well?
> For i386 it will take another branch with full mb,
> which is not needed.
> 
> Besides that both patches looks good to me.

Hi Roman,

Thanks for having taken a look. From Linux kernel source file 
arch/x86/include/asm/barrier.h:

#ifdef CONFIG_X86_32
#define mb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)",\
		"mfence", X86_FEATURE_XMM2) ::: "memory", "cc")
#define rmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)",\
		"lfence", X86_FEATURE_XMM2) ::: "memory", "cc")
#define wmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)",\
		"sfence", X86_FEATURE_XMM2) ::: "memory", "cc")
#else
#define mb() 	asm volatile("mfence":::"memory")
#define rmb()	asm volatile("lfence":::"memory")
#define wmb()	asm volatile("sfence" ::: "memory")
#endif

In other words, I think that 32-bit and 64-bit systems really have to be 
treated in a different way.

Bart.
