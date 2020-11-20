Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C397D2BA062
	for <lists+linux-block@lfdr.de>; Fri, 20 Nov 2020 03:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgKTC2T (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 Nov 2020 21:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgKTC2T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 21:28:19 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2296C0613CF;
        Thu, 19 Nov 2020 18:28:18 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id k27so10756437ejs.10;
        Thu, 19 Nov 2020 18:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NUh0XSgoziMgASCG5dCBlWVik/daeMKH4rGKs0dV7Pw=;
        b=joYIoaiuIXLnRNcB/Is34XGJYfE+9uXR0sORUzep61aoC617zHXFN0lGhgwdtvMU35
         8yIBmbsYuWnl1eHiK17v9MlEV0/L7asuoCwBhoHXHy0RAfLRtPUbwgAJmOy2jmi1IxsA
         CidKzYDm9oeWwKuF6E592GGnfZL0DfvZTEiHiBWa+84TURt1Eppndl9Z0SYMgbuIFo1Z
         /YG4c3XRjhcJmR3zhDJ8Xsrl4jyJcj94y95gawGs2n4lnVN+jkYSLhP3DWew41R0NPBa
         uT8LGfH2A3oYyfRGu2gJyQCJ/cXbUaqB+E8nWHKBjMvxkcnfGTgbdL17qhw/FtKnm1vr
         Hp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NUh0XSgoziMgASCG5dCBlWVik/daeMKH4rGKs0dV7Pw=;
        b=ge4X6QVHspumbp6Hosjqyl0icRQTpa839PeEeOlQtesoGABDVQ6Ae09seNMxM1hLbb
         hinUFrf2Fx9/CN3Ezly0j5fiwyxBJ66PfiRcKk3Tg2/IEMnmgJbgSKba+9VKIyyPibha
         Nl/m0QG5HahGgVzj8ogSM4OoJ1lRpNLtYoKJFrAZO/lDWZSkTTdAB6zyHX2a8SAojoWg
         OFdDpD4YbVoYipN3gNb/iZDkkoLXOJ6dwbCQEwVS426Lxv7bscm3CIcI7GqdGANcPZJ5
         ZgI7y9Eukycsy/EDWYSDqZJ9c+d+sYSWlfYQNSeA+V6SShjteXe/HvchbOtbiQShXuw/
         0mwA==
X-Gm-Message-State: AOAM530h8vlYvVAi9Aw/B7y8kEGFnawYCd/l5ErqQMpq6/IL1trcY9J9
        +F65SZj8NsYSINa8QD1BTzTN+DC5wyxmFg==
X-Google-Smtp-Source: ABdhPJxhOIZbY0Qu/Om1Es3cyIvVxbvGbbrkUmF4hBltLO32Tgj6UFD5A4btxTuLKpwtTlYNsGSztg==
X-Received: by 2002:a17:906:6d0:: with SMTP id v16mr29714005ejb.310.1605839297121;
        Thu, 19 Nov 2020 18:28:17 -0800 (PST)
Received: from [192.168.1.13] (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id y24sm493584edt.15.2020.11.19.18.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 18:28:16 -0800 (PST)
Subject: Re: [PATCH v2 1/2] iov_iter: optimise iov_iter_npages for bvec
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1605827965.git.asml.silence@gmail.com>
 <ab04202d0f8c1424da47251085657c436d762785.1605827965.git.asml.silence@gmail.com>
 <20201120012017.GJ29991@casper.infradead.org>
 <35d5db17-f6f6-ec32-944e-5ecddcbcb0f1@gmail.com>
 <20201120022200.GB333150@T590>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <e70a3c05-a968-7802-df81-0529eaa7f7b4@gmail.com>
Date:   Fri, 20 Nov 2020 02:25:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201120022200.GB333150@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20/11/2020 02:22, Ming Lei wrote:
> On Fri, Nov 20, 2020 at 01:39:05AM +0000, Pavel Begunkov wrote:
>> On 20/11/2020 01:20, Matthew Wilcox wrote:
>>> On Thu, Nov 19, 2020 at 11:24:38PM +0000, Pavel Begunkov wrote:
>>>> The block layer spends quite a while in iov_iter_npages(), but for the
>>>> bvec case the number of pages is already known and stored in
>>>> iter->nr_segs, so it can be returned immediately as an optimisation
>>>
>>> Er ... no, it doesn't.  nr_segs is the number of bvecs.  Each bvec can
>>> store up to 4GB of contiguous physical memory.
>>
>> Ah, really, missed min() with PAGE_SIZE in bvec_iter_len(), then it's a
>> stupid statement. Thanks!
>>
> 
> iov_iter_npages(bvec) still can be improved a bit by the following way:

Yep, was doing exactly that, +a couple of other places that are in my way.

> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 1635111c5bd2..d85ed7acce05 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1608,17 +1608,23 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
>  		npages = pipe_space_for_user(iter_head, pipe->tail, pipe);
>  		if (npages >= maxpages)
>  			return maxpages;
> +	} else if (iov_iter_is_bvec(i)) {
> +		unsigned idx, offset = i->iov_offset;
> +
> +		for (idx = 0; idx < i->nr_segs; idx++) {
> +			npages += DIV_ROUND_UP(i->bvec[idx].bv_len - offset,
> +					PAGE_SIZE);
> +			offset = 0;
> +		}
> +		if (npages >= maxpages)
> +			return maxpages;
>  	} else iterate_all_kinds(i, size, v, ({
>  		unsigned long p = (unsigned long)v.iov_base;
>  		npages += DIV_ROUND_UP(p + v.iov_len, PAGE_SIZE)
>  			- p / PAGE_SIZE;
>  		if (npages >= maxpages)
>  			return maxpages;
> -	0;}),({
> -		npages++;
> -		if (npages >= maxpages)
> -			return maxpages;
> -	}),({
> +	0;}),0,({
>  		unsigned long p = (unsigned long)v.iov_base;
>  		npages += DIV_ROUND_UP(p + v.iov_len, PAGE_SIZE)
>  			- p / PAGE_SIZE;
> 

-- 
Pavel Begunkov
