Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E886DE340
	for <lists+linux-block@lfdr.de>; Tue, 11 Apr 2023 19:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDKR4O (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Apr 2023 13:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDKR4O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:56:14 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F345276
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:56:11 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id pc4-20020a17090b3b8400b0024676052044so8865835pjb.1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235771; x=1683827771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIAzb5QuICVe/X0zP7CoW550fApxU6NqMy7GxIlKCdw=;
        b=ev6Wkpvywj2jVM4G2DkFWNAHs+KxD0fip8aYdj/mFGzqxG5Ymyuq6Q2C5oRvlaxBYL
         y4W7TsmHTSYc6S0IZW/6skI1V8KmqzlFUs3JRgPknzOdd2KdTlYsglLxT8ZxFuxrT2Aj
         1X8YYzEHO4th0uSlyCxMcKs+5gfW3GI6F/Dh3RZKz2QPApcoE5N0r5p/50xSIgy7RdP8
         bmsKcsHSyvzu9WrhyoPik9tjmE4pqDu50wj3VAIu3KRKBgtQyQG4k8oDE8lc1Y/Bnp6k
         REu+rqQdblPoFjpnc1B4CPnk4u3TnaxVFyeT79whc0TJGZLLANzmX2TOwKMTDpE8xiWe
         DvSA==
X-Gm-Message-State: AAQBX9cTvRFFyiMr6AMEg9dzJ0XC7eRPocs00JmGvtDkm3IDIPlIKMnj
        hT+Bh2acqL3hlNWitcVDFO0=
X-Google-Smtp-Source: AKy350bEVfIpZfIMFOHkB9xk1uMpB2xPn/G1DA5hmPNxncbNa2JmalhIXcRZEacK7J2ADCCmTXVq/w==
X-Received: by 2002:a17:90a:498b:b0:246:d375:1598 with SMTP id d11-20020a17090a498b00b00246d3751598mr4696055pjh.49.1681235771005;
        Tue, 11 Apr 2023 10:56:11 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id gd22-20020a17090b0fd600b002465ff5d829sm7617635pjb.13.2023.04.11.10.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:56:10 -0700 (PDT)
Message-ID: <99b07490-ae86-52df-add7-13a2af7beed5@acm.org>
Date:   Tue, 11 Apr 2023 10:56:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 09/16] blk-mq: refactor the DONTPREP/SOFTBARRIER andling
 in blk_mq_requeue_work
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230411133329.554624-1-hch@lst.de>
 <20230411133329.554624-10-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411133329.554624-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 06:33, Christoph Hellwig wrote:
> Split the RQF_DONTPREP and RQF_SOFTBARRIER in separate branches to make
> the code more readable.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
