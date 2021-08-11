Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8848E3E9437
	for <lists+linux-block@lfdr.de>; Wed, 11 Aug 2021 17:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhHKPGO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Aug 2021 11:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhHKPGO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 11:06:14 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFA7C0613D3
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 08:05:50 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u25so5013914oiv.5
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/UzD3VOUXNF9AIw3wsM9S8KXv2PiB7+V+48ULqwic2c=;
        b=Y5Z8rYJIyMV60XOAK995PQFJHYShVaHDOUcYuhW+CWxQLqqYskgx1bmf3PlFj1X/fJ
         Ffsjom75Onaie2GPcUirYkgrCZ2l7sIDAmtb64q/54ys7vjPxHkRDDqLOfzAXzWMQ+x3
         srmamzjEx/0yieq9Kwmhe/722WSUPo0XPlF3jmtwGXjOMV8B4vp4Cx5PhWanjNWYUSoH
         HEIhOX+c3p3X47A64IjcQa7XDR67TYhXOpdCuB1NVDG5WY2bi6Zp30uHWKOpeysosHyv
         Rr84UteZhzMgi59ax6kI69puVcT+mT5A8c0H/QknJw3uOLlbXBD5tF+cLr38CyXg0FG9
         zK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/UzD3VOUXNF9AIw3wsM9S8KXv2PiB7+V+48ULqwic2c=;
        b=A8PgsDQbL5GJrdN7QpE+ZhFXwN+etzX7JqLPo9d5lMMdIDbsEWRZyX+G6agQFbT0Xf
         rPcPBPkq/ftcT02UojWTPjiU5uEZtvs+4mbvI2vDz3mE1R49TS9kym9KmyRChfuVBYum
         59Q5ryzunvtcdqMJ2q5fBQV68DWlSgY6U4iq4+DwFoD/ZeN+lnIAD1THhfcFA4mRdWRP
         9fo4AeO0EsqW0dQyurSxOV1iUDuBn1UnSLiaDagPOowEzN0r/W9naLZuafjHtiyfdmni
         CEgQTCW8EKLro0kV/W0ZekZzYEIzJXTxJbwvVNEdf+7KpI0pOxQJev8sT/eHRKaM9Ap/
         qT6g==
X-Gm-Message-State: AOAM5334lw9qWD2+l+ES8nODMKLDOyI1zVk49hZZEfjmRjBZoTc9AZcM
        uO9amEfBzmswakqGJ4kcfX3WTD1MrCCXAcmS
X-Google-Smtp-Source: ABdhPJwBwwX777AS4mF69j1YnvRdmVtLeVSwIIwwmFvPgM4mokoNzF3Tod3wS2z6wuNSyroo8JTIPg==
X-Received: by 2002:aca:3c07:: with SMTP id j7mr1123622oia.8.1628694349326;
        Wed, 11 Aug 2021 08:05:49 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z23sm3438231oib.36.2021.08.11.08.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 08:05:48 -0700 (PDT)
Subject: Re: [PATCHSET v3 0/5] Enable bio recycling for polled IO
To:     Christoph Hellwig <hch@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
References: <20210810163728.265939-1-axboe@kernel.dk>
 <YROJuSsUX7y236BW@infradead.org> <YROw06H0z0Js8yg3@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c244becd-2d94-5b49-ed33-58e6456d91d9@kernel.dk>
Date:   Wed, 11 Aug 2021 09:05:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YROw06H0z0Js8yg3@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/11/21 5:13 AM, Christoph Hellwig wrote:
> On Wed, Aug 11, 2021 at 09:26:33AM +0100, Christoph Hellwig wrote:
>> I really don't like all the layering violations in here.  What is the
>> problem with a simple (optional) percpu cache in the bio_set?  Something
>> like the completely untested patch below:
> 
> A slightly updated version that actually compiles and survives minimal
> testing is here:
> 
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/bio-cache

I like this approach, I've done something very similar in the past. But
the key here is the opt-in, to avoid needing IRQ/locking for the cache
which defeats the purpose. That's why it was done just for polling,
obviously.

I'll test a bit and re-spin the series.

-- 
Jens Axboe

