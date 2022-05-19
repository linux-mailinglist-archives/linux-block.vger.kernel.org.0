Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEC052D2B5
	for <lists+linux-block@lfdr.de>; Thu, 19 May 2022 14:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbiESMmW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 May 2022 08:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiESMmV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 08:42:21 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DD5BA994
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 05:42:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q18so4669769pln.12
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 05:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=Y1GovqMPzhvut8NvuPgiE/hNGUig6FYl6qCBlK+A9N4=;
        b=vnd1gvTu/Unz1lkokq8fZ1Q1lmDQ1elM7Y8cAW4I2NJHcwmr/6cGQfK1KC21Om/YZb
         xZPPMAAMAppCEewOclP02ef2kaT91sr5GjpGPC1oL2KaA+RY9RYRhvo10SRZrLg0Sc5V
         vaupxPhIKwe/+31NpTqyGOy6FxyflJL0As91UnRvhoJNHfX2znOSRuNhsAhGqLPUIaHB
         eh9vqB8sAOYQ14KIaRZVxrao0+yuVxp5bYIqqVzVwKC84iDa7rBWQYE57KEwM9XBhm2H
         GEi+vD+qvMEClemRHMDmdfxVpU4ezocN8AOewDSY4Q9PHlTFBNQT3SkVrh3iYzK18Hiu
         yBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Y1GovqMPzhvut8NvuPgiE/hNGUig6FYl6qCBlK+A9N4=;
        b=KVqoukZ0wFB+fytGszqPXlOF1DZzjDh6yTYnGGTwNAw8BZvo9kjQhcGjoIJK+HwiTi
         TRRYAkq8HryfmXcBcsYpyTS/W83GbtvTBuH13/Vn76Ol4NilOCkYVz+pe7wsrqtJUltg
         Qk0IC3aA3+tumvUzku73Af2T2vPx6f+SwPKymHl9SQ1+6Dgn4voJ1TzHvKPLtC0ILTCJ
         prHzUjRk4xH6bLmw7JiX6nFLTSy8O7agI0dd3O6vQa8LiYJszienO8Xjk+pYG+KePJjg
         qkCAK7gcsct8EmBuWXbbFoT6k9+8cccq7daa1oqGiRQXH3ak5K6icjDNEXNbjZf6hwBI
         lT3A==
X-Gm-Message-State: AOAM531l9pb/KLbUO7/2xoxNUqrm7aB9HABbtitRq1mVkRSXbYKz3436
        60Kpc1Q9qdgp/OKw2L5rQbYjqw==
X-Google-Smtp-Source: ABdhPJzk1auG0FAgzrLMkSSPdvHMZ/jOsnsDFWEuJ0YYtwakff2NjTBQZTp6GUnx/7N5SdpnKo9o2A==
X-Received: by 2002:a17:902:f607:b0:161:5f47:b213 with SMTP id n7-20020a170902f60700b001615f47b213mr4504874plg.4.1652964140047;
        Thu, 19 May 2022 05:42:20 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s18-20020a634512000000b003c265b7d4f6sm3387809pga.44.2022.05.19.05.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 05:42:19 -0700 (PDT)
Message-ID: <c2d252a1-7223-4899-e5c9-e4bb27e2fc8a@kernel.dk>
Date:   Thu, 19 May 2022 06:42:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [linux-next] build fails modpost: "blkcg_get_fc_appid"
 [drivers/nvme/host/nvme-fc.ko] undefined!
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        sachinp@linux.vnet.com, mputtash@linux.vnet.com,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <86768c9d-9a9c-653b-ab99-86de3bc434d8@linux.vnet.ibm.com>
 <7b16694b-0281-d06d-7564-c4f26760a25e@kernel.dk>
 <fc5f8b96-3c93-5400-b917-a1d991cbe7c9@suse.de>
 <900f57bc-9978-9ba6-22fb-48f03fcf5011@kernel.dk>
In-Reply-To: <900f57bc-9978-9ba6-22fb-48f03fcf5011@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/22 6:40 AM, Jens Axboe wrote:
> On Thu, May 19, 2022 at 6:38 AM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 5/19/22 14:14, Jens Axboe wrote:
>>> On 5/19/22 1:49 AM, Tasmiya Nalatwad wrote:
>>>> Greetings,
>>>>
>>>> linux-next build fails modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
>>>>
>>>> Console Logs :
>>>>
>>>> [console-expect]#make -j 17 -s && make modules && make modules_install && make install
>>>> make -j 17 -s && make modules && make modules_install && make install
>>>> ERROR: modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
>>>> make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
>>>> make: *** [Makefile:1914: modules] Error 2
>>>> make: *** Waiting for unfinished jobs....
>>>
>>> Christoph, can you fix this up?
>>>
>> Cannot reproduce with commit 21498d01d045c5b95b93e0a0625ae965b4330ebe.
>> Please share details.
> 
> The kerneltest bot also reported this a few days ago, you might be able
> to find the details there as that includes config etc.

Here: https://lore.kernel.org/linux-mm/202205190527.o9wVEvHI-lkp@intel.com/

-- 
Jens Axboe

