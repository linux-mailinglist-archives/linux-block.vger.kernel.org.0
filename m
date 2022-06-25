Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAE855A67A
	for <lists+linux-block@lfdr.de>; Sat, 25 Jun 2022 05:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiFYDCo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Jun 2022 23:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiFYDC1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 23:02:27 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF19C699A0
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 20:00:40 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so7382396pjr.0
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 20:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3n/crq/CcoccSfmYuthh6Sy0YFpogQOPmd30lR3ckgU=;
        b=Ga3ylPpaYdEmSeGUoTUAeM95nWLMA8mXVG7WT/nxf6Oe39eVtdtOlJDy5d6lBmewrq
         myDekPCgqINSpqw3CEchGpU0tO4QO1wQrISIM3dp+0pwmzYBX5EZ3PnjUg9qKEptHrhp
         JD01Ngy9f7kQZs5lNWDnZCpMpem2D48EAxECTiclz4SBr8176h9D8xFtTUIt8VpqlFLR
         3il5DDaQ4cTC6tZH5L4XNcBoU7VT/d+7zAYDdRU37VErzXWN8xJc4OhsKYAMN6bsJoIB
         7iphEsyrDq6W1Cf8dcW9zEu+I7Vn4yPvlDTjKbSYu5g1/BFUwqPYQoKubfB14NoODH5k
         g8gA==
X-Gm-Message-State: AJIora/2Ku7S94H4jGTauaoL875f5rtk4adbvIZq+lpLzwfqda0Bp1E/
        ZOZgZLn8X46s8oPQngJTpTE=
X-Google-Smtp-Source: AGRyM1srvwfpMf84lZM7vlIA/ZiC5G/6X+mg6WbtIHupCCwKZDcuyar/qy+aaGRTb8+6fwbq8Mk/sg==
X-Received: by 2002:a17:90b:1e45:b0:1ed:2fae:bc5a with SMTP id pi5-20020a17090b1e4500b001ed2faebc5amr2325348pjb.208.1656126033352;
        Fri, 24 Jun 2022 20:00:33 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id p1-20020aa79e81000000b00522c5e40574sm2448540pfq.129.2022.06.24.20.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 20:00:32 -0700 (PDT)
Message-ID: <5bb73271-95bf-2ae8-cdff-b9b27abb255a@acm.org>
Date:   Fri, 24 Jun 2022 20:00:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/6] block: use default groups to register the queue
 attributes
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220624052510.3996673-1-hch@lst.de>
 <20220624052510.3996673-4-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220624052510.3996673-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 22:25, Christoph Hellwig wrote:
> Set up the default_groups for blk_queue_ktype instead of manually calling
> sysfs_create_group.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
