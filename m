Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AAA218ACC
	for <lists+linux-block@lfdr.de>; Wed,  8 Jul 2020 17:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgGHPGw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 8 Jul 2020 11:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbgGHPGv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 11:06:51 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6591FC08C5CE
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 08:06:51 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id e64so42430515iof.12
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QRr8IaIUSsGD3CeeBoEgXqxqpXOnhIwjY7NBGxGQZyo=;
        b=DU3Ygtsctl26AMlkTp4CMraQH0A+FA5vOVnNO0UIcYo9nxfYiCGy/ymLFOrzpSIPvq
         /CEOf6eB2iHMuxO2Uj9c0aYHbwNJ1koOfPwBQdxhbZrmEaBWTDcDovMfnMGuY7DQcBSl
         /59aWWLJ+6nNzZru72U0sGqPquAoF2yyEAtIyDRj97tm1CKkmn7DmgaPYWmycBfkGRdp
         5HtQzvJXXi6Iy+ALPgddlkzwEo8R8hBRrz1sJuxfBm8lVmmwg3bJZMt12DHYs3qwlyPS
         rbB21x+49LQLxypL1cXpHtPNH1vD6NNvIYALazA0x6rwFXpzq1MciHcfiOlzuO9qSWGr
         iI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QRr8IaIUSsGD3CeeBoEgXqxqpXOnhIwjY7NBGxGQZyo=;
        b=geFkiD1sUs9N8/0PRLW4VpLx/gMo229zeAAxD84UzeFcUQBOynThyITskhiNdZUYcI
         IyEiD4rKh3mSK74dnrwWiJmDjtQKLCMIQdapyMZxKKmr6zg7yV8g7blS8g0bDbJLzfk7
         vqH84OJsN2NxoZoI/v3uVDyZJRPPqiLPDqSxYL0HmutcQzpq4UflvUdVRdil4bYXCBOx
         4YFZ3sMknyaavLRGXar18X7C0+j5wf0Pf7LCMN3ggTye1mqkyo1KaAvvSbZ7YClAp3Ng
         Z8COy7l92loGYqWO1c7JjDdrwrf6Y+yRpnwDHfnzYabIwdNZBmyrpVHzC9i5e96ogmvv
         AD2g==
X-Gm-Message-State: AOAM532Z+ntDQLFdXY7fh1bXFAZzviH3bOYetAAkvejCQyatrD3IrTQf
        peUhlwsz/Wr+mIi0thQc2n/piQ==
X-Google-Smtp-Source: ABdhPJxSNOJIwdG5M6/DgmtTZGq3z2ZwA8+OmZqthv4xlv2bxnbw+dF3KP0JkUjr+YWL22OnfN4/RQ==
X-Received: by 2002:a05:6638:2591:: with SMTP id s17mr15513952jat.23.1594220810484;
        Wed, 08 Jul 2020 08:06:50 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h11sm15046512ilh.69.2020.07.08.08.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:06:49 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] io_uring: add support for zone-append
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, viro@zeniv.linux.org.uk,
        bcrl@kvack.org, hch@infradead.org, Damien.LeMoal@wdc.com,
        asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
        mb@lightnvm.io, linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        Selvakumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <20200707155237.GM25523@casper.infradead.org>
 <20200707202342.GA28364@test-zns>
 <7a44d9c6-bf7d-0666-fc29-32c3cba9d1d8@kernel.dk>
 <20200707221812.GN25523@casper.infradead.org>
 <CGME20200707223803epcas5p41814360c764d6b5f67fdbf173a8ba64e@epcas5p4.samsung.com>
 <145cc0ad-af86-2d6a-78b3-9ade007aae52@kernel.dk>
 <20200708125805.GA16495@test-zns>
 <2962cd68-de34-89be-0464-8b102a3f1d0e@kernel.dk>
 <20200708145826.GS25523@casper.infradead.org>
 <b1c58211-496a-ed85-a9bb-0d0cc56e250c@kernel.dk>
 <20200708150240.GT25523@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <33b9887b-eaba-c7be-5dfd-fc7e7d416f48@kernel.dk>
Date:   Wed, 8 Jul 2020 09:06:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708150240.GT25523@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/8/20 9:02 AM, Matthew Wilcox wrote:
> On Wed, Jul 08, 2020 at 08:59:50AM -0600, Jens Axboe wrote:
>> On 7/8/20 8:58 AM, Matthew Wilcox wrote:
>>> On Wed, Jul 08, 2020 at 08:54:07AM -0600, Jens Axboe wrote:
>>>> On 7/8/20 6:58 AM, Kanchan Joshi wrote:
>>>>>>> +#define IOCB_NO_CMPL		(15 << 28)
>>>>>>>
>>>>>>>  struct kiocb {
>>>>>>> [...]
>>>>>>> -	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
>>>>>>> +	loff_t __user *ki_uposp;
>>>>>>> -	int			ki_flags;
>>>>>>> +	unsigned int		ki_flags;
>>>>>>>
>>>>>>> +typedef void ki_cmpl(struct kiocb *, long ret, long ret2);
>>>>>>> +static ki_cmpl * const ki_cmpls[15];
>>>>>>>
>>>>>>> +void ki_complete(struct kiocb *iocb, long ret, long ret2)
>>>>>>> +{
>>>>>>> +	unsigned int id = iocb->ki_flags >> 28;
>>>>>>> +
>>>>>>> +	if (id < 15)
>>>>>>> +		ki_cmpls[id](iocb, ret, ret2);
>>>>>>> +}
>>>>>>>
>>>>>>> +int kiocb_cmpl_register(void (*cb)(struct kiocb *, long, long))
>>>>>>> +{
>>>>>>> +	for (i = 0; i < 15; i++) {
>>>>>>> +		if (ki_cmpls[id])
>>>>>>> +			continue;
>>>>>>> +		ki_cmpls[id] = cb;
>>>>>>> +		return id;
>>>>>>> +	}
>>>>>>> +	WARN();
>>>>>>> +	return -1;
>>>>>>> +}
>>>>>>
>>>>>> That could work, we don't really have a lot of different completion
>>>>>> types in the kernel.
>>>>>
>>>>> Thanks, this looks sorted.
>>>>
>>>> Not really, someone still needs to do that work. I took a quick look, and
>>>> most of it looks straight forward. The only potential complication is
>>>> ocfs2, which does a swap of the completion for the kiocb. That would just
>>>> turn into an upper flag swap. And potential sync kiocb with NULL
>>>> ki_complete. The latter should be fine, I think we just need to reserve
>>>> completion nr 0 for being that.
>>>
>>> I was reserving completion 15 for that ;-)
>>>
>>> +#define IOCB_NO_CMPL		(15 << 28)
>>> ...
>>> +	if (id < 15)
>>> +		ki_cmpls[id](iocb, ret, ret2);
>>>
>>> Saves us one pointer in the array ...
>>
>> That works. Are you going to turn this into an actual series of patches,
>> adding the functionality and converting users?
> 
> I was under the impression Kanchan was going to do that, but I can run it
> off quickly ...

I just wanted to get clarification there, because to me it sounded like
you expected Kanchan to do it, and Kanchan assuming it "was sorted". I'd
consider that a prerequisite for the append series as far as io_uring is
concerned, hence _someone_ needs to actually do it ;-)

-- 
Jens Axboe

