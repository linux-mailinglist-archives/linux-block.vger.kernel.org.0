Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2825576008E
	for <lists+linux-block@lfdr.de>; Mon, 24 Jul 2023 22:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGXUfh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Jul 2023 16:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjGXUfg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 16:35:36 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FEEAD
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 13:35:35 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1bbbbb77b38so112655ad.3
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 13:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690230935; x=1690835735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iaZ8mXsr3HxozHi0cZ1MUPdLkAHmetYSKOXu6uu6Rlw=;
        b=RYBgrLJ7RxT6hGvPbnikg5OXA86mELV/OMYAzNT9Dmnwb3u2eBcboO467RfCvBf52X
         pb2f87/ne6I8n0fgehVxQx+g848F5UgUNGwSViau1Bj4/enpZgifFftUkD1vYaBX/j9S
         t1Kkt3YFLIwq2WycwM0PjZ/LPuJCkiKpwlZB+i+eO0qkdiXJ2qrRMzqRmLPnpTY2737V
         S6OtqDrR93NBPVVz11MquoXFFOidgKlLQNBv5bba5iAbs3MTEqzgJaNONYV4rgSaiYlp
         b34dzw2n7o02rTYBPRnjxDPMHgkwinDctDrJkZ2nRnIwI4WrxNd64zwOwovMNiigQRDX
         Pg7g==
X-Gm-Message-State: ABy/qLYrVgDQk5fB+J7Wqklwwl/1vPic+CEfjPVhtCqTSQUhbV27WLTX
        zL+ovkz6EsxqTArX2ZJCuJ4=
X-Google-Smtp-Source: APBJJlEZQat5xeFk4t8ieu2jhy70tpWqGCDuY7k66JkC0Hr+RFbrnV1dNXld27/nEXaC7OL9oiiFcA==
X-Received: by 2002:a17:902:c10c:b0:1b9:cc6b:408c with SMTP id 12-20020a170902c10c00b001b9cc6b408cmr8829327pli.38.1690230934673;
        Mon, 24 Jul 2023 13:35:34 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:bda6:6519:2a73:345e? ([2620:15c:211:201:bda6:6519:2a73:345e])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902b94b00b001ac7f583f72sm9420411pls.209.2023.07.24.13.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 13:35:34 -0700 (PDT)
Message-ID: <de3b05d2-34f8-a31c-5b4e-e40c3ce93e0b@acm.org>
Date:   Mon, 24 Jul 2023 13:35:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: Fix a source code comment in
 include/uapi/linux/blkzoned.h
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Shaun Tancheff <shaun.tancheff@seagate.com>,
        Damien Le Moal <damien.lemoal@hgst.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20230706201422.3987341-1-bvanassche@acm.org>
 <748be866-766c-e307-e0f1-13c6cc57ee5d@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <748be866-766c-e307-e0f1-13c6cc57ee5d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/6/23 16:41, Damien Le Moal wrote:
> On 7/7/23 05:14, Bart Van Assche wrote:
>> Fix the symbolic names for zone conditions in the blkzoned.h header
>> file.
>>
>> Cc: Hannes Reinecke <hare@suse.de>
>> Cc: Damien Le Moal <dlemoal@kernel.org>
>> Fixes: 6a0cb1bc106f ("block: Implement support for zoned block devices")
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> 
> Looks good.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Hi Jens,

Do you agree that this patch is ready to be merged?

Thank you,

Bart.


