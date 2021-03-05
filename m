Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0D632EF9F
	for <lists+linux-block@lfdr.de>; Fri,  5 Mar 2021 17:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhCEQFu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 5 Mar 2021 11:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhCEQFa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 11:05:30 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B369C061574
        for <linux-block@vger.kernel.org>; Fri,  5 Mar 2021 08:05:30 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id p10so2433599ils.9
        for <linux-block@vger.kernel.org>; Fri, 05 Mar 2021 08:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dOutfGYiG2A+64OXk3o//THXPi5TUSoKfgG/x5Y+cgc=;
        b=ahyA8ReExwW3Iq2o6f2b0T203bj8n3qviDv8OT1IH6eeP5RxkpeVM0I6eHDRuv8wV9
         wF967WgX3Ag88gyivBVf6V4xCfR+Jj+Hjsq6a5PUet63jBb+fxzQOf9akL3ziiGQwhzg
         +ff0AWnwWtnjtlT97mYwTVE4AoI2g9kGkGggyB4NXNtoOQGu6N3leOlbzegQjSdNSBkq
         6hqUyyJB2Y5sm7Qqbfhc5EQZdY601q8K7KAZ7YALmIU5w3sXgfXjnd4qnyEljV93PGAw
         i3s+3XZD5c3/R5yj0+70N6g8JJOglEMRmcHhY8+8lJl1HM7BTpzL4naZEkpOi2kPypUQ
         jhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dOutfGYiG2A+64OXk3o//THXPi5TUSoKfgG/x5Y+cgc=;
        b=bjm7xG+pqU8euwo8zBHECdtq0F/KwPuDa03Iun505Grz4U1ALn38Z2NYdzA0uG+ffS
         fN83bNCZQ5fcbWp3ld8RJoHKftc6Xrev5VZ9FOHCcqLtVUM/sAi6bfC+J892Pl/deajL
         Q1vvHos1JnGkzu85yK8Yisu0xleLs5NRxf3IEGWxCvIC1FXbVCVYMEKL4gE1gFCxmSzu
         uWsbcGzNn0cqKsRuXWRPPZzxS6isILxjvkpiGfSaiUgPd4LsBXYTgpxl8qgeL3DrMDMo
         hvdN3Yt70FQWAT/SNfp0dW/GyiPnP4z0eXa/F0Q8+PI6zKFJTGM+n1xmfZouBYt4QlzL
         CTqw==
X-Gm-Message-State: AOAM5300Xwn1Lmkov3xCcudTDtg1d9H8ZOfhSUzt8pSY8OoElb3m1heg
        VDesm7EIUWHkKCPshR4ABncBkQ==
X-Google-Smtp-Source: ABdhPJzv0jdG7nN+mYnWzwgQAczr0646hMx1maK6gX9UzCs8SwL7oosIal47E+i7NmfN4horO3h4Rg==
X-Received: by 2002:a05:6e02:1a6e:: with SMTP id w14mr9126622ilv.3.1614960329393;
        Fri, 05 Mar 2021 08:05:29 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w13sm1535763ilg.48.2021.03.05.08.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 08:05:28 -0800 (PST)
Subject: Re: [PATCH 1/4] block: introduce a function
 submit_bio_noacct_mq_direct
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     JeffleXu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <msnitzer@redhat.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        caspar@linux.alibaba.com, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com,
        dm-devel@redhat.com, hch@lst.de
References: <20210302190551.473015400@debian-a64.vm>
 <8424036e-fba9-227e-4173-8f6d05562ee3@kernel.dk>
 <alpine.LRH.2.02.2103040511050.7400@file01.intranet.prod.int.rdu2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0e730b1f-5b49-85f7-c5b7-2d6267c6a7ef@kernel.dk>
Date:   Fri, 5 Mar 2021 09:05:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.2103040511050.7400@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/21 3:14 AM, Mikulas Patocka wrote:
> 
> 
> On Wed, 3 Mar 2021, Jens Axboe wrote:
> 
>> On 3/2/21 12:05 PM, Mikulas Patocka wrote:
>>
>> There seems to be something wrong with how this series is being sent
>> out. I have 1/4 and 3/4, but both are just attachments.
>>
>> -- 
>> Jens Axboe
> 
> I used quilt to send it. I don't know what's wrong with it - if you look 
> at archives at 
> https://listman.redhat.com/archives/dm-devel/2021-March/thread.html , it 
> seems normal.

I guess the archives handle it, but it just shows up as an empty email with
an attachment. Not very conducive to review, so I do suggest you fix how
you're sending them out.

-- 
Jens Axboe

