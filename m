Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAFA3EA8B7
	for <lists+linux-block@lfdr.de>; Thu, 12 Aug 2021 18:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhHLQrS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Aug 2021 12:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbhHLQrQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 12:47:16 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9440DC0613D9
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 09:46:51 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id r19-20020a0568301353b029050aa53c3801so8525578otq.2
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 09:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pq0QUH/VcZ2vtmpr9YCfMhQR/7cJY0M/JWUa/959iiw=;
        b=siOEkxSZN+x8U7kd06QqPGOBt8c1XnEBZERPyizdXqPSjKBjmaJYXwH/sQIo4Vh8yI
         9h2s6Bntv43fORJEoK6c8PxpbZq5DFApx/W7IK1fbG5iLm7lIMVpwbD569VeTqdEnT+m
         jtevUCGJ5rmie157qHeJIJb04etC4MUkcNx6fc+PGROQqThV3e85VcLwgbMAXW5uHrnM
         XKkEsnQy2QMVBR84CiHWzaE6iYiexP2Z5ZJMQjhu7oS5+54f9fDy7VHQbl86Betutwqh
         0BsphwWeR+X5jXILBdF5kKtaq+OfzDAZSvTheOGBS7P9q7LzI/zYRxXVoikr0tnnR2MY
         lWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pq0QUH/VcZ2vtmpr9YCfMhQR/7cJY0M/JWUa/959iiw=;
        b=K79jLcajFQ8XD71ZrbONZ/WTgmeCk7JPv3Uby/eJnsNCOhxR9htH8hLJnWEif1+DDk
         4AjBXFzNPykyiLJDfAJfwv1soCmfoUJ3ynIF4gSVb5/siOWSKJViEyzzjpyNcAcs9lQD
         fsuZSN0Rlqh1cR50WyEkO2DFRu2flVNIbSF71l0JdOhkr9r11XCXSYf/wcX2BWEPzi1w
         5YW/C0SPAkpbWYTZK5wgQsYSpl2uCVPt9WN8na17pF2r5Zt0vchJHuMH2dq9K8o4FOa/
         bsTs9xtzZUV5h/r+cCiUFA9+DTwszpvzy+VZc8id6wD5hGTeJa5oWyMfYTQ+jqaffT21
         rcZA==
X-Gm-Message-State: AOAM531w8PULhKg6588xRS+TWABI+4BamYh/gCva/aom0KtGcdmxdtEz
        nGyWWD/KZyK36EHd4wjboC/+OEh/vwFC4k9w
X-Google-Smtp-Source: ABdhPJxLr5Uu/pHS4FOZxHNj7vP7v18Lu1tDBH0DDAys7VNdFZBUit/Tgp7bevXpc28pDR9N+2GR6g==
X-Received: by 2002:a9d:7d0d:: with SMTP id v13mr4216514otn.252.1628786810828;
        Thu, 12 Aug 2021 09:46:50 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u136sm704638oie.44.2021.08.12.09.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 09:46:50 -0700 (PDT)
Subject: Re: [PATCH 5/6] io_uring: enable use of bio alloc cache
To:     Christoph Hellwig <hch@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
References: <20210812154149.1061502-1-axboe@kernel.dk>
 <20210812154149.1061502-6-axboe@kernel.dk> <YRVOrHvfBSKBiBEr@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <40288323-8d7d-d068-28b6-27c5794b8ff4@kernel.dk>
Date:   Thu, 12 Aug 2021 10:46:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YRVOrHvfBSKBiBEr@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/21 10:39 AM, Christoph Hellwig wrote:
> On Thu, Aug 12, 2021 at 09:41:48AM -0600, Jens Axboe wrote:
>> Mark polled IO as being safe for dipping into the bio allocation
>> cache, in case the targeted bio_set has it enabled.
>>
>> This brings an IOPOLL gen2 Optane QD=128 workload from ~3.0M IOPS to
>> ~3.3M IOPS.
> 
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Didn't the cover letter say 3.5M+ IOPS, though?

It does indeed, we've had some recent improvements so the range is now
more in the 3.2M -> 3.5M IOPS with the cache. Didn't update it, as it's
still roughly the same 10% bump.

-- 
Jens Axboe

