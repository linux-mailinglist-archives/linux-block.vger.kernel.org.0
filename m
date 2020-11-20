Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9092BB15E
	for <lists+linux-block@lfdr.de>; Fri, 20 Nov 2020 18:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgKTRZ1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Nov 2020 12:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgKTRZ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 12:25:26 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161FDC0613CF;
        Fri, 20 Nov 2020 09:25:25 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so11053887wmd.4;
        Fri, 20 Nov 2020 09:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G0q/APOYHJwWcIxEVGu7BpAbHR0uizpMBxh1YXyG6BU=;
        b=hdZMxoVqyTeMQqL9y1kNpAOMOUusUo32K+/CXr3HW0gXJkkPcRfUAJH3ZgpFiNUptD
         3q4JfG4YNJDP9lrw/BkhC63EhxAAiqec8nTYiszXhVNiaate8PmoVVtXiivAgf8GXNA3
         1ifvvL1pXVEaCo47jxw1bp9Aie50a5WkZmM3j69I10pa0PWK3q0apPeQOLGELmolCmGD
         bknf30+BGiWbX1+BjKEtpka37NyTXYtutfRd9rET0mVbWT0PRw3pCvykcf5WaAvq0oof
         5X0lBnrTXOKaCnbheVvAYI939QZy9ZjFHFU5Gk0k0noPpLWIgEjCAkvqEAO91su/muCK
         2LUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=G0q/APOYHJwWcIxEVGu7BpAbHR0uizpMBxh1YXyG6BU=;
        b=sHptKUDUG+5VLXQvhDvPFn99AdsSzNGbhkREqUKa/LA8YVpF1cA+d3DKZcF+psrBwd
         7Cxm6A6ty/1yTvRi3pi+0INdvVnSVztLNWi1EUtPpYOEME230yvb0jbdBGPzvbxmNMpz
         eENtGGa2qxGd7S9rU/8e/4OovwZ4IirMYAjB47F9MQrNW7kebGeCRJVOKzLxqM5Ne5Bp
         LFlu+NEuQU4bhXbwlt/7NJbH1vDRKn4VBYGEquDTZrbRHezM/Q2YhI24NkHktTYFlGp3
         b+kI7jd/64FT3t4DoEYqLuvbLxXekT8OWobj8mFpic4JvtSLcCdjogYS4fYl1dOf5gaV
         42/A==
X-Gm-Message-State: AOAM532OhpihRhLWX078Gidas/vPE5BdvtHutCoZkHbHm0MdPqMn+13e
        Jqi6ExbSI6crfls6wCp4gmGHuEPTBlBFug==
X-Google-Smtp-Source: ABdhPJyuve0won9k2RgIRAA1iF/2lDc6MRNi+CQzlxxVzD5s0dFci/DA0Dc2INhPHfNt2FcuHC+0Vg==
X-Received: by 2002:a1c:1b43:: with SMTP id b64mr10585076wmb.64.1605893123586;
        Fri, 20 Nov 2020 09:25:23 -0800 (PST)
Received: from [192.168.1.31] (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id c187sm5777998wmd.23.2020.11.20.09.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 09:25:23 -0800 (PST)
Subject: Re: [PATCH v2 1/2] iov_iter: optimise iov_iter_npages for bvec
To:     Ming Lei <ming.lei@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1605827965.git.asml.silence@gmail.com>
 <ab04202d0f8c1424da47251085657c436d762785.1605827965.git.asml.silence@gmail.com>
 <20201120012017.GJ29991@casper.infradead.org>
 <35d5db17-f6f6-ec32-944e-5ecddcbcb0f1@gmail.com>
 <20201120014904.GK29991@casper.infradead.org>
 <3dc0b17d-b907-d829-bfec-eab96a6f4c30@gmail.com>
 <20201120020610.GL29991@casper.infradead.org> <20201120022426.GC333150@T590>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <59329ec4-e894-e3ff-6f6e-7d89c34bebaf@gmail.com>
Date:   Fri, 20 Nov 2020 17:22:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201120022426.GC333150@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20/11/2020 02:24, Ming Lei wrote:
> On Fri, Nov 20, 2020 at 02:06:10AM +0000, Matthew Wilcox wrote:
>> On Fri, Nov 20, 2020 at 01:56:22AM +0000, Pavel Begunkov wrote:
>>> On 20/11/2020 01:49, Matthew Wilcox wrote:
>>>> On Fri, Nov 20, 2020 at 01:39:05AM +0000, Pavel Begunkov wrote:
>>>>> On 20/11/2020 01:20, Matthew Wilcox wrote:
>>>>>> On Thu, Nov 19, 2020 at 11:24:38PM +0000, Pavel Begunkov wrote:
>>>>>>> The block layer spends quite a while in iov_iter_npages(), but for the
>>>>>>> bvec case the number of pages is already known and stored in
>>>>>>> iter->nr_segs, so it can be returned immediately as an optimisation
>>>>>>
>>>>>> Er ... no, it doesn't.  nr_segs is the number of bvecs.  Each bvec can
>>>>>> store up to 4GB of contiguous physical memory.
>>>>>
>>>>> Ah, really, missed min() with PAGE_SIZE in bvec_iter_len(), then it's a
>>>>> stupid statement. Thanks!
>>>>>
>>>>> Are there many users of that? All these iterators are a huge burden,
>>>>> just to count one 4KB page in bvec it takes 2% of CPU time for me.
>>>>
>>>> __bio_try_merge_page() will create multipage BIOs, and that's
>>>> called from a number of places including
>>>> bio_try_merge_hw_seg(), bio_add_page(), and __bio_iov_iter_get_pages()
>>>
>>> I get it that there are a lot of places, more interesting how often
>>> it's actually triggered and if that's performance critical for anybody.
>>> Not like I'm going to change it, just out of curiosity, but bvec.h
>>> can be nicely optimised without it.
>>
>> Typically when you're allocating pages for the page cache, they'll get
>> allocated in order and then you'll read or write them in order, so yes,
>> it ends up triggering quite a lot.  There was once a bug in the page
>> allocator which caused them to get allocated in reverse order and it
>> was a noticable performance hit (this was 15-20 years ago).
> 
> hugepage use cases can benefit much from this way too.

This didn't yield any considerable boost for me though. 1.5% -> 1.3%
for 1 page reads. I'll send it anyway though because there are cases
that can benefit, e.g. as Ming mentioned.

Ming would you want to send the patch yourself? After all you did post
it first.

-- 
Pavel Begunkov
