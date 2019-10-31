Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E98E3EB0A5
	for <lists+linux-block@lfdr.de>; Thu, 31 Oct 2019 13:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfJaM5J (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 31 Oct 2019 08:57:09 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43720 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaM5J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Oct 2019 08:57:09 -0400
Received: by mail-il1-f195.google.com with SMTP id j2so3149481ilc.10
        for <linux-block@vger.kernel.org>; Thu, 31 Oct 2019 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HFMClpqTeJP46m822zm9nFLSwcrgj9uvV5/DrfBRnPs=;
        b=iEFkJ7oBRKTnH86pHzYP8n/pBPhjBfJYlldEsYn/rIGVWHnhgpxN9Caj2RqNP+Q9+v
         /SsATlGRTx/Px6pZJL43nAcCe89USwlXPU+5W45WA+Haw1O2APUVr1TBsFo1kfQThhnf
         m0nVawNTVYWxCd4jjbc12V1Vya3LiftKcRzhUzZmxoE/8g1BCcrGF4ZhGsg4Oie75lw9
         JZJal9dMagDpaZUgnKqUDvRkmYQQ0EgBIXmHD53leDI77do78FYlp5HAF5lGoqqcYmrC
         FZxsLPufmfOMu0dkVYHP7TBqJCWqlouul9OvP4+rvYTz9u+JrMVpskCCa2OztwL6Hm99
         FnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HFMClpqTeJP46m822zm9nFLSwcrgj9uvV5/DrfBRnPs=;
        b=jnRGYc+GC6QLl2EaHnnODXXmlX3O+QxOOgY/hGCgLo8ZHjxXOTEy1fUqmi3miR54J2
         dXCaKcN4rAjyM8xYhRjgZdkQu/NfkI1E2FbMjUPL5VbEzDW7FXd4UTd8mooi88pgasie
         vCBqTRScbBVkpeMqbpPuXv04EuSEfwCfcCE/m0GCRd1KXtUg5vwY9BtJBS57wCDu8BZq
         OviR8XNQbrNZfagRLlTggPJyez53xIT+RChOYKFJVvOqL5yEQ+KZxeUHYbD/KAzrYqJ0
         L+QjXPRH2UisSdfBzBWJeSmXHXaOXSclllLvRt6kvTKvyB5IuFi0dEICDonc1tD11jYO
         F0bw==
X-Gm-Message-State: APjAAAVTEH6KQRlA8X9nmUXdBsY3/LjcQcgH+ezmzIZORLWkBEWkPMrQ
        lD8ncGFnX89JSRG117a0w+2O7w==
X-Google-Smtp-Source: APXvYqy6YWgbIHTOYJsUJwrnjXnKqoqGCOzyA33ICwDU+p8YPyAoCA9Am/KjbwjsFlBj73v8w/Qhkw==
X-Received: by 2002:a92:8c1c:: with SMTP id o28mr5805925ild.34.1572526628820;
        Thu, 31 Oct 2019 05:57:08 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l64sm508754ilh.2.2019.10.31.05.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 05:57:07 -0700 (PDT)
Subject: Re: [PATCH] io_uring: signedness bug in io_async_cancel()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20191031105547.GC26612@mwanda>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a697c16b-92bb-52a3-e2e8-5f24d75f580d@kernel.dk>
Date:   Thu, 31 Oct 2019 06:57:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031105547.GC26612@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/31/19 4:55 AM, Dan Carpenter wrote:
> The problem is that this enum is unsigned, and we do use "ret" for the
> enum values, but we also use it for negative error codes.  If it's not
> signed then it causes a problem in the error handling.

I noticed this one the other day, merged in a fix for it then. Not
an issue in the current tree, though linux-next may still have the
older one.

-- 
Jens Axboe

