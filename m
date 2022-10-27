Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED6160F459
	for <lists+linux-block@lfdr.de>; Thu, 27 Oct 2022 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbiJ0KD2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Oct 2022 06:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbiJ0KDL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 06:03:11 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B6BAD98F
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 03:02:48 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id fy4so3011461ejc.5
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 03:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpWS2J3Es7uIIpMV8NfXpdIdeICyL7ab7tVCU0uhI/U=;
        b=7LQWORwlBcytGd0JXHrg5PXT2k4JEFQQOzHUjCjjcLG0SNyqbXkAAEOhb+JEkxWxPr
         LinCivw9zX8c4Pf/RKXCo/DxhXfpJKkiu+tIKvvJx1Y9RxrFiC0gvw1/U8Rb4fY+bKSy
         GZESHSsmwUILvhROa8XPwVCE55EvbrK9GuW3bSgkAxxFO+yCPElgvXVfrKS1nyClVFjU
         ynh9+3PIWZUcz269sQUHIxUt7wTpf9UqQ851Pct6gXy838rwufgeuSP41bZP76EZjQ3f
         XtjIVovEtqayfjVSh9xREneBqzXE+DTYGicl5eOTkDhg/quRj/rsKQUWvWgtVg6yzSMb
         vueg==
X-Gm-Message-State: ACrzQf1IIxiNPDMnXfuqff1C4sF3mAzj0OnWLbq6vrIocB44TywPzsAH
        +WFUikXWw4nViOyWL9/w7dpGjC1Bb2s=
X-Google-Smtp-Source: AMsMyM5CY/5nG0MF2o1QHRha6hhsy0fgyBazhGunp8Q8cB1Uf/XbdOvnjOKX5Eq06ScaH9xc4Sfd9A==
X-Received: by 2002:a17:907:7627:b0:78d:b6f5:9f15 with SMTP id jy7-20020a170907762700b0078db6f59f15mr42093169ejc.149.1666864966910;
        Thu, 27 Oct 2022 03:02:46 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id h8-20020aa7cdc8000000b00459012e5145sm691985edw.70.2022.10.27.03.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 03:02:46 -0700 (PDT)
Message-ID: <bf1fa182-2bab-905d-f48e-eae70e64fd96@grimberg.me>
Date:   Thu, 27 Oct 2022 13:02:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 14/17] blk-mq: move the srcu_struct used for quiescing to
 the tagset
Content-Language: en-US
To:     Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-15-hch@lst.de>
 <12eb7ad8-6b70-092a-978c-a2c1ba595ad4@huawei.com>
 <73072365-adc5-1430-0b12-f552fd99b96e@grimberg.me>
 <276f0800-2927-624d-0d90-8a5722f6d93b@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <276f0800-2927-624d-0d90-8a5722f6d93b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> +
>>>> +    if (set->flags & BLK_MQ_F_BLOCKING) {
>>>> +        set->srcu = kmalloc(sizeof(*set->srcu), GFP_KERNEL);
>>> Memory with contiguous physical addresses is not necessary, maybe it 
>>> is a better choice to use kvmalloc,
>>> because sizeof(*set->srcu) is a little large.
>>> kvmalloc() is more friendly to scenarios where memory is insufficient 
>>> and running for a long time.
>>
>> Huh?
>>
>> (gdb) p sizeof(struct srcu_struct)
>> $1 = 392
> I double recheck it. What I remember in my head is the old version of 
> the size.
> The size of the latest version is the size that you show.
> Change the srcu_node array to a pointer in April 2022.
> The link:
> https://github.com/torvalds/linux/commit/2ec303113d978931ef368886c4c6bc854493e8bf
> 
> Therefore, kvmalloc() is a better choice for older versions.
> For the latest version, static data member or kmalloc() are OK.

We can keep it dynamic allocation IMO.
