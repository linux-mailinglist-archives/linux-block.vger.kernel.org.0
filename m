Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0DB2F0BDE
	for <lists+linux-block@lfdr.de>; Mon, 11 Jan 2021 05:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbhAKEnU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 10 Jan 2021 23:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbhAKEnT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 23:43:19 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A258C061794
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 20:42:39 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y23so13773426wmi.1
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 20:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jvUs4D1It5HUJiN9desNsRbL2weIz3yRevXzkPRQirc=;
        b=PgUojlmeQk0eD3MUEvzllxpNDpOl1dop6U85329fY/rRDN1CgsG29hXqgC9tMYI8+B
         6FiHzJvFKUBKLWa/QJdewbdLa2O3A4eDiI0/01dD84DqE6pJIytG3WOsZDQAHcKR+gRh
         +WVwtJ6spKBaBEs05DYdEoGP7C6Pr7SdQNXY/T3vzRWsVPFX9vrM6SdEJFQXU9CSB8kT
         /IVgpwpc09clIXdnBzUL1Io3DDKzH/ADDW2zNKTXsFXha+RSg8A7wQhf+/uo6Lr1kTM/
         tp/AWqWwqwWaIgT2baexEfUVcxi5YuGZTW6eHTMYslfLuvL1Uz/HOy2iUxr96MZiT0bD
         bdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jvUs4D1It5HUJiN9desNsRbL2weIz3yRevXzkPRQirc=;
        b=KsxXnDoRf00M1e5ErkE2X+04kpnetEAgEXgMHXkTU8C2BRsbbmHf8/oaj3QJ5bQWVK
         i2kxXC3xZ28R9tjMQKVqQinlIrquw3V/O3OCNxmnYUD6QXHVWf7V4DqF76Yw7yW1S/Rv
         aOAiOEEwqsUyC1XHXwoe99w8AFtX2fAN7l2bIKmLkv1WvGiQ5wxadoD5hLCPrdmtb7vj
         2pEcbynRrg5Kx/hR7igBcM2CWxGrx0rVLyQ4GC5owURLLlyImK+oQZRMDUtcZLxPL72U
         BBfzof/qCM8oLpdd62xlQfMH82MpyMpuiuZwZBC3ZaRKh0uNEENIK6y7KMQP6o1qwUzD
         kJUg==
X-Gm-Message-State: AOAM530GHeUKgYGyZxYupc00c7EgBA6JpOnac30VjLCsXZsccAYjCExh
        KbsxFc7Lh06FLE1981zgISmggij4XLE=
X-Google-Smtp-Source: ABdhPJzl3u7AXsCYd22iRnSmn+fIavCF0ZT55I+llDrCZDYvEC/MPwpo/O8vqj8f/kvNtSjVQYWwGw==
X-Received: by 2002:a1c:6208:: with SMTP id w8mr12949497wmb.96.1610340157948;
        Sun, 10 Jan 2021 20:42:37 -0800 (PST)
Received: from [192.168.8.119] ([85.255.237.6])
        by smtp.gmail.com with ESMTPSA id y11sm20046936wmi.0.2021.01.10.20.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jan 2021 20:42:37 -0800 (PST)
Subject: Re: [PATCH V3 1/6] block: manage bio slab cache by xarray
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210111030557.4154161-1-ming.lei@redhat.com>
 <20210111030557.4154161-2-ming.lei@redhat.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <531f35df-97df-3a3d-b4c6-820b4f66fa37@gmail.com>
Date:   Mon, 11 Jan 2021 04:39:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20210111030557.4154161-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/01/2021 03:05, Ming Lei wrote:
> Managing bio slab cache via xarray by using slab cache size as xarray
> index, and storing 'struct bio_slab' instance into xarray.
> 
> So code is simplified a lot, meantime it becomes more readable than before.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Tested-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov
