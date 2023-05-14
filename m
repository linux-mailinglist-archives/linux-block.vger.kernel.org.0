Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E6C701B11
	for <lists+linux-block@lfdr.de>; Sun, 14 May 2023 03:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjENBj7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 13 May 2023 21:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENBj6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 May 2023 21:39:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA8F2682
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 18:39:56 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6463185f761so1524096b3a.0
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 18:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684028396; x=1686620396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BKt1LzqC9JJ0Xe6yYnzJlUisPwLdy3pufUyPL32XOaM=;
        b=nECaR3gjPwh6MtV/ocnAfi0i76b2pKNm80xPlzQjU5bUU2VqhDkk3LKd09aHbeotEZ
         m1UthZI8Q2RHwFokq+b9tj5iRlU5qZRPzzcXdyVt2BGgwaCnCt6cDu33wB+bQ24YKqEK
         oMeCKIzQLuw868KYYWHt8QK9F6WW+vTnpDQrre36VmMH4yxxvR175ogoGc0ppJmhbp8Q
         YamdM6zT3xaf68GnsT8kiPmHa8LCp492EdyCuGJlOgiMuVa9P1jMZu2ikvkmQQOG70+I
         zZHwKeAw/Map8dp6rc4aPQsXeIgB8UUa2XDR2bDbsY/BlJopHyP24kQ+jUJBfa6mm0xq
         IfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684028396; x=1686620396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKt1LzqC9JJ0Xe6yYnzJlUisPwLdy3pufUyPL32XOaM=;
        b=SjXD8ibd0dWwj5OPmoqFzDlJNeZOJ+vQOt0Ljp4k738GUhXUTX26m3Zy6N5z3mA9iD
         +mKuTrgLD7sbhZMrII6MKUYwffqucf4CuKhnZBlyL3zL4b+CqDvD8mfcX6yBynATVuCO
         amnOi8fDcyk/Cw5tXCwlPAfKfrNv2eavtSiMRAcfeY84wcIwD47qalmVI9FwZKki9qlZ
         clBChrjfBK4cm1B3Pt0A0GLhRg3BsiMsg2Pit88n8eIaLtByZ84acRwgZfak4kyFr3i9
         04opM3Ga/uzvYFDkb9HzZM757IE+OhrWkAPBkwT6iaQKDPxEqtlFACUmmSP80G6RU0Sv
         Nr8w==
X-Gm-Message-State: AC+VfDwk69pesoMiQl2RzpvdCFsadAGJvIwyvtx/DiPfuwDYmTTleD4r
        SIakAA2pBU4Y3EFMlMRpVXL/wuAVhtrecZvZcCA=
X-Google-Smtp-Source: ACHHUZ7+n1rNhr7BvicPANiiQIqOjnF0OlLgFLES77MbyHHld7HARnW7PRPPTPJEa16G0RVe9R6yrw==
X-Received: by 2002:a05:6a00:4c99:b0:637:434a:75df with SMTP id eb25-20020a056a004c9900b00637434a75dfmr28759474pfb.0.1684028396366;
        Sat, 13 May 2023 18:39:56 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o33-20020a635a21000000b0052871962579sm8880012pgb.63.2023.05.13.18.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 18:39:55 -0700 (PDT)
Message-ID: <a685e5d2-5da8-2ff2-c53d-dbf77fa9609d@kernel.dk>
Date:   Sat, 13 May 2023 19:39:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] blk-mq: fix blk_mq_hw_ctx active request accounting
Content-Language: en-US
To:     Tian Lan <tilan7663@gmail.com>
Cc:     horms@kernel.org, linux-block@vger.kernel.org, lkp@intel.com,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        tian.lan@twosigma.com
References: <892f5292-884b-42ef-fe24-05cfac56e527@kernel.dk>
 <20230513221138.497270-1-tilan7663@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230513221138.497270-1-tilan7663@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/23 4:11 PM, Tian Lan wrote:
> Thanks Simon and Jens, I will remove the unused reference. 
> 
> And I'm sorry again, I'm very fresh in kernel development and still 
> trying to learn the whole process. Hopefully this is the last time I will 
> have to make the change (previously, I was compiling the entire kernel and
> missed the warning message). Thank you all for being patient with me and 
> tolerate all the silly mistakes.

There should be zero warnings when compiling, so the easiest way to
check and catch it would be:

$ make -jX -s

as that will be quiet unless a warning or error is triggered.

-- 
Jens Axboe


