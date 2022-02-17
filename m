Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C152D4B9657
	for <lists+linux-block@lfdr.de>; Thu, 17 Feb 2022 04:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiBQDIN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Feb 2022 22:08:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiBQDIN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 22:08:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7FD160FC0
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 19:08:00 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so8225417pjl.2
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 19:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m0P9N0WVb6AAY2j7DvviRpPpziBTQrcj2AKsHwgmWuw=;
        b=MXrMezWjXbcndPIug7qJGx/KHFAQ7CSHaswSmR9MRANlQU9yJCNBptTPJazM8l/YCk
         mqAxPoN1u3ukSKF6AZDJQUqb/ILcTsmm6odOPcNe+AecyCA6qkVUDjo2VMVuqzKHNs4v
         1BvU4cBk2ewB20ZLqR9BXLWfclLCTn/j5n+vya9PD7VgV4uAfHaosnxKv5YylxkqkbJP
         Ho8xLE0N7fAh/qK0Kkmy6ySJtwCLcyM2EmOOvxYa1X5/mFmuwFYaNotlT5W4Kk0zq2oM
         OBsmIxWQbbP+Fxvvwx8eeEcAZMg3ZwmKFevlXqa6T5omJ5uYlILM7KsI3b8t7lDKfRU0
         xGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m0P9N0WVb6AAY2j7DvviRpPpziBTQrcj2AKsHwgmWuw=;
        b=h+th4oXABl1+rOCbmcBJ8Gij4bu2SGW23fclHg0pvs4lKIuHVyTsB+oNs4Nk4bIl0m
         RXOqZFoz0S4cyf6Fy/nQjjqXDoq5idg5XPnDHwFpJytIT4zhn/BYxKHMUJyPYCWyLMI3
         7wfWkIiTp1LlW8HilSCpt4zGtajt+pOGVSSc3Siewzy+FYFD1knRaIi7kUCvddaH62zq
         wF42a41fYHeCLdcTice++WPcwvm2E7zDD+/o3+vcpeA0BdKHVtwvtYXEsTMjEpLamMpF
         AKfhMpQ5cOQwI2/mqUx2Uiy3zW3lL5OCPFD1+Tlhf2u5gzcKLpIC1e7ztfBmmsC22Bbg
         r9rA==
X-Gm-Message-State: AOAM533/vkFXIa93Hu6FzBTpqMDz3NwkpEsAlFH2b6QCkhqjWQCMowWm
        /Db/ojqMBsrGR/Yr8xmZuXYPvg==
X-Google-Smtp-Source: ABdhPJz0asluo8iIS9RrrQHu2lUE14mBYhmmL4kxvHAkUj2TEWV/p8/NhGuQnU8TsBWnkNPOevvXaQ==
X-Received: by 2002:a17:902:f787:b0:14f:43ba:55fc with SMTP id q7-20020a170902f78700b0014f43ba55fcmr979111pln.3.1645067279683;
        Wed, 16 Feb 2022 19:07:59 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id lb18sm407819pjb.42.2022.02.16.19.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 19:07:59 -0800 (PST)
Message-ID: <2f3f1c98-e013-ee03-2ffb-3a14730b13b9@kernel.dk>
Date:   Wed, 16 Feb 2022 20:07:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: remove REQ_OP_WRITE_SAME v2
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        target-devel@vger.kernel.org, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, manoj@linux.ibm.com, mrochs@linux.ibm.com,
        ukrishn@linux.ibm.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
        dm-devel@redhat.com
References: <20220209082828.2629273-1-hch@lst.de>
 <yq1wni3sz4k.fsf@ca-mkp.ca.oracle.com> <20220210055151.GA3491@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220210055151.GA3491@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/9/22 10:51 PM, Christoph Hellwig wrote:
> On Wed, Feb 09, 2022 at 01:00:26PM -0500, Martin K. Petersen wrote:
>>
>> Christoph,
>>
>>> Now that we are using REQ_OP_WRITE_ZEROES for all zeroing needs in the
>>> kernel there is very little use left for REQ_OP_WRITE_SAME.  We only
>>> have two callers left, and both just export optional protocol features
>>> to remote systems: DRBD and the target code.
>>
>> No particular objections from me. I had a half-baked series to do the
>> same thing.
>>
>> One thing I would like is to either pull this series through SCSI or do
>> the block pieces in a post merge branch because I'm about to post my
>> discard/zeroing rework and that's going to clash with your changes.
> 
> I'd be fine with taking this through the SCSI tree.  Or we can wait
> another merge window to make your life easier.

Let's just use the SCSI tree - I didn't check if it throws any conflicts
right now, so probably something to check upfront...

If things pan out, you can add my Acked-by to the series.

-- 
Jens Axboe

