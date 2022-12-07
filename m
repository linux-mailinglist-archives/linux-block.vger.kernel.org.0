Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1660645FA4
	for <lists+linux-block@lfdr.de>; Wed,  7 Dec 2022 18:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLGRI4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 7 Dec 2022 12:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiLGRIz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Dec 2022 12:08:55 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD4C66CAA
        for <linux-block@vger.kernel.org>; Wed,  7 Dec 2022 09:08:53 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id q190so7050962iod.10
        for <linux-block@vger.kernel.org>; Wed, 07 Dec 2022 09:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+r3z2TzChBc0Vs/D1sJ6f4Z6Cq8sqK5Sifftb2ph/uA=;
        b=sqgK4uVgdukFxIDxOvSAAyQFpMopVm99bZ5YD2B/lQFb1XglqtMEdjzv4zSPvnedAj
         PlIMswBqc8UYikh4BdgySLaWBAmwPQLCA+DlUrsRTHy+/Y4trGeyfTrXAjWjIXqmWBgX
         hTw2LZQ0rDXoDM9eo98BrRubaVVwABlt9qLRJHkrq14N5qdMHboXlGZVVHnZrW3foxss
         cYd/kgCu+72av+pycZz+zetKRaKEH7IpVSwk9xgVJsZMOfSPMFagEGeyCzFLMIh9/Jhd
         GCY129UD4jcHF5FgAomHtHxC6KVv+ObkjnkDwWHBHgewjgg/JqQUNZeIdPzgrsE+ubKz
         hDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+r3z2TzChBc0Vs/D1sJ6f4Z6Cq8sqK5Sifftb2ph/uA=;
        b=lbU8/unDTnOHLXRmMxwrqCGBA2+k6AzDrYmQG/I4ypTAHsv7u82Eo0FJeL0jNeoQNq
         qZnr+RcWEKIptgsTNEUINJ0DYRnpWd2YFhwDsUSJZPZkp0mZonosUS+JXmdA9nEqUCia
         xaWIG/2VzhnrKwvIVI8VLD3+Sx2pVig4LTs/Gq1lkcJy8uZA0MQxXWn7xzXj0GnnwWP7
         G4g56VpXpkgyvk5MmzPDx41tn85DNWajX9ti6xYlEsCpB1EfkLGG56F6WlZ0W1t0pTYH
         63ahdKyQs9UZxEcoOs6/YQtpr5Cg+5mXShWnmusBUw7MNNT0mQ6QnSVbPgwh9YCPnW8I
         HPSg==
X-Gm-Message-State: ANoB5plhsFYp2RcoE+iKi1HxCERj1uQI6XcI2J8ox0/LUO2VnJpyIqrn
        BHPzi4uOhLZS4x4lnFv+r1lhzg==
X-Google-Smtp-Source: AA0mqf7yLejbRNfqMUu3ilEvsYdDj7YhVkPipELjA6VqWKNVXZJlTdAqiTcfQmriCKmlYB7qULxDWg==
X-Received: by 2002:a05:6638:1124:b0:38a:171a:dee with SMTP id f4-20020a056638112400b0038a171a0deemr12454949jar.292.1670432932906;
        Wed, 07 Dec 2022 09:08:52 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o27-20020a02a1db000000b0038a0c2ae99bsm7327723jah.18.2022.12.07.09.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 09:08:52 -0800 (PST)
Message-ID: <eaf4f9a8-dfc6-402e-4a1a-732034d1512d@kernel.dk>
Date:   Wed, 7 Dec 2022 10:08:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC] block: Change the granularity of io ticks from ms to ns
To:     Gulam Mohamed <gulam.mohamed@oracle.com>,
        linux-block@vger.kernel.org
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, colyli@suse.de,
        kent.overstreet@gmail.com, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, junxiao.bi@oracle.com,
        martin.petersen@oracle.com, kch@nvidia.com,
        drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        nvdimm@lists.linux.dev, konrad.wilk@oracle.com
References: <20221206181536.13333-1-gulam.mohamed@oracle.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221206181536.13333-1-gulam.mohamed@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/22 11:15?AM, Gulam Mohamed wrote:
> Use ktime to change the granularity of IO accounting in block layer from
> milli-seconds to nano-seconds to get the proper latency values for the
> devices whose latency is in micro-seconds. After changing the granularity
> to nano-seconds the iostat command, which was showing incorrect values for
> %util, is now showing correct values.
> 
> We did not work on the patch to drop the logic for
> STAT_PRECISE_TIMESTAMPS yet. Will do it if this patch is ok.
> 
> The iostat command was run after starting the fio with following command
> on an NVME disk. For the same fio command, the iostat %util was showing
> ~100% for the disks whose latencies are in the range of microseconds.
> With the kernel changes (granularity to nano-seconds), the %util was
> showing correct values. Following are the details of the test and their
> output:

As mentioned, this will most likely have a substantial performance
impact. I'd test it, but your patch is nowhere near applying to the
current block tree. Please resend it against for-6.2/block so it can
get tested.

-- 
Jens Axboe

