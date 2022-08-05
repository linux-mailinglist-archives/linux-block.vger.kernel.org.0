Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7565558AF9F
	for <lists+linux-block@lfdr.de>; Fri,  5 Aug 2022 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbiHESP3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 5 Aug 2022 14:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiHESP3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Aug 2022 14:15:29 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B062019039
        for <linux-block@vger.kernel.org>; Fri,  5 Aug 2022 11:15:27 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h16so1721542ilc.10
        for <linux-block@vger.kernel.org>; Fri, 05 Aug 2022 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gk5a3EW3Ph2WpipU/WTzFfbiIRaAAQHx8pFA4GCIzmM=;
        b=Ovo1jaM1jNoHeGymgKW/S1O7IKGi8JTPl5wusmqk8/QBRF0qiX8qIYEaMlg49Sl6Rr
         igkabJRDKfi9kiE1gR5fJY2rQ0hT1TPbzwYZUm7Ag8OAgk+fqNh3ToNqm0xLd3yPE7Qk
         Oi+E3a6qVxwXfb6sn9O7EyH2AQ7JrOylgEAAMFuLNjQ37Q5neXLDZ+diBpC5OcIt3D7t
         rZo5T+VO8cs60ogBloKJ5BTksHzrA3sDlUxyhu4v0zQQvfkhHePD3Fp+ZfsosnGSSHsQ
         gTqaJ6IHuP0xsYQqHxILei7R/i3Wkw0FDR2KqwAcL1fFkTonHyy9zueR8jDiRC6vwmiZ
         hKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gk5a3EW3Ph2WpipU/WTzFfbiIRaAAQHx8pFA4GCIzmM=;
        b=gwA2je11EkfEGQaDt+ZMBt5EpvKXEvtHTg24neEMTRteYNY2p0qbx94VuCk7tiD60o
         /cdHbNlRLXFgqj1ubBCwu1mxmTADWY6s1hmji8mpE/ptBUwYnV7rJyZtFOoEu1NJ/3mK
         /pkc9mYWZQvpkAJrSXb2cVBPlXJvyXG4SgDlxJqAmS4oudcBebMEO1FaRqfnH4u9yOpm
         kC3Gv1PfwuxeH5M9mKl+l/cegxtZb4fylSei8RYjPXEX7Ok2ZEOux3jOLTuX0gJuDrBo
         fhm1wiSTWGoNmfbWwD9K9X7O2gmPjg8DFc+1FkaiDiHKZldZmd5gqWO2cGXdzOXrtKUK
         +eNA==
X-Gm-Message-State: ACgBeo2DHzUO6NRWaXAHLh8yU88whuGfiV+oMaRPza9VUVvmAue//V0c
        +ITSVsHmtCyyLHB2H0JhGR2hjQ==
X-Google-Smtp-Source: AA6agR4dF96Re7MRCaE8lp8UNdD9uMORcpeztS2fubhGx5Y8gqqOZCibghCeLMzaWGWAub0D17UjOg==
X-Received: by 2002:a05:6e02:152b:b0:2de:e632:ca6b with SMTP id i11-20020a056e02152b00b002dee632ca6bmr3703645ilu.296.1659723326973;
        Fri, 05 Aug 2022 11:15:26 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r16-20020a056e02109000b002dcf927087asm1896938ilj.65.2022.08.05.11.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 11:15:26 -0700 (PDT)
Message-ID: <6bd091d6-e0e6-3095-fc6b-d32ec89db054@kernel.dk>
Date:   Fri, 5 Aug 2022 12:15:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] iopoll support for io_uring/nvme passthrough
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, ming.lei@redhat.com,
        joshiiitr@gmail.com, gost.dev@samsung.com
References: <CGME20220805155300epcas5p1b98722e20990d0095238964e2be9db34@epcas5p1.samsung.com>
 <20220805154226.155008-1-joshi.k@samsung.com>
 <78f0ac8e-cd45-d71d-4e10-e6d2f910ae45@kernel.dk>
 <a2a5184d-f3ab-0941-6cc4-87cf231d5333@kernel.dk>
 <Yu1dTRhrcOSXmYoN@kbusch-mbp.dhcp.thefacebook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yu1dTRhrcOSXmYoN@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/5/22 12:11 PM, Keith Busch wrote:
> On Fri, Aug 05, 2022 at 11:18:38AM -0600, Jens Axboe wrote:
>> On 8/5/22 11:04 AM, Jens Axboe wrote:
>>> On 8/5/22 9:42 AM, Kanchan Joshi wrote:
>>>> Hi,
>>>>
>>>> Series enables async polling on io_uring command, and nvme passthrough
>>>> (for io-commands) is wired up to leverage that.
>>>>
>>>> 512b randread performance (KIOP) below:
>>>>
>>>> QD_batch    block    passthru    passthru-poll   block-poll
>>>> 1_1          80        81          158            157
>>>> 8_2         406       470          680            700
>>>> 16_4        620       656          931            920
>>>> 128_32      879       1056        1120            1132
>>>
>>> Curious on why passthru is slower than block-poll? Are we missing
>>> something here?
>>
>> I took a quick peek, running it here. List of items making it slower:
>>
>> - No fixedbufs support for passthru, each each request will go through
>>   get_user_pages() and put_pages() on completion. This is about a 10%
>>   change for me, by itself.
> 
> Enabling fixed buffer support through here looks like it will take a
> little bit of work. The driver needs an opcode or flag to tell it the
> user address is a fixed buffer, and io_uring needs to export its
> registered buffer for a driver like nvme to get to.

Yeah, it's not a straight forward thing. But if this will be used with
recycled buffers, then it'll definitely be worthwhile to look into.

>> - nvme_uring_cmd_io() -> nvme_alloc_user_request() -> blk_rq_map_user()
>>   -> blk_rq_map_user_iov() -> memset() is another ~4% for me.
> 
> Where's the memset() coming from? That should only happen if we need
> to bounce, right? This type of request shouldn't need that unless
> you're using odd user address alignment.

Not sure, need to double check! Hacking up a patch to get rid of the
frivolous alloc+free, we'll see how it stands after that and I'll find
it.

-- 
Jens Axboe

