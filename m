Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C171F2185
	for <lists+linux-block@lfdr.de>; Mon,  8 Jun 2020 23:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgFHVe3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 8 Jun 2020 17:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgFHVe2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 17:34:28 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7B7C08C5C3
        for <linux-block@vger.kernel.org>; Mon,  8 Jun 2020 14:34:28 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n9so7185095plk.1
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2020 14:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9ggOtsrMddgJ70KHu47TjEHmOfrkUHmiWElKeGXU7jk=;
        b=echNLHx9srjMHmq+5UUG2lLx/fvuDhT1/J8+5KiOfks9omgg3UatMBLuCJ0I0uAhrO
         qgemsvt+O5PvhxuzdIjuep0U/cSqOZq38E+u3EHlXOFn3GyAqFXoxtilcVZ8E+wthHSh
         chsbmJGXNK71voRJeQ3INav1q9/t5vJ+9SIXizWPnDmfglbqw7000xkteKYdiHSSKr4X
         93caTFCAV70RkcEUSsVefhfISunnb1OFTbsHOiEAoFWB0gGGdvRbXLiE6L1utb6Sx3D6
         TZFkLoKZULcrUGkm9337IVwSOQ/McmwRAALdYFyeeIl0FJC/rAQVvbE4L8pzdvbrdLUE
         Y2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ggOtsrMddgJ70KHu47TjEHmOfrkUHmiWElKeGXU7jk=;
        b=Kmf0nm0vmnx5fSUKLy/k7K32U4ThaI0dKKlCtLNwSrJfrCOd4zGGTQhvnrKqQZZ0te
         gEXnV4qD/D5ZYtdlGw+vRMb3hJVPo2wSiBtv8qtKtAu1bD+EHiS3Ji7RjYQUcaRrxbq3
         yetXyYpa+Btde6okuVqxxdxT+X3R7dyUtZ0fb8iCXxIE4IvT5/KaKsMkE7fyAzVEcabP
         mSUdWZ2Y1SLRFbVwmOUa1P7DcH1gkKXHnDiIRqVPUJxzKo3uVAMiqKwDYnP8vByvy/lf
         nVIqpKzlledkjYUDExUVJpquncYUnTRm9u/5ffW6vbO5quL5PSqdmw4KNwJekb1haj7E
         pCCg==
X-Gm-Message-State: AOAM532VAPLCDzLgKkWmCUdd5dXmCpia8mTyWFb7tubo4qAe7SiJkQ8M
        kkWiLPeXWRL0XUPdLQjxMwhab4WHBkpw5g==
X-Google-Smtp-Source: ABdhPJxX59Ybax4LAaHNEMMzXtoWteCxYYgxzXVRJIg0ZbBQ3zYZs9pcdYMonT/727rBxXf9qya9Jw==
X-Received: by 2002:a17:90a:294f:: with SMTP id x15mr1178681pjf.97.1591652067748;
        Mon, 08 Jun 2020 14:34:27 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j26sm7900250pfr.215.2020.06.08.14.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 14:34:27 -0700 (PDT)
Subject: Re: blk-softirq vs smp_call_function_single_async()
To:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20200608115800.GA2531@hirez.programming.kicks-ass.net>
 <20200608154557.GA26611@infradead.org>
 <20200608155833.GC2531@hirez.programming.kicks-ass.net>
 <20200608163342.GA5155@infradead.org>
 <20200608164009.GD2531@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a77692f6-0c11-9277-6fe7-58c4fefda5fb@kernel.dk>
Date:   Mon, 8 Jun 2020 15:34:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608164009.GD2531@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/8/20 10:40 AM, Peter Zijlstra wrote:
> On Mon, Jun 08, 2020 at 09:33:42AM -0700, Christoph Hellwig wrote:
>> On Mon, Jun 08, 2020 at 05:58:33PM +0200, Peter Zijlstra wrote:
>>>> A request can only be completed once.
>>>
>>> Sure, but that doesn't help.
>>>
>>> CPU0				CPU1
>>>
>>>  raise_blk_irq()		BLOCK_SOFTIRQ
>>>    IPI -> CPU1
>>>
>>> 				// picks up thing from CPU0
>>> 				req->complete(req);
>>>
>>>
>>> 	<big hole where CSD is active and request completed>
>>>
>>> 				<IPI>
>>> 				  trigger_softirq()
>>>
>>>
>>> What happens to a struct request after completion, is it free()d
>>> or reused? If reused, how do we guarantee CSD completion before
>>> free()ing?
>>
>> The request is freed in the block layer sense by __blk_mq_free_request
>> (which doesn't actually free the memory, so it eventually gets reused).
>>
>> __blk_mq_free_request is called from blk_mq_end_request which
>> is called from the drivers ->complete_rq method, which is called
>> from the block softirq.
>>
>> What is the method to guaranteed CSD completion?
> 
> There isn't one, it was meant to be used with static allocations.
> 
> Frederic proposed changing all these to irq_work, and I think I'll go do
> that. First dinner though.

That sounds good to me, and will also shrink struct request a bit,
which is always nice.

-- 
Jens Axboe

