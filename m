Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC8DBF2126
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2019 22:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfKFV4s (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Nov 2019 16:56:48 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:32787 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKFV4s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 16:56:48 -0500
Received: by mail-io1-f65.google.com with SMTP id j13so16826ioe.0
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2019 13:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jXRWNlhoZUV4NmBgsVoU1Xpd9lxr/fc4e/t6ZKErYuQ=;
        b=xMwFzRVWYx+pqfN8D4VBRXdAqY++dTQ9f0aqeE4HR4rkf56V86WNi6IKLMxBhI2HIL
         rups+e8lFH6uGEIExalGXDqHHF//biM3jFC1LF+M8F3Z/WHnG79ab7DuVD7CSVgAyGL2
         TCA4WgaG0VT6KdlP8Nr9AyMc/g5eQICRgpFb8eoXqZdM2vHJJM8LqilCrAgv57RtcgVf
         zY+WEAw4OnB41NdzfjoMOQ688Ngtc03Knh/LuUD4A6qOf/zKX/iwfpqrhm74LBw41FGa
         84lZdqooXvnn+NY41IwVihkXh8Chj4OAFU4D+UCROwg8L78DDrTrdhYH9+UENoz900eH
         ufbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jXRWNlhoZUV4NmBgsVoU1Xpd9lxr/fc4e/t6ZKErYuQ=;
        b=AAeUxmxJuVK4UYkDzJCUW5TjP+1FIg1/k42nWrLJ0hKJPeRuG/7e2bMCAYik0/j7de
         dwZH6dI7d1gZyDgTrfYJmhcJrfFQn1oeThpZGKRsSphj7eBpDdqzZdO+CB8uX58f6JyB
         6D7h72gsbBPTCcvW53Xb+hGRA7t0F4ZpVf39DMX/Q/1nDHg0C4lsXT5xTcL8soWB3Uf2
         CX5LX3lt9hi0VAGyp3Anok1QDXF4ckxpV9EdJoPY8wGwk5aqgW7NGqfAb6pXQDOy1YAo
         vAhctsZcmPjjbKQWaHApavZ3WXlpswmQMRW/G6x/xg3Lbc72XjgJnTTKb8mtsUimoz9R
         w3gg==
X-Gm-Message-State: APjAAAWnESH2ExemfevGW5kyH10RbqBf8r1NihrQ69pEgPztitqnIFV0
        oLPyyY6PWoEZ3S7WiC+qioho3qYgcbU=
X-Google-Smtp-Source: APXvYqxAa5QzGWtFs3ZXti5IGobSR+Z1LPfu7NOwjOZDcqFimG8k1T2+NwRVHDha8JzQqAgIc9h/Mg==
X-Received: by 2002:a5d:83d7:: with SMTP id u23mr26957726ior.27.1573077405883;
        Wed, 06 Nov 2019 13:56:45 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f145sm3554210ilh.48.2019.11.06.13.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 13:56:45 -0800 (PST)
Subject: Re: [RFC] io_uring CQ ring backpressure
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jann Horn <jannh@google.com>
Cc:     io-uring@vger.kernel.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <37d8ba3d-27c7-7636-0343-23ec56e4bee7@kernel.dk>
 <CAG48ez1_91Lk73sdpp1SiufOQShdP2zX6g9gMLW46gAvMioKOA@mail.gmail.com>
 <c01e91d3-0f20-00e9-e2c6-e4148f667fb6@kernel.dk>
 <7878d52d-d4bb-28e5-e8dc-87b2f0721b56@kernel.dk>
 <5b9e1953-0e32-150d-f607-39025bd1f034@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f98432cc-4e7f-9e95-8f76-d13f6a106ce1@kernel.dk>
Date:   Wed, 6 Nov 2019 14:56:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5b9e1953-0e32-150d-f607-39025bd1f034@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/6/19 2:54 PM, Pavel Begunkov wrote:
> On 07/11/2019 00:31, Jens Axboe wrote:
>> On 11/6/19 1:08 PM, Jens Axboe wrote:
>>> On 11/6/19 12:51 PM, Jann Horn wrote:
>>>> On Wed, Nov 6, 2019 at 5:23 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>> Currently we drop completion events, if the CQ ring is full. That's fine
>>>>> for requests with bounded completion times, but it may make it harder to
>>>>> use io_uring with networked IO where request completion times are
>>>>> generally unbounded. Or with POLL, for example, which is also unbounded.
>>>>>
>>>>> This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a bit
>>>>> for CQ ring overflows. First of all, it doesn't overflow the ring, it
>>>>> simply stores backlog of completions that we weren't able to put into
>>>>> the CQ ring. To prevent the backlog from growing indefinitely, if the
>>>>> backlog is non-empty, we apply back pressure on IO submissions. Any
>>>>> attempt to submit new IO with a non-empty backlog will get an -EBUSY
>>>>> return from the kernel.
>>>>>
>>>>> I think that makes for a pretty sane API in terms of how the application
>>>>> can handle it. With CQ_NODROP enabled, we'll never drop a completion
>>>>> event (well unless we're totally out of memory...), but we'll also not
>>>>> allow submissions with a completion backlog.
>>>> [...]
>>>>> +static void io_cqring_overflow(struct io_ring_ctx *ctx, u64 ki_user_data,
>>>>> +                              long res)
>>>>> +       __must_hold(&ctx->completion_lock)
>>>>> +{
>>>>> +       struct cqe_drop *drop;
>>>>> +
>>>>> +       if (!(ctx->flags & IORING_SETUP_CQ_NODROP)) {
>>>>> +log_overflow:
>>>>> +               WRITE_ONCE(ctx->rings->cq_overflow,
>>>>> +                               atomic_inc_return(&ctx->cached_cq_overflow));
>>>>> +               return;
>>>>> +       }
>>>>> +
>>>>> +       drop = kmalloc(sizeof(*drop), GFP_ATOMIC);
>>>>> +       if (!drop)
>>>>> +               goto log_overflow;
>>>>> +
>>>>> +       drop->user_data = ki_user_data;
>>>>> +       drop->res = res;
>>>>> +       list_add_tail(&drop->list, &ctx->cq_overflow_list);
>>>>> +}
>>>>
>>>> This could potentially consume moderately large amounts of atomic
>>>> memory quickly and without any guarantee that the memory will be freed
>>>> anytime soon, right? That seems moderately bad. Is there no way to
>>>> e.g. pre-reserve memory for completion events, or something like that?
>>>
>>> As soon as there's even one entry in that backlog, the ring won't accept
>>> anymore new IO. So I don't think it's a huge concern. If we pre-reserve,
>>> we haven't really made much progress in making sure we don't drop events,
>>> and we'll be tying up that memory all the time.
>>>
>>> The alternative, as Pavel also mentioned, is to re-use the io_kiocb
>>> for this. But that'll tie up more memory, and it's a bit tricky with
>>> the life times. Just because the request has completed doesn't mean
>>> that someone isn't still holding a reference to it, and who knows
>>> what they will do.
>>
>> OK, I took a stab at it, here's a brain dump of the "complications"
>>
>> 1) Some places now use __io_free_req() to drop both references, if we
>>     know we haven't issued a request yet. Needs double drop, not a big
>>     deal.
>> 2) Some ordering changes between io_put_req() and the fill/add event
>>     logic. Again not a huge deal, easy to spot.
>> 3) We have one failure case that does not have a request, exactly because
>>     we failed to allocate one. Don't look at that part in the below patch,
>>     I think what we should do here is just reserve a request for that case.
>>     It won't help with the submission, but it'll get it logged correctly
>>     for the overflow backlog. Any new submission can't proceed with that
>>     request in the overflow backlog anyway, so we need just the one.
>>     Not super pretty, but at least we can keep this out of the fast path,
>>     as the only one that will free this request is the overflow flush
>>     path.
>>
> 
> 2 (maybe partially) and 3 will hopefully be solved by the patchset
> removing passing sqe_submit. I'll resend it in a minute.

Please do, it'll definitely make a few things easier. Then I'll base the
cleanup/prep patch on top of that, and then the backpressure patch.

-- 
Jens Axboe

