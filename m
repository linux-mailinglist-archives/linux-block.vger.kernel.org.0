Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6510264E77
	for <lists+linux-block@lfdr.de>; Thu, 10 Sep 2020 21:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgIJTPl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 10 Sep 2020 15:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731426AbgIJPyr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Sep 2020 11:54:47 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119E0C0617A0
        for <linux-block@vger.kernel.org>; Thu, 10 Sep 2020 08:54:35 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h11so6088476ilj.11
        for <linux-block@vger.kernel.org>; Thu, 10 Sep 2020 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OZHxSy9GxPtwL4FPXTEL4wHPxBFDa6n0iEKloHdc+dY=;
        b=dJRG8Qmps859QERXNYLJxi55QI15qf+NmhuQCnsZM3tzSEE4XDm6akhiZPmfFP2D5L
         noKfGQmOG//ogqGq6MHNPrBzfyTsSRYDDvmU4HpGKt2M3+VX34Rn11vzjMP7dWCeXtL7
         peTBqP2XxuoNfSrqxocG1z0zzHqFPkd4E6mCLjflVUpkyfeWBoxTosdtHT8O3weuXwoU
         tQ9lPzZrLFElRA5AiEu/B7dHsjPFnIljwQ7uqXHEHqGd8+4jBMrrg/VTkfD3IGCBJS5B
         tsG5z+xzaGHBSxD5B1GWK+wIELg2uX73o8AHY/LKWaXB7jjiscV+sTvRU/rMsZateAut
         mn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OZHxSy9GxPtwL4FPXTEL4wHPxBFDa6n0iEKloHdc+dY=;
        b=Tfdg7MriFsBvaI50Vstppy3uaKsU3calK6tpJYZe+4ilrJfBES8UQ2CawmTkZdQB+/
         ckGpdOwJy/ex0WHnT1CDksnHKOzDt3/ahzAPDNKVdjgmR/tCvNFRAlQHxdxCoVc0ZG4H
         quRZJL+Vx75ZfqxYe7E6y2j8wDddILxQfkr9Aqx5AWdD1X4UlrRq/kAGMSJxwUWlPN2j
         YfkWT78w2wAgez9/sC6oetjlS/o+Zhgw2m/d9wcDK8e7yTuDM7eA7EaD4pyB3f+5GeZH
         s8detTit+SHvoO+ZxNgkUhhAjNDTkWoGSP8WrB1rkVPJDlFJmQnakwrqmfmKGnEhvCnV
         xSfw==
X-Gm-Message-State: AOAM532CjVBfJOMbbzrKyvA91S/SU2C3KoQjLvVo+vqFgxgXS2zpZ8hj
        7FARIGvDUXA1SLnpDSk4XvjGlQ==
X-Google-Smtp-Source: ABdhPJxHvxNIiZ7YNxR9PEQ5wMasrzeeVlpwNZVmQsRSVIQZmYnp6kGKrBV3BTGdMbs3dPcZtBZnXQ==
X-Received: by 2002:a92:b309:: with SMTP id p9mr6758105ilh.125.1599753274952;
        Thu, 10 Sep 2020 08:54:34 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z15sm3315413ilb.73.2020.09.10.08.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 08:54:34 -0700 (PDT)
Subject: Re: rework check_disk_change() v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200908145347.2992670-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b5e51c24-b9a6-979f-8fe0-f762f113bba3@kernel.dk>
Date:   Thu, 10 Sep 2020 09:54:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908145347.2992670-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/8/20 8:53 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series replaced the not very nice check_disk_change() function with
> a new bdev_media_changed that avoids having the ->revalidate_disk call
> at its end.  As a result ->revalidate_disk can be removed from a lot of
> drivers.

Applied, thanks.

-- 
Jens Axboe

