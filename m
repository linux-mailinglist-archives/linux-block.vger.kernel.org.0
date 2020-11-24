Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3F62C2AC7
	for <lists+linux-block@lfdr.de>; Tue, 24 Nov 2020 16:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbgKXPEY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Nov 2020 10:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731164AbgKXPEX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 10:04:23 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A85BC0613D6;
        Tue, 24 Nov 2020 07:04:22 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so22658030wrx.5;
        Tue, 24 Nov 2020 07:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sy/v8vbr0389Zkg1PgKmJJV9z+FSnOz00Ua8W+up/RI=;
        b=VyMwavayGFGPsb3NN77FKVmFDEBqiGinc9OcQt+ZDinFdkQZzhWmGAQjvP1NFWkQ5h
         FV6wLEMgecUE4SeSU92BnE54V0RDvOSd39OKcdUBymHWzJLa4cjfExPULPpzDFPS54wS
         N/+IryOQ64RfzMzCOH4g/kQvVJzWdVa9qjcr0kI3t+okJu6iEkFIwuZ/Q6Fy36y7qnzM
         HSVPtZdM9Dz9LSyzI8YzHUyFVbtUMZITFZ3dAwSln5yBScM+P/ZvMncPBkqohNl6VT5/
         U4DUO7s2LhiLqNdN9eLNq8Hq5luyR8WZJ7pAGlzH91utUmrOxw+qTE1ZkWz9GjBEyTUw
         FaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Sy/v8vbr0389Zkg1PgKmJJV9z+FSnOz00Ua8W+up/RI=;
        b=m/l50/mMpVMZo+mLejbkm3R2Dwdfa/tyMFHc/YreEwmry/SeKPT7gWpEdJIFxM64ZQ
         DIAK1Q5C859nBvxLcM+E/KqCdJHKeWw65JQnsvWhO3SKMBmbdvOxMBM2bvk0n8QQMt1w
         VrTbSevj59oKXe++MPTOlTx7J7NH4NN1+88dFzxb6puWQDp5gWL1pbfGjcP1nCLUHJ0M
         cBmYJHk71tB/B1dsTNrUDDBeoYeWZAIecdqUJhieg/J4zfoHj9Els/FiBlQzWfnNoSup
         n/6vX8OkSzUvqtqFl638N1EjktV4kUqdt4Q2Mu81NPX0xfQpZTqk2dJH9wEvnvH3cqRO
         xVLw==
X-Gm-Message-State: AOAM5312VUYcLVZb8Uo0VaWpz4CiMVPJKIZg8voDZa9u0LYmcLxR/EQ/
        6eg8gj/Qu0rQkKHTNddGAzF94t5PJ7IqbuKJ
X-Google-Smtp-Source: ABdhPJzo4stX1Pr471g3hrk/K+eeUG1/SpdwziWJX1yVx1IxHebqKht0/bZNeA+3g6+QBgNNh5zFuA==
X-Received: by 2002:adf:f852:: with SMTP id d18mr5509351wrq.232.1606230260830;
        Tue, 24 Nov 2020 07:04:20 -0800 (PST)
Received: from [192.168.1.166] (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id n67sm6132840wmf.25.2020.11.24.07.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 07:04:20 -0800 (PST)
To:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org
References: <cover.1606058975.git.asml.silence@gmail.com>
 <ddfa166d93f38e812751b6ff986fd5403b7893b7.1606058975.git.asml.silence@gmail.com>
 <e71a58b5-1315-d655-4e1e-cd7529acfd6b@huawei.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v2 1/4] sbitmap: optimise sbitmap_deferred_clear()
Message-ID: <6d3413c3-7cc9-8c6d-50c6-183d135a2193@gmail.com>
Date:   Tue, 24 Nov 2020 15:01:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <e71a58b5-1315-d655-4e1e-cd7529acfd6b@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24/11/2020 14:11, John Garry wrote:
> On 22/11/2020 15:35, Pavel Begunkov wrote:
>> Because of spinlocks and atomics sbitmap_deferred_clear() have to reload
>> &sb->map[index] on each access even though the map address won't change.
>> Pass in sbitmap_word instead of {sb, index}, so it's cached in a
>> variable. It also improves code generation of
>> sbitmap_find_bit_in_index().
>>
>> Signed-off-by: Pavel Begunkov<asml.silence@gmail.com>
> 
> Looks ok, even though a bit odd not be passing a struct sbitmap * now

IMHO, narrower context is better, so looks more natural to me.

> Reviewed-by: John Garry <john.garry@huawei.com>

Thanks!

-- 
Pavel Begunkov
