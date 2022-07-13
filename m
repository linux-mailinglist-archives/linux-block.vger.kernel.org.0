Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395D05731FD
	for <lists+linux-block@lfdr.de>; Wed, 13 Jul 2022 11:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbiGMJEC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 Jul 2022 05:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbiGMJD5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jul 2022 05:03:57 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898B232ECF;
        Wed, 13 Jul 2022 02:03:52 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id bu1so13364749wrb.9;
        Wed, 13 Jul 2022 02:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D4vlOUSuSK+FhTh9wftzc20mzgHbEI0vkhcBDU8k6o0=;
        b=61Ehp2S/6mBp04O9832ppzlcal3T/AMVdXruNV078bPFFWj4PQxgHxf/cxsYPYeIS6
         LOE4xvBRhtyzt2u8nSCD5htUKiVzURhHw/fPcGr0SlMr2x85SFVyOrvyCvs+Anfi/uKk
         Ff+GvrUlMV5E9i+fmv5OoncNmIbzRiTWDNF3P088ze/WcLIa4jjRT+qPqk4hETJOn1pX
         dzWx2HLofeWl1xdMHArzjnu9hRvTmDeOJ/V5NS8fIqMGJ8Mta3xIuTOlIxHoD9KbXbu4
         Ltb1Qe9UlvtWgYt3bvAQ/newE9YUnF+LFR2N+RDQBCHn5dJPhROO1xJjRD+v29KkbtrX
         DmoQ==
X-Gm-Message-State: AJIora85+EfsDxnhZl2wM+NLILSYUCYeqoPklLg62fufPLzHt3Pg3xUM
        LvtdzEhvXwXQpY4tGLvq0NY=
X-Google-Smtp-Source: AGRyM1sUOndfxHpFDhmMn2Ko7HTQ1cbOP4ustw2mw9OA5suipI6Gdfvjnx8Gk5ApYqYcu1YToSzZJQ==
X-Received: by 2002:adf:fb83:0:b0:21d:649a:72d9 with SMTP id a3-20020adffb83000000b0021d649a72d9mr1986938wrr.688.1657703031143;
        Wed, 13 Jul 2022 02:03:51 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600011c200b0021d68a504cbsm10344745wrx.94.2022.07.13.02.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:03:50 -0700 (PDT)
Message-ID: <f15bc945-8192-c10e-70d8-9946ae2969ce@grimberg.me>
Date:   Wed, 13 Jul 2022 12:03:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     hch@lst.de, kbusch@kernel.org, axboe@kernel.dk,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, asml.silence@gmail.com,
        joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com>
 <20220711110155.649153-5-joshi.k@samsung.com>
 <3fc68482-fb24-1f39-5428-faa3a8db9ecb@grimberg.me>
 <20220711183746.GA20562@test-zns>
 <5f30c7de-03b1-768a-d44f-594ed2d1dc75@grimberg.me>
 <20220712042332.GA14780@test-zns>
 <3a2b281b-793b-b8ad-6a27-138c89a46fac@grimberg.me>
 <20220713053757.GA15022@test-zns>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220713053757.GA15022@test-zns>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> However io_kiocb is less
>> constrained, and could be used as a context to hold such a space.
>>
>> Even if it is undesired to have io_kiocb be passed to uring_cmd(), it
>> can still hold a driver specific space paired with a helper to obtain it
>> (i.e. something like io_uring_cmd_to_driver_ctx(ioucmd) ). Then if the
>> space is pre-allocated it is only a small memory copy for a stable copy
>> that would allow a saner failover design.
> 
> I am thinking along the same lines, but it's not about few bytes of
> space rather we need 80 (72 to be precise). Will think more, but
> these 72 bytes really stand tall in front of my optimism.

You don't have to populate this space on every I/O, you can just
populate it when there is no usable path and when you failover a
request...
