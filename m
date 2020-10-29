Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E8B29EEE4
	for <lists+linux-block@lfdr.de>; Thu, 29 Oct 2020 15:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgJ2O4M (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 29 Oct 2020 10:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgJ2O4M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 10:56:12 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B71C0613CF
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2020 07:56:10 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h21so3728072iob.10
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2020 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WemFOLkmAPUKdN+nqIRjrISM2gmjf14uknKMRvbpklA=;
        b=PrP7myG0Dwdwebo/VH1PXBno7L9+AmvkVybmk1tFIYIEcRDB4rvH2sOOosEL9q8Ba7
         TgYcuIUhW5ifo+QEXvk26qC79StPuRZI+nrciCFnZeZn3LLwZ3gqTpOLAPHvy1aIbMqY
         ENTBKI0Af8OqE3ngNwU5gLd5eg3wUwHxl7wte7AXyolf6n88HTBbWLTlETGRFkySeH20
         wZ2bCwlY1u4kQdMNseMY2Ke7QIjhDYqSBfZbfYMQVVpY0ALqNJRZt18gSUfIjJfzLTjh
         IL1Eh/azheanuworlqNT9JWYygE3KsIu5EfGcU7W1Gh9fDl3R7wb0OEWIrxjYSRHVabK
         1gGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WemFOLkmAPUKdN+nqIRjrISM2gmjf14uknKMRvbpklA=;
        b=irxbZKMGMy+IY+yanzJAdKlG4rtVBcqVQAAyJoDJPB2YqkUMjy/dKv+0oHmG8j5t2T
         6tGxEdX33vp2cZ/THzBhCF2pomULmSFzq8sW1ykVEfhayR9J9K0ECtuNnpk42RRVi1o6
         17D7yHE+4/JgU0l+tw0LmBBXvi8kfOxf3gk3LtbWU9XqPRRJ1QbAW5COStR8RM0mZ9wI
         Ryp1sZzKCHgBw50+jDFDbhnLAUBftG1mr8m84uec+8ZjmVAkceQsMKEEa2dmCVyJWWxt
         3IBdmPJIPv+l0KkF1wbOPX2Zt0Mb4t9/lIjxMmt38a5nUxegKdqeygNShDwj0nlezNjE
         sddw==
X-Gm-Message-State: AOAM530R1ztEbUcBgt9L9C8C37MEs0BGznlkXnyTcx2Y05ZBiWJ5/G0R
        +F3lfbhxluFfgMraAzJvBSCzGg==
X-Google-Smtp-Source: ABdhPJzQRYNRWquLB9rp+ou2a2B6vqz6XFMl8yS/R3QE9y5FegtniEWCzxpMi/P2m8k2orcyneu33w==
X-Received: by 2002:a6b:ef15:: with SMTP id k21mr3824082ioh.37.1603983370092;
        Thu, 29 Oct 2020 07:56:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x13sm2168849iob.8.2020.10.29.07.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 07:56:09 -0700 (PDT)
Subject: Re: [PATCH] lib/scatterlist: use consistent sg_copy_buffer() return
 type
To:     David Disseldorp <ddiss@suse.de>, linux-block@vger.kernel.org
Cc:     Douglas Gilbert <dgilbert@interlog.com>
References: <20201026210310.30169-1-ddiss@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e6db4d34-711a-fd8c-6acc-986436340af5@kernel.dk>
Date:   Thu, 29 Oct 2020 08:56:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026210310.30169-1-ddiss@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/26/20 3:03 PM, David Disseldorp wrote:
> sg_copy_buffer() returns a size_t with the number of bytes copied.
> Return 0 instead of false if the copy is skipped.

I've picked this up, thanks.

-- 
Jens Axboe

