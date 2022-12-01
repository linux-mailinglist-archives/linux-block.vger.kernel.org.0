Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C0E63E735
	for <lists+linux-block@lfdr.de>; Thu,  1 Dec 2022 02:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiLABrD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 30 Nov 2022 20:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLABrC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 20:47:02 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ED94B749
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 17:47:01 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id jn7so186218plb.13
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 17:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8hDdaQmPxw+eSKXxu3gfMm69MhV0uzkfUNnKEmkBTXE=;
        b=EP1iVAJNfePbfh1XQ73+nj6duWcS7GeX4kDcPDxP4Zm/+vKz4IF61o1LkM32zEI0Zb
         KiOqL32O6LJsNHvJ0j2SjjF5kwdBlhIrCYwE1Kj8DOe3ZFbl7yYWpS0aoBewT2XUSoyc
         aW7E51BsJQV00EOBQKOhqfQ01rbNZJLh6QJ3Ty0FuBKYqGp74uuVxRYUz9g1j/nQBtG7
         xjMERT22SHAsVvI+YnsSbaWBI2/QN87pJcKYsdNPzktxXsAXdJD+L9gTOMnlVGhMuBaq
         bPPZItg0sTNH7G1l0s2LRMK52I4Ft+DIAdQlFp7jobjCEdMmsrZb5kTH0olbnhapauVg
         91MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hDdaQmPxw+eSKXxu3gfMm69MhV0uzkfUNnKEmkBTXE=;
        b=0xjngpzzUZAS2FI4AQ6x6gDBuSEQdn41iEc0YcSzkjku6NEWQqgSGM4U50KYr/60VJ
         sO13M79D2u0R4mk2fNJiTAafv1XJkhhGzhyIsH+YPphhIP3ahJXFtKid2FqLmytd7R+Y
         2RLrrD4moyofVYFurcoIeZN1t+DiXkW4gIGarhGAXwlieJHMrrFbZKT1PzFjh7FTvSMa
         V8KNY/0PSECuGZFS7xFESHGv3YMcXjGbRYZNVLxqIN3tJey//81qSPjS+9JHh/szMWay
         6sHnEbN4gIMZHXeyiybNqUpf/8WEcXFGuVCYw7qQ9TuDyK49pe3U9LywX7LlDvdz7xC+
         P1pw==
X-Gm-Message-State: ANoB5pl54WFhNpsWOsHgOkDdDPjemO3WA2SOtGazYGh8OzE8ZkRj3gAC
        1t8J7P98uH1JpgiaY3GmdjGWsQ==
X-Google-Smtp-Source: AA0mqf7x+Zso0v3uBgNTgHq+aewXpz5O2N8SmZVuONOLYxUjPxndqYx39rOt4AgJr8jQP3/t8CGrxQ==
X-Received: by 2002:a17:903:300c:b0:17f:9538:e1f4 with SMTP id o12-20020a170903300c00b0017f9538e1f4mr56504944pla.89.1669859221046;
        Wed, 30 Nov 2022 17:47:01 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x128-20020a626386000000b0056cea9530b9sm1968984pfb.200.2022.11.30.17.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 17:47:00 -0800 (PST)
Message-ID: <bd008582-1509-69f3-1812-2b9caa390c05@kernel.dk>
Date:   Wed, 30 Nov 2022 18:46:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/5] A few cleanup and bugfix patches for blk-iocost
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tj@kernel.org,
        josef@toxicpanda.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221018121932.10792-1-shikemeng@huawei.com>
 <93f9093b-abec-db7e-a945-263cd9355c08@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <93f9093b-abec-db7e-a945-263cd9355c08@huaweicloud.com>
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

On 11/30/22 6:45?PM, Kemeng Shi wrote:
> 
> Hi jens,
> on 10/18/2022 8:19 PM, Kemeng Shi wrote:
>> This series contain a few patch to correct comment, correct trace of
>> vtime_rate and so on. More detail can be found in the respective
>> changelogs.
>>
>> ---
>> v2:
>>  Thanks Tejun for review and comment!
>>  Add Acked-by tag from Tejun.
>>  Correct description in patch 3/5 and 4/5.
>>  Drop "blk-iocost: Avoid to call current_hweight_max if iocg->inuse
>> == iocg->active"
>>  Drop "blk-iocost: Remove redundant initialization of struct ioc_gq"
>>  Drop "blk-iocost: Get ioc_now inside weight_updated"
>> ---
>>
>> Kemeng Shi (5):
>>   blk-iocost: Fix typo in comment
>>   blk-iocost: Reset vtime_base_rate in ioc_refresh_params
>>   blk-iocost: Trace vtime_base_rate instead of vtime_rate
>>   blk-iocost: Remove vrate member in struct ioc_now
>>   blk-iocost: Correct comment in blk_iocost_init
>>
>>  block/blk-iocost.c            | 16 +++++++++-------
>>  include/trace/events/iocost.h |  4 ++--
>>  2 files changed, 11 insertions(+), 9 deletions(-)
> Could you apply this patchset?
> By the way, my apply for an cloud variant of email was just passed
> a few days ago. Is this mail still in spam?

This one wasn't, but I've seen the huaweicloud.com emails fail
the same origination checks in the past.

-- 
Jens Axboe
