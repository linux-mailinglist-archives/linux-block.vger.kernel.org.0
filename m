Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C6C3E0408
	for <lists+linux-block@lfdr.de>; Wed,  4 Aug 2021 17:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbhHDPUr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Aug 2021 11:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbhHDPUr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 11:20:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E58BC0613D5
        for <linux-block@vger.kernel.org>; Wed,  4 Aug 2021 08:20:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ca5so3447434pjb.5
        for <linux-block@vger.kernel.org>; Wed, 04 Aug 2021 08:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/RWLUsd9wW8sGCnVRrE5+sg3Qkd9Ol+XAfTVsr7LwnM=;
        b=NFgN5IYn2Vc2ekeEfbf/QnKdOoeA2LaMG+2BgycMseD12qrmsvzmW5VsirBjhvvuPD
         7cTQawCcs21Yf/aN56UZqtNxDQnmxjYeDF4O2mFHzAH2373A3GXqT7JmwfbW0hABt3f5
         owE0w3uzPePiPS2T6TsXfO0CYn86OZRZPFx1Kwp9uIaPxq++AYCR6jOKXaVWHjdTNV5F
         pve0Iq7lPREWZKKZFP2UzcBtDGCzTG7d382Q1qJYPnM4JSokCaF6z5Awf7h2lKVFxs5b
         6ccpD8wijq2xzBfIFo6okAPHHt6rJwojBU/Siq7OMD3p89lwMJamA1itND56RNHEnLe0
         6Shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/RWLUsd9wW8sGCnVRrE5+sg3Qkd9Ol+XAfTVsr7LwnM=;
        b=V3/gh8Hc2bXYIaLD/70ThlEXyhnbzE3LRyuFPC5hpGBphqsffB0c4Ic/MOLM7PuOJe
         0yYV8hQ79nAscmN8E/JCbmYWqxZoXBcgU6YEpz7ScdOCi3cGQXzTAbvfkSFYxImphL+j
         Uv+92lGFopA4UZvAzAfsl+Ru+DCWIeAvBSZZPT/yE32ro9hDYLqNDBMxbejzSE5jepCV
         tZ3BTHMwMLpdsgA8e1ez7QsIcbcQgJFDYbUI8Hp8i0+EzSy0w4dzCcEvHho9AvQ1nzfA
         2FiH3ItktbFIKN4B18eauk83z5bedH9HWNSrz5152fcG+4yyMgU7VkYPqycZnOk02itF
         wS/w==
X-Gm-Message-State: AOAM533AL5sdIowvXH6tVkB8FTFQNJNsqCFmYZ//+SApHNnj0zmdrrkz
        SAVSf+KwwDckgwDK1QdCVpMZEQ==
X-Google-Smtp-Source: ABdhPJwcJ4hyPPfP/k1nPZ8Ia9IBQZKBD+/Q3mVg49T0J0X3RI7CrJDA3HiekN9ahr4gmeK0oNQ8zA==
X-Received: by 2002:a17:90a:a389:: with SMTP id x9mr10106227pjp.167.1628090433951;
        Wed, 04 Aug 2021 08:20:33 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id 198sm3304580pfu.32.2021.08.04.08.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 08:20:33 -0700 (PDT)
Subject: Re: [PATCH 0/1] s390/dasd: fix use after free
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20210804151800.4031761-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c6a0a7a3-9c8d-4114-6408-bded5f75071d@kernel.dk>
Date:   Wed, 4 Aug 2021 09:20:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804151800.4031761-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/4/21 9:17 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please apply the following patch that fixes an use after free error in
> the DASD driver.
> 
> Stefan Haberland (1):
>   s390/dasd: fix use after free in dasd path handling
> 
>  drivers/s390/block/dasd_eckd.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Jens Axboe

