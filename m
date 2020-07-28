Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA89122FF89
	for <lists+linux-block@lfdr.de>; Tue, 28 Jul 2020 04:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgG1CXT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Jul 2020 22:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgG1CXS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 22:23:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441B8C061794
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 19:23:18 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so9134829plk.1
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 19:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lNH1NYbUVc5zuSMDLmBacK4vanWB5H7USzQ7gMT9cT4=;
        b=X64vyxCn2fxmc6y+JkjyPeT/TAJdTSWExdDQUQwKUybUEhnQ4J7a2oqE+OSeNLALzK
         m9ifA6fUstcips6XPcJm6gpT1JHQMUTuP4za1FS7ls4iSWJj4EyfHOb34N16xINfJOLV
         kCGmIjeH3o4jEEaRYdxNuyXhXiTTUN4sKx1N4oepdXj+7tRlAklrSDhnLAesVVkY1Phk
         Lg66OGEE2hrW9Q2CXcHeIL7zKCJlLjeZortncyFAxY+uGOl0WbQiIxdWkin3eWu95zOG
         2M2KQvfpd9XRE1IW5vLPwJUOEAfeXI653DAtrWO9r3J7rw8qxRCoSRsJWlEfClu9AmFy
         xVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lNH1NYbUVc5zuSMDLmBacK4vanWB5H7USzQ7gMT9cT4=;
        b=d7KbFSn9bSTNEJtsOvn0o+xF0dO9gaQqQ3dTHipelq33Cmqcy0sx6m7MlDnbwF+YWj
         m1BHF6It8VcS96KUBLnLF1JndF9SHj/bglzwZ9605WpvV0PWrxy/ViE/xjdTtwsbO9fW
         RRbXUSn2l0CN3dZau2cpr00nJaerktbStKsYYW0g9QxKk+9VM6ONZvArP2efOI0cujP1
         L2SSmnNfYRlbSOD4owRhWr4AyeqIymsMl2YsAk/5+d/fEh1p5rRTx10CFsdMwZg4GRNK
         5wScj9kmUTge9L6am/GGeGGviG5bZoFc/lvgBH2x1X9CX5Y1JWKHb/afaR7VF47XXNPf
         Ls+w==
X-Gm-Message-State: AOAM532GulkQLS0GgQJFyKZmaGotnmD+hGWrqQ/4o4pwFGC6wYgn+dlu
        /Exrphru8hUsSRrsxX9wWc2Euhn5tRU=
X-Google-Smtp-Source: ABdhPJwMLZTKLOPqhALd98ixY8dCk8CL+dlP08rMmTtVJlLWoDagyMEG8TYC/fwfsZ49LhMNeuBaOA==
X-Received: by 2002:a17:90a:e017:: with SMTP id u23mr2030385pjy.179.1595902997709;
        Mon, 27 Jul 2020 19:23:17 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w18sm16165627pgj.31.2020.07.27.19.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 19:23:16 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Ming Lin <mlin@kernel.org>, Chao Leng <lengchao@huawei.com>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728014038.GA1305646@T590>
 <1d119df0-c3af-2dfa-d569-17109733ac80@kernel.dk>
 <20200728021744.GB1305646@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5fce2096-2ed2-b396-76a7-5fb8ea97a389@kernel.dk>
Date:   Mon, 27 Jul 2020 20:23:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728021744.GB1305646@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/20 8:17 PM, Ming Lei wrote:
> On Mon, Jul 27, 2020 at 07:51:16PM -0600, Jens Axboe wrote:
>> On 7/27/20 7:40 PM, Ming Lei wrote:
>>> On Mon, Jul 27, 2020 at 04:10:21PM -0700, Sagi Grimberg wrote:
>>>> drivers that have shared tagsets may need to quiesce potentially a lot
>>>> of request queues that all share a single tagset (e.g. nvme). Add an interface
>>>> to quiesce all the queues on a given tagset. This interface is useful because
>>>> it can speedup the quiesce by doing it in parallel.
>>>>
>>>> For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
>>>> in parallel such that all of them wait for the same rcu elapsed period with
>>>> a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
>>>> BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
>>>> sufficient.
>>>>
>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>> ---
>>>>  block/blk-mq.c         | 66 ++++++++++++++++++++++++++++++++++++++++++
>>>>  include/linux/blk-mq.h |  4 +++
>>>>  2 files changed, 70 insertions(+)
>>>>
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index abcf590f6238..c37e37354330 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -209,6 +209,42 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>>>>  
>>>> +static void blk_mq_quiesce_blocking_queue_async(struct request_queue *q)
>>>> +{
>>>> +	struct blk_mq_hw_ctx *hctx;
>>>> +	unsigned int i;
>>>> +
>>>> +	blk_mq_quiesce_queue_nowait(q);
>>>> +
>>>> +	queue_for_each_hw_ctx(q, hctx, i) {
>>>> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
>>>> +		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
>>>> +		if (!hctx->rcu_sync)
>>>> +			continue;
>>>
>>> This approach of quiesce/unquiesce tagset is good abstraction.
>>>
>>> Just one more thing, please allocate a rcu_sync array because hctx is
>>> supposed to not store scratch stuff.
>>
>> I'd be all for not stuffing this in the hctx, but how would that work?
>> The only thing I can think of that would work reliably is batching the
>> queue+wait into units of N. We could potentially have many thousands of
>> queues, and it could get iffy (and/or unreliable) in terms of allocation
>> size. Looks like rcu_synchronize is 48-bytes on my local install, and it
>> doesn't take a lot of devices at current CPU counts to make an alloc
>> covering all of it huge. Let's say 64 threads, and 32 devices, then
>> we're already at 64*32*48 bytes which is an order 5 allocation. Not
>> friendly, and not going to be reliable when you need it. And if we start
>> batching in reasonable counts, then we're _almost_ back to doing a queue
>> or two at the time... 32 * 48 is 1536 bytes, so we could only do two at
>> the time for single page allocations.
> 
> We can convert to order 0 allocation by one extra indirect array. 

I guess that could work, and would just be one extra alloc + free if we
still retain the batch. That'd take it to 16 devices (at 32 CPUs) per
round, potentially way less of course if we have more CPUs. So still
somewhat limiting, rather than do all at once.

-- 
Jens Axboe

