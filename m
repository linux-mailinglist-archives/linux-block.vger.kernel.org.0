Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA648316A8B
	for <lists+linux-block@lfdr.de>; Wed, 10 Feb 2021 16:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhBJP5A (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 10 Feb 2021 10:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhBJP47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 10:56:59 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD289C061574
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 07:56:18 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id d85so2091562qkg.5
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 07:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WJrPc40c+DHT1+Gb1xeUmwrG0pKHWNH3yQxd2xtCK8M=;
        b=cRjkdnxEuSk+fKCTpDoKWDNN+/sf80UvA1Z2MDKXGUHXz28rm2laXv43GuId/wawCx
         LVa9x17Qyy1g6/q6h8ocMmn8DGFB/NGdJt6uUZnAepydn/ZFNQQN3O9LMa56RbCAv+e+
         dKR8fedr+SNMchL0+cUIonB81msurXgwinDFI3916n/H0d6N2dto3Ua5/Pq3rX/l9+zm
         iyyST5Wmw5lHYfwJM8aqc6WxRTXHu1nEPE9yUnl5+dRhpgtylsilioX1e4W8rRx5S3xO
         C4MmD3V9D3F/ogJ+y1XJgBgVNJQj/sNWIxS1nFRzYM96W5bff1EG9Iqp2/QsnS5hvEeY
         Fq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WJrPc40c+DHT1+Gb1xeUmwrG0pKHWNH3yQxd2xtCK8M=;
        b=KdALabzQ5VFy58OMp3xRwGP52r2rPI4IhAY8AkSRUPpcUiqoZ+yO5Rog0P4f/2fEEc
         8BWTjREstB6Xw3s3Z8O0AFxx0nL5wlZ7TcFrQjwiCmAo35fLxWonqikyCxVFWeStTIuZ
         5gB87B6ohDArieYWsp+HptD+jYXKPaWvdInT0hECBDJcz4ujp26XVIWvtwkrGbY1uYRx
         zKGWKrB05akwwYn4biMOclLZdp/K1rdvnPRrPULYLVfQMVWwUVo1Ff+/WTLsHFa5ASxW
         i9aBQ0CEh55HuBZr6h7Yzc1Vg6jdNun0LxKJY1Opt5ODMeK+463RdaqPsai4Tn0uhcC0
         ZNww==
X-Gm-Message-State: AOAM533zpKQn4TwMMaqANzPR/Fk8AeB7fnk65RjZmR59/fpz1JiTJfxI
        CtMBpuHY54cf5rVVDd50HtaqjaZcRJTWyDJj
X-Google-Smtp-Source: ABdhPJwqLfnej9NV46Nv57GVPs/3uYC7wdpgJJUxUqsOCUK5RycE7UKiM5g5ymbyseJiosrxh6V6ug==
X-Received: by 2002:a37:6592:: with SMTP id z140mr3949912qkb.319.1612972578074;
        Wed, 10 Feb 2021 07:56:18 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t4sm1480081qto.62.2021.02.10.07.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 07:56:17 -0800 (PST)
Subject: Re: [PATCH] nbd: Convert to DEFINE_SHOW_ATTRIBUTE
To:     winndows@163.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <1612595455-4050-1-git-send-email-winndows@163.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3f6f04a5-b2e1-2f02-bb42-7466605e4dcb@toxicpanda.com>
Date:   Wed, 10 Feb 2021 10:56:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1612595455-4050-1-git-send-email-winndows@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/6/21 2:10 AM, winndows@163.com wrote:
> From: Liao Pingfang <winndows@163.com>
> 
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Liao Pingfang <winndows@163.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
