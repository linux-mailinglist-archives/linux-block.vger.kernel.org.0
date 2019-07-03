Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 416095D647
	for <lists+linux-block@lfdr.de>; Tue,  2 Jul 2019 20:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfGBSkE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Jul 2019 14:40:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:36814 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbfGBSkE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jul 2019 14:40:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E40EB17C;
        Tue,  2 Jul 2019 18:40:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 02 Jul 2019 20:40:03 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH liburing 2/2] Fix the use of memory barriers
In-Reply-To: <876fa5e3-f050-b95c-a30c-755d1e0430d1@acm.org>
References: <20190701214232.29338-1-bvanassche@acm.org>
 <20190701214232.29338-3-bvanassche@acm.org>
 <5d5931e08e338a8a8edb1e58a33a120e@suse.de>
 <876fa5e3-f050-b95c-a30c-755d1e0430d1@acm.org>
Message-ID: <723180510314b2928ba97752e5383202@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-07-02 18:17, Bart Van Assche wrote:
> On 7/2/19 2:07 AM, Roman Penyaev wrote:
>> Hi Bart,
>> 
>> On 2019-07-01 23:42, Bart Van Assche wrote:
>> 
>> ...
>> 
>>> +#if defined(__x86_64__)
>>> +#define smp_store_release(p, v)            \
>>> +do {                        \
>>> +    barrier();                \
>>> +    WRITE_ONCE(*(p), (v));            \
>>> +} while (0)
>>> +
>>> +#define smp_load_acquire(p)            \
>>> +({                        \
>>> +    typeof(*p) ___p1 = READ_ONCE(*(p));    \
>>> +    barrier();                \
>>> +    ___p1;                    \
>>> +})
>> 
>> Can we have these two macros for x86_32 as well?
>> For i386 it will take another branch with full mb,
>> which is not needed.
>> 
>> Besides that both patches looks good to me.
> 
> Hi Roman,
> 
> Thanks for having taken a look. From Linux kernel source file
> arch/x86/include/asm/barrier.h:
> 
> #ifdef CONFIG_X86_32
> #define mb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)",\
> 		"mfence", X86_FEATURE_XMM2) ::: "memory", "cc")
> #define rmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)",\
> 		"lfence", X86_FEATURE_XMM2) ::: "memory", "cc")
> #define wmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)",\
> 		"sfence", X86_FEATURE_XMM2) ::: "memory", "cc")
> #else
> #define mb() 	asm volatile("mfence":::"memory")
> #define rmb()	asm volatile("lfence":::"memory")
> #define wmb()	asm volatile("sfence" ::: "memory")
> #endif
> 
> In other words, I think that 32-bit and 64-bit systems really have to
> be treated in a different way.

I meant smp_load_acquire / smp_store_release

--
Roman

