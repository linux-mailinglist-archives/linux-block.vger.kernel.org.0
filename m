Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2692B615788
	for <lists+linux-block@lfdr.de>; Wed,  2 Nov 2022 03:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiKBCYq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Nov 2022 22:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiKBCYp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 22:24:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B60264DD
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 19:24:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so646871pjl.3
        for <linux-block@vger.kernel.org>; Tue, 01 Nov 2022 19:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7UBdmk5MbBq8xf2xERnJFzAhfjmMFD1Ky4jz35lNF8=;
        b=Ov3ploiPrzbeq6flPiF5LhBY7nXtGzNgcCAIY30CnXl+B32v/IR7MR9/Rr7Y5yuWlK
         yzO9kkalrV7/xaphq3qK7InlXhNHnVNq0gvmWKqYQsr1S3A+U5F/XTl2w9rtiOy3zn72
         QhjChHTrUAzLJd39wvxVjEkG4pGXGaVaBK5U4flJlX+0boaeHtRZWOuZGTIWo+dBjlv0
         it64h/ou+b/y6xcAl7s8bSFN3dLtinvtt7Fo3iRcOSBVO1DSzdGijmNgbb4LafoQvvNq
         yw3BWEYKEKxP9N8XKSQox7JZixChmshToPYAbDvxd9BeL5DzUEr8Aa6lKQKQTfXr4Kvd
         EFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7UBdmk5MbBq8xf2xERnJFzAhfjmMFD1Ky4jz35lNF8=;
        b=Vmb85heAX3LY6uNtetycfno9Yv8Zx3Kn8pjRWMRNXZutaeY/K2pSOE6CznqQfPymxk
         uDySwCDokkts87Bharjf6urOXdpr59lq+OXVz+USThw7R2rOInKujC8GQzY0Eq6FlriP
         NqeZeW3NqxRFsI0Km9ihYQHe3Qwy9+nhay8Mtb8RtB42YfRV/Wsjb1g4tg5bK3MruJsg
         Vr86z12H06/hdrdu9w8WUoL/aW+idyV+d+LypjLoehTufz9CI2zvL09u1MDrjUXfSMV5
         guQZr8uylyMIj9kbidSwy9IOyMGIGI2KMiYtPSVQR2GkW8nFEYd7PznaK4pk/dcM52bX
         3pXA==
X-Gm-Message-State: ACrzQf3HLDZCBhnDJqnOgCRrIovY68vCU5wnHQT4QWqiN9wjQKp4y4Hh
        ht4XLcAtS4NIg1XUVk89TuA0QQ==
X-Google-Smtp-Source: AMsMyM7f3lJIE5Nd37JDrODYmcoJXutEpbXq+qiZ6RiEAYOekxd2L2qLxa6g18v1swxU0Uu3FLNHng==
X-Received: by 2002:a17:903:41cc:b0:186:b756:a5f0 with SMTP id u12-20020a17090341cc00b00186b756a5f0mr22440171ple.132.1667355884067;
        Tue, 01 Nov 2022 19:24:44 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z7-20020aa79587000000b0056bb4bbfb9bsm7377584pfj.95.2022.11.01.19.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 19:24:43 -0700 (PDT)
Message-ID: <0ddaf04b-84b5-8173-a67c-5dadce684108@kernel.dk>
Date:   Tue, 1 Nov 2022 20:24:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH -next v4 1/5] block, bfq: remove set but not used variable
 in __bfq_entity_update_weight_prio
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz,
        paolo.valente@linaro.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221102022542.3621219-1-yukuai1@huaweicloud.com>
 <20221102022542.3621219-2-yukuai1@huaweicloud.com>
 <7f7e59cb-e0b8-0db5-7c46-11aea963bcfa@kernel.dk>
 <ee543096-ae21-99d3-f3a5-483deab03a5f@kernel.dk>
 <61725ff6-6da3-3d3c-4261-7f05c57ab9da@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <61725ff6-6da3-3d3c-4261-7f05c57ab9da@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/1/22 8:18 PM, Yu Kuai wrote:
> Hi,
> 
> 在 2022/11/02 10:11, Jens Axboe 写道:
>> On 11/1/22 8:09 PM, Jens Axboe wrote:
>>> On 11/1/22 8:25 PM, Yu Kuai wrote:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> After the patch "block, bfq: cleanup bfq_weights_tree add/remove apis"),
>>>> the local variable 'bfqd' is not used anymore, thus remove it.
>>>
>>> Please add a Fixes tag.
>>
>> Looks like the rest were good to go, so I added it myself.
> 
> Thanks for helping out. I'm not sure which commit id to use since the
> fixed patch is not in linux-next yet, does the commit id stay the same
> when the patch applied from for-6.2 to next ?

linux-next shas are not stable, but since you're sending this to the
linux-block list and against the block tree, that's obviously where
you'd find that commit.

-- 
Jens Axboe


