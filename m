Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52A63EBD3A
	for <lists+linux-block@lfdr.de>; Fri, 13 Aug 2021 22:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhHMUTk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 Aug 2021 16:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbhHMUTk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 16:19:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13875C0617AD
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 13:19:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so22346330pjr.1
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 13:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VSpDcqH3KixViD1xyL9HU2unmk5zVkkK4q6pf0itpNQ=;
        b=TbfXAwCtvzzMGy+inGfzft+6tbE3sGXjEZIHkPbYjTgIueCjpAQZ59No7PqGPBwKJD
         mDGKwKVtuacxwOkWP7UIkgfLZyyNiFe/OuVzymkxddr6sCAnv1WeCSHTFJ6i9YwdhG0r
         01j3Bo5FjAQtfxrO3mYWFI+EbZ/1Jq0ZxBys6ccHGfDKtoWa2z9q9o5K1qnhKCNk/NT2
         mAlj/jcMjAVBm91pfYbGTcU0Chd7HeFE4Ic9Ri+QepwW95Uy0pHBXG/8hpufqd79U+np
         1klmqF8qEb0NiwCb42Mt5TTgkTbT+WNhFFUkadyhCmS9T5K5UeQytMvfg5Q/3+8NvQ10
         RQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VSpDcqH3KixViD1xyL9HU2unmk5zVkkK4q6pf0itpNQ=;
        b=tODK1+9YkT94fL5HIILWmlvV1CawLX1OzdkidcWCKf5pLgLmr2olazcmUUcKQVL2Wi
         PN9ePPoPT3j/lf1c54nzOqAMOTW5LKXTAKS7160BbPOnd56m/oV+r5bhNZvXZJgtRMJJ
         pkgnLZeYtfEDs9xJfc0XgigQNUn12S1An6ZZ5Zx3yxTaSOjlT4M3cJJMlbbFB0XMx5uB
         MaWS6Wr+yXJCAk8WQS58OZc5YxQJlPZS6Xu1BGQ+8nAYShGvlKEtdpjblIewPTWzXN0b
         au3RwZ+Sosfvz2K7XYLB7+u3XpqGxFLQWzLx7YXaIdOg3ZGrxpw4Et9ygeSDHhdOAVLq
         /agQ==
X-Gm-Message-State: AOAM533E7pVS7iRfAQDvuelJoV10r4a4iyH8GaWUmy2XlAW8zo5MMiEg
        K3y7WSN73iw/Xvsrx3zN11oSvQ==
X-Google-Smtp-Source: ABdhPJw78yXAZdr2HPUEil3W+uBPZQlQsVoeatQaJq3oPJRvMFRm0cadx8ws2GqizSvRpxgpEutMDQ==
X-Received: by 2002:a17:90b:3758:: with SMTP id ne24mr4179028pjb.218.1628885952534;
        Fri, 13 Aug 2021 13:19:12 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g14sm3476046pfr.31.2021.08.13.13.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 13:19:12 -0700 (PDT)
Subject: Re: [PATCH 4/6] block: clear BIO_PERCPU_CACHE flag if polling isn't
 supported
To:     Keith Busch <kbusch@kernel.org>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        hch@infradead.org
References: <20210812154149.1061502-1-axboe@kernel.dk>
 <20210812154149.1061502-5-axboe@kernel.dk>
 <20210812173143.GA3138953@dhcp-10-100-145-180.wdc.com>
 <b60e0031-77b0-fe27-2b52-437ba21babcb@kernel.dk>
 <20210813201722.GB2661@dhcp-10-100-145-180.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <33d05811-a9c6-c1d3-8b9c-7b95bdadd457@kernel.dk>
Date:   Fri, 13 Aug 2021 14:19:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210813201722.GB2661@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/13/21 2:17 PM, Keith Busch wrote:
> On Thu, Aug 12, 2021 at 11:41:58AM -0600, Jens Axboe wrote:
>> Indeed. Wonder if we should make that a small helper, as any clear of
>> REQ_HIPRI should clear BIO_PERCPU_CACHE as well.
>>
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 7e852242f4cc..d2722ecd4d9b 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -821,11 +821,8 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
>>  		}
>>  	}
>>  
>> -	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags)) {
>> -		/* can't support alloc cache if we turn off polling */
>> -		bio_clear_flag(bio, BIO_PERCPU_CACHE);
>> -		bio->bi_opf &= ~REQ_HIPRI;
>> -	}
>> +	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
>> +		bio_clear_hipri(bio);
> 
> Since BIO_PERCPU_CACHE doesn't work without REQ_HIRPI, should this check
> look more like this?
> 
> 	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> 		bio->bi_opf &= ~REQ_HIPRI;
> 	if (!(bio->bi_opf & REQ_HIPRI))
> 		bio_clear_flag(bio, BIO_PERCPU_CACHE);
> 
> I realise the only BIO_PERCPU_CACHE user in this series never sets it
> without REQ_HIPRI, but it looks like a problem waiting to happen if
> nothing enforces this pairing: someone could set the CACHE flag on a
> QUEUE_FLAG_POLL enabled queue without setting HIPRI and get the wrong
> bio_put() action.

I'd rather turn that into a WARN_ON or similar. But probably better to
do that on the freeing side, honestly. That'll be the most reliable way,
but a shame to add cycles to the hot path...

-- 
Jens Axboe

