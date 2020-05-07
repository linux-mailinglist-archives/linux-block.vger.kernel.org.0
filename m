Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D741C9953
	for <lists+linux-block@lfdr.de>; Thu,  7 May 2020 20:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgEGSbF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 May 2020 14:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGSbE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 14:31:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D89EC05BD43
        for <linux-block@vger.kernel.org>; Thu,  7 May 2020 11:31:03 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a7so3009027pju.2
        for <linux-block@vger.kernel.org>; Thu, 07 May 2020 11:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YTPqQ6hkmpHE0rdw6RfMrAaH7fnthYwduKnHwJKxLLE=;
        b=Xps+aKK2KWhwJYJdiKfLw0xpF7+tX8SLuyymQPAUzlsyJFS2KrqU41LV/a8L2tW2Q6
         jEsPGopnSz2QPtK6Znd9xtyIPFK32JUBbEJ5ZyobndBdYn5Y4oRgWfhjcUBRQP7f+jiR
         tMEglWxkI15Cc24C/FMl6o4JkcJhi9GKOnIDPJ4U9l1ENOfqsmPtmloZpQHh2gvEzXAN
         lBbIQ9ZqvThDLBKPuGfDR1/Boa06XbifdApFQjcTX6xAjtNG2zJHhO850C55HMJqLCRR
         d1GJSfWzO7LP0ANhxzbgy+tcRq9evhEHZu7wRRBm3TbSSbbgx+GoEjIiRtzVRbUhSzEY
         zRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YTPqQ6hkmpHE0rdw6RfMrAaH7fnthYwduKnHwJKxLLE=;
        b=aarENCZT4sCmbG/3FIvZJeHt9iHOgXeBXsT4WlsFo69B9YRjR7getRLvFyb5wrXFeO
         OIBdFrq7pcJ6u3eSJo5MWYWn0ryjhNTEzjeMvqf008kzW4mvhVpieHroRWSIkepeQe5z
         jarZOVoAtjZbdYMlywb4X6GpwfxAjjZp6mqnrseKbQ8Y3AAf02ynlEqBq5DrXRHRSFxJ
         GR9Rsdk+J9hye0PzWcqHYMKEbKy6qSAexCr+NGqYLssdac1UfZQQ6spFuazd8195LXty
         +4VwMldoOKh6UH9woV5+cKgvXZW5RK/+tbGBH2szce95m0uwlKMX1TCz6JWPMxY88Flf
         LbEA==
X-Gm-Message-State: AGi0PuaQLKcmMafD/8sR9RMhhVjQ8H+vwDZyp4IIRlyLze3qnD+3aNwd
        WrMOlJG9qxpH2T8BmiOMVe9Hp5SdELI=
X-Google-Smtp-Source: APiQypLWaYFgO0oHlu6TI1b4Jhtx4u5gzhm87cNbbO6fr6TFrMeTlsMiR8NwTy+6ffhrBOqPu3G/ow==
X-Received: by 2002:a17:902:e989:: with SMTP id f9mr14771476plb.321.1588876262475;
        Thu, 07 May 2020 11:31:02 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21e8::1239? ([2620:10d:c090:400::5:ddfe])
        by smtp.gmail.com with ESMTPSA id ft14sm448867pjb.46.2020.05.07.11.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 11:31:01 -0700 (PDT)
Subject: Re: [PATCH v6 0/5] Fix potential kernel panic when increase hardware
 queue
To:     tom.leiming@gmail.com, bvanassche@acm.org, hch@infradead.org,
        linux-block@vger.kernel.org
References: <cover.1588856361.git.zhangweiping@didiglobal.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <182e63ce-e64c-2312-e131-7a72aaec5f40@kernel.dk>
Date:   Thu, 7 May 2020 12:31:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1588856361.git.zhangweiping@didiglobal.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/7/20 7:03 AM, Weiping Zhang wrote:
> Hi,
> 
> This series mainly fix the kernel panic when increase hardware queue,
> and also fix some other misc issue.
> 
> Memleak 1:
> 
> __blk_mq_alloc_rq_maps
> 	__blk_mq_alloc_rq_map
> 
> if fail
> 	blk_mq_free_rq_map
> 
> Actually, __blk_mq_alloc_rq_map alloc both map and request, here
> also need free request.

Applied for 5.8, thanks.

-- 
Jens Axboe

