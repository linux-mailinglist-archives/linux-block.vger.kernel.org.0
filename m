Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7086D526E82
	for <lists+linux-block@lfdr.de>; Sat, 14 May 2022 09:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiENC5K (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 May 2022 22:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiENCzu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 May 2022 22:55:50 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7889730AAE4
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 19:26:37 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id c9so9597297plh.2
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 19:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R0oSDV3Uu6hYpnSvYAJFLDVj7krUBLdGyd/Tyz4EA6g=;
        b=c5hPWQku2Ami2l38eK6G57/q3ysclcS088p87BAm6hmub5zPiZkal5W1Vt0+Cj1NMk
         yqA6OvE9Kqeh0/2v6iZjT/NFp0bizawk/WzjbksEAeQlzhGCWChfPEj2OBZldrkylmJi
         fPUe9iHA9ZgVYJUKwTsmMoFUpFoFvrrad15tuYiuTbc9VWKTLR38EamS13JLMsKcGwi+
         V6kgg4EO5PiXcy6MzdBKthC5lHSltdrKZk5Cku34/itH83rwVfPvpQycjPKzJqsNFdtm
         9phsdchgBcohv462vqVjxVqBmhTO/oCQuO7xo+j5hOvWQxwl9cQfOe1qunCAIW7x1qiF
         XKKg==
X-Gm-Message-State: AOAM531hj9Rj+imn05TUGwXZXSDqDh2xk4/di+DmNfErMPIvdyBNa83J
        ktsUp263uaNqC7kQv5KlFEg=
X-Google-Smtp-Source: ABdhPJzFnFyiKb493dPxxW1MZ76t2oGiyNnMcP7+kgHQzx9NJ8DbHENRrEmL4+Kxe8W/I6DmrUsq5Q==
X-Received: by 2002:a17:903:22cf:b0:15e:cf4e:79c9 with SMTP id y15-20020a17090322cf00b0015ecf4e79c9mr7608742plg.54.1652495196856;
        Fri, 13 May 2022 19:26:36 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id c9-20020aa78e09000000b0050dc76281ebsm2412423pfr.197.2022.05.13.19.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 19:26:36 -0700 (PDT)
Message-ID: <91c2e8b9-7ef5-5c66-6ddc-e411d14df56c@acm.org>
Date:   Fri, 13 May 2022 19:26:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] block: ensure direct io is a block size
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Kernel Team <kernel-team@fb.com>,
        Keith Busch <kbusch@kernel.org>
References: <20220513161339.1580042-1-kbusch@fb.com>
 <20220513161339.1580042-3-kbusch@fb.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220513161339.1580042-3-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/22 09:13, Keith Busch wrote:
>   	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> +	if (size > 0)
> +		size = size & ~(queue_logical_block_size(q) - 1);

The above code won't do what it should do if sizeof(size) > 
sizeof(queue_logical_block_size(q)). Please use the ALIGN() macro instead.

Thanks,

Bart.
