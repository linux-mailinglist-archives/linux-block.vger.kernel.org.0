Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C774394AC7
	for <lists+linux-block@lfdr.de>; Sat, 29 May 2021 08:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhE2Gid (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 29 May 2021 02:38:33 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:33763 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhE2Gic (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 May 2021 02:38:32 -0400
Received: by mail-lj1-f182.google.com with SMTP id o8so8049234ljp.0;
        Fri, 28 May 2021 23:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tA8bN2YzNQKfw1BCEp767KuRQbdDjks5njClJ7GzgoE=;
        b=L53Entvy7d+f4S5YKcEc2PyN4tx8sfimPUSBWSN1VZHLUkB+ZdhIduWAkXciCOndIN
         Vi8ijLQhY5dI0ztDjISaGD0KbCP/SvA01Tc840JYFymItsC09AnYxBj+zcf2loC0b0QP
         gphd734sgkrhMt1VOh8C4viAFsc5ad63rgFAxJzJyQzDrqDJzBwXdI76ondK9wScwKj6
         rtlZxbpwIKYzqngK5PEwilghgW7k5elSXkgw0JGIQskpKoJeeE4ww82RWe0keMb+p8PZ
         5FKNWGkWy8BfchL4P/KrQFjpMaV8aweO0W8gMQr0HJjdyjqD6fJFRZXo16X8VoYta+0t
         MX+A==
X-Gm-Message-State: AOAM531cdFBE3QybSP7344GynCOtFAfonoAnqltT+3fAYavHlwGHE13p
        HsK++px4hVOdqEtUzkGErWOresIHArg=
X-Google-Smtp-Source: ABdhPJy2msKRIPpG5RG0X2hDv0JePHQpL7qN4mDo6L5U8y7eTL2BiOPqM7vB/5cfs+7FOT5olRjfUw==
X-Received: by 2002:a2e:a54d:: with SMTP id e13mr9026970ljn.266.1622270214132;
        Fri, 28 May 2021 23:36:54 -0700 (PDT)
Received: from [10.68.32.147] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id z132sm652646lfa.66.2021.05.28.23.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 23:36:53 -0700 (PDT)
Subject: Re: [PATCH v2][next] floppy: Fix fall-through warning for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210528200335.GA39252@embeddedor>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <07887f9c-c33d-9398-4939-2f23ebb1d094@linux.com>
Date:   Sat, 29 May 2021 09:37:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210528200335.GA39252@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 5/28/21 11:03 PM, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Link: https://lore.kernel.org/linux-hardening/47bcd36a-6524-348b-e802-0691d1b3c429@kernel.dk/
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied, thanks!
https://github.com/evdenis/linux-floppy/commit/6eaddb2a2aa3acd0660537f9f6a12785be0ae830

I will send it to Jens with other floppy patches.
It will be in 5.14

Regards,
Denis

> ---
> Changes in v2:
>   - Add a break statement instead of fallthrough;
> 
>   drivers/block/floppy.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 8a9d22207c59..803af2a72520 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -2123,6 +2123,7 @@ static void format_interrupt(void)
>   	switch (interpret_errors()) {
>   	case 1:
>   		cont->error();
> +		break;
>   	case 2:
>   		break;
>   	case 0:
> 
