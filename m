Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E8060E16A
	for <lists+linux-block@lfdr.de>; Wed, 26 Oct 2022 15:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiJZNDp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Oct 2022 09:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiJZNDn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 09:03:43 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE08FA005
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 06:03:42 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id a14so23419380wru.5
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 06:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2thhFCzMEWIWrj4xKNCjW7Ij35cNo2Mk5pOcDChl1FI=;
        b=jJSJk38VRU04sf24AWtr3gV9mJ2K33Q3M4sdj/tB808UuEK4TuAkG1UhMJZZZMeVd4
         zKvlQK0On+zHjZEw3Dta3sjTwHxK6VtFApPnsH36PS6Dz5jPOJ6fUUWNRo5snEO8y6y2
         HDlghuZZZBr64SQuNYzb2QbQFIjXt3xBbXB8i0S5iuALUcVAqR2vLXvmlbSe8kfj6HWE
         pPOy9C+SO6AyUcJ+0VHqyJ0UrXDl6NNL93bHeJQDyWyiFaV1D+FFZ8g4NWVHv18jInUR
         ihyyrZms5Tag6GAjHKkB60xlb09IY7WeN+9OvZeKaF3zNR/5xLtTWTRt5bzMLXis26Fk
         Io6w==
X-Gm-Message-State: ACrzQf2QKflWnT+2ZOhvz0+Bvb+eu+Ixz9s+6DzMRmYa0g3i+qASkXMC
        FpMLm4hFajeNEW2xopGWl5T//WDSXj8=
X-Google-Smtp-Source: AMsMyM6teqXthzPYDw0Ww80AFPEwxUpOtkuWdveVt3JxZ93AOyVPVO5lVF+5a06eAvB4OJ/nTfxFBg==
X-Received: by 2002:a05:6000:24f:b0:236:76e8:33fd with SMTP id m15-20020a056000024f00b0023676e833fdmr9255292wrz.215.1666789410424;
        Wed, 26 Oct 2022 06:03:30 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id ba21-20020a0560001c1500b002238ea5750csm6793449wrb.72.2022.10.26.06.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 06:03:28 -0700 (PDT)
Message-ID: <bc8a1130-3688-6bc5-067e-56a8d935f331@grimberg.me>
Date:   Wed, 26 Oct 2022 16:03:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 17/17] nvme: use blk_mq_[un]quiesce_tagset
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-18-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-18-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks great,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
