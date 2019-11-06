Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC2F1F27
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2019 20:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfKFTn3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Nov 2019 14:43:29 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38783 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfKFTn3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 14:43:29 -0500
Received: by mail-il1-f193.google.com with SMTP id y5so22861268ilb.5
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2019 11:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fq9vErcTaf25MgmnIdQ2JQPtM0db2t652SngVUT5H5E=;
        b=DJl00mEc6G+PHVRRssOyzoFPVBf7f/dxZ8Rij86oXraqTX+2kBgyI/DKo2pFsfbYzG
         O+d9PPjnKldMMyee0nzTLqpqDch6qjHKoXFL+A1QsP/HX+7yewyjKyF2UsWwKWUuRb8W
         3figgESrsRRasY0UJTBozzzfyxz2kKxiHPVTKQoTODg5MBBN+pE0ckxVypOeCTdZLHUC
         eOIqusQbd12IvEepjvwWieWPRiTjhPWUMsfGUJ2JkXvgRUE7qDcrqmFf4T+keFwxhxK1
         umUsq2AWczUJa6X/uZNo25+fHg6Chu/WIc/MHxr87IzJGR7uPIuuyfAQ9ACwjhL9J2VM
         FxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fq9vErcTaf25MgmnIdQ2JQPtM0db2t652SngVUT5H5E=;
        b=Tu6ctc8WRO7Qx5ugOtL4P0D0IFiNdpPmZaH6PQ1ecqAkg8yJYGH2vF6xVTeFqxy3qQ
         JO6shnZxYD/7v5wVYJOMPSmIWyP4p3FkOiJysRwo3YHCcu6WfUL3velfgwgQzcytEUgy
         itssskRW26TCojHNvKbrtxXuoD4R4tc66nXdon84sYsETxbQ9iqmGF83fPwz1qGb60Ox
         BSINE2jQEl+C7TmwRM+Y6cSzAvt2TyYsL8BndXxsIRnExFAq3y3QA+XPa3N7JTsQHyqk
         RxTEqKi0tSgqZ6rXZjsnL8KjP0QKP7NfB3TKtIqdWy6yCqB5tfzHcU1YFzK0NeR4+KsR
         nHGQ==
X-Gm-Message-State: APjAAAUXoEJRxDNJQmbWYGOYx6u0fRKneV5dVZxy1goh6o3CtEFGWOYt
        2ruPIo65+YDnjHZBwZti/C1RcWXD3Lk=
X-Google-Smtp-Source: APXvYqxIZCP7ENHcLDRaGy8ZU4ecdCSWN5fa6yA5qr5KAD9KuQ63i7Fg5Nrn9RQxJ3cJRKwadD4LXA==
X-Received: by 2002:a92:881c:: with SMTP id h28mr4797423ild.289.1573069406223;
        Wed, 06 Nov 2019 11:43:26 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l64sm3596815ilh.2.2019.11.06.11.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 11:43:25 -0800 (PST)
Subject: Re: [RFC] io_uring CQ ring backpressure
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <37d8ba3d-27c7-7636-0343-23ec56e4bee7@kernel.dk>
 <412439b3-5626-f016-71e7-6100e7a6feef@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <666db8fa-0483-321e-ba2c-a1a9ddf15a6d@kernel.dk>
Date:   Wed, 6 Nov 2019 12:43:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <412439b3-5626-f016-71e7-6100e7a6feef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/6/19 12:12 PM, Pavel Begunkov wrote:
> On 06/11/2019 19:21, Jens Axboe wrote:
>> Currently we drop completion events, if the CQ ring is full. That's fine
>> for requests with bounded completion times, but it may make it harder to
>> use io_uring with networked IO where request completion times are
>> generally unbounded. Or with POLL, for example, which is also unbounded.
>>
>> This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a bit
>> for CQ ring overflows. First of all, it doesn't overflow the ring, it
>> simply stores backlog of completions that we weren't able to put into
>> the CQ ring. To prevent the backlog from growing indefinitely, if the
>> backlog is non-empty, we apply back pressure on IO submissions. Any
>> attempt to submit new IO with a non-empty backlog will get an -EBUSY
>> return from the kernel.
>>
>> I think that makes for a pretty sane API in terms of how the application
>> can handle it. With CQ_NODROP enabled, we'll never drop a completion
>> event (well unless we're totally out of memory...), but we'll also not
>> allow submissions with a completion backlog.
>>
>> ---
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index b647cdf0312c..12e9fe2479f4 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -207,6 +207,7 @@ struct io_ring_ctx {
>>   
>>   		struct list_head	defer_list;
>>   		struct list_head	timeout_list;
>> +		struct list_head	cq_overflow_list;
>>   
>>   		wait_queue_head_t	inflight_wait;
>>   	} ____cacheline_aligned_in_smp;
>> @@ -414,6 +415,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>>   
>>   	ctx->flags = p->flags;
>>   	init_waitqueue_head(&ctx->cq_wait);
>> +	INIT_LIST_HEAD(&ctx->cq_overflow_list);
>>   	init_completion(&ctx->ctx_done);
>>   	init_completion(&ctx->sqo_thread_started);
>>   	mutex_init(&ctx->uring_lock);
>> @@ -588,6 +590,77 @@ static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
>>   	return &rings->cqes[tail & ctx->cq_mask];
>>   }
>>   
>> +static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
>> +{
>> +	if (waitqueue_active(&ctx->wait))
>> +		wake_up(&ctx->wait);
>> +	if (waitqueue_active(&ctx->sqo_wait))
>> +		wake_up(&ctx->sqo_wait);
>> +	if (ctx->cq_ev_fd)
>> +		eventfd_signal(ctx->cq_ev_fd, 1);
>> +}
>> +
>> +struct cqe_drop {
>> +	struct list_head list;
>> +	u64 user_data;
>> +	s32 res;
>> +};
> 
> How about to use io_kiocb instead of new structure?
> It already has valid req->user_data and occasionaly used
> req->result. But this would probably take more work to do.

I did consider that, we could use both those fields. But we can't just
take ownership of the io_kiocb at this point, so it's much easier (and
less error prone) to just stuff in this new structure. The downside is
of course that we could still have an overflow, but if an atomic
allocation of this size fails, then the system is hosed anyway.

This is also a somewhat more slow path. We don't really expect to have
constant overflows, but we need to be able to handle them. Otherwise CQ
ring sizing must be worst case, and maybe that isn't even enough. This
allows use cases that we could not support before.

>> @@ -3036,8 +3108,10 @@ static int io_sq_thread(void *data)
>>   		}
>>   
>>   		to_submit = min(to_submit, ctx->sq_entries);
>> -		inflight += io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm,
>> -					   true);
>> +		ret = io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm, true);
>> +		if (ret < 0)
>> +			continue;
>> +		inflight += ret;
>>   
> 
> After rebase could be simplified to
> if (ret >= 0)
> 	inflight += ret;

Heh, that's exactly that I did:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring-test&id=f491ca28c78b7ff2dcd288847a212bb49f256500

Thanks for the review!

-- 
Jens Axboe

